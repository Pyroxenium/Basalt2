-- Headless smoke test for Basalt3. Writes its result to /basalt3_test_result.txt
-- and shuts the computer down so a scripted CraftOS-PC run terminates.
local results = {}
local function report(line)
    results[#results + 1] = line
end

local ok, err = pcall(function()
    -- load without require so this also works via craftos --script
    local basalt = assert(loadfile("/Basalt3/init.lua", nil, _ENV))("Basalt3", "Basalt3/init.lua")

    -- loading main.lua directly (require("main") style) must bootstrap too
    local direct = assert(loadfile("/Basalt3/src/main.lua", nil, _ENV))("main", "Basalt3/src/main.lua")
    assert(type(direct) == "table" and type(direct.run) == "function",
        "direct main.lua load did not return basalt")
    report("direct main load ok")

    -- frame + custom colors
    local frame = basalt.createFrame()
    frame:setBackground(basalt.rgb("#1e1e2e"))
    assert(frame.width > 0 and frame.height > 0, "frame has no size")
    report("createFrame ok " .. frame.width .. "x" .. frame.height)

    local c1 = basalt.rgb("#89b4fa")
    local c2 = basalt.rgb(0x89b4fa)
    assert(c1 == c2, "rgb dedupe failed")
    report("rgb dedupe ok")

    -- color parsing: ARGB alpha ignored, #RGB shorthand, invalid input errors
    assert(basalt.rgb("FF4E158F") == basalt.rgb("#4E158F"), "ARGB parse failed")
    assert(basalt.rgb("abc") == basalt.rgb("#aabbcc"), "#RGB shorthand failed")
    assert(not pcall(basalt.rgb, "#12345"), "5-digit hex must error")
    assert(not pcall(basalt.rgb, "grün"), "non-hex string must error")
    assert(not pcall(basalt.rgb, -5), "negative color number must error")
    report("rgb parsing ok")

    -- label: autosize + property styles
    local label = frame:addLabel({ x = 2, y = 2, text = "Hello" })
    assert(label.width == 5, "label autosize expected 5, got " .. label.width)
    label.text = "Hello World"
    assert(label.width == 11, "label autosize after change: " .. label.width)
    label:setWidth(4)
    label.text = "xxxxxxxx"
    assert(label.width == 4, "manual width must disable autosize")
    report("label autosize ok")

    -- chaining + plain properties are the same thing
    local btn = frame:addButton({ x = 2, y = 6, text = "Click me" })
    btn:setText("Klick"):setX(2)
    assert(btn.text == "Klick" and btn.x == 2, "chained setters failed")
    btn.text = "Click me"
    assert(btn:getText() == "Click me", "plain property set failed")
    report("property/chaining ok")

    -- combined properties: pure facades over existing properties, preserving
    -- fluent setters, effective getters, false values and authored layout specs
    local combined = frame:addButton({ text = "Combined" })
    assert(combined:setPosition(4, 5):setSize(12, 3) == combined,
        "combined setters must remain fluent")
    local cx, cy = combined:getPosition()
    local cw, ch = combined:getSize()
    assert(cx == 4 and cy == 5 and cw == 12 and ch == 3,
        "position/size combined getters failed")
    combined:setBounds(6, 7, 14, 2)
    local bx, by, bw, bh = combined:getBounds()
    assert(bx == 6 and by == 7 and bw == 14 and bh == 2,
        "bounds combined property failed")
    combined:setColors(colors.red, false)
    local cfg, cbg = combined:getColors()
    assert(cfg == colors.red and cbg == false,
        "combined getter must preserve false values")
    combined:setMinSize(3, 2):setMaxSize(20, 8)
    local minW, minH = combined:getMinSize()
    local maxW, maxH = combined:getMaxSize()
    assert(minW == 3 and minH == 2 and maxW == 20 and maxH == 8,
        "combined min/max size failed")
    combined:setSize(basalt.fill(), basalt.auto())
    local rawW, rawH = combined:getRawSize()
    assert(type(rawW) == "table" and type(rawH) == "table",
        "raw combined getter must preserve layout tokens")
    assert(not pcall(combined.setPosition, combined, 1),
        "combined setter arity must be validated")
    combined:destroy()
    report("combined properties ok")

    -- named states: API, priorities, non-destructive property overrides
    local stateChanges = 0
    btn:onStateChange(function(_, name, active)
        if name == "loading" and active then stateChanges = stateChanges + 1 end
    end)
    btn:setStateStyle("hover", { background = colors.lightGray })
    btn:setStateStyle("pressed", { background = colors.blue })
    btn:setStateStyle("loading", { text = "Loading" }, 50)
    local baseBackground, baseText = btn.background, btn.text
    btn:setState("hover", true)
    assert(btn.background == colors.lightGray, "hover state style failed")
    btn:setState("pressed", true)
    assert(btn.background == colors.blue, "pressed priority failed")
    btn:setState("loading", true)
    assert(btn.text == "Loading" and stateChanges == 1, "custom state failed")
    btn:setState("loading", true)
    assert(stateChanges == 1, "state changes must be idempotent")
    btn:setState("loading", false)
    assert(btn.text == baseText, "state must preserve stored property")
    btn:setState("pressed", false)
    btn:setState("hover", false)
    assert(btn.background == baseBackground, "state fallback failed")
    assert(not pcall(btn.setStateStyle, btn, "bad", { disabled = false }),
        "behavior property must not be state-styleable")
    report("state system ok")

    -- application state: direct properties, mapped/computed dependencies,
    -- subscriptions and dirty propagation
    local count = basalt.state(1)
    local prefix = basalt.state("Count")
    local stateLabel = frame:addLabel({
        x = 25, y = 2, width = 20,
        text = basalt.computed(function()
            return prefix:get() .. ": " .. count:get()
        end),
    })
    assert(stateLabel.text == "Count: 1", "computed initial value failed")
    basalt.update()
    assert(not rawget(frame, "_dirty"), "draw must clear dirty before state test")
    count:set(2)
    assert(rawget(frame, "_dirty"), "signal write must dirty dependent tree")
    assert(stateLabel.text == "Count: 2", "computed signal update failed")
    prefix:set("Total")
    assert(stateLabel.text == "Total: 2", "computed second dependency failed")

    local mapped = count:map(function(v) return v * 10 end)
    local mappedLabel = frame:addLabel({ x = 25, y = 3, width = 6, text = mapped })
    assert(mappedLabel.text == 20, "mapped signal failed")
    count:update(function(v) return v + 1 end)
    assert(mappedLabel.text == 30, "signal update/map failed")

    local observedNew, observedOld
    local unsubscribe = count:subscribe(function(new, old)
        observedNew, observedOld = new, old
    end)
    count:set(4)
    assert(observedNew == 4 and observedOld == 3, "signal subscription failed")
    unsubscribe()
    count:set(5)
    assert(observedNew == 4, "signal unsubscribe failed")

    local tableState = basalt.state({ value = 1 })
    local touchCount = 0
    tableState:subscribe(function() touchCount = touchCount + 1 end)
    tableState:get().value = 2
    tableState:touch()
    assert(touchCount == 1, "table signal touch failed")
    assert(basalt.isState(count) and basalt.isState(mapped), "isState failed")

    local stale = basalt.state("bound")
    local rebound = frame:addLabel({ x = 25, y = 4, width = 8, text = stale })
    basalt.update()
    rebound.text = "fixed"
    basalt.update()
    assert(not rawget(frame, "_dirty"), "rebind setup must finish clean")
    stale:set("obsolete")
    assert(not rawget(frame, "_dirty"),
        "replaced signal must not retain stale UI dependency")

    local inputValue = basalt.state("A")
    local boundInput = frame:addInput({ x = 25, y = 5, width = 8 })
    boundInput:bind("text", inputValue)
    assert(boundInput.text == "A", "input binding initial value failed")
    boundInput:handleKey("char", "B")
    assert(inputValue:get() == "BA" and boundInput.text == "BA",
        "input two-way binding failed")
    assert(basalt.isState(boundInput:raw("text")),
        "control update must restore reactive property")
    inputValue:set("External")
    assert(boundInput.text == "External", "external binding update failed")
    boundInput:unbind("text")
    inputValue:set("Detached")
    assert(boundInput.text == "External", "unbind must retain current value")

    local formatted = frame:addLabel({ x = 25, y = 6, width = 12 })
    formatted:bind("text", count, function(v) return "Value=" .. v end)
    assert(formatted.text == "Value=5", "transformed binding failed")
    report("application state ok")

    -- click routing (button occupies x 2-11, y 6-8)
    local clicks = 0
    btn:onClick(function() clicks = clicks + 1 end)
    basalt.update() -- initial draw
    basalt.update("mouse_click", 1, 3, 7)
    assert(btn:hasState("hover"), "click must update hover state")
    assert(btn:hasState("pressed"), "click must activate pressed state")
    assert(btn:hasState("focused"), "click must focus the button")
    basalt.update("mouse_up", 1, 3, 7)
    assert(not btn:hasState("pressed"), "mouse_up must clear pressed state")
    assert(clicks == 1, "expected 1 click, got " .. clicks)
    btn.disabled = true
    assert(btn:hasState("disabled"), "disabled property must mirror state")
    assert(not btn:hasState("focused") and not btn:hasState("pressed"),
        "disabled element must release focus and press")
    basalt.update("mouse_click", 1, 3, 7)
    basalt.update("mouse_up", 1, 3, 7)
    assert(clicks == 1, "disabled button must ignore clicks")
    btn.disabled = false
    assert(not btn:hasState("disabled"), "disabled state must clear")
    -- CraftOS-PC variants may include a leading source/button value.
    basalt.update("mouse_move", 0, 30, 10)
    assert(not btn:hasState("hover"), "mouse_move must clear hover state")
    basalt.update("mouse_move", 0, 3, 7)
    assert(btn:hasState("hover"), "3-argument mouse_move must set hover")
    basalt.update("mouse_move", 30, 10)
    assert(not btn:hasState("hover"), "2-argument mouse_move must clear hover")
    basalt.update("mouse_click", 1, 1, 1) -- miss
    basalt.update("mouse_up", 1, 1, 1)
    assert(clicks == 1, "click outside button must not fire")
    report("mouse routing ok")

    -- hiding/removing an interactive subtree releases transient states
    local transient = frame:addInput({ x = 30, y = 4, width = 5 })
    basalt.update("mouse_click", 1, 31, 4)
    assert(transient:hasState("focused") and transient:hasState("pressed"),
        "transient input setup failed")
    transient.visible = false
    assert(not transient:hasState("focused") and not transient:hasState("pressed")
        and not transient:hasState("hover"), "hidden element retained state")
    transient.visible = true
    basalt.update("mouse_click", 1, 31, 4)
    transient:destroy()
    assert(not transient:hasState("focused") and not transient:hasState("pressed")
        and not transient:hasState("hover"), "destroyed element retained state")
    report("state lifecycle ok")

    -- reactive update: changing an already-rendered element must dirty the
    -- root again (regression: markDirty early-exit) and land in the buffer
    basalt.update()
    label.text = "42"
    assert(rawget(frame, "_dirty"), "text change must dirty the root")
    basalt.update()
    assert(frame._render.text[2]:find("42", 1, true), "buffer missing new text")
    label.text = "43"
    assert(rawget(frame, "_dirty"), "second change must dirty the root again")
    basalt.update()
    assert(frame._render.text[2]:find("43", 1, true), "buffer missing 2nd text")
    label.text = "42"
    basalt.update()
    report("redraw ok")

    -- nested frame with clipping
    local sub = frame:addFrame({ x = 5, y = 3, width = 10, height = 4 })
    sub:addLabel({ x = 8, y = 2, text = "clipped-text-far-too-long" })
    basalt.update()
    report("nested frame + clipping ok")

    -- dynamic values: functions as property values, evaluated on read
    local dynFrame = frame:addFrame({ x = 20, y = 14, width = 10, height = 3 })
    local dynLabel = dynFrame:addLabel({
        text = "dyn",
        x = function(s) return s.parent.width - 2 end,
        foreground = function() return colors.red end,
    })
    assert(dynLabel.x == 8, "dynamic x expected 8, got " .. tostring(dynLabel.x))
    assert(dynLabel.foreground == colors.red, "dynamic foreground failed")
    dynFrame.width = 15 -- dynamic value follows immediately, no observers
    assert(dynLabel.x == 13, "dynamic x after resize: " .. tostring(dynLabel.x))
    assert(type(dynLabel:raw("x")) == "function", "raw() must return the fn")
    assert(dynLabel:getX() == 13, "getter must evaluate dynamic value")
    dynLabel:setWidth(function(s) return s.parent.width - 4 end)
    dynLabel.text = "longer text" -- autosize must not clobber dynamic width
    assert(dynLabel.width == 11, "dynamic width: " .. tostring(dynLabel.width))
    basalt.update()
    dynLabel.x = 2 -- plain value replaces the dynamic one
    assert(dynLabel.x == 2, "static override failed")
    report("dynamic values ok")

    -- reactive expressions: "{...}" strings compile to dynamic values
    local rframe = frame:addFrame({ x = 40, y = 14, width = 10, height = 3 })
    local rlbl = rframe:addLabel({ text = "abc", name = "rl" })
    rlbl.x = "{parent.width - 2}"
    assert(rlbl.x == 8, "reactive x expected 8, got " .. tostring(rlbl.x))
    rframe.width = 12
    assert(rlbl.x == 10, "reactive x after resize: " .. tostring(rlbl.x))
    rlbl.width = "{#self.text + 2}"
    assert(rlbl.width == 5, "reactive width: " .. tostring(rlbl.width))
    rlbl:setY("{clamp(parent.height * 5, 1, 2)}")
    assert(rlbl.y == 2, "reactive helper fn: " .. tostring(rlbl.y))
    local rlbl2 = rframe:addLabel({ text = "q", x = "{rl.x + 1}" })
    assert(rlbl2.x == 11, "reactive by-name ref: " .. tostring(rlbl2.x))
    assert(not pcall(function() rlbl.y = "{this is not lua}" end),
        "invalid expression must error")
    report("reactive expressions ok")

    -- Input: focus by click, editing, cursor, scrolling
    local input = frame:addInput({ x = 30, y = 2, width = 8 })
    local entered
    input:onEnter(function(_, t) entered = t end)
    basalt.update()
    basalt.update("mouse_click", 1, 31, 2)
    basalt.update("mouse_up", 1, 31, 2)
    assert(frame:getFocused() == input, "input not focused after click")
    for ch in ("hello"):gmatch(".") do basalt.update("char", ch) end
    assert(input.text == "hello", "typing failed: " .. input.text)
    basalt.update("key", keys.backspace)
    assert(input.text == "hell", "backspace failed: " .. input.text)
    basalt.update("key", keys.left)
    basalt.update("key", keys.left)
    basalt.update("char", "X")
    assert(input.text == "heXll", "cursor insert failed: " .. input.text)
    basalt.update("key", keys.enter)
    assert(entered == "heXll", "enter event failed")
    input.text = "{5 + 5}" -- rawString: user text must never compile
    assert(input.text == "{5 + 5}", "input text was compiled as reactive")
    report("input editing ok")

    -- cursor: long text scrolls, terminal cursor sits at the right cell
    input.text = ""
    for ch in ("abcdefghijklmno"):gmatch(".") do basalt.update("char", ch) end
    assert(input._scroll == 8, "scroll expected 8, got " .. input._scroll)
    local r = frame._render
    assert(r.cursorBlink == true, "cursor should blink while focused")
    assert(r.cursorX == 37 and r.cursorY == 2,
        "cursor at " .. r.cursorX .. "," .. r.cursorY .. ", expected 37,2")
    basalt.update("mouse_click", 1, 1, 1) -- click empty root: blur input
    basalt.update("mouse_up", 1, 1, 1)
    assert(r.cursorBlink == false, "cursor must hide on blur")
    report("cursor ok")

    -- monitor frame: touch events arrive as click+up
    local stub = {
        getSize = function() return 20, 10 end,
        setCursorPos = function() end,
        setCursorBlink = function() end,
        setTextColor = function() end,
        setBackgroundColor = function() end,
        clear = function() end,
        blit = function() end,
    }
    local mon = basalt.createFrame(stub, "left")
    local mclicks = 0
    mon:addButton({ x = 2, y = 2, text = "M" }):onClick(function()
        mclicks = mclicks + 1
    end)
    basalt.update()
    basalt.update("monitor_touch", "left", 3, 3)
    assert(mclicks == 1, "monitor touch routing failed")
    basalt.update("monitor_touch", "right", 3, 3) -- other monitor: ignored
    assert(mclicks == 1, "touch on wrong monitor must not fire")
    report("monitor touch ok")

    -- error handler: structured parsing, user-frame detection, wrapping
    local em = basalt.errors
    local info = em.parse(
        "Basalt3/src/core/render.lua:99: unknown color 123",
        "stack traceback:\n"
        .. "\tBasalt3/src/core/render.lua:99: in function 'blit'\n"
        .. "\tBasalt3/src/core/element.lua:120: in function 'render'\n"
        .. "\tstartup.lua:42: in function <startup.lua:40>\n"
        .. "\t[C]: in function 'xpcall'"
    )
    assert(info.message == "unknown color 123", "msg: " .. info.message)
    assert(info.file == "Basalt3/src/core/render.lua" and info.line == 99,
        "error site parse failed")
    assert(info.userFile == "startup.lua" and info.userLine == 42,
        "user frame detection failed: " .. tostring(info.userFile))
    assert(#info.trace == 3, "xpcall frame must be filtered")
    local plain = em.parse("just a message without site")
    assert(plain.message == "just a message without site", "plain msg failed")
    local wrapped = em.wrap("boom", "stack traceback:")
    assert(wrapped.__basaltError and tostring(wrapped) == "boom",
        "wrap/tostring failed")
    -- render the error screen itself: queue the "any key" up front so
    -- show() returns immediately in headless mode
    os.queueEvent("key", keys.enter)
    em.show("Basalt3/src/core/render.lua:99: unknown color value 123",
        "stack traceback:\n"
        .. "\tBasalt3/src/core/render.lua:99: in function 'blit'\n"
        .. "\tstartup.lua:1: in main chunk")
    report("error handler ok")

    -- xml module: markup -> element tree, attribute conversion, scope events
    local xmlMod = basalt.use("xml")
    local xmlClicked = false
    local built = xmlMod.load(frame, [[
        <!-- demo ui -->
        <frame x="35" y="16" width="14" height="3" name="xf">
            <label x="2" y="1" name="xlbl" text="XML!"/>
            <label x="8" y="1" name="xrl" text="{parent.width}"/>
            <button x="2" y="2" width="5" height="1" text="Go" onClick="go"/>
            <label x="9" y="2" name="xtxt">TXT</label>
        </frame>
    ]], { go = function() xmlClicked = true end })
    assert(#built == 1 and built[1].__name == "Frame", "xml root build failed")
    assert(frame:find("xlbl").text == "XML!", "xml attr conversion failed")
    assert(frame:find("xrl").text == 14, "xml reactive attr failed")
    assert(frame:find("xtxt").text == "TXT", "xml text content failed")
    basalt.update()
    basalt.update("mouse_click", 1, 36, 17)
    basalt.update("mouse_up", 1, 36, 17)
    assert(xmlClicked, "xml onClick scope binding failed")
    assert(not pcall(xmlMod.parse, "<a><b></a>"), "mismatched tags must error")
    report("xml module ok")

    -- animation module: tween runs on real timers via basalt.schedule
    local anim = basalt.use("animation")
    local animDone = false
    anim.to(label, { x = 8 }, 0.25, "linear", function() animDone = true end)
    local deadline = os.clock() + 5
    while not animDone and os.clock() < deadline do
        basalt.update(os.pullEvent())
    end
    assert(animDone, "animation did not finish")
    assert(label.x == 8, "animation target: " .. tostring(label.x))
    local handle = label:animate({ x = 2 }, 5) -- Element sugar
    handle.cancel()
    report("animation module ok")

    -- theme module: class defaults + retroactive subtree styling
    local theme = basalt.use("theme")
    local themeBlue = basalt.rgb("#0000aa")
    theme.set({ Button = { background = themeBlue } })
    assert(btn.background == themeBlue, "theme.set must restyle live")
    local btn2 = frame:addButton({ x = 44, y = 10, width = 5, height = 1 })
    assert(btn2.background == themeBlue, "new button must inherit theme")
    btn2.background = colors.red
    assert(btn2.background == colors.red, "explicit override must win")
    theme.set({ Button = { states = {
        hover = { background = colors.yellow },
        disabled = { foreground = colors.lightGray },
    } } })
    btn2:setState("hover", true)
    assert(btn2.background == colors.yellow,
        "theme state style must override base property")
    btn2:setState("hover", false)
    assert(btn2.background == colors.red,
        "theme state style must restore explicit property")
    theme.set({ Button = { background = colors.gray } }) -- restore
    theme.apply(rframe, { Label = {
        foreground = colors.yellow,
        states = { alert = { foreground = colors.red } },
    } })
    assert(rlbl.foreground == colors.yellow, "theme.apply failed")
    rlbl:setState("alert", true)
    assert(rlbl.foreground == colors.red, "theme.apply state style failed")
    rlbl:setState("alert", false)
    assert(not pcall(theme.set, { Button = { background = "{self.x}" } }),
        "reactive string in set() must error")
    assert(not pcall(theme.set, { Nope = {} }), "unknown type must error")
    report("theme module ok")

    -- debug module: overlay, logging, toggle key
    local dbg = basalt.use("debug")
    assert(type(basalt.debug) == "function", "basalt.debug missing")
    basalt.debug("Hello", 42)
    local ov = dbg.getOverlay()
    assert(ov.visible == false, "overlay must start hidden")
    basalt.update("key", keys.f12)
    assert(ov.visible == true, "F12 must show overlay")
    local foundLine = false
    for _, c in ipairs(ov:getChildren()) do
        if c.text == "Hello 42" then foundLine = true end
    end
    assert(foundLine, "log line not shown in overlay")
    basalt.update()
    basalt.update("key", keys.f12)
    assert(ov.visible == false, "F12 must hide overlay again")
    report("debug module ok")

    -- standard elements on an isolated stub frame (events fed directly)
    local stub2 = {
        getSize = function() return 30, 15 end,
        setCursorPos = function() end,
        setCursorBlink = function() end,
        setTextColor = function() end,
        setBackgroundColor = function() end,
        clear = function() end,
        blit = function() end,
    }
    local f2 = basalt.createFrame(stub2)

    -- Checkbox: dynamic auto-width, toggle + change event
    local cbChanged
    local cb = f2:addCheckbox({ x = 2, y = 2, text = "Ok" })
    local cbState = basalt.state(false)
    cb:bind("checked", cbState)
    cb:onChange(function(_, v) cbChanged = v end)
    assert(cb.width == 6, "checkbox auto width: " .. cb.width)
    assert(cb.checked == false and cbState:get() == false,
        "checkbox binding initial value failed: checked=" .. tostring(cb.checked)
        .. " (" .. type(cb.checked) .. "), state=" .. tostring(cbState:get())
        .. " (" .. type(cbState:get()) .. ")")
    f2:handleEvent("mouse_click", 1, 3, 2)
    f2:handleEvent("mouse_up", 1, 3, 2)
    assert(cb.checked == true and cbChanged == true,
        "checkbox toggle failed: checked=" .. tostring(cb.checked)
        .. ", event=" .. tostring(cbChanged)
        .. ", state=" .. tostring(cbState:get()))
    assert(cbState:get() == true and basalt.isState(cb:raw("checked")),
        "checkbox two-way binding failed")
    assert(cb:hasState("checked"), "checkbox must mirror checked state")

    -- Switch: toggle
    local sw = f2:addSwitch({ x = 2, y = 4 })
    f2:handleEvent("mouse_click", 1, 3, 4)
    f2:handleEvent("mouse_up", 1, 3, 4)
    assert(sw.checked == true, "switch toggle failed")
    assert(sw:hasState("checked"), "switch must mirror checked state")

    -- ProgressBar: clamping
    local pb = f2:addProgressBar({ x = 2, y = 6, width = 10 })
    pb.progress = 150
    assert(pb.progress == 100, "progress clamp high failed")
    pb.progress = -5
    assert(pb.progress == 0, "progress clamp low failed")

    -- Slider: click sets value, drag clamps to max
    local sl = f2:addSlider({ x = 2, y = 8, width = 11 })
    local sliderState = basalt.state(0)
    sl:bind("value", sliderState)
    local slValue
    sl:onChange(function(_, v) slValue = v end)
    f2:handleEvent("mouse_click", 1, 7, 8) -- local x=6 -> 50%
    assert(sl.value == 50 and slValue == 50,
        "slider click value: " .. tostring(sl.value))
    assert(sliderState:get() == 50, "slider two-way binding failed")
    f2:handleEvent("mouse_drag", 1, 29, 8) -- beyond the end -> clamps
    f2:handleEvent("mouse_up", 1, 29, 8)
    assert(sl.value == 100, "slider drag clamp: " .. tostring(sl.value))

    -- List: selection, scrolling, select event
    local li = f2:addList({ x = 14, y = 2, width = 10, height = 4 })
    local listState = basalt.state(false)
    li:bind("selected", listState)
    for _, v in ipairs({ "A", "B", "C", "D", "E", "F" }) do li:addItem(v) end
    local selIdx, selItem
    li:onSelect(function(_, i, item) selIdx, selItem = i, item end)
    f2:handleEvent("mouse_click", 1, 15, 3) -- row 2 -> "B"
    f2:handleEvent("mouse_up", 1, 15, 3)
    assert(selIdx == 2 and tostring(selItem) == "B" and li.selected == 2,
        "list select failed")
    assert(listState:get() == 2, "list two-way binding failed")
    assert(li:hasState("selected"), "list must mirror selected state")
    f2:handleEvent("mouse_scroll", 1, 15, 3) -- offset 1
    assert(li.offset == 1, "list scroll failed: " .. li.offset)
    f2:handleEvent("mouse_click", 1, 15, 3) -- row 2 + offset -> "C"
    f2:handleEvent("mouse_up", 1, 15, 3)
    assert(tostring(selItem) == "C", "list select with offset failed")
    li:removeItem(1)
    assert(li.selected == 2 and tostring(li.items[2]) == "C", "list removeItem failed")

    -- List: internal scrollbar + keyboard navigation + thumb drag
    local keyList = f2:addList({ x = 22, y = 6, width = 8, height = 3 })
    for i = 1, 8 do keyList:addItem("L" .. i) end
    assert(keyList:getScrollInfo().show
        and keyList:getScrollInfo().maximum == 5, "list scrollbar missing")
    keyList:focus()
    keyList:handleKey("key", keys.down)
    assert(keyList.selected == 1, "list keyboard initial selection failed")
    keyList:handleKey("key", keys["end"])
    assert(keyList.selected == 8 and keyList.offset == 5,
        "list End/ensure-visible failed")
    keyList:setOffset(0)
    f2:draw()
    f2:handleEvent("mouse_click", 1, 29, 6) -- grab scrollbar thumb
    f2:handleEvent("mouse_drag", 1, 29, 8)
    f2:handleEvent("mouse_up", 1, 29, 8)
    assert(keyList.offset == 5, "list scrollbar drag failed: " .. keyList.offset)

    -- Dropdown: open/close, item select, close on blur
    local dd = f2:addDropdown({ x = 2, y = 10, width = 10, dropHeight = 3 })
    for _, value in ipairs({ "Eins", "Zwei", "Drei", "Vier",
        "Fuenf", "Sechs", "Sieben", "Acht" }) do
        dd:addItem(value)
    end
    assert(dd.height == 1, "dropdown must start closed")
    f2:handleEvent("mouse_click", 1, 3, 10) -- toggle open
    f2:handleEvent("mouse_up", 1, 3, 10)
    assert(dd.open == true and dd.height == 4, "dropdown open failed")
    local ddIdx
    dd:onSelect(function(_, i) ddIdx = i end)
    f2:handleEvent("mouse_click", 1, 3, 12) -- local y=3 -> item 2
    f2:handleEvent("mouse_up", 1, 3, 12)
    assert(ddIdx == 2 and dd.selected == 2 and dd.open == false,
        "dropdown select failed")
    assert(dd:hasState("selected"), "dropdown must mirror selected state")
    f2:handleEvent("mouse_click", 1, 3, 10) -- reopen
    f2:handleEvent("mouse_up", 1, 3, 10)
    assert(dd.open == true, "dropdown reopen failed")
    assert(dd:getScrollInfo().show and dd:getScrollInfo().maximum == 5,
        "dropdown scrollbar missing")
    f2:handleEvent("mouse_scroll", 1, 3, 11)
    assert(dd.offset == 1, "dropdown wheel scrolling failed")
    f2:handleEvent("key", keys["end"])
    assert(dd.offset == 5 and dd.open, "dropdown End/ensure-visible failed")
    f2:handleEvent("key", keys.enter)
    assert(dd.selected == 8 and ddIdx == 8 and not dd.open,
        "dropdown keyboard selection failed")
    f2:handleEvent("mouse_click", 1, 3, 10) -- reopen for Escape
    f2:handleEvent("mouse_up", 1, 3, 10)
    f2:handleEvent("key", keys.escape)
    assert(not dd.open, "dropdown Escape must close")
    f2:handleEvent("mouse_click", 1, 3, 10) -- reopen for blur
    f2:handleEvent("mouse_up", 1, 3, 10)
    f2:handleEvent("mouse_click", 1, 25, 14) -- click elsewhere -> blur
    f2:handleEvent("mouse_up", 1, 25, 14)
    assert(dd.open == false, "dropdown must close on blur")

    basalt.update() -- render everything once (smoke)
    report("standard elements ok")

    -- responsive layout: free tokens, row/column flow, constraints, resize
    -- and mouse hit-testing against resolved geometry
    local layoutW, layoutH = 40, 15
    local layoutTerm = {
        getSize = function() return layoutW, layoutH end,
        setCursorPos = function() end,
        setCursorBlink = function() end,
        setTextColor = function() end,
        setBackgroundColor = function() end,
        clear = function() end,
        blit = function() end,
    }
    local lf = basalt.createFrame(layoutTerm)
    local row = lf:addRow({
        x = 1, y = 1,
        width = basalt.fill(), height = 5,
        padding = 1, gap = 1, align = "center",
    })
    local left = row:addLabel({ text = "A", width = basalt.auto(), height = basalt.auto() })
    local middleClicks = 0
    local middle = row:addButton({ text = "Grow", width = basalt.fill(), height = basalt.auto() })
        :onClick(function() middleClicks = middleClicks + 1 end)
    local right = row:addLabel({
        text = "Right", width = basalt.percent(0.25), height = basalt.auto(),
        maxWidth = 6,
    })
    row:addLabel({ position = "absolute", x = 35, y = 1, text = "ABS" })

    local column = lf:addColumn({
        x = 1, y = 7,
        width = basalt.percent(0.5), height = basalt.fill(),
        padding = 1, gap = 1,
    })
    local top = column:addLabel({ text = "Top", width = basalt.auto(), height = basalt.auto() })
    local growing = column:addInput({ width = basalt.fill(), height = basalt.fill() })

    lf:draw()
    assert(row.width == 40 and row.height == 5, "free fill row size failed")
    assert(left.x == 2 and left.width == 1 and left.y == 3,
        "row auto/align failed: " .. left.x .. "," .. left.y .. "," .. left.width)
    assert(right.width == 6, "layout maxWidth constraint failed: " .. right.width)
    assert(middle.width == 29 and middle.x == 4 and right.x == 34,
        "row fill distribution failed: " .. middle.x .. "/" .. middle.width
        .. "/" .. right.x)
    assert(column.width == 20 and column.height == 9,
        "free percent/fill column size failed")
    assert(top.x == 2 and top.y == 2 and growing.x == 2 and growing.y == 4,
        "column placement failed")
    assert(growing.width == 18 and growing.height == 5,
        "column fill failed: " .. growing.width .. "x" .. growing.height)

    lf:handleEvent("mouse_click", 1, middle.x + 1, middle.y + 1)
    lf:handleEvent("mouse_up", 1, middle.x + 1, middle.y + 1)
    assert(middleClicks == 1, "layout hit-testing failed")

    layoutW = 50
    lf:handleEvent("term_resize")
    lf:draw()
    assert(row.width == 50 and middle.width == 39,
        "responsive resize failed: " .. row.width .. "/" .. middle.width)

    -- shrink: intrinsic/layout-token children yield before fixed children,
    -- while minimum constraints remain intact
    local shrinkRow = lf:addRow({ x = 1, y = 1, width = 10, height = 3, gap = 1 })
    local shrinkable = shrinkRow:addLabel({
        text = "12345678", width = basalt.auto(), minWidth = 3,
    })
    local fixed = shrinkRow:addButton({ text = "F", width = 5, height = 3 })
    lf:draw()
    assert(shrinkable.width == 4 and fixed.width == 5,
        "layout shrink failed: " .. shrinkable.width .. "/" .. fixed.width)

    -- nested auto measurement travels inside-out before placement
    local outer = lf:addColumn({
        x = 1, y = 7, width = basalt.auto(), height = basalt.auto(),
        padding = 1,
    })
    local inner = outer:addRow({
        width = basalt.auto(), height = basalt.auto(), gap = 1,
    })
    inner:addLabel({ text = "Hi", width = basalt.auto(), height = basalt.auto() })
    inner:addButton({ text = "Go", width = basalt.auto(), height = basalt.auto() })
    lf:draw()
    assert(outer.width == 9 and outer.height == 5,
        "nested auto outer measure failed: " .. outer.width .. "x" .. outer.height)
    assert(inner.width == 7 and inner.height == 3 and inner.x == 2 and inner.y == 2,
        "nested auto inner measure failed")

    -- layout tokens supplied by a state style remain tokens during layout
    local stateRow = lf:addRow({ x = 1, y = 1, width = 20, height = 3, gap = 1 })
    local stateSized = stateRow:addButton({ text = "State", width = 5, height = 3 })
    stateRow:addButton({ text = "Fixed", width = 5, height = 3 })
    stateSized:setStateStyle("expanded", { width = basalt.fill() })
    stateSized:setState("expanded", true)
    lf:draw()
    assert(stateSized.width == 14, "state layout token failed: " .. stateSized.width)

    -- optional responsive module: temporary direction overrides + named states
    local responsive = basalt.use("responsive")
    local panel = lf:addFlex({
        x = 1, y = 1, width = basalt.fill(), height = 6,
        direction = "row", gap = 1,
    })
    local rp1 = panel:addButton({ text = "One", width = 6, height = 2 })
    local rp2 = panel:addButton({ text = "Two", width = 6, height = 2 })
    responsive.apply(panel, {
        { name = "compact", maxWidth = 30, props = { direction = "column" } },
        { name = "wide", minWidth = 31, props = { direction = "row" } },
    })
    layoutW = 50
    lf:handleEvent("term_resize")
    lf:draw()
    assert(panel:hasState("wide") and not panel:hasState("compact")
        and rp2.x > rp1.x and rp2.y == rp1.y, "wide breakpoint failed")
    layoutW = 25
    lf:handleEvent("term_resize")
    lf:draw()
    assert(panel:hasState("compact") and not panel:hasState("wide")
        and rp2.y > rp1.y and rp2.x == rp1.x, "compact breakpoint failed")
    panel:clearResponsive()
    lf:draw()
    assert(panel.direction == "row" and not panel:hasState("compact"),
        "responsive cleanup must restore authored properties")
    report("responsive layout ok")

    -- scrollable containers: auto bars, wheel, hit-testing through offsets,
    -- thumb dragging, hidden bars, horizontal fallback and disabling
    local scrollTerm = {
        getSize = function() return 20, 8 end,
        setCursorPos = function() end,
        setCursorBlink = function() end,
        setTextColor = function() end,
        setBackgroundColor = function() end,
        clear = function() end,
        blit = function() end,
    }
    local sf = basalt.createFrame(scrollTerm)
    local sc = sf:addColumn({
        x = 1, y = 1, width = 10, height = 4,
        scrollable = true, scrollbar = "auto",
        scrollXEnabled = false, scrollYEnabled = true,
        scrollStep = 3,
    })
    local scrollItems, clickedItem = {}, nil
    for i = 1, 8 do
        local itemIndex = i
        scrollItems[i] = sc:addButton({
            text = "Item " .. i, width = basalt.fill(), height = 1,
        }):onClick(function() clickedItem = itemIndex end)
    end
    sf:draw()
    local scrollInfo = sc:getScrollInfo()
    assert(scrollInfo.showY and not scrollInfo.showX and scrollInfo.maxY == 4,
        "automatic vertical scrollbar failed")
    local cw, ch = sc:getContentSize()
    assert(cw == 10 and ch == 8, "scroll content measurement failed")

    sf:handleEvent("mouse_scroll", 1, 2, 2)
    local sx, sy = sc:getScroll()
    assert(sx == 0 and sy == 3, "mouse wheel scroll failed: " .. sx .. "/" .. sy)
    sf:handleEvent("mouse_click", 1, 2, 1) -- offset 3 => Item 4
    sf:handleEvent("mouse_up", 1, 2, 1)
    assert(clickedItem == 4, "scrolled hit-testing failed: " .. tostring(clickedItem))

    sc:scrollTo(0, 0)
    sf:draw()
    sf:handleEvent("mouse_click", 1, 10, 1) -- grab vertical thumb
    sf:handleEvent("mouse_drag", 1, 10, 3)
    sf:handleEvent("mouse_up", 1, 10, 3)
    _, sy = sc:getScroll()
    assert(sy == 4, "scrollbar thumb drag failed: " .. sy)

    sc:scrollTo(0, 0):ensureVisible(scrollItems[8])
    _, sy = sc:getScroll()
    assert(sy == 4, "ensureVisible failed: " .. sy)
    sc.scrollbar = "hidden"
    sf:draw()
    assert(not sc:getScrollInfo().showY, "hidden scrollbar must not render")
    sc:scrollTo(0, 0)
    sf:handleEvent("mouse_scroll", 1, 2, 2)
    assert(select(2, sc:getScroll()) == 3,
        "hidden scrollbar must keep wheel scrolling")

    -- a focused input scrolled outside its ancestor viewport must hide cursor
    local scrollInput = sc:addInput({ width = basalt.fill(), height = 1, text = "cursor" })
    sf:draw()
    sc:scrollTo(0, 5)
    sf:handleEvent("mouse_click", 1, 2, 4)
    sf:handleEvent("mouse_up", 1, 2, 4)
    sf:draw()
    assert(sf._render.cursorBlink == true, "visible scrolled input cursor missing")
    sc:scrollTo(0, 0)
    sf:draw()
    assert(sf._render.cursorBlink == false,
        "off-viewport scrolled input cursor must be hidden")

    local horizontal = sf:addRow({
        x = 12, y = 1, width = 6, height = 2,
        scrollable = true, scrollbar = "auto",
        scrollXEnabled = true, scrollYEnabled = false,
    })
    horizontal:addButton({ text = "A", width = 5, height = 1 })
    horizontal:addButton({ text = "B", width = 5, height = 1 })
    sf:draw()
    assert(horizontal:getScrollInfo().showX, "horizontal scrollbar failed")
    sf:handleEvent("mouse_scroll", 1, 13, 1)
    assert(select(1, horizontal:getScroll()) == 3,
        "horizontal wheel fallback failed")

    sc.scrollable = false
    sf:draw()
    sx, sy = sc:getScroll()
    assert(sx == 0 and sy == 0 and not sc:getScrollInfo().showY,
        "disabling scroll must reset state")
    sf:handleEvent("mouse_scroll", 1, 2, 2)
    assert(select(2, sc:getScroll()) == 0,
        "disabled container must ignore wheel")
    report("container scrolling ok")

    -- remaining elements: TextBox, Menu, TabControl, Tree, Table
    local stub3 = {
        getSize = function() return 40, 18 end,
        setCursorPos = function() end,
        setCursorBlink = function() end,
        setTextColor = function() end,
        setBackgroundColor = function() end,
        clear = function() end,
        blit = function() end,
    }
    local f3 = basalt.createFrame(stub3)

    -- TextBox: editing, line merge/split, external assignment, view scroll
    local tb = f3:addTextBox({ x = 1, y = 1, width = 10, height = 3 })
    local tbChanges = 0
    tb:onChange(function() tbChanges = tbChanges + 1 end)
    f3:handleEvent("mouse_click", 1, 1, 1)
    f3:handleEvent("mouse_up", 1, 1, 1)
    f3:handleEvent("char", "a")
    f3:handleEvent("char", "b")
    f3:handleEvent("key", keys.enter)
    f3:handleEvent("char", "c")
    assert(tb.text == "ab\nc", "textbox editing: " .. tb.text:gsub("\n", "|"))
    assert(tbChanges == 4, "textbox change events: " .. tbChanges)
    f3:handleEvent("key", keys.backspace)
    f3:handleEvent("key", keys.backspace) -- merges the lines again
    assert(tb.text == "ab", "textbox merge: " .. tb.text:gsub("\n", "|"))
    tb.text = "1\n2\n3\n4\n5"
    assert(#tb._lines == 5, "textbox external assignment failed")
    for _ = 1, 6 do f3:handleEvent("key", keys.down) end
    f3:draw()
    assert(tb._viewY == 2, "textbox must scroll to cursor: " .. tb._viewY)
    assert(f3._render.cursorBlink == true, "textbox cursor missing")

    -- Menu: spans, click select, keyboard, dynamic auto width
    local menu = f3:addMenu({ x = 1, y = 5 })
    menu:addItem("File"):addItem("Edit")
    assert(menu.width == 13, "menu auto width: " .. menu.width)
    local menuIdx
    menu:onSelect(function(_, i) menuIdx = i end)
    f3:handleEvent("mouse_click", 1, 9, 5) -- inside " Edit "
    f3:handleEvent("mouse_up", 1, 9, 5)
    assert(menuIdx == 2 and menu.selected == 2, "menu click select failed")
    f3:handleEvent("key", keys.left)
    assert(menu.selected == 1, "menu keyboard nav failed")

    -- TabControl: tabs, header switch, content routing to the active tab
    local tc = f3:addTabControl({ x = 15, y = 5, width = 20, height = 6 })
    local tabOne = tc:addTab("One")
    local tabTwo = tc:addTab("Two")
    tabOne:addLabel({ x = 1, y = 1, text = "T1", name = "t1lbl" })
    tabTwo:addLabel({ x = 1, y = 1, text = "T2", name = "t2lbl" })
    f3:draw()
    assert(tc.active == 1 and tabOne.visible and not tabTwo.visible,
        "first tab must be active")
    assert(tabOne.width == 20 and tabOne.height == 5, "tab sizing failed")
    local switched
    tc:onChange(function(_, i, title) switched = title end)
    f3:handleEvent("mouse_click", 1, 21, 5) -- header " Two " (local x 7)
    f3:handleEvent("mouse_up", 1, 21, 5)
    assert(tc.active == 2 and switched == "Two", "tab switch failed")
    assert(tabTwo.visible and not tabOne.visible, "tab visibility failed")
    f3:draw()
    assert(f3:findAt(15, 6) == f3:find("t2lbl"),
        "content routing must hit the active tab")

    -- Tree: expand/collapse, selection, keyboard navigation
    local tree = f3:addTree({ x = 1, y = 8, width = 12, height = 4 })
    tree.nodes = {
        { text = "root", children = {
            { text = "child1" }, { text = "child2" } } },
        { text = "other" },
    }
    local treeSel
    tree:onSelect(function(_, node) treeSel = node end)
    assert(tree.nodes[1].expanded == true,
        "tree must expand first root like Basalt2")
    f3:handleEvent("mouse_click", 1, 1, 8) -- marker cell -> collapse
    f3:handleEvent("mouse_up", 1, 1, 8)
    assert(tree.nodes[1].expanded == false, "tree collapse failed")
    f3:handleEvent("mouse_click", 1, 1, 8) -- expand again
    f3:handleEvent("mouse_up", 1, 1, 8)
    assert(tree.nodes[1].expanded == true, "tree expand failed")
    f3:handleEvent("mouse_click", 1, 5, 9) -- row 2 -> child1
    f3:handleEvent("mouse_up", 1, 5, 9)
    assert(treeSel and treeSel.text == "child1" and tree.selected == treeSel,
        "tree select failed")
    f3:handleEvent("key", keys.down)
    assert(tree.selected.text == "child2", "tree key down failed")
    f3:handleEvent("key", keys.left) -- leaf -> jump to parent
    assert(tree.selected.text == "root", "tree key left (parent) failed")
    f3:handleEvent("key", keys.left) -- expanded parent -> collapse
    assert(tree.nodes[1].expanded == false, "tree key left (collapse) failed")

    -- Table: selection by data index, header sorting without mutating data
    local tbl = f3:addTable({ x = 14, y = 12, width = 24, height = 5 })
    tbl.columns = { { title = "Name", width = 8 }, { title = "Qty" } }
    tbl.data = { { "Banane", 3 }, { "Apfel", 12 }, { "Citrone", 1 } }
    local rowSel
    tbl:onSelect(function(_, _, row) rowSel = row end)
    f3:handleEvent("mouse_click", 1, 15, 14) -- display row 2 -> Apfel
    f3:handleEvent("mouse_up", 1, 15, 14)
    assert(rowSel and rowSel[1] == "Apfel" and tbl.selected == 2,
        "table row select failed")
    f3:handleEvent("mouse_click", 1, 24, 12) -- header col 2 -> sort by Qty
    f3:handleEvent("mouse_up", 1, 24, 12)
    f3:handleEvent("mouse_click", 1, 15, 13) -- display row 1 -> Citrone
    f3:handleEvent("mouse_up", 1, 15, 13)
    assert(rowSel and rowSel[1] == "Citrone",
        "table sort failed: " .. tostring(rowSel and rowSel[1]))
    assert(tbl.selected == 3, "selected must stay a data index")
    assert(tbl.data[1][1] == "Banane", "sorting must not mutate data")
    f3:handleEvent("key", keys.down) -- next in sorted view -> Banane
    assert(tbl.selected == 1, "table keyboard nav must follow view order")

    f3:draw() -- render everything once (smoke)
    report("remaining elements ok")

    -- Program element: embedded CC program with event forwarding
    local pf = fs.open("/b3_prog_test.lua", "w")
    pf.write([[
term.setCursorPos(1, 1)
term.write("HELLO W" .. select(1, term.getSize()))
local total = 0
while true do
    local e, a = os.pullEvent()
    if e == "test_ev" then
        total = total + a
        term.setCursorPos(1, 2)
        term.write("N" .. total)
    elseif e == "mouse_click" then
        term.setCursorPos(1, 3)
        term.write("M" .. a)
    elseif e == "quit_ev" then
        return "bye"
    end
end
]])
    pf.close()

    local prog = frame:addProgram({ x = 40, y = 5, width = 10, height = 4 })
    local progDone, progResult
    prog:onDone(function(_, ok, res) progDone, progResult = ok, res end)
    prog:execute("/b3_prog_test.lua")
    assert(prog.running == true, "program must be running")
    basalt.update()
    assert(frame._render.text[5]:find("HELLO W10", 1, true),
        "program output not rendered (window size wrong?)")
    basalt.update("test_ev", 2) -- forwarded by the event pump
    basalt.update("test_ev", 3)
    assert(frame._render.text[6]:find("N5", 1, true),
        "custom events not forwarded to program")
    basalt.update("mouse_click", 1, 41, 7) -- element-local (2, 3)
    basalt.update("mouse_up", 1, 41, 7)
    assert(frame._render.text[7]:find("M1", 1, true),
        "mouse events not forwarded to program")
    basalt.update("quit_ev")
    assert(progDone == true and progResult == "bye", "done event failed")
    assert(prog.running == false, "running must reset after exit")

    -- crashing program: onError keeps the app alive
    local ef = fs.open("/b3_prog_err.lua", "w")
    ef.write('os.pullEvent("boom_ev") error("kaputt", 0)')
    ef.close()
    local caught
    local prog2 = frame:addProgram({
        x = 40, y = 5, width = 10, height = 4,
        onError = function(_, e) caught = e end,
    })
    prog2:execute("/b3_prog_err.lua")
    basalt.update("boom_ev")
    assert(caught == "kaputt", "error event failed: " .. tostring(caught))
    assert(prog2.running == false, "crashed program must stop")

    prog:destroy()
    prog2:destroy()
    fs.delete("/b3_prog_test.lua")
    fs.delete("/b3_prog_err.lua")
    report("program element ok")

    -- two programs at once: independent events, mouse isolation, crash
    -- isolation (one dying must not affect the other)
    local function writeProg(path, tag, crashEvent)
        local h = fs.open(path, "w")
        h.write(([[
term.setCursorPos(1, 1)
term.write("P%s")
while true do
    local e, a = os.pullEvent()
    if e == "tick_ev" then
        term.setCursorPos(1, 2)
        term.write("%s" .. a)
    elseif e == "mouse_click" then
        term.setCursorPos(1, 3)
        term.write("M%s")
    elseif e == "%s" then
        error("crash %s", 0)
    end
end
]]):format(tag, tag, tag, crashEvent, tag))
        h.close()
    end
    writeProg("/b3_multi_a.lua", "A", "crash_a_ev")
    writeProg("/b3_multi_b.lua", "B", "crash_b_ev")

    local progA = frame:addProgram({ x = 40, y = 5, width = 8, height = 4 })
    local caughtB
    local progB = frame:addProgram({
        x = 28, y = 5, width = 8, height = 4,
        onError = function(_, e) caughtB = e end,
    })
    progA:execute("/b3_multi_a.lua")
    progB:execute("/b3_multi_b.lua")
    basalt.update("tick_ev", 7)
    local row6 = frame._render.text[6]
    assert(row6:sub(40, 47):find("A7", 1, true), "program A missed tick_ev")
    assert(row6:sub(28, 35):find("B7", 1, true), "program B missed tick_ev")

    basalt.update("mouse_click", 1, 29, 7) -- inside B only
    basalt.update("mouse_up", 1, 29, 7)
    local row7 = frame._render.text[7]
    assert(row7:sub(28, 35):find("MB", 1, true), "program B missed its click")
    assert(not row7:sub(40, 47):find("MA", 1, true),
        "program A must not see B's click")

    basalt.update("crash_b_ev")
    assert(caughtB == "crash B" and progB.running == false,
        "program B crash not isolated: " .. tostring(caughtB))
    assert(progA.running == true, "program A must survive B's crash")
    basalt.update("tick_ev", 9)
    assert(frame._render.text[6]:sub(40, 47):find("A9", 1, true),
        "program A must stay responsive after B's crash")

    progA:destroy()
    progB:destroy()
    fs.delete("/b3_multi_a.lua")
    fs.delete("/b3_multi_b.lua")
    report("multiple programs ok")

    -- Basalt2 parity fixes: paste routing, replaceChar, symbols, wheel
    input.text = ""
    basalt.update("mouse_click", 1, 31, 2) -- focus the input again
    basalt.update("mouse_up", 1, 31, 2)
    local pasted
    input:onPaste(function(_, t) pasted = t end)
    basalt.update("paste", "geheim")
    assert(input.text == "geheim", "paste into input failed: " .. input.text)
    assert(pasted == "geheim", "onPaste event failed")
    input.replaceChar = "*"
    basalt.update()
    local inputRow = frame._render.text[2]:sub(30, 37)
    assert(inputRow:find("%*%*%*%*%*%*") and not inputRow:find("geheim"),
        "replaceChar must mask the text: '" .. inputRow .. "'")
    input.replaceChar = false

    f3:handleEvent("mouse_click", 1, 2, 2) -- focus the textbox (line 2)
    f3:handleEvent("mouse_up", 1, 2, 2)
    tb.text = "x"
    f3:handleEvent("key", keys["end"])
    f3:handleEvent("paste", "YZ")
    assert(tb.text == "xYZ", "paste into textbox failed: " .. tb.text)

    cb.checkedSymbol = "o"
    f2:draw()
    assert(f2._render.text[2]:sub(2, 9):find("[o] Ok", 1, true),
        "custom checkbox symbol not rendered")
    -- Slider: wheel adjusts by step (value is 100 after the drag test)
    f2:handleEvent("mouse_scroll", -1, 3, 8)
    assert(sl.value == 99, "slider wheel failed: " .. sl.value)
    f2:handleEvent("mouse_scroll", 1, 3, 8)
    assert(sl.value == 100, "slider wheel up failed: " .. sl.value)
    report("basalt2 parity fixes ok")

    -- ============ Basalt2 parity extensions ============
    local function makeStub(w, h)
        return {
            getSize = function() return w, h end,
            setCursorPos = function() end,
            setCursorBlink = function() end,
            setTextColor = function() end,
            setBackgroundColor = function() end,
            clear = function() end,
            blit = function() end,
        }
    end
    local f4 = basalt.createFrame(makeStub(40, 18))

    -- Label: manual width wraps, height auto-grows
    local wl = f4:addLabel({ x = 1, y = 1, text = "one two three four" })
    wl.width = 8
    assert(wl.height == 3, "label wrap height: " .. wl.height)
    f4:draw()
    assert(f4._render.text[2]:sub(1, 8):find("three"), "label wrap render")

    -- Input: pattern filters typing and pastes
    local pin = f4:addInput({ x = 12, y = 1, width = 6, pattern = "%d" })
    f4:handleEvent("mouse_click", 1, 13, 1)
    f4:handleEvent("mouse_up", 1, 13, 1)
    f4:handleEvent("char", "a")
    f4:handleEvent("char", "5")
    f4:handleEvent("paste", "x7y9")
    assert(pin.text == "579", "input pattern failed: " .. pin.text)

    -- ProgressBar: direction + percentage
    f4:addProgressBar({ x = 1, y = 5, width = 10, height = 1,
        progress = 50, direction = "left", showPercentage = true })
    f4:draw()
    assert(f4._render.text[5]:sub(1, 10):find("50%", 1, true),
        "percentage text missing")
    assert(f4._render.bg[5]:byte(10) == 5 and f4._render.bg[5]:byte(1) == 7,
        "left direction fill wrong")

    -- Slider: vertical orientation
    local vs = f4:addSlider({ x = 14, y = 3, horizontal = false,
        width = 1, height = 6, min = 0, max = 10 })
    f4:handleEvent("mouse_click", 1, 14, 8) -- local y = 6 -> max
    f4:handleEvent("mouse_up", 1, 14, 8)
    assert(vs.value == 10, "vertical slider click: " .. vs.value)

    -- List: emptyText + multi selection
    local ml = f4:addList({ x = 16, y = 1, width = 8, height = 4,
        multiSelection = true, emptyText = "leer" })
    f4:draw()
    assert(f4._render.text[2]:sub(16, 23):find("leer"), "emptyText render")
    for _, v in ipairs({ "A", "B", "C" }) do ml:addItem(v) end
    f4:handleEvent("mouse_click", 1, 17, 1)
    f4:handleEvent("mouse_up", 1, 17, 1)
    f4:handleEvent("mouse_click", 1, 17, 3)
    f4:handleEvent("mouse_up", 1, 17, 3)
    local selection = ml:getSelection()
    assert(#selection == 2 and selection[1] == 1 and selection[2] == 3,
        "multi select failed")
    f4:handleEvent("mouse_click", 1, 17, 1) -- toggle off again
    f4:handleEvent("mouse_up", 1, 17, 1)
    selection = ml:getSelection()
    assert(#selection == 1 and selection[1] == 3, "multi deselect failed")

    -- Table: custom sort, updateCell, removeRow
    local t2 = f4:addTable({ x = 25, y = 1, width = 14, height = 5 })
    t2.columns = { { title = "N", width = 6 }, { title = "V" } }
    t2.data = { { "a", "x2" }, { "b", "x10" }, { "c", "x1" } }
    t2:setColumnSort(2, function(va, vb, asc)
        local na, nb = tonumber(va:sub(2)), tonumber(vb:sub(2))
        if asc then return na < nb end
        return na > nb
    end)
    t2:sortBy(2, true)
    local sel2
    t2:onSelect(function(_, i) sel2 = i end)
    f4:handleEvent("mouse_click", 1, 26, 2) -- top view row -> "x1" = data 3
    f4:handleEvent("mouse_up", 1, 26, 2)
    assert(sel2 == 3, "custom column sort failed: " .. tostring(sel2))
    t2:updateCell(3, 2, "x99") -- resort: "x2" is now first
    f4:handleEvent("mouse_click", 1, 26, 2)
    f4:handleEvent("mouse_up", 1, 26, 2)
    assert(sel2 == 1, "updateCell must resort: " .. tostring(sel2))
    t2:removeRow(1)
    assert(#t2.data == 2 and t2.selected == false, "removeRow failed")

    -- Frame: draggable via top row
    local df = f4:addFrame({ x = 3, y = 8, width = 8, height = 4,
        draggable = true })
    f4:handleEvent("mouse_click", 1, 4, 8) -- grab the top row
    f4:handleEvent("mouse_drag", 1, 7, 10)
    f4:handleEvent("mouse_up", 1, 7, 10)
    assert(df.x == 6 and df.y == 10, "frame drag: " .. df.x .. "," .. df.y)
    f4:handleEvent("mouse_click", 1, 7, 12) -- body is not a drag zone
    f4:handleEvent("mouse_drag", 1, 9, 12)
    f4:handleEvent("mouse_up", 1, 9, 12)
    assert(df.x == 6, "body drag must not move the frame")

    -- Menu: submenus + separators
    local m2 = f4:addMenu({ x = 1, y = 14 })
    m2.items = {
        { text = "File", items = { "New", "Open" } },
        { separator = true },
        "Help",
    }
    local subSel, subParent
    m2:onSelect(function(_, _, item, parent) subSel, subParent = item, parent end)
    f4:handleEvent("mouse_click", 1, 2, 14) -- "File" -> opens submenu
    f4:handleEvent("mouse_up", 1, 2, 14)
    assert(m2.height == 3, "submenu must expand: " .. m2.height)
    f4:handleEvent("mouse_click", 1, 2, 16) -- submenu row 2 -> "Open"
    f4:handleEvent("mouse_up", 1, 2, 16)
    assert(subSel == "Open" and subParent == 1, "submenu select failed")
    assert(m2.height == 1, "submenu must close after select")
    subSel = nil
    f4:handleEvent("mouse_click", 1, 8, 14) -- separator: not clickable
    f4:handleEvent("mouse_up", 1, 8, 14)
    assert(subSel == nil, "separator must not select")
    report("parity extensions ok")

    -- ============ new elements: ComboBox, ContextMenu, Dialog, Toast ====
    local cbx = f4:addComboBox({ x = 25, y = 8, width = 10, autoComplete = true })
    cbx:addItem("Apfel"):addItem("Apfelsaft"):addItem("Birne")
    local cbxIdx
    cbx:onSelect(function(_, i) cbxIdx = i end)
    f4:handleEvent("mouse_click", 1, 34, 8) -- arrow cell toggles
    f4:handleEvent("mouse_up", 1, 34, 8)
    assert(cbx.open == true and cbx.height == 4, "combobox open failed")
    f4:handleEvent("mouse_click", 1, 26, 10) -- row 2 -> "Apfelsaft"
    f4:handleEvent("mouse_up", 1, 26, 10)
    assert(cbx.text == "Apfelsaft" and cbxIdx == 2 and cbx.open == false,
        "combobox select: " .. cbx.text)
    cbx.text = ""
    f4:handleEvent("mouse_click", 1, 26, 8) -- focus the input row
    f4:handleEvent("mouse_up", 1, 26, 8)
    f4:handleEvent("char", "B")
    assert(cbx.open == true, "autocomplete must open while typing")
    local display = cbx:getDisplayItems()
    assert(#display == 1 and display[1].text == "Birne", "filter failed")
    f4:handleEvent("key", keys.enter)
    assert(cbx.text == "Birne" and cbxIdx == 3,
        "autocomplete accept failed: " .. cbx.text)

    local cm = f4:addContextMenu()
    cm:setItems({ "Copy", { separator = true }, "Delete" })
    cm:openAt(30, 12)
    assert(cm.visible == true and cm.x == 30 and cm.y == 12,
        "contextmenu openAt failed")
    local cmSel
    cm:onSelect(function(_, _, item) cmSel = item end)
    f4:handleEvent("mouse_click", 1, 32, 14) -- row 3 -> "Delete"
    f4:handleEvent("mouse_up", 1, 32, 14)
    assert(tostring(cmSel) == "Delete" and cm.visible == false,
        "contextmenu select failed")
    cm:openAt(30, 12)
    f4:handleEvent("mouse_click", 1, 2, 2) -- outside click -> blur -> close
    f4:handleEvent("mouse_up", 1, 2, 2)
    assert(cm.visible == false, "contextmenu must close on outside click")

    local dlg = f4:addDialog()
    local confirmResult
    dlg:confirm("Frage", "Wirklich?", function(yes) confirmResult = yes end)
    assert(dlg.visible and dlg.width == 40 and dlg.height == 18,
        "dialog must cover its parent")
    f4:draw()
    local dbox = dlg:getChildren()[1]
    local yesBtn
    for _, c in ipairs(dbox:getChildren()) do
        if c.text == "Yes" then yesBtn = c end
    end
    assert(yesBtn, "yes button missing")
    local bx, by = yesBtn:getAbsolutePosition()
    f4:handleEvent("mouse_click", 1, bx, by)
    f4:handleEvent("mouse_up", 1, bx, by)
    assert(confirmResult == true and dlg.visible == false, "confirm failed")

    local behindClicked = false
    f4:addButton({ x = 1, y = 17, width = 5, height = 1, text = "B" })
        :onClick(function() behindClicked = true end)
    dlg:alert("T", "msg")
    f4:handleEvent("mouse_click", 1, 2, 17) -- swallowed by the backdrop
    f4:handleEvent("mouse_up", 1, 2, 17)
    assert(behindClicked == false, "dialog must be modal")
    dbox = dlg:getChildren()[1]
    local okBtn
    for _, c in ipairs(dbox:getChildren()) do
        if c.text == "OK" then okBtn = c end
    end
    bx, by = okBtn:getAbsolutePosition()
    f4:handleEvent("mouse_click", 1, bx, by)
    f4:handleEvent("mouse_up", 1, bx, by)
    assert(dlg.visible == false, "alert OK must close")

    local toast = f4:addToast()
    toast:success("Gespeichert")
    assert(toast.visible == true and toast.background == colors.green,
        "toast success failed")
    toast:hide()
    assert(toast.visible == false, "toast hide failed")
    toast:show("Kurz", nil, 0.2)
    assert(toast.visible == true, "toast show failed")
    local toastDeadline = os.clock() + 5
    while toast.visible and os.clock() < toastDeadline do
        basalt.update(os.pullEvent())
    end
    assert(toast.visible == false, "toast must auto-hide")
    report("new elements ok")

    -- ============ modules: charts, image, bigfont ============
    basalt.use("charts")
    local f5 = basalt.createFrame(makeStub(30, 12))
    local g = f5:addGraph({ x = 1, y = 1, width = 10, height = 5, maxValue = 10 })
    g:addSeries("s", { symbol = " ", bg = colors.red, pointCount = 5 })
    g:addPoint("s", 0)
    g:addPoint("s", 10)
    f5:draw()
    assert(f5._render.bg[5]:byte(1) == 14, "graph low point missing")
    assert(f5._render.bg[1]:byte(3) == 14, "graph high point missing")

    local bc = f5:addBarChart({ x = 12, y = 1, width = 7, height = 4 })
    bc.data = { 1, 2, 4 }
    f5:draw()
    assert(f5._render.bg[1]:byte(16) == 5, "barchart tall bar missing")
    assert(f5._render.bg[1]:byte(12) ~= 5, "barchart short bar too tall")

    local lc = f5:addLineChart({ x = 1, y = 7, width = 10, height = 4, maxValue = 4 })
    lc.data = { 0, 4 }
    f5:draw()
    assert(f5._render.bg[10]:byte(1) == 5, "linechart start missing")
    assert(f5._render.bg[7]:byte(10) == 5, "linechart end missing")

    basalt.use("image")
    local img = f5:addImage({ x = 12, y = 7 })
    img.bimg = { { { "AB", "00", "ee" }, { "CD", "00", "ee" } } }
    assert(img.width == 2 and img.height == 2, "image autosize failed")
    f5:draw()
    assert(f5._render.text[7]:sub(12, 13) == "AB", "image render failed")
    assert(f5._render.bg[7]:byte(12) == 14, "image colors failed")
    img.bimg = { { { "X", "0", "e" } }, { { "Y", "0", "e" } } }
    img:nextFrame()
    assert(img.currentFrame == 2, "image nextFrame failed")
    f5:draw()
    assert(f5._render.text[7]:sub(12, 12) == "Y", "image frame switch failed")

    basalt.use("bigfont")
    local bf = f5:addBigFont({ x = 20, y = 7, text = "A", fontSize = 1 })
    assert(bf.width == 3 and bf.height == 3,
        "bigfont size: " .. bf.width .. "x" .. bf.height)
    f5:draw()
    local glyph = f5._render.text[7]:sub(20, 22) .. f5._render.text[8]:sub(20, 22)
    assert(glyph:find("[^ ]"), "bigfont glyph empty")
    assert(not pcall(function() bf.fontSize = 5 end), "fontSize 5 must error")
    report("modules charts/image/bigfont ok")

    -- TextBox selection: shift+keys, mouse drag, ctrl+a/c/x, edits
    tb.text = "abcdef\nghijkl\nmnopqr"
    f3:handleEvent("mouse_click", 1, 1, 1) -- focus, cursor to 1,1
    f3:handleEvent("mouse_up", 1, 1, 1)
    f3:handleEvent("key", keys.leftShift)
    for _ = 1, 3 do f3:handleEvent("key", keys.right) end
    assert(tb:getSelection() == "abc",
        "shift selection: " .. tostring(tb:getSelection()))
    f3:handleEvent("key", keys.down) -- still shifted: extend a line down
    assert(tb:getSelection() == "abcdef\nghi",
        "multiline selection: " .. tostring(tb:getSelection()))
    f3:handleEvent("key_up", keys.leftShift)
    f3:handleEvent("char", "X") -- typing replaces the selection
    assert(tb.text == "Xjkl\nmnopqr",
        "selection replace: " .. tb.text:gsub("\n", "|"))

    f3:handleEvent("key", keys.leftCtrl)
    f3:handleEvent("key", keys.a) -- select all
    assert(tb:getSelection() == "Xjkl\nmnopqr", "ctrl+a failed")
    f3:handleEvent("key", keys.c) -- copy
    f3:handleEvent("key", keys.x) -- cut
    f3:handleEvent("key_up", keys.leftCtrl)
    assert(tb:getClipboard() == "Xjkl\nmnopqr", "clipboard content wrong")
    assert(tb.text == "" and #tb._lines == 1, "cut must empty the buffer")

    tb.text = "hello world"
    f3:handleEvent("mouse_click", 1, 1, 1)
    f3:handleEvent("mouse_drag", 1, 6, 1) -- drag across "hello"
    assert(tb:getSelection() == "hello",
        "mouse selection: " .. tostring(tb:getSelection()))
    f3:handleEvent("mouse_up", 1, 6, 1)
    f3:draw() -- selection overlay renders (smoke)
    f3:handleEvent("key", keys.backspace) -- deletes only the selection
    assert(tb.text == " world", "selection delete: " .. tb.text)
    f3:handleEvent("key", keys.escape) -- no selection left: no-op
    assert(tb:getSelection() == nil, "escape must collapse selection")
    report("textbox selection ok")

    -- bundler: pack src/ into one file, boot it, drive a UI from it
    -- (library mode is what the future installer will call)
    local bundlerApi = assert(loadfile("/Basalt3/bundle.lua", nil, _ENV))("--lib")
    assert(type(bundlerApi.build) == "function", "bundler --lib mode failed")
    local stats = bundlerApi.build({ output = "/b3_bundle_test.lua" })
    assert(fs.exists("/b3_bundle_test.lua"), "bundle output missing")
    assert(stats.files >= 30 and stats.bytesOut < stats.bytesIn,
        "bundler stats implausible")
    local bundled = assert(loadfile("/b3_bundle_test.lua", nil, _ENV))(
        "basalt", "/b3_bundle_test.lua")
    assert(type(bundled) == "table" and type(bundled.run) == "function",
        "bundle did not return basalt")
    assert(bundled.VERSION == basalt.VERSION, "bundle version mismatch")

    local f6 = bundled.createFrame(makeStub(20, 8))
    local bundleClicked
    f6:addButton({ x = 1, y = 1, width = 6, height = 1, text = "Go" })
        :onClick(function() bundleClicked = true end)
    f6:handleEvent("mouse_click", 1, 2, 1)
    f6:handleEvent("mouse_up", 1, 2, 1)
    f6:draw()
    assert(bundleClicked, "bundled basalt is not functional")
    assert(f6._render.text[1]:find("Go", 1, true), "bundled render failed")

    local bundledTheme = bundled.use("theme")
    assert(type(bundledTheme.set) == "function", "bundled module failed")
    bundled.use("bigfont") -- heaviest module: font data must survive bundling
    local bigFromBundle = f6:addBigFont({ x = 8, y = 1, text = "B" })
    assert(bigFromBundle.width == 3, "bundled bigfont broken")
    -- reactive expressions must still compile inside the bundle
    local rb = f6:addLabel({ text = "r", x = "{parent.width - 2}" })
    assert(rb.x == 18, "bundled reactive failed: " .. tostring(rb.x))
    fs.delete("/b3_bundle_test.lua")
    report("bundler ok")

    -- installer: all three variants, non-interactive, local mode
    local installerPath = "/Basalt3/installer.lua"

    assert(loadfile(installerPath, nil, _ENV))("minified", "/b3_inst_min.lua")
    local instMin = assert(loadfile("/b3_inst_min.lua", nil, _ENV))(
        "basalt", "/b3_inst_min.lua")
    assert(type(instMin.run) == "function", "minified install broken")

    assert(loadfile(installerPath, nil, _ENV))("bundled", "/b3_inst_bun.lua")
    assert(fs.getSize("/b3_inst_bun.lua") > fs.getSize("/b3_inst_min.lua"),
        "bundled must be larger than minified")

    assert(loadfile(installerPath, nil, _ENV))("source", "/b3_inst_src")
    assert(fs.exists("/b3_inst_src/init.lua")
        and fs.exists("/b3_inst_src/src/main.lua")
        and fs.exists("/b3_inst_src/src/core/render.lua"),
        "source install incomplete")
    local instSrc = assert(loadfile("/b3_inst_src/init.lua", nil, _ENV))(
        "basalt", "/b3_inst_src/init.lua")
    assert(type(instSrc.createFrame) == "function", "source install broken")

    assert(loadfile(installerPath, nil, _ENV))("--make-manifest")
    assert(fs.exists("/Basalt3/manifest.txt"), "manifest missing")
    local mh = fs.open("/Basalt3/manifest.txt", "r")
    local manifestContent = mh.readAll()
    mh.close()
    assert(manifestContent:find("init.lua", 1, true)
        and manifestContent:find("bundle.lua", 1, true)
        and manifestContent:find("src/main.lua", 1, true)
        and manifestContent:find("src/modules/bigfont.lua", 1, true),
        "manifest incomplete")

    fs.delete("/b3_inst_min.lua")
    fs.delete("/b3_inst_bun.lua")
    fs.delete("/b3_inst_src")
    report("installer ok")

    -- installer GUI: bootstraps its own basalt, renders the wizard; we
    -- drive it with pre-queued events (pick variant, paste target,
    -- install, exit) before starting it
    os.queueEvent("mouse_click", 1, 3, 8) -- list row 3: minified
    os.queueEvent("mouse_up", 1, 3, 8)
    os.queueEvent("mouse_click", 1, 9, 10) -- focus the target input
    os.queueEvent("mouse_up", 1, 9, 10)
    os.queueEvent("paste", "/b3_gui.lua")
    os.queueEvent("mouse_click", 1, 3, 12) -- Install
    os.queueEvent("mouse_up", 1, 3, 12)
    os.queueEvent("mouse_click", 1, 16, 12) -- Exit -> basalt.stop()
    os.queueEvent("mouse_up", 1, 16, 12)
    assert(loadfile(installerPath, nil, _ENV))() -- no args -> GUI wizard
    assert(fs.exists("/b3_gui.lua"), "GUI install produced no file")
    local guiBas = assert(loadfile("/b3_gui.lua", nil, _ENV))(
        "basalt", "/b3_gui.lua")
    assert(type(guiBas.run) == "function", "GUI-installed bundle broken")
    fs.delete("/b3_gui.lua")
    report("installer gui ok")

    -- basalt theme preset: applyPreset styles defaults + class state styles
    do -- scoped: keeps us under Lua's 200-locals-per-function limit
    local themePresetMod = basalt.use("theme")
    assert(themePresetMod.presets and themePresetMod.presets.basalt,
        "basalt preset missing")
    local presetStyles = themePresetMod.presets.basalt.styles
    local savedDefaults = {}
    for typeName, props in pairs(presetStyles) do
        savedDefaults[typeName] = {}
        local cls = themePresetMod.classes[typeName]
        for k in pairs(props) do
            if k ~= "states" then
                savedDefaults[typeName][k] = cls.__defaults[k]
            end
        end
    end

    local pal = themePresetMod.applyPreset("basalt")
    assert(pal.lava and pal.bg and pal.text, "palette tokens missing")
    local themedBtn = f4:addButton({ x = 30, y = 16, width = 6, height = 1 })
    assert(themedBtn.background == pal.raised,
        "preset default not applied to new button")
    assert(themedBtn.foreground == pal.text,
        "Element foreground token not inherited")
    themedBtn:setState("hover", true)
    assert(themedBtn.background == pal.border,
        "preset hover state style not resolved")
    themedBtn:setState("hover", false)
    -- f4's root never set an explicit background -> follows the preset live;
    -- `frame` set one explicitly at the top -> must NOT be overridden
    assert(f4.background == pal.bg, "existing root must retheme live")
    assert(frame.background ~= pal.bg, "explicit background must win")

    -- restore stock defaults: the remaining tests expect CC colors
    for typeName, props in pairs(savedDefaults) do
        local cls = themePresetMod.classes[typeName]
        for k, v in pairs(props) do
            cls.__defaults[k] = v
        end
    end
    for typeName, props in pairs(presetStyles) do
        if props.states then
            local cls = themePresetMod.classes[typeName]
            for stateName in pairs(props.states) do
                cls.__stateStyles[stateName] = nil
            end
        end
    end
    themedBtn:destroy()
    end
    report("theme preset ok")

    -- >16 colors: register plenty, force nearest-match path
    for i = 1, 30 do
        frame:addLabel({ x = i, y = 12, text = " ",
            background = basalt.rgb(i / 30, 0.5, 1 - i / 30) })
    end
    basalt.update()
    report("palette overflow ok")
end)

local f = fs.open("/basalt3_test_result.txt", "w")
if ok then
    f.writeLine("PASS")
else
    f.writeLine("FAIL: " .. tostring(err))
end
for _, line in ipairs(results) do
    f.writeLine(line)
end
f.close()
os.shutdown()

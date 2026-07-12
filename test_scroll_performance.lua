-- Regression for cached layout/content bounds and viewport child culling.
local ok, err = pcall(function()
    local basalt = assert(loadfile("/Basalt3/init.lua", nil, _ENV))(
        "Basalt3", "Basalt3/init.lua")
    local frame = basalt.createFrame()
    local content = frame:addColumn({
        x = 1, y = 1, width = 12, height = 5,
        gap = 0,
        scrollable = true,
        scrollXEnabled = false,
        scrollYEnabled = true,
        scrollStep = 3,
    })

    local layoutPasses, renders = 0, 0
    content:onLayout(function() layoutPasses = layoutPasses + 1 end)
    local buttons = {}
    for i = 1, 200 do
        local button = content:addButton({
            text = "Item " .. i,
            width = basalt.fill(),
            height = 1,
        })
        buttons[i] = button
        local original = button.render
        button.render = function(self, buf)
            renders = renders + 1
            return original(self, buf)
        end
    end

    frame:draw()
    assert(layoutPasses == 1, "expected one initial content layout")
    assert(renders <= 6, "offscreen children rendered initially: " .. renders)
    local width, height = content:getContentSize()
    assert(width == 12 and height == 200,
        "wrong cached content size: " .. width .. "x" .. height)

    renders = 0
    content:scrollTo(0, 50)
    frame:draw()
    assert(layoutPasses == 1, "scroll unexpectedly recomputed layout")
    assert(renders <= 6, "offscreen children rendered after scroll: " .. renders)
    assert(frame:findAt(1, 1) == buttons[51], "visible hit-test cache is wrong")

    renders = 0
    buttons[100].text = "Changed width-affecting text"
    frame:draw()
    assert(layoutPasses == 2, "content mutation did not invalidate layout")
    assert(renders <= 6, "layout invalidation disabled viewport culling")

    renders = 0
    buttons[51]:setStateStyle("hover", { background = colors.blue })
    buttons[51]:setState("hover", true)
    frame:draw()
    assert(layoutPasses == 2, "paint-only hover invalidated layout")
    assert(renders <= 6, "paint-only redraw rendered offscreen children")
end)

local file = assert(fs.open("/basalt3_scroll_performance_result.txt", "w"))
file.writeLine(ok and "PASS" or ("FAIL: " .. tostring(err)))
file.close()
os.shutdown()

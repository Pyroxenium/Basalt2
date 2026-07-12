-- Basalt 2.5 runtime: event loop, frame management, scheduling.

-- Modules are normally loaded through init.lua, whose module loader arrives
-- as the first vararg (this deliberately SHADOWS the global require with a
-- local one — no package.path pollution, no package.loaded collisions).
-- If main.lua is loaded directly via CC's require("main") instead, the first
-- vararg is the module name (a string): bootstrap through init.lua then.
local require = ...
if type(require) ~= "function" then
    local name, path = ...
    local initPath = fs.combine(fs.getDir(path or "Basalt3/src/main.lua"), "init.lua")
    return assert(loadfile(initPath, nil, _ENV))(name, initPath)
end
local errors = require("core/errors")
local palette = require("core/palette")
local state = require("core/state")
local layout = require("core/layout")
local Container = require("core/container")
local BaseFrame = require("core/baseframe")

Container.register("Label", require("elements/Label"))
Container.register("Button", require("elements/Button"))
Container.register("Frame", require("elements/Frame"))
Container.register("Input", require("elements/Input"))
Container.register("Checkbox", require("elements/Checkbox"))
Container.register("Switch", require("elements/Switch"))
Container.register("ProgressBar", require("elements/ProgressBar"))
Container.register("Slider", require("elements/Slider"))
Container.register("Collection", require("elements/Collection"))
Container.register("List", require("elements/List"))
Container.register("Dropdown", require("elements/Dropdown"))
Container.register("Flex", require("elements/Flex"))
Container.register("Row", require("elements/Row"))
Container.register("Column", require("elements/Column"))
Container.register("TextBox", require("elements/TextBox"))
Container.register("Menu", require("elements/Menu"))
Container.register("TabControl", require("elements/TabControl"))
Container.register("Tree", require("elements/Tree"))
Container.register("Table", require("elements/Table"))
Container.register("Program", require("elements/Program"))
Container.register("ComboBox", require("elements/ComboBox"))
Container.register("ContextMenu", require("elements/ContextMenu"))
Container.register("Dialog", require("elements/Dialog"))
Container.register("Toast", require("elements/Toast"))

local basalt = {}
basalt.VERSION = "2.5.0-dev"
basalt.traceback = true -- show the traceback section on the error screen
basalt.errors = errors

--- Registers a custom RGB color; returns a handle usable like a colors.* value.
basalt.rgb = palette.rgb

--- Creates writable application state. Signals can be assigned directly to
--- element properties and automatically invalidate their dependent UI trees.
basalt.state = state.create
basalt.signal = state.create

--- Creates a lazily evaluated value that tracks any signals read inside it.
basalt.computed = state.computed
basalt.isState = state.is

--- Responsive layout values for element width/height properties.
basalt.auto = layout.auto
basalt.fill = layout.fill
basalt.percent = layout.percent

--- Loads an optional module from modules/ (e.g. "debug", "animation",
--- "theme", "xml") and returns its API. Modules extend Basalt from the
--- outside; the core has no knowledge of them.
function basalt.use(moduleName)
    return require("modules/" .. moduleName)
end

local frames = {}
local mainFrame = nil
local running = false
local schedules = {}

--- Creates a root frame bound to a terminal (default: current term).
--- For monitors, pass the wrapped peripheral; touch events are routed
--- automatically. monitorName only needs to be given if auto-detection fails.
function basalt.createFrame(t, monitorName)
    t = t or term.current()
    local f = BaseFrame.new()
    f:setTerm(t)
    if monitorName == nil and t.setTextScale and peripheral then
        local ok, name = pcall(peripheral.getName, t)
        if ok then monitorName = name end
    end
    rawset(f, "monitor", monitorName)
    frames[#frames + 1] = f
    if not mainFrame then mainFrame = f end
    return f
end

--- Returns (or lazily creates) the main frame.
function basalt.getMainFrame()
    return mainFrame or basalt.createFrame()
end

--- Runs a function in a coroutine driven by the event loop; blocking calls
--- like sleep() are allowed inside.
function basalt.schedule(fn)
    local co = coroutine.create(fn)
    local ok, filter = coroutine.resume(co)
    if not ok then
        error(errors.wrap(filter, debug.traceback(co)), 0)
    end
    schedules[#schedules + 1] = { co = co, filter = filter }
    return co
end

local function resumeSchedules(event, ...)
    for i = #schedules, 1, -1 do
        local s = schedules[i]
        if coroutine.status(s.co) == "suspended"
            and (s.filter == nil or s.filter == event) then
            local ok, filter = coroutine.resume(s.co, event, ...)
            if not ok then
                -- capture the coroutine's stack before it is lost
                error(errors.wrap(filter, debug.traceback(s.co)), 0)
            end
            s.filter = filter
        end
        if coroutine.status(s.co) == "dead" then
            table.remove(schedules, i)
        end
    end
end

local MOUSE = {
    mouse_click = true,
    mouse_up = true,
    mouse_drag = true,
    mouse_scroll = true,
    mouse_move = true,
}
local KEY = { key = true, key_up = true, char = true, paste = true }

local function dispatch(event, a, b, c, ...)
    if event == "mouse_move" and type(a) == "string" then
        -- Monitor mouse movement includes the peripheral side before x/y.
        for i = 1, #frames do
            local f = frames[i]
            if rawget(f, "monitor") == a then
                f:handleEvent(event, b, c)
            end
        end
    elseif MOUSE[event] or KEY[event] then
        if mainFrame then mainFrame:handleEvent(event, a, b, c, ...) end
    elseif event == "monitor_touch" or event == "monitor_resize" then
        for i = 1, #frames do
            local f = frames[i]
            if rawget(f, "monitor") == a then
                if event == "monitor_touch" then
                    f:handleEvent("mouse_click", 1, b, c)
                    f:handleEvent("mouse_up", 1, b, c)
                else
                    f:handleEvent("term_resize")
                end
            end
        end
    else
        for i = 1, #frames do
            frames[i]:handleEvent(event, a, b, c, ...)
        end
    end
    resumeSchedules(event, a, b, c, ...)
end

local function draw()
    for i = 1, #frames do
        frames[i]:draw()
    end
end

--- Feeds a single event through Basalt manually (alternative to run()).
function basalt.update(event, ...)
    if event then dispatch(event, ...) end
    draw()
end

--- Stops the event loop.
function basalt.stop()
    running = false
end

local function cleanup()
    for i = 1, #frames do
        frames[i]:cleanup()
    end
end

--- Starts the event loop; returns when basalt.stop() is called or on error.
function basalt.run()
    if running then error("Basalt 2.5 is already running", 2) end
    running = true

    local ok, err = xpcall(function()
        draw()
        while running do
            local ev = table.pack(os.pullEventRaw())
            if ev[1] == "terminate" then
                running = false
            else
                dispatch(table.unpack(ev, 1, ev.n))
                draw()
            end
        end
    end, function(e)
        if type(e) == "table" and e.__basaltError then return e end
        return errors.wrap(e, debug.traceback(nil, 2))
    end)

    running = false
    cleanup() -- restore palette FIRST so the error screen renders correctly
    if not ok then
        errors.show(err.err, err.trace, basalt.traceback)
    end
end

return basalt

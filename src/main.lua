local elementManager = require("elementManager")
local expect = require("libraries/expect")
local errorManager = require("errorManager")

local basalt = {}
basalt.traceback = true
basalt._events = {}
basalt._schedule = {}
basalt._plugins = {}
basalt.LOGGER = require("log")

local mainFrame = nil
local updaterActive = false

function basalt.create(type, id)
    if(id==nil)then id = elementManager.generateId() end
    local element = elementManager.getElement(type).new(id, basalt)
    local ok, result = pcall(require, "main")
    if not ok then
        errorManager(false, result)
    end
    return element
end

function basalt.createFrame()
    local frame = basalt.create("BaseFrame")
    mainFrame = frame
    return frame
end

function basalt.getElementManager()
    return elementManager
end

function basalt.getMainFrame()
    if(mainFrame == nil)then
        mainFrame = basalt.createFrame()
    end
    return mainFrame
end

function basalt.setActiveFrame(frame)
    mainFrame = frame
    return false
end

function basalt.scheduleUpdate(func)
    table.insert(basalt._schedule, func)
    return #basalt._schedule
end

function basalt.removeSchedule(id)
    basalt._schedule[id] = nil
end

local function updateEvent(event, ...)
    if(event=="terminate")then basalt.stop() end

    if event:find("mouse") then
        if mainFrame then
            mainFrame:handleEvent(event, ...)
        end
    end

    if event:find("key") then
        if mainFrame then
            mainFrame:handleEvent(event, ...)
        end
    end

    if basalt._events[event] then
        for _, callback in ipairs(basalt._events[event]) do
            callback(...)
        end
    end
end

local function renderFrames()
    if(mainFrame)then
        mainFrame:render()
    end
end

function basalt.update()
    for k,v in pairs(basalt._schedule) do
        if type(v)=="function" then
            v()
        end
    end
end

function basalt.stop()
    term.clear()
    term.setCursorPos(1,1)
    updaterActive = false
end

function basalt.run(isActive)
    updaterActive = isActive
    if(isActive==nil)then updaterActive = true end
    local function f()
        renderFrames()
        while updaterActive do
            updateEvent(os.pullEventRaw())
        end
    end
    while updaterActive do
        local ok, err = pcall(f)
        if not(ok)then
            errorManager.header = "Basalt Runtime Error"
            errorManager.error(err)
        end
    end
end
basalt.autoUpdate = basalt.run

return basalt
local elementManager = require("elementManager")
local errorManager = require("errorManager")
local propertySystem = require("propertySystem")


--- This is the UI Manager and the starting point for your project. The following functions allow you to influence the default behavior of Basalt.
---
--- Before you can access Basalt, you need to add the following code on top of your file:
--- @usage local basalt = require("basalt")
--- What this code does is it loads basalt into the project, and you can access it by using the variable defined as "basalt".
-- @module Basalt
local basalt = {}
basalt.traceback = true
basalt._events = {}
basalt._schedule = {}
basalt._plugins = {}
basalt.LOGGER = require("log")
basalt.path = fs.getDir(select(2, ...))

local mainFrame = nil
local updaterActive = false
local _type = type

local lazyElements = {}
local lazyElementCount = 10
local lazyElementsTimer = 0
local isLazyElementsTimerActive = false


local function queueLazyElements()
    if(isLazyElementsTimerActive)then return end
    lazyElementsTimer = os.startTimer(0.2)
    isLazyElementsTimerActive = true
end

local function loadLazyElements(count)
    for _=1,count do
        local blueprint = lazyElements[1]
        if(blueprint)then
            blueprint:create()
        end
        table.remove(lazyElements, 1)
    end
end

local function lazyElementsEventHandler(event, timerId)
    if(event=="timer")then
        if(timerId==lazyElementsTimer)then
            loadLazyElements(lazyElementCount)
            isLazyElementsTimerActive = false
            lazyElementsTimer = 0
            if(#lazyElements>0)then
                queueLazyElements()
            end
            return true
        end
    end
end

--- Creates and returns a new UI element of the specified type.
--- @shortDescription Creates a new UI element
--- @param type string The type of element to create (e.g. "Button", "Label", "BaseFrame")
--- @param properties? string|table Optional name for the element or a table with properties to initialize the element with
--- @return table element The created element instance
--- @usage local button = basalt.create("Button")
function basalt.create(type, properties, lazyLoading, parent)
    if(_type(properties)=="string")then properties = {name=properties} end
    if(properties == nil)then properties = {name = type} end
    local elementClass = elementManager.getElement(type)
    if(lazyLoading)then
        local blueprint = propertySystem.blueprint(elementClass, properties, basalt, parent)
        table.insert(lazyElements, blueprint)
        queueLazyElements()
        return blueprint
    else
        local element = elementClass.new()
        element:init(properties, basalt)
        return element
    end
end

--- Creates and returns a new frame
--- @return table BaseFrame The created frame instance
--- @usage local mainFrame = basalt.createFrame()
function basalt.createFrame()
    local frame = basalt.create("BaseFrame")
    frame:postInit()
    mainFrame = frame
    return frame
end

--- Returns the element manager instance
--- @return table ElementManager The element manager
--- @usage local manager = basalt.getElementManager()
function basalt.getElementManager()
    return elementManager
end

--- Gets or creates the main frame
--- @return BaseFrame table The main frame instance
--- @usage local frame = basalt.getMainFrame()
function basalt.getMainFrame()
    if(mainFrame == nil)then
        mainFrame = basalt.createFrame()
    end
    return mainFrame
end

--- Sets the active frame
--- @param frame table The frame to set as active
--- @usage basalt.setActiveFrame(myFrame)
function basalt.setActiveFrame(frame)
    mainFrame = frame
end

--- Schedules a function to be updated
--- @function scheduleUpdate
--- @param func function The function to schedule
--- @return number Id The schedule ID
--- @usage local id = basalt.scheduleUpdate(myFunction)
function basalt.scheduleUpdate(func)
    table.insert(basalt._schedule, func)
    return #basalt._schedule
end

--- Removes a scheduled update
--- @function removeSchedule
--- @param id number The schedule ID to remove
--- @usage basalt.removeSchedule(scheduleId)
function basalt.removeSchedule(id)
    basalt._schedule[id] = nil
end

--- @local Internal event handler
local function updateEvent(event, ...)
    if(event=="terminate")then basalt.stop() end
    if lazyElementsEventHandler(event, ...) then return end

    if(mainFrame)then
        if(mainFrame:dispatchEvent(event, ...))then
            return
        end
    end

    if basalt._events[event] then
        for _, callback in ipairs(basalt._events[event]) do
            callback(...)
        end
    end
end

--- @local Internal render function
local function renderFrames()
    if(mainFrame)then
        mainFrame:render()
    end
end

--- Updates all scheduled functions
--- @usage basalt.update()
function basalt.update()
    for k,v in pairs(basalt._schedule) do
        if type(v)=="function" then
            v()
        end
    end
end

--- Stops the Basalt runtime
--- @usage basalt.stop()
function basalt.stop()
    term.clear()
    term.setCursorPos(1,1)
    updaterActive = false
end

--- Starts the Basalt runtime
--- @param isActive? boolean Whether to start active (default: true)
--- @usage basalt.run()
--- @usage basalt.run(false)
function basalt.run(isActive)
    updaterActive = isActive
    if(isActive==nil)then updaterActive = true end
    local function f()
        renderFrames()
        while updaterActive do
            updateEvent(os.pullEventRaw())
            renderFrames()
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

function basalt.getAPI(name)
    return elementManager.getAPI(name)
end

return basalt
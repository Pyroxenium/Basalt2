local elementManager = require("elementManager")
local errorManager = require("errorManager")
local propertySystem = require("propertySystem")
local expect = require("libraries/expect")


--- This is the UI Manager and the starting point for your project. The following functions allow you to influence the default behavior of Basalt.
---
--- Before you can access Basalt, you need to add the following code on top of your file:
--- @usage local basalt = require("basalt")
--- What this code does is it loads basalt into the project, and you can access it by using the variable defined as "basalt".
--- @class Basalt
--- @field traceback boolean Whether to show a traceback on errors
--- @field _events table A table of events and their callbacks
--- @field _schedule function[] A table of scheduled functions
--- @field _plugins table A table of plugins
--- @field LOGGER Log The logger instance
--- @field path string The path to the Basalt library
local basalt = {}
basalt.traceback = true
basalt._events = {}
basalt._schedule = {}
basalt._plugins = {}
basalt.LOGGER = require("log")
if(minified)then
    basalt.path = fs.getDir(shell.getRunningProgram())
else
    basalt.path = fs.getDir(select(2, ...))
end

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

--- Creates and returns a new BaseFrame
--- @shortDescription Creates a new BaseFrame
--- @return table BaseFrame The created frame instance
--- @usage local mainFrame = basalt.createFrame()
function basalt.createFrame()
    local frame = basalt.create("BaseFrame")
    frame:postInit()
    if(mainFrame==nil)then mainFrame = frame end
    return frame
end

--- Returns the element manager instance
--- @shortDescription Returns the element manager
--- @return table ElementManager The element manager
--- @usage local manager = basalt.getElementManager()
function basalt.getElementManager()
    return elementManager
end

--- Gets or creates the main frame
--- @shortDescription Gets or creates the main frame
--- @return BaseFrame table The main frame instance
--- @usage local frame = basalt.getMainFrame()
function basalt.getMainFrame()
    if(mainFrame == nil)then
        mainFrame = basalt.createFrame()
    end
    return mainFrame
end

--- Sets the active frame
--- @shortDescription Sets the active frame
--- @param frame table The frame to set as active
--- @usage basalt.setActiveFrame(myFrame)
function basalt.setActiveFrame(frame)
    mainFrame = frame
    mainFrame:updateRender()
end

--- Schedules a function to run in a coroutine
--- @shortDescription Schedules a function to run in a coroutine
--- @function scheduleUpdate
--- @param func function The function to schedule
--- @return thread func The scheduled function
--- @usage local id = basalt.scheduleUpdate(myFunction)
function basalt.schedule(func)
    expect(1, func, "function")

    local co = coroutine.create(func)
    local ok, result = coroutine.resume(co)
    if(ok)then
        table.insert(basalt._schedule, {coroutine=co, filter=result})
    else
        errorManager.header = "Basalt Schedule Error"
        errorManager.error(result)
    end
    return co
end

--- Removes a scheduled update
--- @shortDescription Removes a scheduled update
--- @function removeSchedule
--- @param func thread The scheduled function to remove
--- @return boolean success Whether the scheduled function was removed
--- @usage basalt.removeSchedule(scheduleId)
function basalt.removeSchedule(func)
    for i, v in ipairs(basalt._schedule) do
        if(v.coroutine==func)then
            table.remove(basalt._schedule, i)
            return true
        end
    end
    return false
end

local function updateEvent(event, ...)
    if(event=="terminate")then basalt.stop() end
    if lazyElementsEventHandler(event, ...) then return end

    if(mainFrame)then
        mainFrame:dispatchEvent(event, ...)
    end

    for k, func in ipairs(basalt._schedule) do
        if(event==func.filter)or(func.filter==nil)then
            local ok, result = coroutine.resume(func.coroutine, event, ...)
            if(not ok)then
                errorManager.header = "Basalt Schedule Error"
                errorManager.error(result)
            end
            func.filter = result
        end
        if(coroutine.status(func.coroutine)=="dead")then
            basalt.removeSchedule(func.coroutine)
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

--- Runs basalt once
--- @shortDescription Runs basalt once
--- @vararg any The event to run with
--- @usage basalt.update()
function basalt.update(...)
    updateEvent(...)
    renderFrames()
end

--- Stops the Basalt runtime
--- @shortDescription Stops the Basalt runtime
--- @usage basalt.stop()
function basalt.stop()
    updaterActive = false
    term.clear()
    term.setCursorPos(1,1)
end

--- Starts the Basalt runtime
--- @shortDescription Starts the Basalt runtime
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
            if(updaterActive)then
                renderFrames()
            end
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

--- Returns a Plugin API
--- @shortDescription Returns a Plugin API
--- @param name string The name of the plugin
--- @return table Plugin The plugin API
function basalt.getAPI(name)
    return elementManager.getAPI(name)
end

return basalt
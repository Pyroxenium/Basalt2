local elementManager = require("elementManager")
local errorManager = require("errorManager")
local propertySystem = require("propertySystem")
local expect = require("libraries/expect")

--- This is the UI Manager and the starting point for your project. The following functions allow you to influence the default behavior of Basalt.
---
--- Before you can access Basalt, you need to add the following code on top of your file:
--- @usage local basalt = require("basalt")
--- What this code does is it loads basalt into the project, and you can access it by using the variable defined as "basalt".
--- @class basalt
--- @field traceback boolean Whether to show a traceback on errors
--- @field _events table A table of events and their callbacks
--- @field _schedule function[] A table of scheduled functions
--- @field _eventQueue table A table of unfinished events
--- @field _plugins table A table of plugins
--- @field isRunning boolean Whether the Basalt runtime is active
--- @field LOGGER Log The logger instance
--- @field path string The path to the Basalt library
local basalt = {}
basalt.traceback = true
basalt._events = {}
basalt._schedule = {}
basalt._eventQueue = {}
basalt._plugins = {}
basalt.isRunning = false
basalt.LOGGER = require("log")
if(minified)then
    basalt.path = fs.getDir(shell.getRunningProgram())
else
    basalt.path = fs.getDir(select(2, ...))
end

local main = nil
local focusedFrame = nil
local activeFrames = {}
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
--- @return BaseFrame BaseFrame The created frame instance
function basalt.createFrame()
    local frame = basalt.create("BaseFrame")
    frame:postInit()
    if(main==nil)then
        main = tostring(term.current())
        basalt.setActiveFrame(frame, true)
    end
    return frame
end

--- Returns the element manager instance
--- @shortDescription Returns the element manager
--- @return table ElementManager The element manager
function basalt.getElementManager()
    return elementManager
end

--- Returns the error manager instance
--- @shortDescription Returns the error manager
--- @return table ErrorManager The error manager
function basalt.getErrorManager()
    return errorManager
end

--- Gets or creates the main frame
--- @shortDescription Gets or creates the main frame
--- @return BaseFrame BaseFrame The main frame instance
function basalt.getMainFrame()
    local _main = tostring(term.current())
    if(activeFrames[_main] == nil)then
        main = _main
        basalt.createFrame()
    end
    return activeFrames[_main]
end

--- Sets the active frame
--- @shortDescription Sets the active frame
--- @param frame BaseFrame The frame to set as active
--- @param setActive? boolean Whether to set the frame as active (default: true)
function basalt.setActiveFrame(frame, setActive)
    local t = frame:getTerm()
    if(setActive==nil)then setActive = true end
    if(t~=nil)then
        activeFrames[tostring(t)] = setActive and frame or nil
        frame:updateRender()
    end
end

--- Returns the active frame
--- @shortDescription Returns the active frame
--- @param t? term The term to get the active frame for (default: current term)
--- @return BaseFrame? BaseFrame The frame to set as active
function basalt.getActiveFrame(t)
    if(t==nil)then t = term.current() end
    return activeFrames[tostring(t)]
end

--- Sets a frame as focused
--- @shortDescription Sets a frame as focused
--- @param frame BaseFrame The frame to set as focused
function basalt.setFocus(frame)
    if(focusedFrame==frame)then return end
    if(focusedFrame~=nil)then
        focusedFrame:dispatchEvent("blur")
    end
    focusedFrame = frame
    if(focusedFrame~=nil)then
        focusedFrame:dispatchEvent("focus")
    end
end

--- Returns the focused frame
--- @shortDescription Returns the focused frame
--- @return BaseFrame? BaseFrame The focused frame
function basalt.getFocus()
    return focusedFrame
end

--- Schedules a function to run in a coroutine
--- @shortDescription Schedules a function to run in a coroutine
--- @function scheduleUpdate
--- @param func function The function to schedule
--- @return thread func The scheduled function
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
function basalt.removeSchedule(func)
    for i, v in ipairs(basalt._schedule) do
        if(v.coroutine==func)then
            table.remove(basalt._schedule, i)
            return true
        end
    end
    return false
end

local mouseEvents = {
    mouse_click = true,
    mouse_up = true,
    mouse_scroll = true,
    mouse_drag = true,
}

local keyEvents = {
    key = true,
    key_up = true,
    char = true,
}

local function updateEvent(event, ...)
    if(event=="terminate")then basalt.stop() return end
    if lazyElementsEventHandler(event, ...) then return end
    local args = {...}

    local function basaltEvent()
        if(mouseEvents[event])then
            if activeFrames[main] then
                activeFrames[main]:dispatchEvent(event, table.unpack(args))
            end
        elseif(keyEvents[event])then
            if(focusedFrame~=nil)then
                focusedFrame:dispatchEvent(event, table.unpack(args))
            end
        else
            for _, frame in pairs(activeFrames) do
                frame:dispatchEvent(event, table.unpack(args))
            end
            --activeFrames[main]:dispatchEvent(event, table.unpack(args)) -- continue here
        end
    end

    -- Main event coroutine system
    for k,v in pairs(basalt._eventQueue) do
        if coroutine.status(v.coroutine) == "suspended" then
            if v.filter == event or v.filter == nil then
                v.filter = nil
                local ok, result = coroutine.resume(v.coroutine, event, ...)
                if not ok then
                    errorManager.header = "Basalt Event Error"
                    errorManager.error(result)
                end
                v.filter = result
            end
        end
        if coroutine.status(v.coroutine) == "dead" then
            table.remove(basalt._eventQueue, k)
        end
    end

    local newEvent = {coroutine=coroutine.create(basaltEvent), filter=event}
    local ok, result = coroutine.resume(newEvent.coroutine, event, ...)
    if(not ok)then
        errorManager.header = "Basalt Event Error"
        errorManager.error(result)
    end
    if(result~=nil)then
        newEvent.filter = result
    end
    table.insert(basalt._eventQueue, newEvent)

    -- Schedule event coroutine system
    for _, func in ipairs(basalt._schedule) do
        if coroutine.status(func.coroutine)=="suspended" then
            if event==func.filter or func.filter==nil then
                func.filter = nil
                local ok, result = coroutine.resume(func.coroutine, event, ...)
                if(not ok)then
                    errorManager.header = "Basalt Schedule Error"
                    errorManager.error(result)
                end
                func.filter = result
            end
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
    for _, frame in pairs(activeFrames)do
        frame:render()
        frame:postRender()
    end
end

--- Runs basalt once, can be used to update the UI manually, but you have to feed it the events
--- @shortDescription Runs basalt once
--- @vararg any The event to run with
function basalt.update(...)
    local f = function(...)
        basalt.isRunning = true
        updateEvent(...)
        renderFrames()
    end
    local ok, err = pcall(f, ...)
    if not(ok)then
        errorManager.header = "Basalt Runtime Error"
        errorManager.error(err)
    end
    basalt.isRunning = false
end

--- Stops the Basalt runtime
--- @shortDescription Stops the Basalt runtime
function basalt.stop()
    basalt.isRunning = false
    term.clear()
    term.setCursorPos(1,1)
end

--- Starts the Basalt runtime
--- @shortDescription Starts the Basalt runtime
--- @param isActive? boolean Whether to start active (default: true)
function basalt.run(isActive)
    if(basalt.isRunning)then errorManager.error("Basalt is already running") end
    if(isActive==nil)then 
        basalt.isRunning = true
    else
        basalt.isRunning = isActive
    end
    local function f()
        renderFrames()
        while basalt.isRunning do
            updateEvent(os.pullEventRaw())
            if(basalt.isRunning)then
                renderFrames()
            end
        end
    end
    while basalt.isRunning do
        local ok, err = pcall(f)
        if not(ok)then
            errorManager.header = "Basalt Runtime Error"
            errorManager.error(err)
        end
    end
end

--- Returns an element's class without creating a instance
--- @shortDescription Returns an element class
--- @param name string The name of the element
--- @return table Element The element class
function basalt.getElementClass(name)
    return elementManager.getElement(name)
end

--- Returns a Plugin API
--- @shortDescription Returns a Plugin API
--- @param name string The name of the plugin
--- @return table Plugin The plugin API
function basalt.getAPI(name)
    return elementManager.getAPI(name)
end

--- Registers a callback function for a specific event
--- @shortDescription Registers an event callback
--- @param eventName string The name of the event to listen for (e.g. "mouse_click", "key", "timer")
--- @param callback function The callback function to execute when the event occurs
--- @usage basalt.onEvent("mouse_click", function(button, x, y) basalt.debug("Clicked at", x, y) end)
function basalt.onEvent(eventName, callback)
    expect(1, eventName, "string")
    expect(2, callback, "function")

    if not basalt._events[eventName] then
        basalt._events[eventName] = {}
    end

    table.insert(basalt._events[eventName], callback)
end

--- Removes a callback function for a specific event
--- @shortDescription Removes an event callback
--- @param eventName string The name of the event
--- @param callback function The callback function to remove
--- @return boolean success Whether the callback was found and removed
function basalt.removeEvent(eventName, callback)
    expect(1, eventName, "string")
    expect(2, callback, "function")

    if not basalt._events[eventName] then
        return false
    end

    for i, registeredCallback in ipairs(basalt._events[eventName]) do
        if registeredCallback == callback then
            table.remove(basalt._events[eventName], i)
            return true
        end
    end

    return false
end

--- Triggers a custom event and calls all registered callbacks
--- @shortDescription Triggers a custom event
--- @param eventName string The name of the event to trigger
--- @vararg any Arguments to pass to the event callbacks
--- @usage basalt.triggerEvent("custom_event", "data1", "data2")
function basalt.triggerEvent(eventName, ...)
    expect(1, eventName, "string")
    if basalt._events[eventName] then
        for _, callback in ipairs(basalt._events[eventName]) do
            local ok, err = pcall(callback, ...)
            if not ok then
                errorManager.header = "Basalt Event Callback Error"
                errorManager.error("Error in event callback for '" .. eventName .. "': " .. tostring(err))
            end
        end
    end
end

--- Requires specific elements and validates they are available
--- @shortDescription Requires elements for the application
--- @param elements table|string List of element names or single element name
--- @param autoLoad? boolean Whether to automatically load missing elements (default: false)
--- @usage basalt.requireElements({"Button", "Label", "Slider"})
--- @usage basalt.requireElements("Button", true)
function basalt.requireElements(elements, autoLoad)
    if type(elements) == "string" then
        elements = {elements}
    end

    expect(1, elements, "table")
    if autoLoad ~= nil then
        expect(2, autoLoad, "boolean")
    end

    local missing = {}
    local notLoaded = {}

    for _, elementName in ipairs(elements) do
        if not elementManager.hasElement(elementName) then
            table.insert(missing, elementName)
        elseif not elementManager.isElementLoaded(elementName) then
            table.insert(notLoaded, elementName)
        end
    end

    if #notLoaded > 0 then
        for _, name in ipairs(notLoaded) do
            local ok, err = pcall(elementManager.loadElement, name)
            if not ok then
                basalt.LOGGER.warn("Failed to load element "..name..": "..tostring(err))
                table.insert(missing, name)
            end
        end
    end

    if #missing > 0 then
        if autoLoad then
            local stillMissing = {}
            for _, name in ipairs(missing) do
                local ok = elementManager.tryAutoLoad(name)
                if not ok then
                    table.insert(stillMissing, name)
                end
            end

            if #stillMissing > 0 then
                local msg = "Missing required elements: " .. table.concat(stillMissing, ", ")
                msg = msg .. "\n\nThese elements could not be auto-loaded."
                msg = msg .. "\nPlease install them or register remote sources."
                errorManager.error(msg)
            end
        else
            local msg = "Missing required elements: " .. table.concat(missing, ", ")
            msg = msg .. "\n\nSuggestions:"
            msg = msg .. "\n  • Use basalt.requireElements({...}, true) to auto-load"
            msg = msg .. "\n  • Register remote sources with elementManager.registerRemoteSource()"
            msg = msg .. "\n  • Register disk mounts with elementManager.registerDiskMount()"
            errorManager.error(msg)
        end
    end

    basalt.LOGGER.info("All required elements are available: " .. table.concat(elements, ", "))
    return true
end

--- Loads a manifest file that describes element requirements and configuration
--- @shortDescription Loads an application manifest
--- @param path string The path to the manifest file
--- @return table manifest The loaded manifest data
--- @usage basalt.loadManifest("myapp.manifest")
function basalt.loadManifest(path)
    expect(1, path, "string")

    if not fs.exists(path) then
        errorManager.error("Manifest file not found: " .. path)
    end

    local manifest
    local ok, result = pcall(dofile, path)
    if not ok then
        errorManager.error("Failed to load manifest: " .. tostring(result))
    end
    manifest = result

    if type(manifest) ~= "table" then
        errorManager.error("Manifest must return a table")
    end

    if manifest.config then
        elementManager.configure(manifest.config)
        basalt.LOGGER.debug("Applied manifest config")
    end

    if manifest.diskMounts then
        for _, mountPath in ipairs(manifest.diskMounts) do
            elementManager.registerDiskMount(mountPath)
        end
    end

    if manifest.remoteSources then
        for elementName, url in pairs(manifest.remoteSources) do
            elementManager.registerRemoteSource(elementName, url)
        end
    end

    if manifest.requiredElements then
        local autoLoad = manifest.autoLoadMissing ~= false
        basalt.requireElements(manifest.requiredElements, autoLoad)
    end

    if manifest.optionalElements then
        for _, name in ipairs(manifest.optionalElements) do
            pcall(elementManager.loadElement, name)
        end
    end

    if manifest.preloadElements then
        elementManager.preloadElements(manifest.preloadElements)
    end

    basalt.LOGGER.info("Manifest loaded successfully: " .. (manifest.name or path))

    return manifest
end

--- Installs an element interactively or from a specified source
--- @shortDescription Installs an element
--- @param elementName string The name of the element to install
--- @param source? string Optional source URL or path
--- @usage basalt.install("Slider")
--- @usage basalt.install("Slider", "https://example.com/slider.lua")
function basalt.install(elementName, source)
    expect(1, elementName, "string")
    if source ~= nil then
        expect(2, source, "string")
    end

    if elementManager.hasElement(elementName) and elementManager.isElementLoaded(elementName) then
        return true
    end

    if source then
        if source:match("^https?://") then
            elementManager.registerRemoteSource(elementName, source)
        else
            if not fs.exists(source) then
                errorManager.error("Source file not found: " .. source)
            end
        end
    end

    local ok = elementManager.tryAutoLoad(elementName)
    if ok then
        return true
    else
        return false
    end
end

--- Configures the ElementManager (shortcut to elementManager.configure)
--- @shortDescription Configures element loading behavior
--- @param config table Configuration options
--- @usage basalt.configure({allowRemoteLoading = true, useGlobalCache = true})
function basalt.configure(config)
    expect(1, config, "table")
    elementManager.configure(config)
end

return basalt
local PropertySystem = require("propertySystem")
local uuid = require("libraries/utils").uuid
local errorManager = require("errorManager")
---@configDescription The base class for all UI elements in Basalt.

--- The base class for all UI elements in Basalt. This class provides basic properties and event handling functionality.
--- @class BaseElement : PropertySystem
local BaseElement = setmetatable({}, PropertySystem)
BaseElement.__index = BaseElement

--- @property type string BaseElement The type identifier of the element
BaseElement.defineProperty(BaseElement, "type", {default = {"BaseElement"}, type = "string", setter=function(self, value)
    if type(value) == "string" then
        table.insert(self._values.type, 1, value)
        return self._values.type
    end
    return value
end, getter = function(self, _, index)
    if index~= nil and index < 1 then
        return self._values.type
    end
    return self._values.type[index or 1]
end})

--- @property id string BaseElement The unique identifier for the element
BaseElement.defineProperty(BaseElement, "id", {default = "", type = "string", readonly = true})

--- @property name string BaseElement The name of the element
BaseElement.defineProperty(BaseElement, "name", {default = "", type = "string"})

--- @property eventCallbacks table BaseElement The event callbacks for the element
BaseElement.defineProperty(BaseElement, "eventCallbacks", {default = {}, type = "table"})

--- Registers a new event listener for the element (on class level)
--- @shortDescription Registers a new event listener for the element (on class level)
--- @param class table The class to register
--- @param eventName string The name of the event to register
--- @param requiredEvent? string The name of the required event (optional)
function BaseElement.defineEvent(class, eventName, requiredEvent)
    if not rawget(class, '_eventConfigs') then
        class._eventConfigs = {}
    end

    class._eventConfigs[eventName] = {
        requires = requiredEvent and requiredEvent or eventName
    }
end

--- Registers a new event callback for the element (on class level)
--- @shortDescription Registers a new event callback for the element (on class level)
--- @param class table The class to register
--- @param callbackName string The name of the callback to register
--- @param ... string The names of the events to register the callback for
function BaseElement.registerEventCallback(class, callbackName, ...)
    local methodName = callbackName:match("^on") and callbackName or "on"..callbackName
    local events = {...}
    local mainEvent = events[1]

    class[methodName] = function(self, ...)
        for _, sysEvent in ipairs(events) do
            if not self._registeredEvents[sysEvent] then
                self:listenEvent(sysEvent, true)
            end
        end
        self:registerCallback(mainEvent, ...)
        return self
    end
end

--- @shortDescription Creates a new BaseElement instance
--- @return table The newly created BaseElement instance
--- @private
function BaseElement.new()
    local self = setmetatable({}, BaseElement):__init()
    self.class = BaseElement
    return self
end

--- @shortDescription Initializes the BaseElement instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return table self The initialized instance
--- @protected
function BaseElement:init(props, basalt)
    if self._initialized then
        return self
    end
    self._initialized = true
    self._props = props
    self._values.id = uuid()
    self.basalt = basalt
    self._registeredEvents = {}

    local currentClass = getmetatable(self).__index

    local events = {}
    currentClass = self.class

    while currentClass do
        if type(currentClass) == "table" and currentClass._eventConfigs then
            for eventName, config in pairs(currentClass._eventConfigs) do
                if not events[eventName] then
                    events[eventName] = config
                end
            end
        end
        currentClass = getmetatable(currentClass) and getmetatable(currentClass).__index
    end

    for eventName, config in pairs(events) do
        self._registeredEvents[config.requires] = true
    end

    if self._callbacks then
        for eventName, methodName in pairs(self._callbacks) do
            self[methodName] = function(self, ...)
                self:registerCallback(eventName, ...)
                return self
            end
        end
    end 

    return self
end

--- @shortDescription Post initialization
--- @return table self The BaseElement instance
--- @protected
function BaseElement:postInit()
    if self._postInitialized then
        return self
    end
    self._postInitialized = true
    if(self._props)then
        for k,v in pairs(self._props)do
            self.set(k, v)
        end
    end
    self._props = nil
    return self
end

--- Checks if the element is a specific type
--- @shortDescription Checks if the element is a specific type
--- @param type string The type to check for
--- @return boolean isType Whether the element is of the specified type
function BaseElement:isType(type)
    for _, t in ipairs(self._values.type) do
        if t == type then
            return true
        end
    end
    return false
end

--- Enables or disables event listening for a specific event
--- @shortDescription Enables or disables event listening for a specific event
--- @param eventName string The name of the event to listen for
--- @param enable? boolean Whether to enable or disable the event (default: true)
--- @return table self The BaseElement instance
function BaseElement:listenEvent(eventName, enable)
    enable = enable ~= false
    if enable ~= (self._registeredEvents[eventName] or false) then
        if enable then
            self._registeredEvents[eventName] = true
            if self.parent then
                self.parent:registerChildEvent(self, eventName)
            end
        else
            self._registeredEvents[eventName] = nil
            if self.parent then
                self.parent:unregisterChildEvent(self, eventName)
            end
        end
    end
    return self
end

--- Registers a callback function for an event
--- @shortDescription Registers a callback function
--- @param event string The event to register the callback for
--- @param callback function The callback function to register
--- @return table self The BaseElement instance
function BaseElement:registerCallback(event, callback)
    if not self._registeredEvents[event] then
        self:listenEvent(event, true)
    end

    if not self._values.eventCallbacks[event] then
        self._values.eventCallbacks[event] = {}
    end

    table.insert(self._values.eventCallbacks[event], callback)
    return self
end

--- Triggers an event and calls all registered callbacks
--- @shortDescription Triggers an event and calls all registered callbacks
--- @param event string The event to fire
--- @param ... any Additional arguments to pass to the callbacks
--- @return table self The BaseElement instance
function BaseElement:fireEvent(event, ...)
    if self.get("eventCallbacks")[event] then
        for _, callback in ipairs(self.get("eventCallbacks")[event]) do
            local result = callback(self, ...)
            return result
        end
    end
    return self
end

--- @shortDescription Handles all events
--- @param event string The event to handle
--- @vararg any The arguments for the event
--- @return boolean? handled Whether the event was handled
--- @protected
function BaseElement:dispatchEvent(event, ...)
    if self[event] then
        return self[event](self, ...)
    end
    return self:handleEvent(event, ...)
end

--- @shortDescription The default event handler for all events
--- @param event string The event to handle
--- @vararg any The arguments for the event
--- @return boolean? handled Whether the event was handled
--- @protected
function BaseElement:handleEvent(event, ...)
    return false
end

--- Observes a property and calls a callback when it changes
--- @shortDescription Observes a property and calls a callback when it changes
--- @param property string The property to observe
--- @param callback function The callback to call when the property changes
--- @return table self The BaseElement instance
function BaseElement:onChange(property, callback)
    self:observe(property, callback)
    return self
end

--- Returns the base frame of the element
--- @shortDescription Returns the base frame of the element
--- @return BaseFrame BaseFrame The base frame of the element
function BaseElement:getBaseFrame()
    if self.parent then
        return self.parent:getBaseFrame()
    end
    return self
end

--- Destroys the element and cleans up all references
--- @shortDescription Destroys the element and cleans up all references
function BaseElement:destroy()
    self._destroyed = true
    self:removeAllObservers()
    self:setFocused(false)
    for event in pairs(self._registeredEvents) do
        self:listenEvent(event, false)
    end
    if(self.parent) then
        self.parent:removeChild(self)
    end
end

--- Requests a render update for this element
--- @shortDescription Requests a render update for this element
--- @return table self The BaseElement instance
function BaseElement:updateRender()
    if(self.parent) then
        self.parent:updateRender()
    else
        self._renderUpdate = true
    end
    return self
end

return BaseElement
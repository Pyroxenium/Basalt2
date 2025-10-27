local PropertySystem = require("propertySystem")
local uuid = require("libraries/utils").uuid
local errorManager = require("errorManager")
---@configDescription The base class for all UI elements in Basalt.

--- The fundamental base class for all UI elements in Basalt. It implements core functionality like event handling, property management, lifecycle hooks, and the observer pattern. Every UI component inherits from this class to ensure consistent behavior and interface.
--- @class BaseElement : PropertySystem
local BaseElement = setmetatable({}, PropertySystem)
BaseElement.__index = BaseElement

--- @property type string BaseElement A hierarchical identifier of the element's type chain
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

--- @property id string BaseElement Auto-generated unique identifier for element lookup
BaseElement.defineProperty(BaseElement, "id", {default = "", type = "string", readonly = true})

--- @property name string BaseElement User-defined name for the element
BaseElement.defineProperty(BaseElement, "name", {default = "", type = "string"})

--- @property eventCallbacks table BaseElement Collection of registered event handler functions
BaseElement.defineProperty(BaseElement, "eventCallbacks", {default = {}, type = "table"})

--- @property enabled boolean BaseElement Controls event processing for this element
BaseElement.defineProperty(BaseElement, "enabled", {default = true, type = "boolean" })

--- @property states table {} Table of currently active states with their priorities
BaseElement.defineProperty(BaseElement, "states", {
    default = {},
    type = "table",
    canTriggerRender = true
})

--- Registers a class-level event listener with optional dependency
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

--- Defines a class-level event callback method with automatic event registration
--- @shortDescription Registers a new event callback method with auto-registration
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
    self._registeredStates = {}

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

--- Checks if the element matches or inherits from the specified type
--- @shortDescription Tests if element is of or inherits given type
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

--- Configures event listening behavior with automatic parent notification
--- @shortDescription Enables/disables event handling for this element
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

--- Adds an event handler function with automatic event registration
--- @shortDescription Registers a function to handle specific events
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

--- Registers a new state with optional auto-condition
--- @shortDescription Registers a state
--- @param stateName string The name of the state
--- @param condition? function Optional: Function that returns true if state is active: function(element) return boolean end
--- @param priority? number Priority (higher = more important, default: 0)
--- @return BaseElement self The BaseElement instance
function BaseElement:registerState(stateName, condition, priority)
    self._registeredStates[stateName] = {
        condition = condition,
        priority = priority or 0
    }
    return self
end

--- Manually activates a state
--- @shortDescription Activates a state
--- @param stateName string The state to activate
--- @param priority? number Optional priority override
--- @return BaseElement self
function BaseElement:setState(stateName, priority)
    local states = self.get("states")

    if not priority and self._registeredStates[stateName] then
        priority = self._registeredStates[stateName].priority
    end

    states[stateName] = priority or 0
    self.set("states", states)
    return self
end

--- Manually deactivates a state
--- @shortDescription Deactivates a state
--- @param stateName string The state to deactivate
--- @return BaseElement self
function BaseElement:unsetState(stateName)
    local states = self.get("states")
    if states[stateName] ~= nil then
        states[stateName] = nil
        self.set("states", states)
    end
    return self
end

--- Checks if a state is currently active
--- @shortDescription Checks if state is active
--- @param stateName string The state to check
--- @return boolean isActive
function BaseElement:hasState(stateName)
    local states = self.get("states")
    return states[stateName] ~= nil
end

--- Gets the highest priority active state
--- @shortDescription Gets current primary state
--- @return string|nil currentState The state with highest priority
function BaseElement:getCurrentState()
    local states = self.get("states")

    local highestPriority = -math.huge
    local currentState = nil

    for stateName, priority in pairs(states) do
        if priority > highestPriority then
            highestPriority = priority
            currentState = stateName
        end
    end

    return currentState
end

--- Gets all currently active states sorted by priority
--- @shortDescription Gets all active states
--- @return table states Array of {name, priority} sorted by priority
function BaseElement:getActiveStates()
    local states = self.get("states")
    local result = {}
    
    for stateName, priority in pairs(states) do
        table.insert(result, {name = stateName, priority = priority})
    end
    
    table.sort(result, function(a, b) return a.priority > b.priority end)
    
    return result
end

--- Updates all states that have auto-conditions
--- @shortDescription Updates conditional states
--- @return BaseElement self
function BaseElement:updateConditionalStates()
    for stateName, stateInfo in pairs(self._registeredStates) do
        if stateInfo.condition then
            if stateInfo.condition(self) then
                self:setState(stateName, stateInfo.priority)
            else
                self:unsetState(stateName)
            end
        end
    end
    return self
end

--- Removes a state from the registry
--- @shortDescription Removes state definition
--- @param stateName string The state to remove
--- @return BaseElement self
function BaseElement:unregisterState(stateName)
    self._stateRegistry[stateName] = nil
    self:unsetState(stateName)
    return self
end

--- Executes all registered callbacks for the specified event
--- @shortDescription Triggers event callbacks with provided arguments
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
    if self.get("enabled") == false then
        return false
    end
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

--- Sets up a property change observer with immediate callback registration
--- @shortDescription Watches property changes with callback notification
--- @param property string The property to observe
--- @param callback function The callback to call when the property changes
--- @return table self The BaseElement instance
function BaseElement:onChange(property, callback)
    self:observe(property, callback)
    return self
end

--- Traverses parent chain to locate the root frame element
--- @shortDescription Retrieves the root frame of this element's tree
--- @return BaseFrame BaseFrame The base frame of the element
function BaseElement:getBaseFrame()
    if self.parent then
        return self.parent:getBaseFrame()
    end
    return self
end

--- Removes the element from UI tree and cleans up resources
--- @shortDescription Removes element and performs cleanup
function BaseElement:destroy()
    if(self.parent) then
        self.parent:removeChild(self)
    end
    self._destroyed = true
    self:removeAllObservers()
    self:setFocused(false)
end

--- Propagates render request up the element tree
--- @shortDescription Requests UI update for this element
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
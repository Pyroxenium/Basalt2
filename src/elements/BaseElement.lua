local PropertySystem = require("propertySystem")

--- The base class for all UI elements in Basalt
-- @module BaseElement
local BaseElement = setmetatable({}, PropertySystem)
BaseElement.__index = BaseElement
BaseElement._events = {}

--- @property type string BaseElement The type identifier of the element
BaseElement.defineProperty(BaseElement, "type", {default = "BaseElement", type = "string"})

--- @property eventCallbacks table {} Table containing all registered event callbacks
BaseElement.defineProperty(BaseElement, "eventCallbacks", {default = {}, type = "table"})

--- Creates a new BaseElement instance
--- @param id string The unique identifier for this element
--- @param basalt table The basalt instance
--- @return table The newly created BaseElement instance
--- @usage local element = BaseElement.new("myId", basalt)
function BaseElement.new(id, basalt)
    local self = setmetatable({}, BaseElement):__init()
    self:init(id, basalt)
    self.set("type", "BaseElement")
    return self
end

--- Initializes the BaseElement instance
--- @param id string The unique identifier for this element
--- @param basalt table The basalt instance
--- @return table self The initialized instance
function BaseElement:init(id, basalt)
    self.id = id
    self.basalt = basalt
    self._registeredEvents = {}
    if BaseElement._events then
        for event in pairs(BaseElement._events) do
            self._registeredEvents[event] = true
            local handlerName = "on" .. event:gsub("_(%l)", function(c)
                return c:upper()
            end):gsub("^%l", string.upper)
            self[handlerName] = function(self, ...)
                self:registerCallback(event, ...)
            end
        end
    end
    return self
end

--- Registers an event that this class can listen to
--- @param class table The class to add the event to
--- @param eventName string The name of the event to register
--- @usage BaseElement.listenTo(MyClass, "mouse_click")
function BaseElement.listenTo(class, eventName)
    if not class._events then
        class._events = {}
    end
    class._events[eventName] = true
end

--- Enables or disables event listening for a specific event
--- @param eventName string The name of the event to listen for
--- @param enable? boolean Whether to enable or disable the event (default: true)
--- @return table self The BaseElement instance
--- @usage element:listenEvent("mouse_click", true)
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
--- @param event string The event to register the callback for
--- @param callback function The callback function to register
--- @return table self The BaseElement instance
--- @usage element:registerCallback("mouse_click", function(self, ...) end)
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
--- @param event string The event to fire
--- @param ... any Additional arguments to pass to the callbacks
--- @return table self The BaseElement instance
--- @usage element:fireEvent("mouse_click", 1, 2)
function BaseElement:fireEvent(event, ...)
    if self._values.eventCallbacks[event] then
        for _, callback in ipairs(self._values.eventCallbacks[event]) do
            local result = callback(self, ...)
            return result
        end
    end
    return self
end

--- Requests a render update for this element
--- @usage element:updateRender()
function BaseElement:updateRender()
    if(self.parent) then
        self.parent:updateRender()
    else
        self._renderUpdate = true
    end
end

return BaseElement
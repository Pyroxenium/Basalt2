local PropertySystem = require("propertySystem") -- muss geändert werden.

local BaseElement = setmetatable({}, PropertySystem)
BaseElement.__index = BaseElement
BaseElement._events = {}

BaseElement.defineProperty(BaseElement, "type", {default = "BaseElement", type = "string"})
BaseElement.defineProperty(BaseElement, "eventCallbacks", {default = {}, type = "table"})

function BaseElement.new(id, basalt)
    local self = setmetatable({}, BaseElement):__init()
    self:init(id, basalt)
    self.set("type", "BaseElement")
    return self
end

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

function BaseElement.listenTo(class, eventName)
    if not class._events then
        class._events = {}
    end
    class._events[eventName] = true
end

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

function BaseElement:fireEvent(event, ...)
    if self._values.eventCallbacks[event] then
        for _, callback in ipairs(self._values.eventCallbacks[event]) do
            local result = callback(self, ...)
            return result
        end
    end
    return self
end

function BaseElement:updateRender()
    if(self.parent) then
        self.parent:updateRender()
    else
        self._renderUpdate = true
    end
end

return BaseElement
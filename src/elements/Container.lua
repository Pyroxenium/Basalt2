local VisualElement = require("elements/VisualElement")
local elementManager = require("elementManager")
local expect = require("libraries/expect")

local max = math.max

local Container = setmetatable({}, VisualElement)
Container.__index = Container

Container.defineProperty(Container, "children", {default = {}, type = "table"})
Container.defineProperty(Container, "childrenEvents", {default = {}, type = "table"})
Container.defineProperty(Container, "eventListenerCount", {default = {}, type = "table"})

for k, _ in pairs(elementManager:getElementList()) do
    local capitalizedName = k:sub(1,1):upper() .. k:sub(2)
    --if not capitalizedName == "BaseFrame" then
        Container["add"..capitalizedName] = function(self, ...)
            expect(1, self, "table")
            local element = self.basalt.create(k, ...)
            self.basalt.LOGGER.debug(capitalizedName.." created with ID: " .. element.id)
            self:addChild(element)
            return element
        end
    --end
end

---@diagnostic disable-next-line: duplicate-set-field
function Container.new(id, basalt)
    local self = setmetatable({}, Container):__init()
    self:init(id, basalt)
    self.set("type", "Container")
    return self
end

function Container:addChild(child)
    if child == self then
        error("Cannot add container to itself")
    end

    local childZ = child.get("z")
    local pos = 1
    for i, existing in ipairs(self._values.children) do
        if existing.get("z") > childZ then
            break
        end
        pos = i + 1
    end

    table.insert(self._values.children, pos, child)
    child.parent = self
    self:registerChildrenEvents(child)
    return self
end

function Container:sortChildren()
    table.sort(self._values.children, function(a, b)
        return a.get("z") < b.get("z")
    end)
end

function Container:sortChildrenEvents(eventName)
    if self._values.childrenEvents[eventName] then
        table.sort(self._values.childrenEvents[eventName], function(a, b)
            return a.get("z") > b.get("z")
        end)
    end
end

function Container:registerChildrenEvents(child)
    for event in pairs(child._registeredEvents) do
        self:registerChildEvent(child, event)
    end
end

function Container:registerChildEvent(child, eventName)
    if not self._values.childrenEvents[eventName] then
        self._values.childrenEvents[eventName] = {}
        self._values.eventListenerCount[eventName] = 0

        if self.parent then
            self.parent:registerChildEvent(self, eventName)
        end
    end

    for _, registeredChild in ipairs(self._values.childrenEvents[eventName]) do
        if registeredChild == child then
            return
        end
    end

    local childZ = child.get("z")
    local pos = 1
    for i, existing in ipairs(self._values.childrenEvents[eventName]) do
        if existing.get("z") < childZ then
            break
        end
        pos = i + 1
    end

    table.insert(self._values.childrenEvents[eventName], pos, child)
    self._values.eventListenerCount[eventName] = self._values.eventListenerCount[eventName] + 1
end

function Container:removeChildrenEvents(child)
    for event in pairs(child._registeredEvents) do
        self:unregisterChildEvent(child, event)
    end
end

function Container:unregisterChildEvent(child, eventName)
    if self._values.childrenEvents[eventName] then
        for i, listener in ipairs(self._values.childrenEvents[eventName]) do
            if listener == child then
                table.remove(self._values.childrenEvents[eventName], i)
                self._values.eventListenerCount[eventName] = self._values.eventListenerCount[eventName] - 1

                if self._values.eventListenerCount[eventName] <= 0 then
                    self._values.childrenEvents[eventName] = nil
                    self._values.eventListenerCount[eventName] = nil

                    if self.parent then
                        self.parent:unregisterChildEvent(self, eventName)
                    end
                end
                break
            end
        end
    end
end

function Container:removeChild(child)
    for i,v in ipairs(self.children) do
        if v == child then
            table.remove(self._values.children, i)
            child.parent = nil
            break
        end
    end
    return self
end

function Container:handleEvent(event, ...)
    if(VisualElement.handleEvent(self, event, ...))then
        local args = {...}
        if event:find("mouse_") then
            local button, absX, absY = ...
            local relX, relY = self:getRelativePosition(absX, absY)
            args = {button, relX, relY}
        end
        if self._values.childrenEvents[event] then
            for _, child in ipairs(self._values.childrenEvents[event]) do
                if(child:handleEvent(event, table.unpack(args)))then
                    return true
                end
            end
        end
    end
end

--[[function Container:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        if self._values.childrenEvents.mouse_click then
            for _, child in ipairs(self._values.childrenEvents.mouse_click) do
                if child:mouse_click(button, x, y) then
                    return true
                end
            end
        end
    end
end]]

function Container:multiBlit(x, y, width, height, text, fg, bg)
    local w, h = self.get("width"), self.get("height")

    width = x < 1 and math.min(width + x - 1, w) or math.min(width, math.max(0, w - x + 1))
    height = y < 1 and math.min(height + y - 1, h) or math.min(height, math.max(0, h - y + 1))

    if width <= 0 or height <= 0 then return end

    VisualElement.multiBlit(self, math.max(1, x), math.max(1, y), width, height, text, fg, bg)
end

function Container:textFg(x, y, text, fg)
    local w, h = self.get("width"), self.get("height")

    if y < 1 or y > h then return end

    local textStart = x < 1 and (2 - x) or 1
    local textLen = math.min(#text - textStart + 1, w - math.max(1, x) + 1)

    if textLen <= 0 then return end

    VisualElement.textFg(self, math.max(1, x), math.max(1, y), text:sub(textStart, textStart + textLen - 1), fg)
end

---@diagnostic disable-next-line: duplicate-set-field
function Container:render()
    VisualElement.render(self)
    for _, child in ipairs(self._values.children) do
        if child == self then
            self.basalt.LOGGER.error("CIRCULAR REFERENCE DETECTED!")
            return
        end
        child:render()
    end
end

return Container
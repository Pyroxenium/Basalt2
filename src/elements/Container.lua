local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local expect = require("libraries/expect")
local split = require("libraries/utils").split

local max = math.max

---@class Container : VisualElement
local Container = setmetatable({}, VisualElement)
Container.__index = Container

Container.defineProperty(Container, "children", {default = {}, type = "table"})
Container.defineProperty(Container, "childrenSorted", {default = true, type = "boolean"})
Container.defineProperty(Container, "childrenEventsSorted", {default = true, type = "boolean"})
Container.defineProperty(Container, "childrenEvents", {default = {}, type = "table"})
Container.defineProperty(Container, "eventListenerCount", {default = {}, type = "table"})
Container.defineProperty(Container, "focusedChild", {default = nil, type = "table", setter = function(self, value, internal)
    local oldChild = self._values.focusedChild

    if value == oldChild then return value end

    if oldChild then
        if oldChild:isType("Container") then
            oldChild.set("focusedChild", nil, true)
        end
        oldChild.set("focused", false, true)
    end

    if value and not internal then
        value.set("focused", true, true)
        if self.parent then
            self.parent:setFocusedChild(self)
        end
    end

    return value
end})

Container.defineProperty(Container, "visibleChildren", {default = {}, type = "table"})
Container.defineProperty(Container, "visibleChildrenEvents", {default = {}, type = "table"})

function Container:isChildVisible(child)
    local childX, childY = child.get("x"), child.get("y")
    local childW, childH = child.get("width"), child.get("height")
    local containerW, containerH = self.get("width"), self.get("height")

    return childX <= containerW and 
           childY <= containerH and 
           childX + childW > 0 and 
           childY + childH > 0
end

for k, _ in pairs(elementManager:getElementList()) do
    local capitalizedName = k:sub(1,1):upper() .. k:sub(2)
    if capitalizedName ~= "BaseFrame" then
        Container["add"..capitalizedName] = function(self, ...)
            expect(1, self, "table")
            local element = self.basalt.create(k, ...)
            self:addChild(element)
            return element
        end
        Container["addDelayed"..capitalizedName] = function(self, prop)
            expect(1, self, "table")
            local element = self.basalt.create(k, prop, true, self)
            return element
        end
    end
end

function Container.new(props, basalt)
    local self = setmetatable({}, Container):__init()
    self:init(props, basalt)
    return self
end

function Container:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Container")
end

function Container:addChild(child)
    if child == self then
        error("Cannot add container to itself")
    end

    table.insert(self._values.children, child)
    child.parent = self
    self.set("childrenSorted", false)
    self:registerChildrenEvents(child)
    return self
end

local function sortAndFilterChildren(self, children)
    local visibleChildren = {}
    
    for _, child in ipairs(children) do
        if self:isChildVisible(child) then
            table.insert(visibleChildren, child)
        end
    end

    for i = 2, #visibleChildren do
        local current = visibleChildren[i]
        local currentZ = current.get("z")
        local j = i - 1

        while j > 0 do
            local compare = visibleChildren[j].get("z")
            if compare > currentZ then
                visibleChildren[j + 1] = visibleChildren[j]
                j = j - 1
            else
                break
            end
        end
        visibleChildren[j + 1] = current
    end

    return visibleChildren
end

function Container:sortChildren()
    self.set("visibleChildren", sortAndFilterChildren(self, self._values.children))
    self.set("childrenSorted", true)
end

function Container:sortChildrenEvents(eventName)
    if self._values.childrenEvents[eventName] then
        self._values.visibleChildrenEvents[eventName] = sortAndFilterChildren(self, self._values.childrenEvents[eventName])
    end
    self.set("childrenEventsSorted", true)
end

function Container:registerChildrenEvents(child)
    if(child._registeredEvents == nil)then return end
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

    self.set("childrenEventsSorted", false)
    table.insert(self._values.childrenEvents[eventName], child)
    self._values.eventListenerCount[eventName] = self._values.eventListenerCount[eventName] + 1
end

function Container:removeChildrenEvents(child)
    if(child._registeredEvents == nil)then return end
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
    for i,v in ipairs(self._values.children) do
        if v == child then
            table.remove(self._values.children, i)
            child.parent = nil
            break
        end
    end
    self:removeChildrenEvents(child)
    return self
end

function Container:getChild(path)
    if type(path) == "string" then
        local parts = split(path, "/")
        for _,v in pairs(self._values.children) do
            if v.get("name") == parts[1] then
                if #parts == 1 then
                    return v
                else
                    if(v:isType("Container"))then
                        return v:find(table.concat(parts, "/", 2))
                    end
                end
            end
        end
    end
    return nil
end

local function convertMousePosition(self, event, ...)
    local args = {...}
    if event:find("mouse_") then
        local button, absX, absY = ...
        local relX, relY = self:getRelativePosition(absX, absY)
        args = {button, relX, relY}
    end
    return args
end

local function callChildrenEvents(self, visibleOnly, event, ...)
    local children = visibleOnly and self.get("visibleChildrenEvents") or self.get("childrenEvents")
    if children[event] then
        local events = children[event]
        for i = #events, 1, -1 do
            local child = events[i]
            if(child:dispatchEvent(event, ...))then
                return true, child
            end
        end
    end
    return false
end

function Container:handleEvent(event, ...)
    if(VisualElement.handleEvent(self, event, ...))then
        local args = convertMousePosition(self, event, ...)
        return callChildrenEvents(self, false, event, table.unpack(args))
    end
end

function Container:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        local args = convertMousePosition(self, "mouse_click", button, x, y)
        local success, child = callChildrenEvents(self, true, "mouse_click", table.unpack(args))
        if(success)then
            self.set("focusedChild", child)
            return true
        end
        self.set("focusedChild", nil)
    end
end

function Container:key(key)
    if self.get("focusedChild") then
        return self.get("focusedChild"):dispatchEvent("key", key)
    end
    return true
end

function Container:char(char)
    if self.get("focusedChild") then
        return self.get("focusedChild"):dispatchEvent("char", char)
    end
    return true
end

function Container:key_up(key)
    if self.get("focusedChild") then
        return self.get("focusedChild"):dispatchEvent("key_up", key)
    end
    return true
end

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

function Container:blit(x, y, text, fg, bg)
    local w, h = self.get("width"), self.get("height")

    if y < 1 or y > h then return end

    local textStart = x < 1 and (2 - x) or 1
    local textLen = math.min(#text - textStart + 1, w - math.max(1, x) + 1)
    local fgLen = math.min(#fg - textStart + 1, w - math.max(1, x) + 1)
    local bgLen = math.min(#bg - textStart + 1, w - math.max(1, x) + 1)

    if textLen <= 0 then return end

    local finalText = text:sub(textStart, textStart + textLen - 1)
    local finalFg = fg:sub(textStart, textStart + fgLen - 1)
    local finalBg = bg:sub(textStart, textStart + bgLen - 1)

    VisualElement.blit(self, math.max(1, x), math.max(1, y), finalText, finalFg, finalBg)
end

function Container:render()
    VisualElement.render(self)
    if not self.get("childrenSorted")then
        self:sortChildren()
    end
    if not self.get("childrenEventsSorted")then
        for event in pairs(self._values.childrenEvents) do
            self:sortChildrenEvents(event)
        end
    end
    for _, child in ipairs(self.get("visibleChildren")) do
        if child == self then
            self.basalt.LOGGER.error("CIRCULAR REFERENCE DETECTED!")
            return
        end
        child:render()
    end
end

return Container
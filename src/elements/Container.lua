local elementManager = require("elementManager")
local errorManager = require("errorManager")
local VisualElement = elementManager.getElement("VisualElement")
local expect = require("libraries/expect")
local split = require("libraries/utils").split
---@configDescription The container class. It is a visual element that can contain other elements. It is the base class for all containers
---@configDefault true

--- The Container class serves as a fundamental building block for organizing UI elements. It acts as a parent element that can hold and manage child elements.
--- @usage local container = basalt.getMainFrame()
--- @usage container:addButton()  -- Add a child element
---@class Container : VisualElement
local Container = setmetatable({}, VisualElement)
Container.__index = Container

---@property children table {} The children of the container
Container.defineProperty(Container, "children", {default = {}, type = "table"})
---@property childrenSorted boolean true Whether the children are sorted
Container.defineProperty(Container, "childrenSorted", {default = true, type = "boolean"})
---@property childrenEventsSorted boolean true Whether the children events are sorted
Container.defineProperty(Container, "childrenEventsSorted", {default = true, type = "boolean"})
---@property childrenEvents table {} The children events of the container
Container.defineProperty(Container, "childrenEvents", {default = {}, type = "table"})
---@property eventListenerCount table {} The event listener count of the container
Container.defineProperty(Container, "eventListenerCount", {default = {}, type = "table"})
---@property focusedChild table nil The focused child of the container
Container.defineProperty(Container, "focusedChild", {default = nil, type = "table", allowNil=true, setter = function(self, value, internal)
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

---@property visibleChildren table {} The visible children of the container
Container.defineProperty(Container, "visibleChildren", {default = {}, type = "table"})
---@property visibleChildrenEvents table {} The visible children events of the container
Container.defineProperty(Container, "visibleChildrenEvents", {default = {}, type = "table"})

---@property offsetX number 0 Horizontal content offset
Container.defineProperty(Container, "offsetX", {default = 0, type = "number", canTriggerRender = true, setter=function(self, value)
    self.set("childrenSorted", false)
    self.set("childrenEventsSorted", false)
    return value
end})
---@property offsetY number 0 Vertical content offset
Container.defineProperty(Container, "offsetY", {default = 0, type = "number", canTriggerRender = true, setter=function(self, value)
    self.set("childrenSorted", false)
    self.set("childrenEventsSorted", false)
    return value
end})

---@combinedProperty offset {offsetX number, offsetY number} Combined property for offsetX and offsetY
Container.combineProperties(Container, "offset", "offsetX", "offsetY")

for k, _ in pairs(elementManager:getElementList()) do
    local capitalizedName = k:sub(1,1):upper() .. k:sub(2)
    if capitalizedName ~= "BaseFrame" then
        Container["add"..capitalizedName] = function(self, ...)
            expect(1, self, "table")
            local element = self.basalt.create(k, ...)
            self:addChild(element)
            element:postInit()
            return element
        end
        Container["addDelayed"..capitalizedName] = function(self, prop)
            expect(1, self, "table")
            local element = self.basalt.create(k, prop, true, self)
            return element
        end
    end
end

--- Creates a new Container instance
--- @shortDescription Creates a new Container instance
--- @return Container self The new container instance
--- @private
function Container.new()
    local self = setmetatable({}, Container):__init()
    self.class = Container
    return self
end

--- @shortDescription Initializes the Container instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @protected
function Container:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Container")
end

--- Returns whether a child is visible
--- @shortDescription Returns whether a child is visible
--- @param child table The child to check
--- @return boolean boolean the child is visible
function Container:isChildVisible(child)
    if not child:isType("VisualElement") then return false end
    if(child.get("visible") == false)then return false end
    if(child._destroyed)then return false end
    local containerW, containerH = self.get("width"), self.get("height")
    local offsetX, offsetY = self.get("offsetX"), self.get("offsetY")

    local childX, childY = child.get("x"), child.get("y")
    local childW, childH = child.get("width"), child.get("height")

    local relativeX
    local relativeY
    if(child.get("ignoreOffset"))then
        relativeX = childX
        relativeY = childY
    else
        relativeX = childX - offsetX
        relativeY = childY - offsetY
    end

    return (relativeX + childW > 0) and
           (relativeX <= containerW) and
           (relativeY + childH > 0) and
           (relativeY <= containerH)
end

--- Adds a child to the container
--- @shortDescription Adds a child to the container
--- @param child table The child to add
--- @return Container self The container instance
function Container:addChild(child)
    if child == self then
        error("Cannot add container to itself")
    end
    if(child ~= nil)then
        table.insert(self._values.children, child)
        child.parent = self
        child:postInit()
        self.set("childrenSorted", false)
        self:registerChildrenEvents(child)
    end
    return self
end

local function sortAndFilterChildren(self, children)
    local visibleChildren = {}

    for _, child in ipairs(children) do
        if self:isChildVisible(child) and child.get("visible") then
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

--- Clears the container
--- @shortDescription Clears the container
--- @return Container self The container instance
function Container:clear()
    self.set("children", {})
    self.set("childrenEvents", {})
    self.set("visibleChildren", {})
    self.set("visibleChildrenEvents", {})
    self.set("childrenSorted", true)
    self.set("childrenEventsSorted", true)
    return self
end

--- Sorts the children of the container
--- @shortDescription Sorts the children of the container
--- @return Container self The container instance
function Container:sortChildren()
    self.set("visibleChildren", sortAndFilterChildren(self, self._values.children))
    self.set("childrenSorted", true)
    return self
end

--- Sorts the children events of the container
--- @shortDescription Sorts the children events of the container
--- @param eventName string The event name to sort
--- @return Container self The container instance
function Container:sortChildrenEvents(eventName)
    if self._values.childrenEvents[eventName] then
        self._values.visibleChildrenEvents[eventName] = sortAndFilterChildren(self, self._values.childrenEvents[eventName])
    end
    self.set("childrenEventsSorted", true)
    return self
end

--- Registers the children events of the container
--- @shortDescription Registers the children events of the container
--- @param child table The child to register events for
--- @return Container self The container instance
function Container:registerChildrenEvents(child)
    if(child._registeredEvents == nil)then return end
    for event in pairs(child._registeredEvents) do
        self:registerChildEvent(child, event)
    end
    return self
end

--- Registers the children events of the container
--- @shortDescription Registers the children events of the container
--- @param child table The child to register events for
--- @param eventName string The event name to register
--- @return Container self The container instance
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
            return self
        end
    end

    self.set("childrenEventsSorted", false)
    table.insert(self._values.childrenEvents[eventName], child)
    self._values.eventListenerCount[eventName] = self._values.eventListenerCount[eventName] + 1
    return self
end

--- Unregisters the children events of the container
--- @shortDescription Unregisters the children events of the container
--- @param child table The child to unregister events for
--- @return Container self The container instance
function Container:removeChildrenEvents(child)
    if child ~= nil then
        if(child._registeredEvents == nil)then return self end
        for event in pairs(child._registeredEvents) do
            self:unregisterChildEvent(child, event)
        end
    end
    return self
end

--- Unregisters the children events of the container
--- @shortDescription Unregisters the children events of the container
--- @param child table The child to unregister events for
--- @param eventName string The event name to unregister
--- @return Container self The container instance
function Container:unregisterChildEvent(child, eventName)
    if self._values.childrenEvents[eventName] then
        for i, listener in ipairs(self._values.childrenEvents[eventName]) do
            if listener.get("id") == child.get("id") then
                table.remove(self._values.childrenEvents[eventName], i)
                self._values.eventListenerCount[eventName] = self._values.eventListenerCount[eventName] - 1

                if self._values.eventListenerCount[eventName] <= 0 then
                    self._values.childrenEvents[eventName] = nil
                    self._values.eventListenerCount[eventName] = nil

                    if self.parent then
                        self.parent:unregisterChildEvent(self, eventName)
                    end
                end
                self.set("childrenEventsSorted", false)
                self:updateRender()
                break
            end
        end
    end
    return self
end

--- Removes a child from the container
--- @shortDescription Removes a child from the container
--- @param child table The child to remove
--- @return Container self The container instance
function Container:removeChild(child)
    if child == nil then return self end
    for i,v in ipairs(self._values.children) do
        if v.get("id") == child.get("id") then
            table.remove(self._values.children, i)
            child.parent = nil
            break
        end
    end
    self:removeChildrenEvents(child)
    self:updateRender()
    self.set("childrenSorted", false)
    return self
end

--- Removes a child from the container
--- @shortDescription Removes a child from the container
--- @param path string The path to the child to remove
--- @return Container? self The container instance
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
        local xOffset, yOffset = self.get("offsetX"), self.get("offsetY")
        local relX, relY = self:getRelativePosition(absX + xOffset, absY + yOffset)
        args = {button, relX, relY}
    end
    return args
end

--- Calls a event on all children
--- @shortDescription Calls a event on all children
--- @param visibleOnly boolean Whether to only call the event on visible children
--- @param event string The event to call
--- @vararg any The event arguments
--- @return boolean handled Whether the event was handled
--- @return table? child The child that handled the event
function Container:callChildrenEvent(visibleOnly, event, ...)
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
    if(children["*"])then
        local events = children["*"]
        for i = #events, 1, -1 do
            local child = events[i]
            if(child:dispatchEvent(event, ...))then
                return true, child
            end
        end
    end
    return false
end

--- @shortDescription Default handler for events
--- @param event string The event to handle
--- @vararg any The event arguments
--- @return boolean handled Whether the event was handled
--- @protected
function Container:handleEvent(event, ...)
    VisualElement.handleEvent(self, event, ...)
    local args = convertMousePosition(self, event, ...)
    return self:callChildrenEvent(false, event, table.unpack(args))
end

--- @shortDescription Handles mouse click events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function Container:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        local args = convertMousePosition(self, "mouse_click", button, x, y)
        local success, child = self:callChildrenEvent(true, "mouse_click", table.unpack(args))
        if(success)then
            self.set("focusedChild", child)
            return true
        end
        self.set("focusedChild", nil)
        return true
    end
    return false
end

--- @shortDescription Handles mouse up events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function Container:mouse_up(button, x, y)
    if VisualElement.mouse_up(self, button, x, y) then
        local args = convertMousePosition(self, "mouse_up", button, x, y)
        local success, child = self:callChildrenEvent(true, "mouse_up", table.unpack(args))
        if(success)then
            return true
        end
    end
    return false
end

--- @shortDescription Handles mouse release events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @protected
function Container:mouse_release(button, x, y)
    VisualElement.mouse_release(self, button, x, y)
    local args = convertMousePosition(self, "mouse_release", button, x, y)
    self:callChildrenEvent(false, "mouse_release", table.unpack(args))
end

--- @shortDescription Handles mouse move events
--- @param _ number unknown
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function Container:mouse_move(_, x, y)
    if VisualElement.mouse_move(self, _, x, y) then
        local args = convertMousePosition(self, "mouse_move", _, x, y)
        local success, child = self:callChildrenEvent(true, "mouse_move", table.unpack(args))
        if(success)then
            return true
        end
    end
    return false
end

--- @shortDescription Handles mouse drag events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function Container:mouse_drag(button, x, y)
    if VisualElement.mouse_drag(self, button, x, y) then
        local args = convertMousePosition(self, "mouse_drag", button, x, y)
        local success, child = self:callChildrenEvent(true, "mouse_drag", table.unpack(args))
        if(success)then
            return true
        end
    end
    return false
end

--- @shortDescription Handles mouse scroll events
--- @param direction number The direction of the scroll
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function Container:mouse_scroll(direction, x, y)
    local args = convertMousePosition(self, "mouse_scroll", direction, x, y)
    local success, child = self:callChildrenEvent(true, "mouse_scroll", table.unpack(args))
    if(success)then
        return true
    end
    if(VisualElement.mouse_scroll(self, direction, x, y))then
        return true
    end
    return false
end

--- @shortDescription Handles key events
--- @param key number The key that was pressed
--- @return boolean handled Whether the event was handled
--- @protected
function Container:key(key)
    if self.get("focusedChild") then
        return self.get("focusedChild"):dispatchEvent("key", key)
    end
    return true
end

--- @shortDescription Handles char events
--- @param char string The character that was pressed
--- @return boolean handled Whether the event was handled
--- @protected
function Container:char(char)
    if self.get("focusedChild") then
        return self.get("focusedChild"):dispatchEvent("char", char)
    end
    return true
end

--- @shortDescription Handles key up events
--- @param key number The key that was released
--- @return boolean handled Whether the event was handled
--- @protected
function Container:key_up(key)
    if self.get("focusedChild") then
        return self.get("focusedChild"):dispatchEvent("key_up", key)
    end
    return true
end

--- @shortDescription Draws multiple lines of text, fg and bg strings
--- @param x number The x position to draw the text
--- @param y number The y position to draw the text
--- @param width number The width of the text
--- @param height number The height of the text
--- @param text string The text to draw
--- @param fg string The foreground color of the text
--- @param bg string The background color of the text
--- @return Container self The container instance
--- @protected
function Container:multiBlit(x, y, width, height, text, fg, bg)
    local w, h = self.get("width"), self.get("height")
    
    width = x < 1 and math.min(width + x - 1, w) or math.min(width, math.max(0, w - x + 1))
    height = y < 1 and math.min(height + y - 1, h) or math.min(height, math.max(0, h - y + 1))

    if width <= 0 or height <= 0 then return self end

    VisualElement.multiBlit(self, math.max(1, x), math.max(1, y), width, height, text, fg, bg)
    return self
end

--- @shortDescription Draws a line of text and fg as color
--- @param x number The x position to draw the text
--- @param y number The y position to draw the text
--- @param text string The text to draw
--- @param fg color The foreground color of the text
--- @return Container self The container instance
--- @protected
function Container:textFg(x, y, text, fg)
    local w, h = self.get("width"), self.get("height")

    if y < 1 or y > h then return self end

    local textStart = x < 1 and (2 - x) or 1
    local textLen = math.min(#text - textStart + 1, w - math.max(1, x) + 1)

    if textLen <= 0 then return self end

    VisualElement.textFg(self, math.max(1, x), math.max(1, y), text:sub(textStart, textStart + textLen - 1), fg)
    return self
end

--- @shortDescription Draws a line of text and bg as color
--- @param x number The x position to draw the text
--- @param y number The y position to draw the text
--- @param text string The text to draw
--- @param bg color The background color of the text
--- @return Container self The container instance
--- @protected
function Container:textBg(x, y, text, bg)
    local w, h = self.get("width"), self.get("height")

    if y < 1 or y > h then return self end

    local textStart = x < 1 and (2 - x) or 1
    local textLen = math.min(#text - textStart + 1, w - math.max(1, x) + 1)

    if textLen <= 0 then return self end

    VisualElement.textBg(self, math.max(1, x), math.max(1, y), text:sub(textStart, textStart + textLen - 1), bg)
    return self
end

function Container:drawText(x, y, text)
    local w, h = self.get("width"), self.get("height")

    if y < 1 or y > h then return self end

    local textStart = x < 1 and (2 - x) or 1
    local textLen = math.min(#text - textStart + 1, w - math.max(1, x) + 1)

    if textLen <= 0 then return self end

    VisualElement.drawText(self, math.max(1, x), math.max(1, y), text:sub(textStart, textStart + textLen - 1))
    return self
end

function Container:drawFg(x, y, fg)
    local w, h = self.get("width"), self.get("height")

    if y < 1 or y > h then return self end

    local textStart = x < 1 and (2 - x) or 1
    local textLen = math.min(#fg - textStart + 1, w - math.max(1, x) + 1)
    if textLen <= 0 then return self end

    VisualElement.drawFg(self, math.max(1, x), math.max(1, y), fg:sub(textStart, textStart + textLen - 1))
    return self
end

function Container:drawBg(x, y, bg)
    local w, h = self.get("width"), self.get("height")

    if y < 1 or y > h then return self end

    local textStart = x < 1 and (2 - x) or 1
    local textLen = math.min(#bg - textStart + 1, w - math.max(1, x) + 1)
    if textLen <= 0 then return self end

    VisualElement.drawBg(self, math.max(1, x), math.max(1, y), bg:sub(textStart, textStart + textLen - 1))
    return self
end

--- @shortDescription Draws a line of text and fg and bg as colors
--- @param x number The x position to draw the text
--- @param y number The y position to draw the text
--- @param text string The text to draw
--- @param fg string The foreground color of the text
--- @param bg string The background color of the text
--- @return Container self The container instance
--- @protected
function Container:blit(x, y, text, fg, bg)
    local w, h = self.get("width"), self.get("height")

    if y < 1 or y > h then return self end

    local textStart = x < 1 and (2 - x) or 1
    local textLen = math.min(#text - textStart + 1, w - math.max(1, x) + 1)
    local fgLen = math.min(#fg - textStart + 1, w - math.max(1, x) + 1)
    local bgLen = math.min(#bg - textStart + 1, w - math.max(1, x) + 1)

    if textLen <= 0 then return self end

    local finalText = text:sub(textStart, textStart + textLen - 1)
    local finalFg = fg:sub(textStart, textStart + fgLen - 1)
    local finalBg = bg:sub(textStart, textStart + bgLen - 1)

    VisualElement.blit(self, math.max(1, x), math.max(1, y), finalText, finalFg, finalBg)
    return self
end

--- @shortDescription Renders the container
--- @protected
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
            errorManager.error("CIRCULAR REFERENCE DETECTED!")
            return
        end
        child:render()
        child:postRender()
    end
end


--- @private
function Container:destroy()
    if not self:isType("BaseFrame") then
        self.set("childrenSorted", false)
        VisualElement.destroy(self)
        return self
    else
        errorManager.header = "Basalt Error"
        errorManager.error("Cannot destroy a BaseFrame.")
    end
end

return Container
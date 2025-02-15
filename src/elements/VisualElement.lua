local elementManager = require("elementManager")
local BaseElement = elementManager.getElement("BaseElement")
local tHex = require("libraries/colorHex")

---@alias color number

---@class VisualElement : BaseElement
local VisualElement = setmetatable({}, BaseElement)
VisualElement.__index = VisualElement

---@property x number 1 x position of the element
VisualElement.defineProperty(VisualElement, "x", {default = 1, type = "number", canTriggerRender = true})
---@property y number 1 y position of the element
VisualElement.defineProperty(VisualElement, "y", {default = 1, type = "number", canTriggerRender = true})
---@property z number 1 z position of the element
VisualElement.defineProperty(VisualElement, "z", {default = 1, type = "number", canTriggerRender = true, setter = function(self, value)
    if self.parent then
        self.parent:sortChildren()
    end
    return value
end})

---@property width number 1 width of the element
VisualElement.defineProperty(VisualElement, "width", {default = 1, type = "number", canTriggerRender = true})
---@property height number 1 height of the element
VisualElement.defineProperty(VisualElement, "height", {default = 1, type = "number", canTriggerRender = true})
---@property background color black background color of the element
VisualElement.defineProperty(VisualElement, "background", {default = colors.black, type = "number", canTriggerRender = true})
---@property foreground color white foreground color of the element
VisualElement.defineProperty(VisualElement, "foreground", {default = colors.white, type = "number", canTriggerRender = true})
---@property clicked boole an false element is currently clicked
VisualElement.defineProperty(VisualElement, "clicked", {default = false, type = "boolean"})
---@property backgroundEnabled boolean true whether the background is enabled
VisualElement.defineProperty(VisualElement, "backgroundEnabled", {default = true, type = "boolean", canTriggerRender = true})
---@property focused boolean false whether the element is focused
VisualElement.defineProperty(VisualElement, "focused", {default = false, type = "boolean", setter = function(self, value, internal)
    local curValue = self.get("focused")
    if value == curValue then return value end

    if value then
        self:focus()
    else
        self:blur()
    end

    if not internal and self.parent then
        if value then
            self.parent:setFocusedChild(self)
        else
            self.parent:setFocusedChild(nil)
        end
    end
    return value
end})

VisualElement.defineProperty(VisualElement, "visible", {default = true, type = "boolean", canTriggerRender = true, setter=function(self, value)
    if(self.parent~=nil)then
        self.parent.set("childrenSorted", false)
        self.parent.set("childrenEventsSorted", false)
    end
    return value
end})

VisualElement.combineProperties(VisualElement, "position", "x", "y")
VisualElement.combineProperties(VisualElement, "size", "width", "height")
VisualElement.combineProperties(VisualElement, "color", "foreground", "background")

VisualElement.listenTo(VisualElement, "focus")
VisualElement.listenTo(VisualElement, "blur")

local max, min = math.max, math.min

--- Creates a new VisualElement instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return VisualElement object The newly created VisualElement instance
--- @usage local element = VisualElement.new("myId", basalt)
function VisualElement.new(props, basalt)
    local self = setmetatable({}, VisualElement):__init()
    self:init(props, basalt)
    return self
end

function VisualElement:init(props, basalt)
    BaseElement.init(self, props, basalt)
    self.set("type", "VisualElement")
end

--- Draws a text character/fg/bg at the specified position with a certain size, used in the rendering system
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param width number The width of the element
--- @param height number The height of the element
--- @param text string The text char to draw
--- @param fg color The foreground color
--- @param bg color The background color
function VisualElement:multiBlit(x, y, width, height, text, fg, bg)
    x = x + self.get("x") - 1
    y = y + self.get("y") - 1
    self.parent:multiBlit(x, y, width, height, text, fg, bg)
end

--- Draws a text character at the specified position, used in the rendering system
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param text string The text char to draw
--- @param fg color The foreground color
function VisualElement:textFg(x, y, text, fg)
    x = x + self.get("x") - 1
    y = y + self.get("y") - 1
    self.parent:textFg(x, y, text, fg)
end

function VisualElement:textBg(x, y, text, bg)
    x = x + self.get("x") - 1
    y = y + self.get("y") - 1
    self.parent:textBg(x, y, text, bg)
end

function VisualElement:blit(x, y, text, fg, bg)
    x = x + self.get("x") - 1
    y = y + self.get("y") - 1
    self.parent:blit(x, y, text, fg, bg)
end

--- Checks if the specified coordinates are within the bounds of the element
--- @param x number The x position to check
--- @param y number The y position to check
--- @return boolean isInBounds Whether the coordinates are within the bounds of the element
function VisualElement:isInBounds(x, y)
    local xPos, yPos = self.get("x"), self.get("y")
    local width, height = self.get("width"), self.get("height")

    return x >= xPos and x <= xPos + width - 1 and
           y >= yPos and y <= yPos + height - 1
end

--- Handles a mouse click event
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean clicked Whether the element was clicked
function VisualElement:mouse_click(button, x, y)
    if self:isInBounds(x, y) then
        self.set("clicked", true)
        self:fireEvent("mouse_click", button, self:getRelativePosition(x, y))
        return true
    end
    return false
end

function VisualElement:mouse_up(button, x, y)
    self.set("clicked", false)
    if self:isInBounds(x, y) then
        self:fireEvent("mouse_up", button, x, y)
        return true
    end
    self:fireEvent("mouse_release", button, self:getRelativePosition(x, y))
end

function VisualElement:mouse_release()
    self.set("clicked", false)
end

function VisualElement:focus()
    self:fireEvent("focus")
end

function VisualElement:blur()
    self:fireEvent("blur")
    self:setCursor(1,1, false)
end

--- Returns the absolute position of the element or the given coordinates.
---@param x? number x position
---@param y? number y position
function VisualElement:getAbsolutePosition(x, y)
    local xPos, yPos = self.get("x"), self.get("y")
    if(x ~= nil) then
        xPos = xPos + x - 1
    end
    if(y ~= nil) then
        yPos = yPos + y - 1
    end

    local parent = self.parent
    while parent do
        local px, py = parent.get("x"), parent.get("y")
        xPos = xPos + px - 1
        yPos = yPos + py - 1
        parent = parent.parent
    end

    return xPos, yPos
end

--- Returns the relative position of the element or the given coordinates.
---@param x? number x position
---@param y? number y position
---@return number, number
function VisualElement:getRelativePosition(x, y)
    if (x == nil) or (y == nil) then
        x, y = self.get("x"), self.get("y")
    end

    local parentX, parentY = 1, 1
    if self.parent then
        parentX, parentY = self.parent:getRelativePosition()
    end

    local elementX = self.get("x")
    local elementY = self.get("y")

    return x - (elementX - 1) - (parentX - 1),
           y - (elementY - 1) - (parentY - 1)
end

function VisualElement:setCursor(x, y, blink)
    if self.parent then
        local absX, absY = self:getAbsolutePosition(x, y)
        absX = max(self.get("x"), min(absX, self.get("width") + self.get("x") - 1))
        return self.parent:setCursor(absX, absY, blink)
    end
end

--- Renders the element
--- @usage element:render()
function VisualElement:render()
    if(not self.get("backgroundEnabled"))then
        return
    end
    local width, height = self.get("width"), self.get("height")
    self:multiBlit(1, 1, width, height, " ", tHex[self.get("foreground")], tHex[self.get("background")])
end

return VisualElement
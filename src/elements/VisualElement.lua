local BaseElement = require("elements/BaseElement")

---@alias color number

---@class VisualElement : BaseElement
local VisualElement = setmetatable({}, BaseElement)
VisualElement.__index = VisualElement
local tHex = require("libraries/colorHex")

---@property x number 1 x position of the element
BaseElement.defineProperty(VisualElement, "x", {default = 1, type = "number", canTriggerRender = true})
---@property y number 1 y position of the element
BaseElement.defineProperty(VisualElement, "y", {default = 1, type = "number", canTriggerRender = true})
---@property z number 1 z position of the element
BaseElement.defineProperty(VisualElement, "z", {default = 1, type = "number", canTriggerRender = true, setter = function(self, value)
    self.basalt.LOGGER.debug("Setting z to " .. value)
    if self.parent then
        self.parent:sortChildren()
    end
    return value
end})
---@property width number 1 width of the element
BaseElement.defineProperty(VisualElement, "width", {default = 1, type = "number", canTriggerRender = true})
---@property height number 1 height of the element
BaseElement.defineProperty(VisualElement, "height", {default = 1, type = "number", canTriggerRender = true})
---@property background color black background color of the element
BaseElement.defineProperty(VisualElement, "background", {default = colors.black, type = "number", canTriggerRender = true})
---@property foreground color white foreground color of the element
BaseElement.defineProperty(VisualElement, "foreground", {default = colors.white, type = "number", canTriggerRender = true})
---@property clicked boolean false element is currently clicked
BaseElement.defineProperty(VisualElement, "clicked", {default = false, type = "boolean"})

--- Creates a new VisualElement instance
--- @param id string The unique identifier for this element
--- @param basalt table The basalt instance
--- @return VisualElement object The newly created VisualElement instance
--- @usage local element = VisualElement.new("myId", basalt)
function VisualElement.new(id, basalt)
    local self = setmetatable({}, VisualElement):__init()
    self:init(id, basalt)
    self.set("type", "VisualElement")
    return self
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
        self:fireEvent("mouse_click", button, x, y)
        return true
    end
end

function VisualElement:mouse_up(button, x, y)
    if self:isInBounds(x, y) then
        self.set("clicked", false)
        self:fireEvent("mouse_up", button, x, y)
        return true
    end
    self:fireEvent("mouse_release", button, x, y)
end

function VisualElement:mouse_release()
    self.set("clicked", false)
end

function VisualElement:handleEvent(event, ...)
    if(self[event])then
        return self[event](self, ...)
    end
end

--- Returns the absolute position of the element or the given coordinates.
---@param x? number x position
---@param y? number y position
function VisualElement:getAbsolutePosition(x, y)
    if (x == nil) or (y == nil) then
        x, y = self.get("x"), self.get("y")
    end

    local parent = self.parent
    while parent do
        local px, py = parent.get("x"), parent.get("y")
        x = x + px - 1
        y = y + py - 1
        parent = parent.parent
    end

    return x, y
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


--- Renders the element
--- @usage element:render()
function VisualElement:render()
    local width, height = self.get("width"), self.get("height")
    self:multiBlit(1, 1, width, height, " ", tHex[self.get("foreground")], tHex[self.get("background")])
end

return VisualElement
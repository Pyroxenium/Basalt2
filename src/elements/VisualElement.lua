local elementManager = require("elementManager")
local BaseElement = elementManager.getElement("BaseElement")
local tHex = require("libraries/colorHex")
---@configDescription The Visual Element class which is the base class for all visual UI elements
---@configDefault true

--- This is the visual element class. It serves as the base class for all visual UI elements
--- and provides core functionality for positioning, sizing, colors, and rendering.
---@class VisualElement : BaseElement
local VisualElement = setmetatable({}, BaseElement)
VisualElement.__index = VisualElement

---@property x number 1 The horizontal position relative to parent
VisualElement.defineProperty(VisualElement, "x", {default = 1, type = "number", canTriggerRender = true})
---@property y number 1 The vertical position relative to parent
VisualElement.defineProperty(VisualElement, "y", {default = 1, type = "number", canTriggerRender = true})
---@property z number 1 The z-index for layering elements
VisualElement.defineProperty(VisualElement, "z", {default = 1, type = "number", canTriggerRender = true, setter = function(self, value)
    if self.parent then
        self.parent:sortChildren()
    end
    return value
end})

---@property width number 1 The width of the element
VisualElement.defineProperty(VisualElement, "width", {default = 1, type = "number", canTriggerRender = true})
---@property height number 1 The height of the element
VisualElement.defineProperty(VisualElement, "height", {default = 1, type = "number", canTriggerRender = true})
---@property background color black The background color
VisualElement.defineProperty(VisualElement, "background", {default = colors.black, type = "number", canTriggerRender = true})
---@property foreground color white The text/foreground color
VisualElement.defineProperty(VisualElement, "foreground", {default = colors.white, type = "number", canTriggerRender = true})
---@property clicked boolean false Whether the element is currently clicked
VisualElement.defineProperty(VisualElement, "clicked", {default = false, type = "boolean"})
---@property hover boolean false Whether the mouse is currently hover over the element (Craftos-PC only)
VisualElement.defineProperty(VisualElement, "hover", {default = false, type = "boolean"})
---@property backgroundEnabled boolean true Whether to render the background
VisualElement.defineProperty(VisualElement, "backgroundEnabled", {default = true, type = "boolean", canTriggerRender = true})
---@property focused boolean false Whether the element has input focus
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

---@property visible boolean true Whether the element is visible
VisualElement.defineProperty(VisualElement, "visible", {default = true, type = "boolean", canTriggerRender = true, setter=function(self, value)
    if(self.parent~=nil)then
        self.parent.set("childrenSorted", false)
        self.parent.set("childrenEventsSorted", false)
    end
    return value
end})

---@property ignoreOffset boolean false Whether to ignore the parent's offset
VisualElement.defineProperty(VisualElement, "ignoreOffset", {default = false, type = "boolean"})

---@combinedProperty position {x y} Combined x, y position
VisualElement.combineProperties(VisualElement, "position", "x", "y")
---@combinedProperty size {width height} Combined width, height
VisualElement.combineProperties(VisualElement, "size", "width", "height")
---@combinedProperty color {foreground background} Combined foreground, background colors
VisualElement.combineProperties(VisualElement, "color", "foreground", "background")

---@event onMouseClick {button number, x number, y number} Fired on mouse click
---@event onMouseUp {button number, x number, y number} Fired on mouse button release
---@event onMouseRelease {button number, x number, y number} Fired when mouse leaves while clicked
---@event onMouseDrag {button number, x number, y number} Fired when mouse moves while clicked
---@event onFocus {-} Fired when element receives focus
---@event onBlur {-} Fired when element loses focus
---@event onKey {key number, code number, isRepeat boolean} Fired on key press
---@event onKeyUp {key number, code number} Fired on key release
---@event onChar {char string} Fired on character input

VisualElement.defineEvent(VisualElement, "focus")
VisualElement.defineEvent(VisualElement, "blur")

VisualElement.registerEventCallback(VisualElement, "MouseClick", "mouse_click", "mouse_up")
VisualElement.registerEventCallback(VisualElement, "MouseUp", "mouse_up", "mouse_click")
VisualElement.registerEventCallback(VisualElement, "MouseDrag", "mouse_drag", "mouse_click", "mouse_up")
VisualElement.registerEventCallback(VisualElement, "MouseScroll", "mouse_scroll")
VisualElement.registerEventCallback(VisualElement, "MouseEnter", "mouse_enter", "mouse_move")
VisualElement.registerEventCallback(VisualElement, "Focus", "focus", "blur")
VisualElement.registerEventCallback(VisualElement, "Blur", "blur", "focus")

local max, min = math.max, math.min

--- Creates a new VisualElement instance
--- @shortDescription Creates a new visual element
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return VisualElement object The newly created VisualElement instance
--- @usage local element = VisualElement.new("myId", basalt)
function VisualElement.new()
    local self = setmetatable({}, VisualElement):__init()
    return self
end

--- Initializes the VisualElement instance
--- @shortDescription Initializes a new visual element with properties
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
function VisualElement:init(props, basalt)
    BaseElement.init(self, props, basalt)
    self.set("type", "VisualElement")
end

--- Draws multiple characters at once with colors
--- @shortDescription Multi-character drawing with colors
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param width number The width of the area to draw
--- @param height number The height of the area to draw
--- @param text string The text to draw
--- @param fg string The foreground color
--- @param bg string The background color
function VisualElement:multiBlit(x, y, width, height, text, fg, bg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:multiBlit(x, y, width, height, text, fg, bg)
end

--- Draws text with foreground color
--- @shortDescription Draws text with foreground color
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param text string The text char to draw
--- @param fg color The foreground color
function VisualElement:textFg(x, y, text, fg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:textFg(x, y, text, fg)
end

--- Draws text with background color
--- @shortDescription Draws text with background color
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param text string The text char to draw
--- @param bg color The background color
function VisualElement:textBg(x, y, text, bg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:textBg(x, y, text, bg)
end

--- Draws text with both foreground and background colors
--- @shortDescription Draws text with both colors
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param text string The text char to draw
--- @param fg string The foreground color
--- @param bg string The background color
function VisualElement:blit(x, y, text, fg, bg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:blit(x, y, text, fg, bg)
end

--- Checks if the specified coordinates are within the bounds of the element
--- @shortDescription Checks if point is within bounds
--- @param x number The x position to check
--- @param y number The y position to check
--- @return boolean isInBounds Whether the coordinates are within the bounds of the element
function VisualElement:isInBounds(x, y)
    local xPos, yPos = self.get("x"), self.get("y")
    local width, height = self.get("width"), self.get("height")
    if(self.get("ignoreOffset"))then
        if(self.parent)then
            x = x - self.parent.get("offsetX")
            y = y - self.parent.get("offsetY")
        end
    end

    return x >= xPos and x <= xPos + width - 1 and
           y >= yPos and y <= yPos + height - 1
end

--- Handles a mouse click event
--- @shortDescription Handles a mouse click event
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

--- Handles a mouse up event
--- @shortDescription Handles a mouse up event
--- @param button number The button that was released
--- @param x number The x position of the release
--- @param y number The y position of the release
--- @return boolean release Whether the element was released on the element
function VisualElement:mouse_up(button, x, y)
    if self:isInBounds(x, y) then
        self.set("clicked", false)
        self:fireEvent("mouse_up", button, self:getRelativePosition(x, y))
        return true
    end
    return false
end

--- Handles a mouse release event
--- @shortDescription Handles a mouse release event
--- @param button number The button that was released
--- @param x number The x position of the release
--- @param y number The y position of the release
function VisualElement:mouse_release(button, x, y)
    self:fireEvent("mouse_release", button, self:getRelativePosition(x, y))
    self.set("clicked", false)
end

function VisualElement:mouse_move(_, x, y)
    if(x==nil)or(y==nil)then
        return
    end
    local hover = self.get("hover")
    if(self:isInBounds(x, y))then
        if(not hover)then
            self.set("hover", true)
            self:fireEvent("mouse_enter", self:getRelativePosition(x, y))
        end
        return true
    else
        if(hover)then
            self.set("hover", false)
            self:fireEvent("mouse_leave", self:getRelativePosition(x, y))
        end
    end
    return false
end

function VisualElement:mouse_scroll(direction, x, y)
    if(self:isInBounds(x, y))then
        self:fireEvent("mouse_scroll", direction, self:getRelativePosition(x, y))
        return true
    end
    return false
end

function VisualElement:mouse_drag(button, x, y)
    if(self.get("clicked"))then
        self:fireEvent("mouse_drag", button, self:getRelativePosition(x, y))
        return true
    end
    return false
end

--- Handles a focus event
--- @shortDescription Handles a focus event
function VisualElement:focus()
    self:fireEvent("focus")
end

--- Handles a blur event
--- @shortDescription Handles a blur event
function VisualElement:blur()
    self:fireEvent("blur")
    self:setCursor(1,1, false)
end

function VisualElement:calculatePosition()
    local x, y = self.get("x"), self.get("y")
    if not self.get("ignoreOffset") then
        if self.parent ~= nil then
            local xO, yO = self.parent.get("offsetX"), self.parent.get("offsetY")
            x = x - xO
            y = y - yO
        end
    end
    return x, y
end

--- Returns the absolute position of the element or the given coordinates.
--- @shortDescription Returns the absolute position of the element
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
--- @shortDescription Returns the relative position of the element
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

    local elementX, elementY = self.get("x"), self.get("y")
    return x - (elementX - 1) - (parentX - 1),
           y - (elementY - 1) - (parentY - 1)
end

--- Sets the cursor position
--- @shortDescription Sets the cursor position
--- @param x number The x position of the cursor
--- @param y number The y position of the cursor
--- @param blink boolean Whether the cursor should blink
function VisualElement:setCursor(x, y, blink, color)
    if self.parent then
        local absX, absY = self:getAbsolutePosition(x, y)
        absX = max(self.get("x"), min(absX, self.get("width") + self.get("x") - 1))
        return self.parent:setCursor(absX, absY, blink, color)
    end
end

--- Renders the element
--- @shortDescription Renders the element
function VisualElement:render()
    if(not self.get("backgroundEnabled"))then
        return
    end
    local width, height = self.get("width"), self.get("height")
    self:multiBlit(1, 1, width, height, " ", tHex[self.get("foreground")], tHex[self.get("background")])
end

return VisualElement
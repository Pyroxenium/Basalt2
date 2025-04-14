local elementManager = require("elementManager")
local BaseElement = elementManager.getElement("BaseElement")
local tHex = require("libraries/colorHex")
---@configDescription The Visual Element class which is the base class for all visual UI elements

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
VisualElement.defineProperty(VisualElement, "background", {default = colors.black, type = "color", canTriggerRender = true})
---@property foreground color white The text/foreground color
VisualElement.defineProperty(VisualElement, "foreground", {default = colors.white, type = "color", canTriggerRender = true})
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
    if(value==false)then
        self.set("clicked", false)
    end
    return value
end})

---@property ignoreOffset boolean false Whether to ignore the parent's offset
VisualElement.defineProperty(VisualElement, "ignoreOffset", {default = false, type = "boolean"})

---@combinedProperty position {x number, y number} Combined x, y position
VisualElement.combineProperties(VisualElement, "position", "x", "y")
---@combinedProperty size {width number, height number} Combined width, height
VisualElement.combineProperties(VisualElement, "size", "width", "height")
---@combinedProperty color {foreground number, background number} Combined foreground, background colors
VisualElement.combineProperties(VisualElement, "color", "foreground", "background")

---@event onClick {button string, x number, y number} Fired on mouse click
---@event onMouseUp {button, x, y} Fired on mouse button release
---@event onRelease {button, x, y} Fired when mouse leaves while clicked
---@event onDrag {button, x, y} Fired when mouse moves while clicked
---@event onScroll {direction, x, y} Fired on mouse scroll
---@event onEnter {-} Fired when mouse enters element
---@event onLeave {-} Fired when mouse leaves element
---@event onFocus {-} Fired when element receives focus
---@event onBlur {-} Fired when element loses focus
---@event onKey {key} Fired on key press
---@event onKeyUp {key} Fired on key release
---@event onChar {char} Fired on character input

VisualElement.defineEvent(VisualElement, "focus")
VisualElement.defineEvent(VisualElement, "blur")

VisualElement.registerEventCallback(VisualElement, "Click", "mouse_click", "mouse_up")
VisualElement.registerEventCallback(VisualElement, "ClickUp", "mouse_up", "mouse_click")
VisualElement.registerEventCallback(VisualElement, "Drag", "mouse_drag", "mouse_click", "mouse_up")
VisualElement.registerEventCallback(VisualElement, "Scroll", "mouse_scroll")
VisualElement.registerEventCallback(VisualElement, "Enter", "mouse_enter", "mouse_move")
VisualElement.registerEventCallback(VisualElement, "LeEave", "mouse_leave", "mouse_move")
VisualElement.registerEventCallback(VisualElement, "Focus", "focus", "blur")
VisualElement.registerEventCallback(VisualElement, "Blur", "blur", "focus")
VisualElement.registerEventCallback(VisualElement, "Key", "key", "key_up")
VisualElement.registerEventCallback(VisualElement, "Char", "char")
VisualElement.registerEventCallback(VisualElement, "KeyUp", "key_up", "key")

local max, min = math.max, math.min

--- Creates a new VisualElement instance
--- @shortDescription Creates a new visual element
--- @return VisualElement object The newly created VisualElement instance
--- @private
function VisualElement.new()
    local self = setmetatable({}, VisualElement):__init()
    self.class = VisualElement
    return self
end

--- @shortDescription Initializes a new visual element with properties
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @protected
function VisualElement:init(props, basalt)
    BaseElement.init(self, props, basalt)
    self.set("type", "VisualElement")
end

--- @shortDescription Multi-character drawing with colors
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param width number The width of the area to draw
--- @param height number The height of the area to draw
--- @param text string The text to draw
--- @param fg string The foreground color
--- @param bg string The background color
--- @protected
function VisualElement:multiBlit(x, y, width, height, text, fg, bg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:multiBlit(x, y, width, height, text, fg, bg)
end

--- @shortDescription Draws text with foreground color
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param text string The text char to draw
--- @param fg color The foreground color
--- @protected
function VisualElement:textFg(x, y, text, fg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:textFg(x, y, text, fg)
end

--- @shortDescription Draws text with background color
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param text string The text char to draw
--- @param bg color The background color
--- @protected
function VisualElement:textBg(x, y, text, bg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:textBg(x, y, text, bg)
end

function VisualElement:drawText(x, y, text)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:drawText(x, y, text)
end

function VisualElement:drawFg(x, y, fg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:drawFg(x, y, fg)
end

function VisualElement:drawBg(x, y, bg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:drawBg(x, y, bg)
end

--- @shortDescription Draws text with both colors
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param text string The text char to draw
--- @param fg string The foreground color
--- @param bg string The background color
--- @protected
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

--- @shortDescription Handles a mouse click event
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean clicked Whether the element was clicked
--- @protected
function VisualElement:mouse_click(button, x, y)
    if self:isInBounds(x, y) then
        self.set("clicked", true)
        self:fireEvent("mouse_click", button, self:getRelativePosition(x, y))
        return true
    end
    return false
end

--- @shortDescription Handles a mouse up event
--- @param button number The button that was released
--- @param x number The x position of the release
--- @param y number The y position of the release
--- @return boolean release Whether the element was released on the element
--- @protected
function VisualElement:mouse_up(button, x, y)
    if self:isInBounds(x, y) then
        self.set("clicked", false)
        self:fireEvent("mouse_up", button, self:getRelativePosition(x, y))
        return true
    end
    return false
end

--- @shortDescription Handles a mouse release event
--- @param button number The button that was released
--- @param x number The x position of the release
--- @param y number The y position of the release
--- @protected
function VisualElement:mouse_release(button, x, y)
    self:fireEvent("mouse_release", button, self:getRelativePosition(x, y))
    self.set("clicked", false)
end

---@shortDescription Handles a mouse move event
---@param _ number unknown
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@return boolean hover Whether the mouse has moved over the element
--- @protected
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

--- @shortDescription Handles a mouse scroll event
--- @param direction number The scroll direction
--- @param x number The x position of the scroll
--- @param y number The y position of the scroll
--- @return boolean scroll Whether the element was scrolled
--- @protected
function VisualElement:mouse_scroll(direction, x, y)
    if(self:isInBounds(x, y))then
        self:fireEvent("mouse_scroll", direction, self:getRelativePosition(x, y))
        return true
    end
    return false
end

--- @shortDescription Handles a mouse drag event
--- @param button number The button that was clicked while dragging
--- @param x number The x position of the drag
--- @param y number The y position of the drag
--- @return boolean drag Whether the element was dragged
--- @protected
function VisualElement:mouse_drag(button, x, y)
    if(self.get("clicked"))then
        self:fireEvent("mouse_drag", button, self:getRelativePosition(x, y))
        return true
    end
    return false
end

--- @shortDescription Handles a focus event
--- @protected
function VisualElement:focus()
    self:fireEvent("focus")
end

--- @shortDescription Handles a blur event
--- @protected
function VisualElement:blur()
    self:fireEvent("blur")
    self:setCursor(1,1, false)
end

--- @shortDescription Handles a key event
--- @param key number The key that was pressed
--- @protected
function VisualElement:key(key, held)
    if(self.get("focused"))then
        self:fireEvent("key", key, held)
    end
end

--- @shortDescription Handles a key up event
--- @param key number The key that was released
--- @protected
function VisualElement:key_up(key)
    if(self.get("focused"))then
        self:fireEvent("key_up", key)
    end
end

--- @shortDescription Handles a character event
--- @param char string The character that was pressed
--- @protected
function VisualElement:char(char)
    if(self.get("focused"))then
        self:fireEvent("char", char)
    end
end

--- Calculates the position of the element relative to its parent
--- @shortDescription Calculates the position of the element
--- @return number x The x position
--- @return number y The y position
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
---@return number x The absolute x position
---@return number y The absolute y position
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
---@return number x The relative x position
---@return number y The relative y position
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

--- @shortDescription Sets the cursor position
--- @param x number The x position of the cursor
--- @param y number The y position of the cursor
--- @param blink boolean Whether the cursor should blink
--- @param color number The color of the cursor
--- @return VisualElement self The VisualElement instance
--- @protected
function VisualElement:setCursor(x, y, blink, color)
    if self.parent then
        local xPos, yPos = self:calculatePosition()
        if(x + xPos - 1<1)or(x + xPos - 1>self.parent.get("width"))or
        (y + yPos - 1<1)or(y + yPos - 1>self.parent.get("height"))then
            return self.parent:setCursor(x + xPos - 1, y + yPos - 1, false)
        end
        return self.parent:setCursor(x + xPos - 1, y + yPos - 1, blink, color)
    end
    return self
end

--- This function is used to prioritize the element by moving it to the top of its parent's children. It removes the element from its parent and adds it back, effectively changing its order.
--- @shortDescription Prioritizes the element by moving it to the top of its parent's children
--- @return VisualElement self The VisualElement instance
function VisualElement:prioritize()
    if(self.parent)then
        local parent = self.parent
        parent:removeChild(self)
        parent:addChild(self)
        self:updateRender()
    end
    return self
end

--- @shortDescription Renders the element
--- @protected
function VisualElement:render()
    if(not self.get("backgroundEnabled"))then
        return
    end
    local width, height = self.get("width"), self.get("height")
    self:multiBlit(1, 1, width, height, " ", tHex[self.get("foreground")], tHex[self.get("background")])
end

--- @shortDescription Post-rendering function for the element
--- @protected
function VisualElement:postRender()
end

return VisualElement
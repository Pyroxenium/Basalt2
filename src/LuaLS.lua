---@class BaseFrame
---@field text term
local BaseFrame = {}

--- Gets the nil text
---@generic Element: BaseFrame
---@param self Element
---@return term
function BaseFrame:getText()
    return self.text
end

--- Sets the nil text
---@generic Element: BaseFrame
---@param self Element
---@param text term
---@return Element
function BaseFrame:setText(text)
    self.text = text
    return self
end


---@class Button
---@field text string
local Button = {}

--- Gets the Button text
---@generic Element: Button
---@param self Element
---@return string
function Button:getText()
    return self.text
end

--- Sets the Button text
---@generic Element: Button
---@param self Element
---@param text string
---@return Element
function Button:setText(text)
    self.text = text
    return self
end

--- The event that is triggered when the button is clicked
---@generic Element: Button
---@param self Element
---@param callback function
---@return Element
function Button:onMouseClick(callback)
    return self
end


---@class Container
local Container = {}

--- Adds a new Button to the container
---@generic Element: Container
---@param self Element
---@return Button
function Container:addButton()
    return self
end

--- Adds a new Container to the container
---@generic Element: Container
---@param self Element
---@return Container
function Container:addContainer()
    return self
end

--- Adds a new Flexbox to the container
---@generic Element: Container
---@param self Element
---@return Flexbox
function Container:addFlexbox()
    return self
end

--- Adds a new Frame to the container
---@generic Element: Container
---@param self Element
---@return Frame
function Container:addFrame()
    return self
end

--- Adds a new Input to the container
---@generic Element: Container
---@param self Element
---@return Input
function Container:addInput()
    return self
end

--- Adds a new Label to the container
---@generic Element: Container
---@param self Element
---@return Label
function Container:addLabel()
    return self
end

--- Adds a new VisualElement to the container
---@generic Element: Container
---@param self Element
---@return VisualElement
function Container:addVisualElement()
    return self
end


---@class Input
---@field text string
---@field cursorPos number
---@field viewOffset number
local Input = {}

--- Gets the - text to be displayed
---@generic Element: Input
---@param self Element
---@return string
function Input:getText()
    return self.text
end

--- Sets the - text to be displayed
---@generic Element: Input
---@param self Element
---@param text string
---@return Element
function Input:setText(text)
    self.text = text
    return self
end

--- Gets the - current cursor position
---@generic Element: Input
---@param self Element
---@return number
function Input:getCursorPos()
    return self.cursorPos
end

--- Sets the - current cursor position
---@generic Element: Input
---@param self Element
---@param cursorPos number
---@return Element
function Input:setCursorPos(cursorPos)
    self.cursorPos = cursorPos
    return self
end

--- Gets the - offset für Text-Viewport
---@generic Element: Input
---@param self Element
---@return number
function Input:getViewOffset()
    return self.viewOffset
end

--- Sets the - offset für Text-Viewport
---@generic Element: Input
---@param self Element
---@param viewOffset number
---@return Element
function Input:setViewOffset(viewOffset)
    self.viewOffset = viewOffset
    return self
end


---@class Label
---@field text string
local Label = {}

--- Gets the Label text to be displayed
---@generic Element: Label
---@param self Element
---@return string
function Label:getText()
    return self.text
end

--- Sets the Label text to be displayed
---@generic Element: Label
---@param self Element
---@param text string
---@return Element
function Label:setText(text)
    self.text = text
    return self
end


---@class VisualElement
---@field x number
---@field y number
---@field z number
---@field width number
---@field height number
---@field background color
---@field foreground color
---@field clicked boole
---@field backgroundEnabled boolean
---@field focused boolean
local VisualElement = {}

--- Gets the x position of the element
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getX()
    return self.x
end

--- Sets the x position of the element
---@generic Element: VisualElement
---@param self Element
---@param x number
---@return Element
function VisualElement:setX(x)
    self.x = x
    return self
end

--- Gets the y position of the element
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getY()
    return self.y
end

--- Sets the y position of the element
---@generic Element: VisualElement
---@param self Element
---@param y number
---@return Element
function VisualElement:setY(y)
    self.y = y
    return self
end

--- Gets the z position of the element
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getZ()
    return self.z
end

--- Sets the z position of the element
---@generic Element: VisualElement
---@param self Element
---@param z number
---@return Element
function VisualElement:setZ(z)
    self.z = z
    return self
end

--- Gets the width of the element
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getWidth()
    return self.width
end

--- Sets the width of the element
---@generic Element: VisualElement
---@param self Element
---@param width number
---@return Element
function VisualElement:setWidth(width)
    self.width = width
    return self
end

--- Gets the height of the element
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getHeight()
    return self.height
end

--- Sets the height of the element
---@generic Element: VisualElement
---@param self Element
---@param height number
---@return Element
function VisualElement:setHeight(height)
    self.height = height
    return self
end

--- Gets the background color of the element
---@generic Element: VisualElement
---@param self Element
---@return color
function VisualElement:getBackground()
    return self.background
end

--- Sets the background color of the element
---@generic Element: VisualElement
---@param self Element
---@param background color
---@return Element
function VisualElement:setBackground(background)
    self.background = background
    return self
end

--- Gets the foreground color of the element
---@generic Element: VisualElement
---@param self Element
---@return color
function VisualElement:getForeground()
    return self.foreground
end

--- Sets the foreground color of the element
---@generic Element: VisualElement
---@param self Element
---@param foreground color
---@return Element
function VisualElement:setForeground(foreground)
    self.foreground = foreground
    return self
end

--- Gets the false element is currently clicked
---@generic Element: VisualElement
---@param self Element
---@return boole
function VisualElement:getClicked()
    return self.clicked
end

--- Sets the false element is currently clicked
---@generic Element: VisualElement
---@param self Element
---@param clicked boole
---@return Element
function VisualElement:setClicked(clicked)
    self.clicked = clicked
    return self
end

--- Gets the whether the background is enabled
---@generic Element: VisualElement
---@param self Element
---@return boolean
function VisualElement:getBackgroundEnabled()
    return self.backgroundEnabled
end

--- Sets the whether the background is enabled
---@generic Element: VisualElement
---@param self Element
---@param backgroundEnabled boolean
---@return Element
function VisualElement:setBackgroundEnabled(backgroundEnabled)
    self.backgroundEnabled = backgroundEnabled
    return self
end

--- Gets the whether the element is focused
---@generic Element: VisualElement
---@param self Element
---@return boolean
function VisualElement:getFocused()
    return self.focused
end

--- Sets the whether the element is focused
---@generic Element: VisualElement
---@param self Element
---@param focused boolean
---@return Element
function VisualElement:setFocused(focused)
    self.focused = focused
    return self
end

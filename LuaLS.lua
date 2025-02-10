---@class Button
local Button = {}

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

--- Adds a new Frame to the container
---@generic Element: Container
---@param self Element
---@return Frame
function Container:addFrame()
    return self
end

--- Adds a new VisualElement to the container
---@generic Element: Container
---@param self Element
---@return VisualElement
function Container:addVisualElement()
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
---@field clicked boolean
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

--- Gets the element is currently clicked
---@generic Element: VisualElement
---@param self Element
---@return boolean
function VisualElement:getClicked()
    return self.clicked
end

--- Sets the element is currently clicked
---@generic Element: VisualElement
---@param self Element
---@param clicked boolean
---@return Element
function VisualElement:setClicked(clicked)
    self.clicked = clicked
    return self
end

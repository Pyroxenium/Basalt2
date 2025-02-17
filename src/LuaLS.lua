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


---@class Checkbox
---@field checked boolean
---@field text string
---@field symbol string
local Checkbox = {}

--- Gets the checkbox is checked
---@generic Element: Checkbox
---@param self Element
---@return boolean
function Checkbox:getChecked()
    return self.checked
end

--- Sets the checkbox is checked
---@generic Element: Checkbox
---@param self Element
---@param checked boolean
---@return Element
function Checkbox:setChecked(checked)
    self.checked = checked
    return self
end

--- Gets the text
---@generic Element: Checkbox
---@param self Element
---@return string
function Checkbox:getText()
    return self.text
end

--- Sets the text
---@generic Element: Checkbox
---@param self Element
---@param text string
---@return Element
function Checkbox:setText(text)
    self.text = text
    return self
end

--- Gets the symbol
---@generic Element: Checkbox
---@param self Element
---@return string
function Checkbox:getSymbol()
    return self.symbol
end

--- Sets the symbol
---@generic Element: Checkbox
---@param self Element
---@param symbol string
---@return Element
function Checkbox:setSymbol(symbol)
    self.symbol = symbol
    return self
end


---@class Container
---@field children table
---@field childrenSorted boolean
---@field childrenEventsSorted boolean
---@field childrenEvents table
---@field eventListenerCount table
---@field focusedChild table
---@field visibleChildren table
---@field visibleChildrenEvents table
local Container = {}

--- Gets the The children of the container
---@generic Element: Container
---@param self Element
---@return table
function Container:getChildren()
    return self.children
end

--- Sets the The children of the container
---@generic Element: Container
---@param self Element
---@param children table
---@return Element
function Container:setChildren(children)
    self.children = children
    return self
end

--- Gets the Whether the children are sorted
---@generic Element: Container
---@param self Element
---@return boolean
function Container:getChildrenSorted()
    return self.childrenSorted
end

--- Sets the Whether the children are sorted
---@generic Element: Container
---@param self Element
---@param childrenSorted boolean
---@return Element
function Container:setChildrenSorted(childrenSorted)
    self.childrenSorted = childrenSorted
    return self
end

--- Gets the Whether the children events are sorted
---@generic Element: Container
---@param self Element
---@return boolean
function Container:getChildrenEventsSorted()
    return self.childrenEventsSorted
end

--- Sets the Whether the children events are sorted
---@generic Element: Container
---@param self Element
---@param childrenEventsSorted boolean
---@return Element
function Container:setChildrenEventsSorted(childrenEventsSorted)
    self.childrenEventsSorted = childrenEventsSorted
    return self
end

--- Gets the The children events of the container
---@generic Element: Container
---@param self Element
---@return table
function Container:getChildrenEvents()
    return self.childrenEvents
end

--- Sets the The children events of the container
---@generic Element: Container
---@param self Element
---@param childrenEvents table
---@return Element
function Container:setChildrenEvents(childrenEvents)
    self.childrenEvents = childrenEvents
    return self
end

--- Gets the The event listener count of the container
---@generic Element: Container
---@param self Element
---@return table
function Container:getEventListenerCount()
    return self.eventListenerCount
end

--- Sets the The event listener count of the container
---@generic Element: Container
---@param self Element
---@param eventListenerCount table
---@return Element
function Container:setEventListenerCount(eventListenerCount)
    self.eventListenerCount = eventListenerCount
    return self
end

--- Gets the The focused child of the container
---@generic Element: Container
---@param self Element
---@return table
function Container:getFocusedChild()
    return self.focusedChild
end

--- Sets the The focused child of the container
---@generic Element: Container
---@param self Element
---@param focusedChild table
---@return Element
function Container:setFocusedChild(focusedChild)
    self.focusedChild = focusedChild
    return self
end

--- Gets the The visible children of the container
---@generic Element: Container
---@param self Element
---@return table
function Container:getVisibleChildren()
    return self.visibleChildren
end

--- Sets the The visible children of the container
---@generic Element: Container
---@param self Element
---@param visibleChildren table
---@return Element
function Container:setVisibleChildren(visibleChildren)
    self.visibleChildren = visibleChildren
    return self
end

--- Gets the The visible children events of the container
---@generic Element: Container
---@param self Element
---@return table
function Container:getVisibleChildrenEvents()
    return self.visibleChildrenEvents
end

--- Sets the The visible children events of the container
---@generic Element: Container
---@param self Element
---@param visibleChildrenEvents table
---@return Element
function Container:setVisibleChildrenEvents(visibleChildrenEvents)
    self.visibleChildrenEvents = visibleChildrenEvents
    return self
end

--- Adds a new Button to the container
---@generic Element: Container
---@param self Element
---@return Button
function Container:addButton()
    return self
end

--- Adds a new Checkbox to the container
---@generic Element: Container
---@param self Element
---@return Checkbox
function Container:addCheckbox()
    return self
end

--- Adds a new Container to the container
---@generic Element: Container
---@param self Element
---@return Container
function Container:addContainer()
    return self
end

--- Adds a new Dropdown to the container
---@generic Element: Container
---@param self Element
---@return Dropdown
function Container:addDropdown()
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

--- Adds a new List to the container
---@generic Element: Container
---@param self Element
---@return List
function Container:addList()
    return self
end

--- Adds a new Menu to the container
---@generic Element: Container
---@param self Element
---@return Menu
function Container:addMenu()
    return self
end

--- Adds a new Program to the container
---@generic Element: Container
---@param self Element
---@return Program
function Container:addProgram()
    return self
end

--- Adds a new ProgressBar to the container
---@generic Element: Container
---@param self Element
---@return ProgressBar
function Container:addProgressBar()
    return self
end

--- Adds a new Slider to the container
---@generic Element: Container
---@param self Element
---@return Slider
function Container:addSlider()
    return self
end

--- Adds a new Table to the container
---@generic Element: Container
---@param self Element
---@return Table
function Container:addTable()
    return self
end

--- Adds a new Tree to the container
---@generic Element: Container
---@param self Element
---@return Tree
function Container:addTree()
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

--- Gets the - offset of view
---@generic Element: Input
---@param self Element
---@return number
function Input:getViewOffset()
    return self.viewOffset
end

--- Sets the - offset of view
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


---@class List
---@field items table
---@field selectedIndex number
---@field selectable boolean
---@field offset number
---@field selectedColor color
local List = {}

--- Gets the of items to display
---@generic Element: List
---@param self Element
---@return table
function List:getItems()
    return self.items
end

--- Sets the of items to display
---@generic Element: List
---@param self Element
---@param items table
---@return Element
function List:setItems(items)
    self.items = items
    return self
end

--- Gets the selected item index
---@generic Element: List
---@param self Element
---@return number
function List:getSelectedIndex()
    return self.selectedIndex
end

--- Sets the selected item index
---@generic Element: List
---@param self Element
---@param selectedIndex number
---@return Element
function List:setSelectedIndex(selectedIndex)
    self.selectedIndex = selectedIndex
    return self
end

--- Gets the items can be selected
---@generic Element: List
---@param self Element
---@return boolean
function List:getSelectable()
    return self.selectable
end

--- Sets the items can be selected
---@generic Element: List
---@param self Element
---@param selectable boolean
---@return Element
function List:setSelectable(selectable)
    self.selectable = selectable
    return self
end

--- Gets the offset
---@generic Element: List
---@param self Element
---@return number
function List:getOffset()
    return self.offset
end

--- Sets the offset
---@generic Element: List
---@param self Element
---@param offset number
---@return Element
function List:setOffset(offset)
    self.offset = offset
    return self
end

--- Gets the for selected item
---@generic Element: List
---@param self Element
---@return color
function List:getSelectedColor()
    return self.selectedColor
end

--- Sets the for selected item
---@generic Element: List
---@param self Element
---@param selectedColor color
---@return Element
function List:setSelectedColor(selectedColor)
    self.selectedColor = selectedColor
    return self
end


---@class ProgressBar
---@field progress number
---@field showPercentage boolean
---@field progressColor color
local ProgressBar = {}

--- Gets the progress (0-100)
---@generic Element: ProgressBar
---@param self Element
---@return number
function ProgressBar:getProgress()
    return self.progress
end

--- Sets the progress (0-100)
---@generic Element: ProgressBar
---@param self Element
---@param progress number
---@return Element
function ProgressBar:setProgress(progress)
    self.progress = progress
    return self
end

--- Gets the percentage text
---@generic Element: ProgressBar
---@param self Element
---@return boolean
function ProgressBar:getShowPercentage()
    return self.showPercentage
end

--- Sets the percentage text
---@generic Element: ProgressBar
---@param self Element
---@param showPercentage boolean
---@return Element
function ProgressBar:setShowPercentage(showPercentage)
    self.showPercentage = showPercentage
    return self
end

--- Gets the bar color
---@generic Element: ProgressBar
---@param self Element
---@return color
function ProgressBar:getProgressColor()
    return self.progressColor
end

--- Sets the bar color
---@generic Element: ProgressBar
---@param self Element
---@param progressColor color
---@return Element
function ProgressBar:setProgressColor(progressColor)
    self.progressColor = progressColor
    return self
end


---@class Slider
---@field step number
---@field max number
---@field horizontal boolean
---@field barColor color
---@field sliderColor color
local Slider = {}

--- Gets the Current step position (1 to width/height)
---@generic Element: Slider
---@param self Element
---@return number
function Slider:getStep()
    return self.step
end

--- Sets the Current step position (1 to width/height)
---@generic Element: Slider
---@param self Element
---@param step number
---@return Element
function Slider:setStep(step)
    self.step = step
    return self
end

--- Gets the Maximum value for value conversion
---@generic Element: Slider
---@param self Element
---@return number
function Slider:getMax()
    return self.max
end

--- Sets the Maximum value for value conversion
---@generic Element: Slider
---@param self Element
---@param max number
---@return Element
function Slider:setMax(max)
    self.max = max
    return self
end

--- Gets the Whether the slider is horizontal
---@generic Element: Slider
---@param self Element
---@return boolean
function Slider:getHorizontal()
    return self.horizontal
end

--- Sets the Whether the slider is horizontal
---@generic Element: Slider
---@param self Element
---@param horizontal boolean
---@return Element
function Slider:setHorizontal(horizontal)
    self.horizontal = horizontal
    return self
end

--- Gets the Colors for the slider bar
---@generic Element: Slider
---@param self Element
---@return color
function Slider:getBarColor()
    return self.barColor
end

--- Sets the Colors for the slider bar
---@generic Element: Slider
---@param self Element
---@param barColor color
---@return Element
function Slider:setBarColor(barColor)
    self.barColor = barColor
    return self
end

--- Gets the color of the slider handle
---@generic Element: Slider
---@param self Element
---@return color
function Slider:getSliderColor()
    return self.sliderColor
end

--- Sets the color of the slider handle
---@generic Element: Slider
---@param self Element
---@param sliderColor color
---@return Element
function Slider:setSliderColor(sliderColor)
    self.sliderColor = sliderColor
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
---@field backgroundEnabled boolean
---@field focused boolean
---@field visible boolean
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
---@return boolean
function VisualElement:getClicked()
    return self.clicked
end

--- Sets the false element is currently clicked
---@generic Element: VisualElement
---@param self Element
---@param clicked boolean
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

--- Gets the whether the element is visible
---@generic Element: VisualElement
---@param self Element
---@return boolean
function VisualElement:getVisible()
    return self.visible
end

--- Sets the whether the element is visible
---@generic Element: VisualElement
---@param self Element
---@param visible boolean
---@return Element
function VisualElement:setVisible(visible)
    self.visible = visible
    return self
end

--- {button number, x number, y number} Fired when the element is clicked
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onOnMouseClick(callback)
    return self
end

--- {button number, x number, y number} Fired when the mouse is released
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onOnMouseUp(callback)
    return self
end

--- {button number, x number, y number} Fired when the mouse is released
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onOnMouseRelease(callback)
    return self
end

--- {button number, x number, y number} Fired when the mouse is dragged
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onOnMouseDrag(callback)
    return self
end

--- {-} Fired when the element is focused
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onOnFocus(callback)
    return self
end

--- {-} Fired when the element is blurred
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onOnBlur(callback)
    return self
end

--- {key number, code number, isRepeat boolean} Fired when a key is pressed
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onOnKey(callback)
    return self
end

--- {key number, code number} Fired when a key is released
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onOnKeyUp(callback)
    return self
end

--- {char string} Fired when a key is pressed
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onOnChar(callback)
    return self
end

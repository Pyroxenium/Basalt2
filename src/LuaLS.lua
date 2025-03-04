---@class BaseFrame
---@field text term
local BaseFrame = {}

--- Gets the The terminal object to render to
---@generic Element: BaseFrame
---@param self Element
---@return term
function BaseFrame:getText()
    return self.text
end

--- Sets the The terminal object to render to
---@generic Element: BaseFrame
---@param self Element
---@param text term
---@return Element
function BaseFrame:setText(text)
    self.text = text
    return self
end


---@class BigFontText
---@field text string
---@field fontSize number
local BigFontText = {}

--- Gets the BigFont text
---@generic Element: BigFontText
---@param self Element
---@return string
function BigFontText:getText()
    return self.text
end

--- Sets the BigFont text
---@generic Element: BigFontText
---@param self Element
---@param text string
---@return Element
function BigFontText:setText(text)
    self.text = text
    return self
end

--- Gets the The font size of the BigFont
---@generic Element: BigFontText
---@param self Element
---@return number
function BigFontText:getFontSize()
    return self.fontSize
end

--- Sets the The font size of the BigFont
---@generic Element: BigFontText
---@param self Element
---@param fontSize number
---@return Element
function BigFontText:setFontSize(fontSize)
    self.fontSize = fontSize
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


---@class Checkbox
---@field checked boolean
---@field text string
---@field checkedText string
---@field autoSize boolean
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

--- Gets the Text to display
---@generic Element: Checkbox
---@param self Element
---@return string
function Checkbox:getText()
    return self.text
end

--- Sets the Text to display
---@generic Element: Checkbox
---@param self Element
---@param text string
---@return Element
function Checkbox:setText(text)
    self.text = text
    return self
end

--- Gets the when checked
---@generic Element: Checkbox
---@param self Element
---@return string
function Checkbox:getCheckedText()
    return self.checkedText
end

--- Sets the when checked
---@generic Element: Checkbox
---@param self Element
---@param checkedText string
---@return Element
function Checkbox:setCheckedText(checkedText)
    self.checkedText = checkedText
    return self
end

--- Gets the Whether to automatically size the checkbox
---@generic Element: Checkbox
---@param self Element
---@return boolean
function Checkbox:getAutoSize()
    return self.autoSize
end

--- Sets the Whether to automatically size the checkbox
---@generic Element: Checkbox
---@param self Element
---@param autoSize boolean
---@return Element
function Checkbox:setAutoSize(autoSize)
    self.autoSize = autoSize
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
---@field offsetX number
---@field offsetY number
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

--- Gets the Horizontal content offset
---@generic Element: Container
---@param self Element
---@return number
function Container:getOffsetX()
    return self.offsetX
end

--- Sets the Horizontal content offset
---@generic Element: Container
---@param self Element
---@param offsetX number
---@return Element
function Container:setOffsetX(offsetX)
    self.offsetX = offsetX
    return self
end

--- Gets the Vertical content offset
---@generic Element: Container
---@param self Element
---@return number
function Container:getOffsetY()
    return self.offsetY
end

--- Sets the Vertical content offset
---@generic Element: Container
---@param self Element
---@param offsetY number
---@return Element
function Container:setOffsetY(offsetY)
    self.offsetY = offsetY
    return self
end

--- Gets the Combined property for offsetX and offsetY
---@generic Element: Container
---@param self Element
---@return offsetY offsetX
function Container:getOffset()
    return self.offsetX
end

--- Sets the Combined property for offsetX and offsetY
---@generic Element: Container
---@param self Element
---@param offsetX offsetY
---@return Element
function Container:setOffset(offsetX)
    self.offsetX = offsetX
    return self
end

--- Adds a new BigFontText to the container
---@generic Element: Container
---@param self Element
---@return BigFontText
function Container:addBigFontText()
    return self
end

--- Adds a new delayed BigFontText to the container
---@generic Element: Container
---@param self Element
---@return BigFontText
function Container:addDelayedBigFontText()
    return self
end

--- Adds a new Button to the container
---@generic Element: Container
---@param self Element
---@return Button
function Container:addButton()
    return self
end

--- Adds a new delayed Button to the container
---@generic Element: Container
---@param self Element
---@return Button
function Container:addDelayedButton()
    return self
end

--- Adds a new Checkbox to the container
---@generic Element: Container
---@param self Element
---@return Checkbox
function Container:addCheckbox()
    return self
end

--- Adds a new delayed Checkbox to the container
---@generic Element: Container
---@param self Element
---@return Checkbox
function Container:addDelayedCheckbox()
    return self
end

--- Adds a new Container to the container
---@generic Element: Container
---@param self Element
---@return Container
function Container:addContainer()
    return self
end

--- Adds a new delayed Container to the container
---@generic Element: Container
---@param self Element
---@return Container
function Container:addDelayedContainer()
    return self
end

--- Adds a new Dropdown to the container
---@generic Element: Container
---@param self Element
---@return Dropdown
function Container:addDropdown()
    return self
end

--- Adds a new delayed Dropdown to the container
---@generic Element: Container
---@param self Element
---@return Dropdown
function Container:addDelayedDropdown()
    return self
end

--- Adds a new Flexbox to the container
---@generic Element: Container
---@param self Element
---@return Flexbox
function Container:addFlexbox()
    return self
end

--- Adds a new delayed Flexbox to the container
---@generic Element: Container
---@param self Element
---@return Flexbox
function Container:addDelayedFlexbox()
    return self
end

--- Adds a new Frame to the container
---@generic Element: Container
---@param self Element
---@return Frame
function Container:addFrame()
    return self
end

--- Adds a new delayed Frame to the container
---@generic Element: Container
---@param self Element
---@return Frame
function Container:addDelayedFrame()
    return self
end

--- Adds a new Image to the container
---@generic Element: Container
---@param self Element
---@return Image
function Container:addImage()
    return self
end

--- Adds a new delayed Image to the container
---@generic Element: Container
---@param self Element
---@return Image
function Container:addDelayedImage()
    return self
end

--- Adds a new Input to the container
---@generic Element: Container
---@param self Element
---@return Input
function Container:addInput()
    return self
end

--- Adds a new delayed Input to the container
---@generic Element: Container
---@param self Element
---@return Input
function Container:addDelayedInput()
    return self
end

--- Adds a new Label to the container
---@generic Element: Container
---@param self Element
---@return Label
function Container:addLabel()
    return self
end

--- Adds a new delayed Label to the container
---@generic Element: Container
---@param self Element
---@return Label
function Container:addDelayedLabel()
    return self
end

--- Adds a new List to the container
---@generic Element: Container
---@param self Element
---@return List
function Container:addList()
    return self
end

--- Adds a new delayed List to the container
---@generic Element: Container
---@param self Element
---@return List
function Container:addDelayedList()
    return self
end

--- Adds a new Menu to the container
---@generic Element: Container
---@param self Element
---@return Menu
function Container:addMenu()
    return self
end

--- Adds a new delayed Menu to the container
---@generic Element: Container
---@param self Element
---@return Menu
function Container:addDelayedMenu()
    return self
end

--- Adds a new Program to the container
---@generic Element: Container
---@param self Element
---@return Program
function Container:addProgram()
    return self
end

--- Adds a new delayed Program to the container
---@generic Element: Container
---@param self Element
---@return Program
function Container:addDelayedProgram()
    return self
end

--- Adds a new ProgressBar to the container
---@generic Element: Container
---@param self Element
---@return ProgressBar
function Container:addProgressBar()
    return self
end

--- Adds a new delayed ProgressBar to the container
---@generic Element: Container
---@param self Element
---@return ProgressBar
function Container:addDelayedProgressBar()
    return self
end

--- Adds a new Scrollbar to the container
---@generic Element: Container
---@param self Element
---@return Scrollbar
function Container:addScrollbar()
    return self
end

--- Adds a new delayed Scrollbar to the container
---@generic Element: Container
---@param self Element
---@return Scrollbar
function Container:addDelayedScrollbar()
    return self
end

--- Adds a new Slider to the container
---@generic Element: Container
---@param self Element
---@return Slider
function Container:addSlider()
    return self
end

--- Adds a new delayed Slider to the container
---@generic Element: Container
---@param self Element
---@return Slider
function Container:addDelayedSlider()
    return self
end

--- Adds a new Table to the container
---@generic Element: Container
---@param self Element
---@return Table
function Container:addTable()
    return self
end

--- Adds a new delayed Table to the container
---@generic Element: Container
---@param self Element
---@return Table
function Container:addDelayedTable()
    return self
end

--- Adds a new TextBox to the container
---@generic Element: Container
---@param self Element
---@return TextBox
function Container:addTextBox()
    return self
end

--- Adds a new delayed TextBox to the container
---@generic Element: Container
---@param self Element
---@return TextBox
function Container:addDelayedTextBox()
    return self
end

--- Adds a new Tree to the container
---@generic Element: Container
---@param self Element
---@return Tree
function Container:addTree()
    return self
end

--- Adds a new delayed Tree to the container
---@generic Element: Container
---@param self Element
---@return Tree
function Container:addDelayedTree()
    return self
end

--- Adds a new VisualElement to the container
---@generic Element: Container
---@param self Element
---@return VisualElement
function Container:addVisualElement()
    return self
end

--- Adds a new delayed VisualElement to the container
---@generic Element: Container
---@param self Element
---@return VisualElement
function Container:addDelayedVisualElement()
    return self
end


---@class Dropdown
---@field isOpen boolean
---@field dropdownHeight number
---@field selectedText string
---@field dropSymbol string
local Dropdown = {}

--- Gets the Whether the dropdown menu is currently open
---@generic Element: Dropdown
---@param self Element
---@return boolean
function Dropdown:getIsOpen()
    return self.isOpen
end

--- Sets the Whether the dropdown menu is currently open
---@generic Element: Dropdown
---@param self Element
---@param isOpen boolean
---@return Element
function Dropdown:setIsOpen(isOpen)
    self.isOpen = isOpen
    return self
end

--- Gets the Maximum height of the dropdown menu when open
---@generic Element: Dropdown
---@param self Element
---@return number
function Dropdown:getDropdownHeight()
    return self.dropdownHeight
end

--- Sets the Maximum height of the dropdown menu when open
---@generic Element: Dropdown
---@param self Element
---@param dropdownHeight number
---@return Element
function Dropdown:setDropdownHeight(dropdownHeight)
    self.dropdownHeight = dropdownHeight
    return self
end

--- Gets the The text to show when no item is selected
---@generic Element: Dropdown
---@param self Element
---@return string
function Dropdown:getSelectedText()
    return self.selectedText
end

--- Sets the The text to show when no item is selected
---@generic Element: Dropdown
---@param self Element
---@param selectedText string
---@return Element
function Dropdown:setSelectedText(selectedText)
    self.selectedText = selectedText
    return self
end

--- Gets the The symbol to show for dropdown indication
---@generic Element: Dropdown
---@param self Element
---@return string
function Dropdown:getDropSymbol()
    return self.dropSymbol
end

--- Sets the The symbol to show for dropdown indication
---@generic Element: Dropdown
---@param self Element
---@param dropSymbol string
---@return Element
function Dropdown:setDropSymbol(dropSymbol)
    self.dropSymbol = dropSymbol
    return self
end


---@class Flexbox
---@field flexDirection string
---@field flexSpacing number
---@field flexJustifyContent string
---@field flexWrap boolean
---@field flexUpdateLayout boolean
local Flexbox = {}

--- Gets the The direction of the flexbox layout "row" or "column"
---@generic Element: Flexbox
---@param self Element
---@return string
function Flexbox:getFlexDirection()
    return self.flexDirection
end

--- Sets the The direction of the flexbox layout "row" or "column"
---@generic Element: Flexbox
---@param self Element
---@param flexDirection string
---@return Element
function Flexbox:setFlexDirection(flexDirection)
    self.flexDirection = flexDirection
    return self
end

--- Gets the The spacing between flex items
---@generic Element: Flexbox
---@param self Element
---@return number
function Flexbox:getFlexSpacing()
    return self.flexSpacing
end

--- Sets the The spacing between flex items
---@generic Element: Flexbox
---@param self Element
---@param flexSpacing number
---@return Element
function Flexbox:setFlexSpacing(flexSpacing)
    self.flexSpacing = flexSpacing
    return self
end

--- Gets the The alignment of flex items along the main axis
---@generic Element: Flexbox
---@param self Element
---@return string
function Flexbox:getFlexJustifyContent()
    return self.flexJustifyContent
end

--- Sets the The alignment of flex items along the main axis
---@generic Element: Flexbox
---@param self Element
---@param flexJustifyContent string
---@return Element
function Flexbox:setFlexJustifyContent(flexJustifyContent)
    self.flexJustifyContent = flexJustifyContent
    return self
end

--- Gets the Whether to wrap flex items onto multiple lines
---@generic Element: Flexbox
---@param self Element
---@return boolean
function Flexbox:getFlexWrap()
    return self.flexWrap
end

--- Sets the Whether to wrap flex items onto multiple lines
---@generic Element: Flexbox
---@param self Element
---@param flexWrap boolean
---@return Element
function Flexbox:setFlexWrap(flexWrap)
    self.flexWrap = flexWrap
    return self
end

--- Gets the Whether to update the layout of the flexbox
---@generic Element: Flexbox
---@param self Element
---@return boolean
function Flexbox:getFlexUpdateLayout()
    return self.flexUpdateLayout
end

--- Sets the Whether to update the layout of the flexbox
---@generic Element: Flexbox
---@param self Element
---@param flexUpdateLayout boolean
---@return Element
function Flexbox:setFlexUpdateLayout(flexUpdateLayout)
    self.flexUpdateLayout = flexUpdateLayout
    return self
end


---@class Frame
---@field draggable boolean
---@field draggingMap table
local Frame = {}

--- Gets the Whether the frame is draggable
---@generic Element: Frame
---@param self Element
---@return boolean
function Frame:getDraggable()
    return self.draggable
end

--- Sets the Whether the frame is draggable
---@generic Element: Frame
---@param self Element
---@param draggable boolean
---@return Element
function Frame:setDraggable(draggable)
    self.draggable = draggable
    return self
end

--- Gets the The map of dragging positions
---@generic Element: Frame
---@param self Element
---@return table
function Frame:getDraggingMap()
    return self.draggingMap
end

--- Sets the The map of dragging positions
---@generic Element: Frame
---@param self Element
---@param draggingMap table
---@return Element
function Frame:setDraggingMap(draggingMap)
    self.draggingMap = draggingMap
    return self
end


---@class Image
---@field bimg table
---@field currentFrame number
---@field autoResize boolean
---@field offsetX number
---@field offsetY number
local Image = {}

--- Gets the The bimg image data
---@generic Element: Image
---@param self Element
---@return table
function Image:getBimg()
    return self.bimg
end

--- Sets the The bimg image data
---@generic Element: Image
---@param self Element
---@param bimg table
---@return Element
function Image:setBimg(bimg)
    self.bimg = bimg
    return self
end

--- Gets the Current animation frame
---@generic Element: Image
---@param self Element
---@return number
function Image:getCurrentFrame()
    return self.currentFrame
end

--- Sets the Current animation frame
---@generic Element: Image
---@param self Element
---@param currentFrame number
---@return Element
function Image:setCurrentFrame(currentFrame)
    self.currentFrame = currentFrame
    return self
end

--- Gets the Whether to automatically resize the image when content exceeds bounds
---@generic Element: Image
---@param self Element
---@return boolean
function Image:getAutoResize()
    return self.autoResize
end

--- Sets the Whether to automatically resize the image when content exceeds bounds
---@generic Element: Image
---@param self Element
---@param autoResize boolean
---@return Element
function Image:setAutoResize(autoResize)
    self.autoResize = autoResize
    return self
end

--- Gets the Horizontal offset for viewing larger images
---@generic Element: Image
---@param self Element
---@return number
function Image:getOffsetX()
    return self.offsetX
end

--- Sets the Horizontal offset for viewing larger images
---@generic Element: Image
---@param self Element
---@param offsetX number
---@return Element
function Image:setOffsetX(offsetX)
    self.offsetX = offsetX
    return self
end

--- Gets the Vertical offset for viewing larger images
---@generic Element: Image
---@param self Element
---@return number
function Image:getOffsetY()
    return self.offsetY
end

--- Sets the Vertical offset for viewing larger images
---@generic Element: Image
---@param self Element
---@param offsetY number
---@return Element
function Image:setOffsetY(offsetY)
    self.offsetY = offsetY
    return self
end

--- Gets the Combined property for offsetX and offsetY
---@generic Element: Image
---@param self Element
---@return offsetY offsetX
function Image:getOffset()
    return self.offsetX
end

--- Sets the Combined property for offsetX and offsetY
---@generic Element: Image
---@param self Element
---@param offsetX offsetY
---@return Element
function Image:setOffset(offsetX)
    self.offsetX = offsetX
    return self
end


---@class Input
---@field text string
---@field cursorPos number
---@field viewOffset number
---@field placeholder string
---@field placeholderColor color
---@field focusedBackground color
---@field focusedForeground color
---@field cursorColor number
local Input = {}

--- Gets the The current text content of the input
---@generic Element: Input
---@param self Element
---@return string
function Input:getText()
    return self.text
end

--- Sets the The current text content of the input
---@generic Element: Input
---@param self Element
---@param text string
---@return Element
function Input:setText(text)
    self.text = text
    return self
end

--- Gets the The current cursor position in the text
---@generic Element: Input
---@param self Element
---@return number
function Input:getCursorPos()
    return self.cursorPos
end

--- Sets the The current cursor position in the text
---@generic Element: Input
---@param self Element
---@param cursorPos number
---@return Element
function Input:setCursorPos(cursorPos)
    self.cursorPos = cursorPos
    return self
end

--- Gets the The horizontal scroll offset for viewing long text
---@generic Element: Input
---@param self Element
---@return number
function Input:getViewOffset()
    return self.viewOffset
end

--- Sets the The horizontal scroll offset for viewing long text
---@generic Element: Input
---@param self Element
---@param viewOffset number
---@return Element
function Input:setViewOffset(viewOffset)
    self.viewOffset = viewOffset
    return self
end

--- Gets the Text to display when input is empty
---@generic Element: Input
---@param self Element
---@return string
function Input:getPlaceholder()
    return self.placeholder
end

--- Sets the Text to display when input is empty
---@generic Element: Input
---@param self Element
---@param placeholder string
---@return Element
function Input:setPlaceholder(placeholder)
    self.placeholder = placeholder
    return self
end

--- Gets the Color of the placeholder text
---@generic Element: Input
---@param self Element
---@return color
function Input:getPlaceholderColor()
    return self.placeholderColor
end

--- Sets the Color of the placeholder text
---@generic Element: Input
---@param self Element
---@param placeholderColor color
---@return Element
function Input:setPlaceholderColor(placeholderColor)
    self.placeholderColor = placeholderColor
    return self
end

--- Gets the Background color when input is focused
---@generic Element: Input
---@param self Element
---@return color
function Input:getFocusedBackground()
    return self.focusedBackground
end

--- Sets the Background color when input is focused
---@generic Element: Input
---@param self Element
---@param focusedBackground color
---@return Element
function Input:setFocusedBackground(focusedBackground)
    self.focusedBackground = focusedBackground
    return self
end

--- Gets the Foreground color when input is focused
---@generic Element: Input
---@param self Element
---@return color
function Input:getFocusedForeground()
    return self.focusedForeground
end

--- Sets the Foreground color when input is focused
---@generic Element: Input
---@param self Element
---@param focusedForeground color
---@return Element
function Input:setFocusedForeground(focusedForeground)
    self.focusedForeground = focusedForeground
    return self
end

--- Gets the Color of the cursor
---@generic Element: Input
---@param self Element
---@return number
function Input:getCursorColor()
    return self.cursorColor
end

--- Sets the Color of the cursor
---@generic Element: Input
---@param self Element
---@param cursorColor number
---@return Element
function Input:setCursorColor(cursorColor)
    self.cursorColor = cursorColor
    return self
end


---@class Label
---@field text string
---@field autoSize boolean
local Label = {}

--- Gets the The text content to display. Can be a string or a function that returns a string
---@generic Element: Label
---@param self Element
---@return string
function Label:getText()
    return self.text
end

--- Sets the The text content to display. Can be a string or a function that returns a string
---@generic Element: Label
---@param self Element
---@param text string
---@return Element
function Label:setText(text)
    self.text = text
    return self
end

--- Gets the Whether the label should automatically resize its width based on the text content
---@generic Element: Label
---@param self Element
---@return boolean
function Label:getAutoSize()
    return self.autoSize
end

--- Sets the Whether the label should automatically resize its width based on the text content
---@generic Element: Label
---@param self Element
---@param autoSize boolean
---@return Element
function Label:setAutoSize(autoSize)
    self.autoSize = autoSize
    return self
end


---@class List
---@field items table
---@field selectable boolean
---@field multiSelection boolean
---@field offset number
---@field selectedBackground color
---@field selectedForeground color
local List = {}

--- Gets the List of items to display. Items can be tables with properties including selected state
---@generic Element: List
---@param self Element
---@return table
function List:getItems()
    return self.items
end

--- Sets the List of items to display. Items can be tables with properties including selected state
---@generic Element: List
---@param self Element
---@param items table
---@return Element
function List:setItems(items)
    self.items = items
    return self
end

--- Gets the Whether items in the list can be selected
---@generic Element: List
---@param self Element
---@return boolean
function List:getSelectable()
    return self.selectable
end

--- Sets the Whether items in the list can be selected
---@generic Element: List
---@param self Element
---@param selectable boolean
---@return Element
function List:setSelectable(selectable)
    self.selectable = selectable
    return self
end

--- Gets the Whether multiple items can be selected at once
---@generic Element: List
---@param self Element
---@return boolean
function List:getMultiSelection()
    return self.multiSelection
end

--- Sets the Whether multiple items can be selected at once
---@generic Element: List
---@param self Element
---@param multiSelection boolean
---@return Element
function List:setMultiSelection(multiSelection)
    self.multiSelection = multiSelection
    return self
end

--- Gets the Current scroll offset for viewing long lists
---@generic Element: List
---@param self Element
---@return number
function List:getOffset()
    return self.offset
end

--- Sets the Current scroll offset for viewing long lists
---@generic Element: List
---@param self Element
---@param offset number
---@return Element
function List:setOffset(offset)
    self.offset = offset
    return self
end

--- Gets the Background color for selected items
---@generic Element: List
---@param self Element
---@return color
function List:getSelectedBackground()
    return self.selectedBackground
end

--- Sets the Background color for selected items
---@generic Element: List
---@param self Element
---@param selectedBackground color
---@return Element
function List:setSelectedBackground(selectedBackground)
    self.selectedBackground = selectedBackground
    return self
end

--- Gets the Text color for selected items
---@generic Element: List
---@param self Element
---@return color
function List:getSelectedForeground()
    return self.selectedForeground
end

--- Sets the Text color for selected items
---@generic Element: List
---@param self Element
---@param selectedForeground color
---@return Element
function List:setSelectedForeground(selectedForeground)
    self.selectedForeground = selectedForeground
    return self
end

--- {index number, item table} Fired when an item is selected
---@generic Element: List
---@param self Element
---@param callback function
---@return Element
function List:onSelect(callback)
    return self
end


---@class Menu
---@field separatorColor color
local Menu = {}

--- Gets the The color used for separator items in the menu
---@generic Element: Menu
---@param self Element
---@return color
function Menu:getSeparatorColor()
    return self.separatorColor
end

--- Sets the The color used for separator items in the menu
---@generic Element: Menu
---@param self Element
---@param separatorColor color
---@return Element
function Menu:setSeparatorColor(separatorColor)
    self.separatorColor = separatorColor
    return self
end


---@class ProgressBar
---@field progress number
---@field showPercentage boolean
---@field progressColor color
local ProgressBar = {}

--- Gets the Current progress value (0-100)
---@generic Element: ProgressBar
---@param self Element
---@return number
function ProgressBar:getProgress()
    return self.progress
end

--- Sets the Current progress value (0-100)
---@generic Element: ProgressBar
---@param self Element
---@param progress number
---@return Element
function ProgressBar:setProgress(progress)
    self.progress = progress
    return self
end

--- Gets the Whether to show the percentage text in the center
---@generic Element: ProgressBar
---@param self Element
---@return boolean
function ProgressBar:getShowPercentage()
    return self.showPercentage
end

--- Sets the Whether to show the percentage text in the center
---@generic Element: ProgressBar
---@param self Element
---@param showPercentage boolean
---@return Element
function ProgressBar:setShowPercentage(showPercentage)
    self.showPercentage = showPercentage
    return self
end

--- Gets the The color used for the filled portion of the progress bar
---@generic Element: ProgressBar
---@param self Element
---@return color
function ProgressBar:getProgressColor()
    return self.progressColor
end

--- Sets the The color used for the filled portion of the progress bar
---@generic Element: ProgressBar
---@param self Element
---@param progressColor color
---@return Element
function ProgressBar:setProgressColor(progressColor)
    self.progressColor = progressColor
    return self
end


---@class Scrollbar
---@field value number
---@field min number
---@field max number
---@field step number
---@field dragMultiplier number
---@field symbol string
---@field backgroundSymbol string
---@field symbolBackgroundColor color
---@field backgroundSymbol string
---@field orientation string
---@field handleSize number
local Scrollbar = {}

--- Gets the Current scroll value
---@generic Element: Scrollbar
---@param self Element
---@return number
function Scrollbar:getValue()
    return self.value
end

--- Sets the Current scroll value
---@generic Element: Scrollbar
---@param self Element
---@param value number
---@return Element
function Scrollbar:setValue(value)
    self.value = value
    return self
end

--- Gets the Minimum scroll value
---@generic Element: Scrollbar
---@param self Element
---@return number
function Scrollbar:getMin()
    return self.min
end

--- Sets the Minimum scroll value
---@generic Element: Scrollbar
---@param self Element
---@param min number
---@return Element
function Scrollbar:setMin(min)
    self.min = min
    return self
end

--- Gets the Maximum scroll value
---@generic Element: Scrollbar
---@param self Element
---@return number
function Scrollbar:getMax()
    return self.max
end

--- Sets the Maximum scroll value
---@generic Element: Scrollbar
---@param self Element
---@param max number
---@return Element
function Scrollbar:setMax(max)
    self.max = max
    return self
end

--- Gets the Step size for scroll operations
---@generic Element: Scrollbar
---@param self Element
---@return number
function Scrollbar:getStep()
    return self.step
end

--- Sets the Step size for scroll operations
---@generic Element: Scrollbar
---@param self Element
---@param step number
---@return Element
function Scrollbar:setStep(step)
    self.step = step
    return self
end

--- Gets the How fast the scrollbar moves when dragging
---@generic Element: Scrollbar
---@param self Element
---@return number
function Scrollbar:getDragMultiplier()
    return self.dragMultiplier
end

--- Sets the How fast the scrollbar moves when dragging
---@generic Element: Scrollbar
---@param self Element
---@param dragMultiplier number
---@return Element
function Scrollbar:setDragMultiplier(dragMultiplier)
    self.dragMultiplier = dragMultiplier
    return self
end

--- Gets the " Symbol used for the scrollbar handle
---@generic Element: Scrollbar
---@param self Element
---@return string
function Scrollbar:getSymbol()
    return self.symbol
end

--- Sets the " Symbol used for the scrollbar handle
---@generic Element: Scrollbar
---@param self Element
---@param symbol string
---@return Element
function Scrollbar:setSymbol(symbol)
    self.symbol = symbol
    return self
end

--- Gets the Symbol used for the scrollbar background
---@generic Element: Scrollbar
---@param self Element
---@return string
function Scrollbar:getBackgroundSymbol()
    return self.backgroundSymbol
end

--- Sets the Symbol used for the scrollbar background
---@generic Element: Scrollbar
---@param self Element
---@param backgroundSymbol string
---@return Element
function Scrollbar:setBackgroundSymbol(backgroundSymbol)
    self.backgroundSymbol = backgroundSymbol
    return self
end

--- Gets the Background color of the scrollbar handle
---@generic Element: Scrollbar
---@param self Element
---@return color
function Scrollbar:getSymbolBackgroundColor()
    return self.symbolBackgroundColor
end

--- Sets the Background color of the scrollbar handle
---@generic Element: Scrollbar
---@param self Element
---@param symbolBackgroundColor color
---@return Element
function Scrollbar:setSymbolBackgroundColor(symbolBackgroundColor)
    self.symbolBackgroundColor = symbolBackgroundColor
    return self
end

--- Gets the Symbol used for the scrollbar background
---@generic Element: Scrollbar
---@param self Element
---@return string
function Scrollbar:getBackgroundSymbol()
    return self.backgroundSymbol
end

--- Sets the Symbol used for the scrollbar background
---@generic Element: Scrollbar
---@param self Element
---@param backgroundSymbol string
---@return Element
function Scrollbar:setBackgroundSymbol(backgroundSymbol)
    self.backgroundSymbol = backgroundSymbol
    return self
end

--- Gets the Orientation of the scrollbar ("vertical" or "horizontal")
---@generic Element: Scrollbar
---@param self Element
---@return string
function Scrollbar:getOrientation()
    return self.orientation
end

--- Sets the Orientation of the scrollbar ("vertical" or "horizontal")
---@generic Element: Scrollbar
---@param self Element
---@param orientation string
---@return Element
function Scrollbar:setOrientation(orientation)
    self.orientation = orientation
    return self
end

--- Gets the Size of the scrollbar handle in characters
---@generic Element: Scrollbar
---@param self Element
---@return number
function Scrollbar:getHandleSize()
    return self.handleSize
end

--- Sets the Size of the scrollbar handle in characters
---@generic Element: Scrollbar
---@param self Element
---@param handleSize number
---@return Element
function Scrollbar:setHandleSize(handleSize)
    self.handleSize = handleSize
    return self
end


---@class Slider
---@field step number
---@field max number
---@field horizontal boolean
---@field barColor color
---@field sliderColor color
local Slider = {}

--- Gets the Current position of the slider handle (1 to width/height)
---@generic Element: Slider
---@param self Element
---@return number
function Slider:getStep()
    return self.step
end

--- Sets the Current position of the slider handle (1 to width/height)
---@generic Element: Slider
---@param self Element
---@param step number
---@return Element
function Slider:setStep(step)
    self.step = step
    return self
end

--- Gets the Maximum value for value conversion (maps slider position to this range)
---@generic Element: Slider
---@param self Element
---@return number
function Slider:getMax()
    return self.max
end

--- Sets the Maximum value for value conversion (maps slider position to this range)
---@generic Element: Slider
---@param self Element
---@param max number
---@return Element
function Slider:setMax(max)
    self.max = max
    return self
end

--- Gets the Whether the slider is horizontal (false for vertical)
---@generic Element: Slider
---@param self Element
---@return boolean
function Slider:getHorizontal()
    return self.horizontal
end

--- Sets the Whether the slider is horizontal (false for vertical)
---@generic Element: Slider
---@param self Element
---@param horizontal boolean
---@return Element
function Slider:setHorizontal(horizontal)
    self.horizontal = horizontal
    return self
end

--- Gets the Color of the slider track
---@generic Element: Slider
---@param self Element
---@return color
function Slider:getBarColor()
    return self.barColor
end

--- Sets the Color of the slider track
---@generic Element: Slider
---@param self Element
---@param barColor color
---@return Element
function Slider:setBarColor(barColor)
    self.barColor = barColor
    return self
end

--- Gets the Color of the slider handle
---@generic Element: Slider
---@param self Element
---@return color
function Slider:getSliderColor()
    return self.sliderColor
end

--- Sets the Color of the slider handle
---@generic Element: Slider
---@param self Element
---@param sliderColor color
---@return Element
function Slider:setSliderColor(sliderColor)
    self.sliderColor = sliderColor
    return self
end

--- {value number} Fired when the slider value changes
---@generic Element: Slider
---@param self Element
---@param callback function
---@return Element
function Slider:onChange(callback)
    return self
end


---@class Table
---@field columns table
---@field data table
---@field headerColor color
---@field selectedColor color
---@field gridColor color
---@field sortDirection string
---@field scrollOffset number
local Table = {}

--- Gets the List of column definitions with {name, width} properties
---@generic Element: Table
---@param self Element
---@return table
function Table:getColumns()
    return self.columns
end

--- Sets the List of column definitions with {name, width} properties
---@generic Element: Table
---@param self Element
---@param columns table
---@return Element
function Table:setColumns(columns)
    self.columns = columns
    return self
end

--- Gets the The table data as array of row arrays
---@generic Element: Table
---@param self Element
---@return table
function Table:getData()
    return self.data
end

--- Sets the The table data as array of row arrays
---@generic Element: Table
---@param self Element
---@param data table
---@return Element
function Table:setData(data)
    self.data = data
    return self
end

--- Gets the Color of the column headers
---@generic Element: Table
---@param self Element
---@return color
function Table:getHeaderColor()
    return self.headerColor
end

--- Sets the Color of the column headers
---@generic Element: Table
---@param self Element
---@param headerColor color
---@return Element
function Table:setHeaderColor(headerColor)
    self.headerColor = headerColor
    return self
end

--- Gets the Background color of selected row
---@generic Element: Table
---@param self Element
---@return color
function Table:getSelectedColor()
    return self.selectedColor
end

--- Sets the Background color of selected row
---@generic Element: Table
---@param self Element
---@param selectedColor color
---@return Element
function Table:setSelectedColor(selectedColor)
    self.selectedColor = selectedColor
    return self
end

--- Gets the Color of grid lines
---@generic Element: Table
---@param self Element
---@return color
function Table:getGridColor()
    return self.gridColor
end

--- Sets the Color of grid lines
---@generic Element: Table
---@param self Element
---@param gridColor color
---@return Element
function Table:setGridColor(gridColor)
    self.gridColor = gridColor
    return self
end

--- Gets the Sort direction ("asc" or "desc")
---@generic Element: Table
---@param self Element
---@return string
function Table:getSortDirection()
    return self.sortDirection
end

--- Sets the Sort direction ("asc" or "desc")
---@generic Element: Table
---@param self Element
---@param sortDirection string
---@return Element
function Table:setSortDirection(sortDirection)
    self.sortDirection = sortDirection
    return self
end

--- Gets the Current scroll position
---@generic Element: Table
---@param self Element
---@return number
function Table:getScrollOffset()
    return self.scrollOffset
end

--- Sets the Current scroll position
---@generic Element: Table
---@param self Element
---@param scrollOffset number
---@return Element
function Table:setScrollOffset(scrollOffset)
    self.scrollOffset = scrollOffset
    return self
end


---@class TextBox
---@field lines table
---@field cursorX number
---@field cursorY number
---@field scrollX number
---@field scrollY number
---@field editable boolean
---@field syntaxPatterns table
---@field cursorColor number
local TextBox = {}

--- Gets the Array of text lines
---@generic Element: TextBox
---@param self Element
---@return table
function TextBox:getLines()
    return self.lines
end

--- Sets the Array of text lines
---@generic Element: TextBox
---@param self Element
---@param lines table
---@return Element
function TextBox:setLines(lines)
    self.lines = lines
    return self
end

--- Gets the Cursor X position
---@generic Element: TextBox
---@param self Element
---@return number
function TextBox:getCursorX()
    return self.cursorX
end

--- Sets the Cursor X position
---@generic Element: TextBox
---@param self Element
---@param cursorX number
---@return Element
function TextBox:setCursorX(cursorX)
    self.cursorX = cursorX
    return self
end

--- Gets the Cursor Y position (line number)
---@generic Element: TextBox
---@param self Element
---@return number
function TextBox:getCursorY()
    return self.cursorY
end

--- Sets the Cursor Y position (line number)
---@generic Element: TextBox
---@param self Element
---@param cursorY number
---@return Element
function TextBox:setCursorY(cursorY)
    self.cursorY = cursorY
    return self
end

--- Gets the Horizontal scroll offset
---@generic Element: TextBox
---@param self Element
---@return number
function TextBox:getScrollX()
    return self.scrollX
end

--- Sets the Horizontal scroll offset
---@generic Element: TextBox
---@param self Element
---@param scrollX number
---@return Element
function TextBox:setScrollX(scrollX)
    self.scrollX = scrollX
    return self
end

--- Gets the Vertical scroll offset
---@generic Element: TextBox
---@param self Element
---@return number
function TextBox:getScrollY()
    return self.scrollY
end

--- Sets the Vertical scroll offset
---@generic Element: TextBox
---@param self Element
---@param scrollY number
---@return Element
function TextBox:setScrollY(scrollY)
    self.scrollY = scrollY
    return self
end

--- Gets the Whether text can be edited
---@generic Element: TextBox
---@param self Element
---@return boolean
function TextBox:getEditable()
    return self.editable
end

--- Sets the Whether text can be edited
---@generic Element: TextBox
---@param self Element
---@param editable boolean
---@return Element
function TextBox:setEditable(editable)
    self.editable = editable
    return self
end

--- Gets the Syntax highlighting patterns
---@generic Element: TextBox
---@param self Element
---@return table
function TextBox:getSyntaxPatterns()
    return self.syntaxPatterns
end

--- Sets the Syntax highlighting patterns
---@generic Element: TextBox
---@param self Element
---@param syntaxPatterns table
---@return Element
function TextBox:setSyntaxPatterns(syntaxPatterns)
    self.syntaxPatterns = syntaxPatterns
    return self
end

--- Gets the Color of the cursor
---@generic Element: TextBox
---@param self Element
---@return number
function TextBox:getCursorColor()
    return self.cursorColor
end

--- Sets the Color of the cursor
---@generic Element: TextBox
---@param self Element
---@param cursorColor number
---@return Element
function TextBox:setCursorColor(cursorColor)
    self.cursorColor = cursorColor
    return self
end


---@class Tree
---@field nodes table
---@field expandedNodes table
---@field scrollOffset number
---@field horizontalOffset number
---@field nodeColor color
---@field selectedColor color
local Tree = {}

--- Gets the The tree structure containing node objects with {text, children} properties
---@generic Element: Tree
---@param self Element
---@return table
function Tree:getNodes()
    return self.nodes
end

--- Sets the The tree structure containing node objects with {text, children} properties
---@generic Element: Tree
---@param self Element
---@param nodes table
---@return Element
function Tree:setNodes(nodes)
    self.nodes = nodes
    return self
end

--- Gets the Table of nodes that are currently expanded
---@generic Element: Tree
---@param self Element
---@return table
function Tree:getExpandedNodes()
    return self.expandedNodes
end

--- Sets the Table of nodes that are currently expanded
---@generic Element: Tree
---@param self Element
---@param expandedNodes table
---@return Element
function Tree:setExpandedNodes(expandedNodes)
    self.expandedNodes = expandedNodes
    return self
end

--- Gets the Current vertical scroll position
---@generic Element: Tree
---@param self Element
---@return number
function Tree:getScrollOffset()
    return self.scrollOffset
end

--- Sets the Current vertical scroll position
---@generic Element: Tree
---@param self Element
---@param scrollOffset number
---@return Element
function Tree:setScrollOffset(scrollOffset)
    self.scrollOffset = scrollOffset
    return self
end

--- Gets the Current horizontal scroll position
---@generic Element: Tree
---@param self Element
---@return number
function Tree:getHorizontalOffset()
    return self.horizontalOffset
end

--- Sets the Current horizontal scroll position
---@generic Element: Tree
---@param self Element
---@param horizontalOffset number
---@return Element
function Tree:setHorizontalOffset(horizontalOffset)
    self.horizontalOffset = horizontalOffset
    return self
end

--- Gets the Color of unselected nodes
---@generic Element: Tree
---@param self Element
---@return color
function Tree:getNodeColor()
    return self.nodeColor
end

--- Sets the Color of unselected nodes
---@generic Element: Tree
---@param self Element
---@param nodeColor color
---@return Element
function Tree:setNodeColor(nodeColor)
    self.nodeColor = nodeColor
    return self
end

--- Gets the Background color of selected node
---@generic Element: Tree
---@param self Element
---@return color
function Tree:getSelectedColor()
    return self.selectedColor
end

--- Sets the Background color of selected node
---@generic Element: Tree
---@param self Element
---@param selectedColor color
---@return Element
function Tree:setSelectedColor(selectedColor)
    self.selectedColor = selectedColor
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
---@field hover boolean
---@field backgroundEnabled boolean
---@field focused boolean
---@field visible boolean
---@field ignoreOffset boolean
local VisualElement = {}

--- Gets the The horizontal position relative to parent
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getX()
    return self.x
end

--- Sets the The horizontal position relative to parent
---@generic Element: VisualElement
---@param self Element
---@param x number
---@return Element
function VisualElement:setX(x)
    self.x = x
    return self
end

--- Gets the The vertical position relative to parent
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getY()
    return self.y
end

--- Sets the The vertical position relative to parent
---@generic Element: VisualElement
---@param self Element
---@param y number
---@return Element
function VisualElement:setY(y)
    self.y = y
    return self
end

--- Gets the The z-index for layering elements
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getZ()
    return self.z
end

--- Sets the The z-index for layering elements
---@generic Element: VisualElement
---@param self Element
---@param z number
---@return Element
function VisualElement:setZ(z)
    self.z = z
    return self
end

--- Gets the The width of the element
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getWidth()
    return self.width
end

--- Sets the The width of the element
---@generic Element: VisualElement
---@param self Element
---@param width number
---@return Element
function VisualElement:setWidth(width)
    self.width = width
    return self
end

--- Gets the The height of the element
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getHeight()
    return self.height
end

--- Sets the The height of the element
---@generic Element: VisualElement
---@param self Element
---@param height number
---@return Element
function VisualElement:setHeight(height)
    self.height = height
    return self
end

--- Gets the The background color
---@generic Element: VisualElement
---@param self Element
---@return color
function VisualElement:getBackground()
    return self.background
end

--- Sets the The background color
---@generic Element: VisualElement
---@param self Element
---@param background color
---@return Element
function VisualElement:setBackground(background)
    self.background = background
    return self
end

--- Gets the The text/foreground color
---@generic Element: VisualElement
---@param self Element
---@return color
function VisualElement:getForeground()
    return self.foreground
end

--- Sets the The text/foreground color
---@generic Element: VisualElement
---@param self Element
---@param foreground color
---@return Element
function VisualElement:setForeground(foreground)
    self.foreground = foreground
    return self
end

--- Gets the Whether the element is currently clicked
---@generic Element: VisualElement
---@param self Element
---@return boolean
function VisualElement:getClicked()
    return self.clicked
end

--- Sets the Whether the element is currently clicked
---@generic Element: VisualElement
---@param self Element
---@param clicked boolean
---@return Element
function VisualElement:setClicked(clicked)
    self.clicked = clicked
    return self
end

--- Gets the Whether the mouse is currently hover over the element (Craftos-PC only)
---@generic Element: VisualElement
---@param self Element
---@return boolean
function VisualElement:getHover()
    return self.hover
end

--- Sets the Whether the mouse is currently hover over the element (Craftos-PC only)
---@generic Element: VisualElement
---@param self Element
---@param hover boolean
---@return Element
function VisualElement:setHover(hover)
    self.hover = hover
    return self
end

--- Gets the Whether to render the background
---@generic Element: VisualElement
---@param self Element
---@return boolean
function VisualElement:getBackgroundEnabled()
    return self.backgroundEnabled
end

--- Sets the Whether to render the background
---@generic Element: VisualElement
---@param self Element
---@param backgroundEnabled boolean
---@return Element
function VisualElement:setBackgroundEnabled(backgroundEnabled)
    self.backgroundEnabled = backgroundEnabled
    return self
end

--- Gets the Whether the element has input focus
---@generic Element: VisualElement
---@param self Element
---@return boolean
function VisualElement:getFocused()
    return self.focused
end

--- Sets the Whether the element has input focus
---@generic Element: VisualElement
---@param self Element
---@param focused boolean
---@return Element
function VisualElement:setFocused(focused)
    self.focused = focused
    return self
end

--- Gets the Whether the element is visible
---@generic Element: VisualElement
---@param self Element
---@return boolean
function VisualElement:getVisible()
    return self.visible
end

--- Sets the Whether the element is visible
---@generic Element: VisualElement
---@param self Element
---@param visible boolean
---@return Element
function VisualElement:setVisible(visible)
    self.visible = visible
    return self
end

--- Gets the Whether to ignore the parent's offset
---@generic Element: VisualElement
---@param self Element
---@return boolean
function VisualElement:getIgnoreOffset()
    return self.ignoreOffset
end

--- Sets the Whether to ignore the parent's offset
---@generic Element: VisualElement
---@param self Element
---@param ignoreOffset boolean
---@return Element
function VisualElement:setIgnoreOffset(ignoreOffset)
    self.ignoreOffset = ignoreOffset
    return self
end

--- Gets the Combined x, y position
---@generic Element: VisualElement
---@param self Element
---@return number x
---@return number y
function VisualElement:getPosition()
    return self.x, self.y
end

--- Sets the Combined x, y position
---@generic Element: VisualElement
---@param self Element
---@param x number
---@param y number
---@return Element
function VisualElement:setPosition(x, y)
    self.x = x
    self.y = y
    return self
end

--- Gets the Combined width, height
---@generic Element: VisualElement
---@param self Element
---@return number width
---@return number height
function VisualElement:getSize()
    return self.width, self.height
end

--- Sets the Combined width, height
---@generic Element: VisualElement
---@param self Element
---@param width number
---@param height number
---@return Element
function VisualElement:setSize(width, height)
    self.width = width
    self.height = height
    return self
end

--- Gets the Combined foreground, background colors
---@generic Element: VisualElement
---@param self Element
---@return number foreground
---@return number background
function VisualElement:getColor()
    return self.foreground, self.background
end

--- Sets the Combined foreground, background colors
---@generic Element: VisualElement
---@param self Element
---@param foreground number
---@param background number
---@return Element
function VisualElement:setColor(foreground, background)
    self.foreground = foreground
    self.background = background
    return self
end

--- {button, x, y} Fired on mouse click
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onClick(callback)
    return self
end

--- {button, x, y} Fired on mouse button release
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onMouseUp(callback)
    return self
end

--- {button, x, y} Fired when mouse leaves while clicked
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onRelease(callback)
    return self
end

--- {button, x, y} Fired when mouse moves while clicked
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onDrag(callback)
    return self
end

--- {direction, x, y} Fired on mouse scroll
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onScroll(callback)
    return self
end

--- {-} Fired when mouse enters element
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onEnter(callback)
    return self
end

--- {-} Fired when mouse leaves element
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onLeave(callback)
    return self
end

--- {-} Fired when element receives focus
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onFocus(callback)
    return self
end

--- {-} Fired when element loses focus
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onBlur(callback)
    return self
end

--- {key} Fired on key press
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onKey(callback)
    return self
end

--- {key} Fired on key release
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onKeyUp(callback)
    return self
end

--- {char} Fired on character input
---@generic Element: VisualElement
---@param self Element
---@param callback function
---@return Element
function VisualElement:onChar(callback)
    return self
end

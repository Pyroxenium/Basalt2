# ComboBox
_This is the ComboBox class. It extends the dropdown functionality with editable text input,_
_allowing users to either select from a list or type their own custom text._

Extends: `Dropdown`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|editable|boolean|true|Whether the ComboBox allows text input|
|text|string|""|The current text content of the ComboBox|
|cursorPos|number|1|The current cursor position in the text|
|viewOffset|number|0|The horizontal scroll offset for viewing long text|
|placeholder|string|"..."|Text to display when input is empty|
|placeholderColor|color|gray|Color of the placeholder text|
|focusedBackground|color|blue|Background color when ComboBox is focused|
|focusedForeground|color|white|Foreground color when ComboBox is focused  |
|autoComplete|boolean|false|Whether to enable auto-complete filtering when typing|
|manuallyOpened|boolean|false|Whether the dropdown was manually opened (not by auto-complete)|

## Functions

|Method|Returns|Description|
|---|---|---|
|[ComboBox.new](#combobox-new)|ComboBox|Creates a new ComboBox instance|
|[ComboBox:init](#combobox-init-props-basalt)|ComboBox|Initializes the ComboBox instance|
|[ComboBox:setText](#combobox-settext-text)|ComboBox|Sets the text content|
|[ComboBox:getText](#combobox-gettext)|string|Gets the text content|
|[ComboBox:setEditable](#combobox-seteditable-editable)|ComboBox|Sets editable state|
|[ComboBox:getFilteredItems](#combobox-getfiltereditems)|-|Filters items for auto-complete|
|[ComboBox:updateFilteredDropdown](#combobox-updatefiltereddropdown)|-|Updates dropdown with filtered items|
|[ComboBox:updateViewport](#combobox-updateviewport)|-|Updates the viewport|
|[ComboBox:char](#combobox-char-char)|-|Handles character input|
|[ComboBox:key](#combobox-key-key-held)|-|Handles key input|
|[ComboBox:mouse_click](#combobox-mouse-click-button-x-y)|boolean|Handles mouse clicks|
|[ComboBox:render](#combobox-render)|-|Renders the ComboBox|
|[ComboBox:focus](#combobox-focus)|-|Called when gaining focus|
|[ComboBox:blur](#combobox-blur)|-|Called when losing focus|

## ComboBox.new()

Creates a new ComboBox instance

### Returns
* `ComboBox` `self` The newly created ComboBox instance

## ComboBox:init(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `ComboBox` `self` The initialized instance

## ComboBox:setText(text)

Sets the text content of the ComboBox

### Parameters
* `text` `string` The text to set

### Returns
* `ComboBox` self

## ComboBox:getText()

Gets the current text content

### Returns
* `string` `text` The current text

## ComboBox:setEditable(editable)

Sets whether the ComboBox is editable

### Parameters
* `editable` `boolean` Whether the ComboBox should be editable

### Returns
* `ComboBox` self

## ComboBox:getFilteredItems()

Filters items based on current text for auto-complete

## ComboBox:updateFilteredDropdown()

Updates the dropdown with filtered items

## ComboBox:updateViewport()
## ComboBox:char(char)

Handles character input when editable

### Parameters
* `char` `string` The character that was typed

## ComboBox:key(key, held)

Handles key input when editable

### Parameters
* `key` `number` The key code that was pressed
* `held` `boolean` Whether the key is being held

## ComboBox:mouse_click(button, x, y)

Handles mouse clicks

### Parameters
* `button` `number` The mouse button (1 = left, 2 = right, 3 = middle)
* `x` `number` The x coordinate of the click
* `y` `number` The y coordinate of the click

### Returns
* `boolean` `handled` Whether the event was handled

## ComboBox:render()

Renders the ComboBox

## ComboBox:focus()

Called when the ComboBox gains focus

## ComboBox:blur()

Called when the ComboBox loses focus

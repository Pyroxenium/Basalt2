# ComboBox
_A hybrid input element that combines a text input field with a dropdown list. Users can either type directly or select from predefined options. _
_Supports auto-completion, custom styling, and both single and multi-selection modes._

Extends: `DropDown`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|editable|boolean|true|Enables direct text input in the field|
|text|string|""|The current text value of the input field|
|cursorPos|number|1|Current cursor position in the text input|
|viewOffset|number|0|Horizontal scroll position for viewing long text|
|placeholder|string|"..."|Text shown when the input is empty|
|placeholderColor|color|gray|Color used for placeholder text|
|focusedBackground|color|blue|Background color when input is focused|
|focusedForeground|color|white|Text color when input is focused|
|autoComplete|boolean|false|Enables filtering dropdown items while typing|
|manuallyOpened|boolean|false|Indicates if dropdown was opened by user action|

## Functions

|Method|Returns|Description|
|---|---|---|
|[ComboBox.new](#combobox-new)|ComboBox|Creates a new ComboBox instance|
|[ComboBox:setText](#combobox-settext-text)|ComboBox|Sets the text content|
|[ComboBox:getText](#combobox-gettext)|string|Gets the text content|
|[ComboBox:setEditable](#combobox-seteditable-editable)|ComboBox|Sets editable state|
|[ComboBox:char](#combobox-char-char)|-|Handles character input|
|[ComboBox:key](#combobox-key-key-held)|-|Handles key input|
|[ComboBox:render](#combobox-render)|-|Renders the ComboBox|
|[ComboBox:focus](#combobox-focus)|-|Called when gaining focus|
|[ComboBox:blur](#combobox-blur)|-|Called when losing focus|

## ComboBox.new()

Creates a new ComboBox instance

### Returns
* `ComboBox` `self` The newly created ComboBox instance

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

## ComboBox:char(char)

Handles character input when editable

### Parameters
* `char` `string` The character that was typed

## ComboBox:key(key, held)

Handles key input when editable

### Parameters
* `key` `number` The key code that was pressed
* `held` `boolean` Whether the key is being held

## ComboBox:render()

Renders the ComboBox

## ComboBox:focus()

Called when the ComboBox gains focus

## ComboBox:blur()

Called when the ComboBox loses focus

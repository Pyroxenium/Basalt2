# TextBox
_A multi-line text editor component with cursor support and text manipulation features_

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|lines|table|{}|Array of text lines|
|cursorX|number|1|Cursor X position|
|cursorY|number|1|Cursor Y position (line number)|
|scrollX|number|0|Horizontal scroll offset|
|scrollY|number|0|Vertical scroll offset|
|editable|boolean|true|Whether text can be edited|
|syntaxPatterns|table|{}|Syntax highlighting patterns|
|cursorColor|number|nil|Color of the cursor|

## Functions

|Method|Returns|Description|
|---|---|---|
|[TextBox.new](#textbox-new)|TextBox|Creates a new TextBox instance|
|[TextBox:TextBox](#textbox-textbox-props-basalt)|TextBox|Initializes the TextBox instance|
|[TextBox:TextBox](#textbox-textbox-pattern-color)|TextBox|Adds a new syntax highlighting pattern|
|[TextBox:TextBox](#textbox-textbox)|TextBox|Updates the viewport to keep the cursor in view|
|[TextBox:TextBox](#textbox-textbox-char)|boolean|Handles character input|
|[TextBox:TextBox](#textbox-textbox-key)|boolean|Handles key events|
|[TextBox:TextBox](#textbox-textbox-direction-x-y)|boolean|Handles mouse scroll events|
|[TextBox:TextBox](#textbox-textbox-button-x-y)|boolean|Handles mouse click events|
|[TextBox:TextBox](#textbox-textbox)|-|Handles paste events|
|[TextBox:TextBox](#textbox-textbox-text)|TextBox|Sets the text of the TextBox|
|[TextBox:TextBox](#textbox-textbox)|string|Gets the text of the TextBox|
|[TextBox:TextBox](#textbox-textbox)|-|Renders the TextBox with syntax highlighting|

## TextBox.new()

Creates a new TextBox instance

### Returns
* `TextBox` `self` The newly created TextBox instance

## TextBox:TextBox(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `TextBox` `self` The initialized instance

## TextBox:TextBox(pattern, color)

Adds a new syntax highlighting pattern

### Parameters
* `pattern` `string` The regex pattern to match
* `color` `colors` The color to apply

### Returns
* `TextBox` `self` The TextBox instance

## TextBox:TextBox()

Updates the viewport to keep the cursor in view

### Returns
* `TextBox` `self` The TextBox instance

## TextBox:TextBox(char)
### Parameters
* `char` `string` The character that was typed

### Returns
* `boolean` `handled` Whether the event was handled

## TextBox:TextBox(key)
### Parameters
* `key` `number` The key that was pressed

### Returns
* `boolean` `handled` Whether the event was handled

## TextBox:TextBox(direction, x, y)
### Parameters
* `direction` `number` The scroll direction
* `x` `number` The x position of the scroll
* `y` `number` The y position of the scroll

### Returns
* `boolean` `handled` Whether the event was handled

## TextBox:TextBox(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## TextBox:TextBox()
## TextBox:TextBox(text)

Sets the text of the TextBox

### Parameters
* `text` `string` The text to set

### Returns
* `TextBox` `self` The TextBox instance

## TextBox:TextBox()

Gets the text of the TextBox

### Returns
* `string` `text` The text of the TextBox

## TextBox:TextBox()
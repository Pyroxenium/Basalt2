# TextBox : VisualElement
A multi-line text editor component with cursor support and text manipulation features

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|lines|table|{}|Array of text lines
|cursorX|number|1|Cursor X position
|cursorY|number|1|Cursor Y position (line number)
|scrollX|number|0|Horizontal scroll offset
|scrollY|number|0|Vertical scroll offset
|editable|boolean|true|Whether text can be edited
|syntaxPatterns|table|{}|Syntax highlighting patterns
|cursorColor|number|nil|Color of the cursor

## Functions

|Method|Returns|Description|
|---|---|---|
|[TextBox.new](#TextBox.new)|TextBox|Creates a new TextBox instance
|[TextBox:addSyntaxPattern](#TextBox:addSyntaxPattern)|-|Adds a new syntax highlighting pattern
|[TextBox:char](#TextBox:char)|boolean|Handles character input
|[TextBox:getText](#TextBox:getText)|string|Gets the text of the TextBox
|[TextBox:init](#TextBox:init)|TextBox|Initializes the TextBox instance
|[TextBox:key](#TextBox:key)|boolean|Handles key events
|[TextBox:mouse_click](#TextBox:mouse_click)|boolean|Handles mouse click events
|[TextBox:mouse_scroll](#TextBox:mouse_scroll)|boolean|Handles mouse scroll events
|[TextBox:render](#TextBox:render)|-|Renders the TextBox with syntax highlighting
|[TextBox:setText](#TextBox:setText)|TextBox|Sets the text of the TextBox
|[TextBox:updateViewport](#TextBox:updateViewport)|TextBox|Updates the viewport to keep the cursor in view


## TextBox.new()
Creates a new TextBox instance

### Returns
* `TextBox` `self` The newly created TextBox instance

## TextBox:addSyntaxPattern(pattern, color)
Adds a new syntax highlighting pattern

### Parameters
* `pattern` `string` The regex pattern to match
* `color` `colors` The color to apply

## TextBox:char(char)
Handles character input

### Parameters
* `char` `string` The character that was typed

### Returns
* `boolean` `handled` Whether the event was handled

## TextBox:getText()
Gets the text of the TextBox

### Returns
* `string` `text` The text of the TextBox

## TextBox:init(props, basalt)
Initializes the TextBox instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `TextBox` `self` The initialized instance

## TextBox:key(key)
Handles key events

### Parameters
* `key` `number` The key that was pressed

### Returns
* `boolean` `handled` Whether the event was handled

## TextBox:mouse_click(button, x, y)
Handles mouse click events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## TextBox:mouse_scroll(direction, x, y)
Handles mouse scroll events

### Parameters
* `direction` `number` The scroll direction
* `x` `number` The x position of the scroll
* `y` `number` The y position of the scroll

### Returns
* `boolean` `handled` Whether the event was handled

## TextBox:render()
Renders the TextBox

## TextBox:setText(text)
Sets the text of the TextBox

### Parameters
* `text` `string` The text to set

### Returns
* `TextBox` `self` The TextBox instance

## TextBox:updateViewport()
Updates the viewport to keep the cursor in view

### Returns
* `TextBox` `self` The TextBox instance



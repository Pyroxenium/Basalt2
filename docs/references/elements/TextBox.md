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
|[TextBox:addSyntaxPattern](#textbox-addsyntaxpattern)|TextBox|Adds a new syntax highlighting pattern
|[TextBox:getText](#textbox-gettext)|string|Gets the text of the TextBox
|[TextBox:setText](#textbox-settext)|TextBox|Sets the text of the TextBox
|[TextBox:updateViewport](#textbox-updateviewport)|TextBox|Updates the viewport to keep the cursor in view


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|TextBox:char|boolean|Handles character input
|TextBox:init|TextBox|Initializes the TextBox instance
|TextBox:key|boolean|Handles key events
|TextBox:mouse_click|boolean|Handles mouse click events
|TextBox:mouse_scroll|boolean|Handles mouse scroll events
|TextBox:render|-|Renders the TextBox with syntax highlighting

## TextBox:addSyntaxPattern(pattern, color)
Adds a new syntax highlighting pattern

### Parameters
* `pattern` `string` The regex pattern to match
* `color` `colors` The color to apply

### Returns
* `TextBox` `self` The TextBox instance

## TextBox:getText()
Gets the text of the TextBox

### Returns
* `string` `text` The text of the TextBox

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



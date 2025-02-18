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
|[TextBox.new](#TextBox.new)|-|
|[TextBox:addSyntaxPattern](#TextBox:addSyntaxPattern)|-|
|[TextBox:char](#TextBox:char)|-|
|[TextBox:getText](#TextBox:getText)|-|
|[TextBox:init](#TextBox:init)|-|
|[TextBox:key](#TextBox:key)|-|
|[TextBox:mouse_click](#TextBox:mouse_click)|-|
|[TextBox:mouse_scroll](#TextBox:mouse_scroll)|-|
|[TextBox:render](#TextBox:render)|-|
|[TextBox:setText](#TextBox:setText)|-|
|[TextBox:updateViewport](#TextBox:updateViewport)|-|

## TextBox.new()

## TextBox:addSyntaxPattern(pattern, color)
Adds a new syntax highlighting pattern

### Parameters
* `pattern` `string` The regex pattern to match
* `color` `colors` The color to apply

## TextBox:char()

## TextBox:getText()

## TextBox:init()

## TextBox:key()

## TextBox:mouse_click()

## TextBox:mouse_scroll()

## TextBox:render()

## TextBox:setText()

## TextBox:updateViewport()



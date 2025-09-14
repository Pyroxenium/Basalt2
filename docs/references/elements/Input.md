# Input
_This is the input class. It provides a text input field that can handle user input with various features like_
_cursor movement, text manipulation, placeholder text, and input validation._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|-|The current text content of the input|
|cursorPos|number|1|The current cursor position in the text|
|viewOffset|number|0|The horizontal scroll offset for viewing long text|
|placeholder|string|...|Text to display when input is empty|
|placeholderColor|color|gray|Color of the placeholder text|
|focusedBackground|color|blue|Background color when input is focused|
|focusedForeground|color|white|Foreground color when input is focused|
|cursorColor|number|nil|Color of the cursor|
|replaceChar|string|nil|Character to replace the input with (for password fields)|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Input:setCursor](#input-setcursor-x-y-blink-color)|-|Sets the cursor position and color|
|[Input:updateViewport](#input-updateviewport)|Input|Updates the input's viewport|

## Input:setCursor(x, y, blink, color)

Sets the cursor position and color

### Parameters
* `x` `number` The x position of the cursor
* `y` `number` The y position of the cursor
* `blink` `boolean` Whether the cursor should blink
* `color` `number` The color of the cursor

## Input:updateViewport()

Updates the input's viewport

### Returns
* `Input` `self` The updated instance

# Input
_This is the input class. It provides a text input field that can handle user input with various features like
cursor movement, text manipulation, placeholder text, and input validation._

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
|[Input.new](#input-new)|Input|Creates a new Input instance|
|[Input:init](#input-init-props-basalt)|Input|Initializes the Input instance|
|[Input:setCursor](#input-setcursor-x-y-blink-color)|-|Sets the cursor position and color|
|[Input:char](#input-char-char)|boolean|Handles char events|
|[Input:key](#input-key-key)|boolean|Handles key events|
|[Input:mouse_click](#input-mouse-click-button-x-y)|boolean|Handles mouse click events|
|[Input:updateViewport](#input-updateviewport)|Input|Updates the input's viewport|
|[Input:focus](#input-focus)|-|Handles a focus event|
|[Input:blur](#input-blur)|-|Handles a blur event|
|[Input:paste](#input-paste)|-|Handles paste events|
|[Input:render](#input-render)|-|Renders the input element|

## Input.new()
### Returns
* `Input` `object` The newly created Input instance

## Input:init(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Input` `self` The initialized instance

## Input:setCursor(x, y, blink, color)

Sets the cursor position and color

### Parameters
* `x` `number` The x position of the cursor
* `y` `number` The y position of the cursor
* `blink` `boolean` Whether the cursor should blink
* `color` `number` The color of the cursor

## Input:char(char)
### Parameters
* `char` `string` The character that was typed

### Returns
* `boolean` `handled` Whether the event was handled

## Input:key(key)
### Parameters
* `key` `number` The key that was pressed

### Returns
* `boolean` `handled` Whether the event was handled

## Input:mouse_click(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Input:updateViewport()

Updates the input's viewport

### Returns
* `Input` `self` The updated instance

## Input:focus()
## Input:blur()
## Input:paste()
## Input:render()
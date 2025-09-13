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
|[Input:Input](#input-input-props-basalt)|Input|Initializes the Input instance|
|[Input:Input](#input-input-x-y-blink-color)|-|Sets the cursor position and color|
|[Input:Input](#input-input-char)|boolean|Handles char events|
|[Input:Input](#input-input-key)|boolean|Handles key events|
|[Input:Input](#input-input-button-x-y)|boolean|Handles mouse click events|
|[Input:Input](#input-input)|Input|Updates the input's viewport|
|[Input:Input](#input-input)|-|Handles a focus event|
|[Input:Input](#input-input)|-|Handles a blur event|
|[Input:Input](#input-input)|-|Handles paste events|
|[Input:Input](#input-input)|-|Renders the input element|

## Input.new()
### Returns
* `Input` `object` The newly created Input instance

## Input:Input(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Input` `self` The initialized instance

## Input:Input(x, y, blink, color)

Sets the cursor position and color

### Parameters
* `x` `number` The x position of the cursor
* `y` `number` The y position of the cursor
* `blink` `boolean` Whether the cursor should blink
* `color` `number` The color of the cursor

## Input:Input(char)
### Parameters
* `char` `string` The character that was typed

### Returns
* `boolean` `handled` Whether the event was handled

## Input:Input(key)
### Parameters
* `key` `number` The key that was pressed

### Returns
* `boolean` `handled` Whether the event was handled

## Input:Input(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Input:Input()

Updates the input's viewport

### Returns
* `Input` `self` The updated instance

## Input:Input()
## Input:Input()
## Input:Input()
## Input:Input()
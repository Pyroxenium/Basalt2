# Input : VisualElement
This is the input class. It provides a text input field that can handle user input with various features like
cursor movement, text manipulation, placeholder text, and input validation.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|-|The current text content of the input
|cursorPos|number|1|The current cursor position in the text
|viewOffset|number|0|The horizontal scroll offset for viewing long text
|maxLength|number?|nil|Maximum length of input text (optional)
|placeholder|string|...|Text to display when input is empty
|placeholderColor|color|gray|Color of the placeholder text
|focusedColor|color|blue|Background color when input is focused
|pattern|string?|nil|Regular expression pattern for input validation
|cursorColor|number|nil|Color of the cursor

## Functions

|Method|Returns|Description|
|---|---|---|
|[Input.new](#Input.new)|Input|Creates a new Input instance
|[Input:blur](#Input:blur)|-|Handles blur events
|[Input:char](#Input:char)|boolean|Handles char events
|[Input:focus](#Input:focus)|-|Handles focus events
|[Input:init](#Input:init)|Input|Initializes the Input instance
|[Input:key](#Input:key)|boolean|Handles key events
|[Input:mouse_click](#Input:mouse_click)|boolean|Handles mouse click events
|[Input:render](#Input:render)|-|Renders the input element
|[Input:updateViewport](#Input:updateViewport)|-|Updates the input's viewport

## Input.new()
Creates a new Input instance

### Returns
* `Input` `object` The newly created Input instance

### Usage
 ```lua
local element = Input.new("myId", basalt)
```

## Input:blur()
Handles blur events

## Input:char(char)
Handles char events

### Parameters
* `char` `string` The character that was typed

### Returns
* `boolean` `handled` Whether the event was handled

## Input:focus()
Handles focus events

## Input:init(props, basalt)
Initializes the Input instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Input` `self` The initialized instance

## Input:key(key)
Handles key events

### Parameters
* `key` `number` The key that was pressed

### Returns
* `boolean` `handled` Whether the event was handled

## Input:mouse_click(button, x, y)
Handles mouse click events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Input:render()
Renders the input element

## Input:updateViewport()
Updates the input's viewport



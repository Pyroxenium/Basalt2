# BaseFrame
_This is the base frame class. It is the root element of all elements and the only element without a parent._

Extends: `Container`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|term|term|peripheral|term.current()|The terminal or (monitor) peripheral object to render to|

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseFrame.new](#baseframe-new)|BaseFrame|Creates a new Frame instance|
|[BaseFrame:BaseFrame](#baseframe-baseframe-props-basalt)|table|Initializes the Frame instance|
|[BaseFrame:BaseFrame](#baseframe-baseframe-x-y-width-height-text-fg-bg)|-|Renders a multiBlit to the render Object|
|[BaseFrame:BaseFrame](#baseframe-baseframe-x-y-text-fg)|-|Renders a text with a foreground color to the render Object|
|[BaseFrame:BaseFrame](#baseframe-baseframe-x-y-text-bg)|-|Renders a text with a background color to the render Object|
|[BaseFrame:BaseFrame](#baseframe-baseframe-x-y-text-bg)|-|Renders a text with a background color to the render Object|
|[BaseFrame:BaseFrame](#baseframe-baseframe-x-y-text-fg-bg)|-|Renders a text with a foreground and background color to the render Object|
|[BaseFrame:BaseFrame](#baseframe-baseframe-x-y-blink)|-|Sets the cursor position|
|[BaseFrame:BaseFrame](#baseframe-baseframe-name-x-y)|-|Handles monitor touch events|
|[BaseFrame:BaseFrame](#baseframe-baseframe-button-x-y)|-|Handles mouse click events|
|[BaseFrame:BaseFrame](#baseframe-baseframe-button-x-y)|-|Handles mouse up events|
|[BaseFrame:BaseFrame](#baseframe-baseframe)|-|Resizes the Frame|
|[BaseFrame:BaseFrame](#baseframe-baseframe-key)|-|Handles key events|
|[BaseFrame:BaseFrame](#baseframe-baseframe-key)|-|Handles key up events|
|[BaseFrame:BaseFrame](#baseframe-baseframe-char)|-|Handles character events|
|[BaseFrame:BaseFrame](#baseframe-baseframe)|-|Renders the Frame|

## BaseFrame.new()

Creates a new Frame instance

### Returns
* `BaseFrame` `object` The newly created Frame instance

### Usage
```lua
local element = BaseFrame.new()
```

## BaseFrame:BaseFrame(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `table` `self` The initialized instance

## BaseFrame:BaseFrame(x, y, width, height, text, fg, bg)
### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `width` `number` The width of the text
* `height` `number` The height of the text
* `text` `string` The text to render
* `fg` `string` The foreground color
* `bg` `string` The background color

## BaseFrame:BaseFrame(x, y, text, fg)
### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `text` `string` The text to render
* `fg` `colors` The foreground color

## BaseFrame:BaseFrame(x, y, text, bg)
### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `text` `string` The text to render
* `bg` `colors` The background color

## BaseFrame:BaseFrame(x, y, text, bg)
### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `text` `string` The text to render
* `bg` `colors` The background color

## BaseFrame:BaseFrame(x, y, text, fg, bg)
### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `text` `string` The text to render
* `fg` `string` The foreground color
* `bg` `string` The background color

## BaseFrame:BaseFrame(x, y, blink)

Sets the cursor position

### Parameters
* `x` `number` The x position to set the cursor to
* `y` `number` The y position to set the cursor to
* `blink` `boolean` Whether the cursor should blink

## BaseFrame:BaseFrame(name, x, y)
### Parameters
* `name` `string` The name of the monitor that was touched
* `x` `number` The x position of the mouse
* `y` `number` The y position of the mouse

## BaseFrame:BaseFrame(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the mouse
* `y` `number` The y position of the mouse

## BaseFrame:BaseFrame(button, x, y)
### Parameters
* `button` `number` The button that was released
* `x` `number` The x position of the mouse
* `y` `number` The y position of the mouse

## BaseFrame:BaseFrame()
## BaseFrame:BaseFrame(key)
### Parameters
* `key` `number` The key that was pressed

## BaseFrame:BaseFrame(key)
### Parameters
* `key` `number` The key that was released

## BaseFrame:BaseFrame(char)
### Parameters
* `char` `string` The character that was pressed

## BaseFrame:BaseFrame()
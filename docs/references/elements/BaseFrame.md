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
|[BaseFrame:init](#baseframe-init-props-basalt)|table|Initializes the Frame instance|
|[BaseFrame:multiBlit](#baseframe-multiblit-x-y-width-height-text-fg-bg)|-|Renders a multiBlit to the render Object|
|[BaseFrame:textFg](#baseframe-textfg-x-y-text-fg)|-|Renders a text with a foreground color to the render Object|
|[BaseFrame:textBg](#baseframe-textbg-x-y-text-bg)|-|Renders a text with a background color to the render Object|
|[BaseFrame:drawText](#baseframe-drawtext-x-y-text-bg)|-|Renders a text with a background color to the render Object|
|[BaseFrame:blit](#baseframe-blit-x-y-text-fg-bg)|-|Renders a text with a foreground and background color to the render Object|
|[BaseFrame:setCursor](#baseframe-setcursor-x-y-blink)|-|Sets the cursor position|
|[BaseFrame:monitor_touch](#baseframe-monitor-touch-name-x-y)|-|Handles monitor touch events|
|[BaseFrame:mouse_click](#baseframe-mouse-click-button-x-y)|-|Handles mouse click events|
|[BaseFrame:mouse_up](#baseframe-mouse-up-button-x-y)|-|Handles mouse up events|
|[BaseFrame:term_resize](#baseframe-term-resize)|-|Resizes the Frame|
|[BaseFrame:key](#baseframe-key-key)|-|Handles key events|
|[BaseFrame:key_up](#baseframe-key-up-key)|-|Handles key up events|
|[BaseFrame:char](#baseframe-char-char)|-|Handles character events|
|[BaseFrame:render](#baseframe-render)|-|Renders the Frame|

## BaseFrame.new()

Creates a new Frame instance

### Returns
* `BaseFrame` `object` The newly created Frame instance

### Usage
```lua
local element = BaseFrame.new()
```

## BaseFrame:init(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `table` `self` The initialized instance

## BaseFrame:multiBlit(x, y, width, height, text, fg, bg)
### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `width` `number` The width of the text
* `height` `number` The height of the text
* `text` `string` The text to render
* `fg` `string` The foreground color
* `bg` `string` The background color

## BaseFrame:textFg(x, y, text, fg)
### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `text` `string` The text to render
* `fg` `colors` The foreground color

## BaseFrame:textBg(x, y, text, bg)
### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `text` `string` The text to render
* `bg` `colors` The background color

## BaseFrame:drawText(x, y, text, bg)
### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `text` `string` The text to render
* `bg` `colors` The background color

## BaseFrame:blit(x, y, text, fg, bg)
### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `text` `string` The text to render
* `fg` `string` The foreground color
* `bg` `string` The background color

## BaseFrame:setCursor(x, y, blink)

Sets the cursor position

### Parameters
* `x` `number` The x position to set the cursor to
* `y` `number` The y position to set the cursor to
* `blink` `boolean` Whether the cursor should blink

## BaseFrame:monitor_touch(name, x, y)
### Parameters
* `name` `string` The name of the monitor that was touched
* `x` `number` The x position of the mouse
* `y` `number` The y position of the mouse

## BaseFrame:mouse_click(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the mouse
* `y` `number` The y position of the mouse

## BaseFrame:mouse_up(button, x, y)
### Parameters
* `button` `number` The button that was released
* `x` `number` The x position of the mouse
* `y` `number` The y position of the mouse

## BaseFrame:term_resize()
## BaseFrame:key(key)
### Parameters
* `key` `number` The key that was pressed

## BaseFrame:key_up(key)
### Parameters
* `key` `number` The key that was released

## BaseFrame:char(char)
### Parameters
* `char` `string` The character that was pressed

## BaseFrame:render()
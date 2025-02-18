# BaseFrame : Container
This is the base frame class. It is the root element of all elements and the only element without a parent.

## Fields

|Field|Type|Description|
|---|---|---|
|_render|`Render`|The render object|
|_renderUpdate|`boolean`|Whether the render object needs to be updated|

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|term|nil|The terminal object to render to

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseFrame.new](#BaseFrame.new)|BaseFrame|Creates a new Frame instance
|[BaseFrame:blit](#BaseFrame:blit)|-|Renders a text with a foreground and background color to the render Object
|[BaseFrame:init](#BaseFrame:init)|table|Initializes the Frame instance
|[BaseFrame:mouse_up](#BaseFrame:mouse_up)|-|
|[BaseFrame:multiBlit](#BaseFrame:multiBlit)|-|Renders a multiBlit to the render Object
|[BaseFrame:render](#BaseFrame:render)|-|Renders the Frame
|[BaseFrame:setCursor](#BaseFrame:setCursor)|-|Sets the cursor position
|[BaseFrame:term_resize](#BaseFrame:term_resize)|-|
|[BaseFrame:textBg](#BaseFrame:textBg)|-|Renders a text with a background color to the render Object
|[BaseFrame:textFg](#BaseFrame:textFg)|-|Renders a text with a foreground color to the render Object

## BaseFrame.new()
Creates a new Frame instance

### Returns
* `BaseFrame` `object` The newly created Frame instance

### Usage
 ```lua
local element = BaseFrame.new()
```

## BaseFrame:blit(x, y, text, fg, bg)
Renders a text with a foreground and background color to the render Object

### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `text` `string` The text to render
* `fg` `string` The foreground color
* `bg` `string` The background color

## BaseFrame:init(props, basalt)
Initializes the Frame instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `table` `self` The initialized instance

## BaseFrame:mouse_up()

## BaseFrame:multiBlit(x, y, width, height, text, fg, bg)
Renders a multiBlit to the render Object

### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `width` `number` The width of the text
* `height` `number` The height of the text
* `text` `string` The text to render
* `fg` `string` The foreground color
* `bg` `string` The background color

## BaseFrame:render()
Renders the Frame

## BaseFrame:setCursor(x, y, blink)
Sets the cursor position

### Parameters
* `x` `number` The x position to set the cursor to
* `y` `number` The y position to set the cursor to
* `blink` `boolean` Whether the cursor should blink

## BaseFrame:term_resize()

## BaseFrame:textBg(x, y, text, bg)
Renders a text with a background color to the render Object

### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `text` `string` The text to render
* `bg` `colors` The background color

## BaseFrame:textFg(x, y, text, fg)
Renders a text with a foreground color to the render Object

### Parameters
* `x` `number` The x position to render to
* `y` `number` The y position to render to
* `text` `string` The text to render
* `fg` `colors` The foreground color



# VisualElement : BaseElement
This is the visual element class. It serves as the base class for all visual UI elements
and provides core functionality for positioning, sizing, colors, and rendering.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|x|number|1|The horizontal position relative to parent
|y|number|1|The vertical position relative to parent
|z|number|1|The z-index for layering elements
|width|number|1|The width of the element
|height|number|1|The height of the element
|background|color|black|The background color
|foreground|color|white|The text/foreground color
|clicked|boolean|false|Whether the element is currently clicked
|hover|boolean|false|Whether the mouse is currently hover over the element (Craftos-PC only)
|backgroundEnabled|boolean|true|Whether to render the background
|focused|boolean|false|Whether the element has input focus
|visible|boolean|true|Whether the element is visible

## Combined Properties

|Name|Properties|Description|
|---|---|---|
|position|`x y`|Combined x, y position|
|size|`width height`|Combined width, height|
|color|`foreground background`|Combined foreground, background colors|

## Events

|Event|Parameters|Description|
|---|---|---|
|onMouseClick|`button number, x number, y number`|Fired on mouse click|
|onMouseUp|`button number, x number, y number`|Fired on mouse button release|
|onMouseRelease|`button number, x number, y number`|Fired when mouse leaves while clicked|
|onMouseDrag|`button number, x number, y number`|Fired when mouse moves while clicked|
|onFocus|`-`|Fired when element receives focus|
|onBlur|`-`|Fired when element loses focus|
|onKey|`key number, code number, isRepeat boolean`|Fired on key press|
|onKeyUp|`key number, code number`|Fired on key release|
|onChar|`char string`|Fired on character input|

## Functions

|Method|Returns|Description|
|---|---|---|
|[VisualElement.new](#VisualElement.new)|VisualElement|Creates a new visual element
|[VisualElement:blit](#VisualElement:blit)|-|Draws text with both colors
|[VisualElement:blur](#VisualElement:blur)|-|Handles a blur event
|[VisualElement:focus](#VisualElement:focus)|-|Handles a focus event
|[VisualElement:getAbsolutePosition](#VisualElement:getAbsolutePosition)|-|Returns the absolute position of the element
|[VisualElement:getRelativePosition](#VisualElement:getRelativePosition)|number,|Returns the relative position of the element
|[VisualElement:init](#VisualElement:init)|-|Initializes a new visual element with properties
|[VisualElement:isInBounds](#VisualElement:isInBounds)|boolean|Checks if point is within bounds
|[VisualElement:mouse_click](#VisualElement:mouse_click)|boolean|Handles a mouse click event
|[VisualElement:mouse_drag](#VisualElement:mouse_drag)|-|
|[VisualElement:mouse_move](#VisualElement:mouse_move)|-|
|[VisualElement:mouse_release](#VisualElement:mouse_release)|-|Handles a mouse release event
|[VisualElement:mouse_scroll](#VisualElement:mouse_scroll)|-|
|[VisualElement:mouse_up](#VisualElement:mouse_up)|boolean|Handles a mouse up event
|[VisualElement:render](#VisualElement:render)|-|Renders the element
|[VisualElement:setCursor](#VisualElement:setCursor)|-|Sets the cursor position
|[VisualElement:textBg](#VisualElement:textBg)|-|Draws text with background color
|[VisualElement:textFg](#VisualElement:textFg)|-|Draws text with foreground color

## VisualElement.new(props, basalt)
Creates a new VisualElement instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `VisualElement` `object` The newly created VisualElement instance

### Usage
 ```lua
local element = VisualElement.new("myId", basalt)
```

## VisualElement:blit(x, y, text, fg, bg)
Draws text with both foreground and background colors

### Parameters
* `x` `number` The x position to draw
* `y` `number` The y position to draw
* `text` `string` The text char to draw
* `fg` `string` The foreground color
* `bg` `string` The background color

## VisualElement:blur()
Handles a blur event

## VisualElement:focus()
Handles a focus event

## VisualElement:getAbsolutePosition(x?, y?)
Returns the absolute position of the element or the given coordinates.

### Parameters
* `x` *(optional)* `number` x position
* `y` *(optional)* `number` y position

## VisualElement:getRelativePosition(x?, y?)
Returns the relative position of the element or the given coordinates.

### Parameters
* `x` *(optional)* `number` x position
* `y` *(optional)* `number` y position

### Returns
* `nil` `nil` nil

## VisualElement:init(props, basalt)
Initializes the VisualElement instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

## VisualElement:isInBounds(x, y)
Checks if the specified coordinates are within the bounds of the element

### Parameters
* `x` `number` The x position to check
* `y` `number` The y position to check

### Returns
* `boolean` `isInBounds` Whether the coordinates are within the bounds of the element

## VisualElement:mouse_click(button, x, y)
Handles a mouse click event

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `clicked` Whether the element was clicked

## VisualElement:mouse_drag()

## VisualElement:mouse_move()

## VisualElement:mouse_release(button, x, y)
Handles a mouse release event

### Parameters
* `button` `number` The button that was released
* `x` `number` The x position of the release
* `y` `number` The y position of the release

## VisualElement:mouse_scroll()

## VisualElement:mouse_up(button, x, y)
Handles a mouse up event

### Parameters
* `button` `number` The button that was released
* `x` `number` The x position of the release
* `y` `number` The y position of the release

### Returns
* `boolean` `release` Whether the element was released on the element

## VisualElement:render()
Renders the element

## VisualElement:setCursor(x, y, blink)
Sets the cursor position

### Parameters
* `x` `number` The x position of the cursor
* `y` `number` The y position of the cursor
* `blink` `boolean` Whether the cursor should blink

## VisualElement:textBg(x, y, text, bg)
Draws text with background color

### Parameters
* `x` `number` The x position to draw
* `y` `number` The y position to draw
* `text` `string` The text char to draw
* `bg` `color` The background color

## VisualElement:textFg(x, y, text, fg)
Draws text with foreground color

### Parameters
* `x` `number` The x position to draw
* `y` `number` The y position to draw
* `text` `string` The text char to draw
* `fg` `color` The foreground color



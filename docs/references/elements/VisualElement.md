# VisualElement
_This is the visual element class. It serves as the base class for all visual UI elements_
_and provides core functionality for positioning, sizing, colors, and rendering._

Extends: `BaseElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|x|number|1|The horizontal position relative to parent|
|y|number|1|The vertical position relative to parent|
|z|number|1|The z-index for layering elements|
|width|number|1|The width of the element|
|height|number|1|The height of the element|
|background|color|black|The background color|
|foreground|color|white|The text/foreground color|
|clicked|boolean|false|Whether the element is currently clicked|
|hover|boolean|false|Whether the mouse is currently hover over the element (Craftos-PC only)|
|backgroundEnabled|boolean|true|Whether to render the background|
|focused|boolean|false|Whether the element has input focus|
|visible|boolean|true|Whether the element is visible|
|ignoreOffset|boolean|false|Whether to ignore the parent's offset|

## Events

|Event|Parameters|Description|
|---|---|---|
|onClick|`button string, x number, y number`|Fired on mouse click|

## Functions

|Method|Returns|Description|
|---|---|---|
|[VisualElement.new](#visualelement-new)|VisualElement|Creates a new visual element|
|[VisualElement:init](#visualelement-init-props-basalt)|-|Initializes a new visual element with properties|
|[VisualElement:multiBlit](#visualelement-multiblit-x-y-width-height-text-fg-bg)|-|Multi-character drawing with colors|
|[VisualElement:textFg](#visualelement-textfg-x-y-text-fg)|-|Draws text with foreground color|
|[VisualElement:textBg](#visualelement-textbg-x-y-text-bg)|-|Draws text with background color|
|[VisualElement:blit](#visualelement-blit-x-y-text-fg-bg)|-|Draws text with both colors|
|[VisualElement:isInBounds](#visualelement-isinbounds-x-y)|boolean|Checks if point is within bounds|
|[VisualElement:mouse_click](#visualelement-mouse-click-button-x-y)|boolean|Handles a mouse click event|
|[VisualElement:mouse_up](#visualelement-mouse-up-button-x-y)|boolean|Handles a mouse up event|
|[VisualElement:mouse_release](#visualelement-mouse-release-button-x-y)|-|Handles a mouse release event|
|[VisualElement:mouse_move](#visualelement-mouse-move---x-y)|boolean|Handles a mouse move event|
|[VisualElement:mouse_scroll](#visualelement-mouse-scroll-direction-x-y)|boolean|Handles a mouse scroll event|
|[VisualElement:mouse_drag](#visualelement-mouse-drag-button-x-y)|boolean|Handles a mouse drag event|
|[VisualElement:focus](#visualelement-focus)|-|Handles a focus event|
|[VisualElement:blur](#visualelement-blur)|-|Handles a blur event|
|[VisualElement:key](#visualelement-key-key)|-|Handles a key event|
|[VisualElement:key_up](#visualelement-key-up-key)|-|Handles a key up event|
|[VisualElement:char](#visualelement-char-char)|-|Handles a character event|
|[VisualElement:calculatePosition](#visualelement-calculateposition)|number, number|Calculates the position of the element|
|[VisualElement:getAbsolutePosition](#visualelement-getabsoluteposition-x-y)|number, number|Returns the absolute position of the element|
|[VisualElement:getRelativePosition](#visualelement-getrelativeposition-x-y)|number, number|Returns the relative position of the element|
|[VisualElement:setCursor](#visualelement-setcursor-x-y-blink-color)|VisualElement|Sets the cursor position|
|[VisualElement:prioritize](#visualelement-prioritize)|VisualElement|Prioritizes the element by moving it to the top of its parent's children|
|[VisualElement:render](#visualelement-render)|-|Renders the element|
|[VisualElement:postRender](#visualelement-postrender)|-|Post-rendering function for the element|

## VisualElement.new()

Creates a new VisualElement instance

### Returns
* `VisualElement` `object` The newly created VisualElement instance

## VisualElement:init(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

## VisualElement:multiBlit(x, y, width, height, text, fg, bg)
### Parameters
* `x` `number` The x position to draw
* `y` `number` The y position to draw
* `width` `number` The width of the area to draw
* `height` `number` The height of the area to draw
* `text` `string` The text to draw
* `fg` `string` The foreground color
* `bg` `string` The background color

## VisualElement:textFg(x, y, text, fg)
### Parameters
* `x` `number` The x position to draw
* `y` `number` The y position to draw
* `text` `string` The text char to draw
* `fg` `color` The foreground color

## VisualElement:textBg(x, y, text, bg)
### Parameters
* `x` `number` The x position to draw
* `y` `number` The y position to draw
* `text` `string` The text char to draw
* `bg` `color` The background color

## VisualElement:blit(x, y, text, fg, bg)
### Parameters
* `x` `number` The x position to draw
* `y` `number` The y position to draw
* `text` `string` The text char to draw
* `fg` `string` The foreground color
* `bg` `string` The background color

## VisualElement:isInBounds(x, y)

Checks if the specified coordinates are within the bounds of the element

### Parameters
* `x` `number` The x position to check
* `y` `number` The y position to check

### Returns
* `boolean` `isInBounds` Whether the coordinates are within the bounds of the element

## VisualElement:mouse_click(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `clicked` Whether the element was clicked

## VisualElement:mouse_up(button, x, y)
### Parameters
* `button` `number` The button that was released
* `x` `number` The x position of the release
* `y` `number` The y position of the release

### Returns
* `boolean` `release` Whether the element was released on the element

## VisualElement:mouse_release(button, x, y)
### Parameters
* `button` `number` The button that was released
* `x` `number` The x position of the release
* `y` `number` The y position of the release

## VisualElement:mouse_move(_, x, y)
### Parameters
* `_` `number` unknown
* `x` `number` The x position of the mouse
* `y` `number` The y position of the mouse

### Returns
* `boolean` `hover` Whether the mouse has moved over the element

## VisualElement:mouse_scroll(direction, x, y)
### Parameters
* `direction` `number` The scroll direction
* `x` `number` The x position of the scroll
* `y` `number` The y position of the scroll

### Returns
* `boolean` `scroll` Whether the element was scrolled

## VisualElement:mouse_drag(button, x, y)
### Parameters
* `button` `number` The button that was clicked while dragging
* `x` `number` The x position of the drag
* `y` `number` The y position of the drag

### Returns
* `boolean` `drag` Whether the element was dragged

## VisualElement:focus()
## VisualElement:blur()
## VisualElement:key(key)
### Parameters
* `key` `number` The key that was pressed

## VisualElement:key_up(key)
### Parameters
* `key` `number` The key that was released

## VisualElement:char(char)
### Parameters
* `char` `string` The character that was pressed

## VisualElement:calculatePosition()

Calculates the position of the element relative to its parent

### Returns
* `number` `x` The x position
* `number` `y` The y position

## VisualElement:getAbsolutePosition(x?, y?)

Returns the absolute position of the element or the given coordinates.

### Parameters
* `x` *(optional)* `number` x position
* `y` *(optional)* `number` y position

### Returns
* `number` `x` The absolute x position
* `number` `y` The absolute y position

## VisualElement:getRelativePosition(x?, y?)

Returns the relative position of the element or the given coordinates.

### Parameters
* `x` *(optional)* `number` x position
* `y` *(optional)* `number` y position

### Returns
* `number` `x` The relative x position
* `number` `y` The relative y position

## VisualElement:setCursor(x, y, blink, color)
### Parameters
* `x` `number` The x position of the cursor
* `y` `number` The y position of the cursor
* `blink` `boolean` Whether the cursor should blink
* `color` `number` The color of the cursor

### Returns
* `VisualElement` `self` The VisualElement instance

## VisualElement:prioritize()

This function is used to prioritize the element by moving it to the top of its parent's children. It removes the element from its parent and adds it back, effectively changing its order.

### Returns
* `VisualElement` `self` The VisualElement instance

## VisualElement:render()
## VisualElement:postRender()
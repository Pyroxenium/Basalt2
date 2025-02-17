# VisualElement : BaseElement

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|x|number|1|x position of the element
|y|number|1|y position of the element
|z|number|1|z position of the element
|width|number|1|width of the element
|height|number|1|height of the element
|background|color|black|background color of the element
|foreground|color|white|foreground color of the element
|clicked|boolean|an|false element is currently clicked
|backgroundEnabled|boolean|true|whether the background is enabled
|focused|boolean|false|whether the element is focused
|visible|boolean|true|whether the element is visible

## Combined Properties

|Name|Properties|Description|
|---|---|---|
|position|{x|y}|Position of the element
|size|{width|height}|Size of the element
|color|{foreground|background}|Color of the element

## Events

|Event|Parameters|Description|
|---|---|---|
|onMouseClick|`button number, x number, y number`|Fired when the element is clicked|
|onMouseUp|`button number, x number, y number`|Fired when the mouse is released|
|onMouseRelease|`button number, x number, y number`|Fired when the mouse is released|
|onMouseDrag|`button number, x number, y number`|Fired when the mouse is dragged|
|onFocus|`-`|Fired when the element is focused|
|onBlur|`-`|Fired when the element is blurred|
|onKey|`key number, code number, isRepeat boolean`|Fired when a key is pressed|
|onKeyUp|`key number, code number`|Fired when a key is released|
|onChar|`char string`|Fired when a key is pressed|

## Functions

|Method|Returns|Description|
|---|---|---|
|[VisualElement.new](#VisualElement.new)|VisualElement|
|[VisualElement:blit](#VisualElement:blit)|-|
|[VisualElement:blur](#VisualElement:blur)|-|
|[VisualElement:focus](#VisualElement:focus)|-|
|[VisualElement:getAbsolutePosition](#VisualElement:getAbsolutePosition)|-|
|[VisualElement:getRelativePosition](#VisualElement:getRelativePosition)|number,|
|[VisualElement:init](#VisualElement:init)|-|
|[VisualElement:isInBounds](#VisualElement:isInBounds)|boolean|
|[VisualElement:mouse_click](#VisualElement:mouse_click)|boolean|
|[VisualElement:mouse_release](#VisualElement:mouse_release)|boolean|
|[VisualElement:mouse_up](#VisualElement:mouse_up)|boolean|
|[VisualElement:render](#VisualElement:render)|-|
|[VisualElement:setCursor](#VisualElement:setCursor)|-|
|[VisualElement:textBg](#VisualElement:textBg)|-|
|[VisualElement:textFg](#VisualElement:textFg)|-|

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
Draws a text character with a foreground and background at the specified position, used in the rendering system

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

## VisualElement:init()
Initializes the VisualElement instance

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

## VisualElement:mouse_release(button, x, y)
Handles a mouse release event

### Parameters
* `button` `number` The button that was released
* `x` `number` The x position of the release
* `y` `number` The y position of the release

### Returns
* `boolean` `release` Whether the element was released on the element

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
Draws a text character with a background at the specified position, used in the rendering system

### Parameters
* `x` `number` The x position to draw
* `y` `number` The y position to draw
* `text` `string` The text char to draw
* `bg` `color` The background color

## VisualElement:textFg(x, y, text, fg)
Draws a text character at the specified position, used in the rendering system

### Parameters
* `x` `number` The x position to draw
* `y` `number` The y position to draw
* `text` `string` The text char to draw
* `fg` `color` The foreground color


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
|ignoreOffset|boolean|false|Whether to ignore the parent's offset

## Combined Properties

|Name|Properties|Description|
|---|---|---|
|position|`x number, y number`|Combined x, y position|
|size|`width number, height number`|Combined width, height|
|color|`foreground number, background number`|Combined foreground, background colors|

## Events

|Event|Parameters|Description|
|---|---|---|
|onClick|`button string, x number, y number`|Fired on mouse click|
|onMouseUp|`button, x, y`|Fired on mouse button release|
|onRelease|`button, x, y`|Fired when mouse leaves while clicked|
|onDrag|`button, x, y`|Fired when mouse moves while clicked|
|onScroll|`direction, x, y`|Fired on mouse scroll|
|onEnter|`-`|Fired when mouse enters element|
|onLeave|`-`|Fired when mouse leaves element|
|onFocus|`-`|Fired when element receives focus|
|onBlur|`-`|Fired when element loses focus|
|onKey|`key`|Fired on key press|
|onKeyUp|`key`|Fired on key release|
|onChar|`char`|Fired on character input|

## Functions

|Method|Returns|Description|
|---|---|---|
|[VisualElement:calculatePosition](#visualelement-calculateposition)|number|Calculates the position of the element
|[VisualElement:getAbsolutePosition](#visualelement-getabsoluteposition)|number|Returns the absolute position of the element
|[VisualElement:getRelativePosition](#visualelement-getrelativeposition)|number|Returns the relative position of the element
|[VisualElement:isInBounds](#visualelement-isinbounds)|boolean|Checks if point is within bounds
|[VisualElement:prioritize](#visualelement-prioritize)|VisualElement|Prioritizes the element by moving it to the top of its parent's children


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|VisualElement:blit|-|Draws text with both colors
|VisualElement:blur|-|Handles a blur event
|VisualElement:char|-|Handles a character event
|VisualElement:focus|-|Handles a focus event
|VisualElement:init|-|Initializes a new visual element with properties
|VisualElement:key|-|Handles a key event
|VisualElement:key_up|-|Handles a key up event
|VisualElement:mouse_click|boolean|Handles a mouse click event
|VisualElement:mouse_drag|boolean|Handles a mouse drag event
|VisualElement:mouse_move|boolean|Handles a mouse move event
|VisualElement:mouse_release|-|Handles a mouse release event
|VisualElement:mouse_scroll|boolean|Handles a mouse scroll event
|VisualElement:mouse_up|boolean|Handles a mouse up event
|VisualElement:multiBlit|-|Multi-character drawing with colors
|VisualElement:render|-|Renders the element
|VisualElement:setCursor|VisualElement|Sets the cursor position
|VisualElement:textBg|-|Draws text with background color
|VisualElement:textFg|-|Draws text with foreground color

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

## VisualElement:isInBounds(x, y)
Checks if the specified coordinates are within the bounds of the element

### Parameters
* `x` `number` The x position to check
* `y` `number` The y position to check

### Returns
* `boolean` `isInBounds` Whether the coordinates are within the bounds of the element

## VisualElement:prioritize()
This function is used to prioritize the element by moving it to the top of its parent's children. It removes the element from its parent and adds it back, effectively changing its order.

### Returns
* `VisualElement` `self` The VisualElement instance



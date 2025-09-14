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
|[VisualElement:isInBounds](#visualelement-isinbounds-x-y)|boolean|Checks if point is within bounds|
|[VisualElement:calculatePosition](#visualelement-calculateposition)|number, number|Calculates the position of the element|
|[VisualElement:getAbsolutePosition](#visualelement-getabsoluteposition-x-y)|number, number|Returns the absolute position of the element|
|[VisualElement:getRelativePosition](#visualelement-getrelativeposition-x-y)|number, number|Returns the relative position of the element|
|[VisualElement:prioritize](#visualelement-prioritize)|VisualElement|Prioritizes the element by moving it to the top of its parent's children|

## VisualElement:isInBounds(x, y)

Checks if the specified coordinates are within the bounds of the element

### Parameters
* `x` `number` The x position to check
* `y` `number` The y position to check

### Returns
* `boolean` `isInBounds` Whether the coordinates are within the bounds of the element

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

## VisualElement:prioritize()

This function is used to prioritize the element by moving it to the top of its parent's children. It removes the element from its parent and adds it back, effectively changing its order.

### Returns
* `VisualElement` `self` The VisualElement instance

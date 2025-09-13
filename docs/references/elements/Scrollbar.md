# ScrollBar
_A ScrollBar element that can be attached to other elements to control their scroll properties_

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|value|number|0|Current scroll value|
|min|number|0|Minimum scroll value|
|max|number|100|Maximum scroll value|
|step|number|1|Step size for scroll operations|
|dragMultiplier|number|1|How fast the ScrollBar moves when dragging|
|symbol|string|"|" Symbol used for the ScrollBar handle|
|backgroundSymbol|string|"\127"|Symbol used for the ScrollBar background|
|symbolBackgroundColor|color|black|Background color of the ScrollBar handle|
|backgroundSymbol|string|"\127"|Symbol used for the ScrollBar background|
|minValue|number|function|0|Minimum value or function that returns it|
|maxValue|number|function|100|Maximum value or function that returns it|
|orientation|string|vertical|Orientation of the ScrollBar ("vertical" or "horizontal")|
|handleSize|number|2|Size of the ScrollBar handle in characters|

## Functions

|Method|Returns|Description|
|---|---|---|
|[ScrollBar.new](#scrollbar-new)|ScrollBar|Creates a new ScrollBar instance|
|[ScrollBar:ScrollBar](#scrollbar-scrollbar-props-basalt)|ScrollBar|Initializes the ScrollBar instance|
|[ScrollBar:ScrollBar](#scrollbar-scrollbar-element-config)|ScrollBar|Attaches the ScrollBar to an element's property|
|[ScrollBar:ScrollBar](#scrollbar-scrollbar)|ScrollBar|Updates the attached element's property based on the ScrollBar value|
|[ScrollBar:ScrollBar](#scrollbar-scrollbar-button-x-y)|boolean|Handles mouse click events|
|[ScrollBar:ScrollBar](#scrollbar-scrollbar-button-x-y)|boolean|Handles mouse drag events|
|[ScrollBar:ScrollBar](#scrollbar-scrollbar-direction-x-y)|boolean|Handles mouse scroll events|
|[ScrollBar:ScrollBar](#scrollbar-scrollbar)|-|Renders the ScrollBar|

## ScrollBar.new()

Creates a new ScrollBar instance

### Returns
* `ScrollBar` `self` The newly created ScrollBar instance

## ScrollBar:ScrollBar(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `ScrollBar` `self` The initialized instance

## ScrollBar:ScrollBar(element, config)

Attaches the ScrollBar to an element's property

### Parameters
* `element` `BaseElement` The element to attach to
* `config` `table` Configuration {property = "propertyName", min = number|function, max = number|function}

### Returns
* `ScrollBar` `self` The ScrollBar instance

## ScrollBar:ScrollBar()

Updates the attached element's property based on the ScrollBar value

### Returns
* `ScrollBar` `self` The ScrollBar instance

## ScrollBar:ScrollBar(button, x, y)
### Parameters
* `button` `number` The mouse button clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `Whether` the event was handled

## ScrollBar:ScrollBar(button, x, y)
### Parameters
* `button` `number` The mouse button being dragged
* `x` `number` The x position of the drag
* `y` `number` The y position of the drag

### Returns
* `boolean` `Whether` the event was handled

## ScrollBar:ScrollBar(direction, x, y)
### Parameters
* `direction` `number` The scroll direction (1 for up, -1 for down)
* `x` `number` The x position of the scroll
* `y` `number` The y position of the scroll

### Returns
* `boolean` `Whether` the event was handled

## ScrollBar:ScrollBar()
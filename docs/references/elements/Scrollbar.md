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
|[ScrollBar:attach](#scrollbar-attach-element-config)|ScrollBar|Attaches the ScrollBar to an element's property|
|[ScrollBar:updateAttachedElement](#scrollbar-updateattachedelement)|ScrollBar|Updates the attached element's property based on the ScrollBar value|

## ScrollBar:attach(element, config)

Attaches the ScrollBar to an element's property

### Parameters
* `element` `BaseElement` The element to attach to
* `config` `table` Configuration {property = "propertyName", min = number|function, max = number|function}

### Returns
* `ScrollBar` `self` The ScrollBar instance

## ScrollBar:updateAttachedElement()

Updates the attached element's property based on the ScrollBar value

### Returns
* `ScrollBar` `self` The ScrollBar instance

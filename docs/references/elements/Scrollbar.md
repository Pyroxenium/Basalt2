# Scrollbar : VisualElement
A scrollbar element that can be attached to other elements to control their scroll properties

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|value|number|0|Current scroll value
|min|number|0|Minimum scroll value
|max|number|100|Maximum scroll value
|step|number|1|Step size for scroll operations
|dragMultiplier|number|1|How fast the scrollbar moves when dragging
|symbol|string|"|" Symbol used for the scrollbar handle
|backgroundSymbol|string|"\127"|Symbol used for the scrollbar background
|symbolBackgroundColor|color|black|Background color of the scrollbar handle
|backgroundSymbol|string|"\127"|Symbol used for the scrollbar background
|attachedElement|table?|nil|The element this scrollbar is attached to
|attachedProperty|string?|nil|The property being controlled
|minValue|number|function|0|Minimum value or function that returns it
|maxValue|number|function|100|Maximum value or function that returns it
|orientation|string|vertical|Orientation of the scrollbar ("vertical" or "horizontal")
|handleSize|number|2|Size of the scrollbar handle in characters

## Functions

|Method|Returns|Description|
|---|---|---|
|[Scrollbar.new](#Scrollbar.new)|Scrollbar|Creates a new Scrollbar instance
|[Scrollbar:attach](#Scrollbar:attach)|Scrollbar|
|[Scrollbar:init](#Scrollbar:init)|-|
|[Scrollbar:mouse_click](#Scrollbar:mouse_click)|-|
|[Scrollbar:mouse_drag](#Scrollbar:mouse_drag)|-|
|[Scrollbar:mouse_scroll](#Scrollbar:mouse_scroll)|-|
|[Scrollbar:render](#Scrollbar:render)|-|
|[Scrollbar:updateAttachedElement](#Scrollbar:updateAttachedElement)|-|

## Scrollbar.new()
Creates a new Scrollbar instance

### Returns
* `Scrollbar` `self` The newly created Scrollbar instance

### Usage
 ```lua
local scrollbar = Scrollbar.new()
```

## Scrollbar:attach(element, config)
Attaches the scrollbar to an element's property

### Parameters
* `element` `BaseElement` The element to attach to
* `config` `table` Configuration {property = "propertyName", min = number|function, max = number|function}

### Returns
* `Scrollbar` `self` The scrollbar instance

## Scrollbar:init()

## Scrollbar:mouse_click()

## Scrollbar:mouse_drag()

## Scrollbar:mouse_scroll()

## Scrollbar:render()

## Scrollbar:updateAttachedElement()



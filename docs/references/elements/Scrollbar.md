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
|[Scrollbar:attach](#Scrollbar:attach)|Scrollbar|Attaches the scrollbar to an element's property
|[Scrollbar:init](#Scrollbar:init)|Scrollbar|Initializes the Scrollbar instance
|[Scrollbar:mouse_click](#Scrollbar:mouse_click)|boolean|Handles mouse click events
|[Scrollbar:mouse_drag](#Scrollbar:mouse_drag)|boolean|Handles mouse drag events
|[Scrollbar:mouse_scroll](#Scrollbar:mouse_scroll)|boolean|Handles mouse scroll events
|[Scrollbar:render](#Scrollbar:render)|-|Renders the scrollbar
|[Scrollbar:updateAttachedElement](#Scrollbar:updateAttachedElement)|Scrollbar|Updates the attached element's property based on the scrollbar value


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

## Scrollbar:init(props, basalt)
Initializes the Scrollbar instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Scrollbar` `self` The initialized instance

## Scrollbar:mouse_click(button, x, y)
Handles mouse click events

### Parameters
* `button` `number` The mouse button clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `Whether` the event was handled

## Scrollbar:mouse_drag(button, x, y)
Handles mouse drag events

### Parameters
* `button` `number` The mouse button being dragged
* `x` `number` The x position of the drag
* `y` `number` The y position of the drag

### Returns
* `boolean` `Whether` the event was handled

## Scrollbar:mouse_scroll(direction, x, y)
Handles mouse scroll events

### Parameters
* `direction` `number` The scroll direction (1 for up, -1 for down)
* `x` `number` The x position of the scroll
* `y` `number` The y position of the scroll

### Returns
* `boolean` `Whether` the event was handled

## Scrollbar:render()
Renders the Scrollbar

## Scrollbar:updateAttachedElement()
Updates the attached element's property based on the scrollbar value

### Returns
* `Scrollbar` `self` The scrollbar instance



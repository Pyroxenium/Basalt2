@alias color number
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
|clicked|boolean|false|element is currently clicked

## Functions

|Method|Returns|Description|
|---|---|---|
|[VisualElement.new](#VisualElement.new)|VisualElement|
|[VisualElement:getAbsolutePosition](#VisualElement:getAbsolutePosition)|-|
|[VisualElement:getRelativePosition](#VisualElement:getRelativePosition)|number,|
|[VisualElement:handleEvent](#VisualElement:handleEvent)|-|
|[VisualElement:isInBounds](#VisualElement:isInBounds)|boolean|
|[VisualElement:mouse_click](#VisualElement:mouse_click)|boolean|
|[VisualElement:mouse_release](#VisualElement:mouse_release)|-|
|[VisualElement:mouse_up](#VisualElement:mouse_up)|-|
|[VisualElement:multiBlit](#VisualElement:multiBlit)|-|
|[VisualElement:render](#VisualElement:render)|-|
|[VisualElement:textFg](#VisualElement:textFg)|-|

## VisualElement.new(id, basalt)
Creates a new VisualElement instance

### Parameters
* `id` `string` The unique identifier for this element
* `basalt` `table` The basalt instance

### Returns
* `VisualElement` `object` The newly created VisualElement instance

### Usage
 ```lua
local element = VisualElement.new("myId", basalt)
```

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

## VisualElement:handleEvent()

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

## VisualElement:mouse_release()

## VisualElement:mouse_up()

## VisualElement:multiBlit(x, y, width, height, text, fg, bg)
Draws a text character/fg/bg at the specified position with a certain size, used in the rendering system

### Parameters
* `x` `number` The x position to draw
* `y` `number` The y position to draw
* `width` `number` The width of the element
* `height` `number` The height of the element
* `text` `string` The text char to draw
* `fg` `color` The foreground color
* `bg` `color` The background color

## VisualElement:render()
@diagnostic disable-next-line: duplicate-set-field

## VisualElement:textFg(x, y, text, fg)
Draws a text character at the specified position, used in the rendering system

### Parameters
* `x` `number` The x position to draw
* `y` `number` The y position to draw
* `text` `string` The text char to draw
* `fg` `color` The foreground color


# Frame
_This is the frame class. It serves as a grouping container for other elements._

Extends: `Container`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|draggable|boolean|false|Whether the frame is draggable|
|draggingMap|table|{}|The map of dragging positions|
|scrollable|boolean|false|Whether the frame is scrollable|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Frame.new](#frame-new)|Frame|Creates a new Frame instance|
|[Frame:init](#frame-init-props-basalt)|Frame|Initializes the Frame instance|
|[Frame:mouse_click](#frame-mouse-click-button-x-y)|boolean|Handles mouse click events|
|[Frame:mouse_up](#frame-mouse-up-button-x-y)|boolean|Handles mouse release events|
|[Frame:mouse_drag](#frame-mouse-drag-button-x-y)|boolean|Handles mouse drag events|
|[Frame:getChildrenHeight](#frame-getchildrenheight)|number|Calculates the total height of all children elements|
|[Frame:mouse_scroll](#frame-mouse-scroll-direction-x-y)|boolean|Handles mouse scroll events|

## Frame.new()

Creates a new Frame instance

### Returns
* `Frame` `self` The newly created Frame instance

## Frame:init(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Frame` `self` The initialized instance

## Frame:mouse_click(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Frame:mouse_up(button, x, y)
### Parameters
* `button` `number` The button that was released
* `x` `number` The x position of the release
* `y` `number` The y position of the release

### Returns
* `boolean` `handled` Whether the event was handled

## Frame:mouse_drag(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the drag position
* `y` `number` The y position of the drag position

### Returns
* `boolean` `handled` Whether the event was handled

## Frame:getChildrenHeight()
### Returns
* `number` `height` The total height needed for all children

## Frame:mouse_scroll(direction, x, y)
### Parameters
* `direction` `number` The scroll direction
* `x` `number` The x position of the scroll
* `y` `number` The y position of the scroll

### Returns
* `boolean` `handled` Whether the event was handled

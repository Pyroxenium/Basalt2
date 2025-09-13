# Frame
_This is the frame class. It serves as a grouping container for other elements._

Extends: `Container`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|draggable|boolean|false|Whether the frame is draggable|
|draggingMap|table|{}|The map of dragging positions|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Frame.new](#frame-new)|Frame|Creates a new Frame instance|
|[Frame:Frame](#frame-frame-props-basalt)|Frame|Initializes the Frame instance|
|[Frame:Frame](#frame-frame-button-x-y)|boolean|Handles mouse click events|
|[Frame:Frame](#frame-frame-button-x-y)|boolean|Handles mouse release events|
|[Frame:Frame](#frame-frame-button-x-y)|boolean|Handles mouse drag events|

## Frame.new()

Creates a new Frame instance

### Returns
* `Frame` `self` The newly created Frame instance

## Frame:Frame(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Frame` `self` The initialized instance

## Frame:Frame(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Frame:Frame(button, x, y)
### Parameters
* `button` `number` The button that was released
* `x` `number` The x position of the release
* `y` `number` The y position of the release

### Returns
* `boolean` `handled` Whether the event was handled

## Frame:Frame(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the drag position
* `y` `number` The y position of the drag position

### Returns
* `boolean` `handled` Whether the event was handled

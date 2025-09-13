# Container
_The Container class serves as a fundamental building block for organizing UI elements. It acts as a parent element that can hold and manage child elements._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|children|table|{}|The children of the container|
|childrenSorted|boolean|true|Whether the children are sorted|
|childrenEventsSorted|boolean|true|Whether the children events are sorted|
|childrenEvents|table|{}|The children events of the container|
|eventListenerCount|table|{}|The event listener count of the container|
|focusedChild|table|nil|The focused child of the container|
|visibleChildren|table|{}|The visible children of the container|
|visibleChildrenEvents|table|{}|The visible children events of the container|
|offsetX|number|0|Horizontal content offset|
|offsetY|number|0|Vertical content offset|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Container.new](#container-new)|Container|Creates a new Container instance|
|[Container:Container](#container-container-props-basalt)|-|Initializes the Container instance|
|[Container:Container](#container-container-child)|boolean|Returns whether a child is visible|
|[Container:Container](#container-container-child)|Container|Adds a child to the container|
|[Container:Container](#container-container)|Container|Clears the container|
|[Container:Container](#container-container)|Container|Sorts the children of the container|
|[Container:Container](#container-container-eventname)|Container|Sorts the children events of the container|
|[Container:Container](#container-container-child)|Container|Registers the children events of the container|
|[Container:Container](#container-container-child-eventname)|Container|Registers the children events of the container|
|[Container:Container](#container-container-child)|Container|Unregisters the children events of the container|
|[Container:Container](#container-container-child-eventname)|Container|Unregisters the children events of the container|
|[Container:Container](#container-container-child)|Container|Removes a child from the container|
|[Container:Container](#container-container-path)|self|Removes a child from the container|
|[Container:Container](#container-container-visibleonly-event)|boolean, child|Calls a event on all children|
|[Container:Container](#container-container-event)|boolean|Default handler for events|
|[Container:Container](#container-container-button-x-y)|boolean|Handles mouse click events|
|[Container:Container](#container-container-button-x-y)|boolean|Handles mouse up events|
|[Container:Container](#container-container-button-x-y)|-|Handles mouse release events|
|[Container:Container](#container-container---x-y)|boolean|Handles mouse move events|
|[Container:Container](#container-container-button-x-y)|boolean|Handles mouse drag events|
|[Container:Container](#container-container-direction-x-y)|boolean|Handles mouse scroll events|
|[Container:Container](#container-container-key)|boolean|Handles key events|
|[Container:Container](#container-container-char)|boolean|Handles char events|
|[Container:Container](#container-container-key)|boolean|Handles key up events|
|[Container:Container](#container-container-x-y-width-height-text-fg-bg)|Container|Draws multiple lines of text, fg and bg strings|
|[Container:Container](#container-container-x-y-text-fg)|Container|Draws a line of text and fg as color|
|[Container:Container](#container-container-x-y-text-bg)|Container|Draws a line of text and bg as color|
|[Container:Container](#container-container-x-y-text-fg-bg)|Container|Draws a line of text and fg and bg as colors|
|[Container:Container](#container-container)|-|Renders the container|
|[Container:Container](#container-container)|-||

## Container.new()

Creates a new Container instance

### Returns
* `Container` `self` The new container instance

## Container:Container(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

## Container:Container(child)

Returns whether a child is visible

### Parameters
* `child` `table` The child to check

### Returns
* `boolean` `boolean` the child is visible

## Container:Container(child)

Adds a child to the container

### Parameters
* `child` `table` The child to add

### Returns
* `Container` `self` The container instance

## Container:Container()

Clears the container

### Returns
* `Container` `self` The container instance

## Container:Container()

Sorts the children of the container

### Returns
* `Container` `self` The container instance

## Container:Container(eventName)

Sorts the children events of the container

### Parameters
* `eventName` `string` The event name to sort

### Returns
* `Container` `self` The container instance

## Container:Container(child)

Registers the children events of the container

### Parameters
* `child` `table` The child to register events for

### Returns
* `Container` `self` The container instance

## Container:Container(child, eventName)

Registers the children events of the container

### Parameters
* `child` `table` The child to register events for
* `eventName` `string` The event name to register

### Returns
* `Container` `self` The container instance

## Container:Container(child)

Unregisters the children events of the container

### Parameters
* `child` `table` The child to unregister events for

### Returns
* `Container` `self` The container instance

## Container:Container(child, eventName)

Unregisters the children events of the container

### Parameters
* `child` `table` The child to unregister events for
* `eventName` `string` The event name to unregister

### Returns
* `Container` `self` The container instance

## Container:Container(child)

Removes a child from the container

### Parameters
* `child` `table` The child to remove

### Returns
* `Container` `self` The container instance

## Container:Container(path)

Removes a child from the container

### Parameters
* `path` `string` The path to the child to remove

### Returns
* `self` `The` container instance

## Container:Container(visibleOnly, event)

Calls a event on all children

### Parameters
* `visibleOnly` `boolean` Whether to only call the event on visible children
* `event` `string` The event to call

### Returns
* `boolean` `handled` Whether the event was handled
* `child` `The` child that handled the event

## Container:Container(event)
### Parameters
* `event` `string` The event to handle

### Returns
* `boolean` `handled` Whether the event was handled

## Container:Container(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:Container(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:Container(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

## Container:Container(_, x, y)
### Parameters
* `_` `number` unknown
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:Container(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:Container(direction, x, y)
### Parameters
* `direction` `number` The direction of the scroll
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:Container(key)
### Parameters
* `key` `number` The key that was pressed

### Returns
* `boolean` `handled` Whether the event was handled

## Container:Container(char)
### Parameters
* `char` `string` The character that was pressed

### Returns
* `boolean` `handled` Whether the event was handled

## Container:Container(key)
### Parameters
* `key` `number` The key that was released

### Returns
* `boolean` `handled` Whether the event was handled

## Container:Container(x, y, width, height, text, fg, bg)
### Parameters
* `x` `number` The x position to draw the text
* `y` `number` The y position to draw the text
* `width` `number` The width of the text
* `height` `number` The height of the text
* `text` `string` The text to draw
* `fg` `string` The foreground color of the text
* `bg` `string` The background color of the text

### Returns
* `Container` `self` The container instance

## Container:Container(x, y, text, fg)
### Parameters
* `x` `number` The x position to draw the text
* `y` `number` The y position to draw the text
* `text` `string` The text to draw
* `fg` `color` The foreground color of the text

### Returns
* `Container` `self` The container instance

## Container:Container(x, y, text, bg)
### Parameters
* `x` `number` The x position to draw the text
* `y` `number` The y position to draw the text
* `text` `string` The text to draw
* `bg` `color` The background color of the text

### Returns
* `Container` `self` The container instance

## Container:Container(x, y, text, fg, bg)
### Parameters
* `x` `number` The x position to draw the text
* `y` `number` The y position to draw the text
* `text` `string` The text to draw
* `fg` `string` The foreground color of the text
* `bg` `string` The background color of the text

### Returns
* `Container` `self` The container instance

## Container:Container()
## Container:Container()
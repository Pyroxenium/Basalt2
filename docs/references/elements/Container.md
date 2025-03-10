# Container : VisualElement
The container class. It is a visual element that can contain other elements. It is the base class for all containers,
like Frames, BaseFrames, and more.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|children|table|{}|The children of the container
|childrenSorted|boolean|true|Whether the children are sorted
|childrenEventsSorted|boolean|true|Whether the children events are sorted
|childrenEvents|table|{}|The children events of the container
|eventListenerCount|table|{}|The event listener count of the container
|focusedChild|table|nil|The focused child of the container
|visibleChildren|table|{}|The visible children of the container
|visibleChildrenEvents|table|{}|The visible children events of the container
|offsetX|number|0|Horizontal content offset
|offsetY|number|0|Vertical content offset

## Combined Properties

|Name|Properties|Description|
|---|---|---|
|offset|`offsetX number, offsetY number`|Combined property for offsetX and offsetY|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Container:addChild](#Container:addChild)|Container|Adds a child to the container
|[Container:callChildrenEvent](#Container:callChildrenEvent)|boolean|Calls a event on all children
|[Container:clear](#Container:clear)|Container|Clears the container
|[Container:getChild](#Container:getChild)|Container?|Removes a child from the container
|[Container:isChildVisible](#Container:isChildVisible)|boolean|Returns whether a child is visible
|[Container:registerChildEvent](#Container:registerChildEvent)|Container|Registers the children events of the container
|[Container:registerChildrenEvents](#Container:registerChildrenEvents)|Container|Registers the children events of the container
|[Container:removeChild](#Container:removeChild)|Container|Removes a child from the container
|[Container:removeChildrenEvents](#Container:removeChildrenEvents)|Container|Unregisters the children events of the container
|[Container:sortChildren](#Container:sortChildren)|Container|Sorts the children of the container
|[Container:sortChildrenEvents](#Container:sortChildrenEvents)|Container|Sorts the children events of the container
|[Container:unregisterChildEvent](#Container:unregisterChildEvent)|Container|Unregisters the children events of the container


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|[Container:blit](#Container:blit)|Container|Draws a line of text and fg and bg as colors
|[Container:char](#Container:char)|boolean|Handles char events
|[Container:handleEvent](#Container:handleEvent)|boolean|Default handler for events
|[Container:init](#Container:init)|-|Initializes the Container instance
|[Container:key](#Container:key)|boolean|Handles key events
|[Container:key_up](#Container:key_up)|boolean|Handles key up events
|[Container:mouse_click](#Container:mouse_click)|boolean|Handles mouse click events
|[Container:mouse_drag](#Container:mouse_drag)|boolean|Handles mouse drag events
|[Container:mouse_move](#Container:mouse_move)|boolean|Handles mouse move events
|[Container:mouse_release](#Container:mouse_release)|-|Handles mouse release events
|[Container:mouse_scroll](#Container:mouse_scroll)|boolean|Handles mouse scroll events
|[Container:mouse_up](#Container:mouse_up)|boolean|Handles mouse up events
|[Container:multiBlit](#Container:multiBlit)|Container|Draws multiple lines of text, fg and bg strings
|[Container:render](#Container:render)|-|Renders the container
|[Container:textBg](#Container:textBg)|Container|Draws a line of text and bg as color
|[Container:textFg](#Container:textFg)|Container|Draws a line of text and fg as color

## Container:addChild(child)
Adds a child to the container

### Parameters
* `child` `table` The child to add

### Returns
* `Container` `self` The container instance

## Container:callChildrenEvent(visibleOnly, event...)
Calls a event on all children

### Parameters
* `visibleOnly` `boolean` Whether to only call the event on visible children
* `event` `string` The event to call
* `...` *(vararg)* `any` The event arguments

### Returns
* `boolean` `handled` Whether the event was handled
* `table?` `child` The child that handled the event

## Container:clear()
Clears the container

### Returns
* `Container` `self` The container instance

## Container:getChild(path)
Removes a child from the container

### Parameters
* `path` `string` The path to the child to remove

### Returns
* `Container?` `self` The container instance

## Container:isChildVisible(child)
Returns whether a child is visible

### Parameters
* `child` `table` The child to check

### Returns
* `boolean` `boolean` the child is visible

## Container:registerChildEvent(child, eventName)
Registers the children events of the container

### Parameters
* `child` `table` The child to register events for
* `eventName` `string` The event name to register

### Returns
* `Container` `self` The container instance

## Container:registerChildrenEvents(child)
Registers the children events of the container

### Parameters
* `child` `table` The child to register events for

### Returns
* `Container` `self` The container instance

## Container:removeChild(child)
Removes a child from the container

### Parameters
* `child` `table` The child to remove

### Returns
* `Container` `self` The container instance

## Container:removeChildrenEvents(child)
Unregisters the children events of the container

### Parameters
* `child` `table` The child to unregister events for

### Returns
* `Container` `self` The container instance

## Container:sortChildren()
Sorts the children of the container

### Returns
* `Container` `self` The container instance

## Container:sortChildrenEvents(eventName)
Sorts the children events of the container

### Parameters
* `eventName` `string` The event name to sort

### Returns
* `Container` `self` The container instance

## Container:unregisterChildEvent(child, eventName)
Unregisters the children events of the container

### Parameters
* `child` `table` The child to unregister events for
* `eventName` `string` The event name to unregister

### Returns
* `Container` `self` The container instance



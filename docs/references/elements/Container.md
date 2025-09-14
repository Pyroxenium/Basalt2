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
|[Container:isChildVisible](#container-ischildvisible-child)|boolean|Returns whether a child is visible|
|[Container:addChild](#container-addchild-child)|Container|Adds a child to the container|
|[Container:clear](#container-clear)|Container|Clears the container|
|[Container:sortChildren](#container-sortchildren)|Container|Sorts the children of the container|
|[Container:sortChildrenEvents](#container-sortchildrenevents-eventname)|Container|Sorts the children events of the container|
|[Container:registerChildrenEvents](#container-registerchildrenevents-child)|Container|Registers the children events of the container|
|[Container:registerChildEvent](#container-registerchildevent-child-eventname)|Container|Registers the children events of the container|
|[Container:removeChildrenEvents](#container-removechildrenevents-child)|Container|Unregisters the children events of the container|
|[Container:unregisterChildEvent](#container-unregisterchildevent-child-eventname)|Container|Unregisters the children events of the container|
|[Container:removeChild](#container-removechild-child)|Container|Removes a child from the container|
|[Container:getChild](#container-getchild-path)|self|Removes a child from the container|
|[Container:callChildrenEvent](#container-callchildrenevent-visibleonly-event)|boolean, child|Calls a event on all children|

## Container:isChildVisible(child)

Returns whether a child is visible

### Parameters
* `child` `table` The child to check

### Returns
* `boolean` `boolean` the child is visible

## Container:addChild(child)

Adds a child to the container

### Parameters
* `child` `table` The child to add

### Returns
* `Container` `self` The container instance

## Container:clear()

Clears the container

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

## Container:registerChildrenEvents(child)

Registers the children events of the container

### Parameters
* `child` `table` The child to register events for

### Returns
* `Container` `self` The container instance

## Container:registerChildEvent(child, eventName)

Registers the children events of the container

### Parameters
* `child` `table` The child to register events for
* `eventName` `string` The event name to register

### Returns
* `Container` `self` The container instance

## Container:removeChildrenEvents(child)

Unregisters the children events of the container

### Parameters
* `child` `table` The child to unregister events for

### Returns
* `Container` `self` The container instance

## Container:unregisterChildEvent(child, eventName)

Unregisters the children events of the container

### Parameters
* `child` `table` The child to unregister events for
* `eventName` `string` The event name to unregister

### Returns
* `Container` `self` The container instance

## Container:removeChild(child)

Removes a child from the container

### Parameters
* `child` `table` The child to remove

### Returns
* `Container` `self` The container instance

## Container:getChild(path)

Removes a child from the container

### Parameters
* `path` `string` The path to the child to remove

### Returns
* `self` `The` container instance

## Container:callChildrenEvent(visibleOnly, event)

Calls a event on all children

### Parameters
* `visibleOnly` `boolean` Whether to only call the event on visible children
* `event` `string` The event to call

### Returns
* `boolean` `handled` Whether the event was handled
* `child` `The` child that handled the event

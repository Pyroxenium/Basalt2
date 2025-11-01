# Container
_A fundamental layout element that manages child UI components. Containers handle element organization, event propagation, rendering hierarchy, and coordinate space management._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|children|table|{}|Collection of all child elements|
|childrenSorted|boolean|true|Indicates if children are sorted by z-index|
|childrenEventsSorted|boolean|true|Indicates if event handlers are properly sorted|
|childrenEvents|table|{}|Registered event handlers for all children|
|eventListenerCount|table|{}|Number of listeners per event type|
|focusedChild|table|nil|Currently focused child element (receives keyboard events)|
|visibleChildren|table|{}|Currently visible child elements (calculated based on viewport)|
|visibleChildrenEvents|table|{}|Event handlers for currently visible children|
|offsetX|number|0|Horizontal scroll/content offset|
|offsetY|number|0|Vertical scroll/content offset|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Container:isChildVisible](#container-ischildvisible-child)|boolean|Checks if a child element is visible|
|[Container:addChild](#container-addchild-child)|Container|Adds a child element to the container|
|[Container:clear](#container-clear)|Container|Removes all children and resets container|
|[Container:sortChildren](#container-sortchildren)|Container|Updates child element ordering|
|[Container:sortChildrenEvents](#container-sortchildrenevents-eventname)|Container|Sorts the children events of the container|
|[Container:registerChildrenEvents](#container-registerchildrenevents-child)|Container|Registers the children events of the container|
|[Container:registerChildEvent](#container-registerchildevent-child-eventname)|Container|Sets up event handling for a child|
|[Container:removeChildrenEvents](#container-removechildrenevents-child)|Container|Unregisters the children events of the container|
|[Container:unregisterChildEvent](#container-unregisterchildevent-child-eventname)|Container|Unregisters the children events of the container|
|[Container:removeChild](#container-removechild-child)|Container|Removes a child element from the container|
|[Container:getChild](#container-getchild-path)|child|Finds a child element by its path|
|[Container:callChildrenEvent](#container-callchildrenevent-visibleonly-event)|boolean, child|Calls a event on all children|
|[Container:applyLayout](#container-applylayout-layoutpath-options)|Container|Applies a layout to the container|
|[Container:updateLayout](#container-updatelayout)|Container|Updates the layout|
|[Container:clearLayout](#container-clearlayout)|Container|Clears the layout|

## Container:isChildVisible(child)

Tests whether a child element is currently visible within the container's viewport

### Parameters
* `child` `table` The child element to check

### Returns
* `boolean` `isVisible` Whether the child is within view bounds

## Container:addChild(child)

Adds a new element to this container's hierarchy

### Parameters
* `child` `table` The element to add as a child

### Returns
* `Container` `self` For method chaining

## Container:clear()

Removes all child elements and resets the container's state

### Returns
* `Container` `self` For method chaining

## Container:sortChildren()

Re-sorts children by their z-index and updates visibility

### Returns
* `Container` `self` For method chaining

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

Registers an event handler for a specific child element

### Parameters
* `child` `table` The child element to register events for
* `eventName` `string` The name of the event to register

### Returns
* `Container` `self` For method chaining

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

Removes an element from this container's hierarchy and cleans up its events

### Parameters
* `child` `table` The element to remove

### Returns
* `Container` `self` For method chaining

## Container:getChild(path)

Locates a child element using a path-like syntax (e.g. "panel/button1")

### Parameters
* `path` `string` Path to the child (e.g. "panel/button1", "header/title")

### Returns
* `child` `The` found element or nil if not found

## Container:callChildrenEvent(visibleOnly, event)

Calls a event on all children

### Parameters
* `visibleOnly` `boolean` Whether to only call the event on visible children
* `event` `string` The event to call

### Returns
* `boolean` `handled` Whether the event was handled
* `child` `The` child that handled the event

## Container:applyLayout(layoutPath, options?)

Applies a layout from a file to this container

### Parameters
* `layoutPath` `string` Path to the layout file (e.g. "layouts/grid")
* `options` *(optional)* `table` Optional layout-specific options

### Returns
* `Container` `self` For method chaining

## Container:updateLayout()

Updates the current layout (recalculates positions)

### Returns
* `Container` `self` For method chaining

## Container:clearLayout()

Removes the current layout

### Returns
* `Container` `self` For method chaining

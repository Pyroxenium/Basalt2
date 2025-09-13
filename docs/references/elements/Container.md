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
|[Container:init](#container-init-props-basalt)|-|Initializes the Container instance|
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
|[Container:handleEvent](#container-handleevent-event)|boolean|Default handler for events|
|[Container:mouse_click](#container-mouse-click-button-x-y)|boolean|Handles mouse click events|
|[Container:mouse_up](#container-mouse-up-button-x-y)|boolean|Handles mouse up events|
|[Container:mouse_release](#container-mouse-release-button-x-y)|-|Handles mouse release events|
|[Container:mouse_move](#container-mouse-move---x-y)|boolean|Handles mouse move events|
|[Container:mouse_drag](#container-mouse-drag-button-x-y)|boolean|Handles mouse drag events|
|[Container:mouse_scroll](#container-mouse-scroll-direction-x-y)|boolean|Handles mouse scroll events|
|[Container:key](#container-key-key)|boolean|Handles key events|
|[Container:char](#container-char-char)|boolean|Handles char events|
|[Container:key_up](#container-key-up-key)|boolean|Handles key up events|
|[Container:multiBlit](#container-multiblit-x-y-width-height-text-fg-bg)|Container|Draws multiple lines of text, fg and bg strings|
|[Container:textFg](#container-textfg-x-y-text-fg)|Container|Draws a line of text and fg as color|
|[Container:textBg](#container-textbg-x-y-text-bg)|Container|Draws a line of text and bg as color|
|[Container:blit](#container-blit-x-y-text-fg-bg)|Container|Draws a line of text and fg and bg as colors|
|[Container:render](#container-render)|-|Renders the container|
|[Container:destroy](#container-destroy)|-||

## Container.new()

Creates a new Container instance

### Returns
* `Container` `self` The new container instance

## Container:init(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

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

## Container:handleEvent(event)
### Parameters
* `event` `string` The event to handle

### Returns
* `boolean` `handled` Whether the event was handled

## Container:mouse_click(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:mouse_up(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:mouse_release(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

## Container:mouse_move(_, x, y)
### Parameters
* `_` `number` unknown
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:mouse_drag(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:mouse_scroll(direction, x, y)
### Parameters
* `direction` `number` The direction of the scroll
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:key(key)
### Parameters
* `key` `number` The key that was pressed

### Returns
* `boolean` `handled` Whether the event was handled

## Container:char(char)
### Parameters
* `char` `string` The character that was pressed

### Returns
* `boolean` `handled` Whether the event was handled

## Container:key_up(key)
### Parameters
* `key` `number` The key that was released

### Returns
* `boolean` `handled` Whether the event was handled

## Container:multiBlit(x, y, width, height, text, fg, bg)
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

## Container:textFg(x, y, text, fg)
### Parameters
* `x` `number` The x position to draw the text
* `y` `number` The y position to draw the text
* `text` `string` The text to draw
* `fg` `color` The foreground color of the text

### Returns
* `Container` `self` The container instance

## Container:textBg(x, y, text, bg)
### Parameters
* `x` `number` The x position to draw the text
* `y` `number` The y position to draw the text
* `text` `string` The text to draw
* `bg` `color` The background color of the text

### Returns
* `Container` `self` The container instance

## Container:blit(x, y, text, fg, bg)
### Parameters
* `x` `number` The x position to draw the text
* `y` `number` The y position to draw the text
* `text` `string` The text to draw
* `fg` `string` The foreground color of the text
* `bg` `string` The background color of the text

### Returns
* `Container` `self` The container instance

## Container:render()
## Container:destroy()
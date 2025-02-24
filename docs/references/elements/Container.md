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

## Functions

|Method|Returns|Description|
|---|---|---|
|[Container.new](#Container.new)|Container|Creates a new Container instance
|[Container:addChild](#Container:addChild)|Container|Adds a child to the container
|[Container:blit](#Container:blit)|Container|Draws a line of text and fg and bg as colors
|[Container:callChildrenEvents](#Container:callChildrenEvents)|boolean|Calls a event on all children
|[Container:char](#Container:char)|boolean|Handles char events
|[Container:clear](#Container:clear)|Container|Clears the container
|[Container:destroy](#Container:destroy)|Container|Destroys the container and its children
|[Container:getChild](#Container:getChild)|Container?|Removes a child from the container
|[Container:handleEvent](#Container:handleEvent)|boolean|Default handler for events
|[Container:init](#Container:init)|-|Initializes the Container instance
|[Container:isChildVisible](#Container:isChildVisible)|boolean|Returns whether a child is visible
|[Container:key](#Container:key)|boolean|Handles key events
|[Container:key_up](#Container:key_up)|boolean|Handles key up events
|[Container:mouse_click](#Container:mouse_click)|boolean|Handles mouse click events
|[Container:mouse_drag](#Container:mouse_drag)|boolean|Handles mouse drag events
|[Container:mouse_move](#Container:mouse_move)|boolean|Handles mouse move events
|[Container:mouse_release](#Container:mouse_release)|-|Handles mouse release events
|[Container:mouse_scroll](#Container:mouse_scroll)|boolean|Handles mouse scroll events
|[Container:mouse_up](#Container:mouse_up)|boolean|Handles mouse up events
|[Container:multiBlit](#Container:multiBlit)|Container|Draws multiple lines of text, fg and bg strings
|[Container:registerChildEvent](#Container:registerChildEvent)|Container|Registers the children events of the container
|[Container:registerChildrenEvents](#Container:registerChildrenEvents)|Container|Registers the children events of the container
|[Container:removeChild](#Container:removeChild)|Container|Removes a child from the container
|[Container:removeChildrenEvents](#Container:removeChildrenEvents)|Container|Unregisters the children events of the container
|[Container:render](#Container:render)|-|Renders the container
|[Container:sortChildren](#Container:sortChildren)|Container|Sorts the children of the container
|[Container:sortChildrenEvents](#Container:sortChildrenEvents)|Container|Sorts the children events of the container
|[Container:textBg](#Container:textBg)|Container|Draws a line of text and bg as color
|[Container:textFg](#Container:textFg)|Container|Draws a line of text and fg as color
|[Container:unregisterChildEvent](#Container:unregisterChildEvent)|Container|Unregisters the children events of the container

## Container.new()
Creates a new Container instance

### Returns
* `Container` `self` The new container instance

## Container:addChild(child)
Adds a child to the container

### Parameters
* `child` `table` The child to add

### Returns
* `Container` `self` The container instance

## Container:blit(x, y, text, fg, bg)
Draws a line of text and fg and bg as colors, it is usually used in the render loop

### Parameters
* `x` `number` The x position to draw the text
* `y` `number` The y position to draw the text
* `text` `string` The text to draw
* `fg` `string` The foreground color of the text
* `bg` `string` The background color of the text

### Returns
* `Container` `self` The container instance

## Container:callChildrenEvents(visibleOnly, event...)
Calls a event on all children

### Parameters
* `visibleOnly` `boolean` Whether to only call the event on visible children
* `event` `string` The event to call
* `...` *(vararg)* `any` The event arguments

### Returns
* `boolean` `handled` Whether the event was handled
* `table` `child?` The child that handled the event

## Container:char(char)
Handles char events

### Parameters
* `char` `string` The character that was pressed

### Returns
* `boolean` `handled` Whether the event was handled

## Container:clear()
Clears the container

### Returns
* `Container` `self` The container instance

## Container:destroy()
Destroys the container and its children

### Returns
* `Container` `self` The container instance

## Container:getChild(path)
Removes a child from the container

### Parameters
* `path` `string` The path to the child to remove

### Returns
* `Container?` `self` The container instance

## Container:handleEvent(event...)
Default handler for events

### Parameters
* `event` `string` The event to handle
* `...` *(vararg)* `any` The event arguments

### Returns
* `boolean` `handled` Whether the event was handled

## Container:init(props, basalt)
Initializes the Container instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

## Container:isChildVisible(child)
Returns whether a child is visible

### Parameters
* `child` `table` The child to check

### Returns
* `boolean` `boolean` the child is visible

## Container:key(key)
Handles key events

### Parameters
* `key` `number` The key that was pressed

### Returns
* `boolean` `handled` Whether the event was handled

## Container:key_up(key)
Handles key up events

### Parameters
* `key` `number` The key that was released

### Returns
* `boolean` `handled` Whether the event was handled

## Container:mouse_click(button, x, y)
Handles mouse click events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:mouse_drag(button, x, y)
Handles mouse drag events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:mouse_move(_, x, y)
Handles mouse move events

### Parameters
* `_` `number` unknown
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:mouse_release(button, x, y)
Handles mouse release events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

## Container:mouse_scroll(direction, x, y)
Handles mouse scroll events

### Parameters
* `direction` `number` The direction of the scroll
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:mouse_up(button, x, y)
Handles mouse up events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Container:multiBlit(x, y, width, height, text, fg, bg)
Draws multiple lines of text, fg and bg strings, it is usually used in the render loop

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

## Container:render()
Renders the container

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

## Container:textBg(x, y, text, bg)
Draws a line of text and bg as color, it is usually used in the render loop

### Parameters
* `x` `number` The x position to draw the text
* `y` `number` The y position to draw the text
* `text` `string` The text to draw
* `bg` `color` The background color of the text

### Returns
* `Container` `self` The container instance

## Container:textFg(x, y, text, fg)
Draws a line of text and fg as color, it is usually used in the render loop

### Parameters
* `x` `number` The x position to draw the text
* `y` `number` The y position to draw the text
* `text` `string` The text to draw
* `fg` `color` The foreground color of the text

### Returns
* `Container` `self` The container instance

## Container:unregisterChildEvent(child, eventName)
Unregisters the children events of the container

### Parameters
* `child` `table` The child to unregister events for
* `eventName` `string` The event name to unregister

### Returns
* `Container` `self` The container instance



# Container : VisualElement

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

## Functions

|Method|Returns|Description|
|---|---|---|
|[Container.new](#Container.new)|Container|
|[Container:addChild](#Container:addChild)|Container|
|[Container:blit](#Container:blit)|Container|
|[Container:char](#Container:char)|boolean|
|[Container:clear](#Container:clear)|Container|
|[Container:destroy](#Container:destroy)|-|
|[Container:getChild](#Container:getChild)|Container?|
|[Container:handleEvent](#Container:handleEvent)|boolean|
|[Container:init](#Container:init)|-|
|[Container:isChildVisible](#Container:isChildVisible)|boolean|
|[Container:key](#Container:key)|boolean|
|[Container:key_up](#Container:key_up)|boolean|
|[Container:mouse_click](#Container:mouse_click)|boolean|
|[Container:mouse_up](#Container:mouse_up)|boolean|
|[Container:multiBlit](#Container:multiBlit)|Container|
|[Container:registerChildEvent](#Container:registerChildEvent)|Container|
|[Container:registerChildrenEvents](#Container:registerChildrenEvents)|Container|
|[Container:removeChild](#Container:removeChild)|Container|
|[Container:removeChildrenEvents](#Container:removeChildrenEvents)|Container|
|[Container:render](#Container:render)|-|
|[Container:sortChildren](#Container:sortChildren)|Container|
|[Container:sortChildrenEvents](#Container:sortChildrenEvents)|Container|
|[Container:textFg](#Container:textFg)|Container|
|[Container:unregisterChildEvent](#Container:unregisterChildEvent)|Container|

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

## Container:char(char)
Handles char events

### Parameters
* `char` `string` The character that was pressed

### Returns
* `boolean` `Whether` the event was handled

## Container:clear()
Clears the container

### Returns
* `Container` `self` The container instance

## Container:destroy()

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
* `boolean` `Whether` the event was handled

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
* `boolean` `Whether` the event was handled

## Container:key_up(key)
Handles key up events

### Parameters
* `key` `number` The key that was released

### Returns
* `boolean` `Whether` the event was handled

## Container:mouse_click(button, x, y)
Handles mouse click events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `Whether` the event was handled

## Container:mouse_up(button, x, y)
Handles mouse up events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `Whether` the event was handled

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


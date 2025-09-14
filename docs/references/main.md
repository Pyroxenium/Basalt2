# basalt
_This is the UI Manager and the starting point for your project. The following functions allow you to influence the default behavior of Basalt._

_Before you can access Basalt, you need to add the following code on top of your file:_
_What this code does is it loads basalt into the project, and you can access it by using the variable defined as "basalt"._

## Functions

|Method|Returns|Description|
|---|---|---|
|[basalt.create](#basalt-create-type-properties)|table|Creates a new UI element|
|[basalt.createFrame](#basalt-createframe)|BaseFrame|Creates a new BaseFrame|
|[basalt.getElementManager](#basalt-getelementmanager)|table|Returns the element manager|
|[basalt.getErrorManager](#basalt-geterrormanager)|table|Returns the error manager|
|[basalt.getMainFrame](#basalt-getmainframe)|BaseFrame|Gets or creates the main frame|
|[basalt.setActiveFrame](#basalt-setactiveframe-frame-setactive)|-|Sets the active frame|
|[basalt.getActiveFrame](#basalt-getactiveframe-t)|BaseFrame|Returns the active frame|
|[basalt.setFocus](#basalt-setfocus-frame)|-|Sets a frame as focused|
|[basalt.getFocus](#basalt-getfocus)|BaseFrame|Returns the focused frame|
|[basalt.schedule](#basalt-schedule-func)|thread|Schedules a function to run in a coroutine|
|[basalt.removeSchedule](#basalt-removeschedule-func)|boolean|Removes a scheduled update|
|[basalt.update](#basalt-update)|-|Runs basalt once|
|[basalt.stop](#basalt-stop)|-|Stops the Basalt runtime|
|[basalt.run](#basalt-run-isactive)|-|Starts the Basalt runtime|
|[basalt.getElementClass](#basalt-getelementclass-name)|table|Returns an element class|
|[basalt.getAPI](#basalt-getapi-name)|table|Returns a Plugin API|
|[basalt.onEvent](#basalt-onevent-eventname-callback)|-|Registers an event callback|
|[basalt.removeEvent](#basalt-removeevent-eventname-callback)|boolean|Removes an event callback|
|[basalt.triggerEvent](#basalt-triggerevent-eventname)|-|Triggers a custom event|

## basalt.create(type, properties?)

Creates and returns a new UI element of the specified type.

### Parameters
* `type` `string` The type of element to create (e.g. "Button", "Label", "BaseFrame")
* `properties` *(optional)* `string|table` Optional name for the element or a table with properties to initialize the element with

### Returns
* `table` `element` The created element instance

### Usage
```lua
local button = basalt.create("Button")
```

## basalt.createFrame()

Creates and returns a new BaseFrame

### Returns
* `BaseFrame` `BaseFrame` The created frame instance

## basalt.getElementManager()

Returns the element manager instance

### Returns
* `table` `ElementManager` The element manager

## basalt.getErrorManager()

Returns the error manager instance

### Returns
* `table` `ErrorManager` The error manager

## basalt.getMainFrame()

Gets or creates the main frame

### Returns
* `BaseFrame` `BaseFrame` The main frame instance

## basalt.setActiveFrame(frame, setActive?)

Sets the active frame

### Parameters
* `frame` `BaseFrame` The frame to set as active
* `setActive` *(optional)* `boolean` Whether to set the frame as active (default: true)

## basalt.getActiveFrame(t?)

Returns the active frame

### Parameters
* `t` *(optional)* `term` The term to get the active frame for (default: current term)

### Returns
* `BaseFrame` `The` frame to set as active

## basalt.setFocus(frame)

Sets a frame as focused

### Parameters
* `frame` `BaseFrame` The frame to set as focused

## basalt.getFocus()

Returns the focused frame

### Returns
* `BaseFrame` `The` focused frame

## basalt.schedule(func)

Schedules a function to run in a coroutine

### Parameters
* `func` `function` The function to schedule

### Returns
* `thread` `func` The scheduled function

## basalt.removeSchedule(func)

Removes a scheduled update

### Parameters
* `func` `thread` The scheduled function to remove

### Returns
* `boolean` `success` Whether the scheduled function was removed

## basalt.update()

Runs basalt once, can be used to update the UI manually, but you have to feed it the events

## basalt.stop()

Stops the Basalt runtime

## basalt.run(isActive?)

Starts the Basalt runtime

### Parameters
* `isActive` *(optional)* `boolean` Whether to start active (default: true)

## basalt.getElementClass(name)

Returns an element's class without creating a instance

### Parameters
* `name` `string` The name of the element

### Returns
* `table` `Element` The element class

## basalt.getAPI(name)

Returns a Plugin API

### Parameters
* `name` `string` The name of the plugin

### Returns
* `table` `Plugin` The plugin API

## basalt.onEvent(eventName, callback)

Registers a callback function for a specific event

### Parameters
* `eventName` `string` The name of the event to listen for (e.g. "mouse_click", "key", "timer")
* `callback` `function` The callback function to execute when the event occurs

### Usage
```lua
basalt.onEvent("mouse_click", function(button, x, y) basalt.debug("Clicked at", x, y) end)
```

## basalt.removeEvent(eventName, callback)

Removes a callback function for a specific event

### Parameters
* `eventName` `string` The name of the event
* `callback` `function` The callback function to remove

### Returns
* `boolean` `success` Whether the callback was found and removed

## basalt.triggerEvent(eventName)

Triggers a custom event and calls all registered callbacks

### Parameters
* `eventName` `string` The name of the event to trigger

### Usage
```lua
basalt.triggerEvent("custom_event", "data1", "data2")
```

# basalt
This is the UI Manager and the starting point for your project. The following functions allow you to influence the default behavior of Basalt.

Before you can access Basalt, you need to add the following code on top of your file:

### Usage
 ```lua
local basalt = require("basalt")
```

What this code does is it loads basalt into the project, and you can access it by using the variable defined as "basalt".

## Fields

|Field|Type|Description|
|---|---|---|
|traceback|`boolean`|Whether to show a traceback on errors|
|_events|`table`|A table of events and their callbacks|
|_schedule|`function[]`|A table of scheduled functions|
|_plugins|`table`|A table of plugins|
|isRunning|`boolean`|Whether the Basalt runtime is active|
|LOGGER|`Log`|The logger instance|
|path|`string`|The path to the Basalt library|

## Functions

|Method|Returns|Description|
|---|---|---|
|[basalt.create](#basalt-create)|table|Creates a new UI element
|[basalt.createFrame](#basalt-createframe)|BaseFrame|Creates a new BaseFrame
|[basalt.getAPI](#basalt-getapi)|table|Returns a Plugin API
|[basalt.getActiveFrame](#basalt-getactiveframe)|BaseFrame?|Returns the active frame
|[basalt.getElementClass](#basalt-getelementclass)|table|Returns an element class
|[basalt.getElementManager](#basalt-getelementmanager)|table|Returns the element manager
|[basalt.getErrorManager](#basalt-geterrormanager)|table|Returns the error manager
|[basalt.getFocus](#basalt-getfocus)|BaseFrame?|Returns the focused frame
|[basalt.getMainFrame](#basalt-getmainframe)|BaseFrame|Gets or creates the main frame
|[basalt.removeSchedule](#basalt-removeschedule)|boolean|Removes a scheduled update
|[basalt.run](#basalt-run)|-|Starts the Basalt runtime
|[basalt.schedule](#basalt-schedule)|thread|Schedules a function to run in a coroutine
|[basalt.setActiveFrame](#basalt-setactiveframe)|-|Sets the active frame
|[basalt.setFocus](#basalt-setfocus)|-|Sets a frame as focused
|[basalt.stop](#basalt-stop)|-|Stops the Basalt runtime
|[basalt.update](#basalt-update)|-|Runs basalt once


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

## basalt.getAPI(name)
Returns a Plugin API

### Parameters
* `name` `string` The name of the plugin

### Returns
* `table` `Plugin` The plugin API

## basalt.getActiveFrame(t?)
Returns the active frame

### Parameters
* `t` *(optional)* `term` The term to get the active frame for (default: current term)

### Returns
* `BaseFrame?` `BaseFrame` The frame to set as active

## basalt.getElementClass(name)
Returns an element's class without creating a instance

### Parameters
* `name` `string` The name of the element

### Returns
* `table` `Element` The element class

## basalt.getElementManager()
Returns the element manager instance

### Returns
* `table` `ElementManager` The element manager

## basalt.getErrorManager()
Returns the error manager instance

### Returns
* `table` `ErrorManager` The error manager

## basalt.getFocus()
Returns the focused frame

### Returns
* `BaseFrame?` `BaseFrame` The focused frame

## basalt.getMainFrame()
Gets or creates the main frame

### Returns
* `BaseFrame` `BaseFrame` The main frame instance

## basalt.removeSchedule(func)
Removes a scheduled update

### Parameters
* `func` `thread` The scheduled function to remove

### Returns
* `boolean` `success` Whether the scheduled function was removed

## basalt.run(isActive?)
Starts the Basalt runtime

### Parameters
* `isActive` *(optional)* `boolean` Whether to start active (default: true)

## basalt.schedule(func)
Schedules a function to run in a coroutine

### Parameters
* `func` `function` The function to schedule

### Returns
* `thread` `func` The scheduled function

## basalt.setActiveFrame(frame, setActive?)
Sets the active frame

### Parameters
* `frame` `BaseFrame` The frame to set as active
* `setActive` *(optional)* `boolean` Whether to set the frame as active (default: true)

## basalt.setFocus(frame)
Sets a frame as focused

### Parameters
* `frame` `BaseFrame` The frame to set as focused

## basalt.stop()
Stops the Basalt runtime

## basalt.update(...)
Runs basalt once, can be used to update the UI manually, but you have to feed it the events

### Parameters
* `...` *(vararg)* `any` The event to run with



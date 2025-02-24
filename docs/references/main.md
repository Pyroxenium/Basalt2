# Basalt
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
|LOGGER|`Log`|The logger instance|
|path|`string`|The path to the Basalt library|

## Functions

|Method|Returns|Description|
|---|---|---|
|[basalt.create](#basalt.create)|table|Creates a new UI element
|[basalt.createFrame](#basalt.createFrame)|table|Creates a new BaseFrame
|[basalt.getAPI](#basalt.getAPI)|table|Returns a Plugin API
|[basalt.getElementManager](#basalt.getElementManager)|table|Returns the element manager
|[basalt.getMainFrame](#basalt.getMainFrame)|BaseFrame|Gets or creates the main frame
|[basalt.removeSchedule](#basalt.removeSchedule)|boolean|Removes a scheduled update
|[basalt.run](#basalt.run)|-|Starts the Basalt runtime
|[basalt.schedule](#basalt.schedule)|thread|Schedules a function to run in a coroutine
|[basalt.setActiveFrame](#basalt.setActiveFrame)|-|Sets the active frame
|[basalt.stop](#basalt.stop)|-|Stops the Basalt runtime
|[basalt.update](#basalt.update)|-|Runs basalt once


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
* `table` `BaseFrame` The created frame instance

### Usage
 ```lua
local mainFrame = basalt.createFrame()
```

## basalt.getAPI(name)
Returns a Plugin API

### Parameters
* `name` `string` The name of the plugin

### Returns
* `table` `Plugin` The plugin API

## basalt.getElementManager()
Returns the element manager instance

### Returns
* `table` `ElementManager` The element manager

### Usage
 ```lua
local manager = basalt.getElementManager()
```

## basalt.getMainFrame()
Gets or creates the main frame

### Returns
* `BaseFrame` `table` The main frame instance

### Usage
 ```lua
local frame = basalt.getMainFrame()
```

## basalt.removeSchedule(func)
Removes a scheduled update

### Parameters
* `func` `thread` The scheduled function to remove

### Returns
* `boolean` `success` Whether the scheduled function was removed

### Usage
 ```lua
basalt.removeSchedule(scheduleId)
```

## basalt.run(isActive?)
Starts the Basalt runtime

### Parameters
* `isActive` *(optional)* `boolean` Whether to start active (default: true)

### Usage
 ```lua
basalt.run()
basalt.run(false)
```

## basalt.schedule(func)
Schedules a function to run in a coroutine

### Parameters
* `func` `function` The function to schedule

### Returns
* `thread` `func` The scheduled function

### Usage
 ```lua
local id = basalt.scheduleUpdate(myFunction)
```

## basalt.setActiveFrame(frame)
Sets the active frame

### Parameters
* `frame` `table` The frame to set as active

### Usage
 ```lua
basalt.setActiveFrame(myFrame)
```

## basalt.stop()
Stops the Basalt runtime

### Usage
 ```lua
basalt.stop()
```

## basalt.update(...)
Runs basalt once

### Parameters
* `...` *(vararg)* `any` The event to run with

### Usage
 ```lua
basalt.update()
```



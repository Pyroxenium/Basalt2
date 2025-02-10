# Basalt
This is the UI Manager and the starting point for your project. The following functions allow you to influence the default behavior of Basalt.

Before you can access Basalt, you need to add the following code on top of your file:

### Usage
 ```lua
local basalt = require("basalt")
```

What this code does is it loads basalt into the project, and you can access it by using the variable defined as "basalt".

## Functions

|Method|Returns|Description|
|---|---|---|
|[basalt.create](#basalt.create)|table|Creates a new UI element
|[basalt.createFrame](#basalt.createFrame)|table|
|[basalt.getElementManager](#basalt.getElementManager)|table|
|[basalt.getMainFrame](#basalt.getMainFrame)|BaseFrame|
|[basalt.removeSchedule](#basalt.removeSchedule)|-|
|[basalt.run](#basalt.run)|-|
|[basalt.scheduleUpdate](#basalt.scheduleUpdate)|number|
|[basalt.setActiveFrame](#basalt.setActiveFrame)|-|
|[basalt.stop](#basalt.stop)|-|
|[basalt.update](#basalt.update)|-|

## basalt.create(type, id?)
Creates and returns a new UI element of the specified type!

### Parameters
* `type` `string` The type of element to create (e.g. "Button", "Label", "BaseFrame")
* `id` *(optional)* `string` Optional unique identifier for the element

### Returns
* `table` `element` The created element instance

### Usage
 ```lua
local button = basalt.create("Button")
```

## basalt.createFrame()
Creates and returns a new frame

### Returns
* `table` `BaseFrame` The created frame instance

### Usage
 ```lua
local mainFrame = basalt.createFrame()
```

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

## basalt.removeSchedule(id)
Removes a scheduled update

### Parameters
* `id` `number` The schedule ID to remove

### Usage
 ```lua
basalt.removeSchedule(scheduleId)
```

## basalt.run(isActive)
Starts the Basalt runtime

### Parameters
* `isActive` `boolean` Whether to start active (default: true)

### Usage
 ```lua
basalt.run()
basalt.run(false)
```

## basalt.scheduleUpdate(func)
Schedules a function to be updated

### Parameters
* `func` `function` The function to schedule

### Returns
* `number` `Id` The schedule ID

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

## basalt.update()
Updates all scheduled functions

### Usage
 ```lua
basalt.update()
```


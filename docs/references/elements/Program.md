# Program
_This is the program class. It provides a program that runs in a window._

Extends: `VisualElement`

## Examples (Executable)
```lua run
local basalt = require("basalt")

local main = basalt.getMainFrame()

local execPath = "rom/programs/fun/worm.lua"

local btn = main:addButton({
x = 5,
y = 2,
width = 20,
height = 3,
text = "Run Worm",
}):onClick(function()
local frame = main:addFrame({
x = 2,
y = 2,
width = 28,
height = 10,
title = "Worm Program",
draggable = true,
})
:setDraggingMap({{x=1, y=1, width=27, height=1}})
:onFocus(function(self)
self:prioritize()
end)
local program = frame:addProgram({
x = 1,
y = 2,
width = 28,
height = 9,
})
program:execute(execPath)
frame:addLabel({
x = 2,
y = 1,
text = "Worm",
foreground = colors.lightBlue
})
frame:addButton({
x = frame.get("width"),
y = 1,
width = 1,
height = 1,
text = "X",
background = colors.red,
foreground = colors.white
}):onClick(function()
frame:destroy()
end)
end)

basalt.run()
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|program|table|nil|The program instance|
|path|string|""|The path to the program|
|running|boolean|false|Whether the program is running|
|errorCallback|function|nil|The error callback function|
|doneCallback|function|nil|The done callback function|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Program:execute](#program-execute-path-env-addenvironment)|Program|Executes a program|
|[Program:stop](#program-stop)|Program|Stops the program|
|[Program:sendEvent](#program-sendevent-event-any)|Program|Sends an event to the program|
|[Program:onError](#program-onerror-fn)|Program|Registers a callback for the program's error event|
|[Program:onDone](#program-ondone-fn)|Program|Registers a callback for the program's done event|

## Program:execute(path, env?, addEnvironment?)

Executes a program

### Parameters
* `path` `string` The path to the program
* `env` *(optional)* `table` The environment to run the program in
* `addEnvironment` *(optional)* `boolean` Whether to add the environment to the program's environment (false = overwrite instead of adding)

### Returns
* `Program` `self` The Program instance

## Program:stop()

Stops the program

### Returns
* `Program` `self` The Program instance

## Program:sendEvent(event, any)

Sends an event to the program

### Parameters
* `event` `string` The event to send
* `any` `The` event arguments

### Returns
* `Program` `self` The Program instance

## Program:onError(fn)

Registers a callback for the program's error event, if the function returns false, the program won't stop

### Parameters
* `fn` `function` The callback function to register

### Returns
* `Program` `self` The Program instance

## Program:onDone(fn)

Registers a callback for the program's done event

### Parameters
* `fn` `function` The callback function to register

### Returns
* `Program` `self` The Program instance

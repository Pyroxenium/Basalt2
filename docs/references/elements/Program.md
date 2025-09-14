# Program
_This is the program class. It provides a program that runs in a window._

Extends: `VisualElement`

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

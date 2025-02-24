# Program : VisualElement
This is the program class. It provides a program that runs in a window.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|program|table|nil|The program instance
|path|string|""|The path to the program
|running|boolean|false|Whether the program is running

## Functions

|Method|Returns|Description|
|---|---|---|
|[Program.new](#Program.new)|Program|Creates a new Program instance
|[Program:dispatchEvent](#Program:dispatchEvent)|any|Handles all incomming events
|[Program:execute](#Program:execute)|Program|Executes a program
|[Program:focus](#Program:focus)|-|Gets called when the element gets focused
|[Program:init](#Program:init)|Program|Initializes the Program instance
|[Program:render](#Program:render)|-|Renders the program

## Program.new()
Creates a new Program instance

### Returns
* `Program` `object` The newly created Program instance

### Usage
 ```lua
local element = Program.new("myId", basalt)
```

## Program:dispatchEvent(event, ...)
Handles all incomming events

### Parameters
* `event` `string` The event to handle
* `...` `any` The event arguments

### Returns
* `any` `result` The event result

## Program:execute(path)
Executes a program

### Parameters
* `path` `string` The path to the program

### Returns
* `Program` `self` The Program instance

## Program:focus()
Gets called when the element gets focused

## Program:init(props, basalt)
Initializes the Program instanceProperty

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Program` `self` The initialized instance

## Program:render()
Renders the program



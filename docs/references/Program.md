Rendering optimization (only render when screen changed)
Eventsystem improvement
Cursor is sometimes not visible on time
# Program : VisualElement

## Functions

|Method|Returns|Description|
|---|---|---|
|[BasaltProgram.new](#BasaltProgram.new)|-|
|[BasaltProgram:resize](#BasaltProgram:resize)|-|
|[BasaltProgram:resume](#BasaltProgram:resume)|-|
|[BasaltProgram:run](#BasaltProgram:run)|-|
|[BasaltProgram:stop](#BasaltProgram:stop)|-|
|[Program.new](#Program.new)|Program|
|[Program:dispatchEvent](#Program:dispatchEvent)|-|
|[Program:execute](#Program:execute)|-|
|[Program:focus](#Program:focus)|-|
|[Program:init](#Program:init)|-|
|[Program:render](#Program:render)|-|

## BasaltProgram.new()

## BasaltProgram:resize()

## BasaltProgram:resume()

## BasaltProgram:run()

## BasaltProgram:stop()

## Program.new(props, basalt)
Creates a new Program instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Program` `object` The newly created Program instance

### Usage
 ```lua
local element = Program.new("myId", basalt)
```

## Program:dispatchEvent()

## Program:execute()

## Program:focus()

## Program:init()

## Program:render()


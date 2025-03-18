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
|[Program:execute](#program-execute)|Program|Executes a program


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|Program:dispatchEvent|any|Handles all incomming events
|Program:focus|-|Gets called when the element gets focused
|Program:init|Program|Initializes the Program instance
|Program:render|-|Renders the program

## Program:execute(path)
Executes a program

### Parameters
* `path` `string` The path to the program

### Returns
* `Program` `self` The Program instance



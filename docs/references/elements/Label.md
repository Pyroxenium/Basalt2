# Label : VisualElement
This is the label class. It provides a simple text display element that automatically
resizes its width based on the text content.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|Label|The text content to display. Can be a string or a function that returns a string

## Functions

|Method|Returns|Description|
|---|---|---|
|[Label.new](#Label.new)|Label|Creates a new Label instance
|[Label:init](#Label:init)|Label|Initializes the Label instance
|[Label:render](#Label:render)|-|Renders the Label by drawing its text content

## Label.new()
Creates a new Label instance

### Returns
* `Label` `self` The newly created Label instance

### Usage
 ```lua
local label = Label.new()
```

## Label:init(props, basalt)
Initializes the Label instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Label` `self` The initialized instance

## Label:render()
Renders the Label



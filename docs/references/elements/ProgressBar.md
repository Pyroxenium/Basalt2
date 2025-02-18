# ProgressBar : VisualElement
This is the progress bar class. It provides a visual representation of progress
with optional percentage display and customizable colors.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|progress|number|0|Current progress value (0-100)
|showPercentage|boolean|false|Whether to show the percentage text in the center
|progressColor|color|lime|The color used for the filled portion of the progress bar

## Functions

|Method|Returns|Description|
|---|---|---|
|[ProgressBar.new](#ProgressBar.new)|ProgressBar|Creates a new ProgressBar instance
|[ProgressBar:init](#ProgressBar:init)|ProgressBar|Initializes the ProgressBar instance
|[ProgressBar:render](#ProgressBar:render)|-|Renders the progress bar with filled portion and optional percentage text

## ProgressBar.new()
Creates a new ProgressBar instance

### Returns
* `ProgressBar` `self` The newly created ProgressBar instance

### Usage
 ```lua
local progressBar = ProgressBar.new()
```

## ProgressBar:init(props, basalt)
Initializes the ProgressBar instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `ProgressBar` `self` The initialized instance

## ProgressBar:render()
Renders the ProgressBar



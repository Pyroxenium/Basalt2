# ProgressBar : VisualElement
This is the progress bar class. It provides a visual representation of progress
with optional percentage display and customizable colors.

### Usage
 ```lua
local progressBar = main:addProgressBar()
progressBar:setDirection("up") 
progressBar:setProgress(50)
```


## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|progress|number|0|Current progress value (0-100)
|showPercentage|boolean|false|Whether to show the percentage text in the center
|progressColor|color|lime|The color used for the filled portion of the progress bar
|direction|string|right|The direction of the progress bar ("up", "down", "left", "right")


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|ProgressBar:init|ProgressBar|Initializes the ProgressBar instance
|ProgressBar:render|-|Renders the progress bar with filled portion and optional percentage text



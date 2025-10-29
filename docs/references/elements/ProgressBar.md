# ProgressBar
_This is the progress bar class. It provides a visual representation of progress_
_with optional percentage display and customizable colors._

Extends: `VisualElement`

## Usage
```lua run
local progressBar = main:addProgressBar()
```

```lua run
progressBar:setDirection("up") 
```

```lua run
progressBar:setProgress(50)
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|progress|number|0|Current progress value (0-100)|
|showPercentage|boolean|false|Whether to show the percentage text in the center|
|progressColor|color|lime|The color used for the filled portion of the progress bar|
|direction|string|right|The direction of the progress bar ("up", "down", "left", "right")|

# ProgressBar
_This is the progress bar class. It provides a visual representation of progress_
_with optional percentage display and customizable colors._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|progress|number|0|Current progress value (0-100)|
|showPercentage|boolean|false|Whether to show the percentage text in the center|
|progressColor|color|lime|The color used for the filled portion of the progress bar|
|direction|string|right|The direction of the progress bar ("up", "down", "left", "right")|

## Functions

|Method|Returns|Description|
|---|---|---|
|[ProgressBar.new](#progressbar-new)|ProgressBar|Creates a new ProgressBar instance|
|[ProgressBar:init](#progressbar-init-props-basalt)|ProgressBar|Initializes the ProgressBar instance|
|[ProgressBar:render](#progressbar-render)|-|Renders the progress bar with filled portion and optional percentage text|

## ProgressBar.new()

Creates a new ProgressBar instance

### Returns
* `ProgressBar` `self` The newly created ProgressBar instance

## ProgressBar:init(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `ProgressBar` `self` The initialized instance

## ProgressBar:render()
# Slider
_This is the slider class. It provides a draggable slider control that can be either horizontal or vertical,_
_with customizable colors and value ranges._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|step|number|1|Current position of the slider handle (1 to width/height)|
|max|number|100|Maximum value for value conversion (maps slider position to this range)|
|horizontal|boolean|true|Whether the slider is horizontal (false for vertical)|
|barColor|color|gray|Color of the slider track|
|sliderColor|color|blue|Color of the slider handle|

## Events

|Event|Parameters|Description|
|---|---|---|
|onChange|`value number`|Fired when the slider value changes|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Slider:getValue](#slider-getvalue)|number|Gets the current value mapped to the max range|

## Slider:getValue()

Gets the current value of the slider

### Returns
* `number` `value` The current value (0 to max)

### Usage
```lua
local value = slider:getValue()
```

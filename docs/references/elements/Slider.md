# Slider : VisualElement
This is the slider class. It provides a draggable slider control that can be either horizontal or vertical,
with customizable colors and value ranges.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|step|number|1|Current position of the slider handle (1 to width/height)
|max|number|100|Maximum value for value conversion (maps slider position to this range)
|horizontal|boolean|true|Whether the slider is horizontal (false for vertical)
|barColor|color|gray|Color of the slider track
|sliderColor|color|blue|Color of the slider handle

## Events

|Event|Parameters|Description|
|---|---|---|
|onChange|`value number`|Fired when the slider value changes|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Slider.new](#Slider.new)|Slider|Creates a new Slider instance
|[Slider:getValue](#Slider:getValue)|number|Gets the current value mapped to the max range
|[Slider:init](#Slider:init)|Slider|Initializes the Slider instance
|[Slider:mouse_click](#Slider:mouse_click)|boolean|Updates slider position on mouse click
|[Slider:mouse_scroll](#Slider:mouse_scroll)|boolean|Handles mouse release events
|[Slider:render](#Slider:render)|-|Renders the slider with track and handle


## Slider.new()
Creates a new Slider instance

### Returns
* `Slider` `self` The newly created Slider instance

### Usage
 ```lua
local slider = Slider.new()
```

## Slider:getValue()
Gets the current value of the slider

### Returns
* `number` `value` The current value (0 to max)

### Usage
 ```lua
local value = slider:getValue()
```

## Slider:init(props, basalt)
Initializes the Slider instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Slider` `self` The initialized instance

## Slider:mouse_click(button, x, y)
Handles mouse click events

### Parameters
* `button` `number` The mouse button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Slider:mouse_scroll(button, x, y)
Handles mouse release events

### Parameters
* `button` `number` The mouse button that was released
* `x` `number` The x position of the release
* `y` `number` The y position of the release

### Returns
* `boolean` `handled` Whether the event was handled

## Slider:render()
Renders the slider



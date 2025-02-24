# Checkbox : VisualElement
The Checkbox is a visual element that can be checked.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|checked|boolean|Whether|checkbox is checked
|text|string|empty|Text to display
|checkedText|string|Text|when checked
|autoSize|boolean|true|Whether to automatically size the checkbox

## Functions

|Method|Returns|Description|
|---|---|---|
|[Checkbox.new](#Checkbox.new)|Checkbox|Creates a new Checkbox instance
|[Checkbox:init](#Checkbox:init)|-|Initializes the Checkbox instance
|[Checkbox:mouse_click](#Checkbox:mouse_click)|boolean|Handles mouse click events
|[Checkbox:render](#Checkbox:render)|-|Renders the Checkbox


## Checkbox.new()
Creates a new Checkbox instance

### Returns
* `Checkbox` `self` The created instance

## Checkbox:init(props, basalt)
Initializes the Checkbox instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

## Checkbox:mouse_click(button, x, y)
Handles mouse click events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `Clicked` Whether the event was handled

## Checkbox:render()
Renders the Checkbox



# Checkbox : VisualElement

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|checked|boolean|Whether|checkbox is checked
|text|string|Label|text
|symbol|string|Check|symbol

## Functions

|Method|Returns|Description|
|---|---|---|
|[Checkbox.new](#Checkbox.new)|Checkbox|
|[Checkbox:init](#Checkbox:init)|-|
|[Checkbox:mouse_click](#Checkbox:mouse_click)|boolean|
|[Checkbox:render](#Checkbox:render)|-|

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
* `boolean` `Whether` the event was handled

## Checkbox:render()
Renders the Checkbox


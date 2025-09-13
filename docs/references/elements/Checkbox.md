# Checkbox
_The Checkbox is a visual element that can be checked._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|checked|boolean|Whether|checkbox is checked|
|text|string|empty|Text to display|
|checkedText|string|Text|when checked|
|autoSize|boolean|true|Whether to automatically size the checkbox|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Checkbox.new](#checkbox-new)|Checkbox|Creates a new Checkbox instance|
|[Checkbox:init](#checkbox-init-props-basalt)|-|Initializes the Checkbox instance|
|[Checkbox:mouse_click](#checkbox-mouse-click-button-x-y)|boolean|Handles mouse click events|
|[Checkbox:render](#checkbox-render)|-|Renders the Checkbox|

## Checkbox.new()
### Returns
* `Checkbox` `self` The created instance

## Checkbox:init(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

## Checkbox:mouse_click(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `Clicked` Whether the event was handled

## Checkbox:render()
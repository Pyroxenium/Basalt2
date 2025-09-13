# Switch
_The Switch is a standard Switch element with click handling and state management._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|checked|boolean|Whether|switch is checked|
|text|string|Text|to display next to switch|
|autoSize|boolean|Whether|to automatically size the element to fit switch and text|
|onBackground|number|Background|color when ON|
|offBackground|number|Background|color when OFF|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Switch.new](#switch-new)|table|Creates a new Switch instance|
|[Switch:init](#switch-init-props-basalt)|-|Initializes the Switch instance|
|[Switch:mouse_click](#switch-mouse-click-button-x-y)|boolean|Handles mouse click events|
|[Switch:render](#switch-render)|-|Renders the Switch|

## Switch.new()
### Returns
* `table` `self` The created instance

## Switch:init(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

## Switch:mouse_click(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `Whether` the event was handled

## Switch:render()
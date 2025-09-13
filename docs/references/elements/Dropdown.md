# Dropdown
_This is the dropdown class. It is a visual element that can show a list of selectable items in a dropdown menu._

Extends: `List`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|isOpen|boolean|false|Whether the dropdown menu is currently open|
|dropdownHeight|number|5|Maximum height of the dropdown menu when open|
|selectedText|string|""|The text to show when no item is selected|
|dropSymbol|string|"\31"|The symbol to show for dropdown indication|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Dropdown.new](#dropdown-new)|Dropdown|Creates a new Dropdown instance|
|[Dropdown:Dropdown](#dropdown-dropdown-props-basalt)|Dropdown|Initializes the Dropdown instance|
|[Dropdown:Dropdown](#dropdown-dropdown-button-x-y)|boolean|Handles mouse click events|
|[Dropdown:Dropdown](#dropdown-dropdown)|-|Renders the Dropdown|

## Dropdown.new()

Creates a new Dropdown instance

### Returns
* `Dropdown` `self` The newly created Dropdown instance

## Dropdown:Dropdown(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Dropdown` `self` The initialized instance

## Dropdown:Dropdown(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Dropdown:Dropdown()
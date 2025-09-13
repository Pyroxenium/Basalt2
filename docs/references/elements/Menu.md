# Menu
_This is the menu class. It provides a horizontal menu bar with selectable items.
Menu items are displayed in a single row and can have custom colors and callbacks._

Extends: `List`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|separatorColor|color|gray|The color used for separator items in the menu|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Menu.new](#menu-new)|Menu|Creates a new Menu instance|
|[Menu:Menu](#menu-menu-props-basalt)|Menu|Initializes the Menu instance|
|[Menu:Menu](#menu-menu-items)|Menu|Sets the menu items and calculates total width|
|[Menu:Menu](#menu-menu)|-|Renders the menu horizontally with proper spacing and colors|
|[Menu:Menu](#menu-menu-button-x-y)|boolean|Handles mouse click events and item selection|

## Menu.new()

Creates a new Menu instance

### Returns
* `Menu` `self` The newly created Menu instance

## Menu:Menu(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Menu` `self` The initialized instance

## Menu:Menu(items)

Sets the menu items

### Parameters
* `items` `table` [] List of items with {text, separator, callback, foreground, background} properties

### Returns
* `Menu` `self` The Menu instance

### Usage
```lua
menu:setItems({{text="File"}, {separator=true}, {text="Edit"}})
```

## Menu:Menu()
## Menu:Menu(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `Whether` the event was handled

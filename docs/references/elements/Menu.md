# Menu : List
This is the menu class. It provides a horizontal menu bar with selectable items.
Menu items are displayed in a single row and can have custom colors and callbacks.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|separatorColor|color|gray|The color used for separator items in the menu

## Functions

|Method|Returns|Description|
|---|---|---|
|[Menu.new](#Menu.new)|Menu|Creates a new Menu instance
|[Menu:init](#Menu:init)|Menu|Initializes the Menu instance
|[Menu:mouse_click](#Menu:mouse_click)|boolean|Handles mouse click events and item selection
|[Menu:render](#Menu:render)|-|Renders the menu horizontally with proper spacing and colors
|[Menu:setItems](#Menu:setItems)|Menu|Sets the menu items and calculates total width

## Menu.new()
Creates a new Menu instance

### Returns
* `Menu` `self` The newly created Menu instance

### Usage
 ```lua
local menu = Menu.new()
```

## Menu:init(props, basalt)
Initializes the Menu instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Menu` `self` The initialized instance

## Menu:mouse_click(button, x, y)
Handles mouse click events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `Whether` the event was handled

## Menu:render()
Renders the menu

## Menu:setItems(items)
Sets the menu items

### Parameters
* `items` `table[]` List of items with {text, separator, callback, foreground, background} properties

### Returns
* `Menu` `self` The Menu instance

### Usage
 ```lua
menu:setItems({{text="File"}, {separator=true}, {text="Edit"}})
```



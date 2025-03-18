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
|[Menu:setItems](#menu-setitems)|Menu|Sets the menu items and calculates total width


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|Menu:init|Menu|Initializes the Menu instance
|Menu:mouse_click|boolean|Handles mouse click events and item selection
|Menu:render|-|Renders the menu horizontally with proper spacing and colors

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



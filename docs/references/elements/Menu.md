# Menu
_This is the menu class. It provides a horizontal menu bar with selectable items._
_Menu items are displayed in a single row and can have custom colors and callbacks._

Extends: `List`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|separatorColor|color|gray|The color used for separator items in the menu|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Menu:setItems](#menu-setitems-items)|Menu|Sets the menu items and calculates total width|

## Menu:setItems(items)

Sets the menu items

### Parameters
* `items` `table` [] List of items with {text, separator, callback, foreground, background} properties

### Returns
* `Menu` `self` The Menu instance

### Usage
```lua
menu:setItems({{text="File"}, {separator=true}, {text="Edit"}})
```

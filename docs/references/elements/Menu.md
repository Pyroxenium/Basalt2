# Menu
_This is the menu class. It provides a horizontal menu bar with selectable items. Menu items are displayed in a single row and can have custom colors and callbacks._

Extends: `List`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|separatorColor|color|gray|The color used for separator items in the menu|
|spacing|number|0|The number of spaces between menu items|
|horizontalOffset|number|0|Current horizontal scroll offset|
|maxWidth|number|nil|Maximum width before scrolling is enabled (nil = auto-size to items)|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Menu:getTotalWidth](#menu-gettotalwidth)|number|Calculates total width of menu items|

## Menu:getTotalWidth()

Calculates the total width of all menu items with spacing

### Returns
* `number` `totalWidth` The total width of all items

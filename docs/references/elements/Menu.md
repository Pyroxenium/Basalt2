# Menu
_This is the menu class. It provides a horizontal menu bar with selectable items. Menu items are displayed in a single row and can have custom colors and callbacks._

Extends: `List`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|separatorColor|color|gray|The color used for separator items in the menu|
|spacing|number|0|The number of spaces between menu items|
|openDropdown|table|nil|Currently open dropdown data {index, items, x, y, width, height}|
|dropdownBackground|color|black|Background color for dropdown menus|
|dropdownForeground|color|white|Foreground color for dropdown menus|
|horizontalOffset|number|0|Current horizontal scroll offset|
|maxWidth|number|nil|Maximum width before scrolling is enabled (nil = auto-size to items)|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Menu:getTotalWidth](#menu-gettotalwidth)|number|Calculates total width of menu items|
|[Menu:showDropdown](#menu-showdropdown-index-item-itemx)|-|Shows dropdown menu|
|[Menu:hideDropdown](#menu-hidedropdown)|-|Closes dropdown menu|
|[Menu:isInsideDropdown](#menu-isinsidedropdown-relx-rely-dropdown)|boolean|Checks if position is in dropdown|
|[Menu:handleDropdownClick](#menu-handledropdownclick-relx-rely-dropdown)|boolean|Handles dropdown click|

## Menu:getTotalWidth()

Calculates the total width of all menu items with spacing

### Returns
* `number` `totalWidth` The total width of all items

## Menu:showDropdown(index, item, itemX)

Shows a dropdown menu for a specific item

### Parameters
* `index` `number` The item index
* `item` `table` The menu item
* `itemX` `number` The X position of the item

## Menu:hideDropdown()

Closes the currently open dropdown

## Menu:isInsideDropdown(relX, relY, dropdown)

Checks if a position is inside the dropdown

### Parameters
* `relX` `number` Relative X position
* `relY` `number` Relative Y position
* `dropdown` `table` Dropdown data

### Returns
* `boolean` `inside` Whether position is inside dropdown

## Menu:handleDropdownClick(relX, relY, dropdown)

Handles click inside dropdown

### Parameters
* `relX` `number` Relative X position
* `relY` `number` Relative Y position
* `dropdown` `table` Dropdown data

### Returns
* `boolean` `handled` Whether click was handled

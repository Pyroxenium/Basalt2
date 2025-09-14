# List
_This is the list class. It provides a scrollable list of selectable items with support for _
_custom item rendering, separators, and selection handling._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|items|table|{}|List of items to display. Items can be tables with properties including selected state|
|selectable|boolean|true|Whether items in the list can be selected|
|multiSelection|boolean|false|Whether multiple items can be selected at once|
|offset|number|0|Current scroll offset for viewing long lists|
|selectedBackground|color|blue|Background color for selected items|
|selectedForeground|color|white|Text color for selected items|

## Events

|Event|Parameters|Description|
|---|---|---|
|onSelect|`index number, item table`|Fired when an item is selected|

## Functions

|Method|Returns|Description|
|---|---|---|
|[List:addItem](#list-additem-text)|List|Adds an item to the list|
|[List:removeItem](#list-removeitem-index)|List|Removes an item from the list|
|[List:clear](#list-clear)|List|Clears all items from the list|
|[List:getSelectedItems](#list-getselecteditems)|table|Gets the currently selected items|
|[List:getSelectedItem](#list-getselecteditem)|selected|Gets first selected item|
|[List:onSelect](#list-onselect-callback)|List|Registers a callback for the select event|
|[List:scrollToBottom](#list-scrolltobottom)|List|Scrolls the list to the bottom|
|[List:scrollToTop](#list-scrolltotop)|List|Scrolls the list to the top|

## List:addItem(text)

Adds an item to the list

### Parameters
* `text` `string|table` The item to add (string or item table)

### Returns
* `List` `self` The List instance

### Usage
```lua
list:addItem("New Item")
list:addItem({text="Item", callback=function() end})
```

## List:removeItem(index)

Removes an item from the list

### Parameters
* `index` `number` The index of the item to remove

### Returns
* `List` `self` The List instance

### Usage
```lua
list:removeItem(1)
```

## List:clear()

Clears all items from the list

### Returns
* `List` `self` The List instance

### Usage
```lua
list:clear()
```

## List:getSelectedItems()

Gets the currently selected items

### Returns
* `table` `selected` List of selected items

### Usage
```lua
local selected = list:getSelectedItems()
```

## List:getSelectedItem()

Gets first selected item

### Returns
* `selected` `The` first item

## List:onSelect(callback)

Registers a callback for the select event

### Parameters
* `callback` `function` The callback function to register

### Returns
* `List` `self` The List instance

### Usage
```lua
list:onSelect(function(index, item) print("Selected item:", index, item) end)
```

## List:scrollToBottom()

Scrolls the list to the bottom

### Returns
* `List` `self` The List instance

## List:scrollToTop()

Scrolls the list to the top

### Returns
* `List` `self` The List instance

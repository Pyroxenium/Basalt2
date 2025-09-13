# List
_This is the list class. It provides a scrollable list of selectable items with support for 
custom item rendering, separators, and selection handling._

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
|[List.new](#list-new)|List|Creates a new List instance|
|[List:List](#list-list-props-basalt)|List|Initializes the List instance|
|[List:List](#list-list-text)|List|Adds an item to the list|
|[List:List](#list-list-index)|List|Removes an item from the list|
|[List:List](#list-list)|List|Clears all items from the list|
|[List:List](#list-list)|table|Gets the currently selected items|
|[List:List](#list-list)|selected|Gets first selected item|
|[List:List](#list-list-button-x-y)|boolean|Handles mouse click events|
|[List:List](#list-list-direction-x-y)|boolean|Handles mouse scroll events|
|[List:List](#list-list-callback)|List|Registers a callback for the select event|
|[List:List](#list-list)|List|Scrolls the list to the bottom|
|[List:List](#list-list)|List|Scrolls the list to the top|
|[List:List](#list-list)|-|Renders the list|

## List.new()

Creates a new List instance

### Returns
* `List` `self` The newly created List instance

## List:List(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `List` `self` The initialized instance

## List:List(text)

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

## List:List(index)

Removes an item from the list

### Parameters
* `index` `number` The index of the item to remove

### Returns
* `List` `self` The List instance

### Usage
```lua
list:removeItem(1)
```

## List:List()

Clears all items from the list

### Returns
* `List` `self` The List instance

### Usage
```lua
list:clear()
```

## List:List()

Gets the currently selected items

### Returns
* `table` `selected` List of selected items

### Usage
```lua
local selected = list:getSelectedItems()
```

## List:List()

Gets first selected item

### Returns
* `selected` `The` first item

## List:List(button, x, y)
### Parameters
* `button` `number` The mouse button that was clicked
* `x` `number` The x-coordinate of the click
* `y` `number` The y-coordinate of the click

### Returns
* `boolean` `Whether` the event was handled

## List:List(direction, x, y)
### Parameters
* `direction` `number` The direction of the scroll (1 for down, -1 for up)
* `x` `number` The x-coordinate of the scroll
* `y` `number` The y-coordinate of the scroll

### Returns
* `boolean` `Whether` the event was handled

## List:List(callback)

Registers a callback for the select event

### Parameters
* `callback` `function` The callback function to register

### Returns
* `List` `self` The List instance

### Usage
```lua
list:onSelect(function(index, item) print("Selected item:", index, item) end)
```

## List:List()

Scrolls the list to the bottom

### Returns
* `List` `self` The List instance

## List:List()

Scrolls the list to the top

### Returns
* `List` `self` The List instance

## List:List()
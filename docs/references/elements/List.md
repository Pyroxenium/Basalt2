# List : VisualElement
This is the list class. It provides a scrollable list of selectable items with support for 
custom item rendering, separators, and selection handling.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|items|table|{}|List of items to display. Items can be strings or tables with properties
|selectedIndex|number|0|Index of the currently selected item (0 means no selection)
|selectable|boolean|true|Whether items in the list can be selected
|offset|number|0|Current scroll offset for viewing long lists
|selectedColor|color|blue|Background color for the selected item

## Events

|Event|Parameters|Description|
|---|---|---|
|onSelect|`index number, item any`|Fired when an item is selected|

## Functions

|Method|Returns|Description|
|---|---|---|
|[List.new](#List.new)|List|Creates a new List instance
|[List:addItem](#List:addItem)|List|Adds an item to the list
|[List:clear](#List:clear)|List|Clears all items from the list
|[List:init](#List:init)|List|Initializes the List instance
|[List:mouse_click](#List:mouse_click)|boolean|Handles mouse click events
|[List:mouse_scroll](#List:mouse_scroll)|boolean|Handles mouse scroll events
|[List:onSelect](#List:onSelect)|List|Registers a callback for the select event
|[List:removeItem](#List:removeItem)|List|Removes an item from the list
|[List:render](#List:render)|-|Renders the list

## List.new()
Creates a new List instance

### Returns
* `List` `self` The newly created List instance

### Usage
 ```lua
local list = List.new()
```

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

## List:clear()
Clears all items from the list

### Returns
* `List` `self` The List instance

### Usage
 ```lua
list:clear()
```

## List:init(props, basalt)
Initializes the List instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `List` `self` The initialized instance

## List:mouse_click(button, x, y)
Handles mouse click events

### Parameters
* `button` `number` The mouse button that was clicked
* `x` `number` The x-coordinate of the click
* `y` `number` The y-coordinate of the click

### Returns
* `boolean` `Whether` the event was handled

## List:mouse_scroll(direction, x, y)
Handles mouse scroll events

### Parameters
* `direction` `number` The direction of the scroll (1 for down, -1 for up)
* `x` `number` The x-coordinate of the scroll
* `y` `number` The y-coordinate of the scroll

### Returns
* `boolean` `Whether` the event was handled

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

## List:render()
Renders the list



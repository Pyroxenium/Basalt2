# Collection
_This is the Collection class. It provides a collection of items_

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|selectable|boolean|true|Whether items can be selected|
|multiSelection|boolean|false|Whether multiple items can be selected at once|
|selectedBackground|color|blue|Background color for selected items|
|selectedForeground|color|white|Text color for selected items|

## Events

|Event|Parameters|Description|
|---|---|---|
|onSelect|`index number, item table`|Fired when an item is selected|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Collection:addItem](#collection-additem-text)|Collection|Adds an item to the Collection|
|[Collection:removeItem](#collection-removeitem-index)|Collection|Removes an item from the Collection|
|[Collection:clear](#collection-clear)|Collection|Clears all items from the Collection|
|[Collection:getSelectedItems](#collection-getselecteditems)|table|Gets the currently selected items|
|[Collection:getSelectedItem](#collection-getselecteditem)|selected|Gets first selected item|
|[Collection:onSelect](#collection-onselect-callback)|Collection|Registers a callback for the select event|

## Collection:addItem(text)

Adds an item to the Collection

### Parameters
* `text` `string|table` The item to add (string or item table)

### Returns
* `Collection` `self` The Collection instance

### Usage
```lua
Collection:addItem("New Item")
Collection:addItem({text="Item", callback=function() end})
```

## Collection:removeItem(index)

Removes an item from the Collection

### Parameters
* `index` `number` The index of the item to remove

### Returns
* `Collection` `self` The Collection instance

### Usage
```lua
Collection:removeItem(1)
```

## Collection:clear()

Clears all items from the Collection

### Returns
* `Collection` `self` The Collection instance

### Usage
```lua
Collection:clear()
```

## Collection:getSelectedItems()

Gets the currently selected items

### Returns
* `table` `selected` Collection of selected items

### Usage
```lua
local selected = Collection:getSelectedItems()
```

## Collection:getSelectedItem()

Gets first selected item

### Returns
* `selected` `The` first item

## Collection:onSelect(callback)

Registers a callback for the select event

### Parameters
* `callback` `function` The callback function to register

### Returns
* `Collection` `self` The Collection instance

### Usage
```lua
Collection:onSelect(function(index, item) print("Selected item:", index, item) end)
```

# List
_This is the list class. It provides a scrollable list of selectable items with support for _
_custom item rendering, separators, and selection handling._

Extends: `Collection`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|offset|number|0|Current scroll offset for viewing long lists|

## Events

|Event|Parameters|Description|
|---|---|---|
|onSelect|`index number, item table`|Fired when an item is selected|

## Functions

|Method|Returns|Description|
|---|---|---|
|[List:onSelect](#list-onselect-callback)|List|Registers a callback for the select event|
|[List:scrollToBottom](#list-scrolltobottom)|List|Scrolls the list to the bottom|
|[List:scrollToTop](#list-scrolltotop)|List|Scrolls the list to the top|

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

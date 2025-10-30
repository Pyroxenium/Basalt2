# Breadcrumb

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|path|table|{}|Array of strings representing the breadcrumb segments|
|clickable|true|boolean|Whether the segments are clickable|
|autoSize|false|boolean|Whether to resize the element width automatically based on text|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Breadcrumb.new](#breadcrumb-new)|table|Creates a new Breadcrumb instance|
|[Breadcrumb:init](#breadcrumb-init-props-basalt)|-|Initializes the Breadcrumb instance|
|[Breadcrumb:mouse_click](#breadcrumb-mouse-click-button-x-y)|boolean|Handles mouse click events|
|[Breadcrumb:onSelect](#breadcrumb-onselect-callback)|Breadcrumb|Registers a callback for the select event|

## Breadcrumb.new()
### Returns
* `table` self

## Breadcrumb:init(props, basalt)
### Parameters
* `props` `table`
* `basalt` `table`

## Breadcrumb:mouse_click(button, x, y)
### Parameters
* `button` `number`
* `x` `number`
* `y` `number`

### Returns
* `boolean` handled

## Breadcrumb:onSelect(callback)

Registers a callback for the select event

### Parameters
* `callback` `function` The callback function to register

### Returns
* `Breadcrumb` `self` The Breadcrumb instance

### Usage
```lua
breadcrumb:onSelect(function(segmentIndex, path) print("Navigated to segment:", segmentIndex, path) end)
```

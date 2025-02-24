# Flexbox : Container
This is the Flexbox class. It is a container that arranges its children in a flexible layout.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|flexDirection|string|"row"|The direction of the flexbox layout "row" or "column"
|flexSpacing|number|1|The spacing between flex items
|flexJustifyContent|string|"flex-start"|The alignment of flex items along the main axis
|flexWrap|boolean|false|Whether to wrap flex items onto multiple lines
|flexUpdateLayout|boolean|false|Whether to update the layout of the flexbox

## Functions

|Method|Returns|Description|
|---|---|---|
|[Flexbox.new](#Flexbox.new)|Flexbox|Creates a new Flexbox instance
|[Flexbox:addChild](#Flexbox:addChild)|Flexbox|Adds a child element to the flexbox
|[Flexbox:addLineBreak](#Flexbox:addLineBreak)|Flexbox|Adds a new line break to the flexbox.
|[Flexbox:init](#Flexbox:init)|Flexbox|Initializes the Flexbox instance
|[Flexbox:removeChild](#Flexbox:removeChild)|Flexbox|Removes a child element from the flexbox
|[Flexbox:render](#Flexbox:render)|Flexbox|Renders the flexbox and its children

## Flexbox.new()
Creates a new Flexbox instance

### Returns
* `Flexbox` `object` The newly created Flexbox instance

### Usage
 ```lua
local element = Flexbox.new("myId", basalt)
```

## Flexbox:addChild(element)
Adds a child element to the flexbox

### Parameters
* `element` `Element` The child element to add

### Returns
* `Flexbox` `self` The flexbox instance

## Flexbox:addLineBreak(self)
Adds a new line break to the flexbox

### Parameters
* `self` `Flexbox` The element itself

### Returns
* `nil` `nil` nil

## Flexbox:init(props, basalt)
Initializes the Flexbox instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Flexbox` `self` The initialized instance

## Flexbox:removeChild(element)
Removes a child element from the flexbox

### Parameters
* `element` `Element` The child element to remove

### Returns
* `Flexbox` `self` The flexbox instance

## Flexbox:render()
Renders the flexbox and its children

### Returns
* `Flexbox` `self` The flexbox instance



# Flexbox : Container
This is the Flexbox class. It is a container that arranges its children in a flexible layout.

### Usage
 ```lua
local flex = main:addFlexbox({background=colors.black, width=30, height=10})
flex:addButton():setFlexGrow(1)
flex:addButton():setFlexGrow(1)
flex:addButton():setFlexGrow(1)
```

The flexbox element adds the following properties to its children:

### Usage
 ```lua
flex:addButton():setFlexGrow(1) -- The flex-grow property defines the ability for a flex item to grow if necessary.
flex:addButton():setFlexShrink(1) -- The flex-shrink property defines the ability for a flex item to shrink if necessary.
flex:addButton():setFlexBasis(1) -- The flex-basis property defines the default size of an element before the remaining space is distributed.
```



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
|[Flexbox:addChild](#flexbox-addchild)|Flexbox|Adds a child element to the flexbox
|[Flexbox:addLineBreak](#flexbox-addlinebreak)|Flexbox|Adds a new line break to the flexbox.


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|Flexbox:init|Flexbox|Initializes the Flexbox instance
|Flexbox:removeChild|Flexbox|Removes a child element from the flexbox
|Flexbox:render|-|Renders the flexbox and its children

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



# FlexBox
_This is the FlexBox class. It is a container that arranges its children in a flexible layout._

Extends: `Container`

## Usage
```lua
local flex = main:addFlexbox({background=colors.black, width=30, height=10})
flex:addButton():setFlexGrow(1)
flex:addButton():setFlexGrow(1)
flex:addButton():setFlexGrow(1)
The flexbox element adds the following properties to its children:

flex:addButton():setFlexGrow(1) -- The flex-grow property defines the ability for a flex item to grow if necessary.
flex:addButton():setFlexShrink(1) -- The flex-shrink property defines the ability for a flex item to shrink if necessary.
flex:addButton():setFlexBasis(1) -- The flex-basis property defines the default size of an element before the remaining space is distributed.
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|flexDirection|string|"row"|The direction of the flexbox layout "row" or "column"|
|flexSpacing|number|1|The spacing between flex items|
|flexJustifyContent|string|"flex-start"|The alignment of flex items along the main axis|
|flexAlignItems|string|"flex-start"|The alignment of flex items along the cross axis|
|flexCrossPadding|number|0|The padding on both sides of the cross axis|
|flexWrap|boolean|false|Whether to wrap flex items onto multiple lines|

## Functions

|Method|Returns|Description|
|---|---|---|
|[FlexBox:addChild](#flexbox-addchild-element)|FlexBox|Adds a child element to the flexbox|
|[FlexBox:addLineBreak](#flexbox-addlinebreak-self)|FlexBox|Adds a new line break to the flexbox.|

## FlexBox:addChild(element)

Adds a child element to the flexbox

### Parameters
* `element` `Element` The child element to add

### Returns
* `FlexBox` `self` The flexbox instance

## FlexBox:addLineBreak(self)

Adds a new line break to the flexbox

### Parameters
* `self` `FlexBox` The element itself

### Returns
* `FlexBox`

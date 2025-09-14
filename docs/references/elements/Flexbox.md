# Flexbox
_This is the Flexbox class. It is a container that arranges its children in a flexible layout._
_The flexbox element adds the following properties to its children:_

Extends: `Container`

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
|[Flexbox:addChild](#flexbox-addchild-element)|Flexbox|Adds a child element to the flexbox|
|[Flexbox:addLineBreak](#flexbox-addlinebreak-self)|Flexbox|Adds a new line break to the flexbox.|

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
* `Flexbox`

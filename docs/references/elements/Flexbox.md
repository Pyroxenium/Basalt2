# Flexbox
_This is the Flexbox class. It is a container that arranges its children in a flexible layout.
The flexbox element adds the following properties to its children:
_

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
|[Flexbox.new](#flexbox-new)|Flexbox|Creates a new Flexbox instance|
|[Flexbox:Flexbox](#flexbox-flexbox-props-basalt)|Flexbox|Initializes the Flexbox instance|
|[Flexbox:Flexbox](#flexbox-flexbox-element)|Flexbox|Adds a child element to the flexbox|
|[Flexbox:Flexbox](#flexbox-flexbox-element)|Flexbox|Removes a child element from the flexbox|
|[Flexbox:Flexbox](#flexbox-flexbox-self)|Flexbox|Adds a new line break to the flexbox.|
|[Flexbox:Flexbox](#flexbox-flexbox)|-|Renders the flexbox and its children|

## Flexbox.new()
### Returns
* `Flexbox` `object` The newly created Flexbox instance

## Flexbox:Flexbox(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Flexbox` `self` The initialized instance

## Flexbox:Flexbox(element)

Adds a child element to the flexbox

### Parameters
* `element` `Element` The child element to add

### Returns
* `Flexbox` `self` The flexbox instance

## Flexbox:Flexbox(element)
### Parameters
* `element` `Element` The child element to remove

### Returns
* `Flexbox` `self` The flexbox instance

## Flexbox:Flexbox(self)

Adds a new line break to the flexbox

### Parameters
* `self` `Flexbox` The element itself

### Returns
* `Flexbox`

## Flexbox:Flexbox()
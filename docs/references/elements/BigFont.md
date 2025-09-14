# BigFont
_The BigFont element is a text element that displays larger text. It uses Wojbie's BigFont API to render the text in a larger font size. Credits to Wojbie for the original API._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|BigFont|BigFont text|
|fontSize|number|1|The font size of the BigFont|

## Functions

|Method|Returns|Description|
|---|---|---|
|[BigFont.new](#bigfont-new)|table|Creates a new BigFont instance|
|[BigFont:init](#bigfont-init-props-basalt)|-|Initializes the BigFont instance|
|[BigFont:render](#bigfont-render)|-|Renders the BigFont|

## BigFont.new()
### Returns
* `table` `self` The created instance

## BigFont:init(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

## BigFont:render()
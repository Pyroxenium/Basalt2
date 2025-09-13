# BigFontText
_Basalt - Nyorie: Please don't copy paste this code to your projects, this code is slightly changed (to fit the way basalt draws elements), if you want the original code, checkout this:
http://www.computercraft.info/forums2/index.php?/topic/25367-bigfont-api-write-bigger-letters-v10/_

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
|[BigFont:BigFont](#bigfont-bigfont-props-basalt)|-|Initializes the BigFont instance|
|[BigFont:BigFont](#bigfont-bigfont)|-|Renders the BigFont|

## BigFont.new()
### Returns
* `table` `self` The created instance

## BigFont:BigFont(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

## BigFont:BigFont()
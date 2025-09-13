# BigFont : VisualElement
The BigFont element is a text element that displays larger text. It uses Wojbie's BigFont API to render the text in a larger font size. Credits to Wojbie for the original API.

### Usage
 ```lua
local font = main:addBigFont()
font:setText("Hello World!")
```


## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|BigFont|BigFont text
|fontSize|number|1|The font size of the BigFont


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|BigFont:init|-|Initializes the BigFont instance
|BigFont:render|-|Renders the BigFont



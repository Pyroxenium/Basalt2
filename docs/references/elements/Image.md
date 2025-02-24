# Image : VisualElement
This is the Image element class which can be used to display bimg format images.
The bimg format is a universal ComputerCraft image format.
See: https://github.com/SkyTheCodeMaster/bimg

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|bimg|table|{}|The bimg image data
|currentFrame|number|1|Current animation frame
|metadata|table|{}|Image metadata (version, palette, etc)

## Functions

|Method|Returns|Description|
|---|---|---|
|[Image.new](#Image.new)|-|
|[Image:getPixelData](#Image:getPixelData)|number?|
|[Image:init](#Image:init)|-|
|[Image:loadBimg](#Image:loadBimg)|-|
|[Image:nextFrame](#Image:nextFrame)|-|
|[Image:render](#Image:render)|-|
|[Image:setBg](#Image:setBg)|-|
|[Image:setChar](#Image:setChar)|-|
|[Image:setFg](#Image:setFg)|-|
|[Image:setPixel](#Image:setPixel)|-|

## Image.new()

## Image:getPixelData(x, y)
Gets pixel information at position

### Parameters
* `x` `number` X position
* `y` `number` Y position

### Returns
* `number?` `fg` Foreground color
* `number?` `bg` Background color
* `string?` `char` Character at position

## Image:init()

## Image:loadBimg(bimgData)
Loads a bimg format image

### Parameters
* `bimgData` `table` The bimg image data

## Image:nextFrame()

## Image:render()

## Image:setBg(x, y, color)
Sets background color at position

### Parameters
* `x` `number` X position
* `y` `number` Y position
* `color` `number` Color value (0-15)

## Image:setChar(x, y, char)
Sets character at position

### Parameters
* `x` `number` X position
* `y` `number` Y position
* `char` `string` Single character to set

## Image:setFg(x, y, color)
Sets foreground color at position

### Parameters
* `x` `number` X position
* `y` `number` Y position
* `color` `number` Color value (0-15)

## Image:setPixel(x, y, char, fg, bg)
Sets all properties at position

### Parameters
* `x` `number` X position
* `y` `number` Y position
* `char` `string?` Character to set (optional)
* `fg` `number?` Foreground color (optional)
* `bg` `number?` Background color (optional)



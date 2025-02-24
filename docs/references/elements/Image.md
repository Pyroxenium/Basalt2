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
|[Image:getPixelData](#Image:getPixelData)|number?|Gets pixel information at position
|[Image:loadBimg](#Image:loadBimg)|Image|Loads a bimg format image
|[Image:nextFrame](#Image:nextFrame)|Image|Advances to the next frame in the animation
|[Image:setBg](#Image:setBg)|-|Sets background color at position
|[Image:setChar](#Image:setChar)|-|Sets character at position
|[Image:setFg](#Image:setFg)|-|Sets foreground color at position
|[Image:setPixel](#Image:setPixel)|-|Sets all properties at position


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|[Image:init](#Image:init)|Image|Initializes the Image instance
|[Image:render](#Image:render)|-|Renders the Image

## Image:getPixelData(x, y)
Gets pixel information at position

### Parameters
* `x` `number` X position
* `y` `number` Y position

### Returns
* `number?` `fg` Foreground color
* `number?` `bg` Background color
* `string?` `char` Character at position

## Image:loadBimg(bimgData)
Loads a bimg format image

### Parameters
* `bimgData` `table` The bimg image data

### Returns
* `Image` `self` The Image instance

## Image:nextFrame()
Advances to the next frame in the animation

### Returns
* `Image` `self` The Image instance

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



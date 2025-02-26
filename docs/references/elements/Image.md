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
|autoResize|boolean|false|Whether to automatically resize the image when content exceeds bounds
|offsetX|number|0|Horizontal offset for viewing larger images
|offsetY|number|0|Vertical offset for viewing larger images

## Functions

|Method|Returns|Description|
|---|---|---|
|[Image:getImageSize](#Image:getImageSize)|-|
|[Image:getOffset](#Image:getOffset)|-|
|[Image:getPixelData](#Image:getPixelData)|number?|Gets pixel information at position
|[Image:loadBimg](#Image:loadBimg)|Image|Loads a bimg format image
|[Image:nextFrame](#Image:nextFrame)|Image|Advances to the next frame in the animation
|[Image:resizeImage](#Image:resizeImage)|-|
|[Image:setBg](#Image:setBg)|-|
|[Image:setFg](#Image:setFg)|-|
|[Image:setOffset](#Image:setOffset)|-|
|[Image:setPixel](#Image:setPixel)|-|
|[Image:setText](#Image:setText)|-|


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|[Image:init](#Image:init)|Image|Initializes the Image instance
|[Image:render](#Image:render)|-|Renders the Image

## Image:getImageSize()

## Image:getOffset()

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

## Image:resizeImage()

## Image:setBg()

## Image:setFg()

## Image:setOffset()

## Image:setPixel()

## Image:setText()



# Image : VisualElement
This is the Image element class which can be used to display bimg format images.
The bimg format is a universal ComputerCraft image format.
See: https://github.com/SkyTheCodeMaster/bimg

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|bimg|table|{}|The bimg image data
|currentFrame|number|1|Current animation frame
|autoResize|boolean|false|Whether to automatically resize the image when content exceeds bounds
|offsetX|number|0|Horizontal offset for viewing larger images
|offsetY|number|0|Vertical offset for viewing larger images

## Combined Properties

|Name|Properties|Description|
|---|---|---|
|offset|`offsetX offsetY`|Combined property for offsetX and offsetY|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Image:addFrame](#Image:addFrame)|Image|Adds a new frame to the image
|[Image:getBg](#Image:getBg)|-|
|[Image:getFg](#Image:getFg)|-|
|[Image:getFrame](#Image:getFrame)|table|Gets the specified frame
|[Image:getImageSize](#Image:getImageSize)|number|Gets the size of the image
|[Image:getMetadata](#Image:getMetadata)|-|
|[Image:getPixelData](#Image:getPixelData)|number?|Gets pixel information at position
|[Image:getText](#Image:getText)|-|
|[Image:nextFrame](#Image:nextFrame)|Image|Advances to the next frame in the animation
|[Image:resizeImage](#Image:resizeImage)|Image|Resizes the image to the specified width and height
|[Image:setBg](#Image:setBg)|Image|Sets the background color at the specified position
|[Image:setFg](#Image:setFg)|Image|Sets the foreground color at the specified position
|[Image:setMetadata](#Image:setMetadata)|-|
|[Image:setPixel](#Image:setPixel)|Image|Sets the pixel at the specified position
|[Image:setText](#Image:setText)|Image|Sets the text at the specified position
|[Image:updateFrame](#Image:updateFrame)|Image|Updates the specified frame with the provided data


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|[Image:init](#Image:init)|Image|Initializes the Image instance
|[Image:render](#Image:render)|-|Renders the Image

## Image:addFrame()
Adds a new frame to the image

### Returns
* `Image` `self` The Image instance

## Image:getBg()

## Image:getFg()

## Image:getFrame(frameIndex)
Gets the specified frame

### Parameters
* `frameIndex` `number` The index of the frame to get

### Returns
* `table` `frame` The frame data

## Image:getImageSize()
Gets the size of the image

### Returns
* `number` `width` The width of the image
* `number` `height` The height of the image

## Image:getMetadata()

## Image:getPixelData(x, y)
Gets pixel information at position

### Parameters
* `x` `number` X position
* `y` `number` Y position

### Returns
* `number?` `fg` Foreground color
* `number?` `bg` Background color
* `string?` `char` Character at position

## Image:getText()

## Image:nextFrame()
Advances to the next frame in the animation

### Returns
* `Image` `self` The Image instance

## Image:resizeImage(width, height)
Resizes the image to the specified width and height

### Parameters
* `width` `number` The new width of the image
* `height` `number` The new height of the image

### Returns
* `Image` `self` The Image instance

## Image:setBg(x, y, pattern)
Sets the background color at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `pattern` `string` The background color pattern

### Returns
* `Image` `self` The Image instance

## Image:setFg(x, y, pattern)
Sets the foreground color at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `pattern` `string` The foreground color pattern

### Returns
* `Image` `self` The Image instance

## Image:setMetadata()

## Image:setPixel(x, y, char, fg, bg)
Sets the pixel at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `char` `string` The character to set
* `fg` `string` The foreground color pattern
* `bg` `string` The background color pattern

### Returns
* `Image` `self` The Image instance

## Image:setText(x, y, text)
Sets the text at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `text` `string` The text to set

### Returns
* `Image` `self` The Image instance

## Image:updateFrame(frameIndex, frame)
Updates the specified frame with the provided data

### Parameters
* `frameIndex` `number` The index of the frame to update
* `frame` `table` The new frame data

### Returns
* `Image` `self` The Image instance



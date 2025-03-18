# Image : VisualElement
This is the Image element class which can be used to display bimg formatted images.
Bimg is a universal ComputerCraft image format.
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
|[Image:addFrame](#image-addframe)|Image|Adds a new frame to the image
|[Image:getBg](#image-getbg)|string|Gets the background color at the specified position
|[Image:getFg](#image-getfg)|string|Gets the foreground color at the specified position
|[Image:getFrame](#image-getframe)|table|Gets the specified frame
|[Image:getImageSize](#image-getimagesize)|number|Gets the size of the image
|[Image:getMetadata](#image-getmetadata)|table|Gets the metadata of the image
|[Image:getPixelData](#image-getpixeldata)|number?|Gets pixel information at position
|[Image:getText](#image-gettext)|string|Gets the text at the specified position
|[Image:nextFrame](#image-nextframe)|Image|Advances to the next frame in the animation
|[Image:resizeImage](#image-resizeimage)|Image|Resizes the image to the specified width and height
|[Image:setBg](#image-setbg)|Image|Sets the background color at the specified position
|[Image:setFg](#image-setfg)|Image|Sets the foreground color at the specified position
|[Image:setMetadata](#image-setmetadata)|Image|Sets the metadata of the image
|[Image:setPixel](#image-setpixel)|Image|Sets the pixel at the specified position
|[Image:setText](#image-settext)|Image|Sets the text at the specified position
|[Image:updateFrame](#image-updateframe)|Image|Updates the specified frame with the provided data


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|Image:init|Image|Initializes the Image instance
|Image:render|-|Renders the Image

## Image:addFrame()
Adds a new frame to the image

### Returns
* `Image` `self` The Image instance

## Image:getBg(x, y, length)
Gets the background color at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `length` `number` The length of the background color pattern to get

### Returns
* `string` `bg` The background color pattern

## Image:getFg(x, y, length)
Gets the foreground color at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `length` `number` The length of the foreground color pattern to get

### Returns
* `string` `fg` The foreground color pattern

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
Gets the metadata of the image

### Returns
* `table` `metadata` The metadata of the image

## Image:getPixelData(x, y)
Gets pixel information at position

### Parameters
* `x` `number` X position
* `y` `number` Y position

### Returns
* `number?` `fg` Foreground color
* `number?` `bg` Background color
* `string?` `char` Character at position

## Image:getText(x, y, length)
Gets the text at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `length` `number` The length of the text to get

### Returns
* `string` `text` The text at the specified position

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

## Image:setMetadata(key, value)
Sets the metadata of the image

### Parameters
* `key` `string` The key of the metadata to set
* `value` `string` The value of the metadata to set

### Returns
* `Image` `self` The Image instance

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



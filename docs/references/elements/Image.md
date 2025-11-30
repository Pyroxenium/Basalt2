# Image
_This is the Image element class which can be used to display bimg formatted images. Bimg is a universal ComputerCraft image format. See: [https://github.com/SkyTheCodeMaster/bimg](https://github.com/SkyTheCodeMaster/bimg)_

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|bimg|table|{}|The bimg image data|
|currentFrame|number|1|Current animation frame|
|autoResize|boolean|false|Whether to automatically resize the image when content exceeds bounds|
|offsetX|number|0|Horizontal offset for viewing larger images|
|offsetY|number|0|Vertical offset for viewing larger images|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Image:resizeImage](#image-resizeimage-width-height)|Image|Resizes the image to the specified width and height|
|[Image:getImageSize](#image-getimagesize)|number, number|Gets the size of the image|
|[Image:getPixelData](#image-getpixeldata-x-y)|fg, bg, char|Gets pixel information at position|
|[Image:setText](#image-settext-x-y-text)|Image|Sets the text at the specified position|
|[Image:getText](#image-gettext-x-y-length)|string|Gets the text at the specified position|
|[Image:setFg](#image-setfg-x-y-pattern)|Image|Sets the foreground color at the specified position|
|[Image:getFg](#image-getfg-x-y-length)|string|Gets the foreground color at the specified position|
|[Image:setBg](#image-setbg-x-y-pattern)|Image|Sets the background color at the specified position|
|[Image:getBg](#image-getbg-x-y-length)|string|Gets the background color at the specified position|
|[Image:setPixel](#image-setpixel-x-y-char-fg-bg)|Image|Sets the pixel at the specified position|
|[Image:applyPalette](#image-applypalette)|Image|Applies the palette defined in the image to the terminal|
|[Image:undoPalette](#image-undopalette)|Image|Restores the previous palette before applyPalette was called|
|[Image:nextFrame](#image-nextframe)|Image|Advances to the next frame in the animation|
|[Image:addFrame](#image-addframe)|Image|Adds a new frame to the image|
|[Image:updateFrame](#image-updateframe-frameindex-frame)|Image|Updates the specified frame with the provided data|
|[Image:getFrame](#image-getframe-frameindex)|table|Gets the specified frame|
|[Image:getMetadata](#image-getmetadata)|table|Gets the metadata of the image|
|[Image:setMetadata](#image-setmetadata-key-value)|Image|Sets the metadata of the image|

## Image:resizeImage(width, height)

Resizes the image to the specified width and height

### Parameters
* `width` `number` The new width of the image
* `height` `number` The new height of the image

### Returns
* `Image` `self` The Image instance

## Image:getImageSize()

Gets the size of the image

### Returns
* `number` `width` The width of the image
* `number` `height` The height of the image

## Image:getPixelData(x, y)

Gets pixel information at position

### Parameters
* `x` `number` X position
* `y` `number` Y position

### Returns
* `fg` `Foreground` color
* `bg` `Background` color
* `char` `Character` at position

## Image:setText(x, y, text)

Sets the text at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `text` `string` The text to set

### Returns
* `Image` `self` The Image instance

## Image:getText(x, y, length)

Gets the text at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `length` `number` The length of the text to get

### Returns
* `string` `text` The text at the specified position

## Image:setFg(x, y, pattern)

Sets the foreground color at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `pattern` `string` The foreground color pattern

### Returns
* `Image` `self` The Image instance

## Image:getFg(x, y, length)

Gets the foreground color at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `length` `number` The length of the foreground color pattern to get

### Returns
* `string` `fg` The foreground color pattern

## Image:setBg(x, y, pattern)

Sets the background color at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `pattern` `string` The background color pattern

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

## Image:applyPalette()

Applies the palette defined in the image to the terminal

### Returns
* `Image` `self` The Image instance

## Image:undoPalette()

Restores the previous palette before applyPalette was called

### Returns
* `Image` `self` The Image instance

## Image:nextFrame()

Advances to the next frame in the animation

### Returns
* `Image` `self` The Image instance

## Image:addFrame()

Adds a new frame to the image

### Returns
* `Image` `self` The Image instance

## Image:updateFrame(frameIndex, frame)

Updates the specified frame with the provided data

### Parameters
* `frameIndex` `number` The index of the frame to update
* `frame` `table` The new frame data

### Returns
* `Image` `self` The Image instance

## Image:getFrame(frameIndex)

Gets the specified frame

### Parameters
* `frameIndex` `number` The index of the frame to get

### Returns
* `table` `frame` The frame data

## Image:getMetadata()

Gets the metadata of the image

### Returns
* `table` `metadata` The metadata of the image

## Image:setMetadata(key, value)

Sets the metadata of the image

### Parameters
* `key` `string` The key of the metadata to set
* `value` `string` The value of the metadata to set

### Returns
* `Image` `self` The Image instance

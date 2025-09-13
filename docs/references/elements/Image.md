# Image
_This is the Image element class which can be used to display bimg formatted images.
Bimg is a universal ComputerCraft image format.
See: https://github.com/SkyTheCodeMaster/bimg_

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
|[Image.new](#image-new)|Image|Creates a new Image instance|
|[Image:Image](#image-image-props-basalt)|Image|Initializes the Image instance|
|[Image:Image](#image-image-width-height)|Image|Resizes the image to the specified width and height|
|[Image:Image](#image-image)|number, number|Gets the size of the image|
|[Image:Image](#image-image-x-y)|fg, bg, char|Gets pixel information at position|
|[Image:Image](#image-image-x-y-text)|Image|Sets the text at the specified position|
|[Image:Image](#image-image-x-y-length)|string|Gets the text at the specified position|
|[Image:Image](#image-image-x-y-pattern)|Image|Sets the foreground color at the specified position|
|[Image:Image](#image-image-x-y-length)|string|Gets the foreground color at the specified position|
|[Image:Image](#image-image-x-y-pattern)|Image|Sets the background color at the specified position|
|[Image:Image](#image-image-x-y-length)|string|Gets the background color at the specified position|
|[Image:Image](#image-image-x-y-char-fg-bg)|Image|Sets the pixel at the specified position|
|[Image:Image](#image-image)|Image|Advances to the next frame in the animation|
|[Image:Image](#image-image)|Image|Adds a new frame to the image|
|[Image:Image](#image-image-frameindex-frame)|Image|Updates the specified frame with the provided data|
|[Image:Image](#image-image-frameindex)|table|Gets the specified frame|
|[Image:Image](#image-image)|table|Gets the metadata of the image|
|[Image:Image](#image-image-key-value)|Image|Sets the metadata of the image|
|[Image:Image](#image-image)|-|Renders the Image|

## Image.new()

Creates a new Image instance

### Returns
* `Image` `self` The newly created Image instance

## Image:Image(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Image` `self` The initialized instance

## Image:Image(width, height)

Resizes the image to the specified width and height

### Parameters
* `width` `number` The new width of the image
* `height` `number` The new height of the image

### Returns
* `Image` `self` The Image instance

## Image:Image()

Gets the size of the image

### Returns
* `number` `width` The width of the image
* `number` `height` The height of the image

## Image:Image(x, y)

Gets pixel information at position

### Parameters
* `x` `number` X position
* `y` `number` Y position

### Returns
* `fg` `Foreground` color
* `bg` `Background` color
* `char` `Character` at position

## Image:Image(x, y, text)

Sets the text at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `text` `string` The text to set

### Returns
* `Image` `self` The Image instance

## Image:Image(x, y, length)

Gets the text at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `length` `number` The length of the text to get

### Returns
* `string` `text` The text at the specified position

## Image:Image(x, y, pattern)

Sets the foreground color at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `pattern` `string` The foreground color pattern

### Returns
* `Image` `self` The Image instance

## Image:Image(x, y, length)

Gets the foreground color at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `length` `number` The length of the foreground color pattern to get

### Returns
* `string` `fg` The foreground color pattern

## Image:Image(x, y, pattern)

Sets the background color at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `pattern` `string` The background color pattern

### Returns
* `Image` `self` The Image instance

## Image:Image(x, y, length)

Gets the background color at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `length` `number` The length of the background color pattern to get

### Returns
* `string` `bg` The background color pattern

## Image:Image(x, y, char, fg, bg)

Sets the pixel at the specified position

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `char` `string` The character to set
* `fg` `string` The foreground color pattern
* `bg` `string` The background color pattern

### Returns
* `Image` `self` The Image instance

## Image:Image()

Advances to the next frame in the animation

### Returns
* `Image` `self` The Image instance

## Image:Image()

Adds a new frame to the image

### Returns
* `Image` `self` The Image instance

## Image:Image(frameIndex, frame)

Updates the specified frame with the provided data

### Parameters
* `frameIndex` `number` The index of the frame to update
* `frame` `table` The new frame data

### Returns
* `Image` `self` The Image instance

## Image:Image(frameIndex)

Gets the specified frame

### Parameters
* `frameIndex` `number` The index of the frame to get

### Returns
* `table` `frame` The frame data

## Image:Image()

Gets the metadata of the image

### Returns
* `table` `metadata` The metadata of the image

## Image:Image(key, value)

Sets the metadata of the image

### Parameters
* `key` `string` The key of the metadata to set
* `value` `string` The value of the metadata to set

### Returns
* `Image` `self` The Image instance

## Image:Image()
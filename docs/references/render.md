# Render

## Fields

|Field|Type|Description|
|---|---|---|
|terminal|`table`|The terminal object to render to|
|width|`number`|The width of the render|
|height|`number`|The height of the render|
|buffer|`table`|The buffer to render|
|xCursor|`number`|The x position of the cursor|
|yCursor|`number`|The y position of the cursor|
|blink|`boolean`|Whether the cursor should blink|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Render.new](#Render.new)|Render|
|[Render:addDirtyRect](#Render:addDirtyRect)|s|
|[Render:bg](#Render:bg)|s|
|[Render:blit](#Render:blit)|s|
|[Render:clear](#Render:clear)|s|
|[Render:clearArea](#Render:clearArea)|-|
|[Render:fg](#Render:fg)|s|
|[Render:getSize](#Render:getSize)|s|
|[Render:mergeRects](#Render:mergeRects)|s|
|[Render:multiBlit](#Render:multiBlit)|s|
|[Render:rectOverlaps](#Render:rectOverlaps)|s|
|[Render:render](#Render:render)|s|
|[Render:setCursor](#Render:setCursor)|-|
|[Render:text](#Render:text)|s|
|[Render:textBg](#Render:textBg)|s|
|[Render:textFg](#Render:textFg)|-|

## Render.new(terminal)
Creates a new Render object

### Parameters
* `terminal` `table` The terminal object to render to

### Returns
* `nil` `nil` nil

## Render:addDirtyRect(x, y, width, height)
Adds a dirty rectangle to the buffer

### Parameters
* `x` `number` The x position of the rectangle
* `y` `number` The y position of the rectangle
* `width` `number` The width of the rectangle
* `height` `number` The height of the rectangle

### Returns
* `nil` `nil` nil

## Render:bg(x, y, bg)
Blits a background color to the screen

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `bg` `string` The background color to blit

### Returns
* `nil` `nil` nil

## Render:blit(x, y, text, fg, bg)
Blits text to the screen

### Parameters
* `x` `number` The x position to blit to
* `y` `number` The y position to blit to
* `text` `string` The text to blit
* `fg` `string` The foreground color of the text
* `bg` `string` The background color of the text

### Returns
* `nil` `nil` nil

## Render:clear(bg)
Clears the screen

### Parameters
* `bg` `colors` The background color to clear the screen with

### Returns
* `nil` `nil` nil

## Render:clearArea(x, y, width, height, bg)
Clears an area of the screen

### Parameters
* `x` `number` The x position of the area
* `y` `number` The y position of the area
* `width` `number` The width of the area
* `height` `number` The height of the area
* `bg` `colors` The background color to clear the area with

## Render:fg(x, y, fg)
Blits a foreground color to the screen

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `fg` `string` The foreground color to blit

### Returns
* `nil` `nil` nil

## Render:getSize()
Gets the size of the render

### Returns
* `s` `number,` number

## Render:mergeRects(target, source)
Merges two rectangles

### Parameters
* `target` `table` The target rectangle
* `source` `table` The source rectangle

### Returns
* `nil` `nil` nil

## Render:multiBlit(x, y, width, height, text, fg, bg)
Blits text to the screen with multiple lines

### Parameters
* `x` `number` The x position to blit to
* `y` `number` The y position to blit to
* `width` `number` The width of the text
* `height` `number` The height of the text
* `text` `string` The text to blit
* `fg` `colors` The foreground color of the text
* `bg` `colors` The background color of the text

### Returns
* `nil` `nil` nil

## Render:rectOverlaps(r1, r2)
Checks if two rectangles overlap

### Parameters
* `r1` `table` The first rectangle
* `r2` `table` The second rectangle

### Returns
* `nil` `nil` nil

## Render:render()
Renders the buffer to the screen

### Returns
* `nil` `nil` nil

## Render:setCursor(x, y, blink)
Sets the cursor position

### Parameters
* `x` `number` The x position of the cursor
* `y` `number` The y position of the cursor
* `blink` `boolean` Whether the cursor should blink

## Render:text(x, y, text)
Blits text to the screen

### Parameters
* `x` `number` The x position to blit to
* `y` `number` The y position to blit to
* `text` `string` The text to blit

### Returns
* `nil` `nil` nil

## Render:textBg(x, y, text, bg)
Blits text to the screen with a background color

### Parameters
* `x` `number` The x position to blit to
* `y` `number` The y position to blit to
* `text` `string` The text to blit
* `bg` `colors` The background color of the text

### Returns
* `nil` `nil` nil

## Render:textFg(x, y, text, fg)
Blits text to the screen with a foreground color

### Parameters
* `x` `number` The x position to blit to
* `y` `number` The y position to blit to
* `text` `string` The text to blit
* `fg` `colors` The foreground color of the text


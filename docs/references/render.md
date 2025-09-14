# Render
_This is the render module for Basalt. It tries to mimic the functionality of the `term` API. but with additional _
_functionality. It also has a buffer system to reduce the number of calls_

## Functions

|Method|Returns|Description|
|---|---|---|
|[Render.new](#render-new-terminal)|Render|Creates a new Render object|
|[Render:addDirtyRect](#render-adddirtyrect-x-y-width-height)|Render|Adds a dirty rectangle to the buffer|
|[Render:blit](#render-blit-x-y-text-fg-bg)|Render|Blits text to the screen|
|[Render:multiBlit](#render-multiblit-x-y-width-height-text-fg-bg)|Render|Blits text to the screen with multiple lines|
|[Render:textFg](#render-textfg-x-y-text-fg)|Render|Blits text to the screen with a foreground color|
|[Render:textBg](#render-textbg-x-y-text-bg)|Render|Blits text to the screen with a background color|
|[Render:text](#render-text-x-y-text)|Render|Renders the text to the screen|
|[Render:fg](#render-fg-x-y-fg)|Render|Blits a foreground color to the screen|
|[Render:bg](#render-bg-x-y-bg)|Render|Blits a background color to the screen|
|[Render:text](#render-text-x-y-text)|Render|Blits text to the screen|
|[Render:fg](#render-fg-x-y-fg)|Render|Blits a foreground color to the screen|
|[Render:bg](#render-bg-x-y-bg)|Render|Blits a background color to the screen|
|[Render:clear](#render-clear-bg)|Render|Clears the screen|
|[Render:render](#render-render)|Render|Renders the buffer to the screen|
|[Render:rectOverlaps](#render-rectoverlaps-r1-r2)|boolean|Checks if two rectangles overlap|
|[Render:mergeRects](#render-mergerects-target-source)|Render|Merges two rectangles|
|[Render:setCursor](#render-setcursor-x-y-blink)|Render|Sets the cursor position|
|[Render:clearArea](#render-cleararea-x-y-width-height-bg)|Render|Clears an area of the screen|
|[Render:getSize](#render-getsize)|number|Gets the size of the render|
|[Render:setSize](#render-setsize-width-height)|Render|Sets the size of the render|

## Render.new(terminal)

Creates a new Render object

### Parameters
* `terminal` `table` The terminal object to render to

### Returns
* `Render`

## Render:addDirtyRect(x, y, width, height)

Adds a dirty rectangle to the buffer

### Parameters
* `x` `number` The x position of the rectangle
* `y` `number` The y position of the rectangle
* `width` `number` The width of the rectangle
* `height` `number` The height of the rectangle

### Returns
* `Render`

## Render:blit(x, y, text, fg, bg)

Blits text to the screen

### Parameters
* `x` `number` The x position to blit to
* `y` `number` The y position to blit to
* `text` `string` The text to blit
* `fg` `string` The foreground color of the text
* `bg` `string` The background color of the text

### Returns
* `Render`

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
* `Render`

## Render:textFg(x, y, text, fg)

Blits text to the screen with a foreground color

### Parameters
* `x` `number` The x position to blit to
* `y` `number` The y position to blit to
* `text` `string` The text to blit
* `fg` `colors` The foreground color of the text

### Returns
* `Render`

## Render:textBg(x, y, text, bg)

Blits text to the screen with a background color

### Parameters
* `x` `number` The x position to blit to
* `y` `number` The y position to blit to
* `text` `string` The text to blit
* `bg` `colors` The background color of the text

### Returns
* `Render`

## Render:text(x, y, text)

Renders the text to the screen

### Parameters
* `x` `number` The x position to blit to
* `y` `number` The y position to blit to
* `text` `string` The text to blit

### Returns
* `Render`

## Render:fg(x, y, fg)

Blits a foreground color to the screen

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `fg` `string` The foreground color to blit

### Returns
* `Render`

## Render:bg(x, y, bg)

Blits a background color to the screen

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `bg` `string` The background color to blit

### Returns
* `Render`

## Render:text(x, y, text)

Blits text to the screen

### Parameters
* `x` `number` The x position to blit to
* `y` `number` The y position to blit to
* `text` `string` The text to blit

### Returns
* `Render`

## Render:fg(x, y, fg)

Blits a foreground color to the screen

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `fg` `string` The foreground color to blit

### Returns
* `Render`

## Render:bg(x, y, bg)

Blits a background color to the screen

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `bg` `string` The background color to blit

### Returns
* `Render`

## Render:clear(bg)

Clears the screen

### Parameters
* `bg` `colors` The background color to clear the screen with

### Returns
* `Render`

## Render:render()

Renders the buffer to the screen

### Returns
* `Render`

## Render:rectOverlaps(r1, r2)

Checks if two rectangles overlap

### Parameters
* `r1` `table` The first rectangle
* `r2` `table` The second rectangle

### Returns
* `boolean`

## Render:mergeRects(target, source)

Merges two rectangles

### Parameters
* `target` `table` The target rectangle
* `source` `table` The source rectangle

### Returns
* `Render`

## Render:setCursor(x, y, blink)

Sets the cursor position

### Parameters
* `x` `number` The x position of the cursor
* `y` `number` The y position of the cursor
* `blink` `boolean` Whether the cursor should blink

### Returns
* `Render`

## Render:clearArea(x, y, width, height, bg)

Clears an area of the screen

### Parameters
* `x` `number` The x position of the area
* `y` `number` The y position of the area
* `width` `number` The width of the area
* `height` `number` The height of the area
* `bg` `colors` The background color to clear the area with

### Returns
* `Render`

## Render:getSize()

Gets the size of the render

### Returns
* `number`

## Render:setSize(width, height)

Sets the size of the render

### Parameters
* `width` `number` The width of the render
* `height` `number` The height of the render

### Returns
* `Render`

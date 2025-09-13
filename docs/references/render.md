# Render
This is the render module for Basalt. It tries to mimic the functionality of the `term` API. but with additional 
functionality. It also has a buffer system to reduce the number of calls

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
|[Render.new](#render-new)|Render|
|[Render:addDirtyRect](#render-adddirtyrect)|Render|
|[Render:bg](#render-bg)|Render|
|[Render:bg](#render-bg)|Render|
|[Render:blit](#render-blit)|Render|
|[Render:clear](#render-clear)|Render|
|[Render:clearArea](#render-cleararea)|Render|
|[Render:fg](#render-fg)|Render|
|[Render:fg](#render-fg)|Render|
|[Render:getSize](#render-getsize)|number,|
|[Render:mergeRects](#render-mergerects)|Render|
|[Render:multiBlit](#render-multiblit)|Render|
|[Render:rectOverlaps](#render-rectoverlaps)|boolean|
|[Render:render](#render-render)|Render|
|[Render:setCursor](#render-setcursor)|Render|
|[Render:setSize](#render-setsize)|Render|
|[Render:text](#render-text)|Render|
|[Render:text](#render-text)|Render|
|[Render:textBg](#render-textbg)|Render|
|[Render:textFg](#render-textfg)|Render|


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

### Returns
* `nil` `nil` nil

## Render:fg(x, y, fg)
Blits a foreground color to the screen

### Parameters
* `x` `number` The x position
* `y` `number` The y position
* `fg` `string` The foreground color to blit

### Returns
* `nil` `nil` nil

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
* `nil` `nil` nil

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

### Returns
* `nil` `nil` nil

## Render:setSize(width, height)
Sets the size of the render

### Parameters
* `width` `number` The width of the render
* `height` `number` The height of the render

### Returns
* `nil` `nil` nil

## Render:text(x, y, text)
Blits text to the screen

### Parameters
* `x` `number` The x position to blit to
* `y` `number` The y position to blit to
* `text` `string` The text to blit

### Returns
* `nil` `nil` nil

## Render:text(x, y, text)
Renders the text to the screen

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

### Returns
* `nil` `nil` nil



# Display
_The Display is a special element where you can use the window (term) API to draw on the display, useful when you need to use external APIs._

Extends: `VisualElement`

## Functions

|Method|Returns|Description|
|---|---|---|
|[Display:getWindow](#display-getwindow)|table|Returns the current window object|
|[Display:write](#display-write-x-y-text-fg-bg)|Display|Writes text to the display|

## Display:getWindow()

Returns the current window object

### Returns
* `table` `window` The current window object

## Display:write(x, y, text, fg?, bg?)

Writes text to the display at the given position with the given foreground and background colors

### Parameters
* `x` `number` The x position to write to
* `y` `number` The y position to write to
* `text` `string` The text to write
* `fg` *(optional)* `colors` The foreground color (optional)
* `bg` *(optional)* `colors` The background color (optional)

### Returns
* `Display` `self` The display instance

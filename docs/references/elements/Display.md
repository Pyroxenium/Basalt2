# Display
_A specialized element that provides direct access to ComputerCraft's Window API. _
_It acts as a canvas where you can use standard CC terminal operations, making it ideal for:_
_- Integration with existing CC programs and APIs_
_- Custom drawing operations_
_- Terminal emulation_
_- Complex text manipulation_
_The Display maintains its own terminal buffer and can be manipulated using familiar CC terminal methods._

Extends: `VisualElement`

## Functions

|Method|Returns|Description|
|---|---|---|
|[Display:getWindow](#display-getwindow)|table|Gets the CC window instance|
|[Display:write](#display-write-x-y-text-fg-bg)|Display|Writes colored text to the display|

## Display:getWindow()

Retrieves the underlying ComputerCraft window object

### Returns
* `table` `window` A CC window object with all standard terminal methods

## Display:write(x, y, text, fg?, bg?)

Writes text directly to the display with optional colors

### Parameters
* `x` `number` X position (1-based)
* `y` `number` Y position (1-based)
* `text` `string` Text to write
* `fg` *(optional)* `colors` Foreground color (optional)
* `bg` *(optional)* `colors` Background color (optional)

### Returns
* `Display` `self` For method chaining

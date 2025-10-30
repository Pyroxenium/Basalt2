# Display
_A specialized element that provides direct access to ComputerCraft's Window API. It acts as a canvas where you can use standard CC terminal operations._

Extends: `VisualElement`

## Usage
```lua
-- Create a display for a custom terminal
local display = main:addDisplay()
:setSize(30, 10)
:setPosition(2, 2)

-- Get the window object for CC API operations
local win = display:getWindow()

-- Use standard CC terminal operations
win.setTextColor(colors.yellow)
win.setBackgroundColor(colors.blue)
win.clear()
win.setCursorPos(1, 1)
win.write("Hello World!")

-- Or use the helper method
display:write(1, 2, "Direct write", colors.red, colors.black)

-- Useful for external APIs
local paintutils = require("paintutils")
paintutils.drawLine(1, 1, 10, 1, colors.red, win)
```

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

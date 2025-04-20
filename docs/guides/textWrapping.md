# Text Wrapping

Labels in Basalt provide automatic text wrapping functionality. By default, a label adjusts its width to fit the text content. However, you can control this behavior to make the text wrap instead.

## Basic Usage
```lua
local main = basalt.createFrame()
local label = main:addLabel()
    :setSize(20, 5)     -- Set fixed width
    :setAutoSize(false) -- Disable auto-sizing
    :setText("This is a long text that will automatically wrap to fit the label's width")
```

## Understanding Auto-Size
- Default behavior: Label width grows to fit text
- With `:setAutoSize(false)`: Text wraps to fit label width
- Text wrapping only works when auto-size is disabled

## Examples
```lua
-- Default: Label grows with text
label:setText("Long text...")  -- Width adjusts automatically

-- Fixed width with wrapping
label:setSize(15, 5)
    :setAutoSize(false)       -- Enable text wrapping
    :setText("Text wraps to fit 15 characters width")
```

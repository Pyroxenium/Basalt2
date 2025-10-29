# BigFont
_A specialized text element that renders characters in larger sizes using Wojbie's BigFont API. Supports multiple font sizes and custom colors while maintaining the pixel-art style of ComputerCraft. Ideal for headers, titles, and emphasis text._

Extends: `VisualElement`

## Usage
```lua
-- Create a large welcome message
local main = basalt.getMainFrame()
local title = main:addBigFont()
:setPosition(3, 3)
:setFontSize(2)  -- Makes text twice as large
:setText("Welcome!")
:setForeground(colors.yellow)  -- Make text yellow

-- For animated text
basalt.schedule(function()
while true do
title:setForeground(colors.yellow)
sleep(0.5)
title:setForeground(colors.orange)
sleep(0.5)
end
end)
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|BigFont|The text string to display in enlarged format|
|fontSize|number|1|Scale factor for text size (1-3, where 1 is 3x3 pixels per character)|

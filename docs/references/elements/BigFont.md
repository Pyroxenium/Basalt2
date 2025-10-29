# BigFont
_A specialized text element that renders characters in larger sizes using Wojbie's BigFont API. Supports multiple font sizes and custom colors while maintaining the pixel-art style of ComputerCraft. Ideal for headers, titles, and emphasis text._

Extends: `VisualElement`

## Usage
```lua
-- Create a large welcome message
```

```lua
local main = basalt.getMainFrame()
```

```lua
local title = main:addBigFont()
```

```lua
:setPosition(3, 3)
```

```lua
:setFontSize(2)  -- Makes text twice as large
```

```lua
:setText("Welcome!")
```

```lua
:setForeground(colors.yellow)  -- Make text yellow
```

```lua

```

```lua
-- For animated text
```

```lua
basalt.schedule(function()
```

```lua
while true do
```

```lua
title:setForeground(colors.yellow)
```

```lua
sleep(0.5)
```

```lua
title:setForeground(colors.orange)
```

```lua
sleep(0.5)
```

```lua
end
```

```lua
end)
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|BigFont|The text string to display in enlarged format|
|fontSize|number|1|Scale factor for text size (1-3, where 1 is 3x3 pixels per character)|

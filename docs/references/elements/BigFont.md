# BigFont
_A specialized text element that renders characters in larger sizes using Wojbie's BigFont API. Supports multiple font sizes and custom colors while maintaining the pixel-art style of ComputerCraft. Ideal for headers, titles, and emphasis text._

Extends: `VisualElement`

## Usage
```lua run
-- Create a large welcome message
```

```lua run
local main = basalt.getMainFrame()
```

```lua run
local title = main:addBigFont()
```

```lua run
:setPosition(3, 3)
```

```lua run
:setFontSize(2)  -- Makes text twice as large
```

```lua run
:setText("Welcome!")
```

```lua run
:setForeground(colors.yellow)  -- Make text yellow
```

```lua run

```

```lua run
-- For animated text
```

```lua run
basalt.schedule(function()
```

```lua run
while true do
```

```lua run
title:setForeground(colors.yellow)
```

```lua run
sleep(0.5)
```

```lua run
title:setForeground(colors.orange)
```

```lua run
sleep(0.5)
```

```lua run
end
```

```lua run
end)
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|text|string|BigFont|The text string to display in enlarged format|
|fontSize|number|1|Scale factor for text size (1-3, where 1 is 3x3 pixels per character)|

# ScrollFrame
_A container that provides automatic scrolling capabilities with visual scrollbars. Displays vertical and/or horizontal scrollbars when child content exceeds the container's dimensions._

Extends: `Container`

## Examples (Executable)
```lua run
local basalt = require("basalt")

local main = basalt.getMainFrame()

-- Create a ScrollFrame with content larger than the frame
local scrollFrame = main:addScrollFrame({
x = 2,
y = 2,
width = 30,
height = 12,
background = colors.lightGray
})

-- Add a title
scrollFrame:addLabel({
x = 2,
y = 1,
text = "ScrollFrame Example",
foreground = colors.yellow
})

-- Add multiple labels that exceed the frame height
for i = 1, 20 do
scrollFrame:addLabel({
x = 2,
y = i + 2,
text = "Line " .. i .. " - Scroll to see more",
foreground = i % 2 == 0 and colors.white or colors.lightGray
})
end

-- Add some interactive buttons at different positions
scrollFrame:addButton({
x = 2,
y = 24,
width = 15,
height = 3,
text = "Button 1",
background = colors.blue
})
:onClick(function()
scrollFrame:addLabel({
x = 18,
y = 24,
text = "Clicked!",
foreground = colors.lime
})
end)

scrollFrame:addButton({
x = 2,
y = 28,
width = 15,
height = 3,
text = "Button 2",
background = colors.green
})
:onClick(function()
scrollFrame:addLabel({
x = 18,
y = 28,
text = "Nice!",
foreground = colors.orange
})
end)

-- Info label outside the scroll frame
main:addLabel({
x = 2,
y = 15,
text = "Use mouse wheel to scroll!",
foreground = colors.gray
})

basalt.run()
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|showScrollBar|boolean|true|Whether to show scrollbars|
|scrollBarSymbol|string|"_"|The symbol used for the scrollbar handle|
|scrollBarBackground|string|"\127"|The symbol used for the scrollbar background|
|scrollBarColor|color|lightGray|Color of the scrollbar handle|
|scrollBarBackgroundColor|color|gray|Background color of the scrollbar|
|contentWidth|number|0|The total width of the content (calculated from children)|
|contentHeight|number|0|The total height of the content (calculated from children)|

# Canvas Plugin Guide

The Canvas plugin allows you to draw various shapes and text on your elements. It provides a simple yet powerful way to create custom graphics.

## Basic Usage

First, you need to get the canvas object:

```lua
local main = basalt.createFrame()
local canvas = main:getCanvas()
```

## Drawing Functions

### Lines
Draw a line from point (x1,y1) to (x2,y2):
```lua
canvas:line(1, 1, 10, 10, "*", colors.red, colors.black) -- Draws a red line
```

### Rectangles
Create rectangles with specified dimensions:
```lua
canvas:rect(5, 5, 10, 5, "#", colors.blue, colors.white) -- Creates a blue rectangle
```

### Ellipses
Draw ellipses/circles:
```lua
canvas:ellipse(10, 10, 5, 3, "@", colors.green, colors.black) -- Creates an ellipse
```

### Text
Write text at specific coordinates:
```lua
canvas:text(1, 1, "Hello World!", colors.yellow, colors.black)
```

## Color Management

### Background Colors
Set background color at specific coordinates:
```lua
canvas:bg(1, 1, colors.blue)
```

### Foreground Colors
Set foreground color at specific coordinates:
```lua
canvas:fg(1, 1, colors.white)
```

## Render Types

The canvas plugin supports two different render types that control when the canvas commands are executed:

### Setting the Render Type
```lua
canvas:setType(type)
```

Parameters:
- `type`: String, either "pre" or "post"
  - `"pre"`: Commands are executed before the main object rendering (default)
  - `"post"`: Commands are executed after the main object rendering

Example:
```lua
-- Create a canvas that renders after the main object
local canvas = main:addCanvas()
canvas:setType("post")

-- Add commands that will now execute after main rendering
canvas:addCommand(function()
    canvas:drawText(1, 1, "Overlay Text")
end)

-- or
canvas:line(1, 1, 10, 10, " ", colors.red, colors.green)
```

Note: Changing the render type affects all subsequent commands added to the canvas. You can have multiple canvas objects with different render types on the same base object.

## Canvas Commands

Canvas commands allow you to create custom drawing operations using low-level drawing functions. Available commands are:
- `textFg` - Set text foreground color
- `textBg` - Set text background color
- `drawText` - Draw text
- `drawFg` - Draw foreground colors
- `drawBg` - Draw background colors
- `blit` - Draw text with foreground and background colors
- `multiBlit` - Draw multiple blit operations

### Adding Commands

```lua
-- Example of proper command usage
canvas:addCommand(function()
    -- Draw red text on black background
    canvas:drawText(1, 1, "Hello")
    canvas:drawFg(1, 1, colors.red)
    canvas:drawBg(1, 1, colors.black)
    
    -- Or use blit for more efficient drawing
    canvas:blit(1, 2, "Hello", "fffff", "00000") -- white on black
end)
```

### Advanced Blit Example

The multiBlit function allows you to render text efficiently in a rectangular area:

```lua
canvas:addCommand(function()
    -- Parameters: x, y, width, height, text, fg, bg
    canvas:multiBlit(1, 1, 5, 3, 
        "HelloWorld!Hello", -- text (width * height characters)
        "ffffffffff", -- fg colors (width * height characters)
        "0000000000"  -- bg colors (width * height characters)
    )
end)
```

Note: Do not use drawing functions like `line`, `rect`, or `ellipse` inside commands as this will cause render queue issues. Use the low-level drawing functions instead.
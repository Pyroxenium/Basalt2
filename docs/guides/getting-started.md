# Getting Started with Basalt

## Installation

Check out the [download guide](download) to learn how to get Basalt on your CC:Tweaked computer.

## Creating Your First UI

Here's a simple example that creates a window with a button:

```lua
local basalt = require("basalt")

-- Get the main frame (your window)
local main = basalt.getMainFrame()

-- Add a button
main:addButton()
    :setText("Click me!")
    :setPosition(4, 4)
    :onClick(function(self)
        self:setText("Clicked!")
    end)

-- Start Basalt (starts the event loop)
basalt.run()
```

## Adding More Elements

You can add various UI elements to your frame:

```lua
-- Add a label (text)
main:addLabel()
    :setText("Hello World")
    :setPosition(4, 2)

-- Add an input field
main:addInput()
    :setPosition(4, 6)
    :setSize(20, 1)

-- Add a list
main:addList()
    :setPosition(4, 8)
    :setSize(20, 6)
    :addItem("Item 1")
    :addItem("Item 2")
```

## Basic Properties

Most elements support these common properties:
```lua
element:setPosition(x, y)        -- Set position
element:setSize(width, height)   -- Set size
element:setBackground(color)     -- Set background color
element:setForeground(color)     -- Set text color
```

## Basic Events

Elements can respond to user interaction:
```lua
element:onClick(function(self)
    -- Called when clicked
    -- 'self' refers to the element that was clicked
end)

element:onEnter(function(self)
    -- Called when mouse enters (CraftOS-PC only)
end)

element:onChange("text", function(self, value)
    -- Called when the "text" property changes
    -- 'value' contains the new value
end)
```

## Using monitors instead

Basalt can also render to monitors. Here's how:

```lua
local basalt = require("basalt")

local main = basalt.getMainFrame()

-- Get a reference to the monitor
local monitor = peripheral.find("monitor") 
-- Or use a specific side: peripheral.wrap("right")

-- Create a frame for the monitor
local monitorFrame = basalt.createFrame()
    :setTerm(monitor)

-- Add elements like normal
monitorFrame:addButton()
    :setText("Monitor Button")
    :setSize(24, 3)
    :setPosition(2, 2)

-- Start Basalt (handles all frames automatically)
basalt.run()
```

You can have multiple frames on different screens - just call `basalt.run()` once at the end!

## Next Steps

- Check out the [Examples](https://github.com/Pyroxenium/Basalt2/tree/main/examples) for more complex UIs
- Learn about [Animations](animations) for smooth transitions
- Explore [States](states) for state management
- Read the [API Reference](/references/main) for detailed documentation
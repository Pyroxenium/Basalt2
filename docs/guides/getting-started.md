# Getting Started with Basalt

## Installation

Checkout [download](download) to learn how to get basalt on your CC:Tweaked computer.

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
    :onClick(function()
        -- Do something when clicked
    end)

-- Start Basalt
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
element:onClick(function()
    -- Called when clicked
end)

element:onEnter(function()
    -- Called when mouse enters the element (only available on CraftOS-PC)
end)

element:onChange(function(self, value)
    -- Called when value changes (inputs, lists, etc)
end)
```

## Next Steps

- Check out the [Examples](https://github.com/Pyroxenium/Basalt2/tree/main/examples) for more complex UIs
- Learn about [Animations](animations) for smooth transitions
- Explore [States](states) for data management
- Read the [API Reference](/references/main) for detailed documentation
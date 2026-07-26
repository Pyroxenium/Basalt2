# Getting Started

This guide walks through installing Basalt and creating a small
interactive UI.

## Requirements

- A CC:Tweaked computer running a current CraftOS version
- HTTP access enabled when downloading Basalt with `wget`

## Installation

Download the Basalt single-file bundle and save it as `basalt.lua`:

```shell
wget https://raw.githubusercontent.com/Pyroxenium/Basalt2/basalt2.5/bundle/basalt.lua basalt.lua
```

You can then load it from a program in the same directory:

```lua
local basalt = require("basalt")
```

## Creating Your First UI

Create a root frame, add a label and button, and finally start the event
loop:

```lua
local basalt = require("basalt")

local frame = basalt.createFrame()
frame.background = basalt.rgb("#1e1e2e")

local label = frame:addLabel({
    x = 2,
    y = 2,
    text = "Hello Basalt!",
})

frame:addButton({
    x = 2,
    y = 4,
    width = 14,
    text = "Click me",
})
    :onClick(function(self)
        self.text = "Clicked!"
        label.text = "It works!"
    end)

basalt.run()
```

`basalt.run()` starts the blocking event loop and updates every frame until
the program is terminated or calls `basalt.stop()`.

## Properties and Method Chaining

Properties can be assigned directly:

```lua
label.text = "Updated text"
label.x = 4
label.foreground = colors.yellow
```

The generated setters remain available when method chaining is more
convenient:

```lua
label
    :setText("Updated text")
    :setPosition(4, 2)
    :setForeground(colors.yellow)
```

Elements also accept their initial properties as a table when they are
created:

```lua
local input = frame:addInput({
    x = 2,
    y = 7,
    width = 20,
    placeholder = "Enter your name",
})
```

## Reactive State

A signal can be assigned directly to an element property. Updating the
signal marks dependent UI elements for rendering automatically:

```lua
local count = basalt.state(0)

local counter = frame:addLabel({
    x = 2,
    y = 10,
    text = count:map(function(value)
        return "Count: " .. value
    end),
})

frame:addButton({
    x = 2,
    y = 12,
    text = "Increment",
})
    :onClick(function()
        count:update(function(value)
            return value + 1
        end)
    end)
```

## Rendering to a Monitor

Pass a wrapped monitor to `basalt.createFrame`. Basalt detects its peripheral
name when possible and routes monitor touch events to the frame:

```lua
local basalt = require("Basalt")
local monitor = peripheral.find("monitor")

if not monitor then
    error("No monitor connected")
end

monitor.setTextScale(0.5)

local frame = basalt.createFrame(monitor)
frame:addButton({
    x = 2,
    y = 2,
    width = 18,
    text = "Monitor Button",
})

basalt.run()
```

Multiple frames can share the same event loop. Create each frame before
calling `basalt.run()` once at the end.

## Next Steps

- Browse the [API Reference](/api/) for all core APIs, elements, and modules.
- Read the [Basalt documentation](https://basalt.madefor.cc/2.0/) when
  maintaining an application built against the frozen Basalt 2 release.
- Explore the [Basalt 2.5 source code](https://github.com/Pyroxenium/Basalt2/tree/basalt2.5).

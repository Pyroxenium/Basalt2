# How Basalt Works

Basalt is a retained user-interface framework: you create a tree of elements,
change their properties, and let Basalt render and update the terminal.

## The Four Main Pieces

Every Basalt application has four important parts:

1. the Basalt library;
2. one or more root frames;
3. a tree of child elements;
4. an event loop.

```text
Basalt runtime
└── root frame
    ├── label
    ├── input
    └── frame
        ├── button
        └── progress bar
```

The parent controls where its children are rendered. Mouse coordinates are
translated as events travel down the tree. Keyboard events are sent to the
currently focused element.

## Root Frames

The simplest application uses the main frame:

```lua
local frame = basalt.getMainFrame()
```

The first call creates a root frame for the current terminal. Later calls
return the same frame.

Use `basalt.createFrame()` when you need an explicit root or another output
device:

```lua
local terminalFrame = basalt.createFrame(term.current())

local monitor = peripheral.find("monitor")
local monitorFrame = basalt.createFrame(monitor)
```

Create every root frame before calling `basalt.run()`. A single event loop
updates all of them.

## Element Trees

Containers own children. Calling an `add...` method creates an element and
attaches it to that container:

```lua
local panel = frame:addFrame({
    x = 2,
    y = 2,
    width = 24,
    height = 8,
})

local title = panel:addLabel({
    x = 2,
    y = 2,
    text = "Settings",
})
```

The title's coordinates are relative to `panel`, not to the terminal.
Moving the panel therefore moves the complete subtree.

Containers can find named descendants:

```lua
local title = panel:addLabel({
    name = "title",
    text = "Settings",
})

local sameTitle = frame:find("title")
```

Names are especially useful in larger trees and reactive expressions.

## Rendering

Changing a visual property marks the relevant UI tree as dirty:

```lua
title.text = "Updated settings"
title.foreground = colors.orange
```

Basalt lays out and redraws the tree during the next event-loop pass. Its
render buffer only writes changed terminal lines, so application code does
not need to call a redraw function after ordinary property changes.

Visibility and stacking are also properties:

```lua
panel.visible = false
panel.z = 10
```

Hidden elements are neither drawn nor given input. Among overlapping
siblings, a higher `z` value is drawn and hit-tested above a lower one.

## The Event Loop

Start the blocking event loop after building the interface:

```lua
basalt.run()
```

The loop:

1. draws dirty frames;
2. waits for the next CC:Tweaked event;
3. routes mouse, keyboard, monitor, and other events;
4. resumes scheduled tasks;
5. draws any resulting changes.

Stop it cleanly with:

```lua
basalt.stop()
```

## Complete Lifecycle Example

```lua run title="Basalt lifecycle"
local basalt = require("basalt")

-- 1. Obtain a root.
local frame = basalt.getMainFrame()

-- 2. Build the element tree.
local status = frame:addLabel({
    x = 2,
    y = 2,
    text = "Running",
})

frame:addButton({
    x = 2,
    y = 4,
    text = "Stop",
}):onClick(function()
    status.text = "Stopping..."
    basalt.stop()
end)

-- 3. Start event processing after the UI is complete.
basalt.run()

-- 4. Execution continues here after the loop stops.
print("Application closed")
```

When the loop ends, Basalt cleans up its root frames and restores terminal
state.

## Manual Integration

Applications that already own an event loop can feed events to Basalt with
`basalt.update(event, ...)` instead of calling `basalt.run()`. Treat this as
an advanced integration: the application becomes responsible for collecting
and forwarding every relevant event.

## Common Mistakes

### Calling `basalt.run()` too early

The call blocks. Build the initial interface and register handlers before
starting the loop.

### Creating a separate loop for every frame

All frames share the same Basalt runtime. Call `basalt.run()` once.

### Using terminal coordinates for nested elements

Child positions are relative to their direct parent.

### Redrawing manually after every change

Ordinary property changes invalidate the UI automatically.

## Related API

- [`basalt.getMainFrame()` and runtime functions](/api/basalt)
- [`BaseFrame`](/api/elements/BaseFrame)
- [`Container`](/api/elements/Container)
- [`Element`](/api/elements/Element)

## Next Steps

Continue with [Elements and Properties](./elements-and-properties), followed
by [Events and Focus](./events-and-focus).

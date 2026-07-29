# Multiple Roots and Monitors

Each Basalt root is an independent UI tree bound to one terminal-like target.
All roots share one event loop and may react to the same application state.

## Root Versus Child Frame

```lua
local root = basalt.createFrame(terminal)
local panel = root:addFrame({ x = 2, y = 2, width = 20, height = 8 })
```

`createFrame()` creates a separate root with its own render buffer, palette,
focus, hover, and mouse capture. `addFrame()` creates a panel inside an
existing root.

Create the computer terminal first because the first root becomes the main
Frame and receives ordinary keyboard and mouse events:

```lua
local terminalRoot = basalt.getMainFrame()
```

## Add a Physical Monitor

```lua
local monitorName = "monitor_0"
local monitor = assert(peripheral.wrap(monitorName), "monitor missing")

monitor.setTextScale(0.5)

local monitorRoot = basalt.createFrame(monitor, monitorName)
monitorRoot.background = colors.black
```

Basalt normally discovers a wrapped monitor's name. Passing it explicitly is
safer for proxies and test terminals.

Create every stable root during startup and call `basalt.run()` once.

## Event Routing

- Keyboard and ordinary mouse events go to the main root.
- `monitor_touch` goes to the root with the matching monitor name.
- `monitor_resize` updates only that named root.
- Timers and other non-pointer events are offered to every root.

Monitor hardware emits touches, not keyboard input. Keep text entry on the
computer or implement an explicit on-screen keyboard.

## Share State, Not Elements

One element belongs to one parent and one root. Build a separate view per
display and share Signals or model tables:

```lua
local level = basalt.state(0)

terminalRoot:addLabel({
    text = level:map(function(value)
        return "Level: " .. value
    end),
})

monitorRoot:addProgressBar({
    width = 20,
    progress = level,
})
```

Updating the Signal invalidates every dependent root. Split high-frequency
state when only one display needs every sample.

## Several Monitors

```lua
for _, name in ipairs(peripheral.getNames()) do
    if peripheral.getType(name) == "monitor" then
        local monitor = peripheral.wrap(name)
        local root = basalt.createFrame(monitor, name)
        root:addLabel({ x = 2, y = 2, text = name })
    end
end
```

The current root registry has no removal API. Do not create replacement roots
repeatedly when peripherals reconnect; keep root creation stable.

## Test Monitor Routing

```lua
basalt.update("monitor_touch", "monitor_0", 3, 5)
basalt.update("monitor_resize", "monitor_0")
```

This drives the same routing path as real monitor events without entering the
blocking loop.

## Runnable Two-Root Example

The browser has no physical monitor, so two CC windows act as independent
roots. The left Button queues a real `monitor_touch` event for the right root.

```lua run title="Two roots with a virtual monitor"
local basalt = require("basalt")

local native = term.current()
native.setBackgroundColor(colors.black)
native.clear()

local terminalWindow = window.create(native, 1, 1, 25, 19, true)
local monitorWindow = window.create(native, 27, 1, 25, 19, true)

local terminalRoot = basalt.createFrame(terminalWindow)
local monitorName = "virtual_right"
local monitorRoot = basalt.createFrame(monitorWindow, monitorName)

terminalRoot.background = colors.black
monitorRoot.background = colors.gray

local count = basalt.state(0)
local touches = basalt.state(0)

terminalRoot:addLabel({
    x = 2,
    y = 2,
    text = "MAIN TERMINAL",
    foreground = colors.orange,
})

terminalRoot:addLabel({
    x = 2,
    y = 5,
    width = 21,
    text = count:map(function(value)
        return "Shared count: " .. value
    end),
})

terminalRoot:addButton({
    x = 2,
    y = 8,
    width = 21,
    height = 3,
    text = "Increment",
    background = colors.blue,
}):onClick(function()
    count:update(function(value) return value + 1 end)
end)

terminalRoot:addButton({
    x = 2,
    y = 12,
    width = 21,
    height = 3,
    text = "Sim touch",
}):onClick(function()
    os.queueEvent("monitor_touch", monitorName, 3, 11)
end)

terminalRoot:addButton({
    x = 2,
    y = 16,
    width = 21,
    height = 2,
    text = "Exit",
    background = colors.red,
}):onClick(function()
    basalt.stop()
end)

monitorRoot:addLabel({
    x = 2,
    y = 2,
    text = "VIRTUAL MONITOR",
    foreground = colors.yellow,
})

monitorRoot:addLabel({
    x = 2,
    y = 5,
    width = 21,
    text = count:map(function(value)
        return "Shared count: " .. value
    end),
})

monitorRoot:addProgressBar({
    x = 2,
    y = 7,
    width = 21,
    progress = count:map(function(value)
        return value * 10 % 101
    end),
    barColor = colors.lime,
    background = colors.black,
    showPercentage = true,
})

monitorRoot:addButton({
    x = 2,
    y = 10,
    width = 21,
    height = 3,
    text = "TOUCH TARGET",
    background = colors.green,
}):onClick(function()
    touches:update(function(value) return value + 1 end)
    count:update(function(value) return value + 5 end)
end)

monitorRoot:addLabel({
    x = 2,
    y = 15,
    width = 21,
    text = touches:map(function(value)
        return "Monitor touches: " .. value
    end),
})

basalt.run()
```

## Design Notes

- Design each root for its own dimensions and text scale.
- Apply theme defaults before constructing roots.
- Use large touch targets on physical monitors.
- Keep essential state in text or symbols as well as color.
- A clean root skips drawing even when another root changes.

## Common Mistakes

- Passing element properties to `createFrame()` instead of configuring the
  returned root.
- Creating the monitor before the intended main terminal.
- Starting one event loop per display.
- Sharing element instances instead of application state.
- Expecting keyboard input from monitor hardware.

## Related Guides and API

- [Reactive State](../foundations/reactive-state)
- [Testing](../development/testing)
- [Performance Tuning](../development/performance-tuning)
- [`basalt.createFrame()`](/api/basalt#basalt-createframe-t-monitorname)

## Next Steps

Use [Performance Tuning](../development/performance-tuning) to keep
high-frequency multi-display applications responsive.

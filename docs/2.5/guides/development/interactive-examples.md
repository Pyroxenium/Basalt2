# Interactive Examples

Runnable examples let readers start a real CC:Tweaked computer without
leaving the guide. The emulator uses
[Copy Cat](https://github.com/SquidDev-CC/copy-cat) and receives the same
minified Basalt 2.5 build that is shipped with this documentation.

## Run a Basalt Application

Select **Run in CC:Tweaked** above the example. The computer starts with the
code as `startup.lua` and Basalt as `basalt.lua`.

```lua run title="Basalt counter"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = basalt.rgb("#14161b")

local count = 0
local value = frame:addLabel({
    x = 2,
    y = 3,
    width = 28,
    text = "Button clicks: 0",
    foreground = colors.orange,
})

frame:addButton({
    x = 2,
    y = 6,
    width = 14,
    text = "Increment",
}):onClick(function()
    count = count + 1
    value.text = "Button clicks: " .. count
end)

frame:addButton({
    x = 18,
    y = 6,
    width = 10,
    text = "Exit",
}):onClick(function()
    basalt.stop()
end)

basalt.run()
```

The emulator window can be moved, centered, restarted, and closed. Opening a
second example creates an independent computer.

```lua run title="Second computer"
term.setTextColor(colors.cyan)
print("Independent CC:Tweaked computer")
term.setTextColor(colors.white)
print("")
print("This example can run beside the")
print("Basalt counter above.")
```

## Marking an Example as Runnable

Add `run` after the `lua` language marker:

````md
```lua run
print("Hello from CC:Tweaked")
```
````

Give the emulator a descriptive title with an optional `title` value:

````md
```lua run title="Input example"
-- application code
```
````

Only explicitly marked Lua blocks are executable. Every example remains an
ordinary highlighted, copyable code block when JavaScript is unavailable.

## Runtime and Lifecycle

The page loads Copy Cat only when a reader starts the first example. All
examples share that loader and the cached Basalt runtime, while each open
window owns a separate CC:Tweaked computer.

Closing a window or navigating away disposes its computer and removes its
event handlers. Restart replaces only that example. Failed network requests
show an error inside the window and can be retried.

Copy Cat runs entirely in the browser. It models CC:Tweaked, but examples
that depend on a Minecraft world, attached peripherals, or server-specific
HTTP configuration still need to be tested in-game.

## Next Steps

- Use [Debugging](./debugging) to reduce a problem to
  a small runnable example.
- Start with [Getting Started](../getting-started) for the Basalt application
  lifecycle.

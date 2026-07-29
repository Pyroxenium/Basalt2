# Getting Started

In this guide you will install Basalt and build a complete small application
with text input, buttons, and keyboard focus.

## Requirements

- A CC:Tweaked computer running a current CraftOS version
- HTTP access enabled when downloading Basalt with `wget`

## Install Basalt

Run the installer inside the CC:Tweaked computer:

```shell
wget run https://basalt.madefor.cc/2.5/install.lua minified
```

The recommended minified build is saved as `basalt.lua`. Your application can
load it with:

```lua
local basalt = require("basalt")
```

See [Installation](./foundations/installation) for the interactive installer,
other build variants, custom destinations, and troubleshooting.

## Build a Small Application

Create a file named `app.lua` next to `basalt.lua`:

```lua run title="Getting started app"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = basalt.rgb("#14161b")

frame:addLabel({
    x = 2,
    y = 2,
    text = "What is your name?",
    foreground = colors.orange,
})

local nameInput = frame:addInput({
    x = 2,
    y = 4,
    width = 24,
    placeholder = "Steve",
})

local result = frame:addLabel({
    x = 2,
    y = 6,
    width = 30,
    text = "Enter a name to continue.",
    foreground = colors.lightGray,
})

local function greet()
    local name = nameInput.text:match("^%s*(.-)%s*$")
    if name == "" then
        result.text = "Please enter a name."
        result.foreground = colors.red
        return
    end

    result.text = "Hello, " .. name .. "!"
    result.foreground = colors.lime
end

frame:addButton({
    x = 2,
    y = 8,
    width = 12,
    text = "Say hello",
}):onClick(greet)

frame:addButton({
    x = 16,
    y = 8,
    width = 10,
    text = "Exit",
}):onClick(function()
    basalt.stop()
end)

nameInput:onEnter(greet)
nameInput:focus()

basalt.run()
```

Run the program:

```shell
app
```

You can activate **Say hello** with the mouse or press Enter while the input
is focused. **Exit** calls `basalt.stop()` and lets the event loop finish
cleanly.

## What the Code Does

`basalt.getMainFrame()` returns the root frame connected to the current
terminal. Every label, input, and button is a child of that frame.

Elements accept their initial properties in a table:

```lua
local label = frame:addLabel({
    x = 2,
    y = 2,
    text = "Hello",
})
```

Properties remain writable after creation:

```lua
label.text = "Updated"
label.foreground = colors.yellow
```

Events connect user actions to Lua functions:

```lua
button:onClick(function(self)
    self.text = "Clicked"
end)
```

Finally, `basalt.run()` draws every frame and waits for CC:Tweaked events.
It blocks until the program terminates or calls `basalt.stop()`.

## Next Steps

- Read [How Basalt Works](./foundations/mental-model) for the complete
  application lifecycle.
- Learn the three supported configuration styles in
  [Elements and Properties](./foundations/elements-and-properties).
- Build interfaces that adapt to their terminal in
  [Layout Basics](./foundations/layout-basics).
- Connect data to controls with [Reactive State](./foundations/reactive-state).

For detailed class and method information, see the
[API Reference](/api/).

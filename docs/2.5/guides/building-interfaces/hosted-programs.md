# Hosted Programs

Program embeds a complete CC application inside a Basalt interface. The child
receives its own terminal window and event loop while the host controls
placement, focus, lifecycle, and error feedback.

Use [Canvas](./canvas) instead when Basalt already owns the data and only
custom drawing is needed.

## Start a Program

Add the element before calling `execute()`:

```lua
local program = frame:addProgram({
    x = 2,
    y = 3,
    width = 40,
    height = 12,
})

program:execute("shell")
program:focus()
```

`execute()` accepts a file path or a program name resolved by the shell.
Additional arguments become the child's `...` values.

The child sees the Program dimensions through `term.getSize()`. Resizing the
element resizes its window and sends `term_resize`.

## Event Routing

| Events | Delivery |
| --- | --- |
| Mouse events | Local coordinates inside the Program |
| Key, character, and paste events | Only while the Program owns focus |
| Timers, redstone, modem, HTTP, and other events | Forwarded by its event pump |

Clicking the Program focuses it. A host Button takes focus when clicked, so
return focus after actions intended to continue inside the child.

Send host-specific events explicitly:

```lua
program:sendEvent("host_message", "Refresh requested")
```

The child receives them normally:

```lua
local _, message = os.pullEvent("host_message")
```

## Lifecycle

| Method | Result |
| --- | --- |
| `execute(path, ...)` | Stops the old child and starts another |
| `stop()` | Immediately closes the coroutine |
| `terminate()` | Sends `terminate`, then force-stops if necessary |
| `destroy()` | Terminates the child and removes the element |

`running` and `path` describe the current child.

Listen for completion and failure:

```lua
program:onDone(function(self, ok, result)
    status.text = ok and "Finished" or "Failed"
end)

program:onError(function(self, err, trace)
    status.text = "Child error: " .. tostring(err)
end)
```

Without an `error` handler, a child crash reaches Basalt's application error
screen. Manual `stop()` fires neither `done` nor `error`.

## Child Environment

Add host values before execution:

```lua
program.env = {
    hostName = "Control Room",
    accentColor = colors.orange,
}
program:execute("child.lua")
```

The environment is assembled when the child starts. Use events for values
that change later. Relative `require()` calls resolve from the child file's
directory.

## Runnable Host

This example creates a temporary child program, hosts it, and removes it on
Exit.

```lua run title="Hosted Program console"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.gray

local childPath = ".basalt-hosted-demo.lua"
local childSource = [=[
local message = "Click here, then type"
local count = 0

local function draw()
    local width, height = term.getSize()
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    term.setCursorPos(2, 2)
    term.setTextColor(accentColor)
    term.write("HOSTED PROGRAM")
    term.setTextColor(colors.lightGray)
    term.setCursorPos(2, 4)
    term.write("Clicks: " .. count)
    term.setCursorPos(2, 6)
    term.write(message:sub(1, width - 2))
    term.setCursorPos(2, height)
    term.write(("Size: %dx%d"):format(width, height))
end

draw()
while true do
    local event, a, b, c = os.pullEvent()
    if event == "mouse_click" then
        count = count + 1
        message = ("Mouse at %d,%d"):format(b, c)
    elseif event == "char" then
        message = "Typed: " .. a
    elseif event == "host_message" then
        message = tostring(a)
    elseif event == "term_resize" then
        message = "Window resized"
    end
    draw()
end
]=]

local file = assert(fs.open(childPath, "w"))
file.write(childSource)
file.close()

local status = frame:addLabel({
    x = 2,
    y = 1,
    width = 47,
    text = "Starting child...",
    foreground = colors.white,
})

local program = frame:addProgram({
    x = 2,
    y = 3,
    width = 48,
    height = 11,
    background = colors.black,
    env = { accentColor = colors.orange },
})

program:onError(function(_, err)
    status.text = "Child error: " .. tostring(err)
    status.foreground = colors.red
end)

local function start()
    program:execute(childPath)
    program:focus()
    status.text = "Running - click inside to type"
end

frame:addButton({
    x = 2,
    y = 15,
    width = 12,
    height = 2,
    text = "Restart",
}):onClick(start)

frame:addButton({
    x = 16,
    y = 15,
    width = 12,
    height = 2,
    text = "Message",
}):onClick(function()
    program:sendEvent("host_message", "Hello from Basalt")
    program:focus()
end)

frame:addButton({
    x = 38,
    y = 15,
    width = 12,
    height = 2,
    text = "Exit",
    background = colors.red,
}):onClick(function()
    program:terminate()
    if fs.exists(childPath) then fs.delete(childPath) end
    basalt.stop()
end)

start()
basalt.run()
```

## Common Mistakes

- Execute only after the Program belongs to a root.
- Focus the Program before expecting keyboard input.
- Use `terminate()` when the child should see a shutdown event.
- Register `onError` when the host should remain open after a child crash.
- Do not wrap Program in a second event loop.

## Related Guides and API

- [Canvas](./canvas)
- [Debugging](../development/debugging)
- [Testing](../development/testing)
- [`Program`](/api/elements/Program)

## Next Steps

Use [Multiple Roots and Monitors](./multiple-roots-and-monitors) when an
application must render on separate physical displays instead of one hosted
window.

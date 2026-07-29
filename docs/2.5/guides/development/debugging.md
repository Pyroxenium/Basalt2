# Debugging

Use Basalt's debug overlay, element inspection, and protected error screen to
understand a live interface. Once the problem is reduced, turn the expected
behavior into a test with [Testing](./testing).

## A Short Debugging Loop

1. Reproduce the problem with the fewest interactions.
2. Log the relevant event, state, focus, and geometry.
3. Decide whether the failure belongs to data, layout, or event routing.
4. Reduce it to one root and the affected controls.
5. Fix the cause and keep a regression test.

Avoid changing several unrelated properties while investigating.

## Debug Overlay

```lua
local basalt = require("basalt")
local dbg = basalt.use("debug")

dbg.log("Starting", basalt.VERSION)
```

Press F12 to toggle the overlay. Control it directly when necessary:

```lua
dbg.show(true)
dbg.show(false)
dbg.show()
dbg.clear()
dbg.setToggleKey(keys.f3)
```

The overlay retains the latest 40 messages and displays the latest seven.
It is ordinary interactive UI at high `z`, so it consumes mouse input in the
rows it covers.

Log transitions and context:

```lua
tasks:onChange(function(self, index, item, oldIndex)
    dbg.log(
        "task",
        "old=" .. tostring(oldIndex),
        "new=" .. tostring(index),
        "value=" .. tostring(item and item.value)
    )
end)
```

Do not serialize large tables continuously. Log a changed record or count.

## Inspect Elements

Give important controls names:

```lua
local saveButton = panel:addButton({
    name = "save_button",
    x = 2,
    y = 8,
    width = 12,
    text = "Save",
})
```

Then inspect the tree:

```lua
local found = frame:find("save_button")
local absoluteX, absoluteY = found:getAbsolutePosition()

dbg.log(
    found.name,
    absoluteX .. "," .. absoluteY,
    found.width .. "x" .. found.height,
    "visible=" .. tostring(found.visible)
)
```

Properties return resolved values. `element:raw("width")` returns the authored
value, which may be a Signal, function, or layout token.

Inspect focus and hit testing:

```lua
local focused = frame:getFocused()
local hit = frame:findAt(10, 6)

dbg.log("focused", focused and focused.name or "<none>")
dbg.log("hit", hit and hit.name or "<none>")
```

## The Error Screen

Errors raised during `basalt.run()` are wrapped with source information and
shown on a protected error screen. It covers drawing, event handlers,
reactive evaluation, and scheduled coroutines.

Errors before `basalt.run()` use normal CC error handling:

```lua
local config = assert(loadConfig()) -- outside the protected loop
basalt.run()
```

Validate startup data deliberately or wrap only the expected failure.

Scheduled failures keep their coroutine traceback:

```lua
basalt.schedule(function()
    sleep(0.1)
    error("worker failed")
end)
```

Handle recoverable application errors locally:

```lua
local ok, value = pcall(textutils.unserializeJSON, input.text)
if not ok then
    status.text = "Invalid JSON"
    status.foreground = colors.red
    return
end
```

Do not catch unexpected programming errors only to hide their traceback.

## Hosted Program Failures

```lua
program:onDone(function(self, ok, result)
    dbg.log("program done", ok, result)
end)

program:onError(function(self, err, trace)
    dbg.log("program error", err)
    dbg.log("trace", trace:gsub("\n", " | "))
end)
```

With an `error` handler, the host remains open. Without one, the failure
reaches Basalt's normal error screen.

## Runnable Diagnostic App

```lua run title="Diagnostic application"
local basalt = require("basalt")
local dbg = basalt.use("debug")

dbg.setToggleKey(keys.f3)

local frame = basalt.getMainFrame()
frame.background = colors.black

local attempts = 0

frame:addLabel({
    x = 2,
    y = 1,
    width = 47,
    text = "Diagnostic app - press F3 for logs",
    foreground = colors.orange,
})

local input = frame:addInput({
    name = "number_input",
    x = 2,
    y = 4,
    width = 20,
    placeholder = "Positive number",
})

local status = frame:addLabel({
    name = "status",
    x = 2,
    y = 7,
    width = 35,
    height = 3,
    text = "Waiting for input",
    foreground = colors.lightGray,
})

local function validate()
    attempts = attempts + 1
    local value = tonumber(input.text)
    dbg.log("validate", "attempt=" .. attempts, "raw=" .. input.text)

    if not value or value <= 0 then
        status.text = "Enter a number above zero."
        status.foreground = colors.red
        return
    end

    status.text = "Accepted: " .. value
    status.foreground = colors.lime
end

frame:addButton({
    x = 2,
    y = 11,
    width = 12,
    height = 2,
    text = "Validate",
}):onClick(validate)

frame:addButton({
    x = 16,
    y = 11,
    width = 12,
    height = 2,
    text = "Inspect",
}):onClick(function()
    local found = frame:find("number_input")
    local x, y = found:getAbsolutePosition()
    dbg.log("input bounds", x, y, found.width, found.height)
    dbg.show(true)
end)

frame:addButton({
    x = 38,
    y = 15,
    width = 12,
    height = 2,
    text = "Exit",
    background = colors.red,
}):onClick(function()
    basalt.stop()
end)

input:onEnter(validate)
input:focus()
basalt.run()
```

## Common Mistakes

- `print()` writes behind Basalt; use the overlay while the UI runs.
- `tostring(table)` does not show table contents.
- The protected error screen starts inside `basalt.run()`.
- A visible debug overlay occupies real hit-testable rows.
- `fire()` does not test root routing or coordinate conversion.

## Related Guides and API

- [Testing](./testing)
- [Hosted Programs](../building-interfaces/hosted-programs)
- [Performance Tuning](./performance-tuning)
- [`debug` module](/api/modules/debug)
- [`errors`](/api/core/errors)

## Next Steps

Turn the reduced behavior into a deterministic test with
[Testing](./testing).

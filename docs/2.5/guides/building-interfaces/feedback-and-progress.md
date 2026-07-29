# Feedback and Progress

Use the least disruptive feedback that still communicates the result:

| Pattern | Use |
| --- | --- |
| Inline Label | Persistent validation or connection state |
| Toast | Temporary success, warning, or error |
| ProgressBar | Determinate work from 0 through 100 |
| Dialog | A decision that must interrupt the workflow |

## Inline Status

```lua
status.text = "Settings saved"
status.foreground = colors.lime
```

Inline feedback remains visible while the user corrects a form or examines a
current state.

## Toast

Create one Toast and reuse it:

```lua
local toast = frame:addToast({
    duration = 3,
    maxWidth = 24,
})

toast:success("Settings saved")
toast:error("Could not save", 5)
toast:warning("Fuel is low")
toast:info("Scanning")
```

Duration zero keeps it open until clicked or hidden. A new message replaces
the current message and its auto-hide timer.

## Progress

```lua
local progress = frame:addProgressBar({
    x = 2,
    y = 6,
    width = 30,
    progress = 0,
    barColor = colors.lime,
    background = colors.gray,
    showPercentage = true,
})
```

Values are clamped to 0 through 100. Yield during work so Basalt can redraw:

```lua
basalt.schedule(function()
    for value = 0, 100, 10 do
        progress.progress = value
        sleep(0.1)
    end
    toast:success("Complete")
end)
```

Tie progress to real work events when possible. Use status text instead of a
fictional percentage when completion cannot be estimated.

## Runnable Feedback

```lua run title="Feedback and progress"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

local toast = frame:addToast({
    duration = 2,
    maxWidth = 24,
})

local status = frame:addLabel({
    x = 2,
    y = 2,
    width = 40,
    text = "Ready",
    foreground = colors.lightGray,
})

local progress = frame:addProgressBar({
    x = 2,
    y = 6,
    width = 35,
    progress = 0,
    barColor = colors.lime,
    background = colors.gray,
    showPercentage = true,
})

local running = false

frame:addButton({
    x = 2,
    y = 10,
    width = 12,
    height = 2,
    text = "Start",
}):onClick(function()
    if running then return end
    running = true
    status.text = "Working..."
    status.foreground = colors.orange

    basalt.schedule(function()
        for value = 0, 100, 10 do
            progress.progress = value
            sleep(0.1)
        end
        running = false
        status.text = "Complete"
        status.foreground = colors.lime
        toast:success("Operation complete")
    end)
end)

frame:addButton({
    x = 38,
    y = 14,
    width = 12,
    height = 2,
    text = "Exit",
    background = colors.red,
}):onClick(function()
    basalt.stop()
end)

basalt.run()
```

## Common Mistakes

- Do not create a new Toast for every message.
- Do not block the event loop while updating ProgressBar.
- Use a Dialog only when an answer changes what happens next.
- Keep essential state in text as well as color.

## Related Guides and API

- [Dialogs and Context Menus](./dialogs)
- [Performance Tuning](../development/performance-tuning)
- [`Toast`](/api/elements/Toast)
- [`ProgressBar`](/api/elements/ProgressBar)

## Next Steps

Use [Dialogs and Context Menus](./dialogs) for confirmations, prompts, and
temporary action lists.

# Dialogs and Context Menus

Dialogs interrupt the current workflow for a decision or short input.
ContextMenu exposes temporary actions at a pointer location. Routine success
and progress belong in [Feedback and Progress](./feedback-and-progress).

## Reuse One Dialog

```lua
local dialog = frame:addDialog({
    boxWidth = 32,
    titleBackground = colors.blue,
    titleForeground = colors.white,
    boxBackground = colors.lightGray,
    boxForeground = colors.black,
})
```

Add it to the root when its backdrop should cover the complete application.

## Alert, Confirm, and Prompt

```lua
dialog:alert("Connection", "The remote computer is unavailable.")
```

```lua
dialog:confirm("Delete task?", "This cannot be undone.", function(yes)
    if yes then deleteTask() end
    taskList:focus()
end)
dialog:focus()
```

```lua
dialog:prompt("Rename", "New task name:", currentName, function(value)
    if value and value:match("%S") then currentName = value end
    renameButton:focus()
end)
```

Prompt returns `nil` for Cancel. An empty string is a submitted value.

Alert and Confirm do not automatically claim keyboard focus. Focus the Dialog
or build a custom overlay when full keyboard navigation is required.

Every closure fires `close`:

```lua
dialog:onClose(function(self, result)
    cleanup(result)
end)
```

Manual `close()` fires this event but not a helper-specific callback.

## Context Menu

```lua
local menu = frame:addContextMenu()

menu:setItems({
    { text = "Rename", callback = renameSelected },
    { separator = true },
    { text = "Delete", callback = deleteSelected },
})

menu:showAt(20, 8)
```

Coordinates passed to a root menu are root-local. Close or replace other
overlays so temporary layers do not compete.

## Runnable Dialog

```lua run title="Dialogs and context menu"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

local status = frame:addLabel({
    x = 2,
    y = 2,
    width = 45,
    height = 3,
    text = "Choose an action.",
    foreground = colors.lightGray,
})

local dialog = frame:addDialog({
    boxWidth = 32,
    titleBackground = colors.blue,
    boxBackground = colors.lightGray,
    boxForeground = colors.black,
})

frame:addButton({
    x = 2,
    y = 6,
    width = 12,
    height = 2,
    text = "Confirm",
}):onClick(function()
    dialog:confirm("Continue?", "Apply the selected action?", function(yes)
        status.text = yes and "Confirmed" or "Cancelled"
        status.foreground = yes and colors.lime or colors.orange
    end)
    dialog:focus()
end)

frame:addButton({
    x = 16,
    y = 6,
    width = 12,
    height = 2,
    text = "Prompt",
}):onClick(function()
    dialog:prompt("Rename", "Enter a name:", "", function(value)
        status.text = value and ("Name: " .. value) or "Prompt cancelled"
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

- Use inline status or Toast for routine success.
- Keep destructive work inside the confirmation callback.
- Restore useful focus after a Dialog closes.
- Treat empty Prompt text separately from Cancel.
- Do not assume pointer modality also provides keyboard modality.

## Related Guides and API

- [Feedback and Progress](./feedback-and-progress)
- [Events and Focus](../foundations/events-and-focus)
- [`Dialog`](/api/elements/Dialog)
- [`ContextMenu`](/api/elements/ContextMenu)

## Next Steps

Use [Feedback and Progress](./feedback-and-progress) for non-blocking status,
notifications, and long-running work.

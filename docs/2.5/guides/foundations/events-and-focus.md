# Events and Focus

Events connect mouse, keyboard, and application actions to Lua functions.
Basalt routes input through the element tree and calls the handlers registered
on the matching element.

## Registering Event Handlers

Most events have a convenience method:

```lua
button:onClick(function(self, mouseButton, x, y)
    self.text = "Clicked"
end)
```

Every handler receives the element as its first argument. Remaining arguments
depend on the event.

The generic form is equivalent:

```lua
button:on("click", function(self, mouseButton, x, y)
    self.text = "Clicked"
end)
```

Convenience methods are easier to discover; `on()` is useful for dynamic and
custom event names.

## Common Element Events

All elements support these events:

| Event | Convenience method | Additional arguments |
| --- | --- | --- |
| `click` | `onClick` | mouse button, local x, local y |
| `clickUp` | `onClickUp` | mouse button, local x, local y |
| `drag` | `onDrag` | mouse button, local x, local y |
| `scroll` | `onScroll` | direction, local x, local y |
| `focus` | `onFocus` | none |
| `blur` | `onBlur` | none |
| `key` | `onKey` | key code, held flag |
| `keyUp` | `onKeyUp` | key code |
| `char` | `onChar` | typed character |
| `paste` | `onPaste` | pasted text |
| `mouseEnter` | `onMouseEnter` | none |
| `mouseLeave` | `onMouseLeave` | none |
| `stateChange` | `onStateChange` | state name, active |

Controls add their own events. For example, `Input` fires `change` with its
new text and `enter` with its current text:

```lua
input:onChange(function(self, text)
    print("New value:", text)
end)

input:onEnter(function(self, text)
    print("Submitted:", text)
end)
```

Check the element's API page for its exact callback arguments.

## Handler References and Removal

Keep a function reference when it may need to be removed:

```lua
local function handleClick(self)
    self.text = "Clicked"
end

button:onClick(handleClick)
button:off("click", handleClick)
```

`off()` removes one matching registration. Passing a newly created function
does not remove the original handler.

## Keyboard Focus

Only the focused element receives keyboard, character, and paste events.

Input-like controls focus themselves when clicked. Focus can also be assigned
explicitly:

```lua
input:focus()
```

Listen for focus changes:

```lua
input:onFocus(function(self)
    self.background = colors.white
end)

input:onBlur(function(self)
    self.background = colors.lightGray
end)
```

The root frame tracks the focused element:

```lua
local focused = frame:getFocused()
```

Hiding, disabling, removing, or destroying a focused subtree releases its
focus safely.

## Mouse Routing and Stacking

Mouse input is sent to the topmost visible child under the pointer. When
siblings overlap, the greater `z` property wins:

```lua
dialog.z = 100
tooltip.z = 200
```

An element consumes a click when it has a background or a click handler.
Transparent decorative elements without handlers allow the search to
continue.

Coordinates passed to a handler are local to the receiving element:

```lua
canvas:onClick(function(self, button, x, y)
    -- x=1, y=1 is the canvas's own top-left cell.
end)
```

## Control-Specific Events

Several controls follow common patterns:

- `Input` and `TextBox` fire `change`.
- `Checkbox` and `Switch` fire `change` with the checked value.
- `Slider` fires `change` with the new numeric value.
- Collections fire selection events.
- `TabControl` fires `change` when the active tab changes.
- `Dialog` fires `close` with its result.
- `Program` fires `done` or `error`.

Use these semantic events instead of reimplementing the control's mouse and
keyboard behavior.

## Custom Application Events

Any element can host a custom event:

```lua
panel:on("saved", function(self, path)
    status.text = "Saved " .. path
end)

panel:fire("saved", "config.json")
```

`fire()` calls handlers synchronously and returns whether any handlers were
registered.

## Complete Form Example

```lua run title="Focused form events"
local basalt = require("basalt")

local frame = basalt.getMainFrame()

frame:addLabel({
    x = 2,
    y = 2,
    text = "Amount:",
})

local amount = frame:addInput({
    x = 10,
    y = 2,
    width = 8,
    placeholder = "1",
    pattern = "%d",
    maxLength = 4,
})

local status = frame:addLabel({
    x = 2,
    y = 4,
    width = 30,
    text = "Waiting...",
})

local function submit()
    local value = tonumber(amount.text)
    if not value then
        status.text = "Enter a number."
        status.foreground = colors.red
        amount:focus()
        return
    end

    status.text = "Accepted: " .. value
    status.foreground = colors.lime
end

amount:onChange(function(self, text)
    status.text = text == "" and "Waiting..." or "Editing: " .. text
    status.foreground = colors.lightGray
end)

amount:onEnter(submit)

frame:addButton({
    x = 2,
    y = 6,
    width = 10,
    text = "Submit",
}):onClick(submit)

frame:addButton({
    x = 14,
    y = 6,
    width = 8,
    text = "Exit",
}):onClick(function()
    basalt.stop()
end)

amount:focus()
basalt.run()
```

## Common Mistakes

### Calling the handler during registration

Pass the function itself:

```lua
button:onClick(save)
```

Do not call it:

```lua
button:onClick(save()) -- wrong
```

### Expecting keyboard events without focus

Call `focus()` or let the user click the input control first.

### Depending on terminal-global coordinates

Mouse callback coordinates are local to the receiving element.

### Adding low-level click handling to existing controls

Prefer `onChange`, `onEnter`, `onSelect`, and other control-specific events
when available.

## Related API

- [`Element` events](/api/elements/Element)
- [`BaseFrame` focus management](/api/elements/BaseFrame)
- [`Input`](/api/elements/Input)
- [`Checkbox`](/api/elements/Checkbox)
- [`Slider`](/api/elements/Slider)

## Next Steps

Continue with [Layout Basics](./layout-basics), or use
[Reactive State](./reactive-state) to connect controls to application data.

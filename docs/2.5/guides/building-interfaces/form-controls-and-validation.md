# Form Controls and Validation

Forms combine editable controls, one source of state, explicit validation,
and predictable submission.

## Boolean and Numeric Controls

```lua
local enabled = frame:addCheckbox({
    x = 2,
    y = 3,
    text = "Enable alerts",
})

local compact = frame:addSwitch({
    x = 2,
    y = 6,
    text = "Compact mode",
})

local volume = frame:addSlider({
    x = 2,
    y = 9,
    width = 24,
    min = 0,
    max = 100,
    value = 50,
})
```

Observe `change` for user-visible value changes. Slider values are clamped to
their range.

## Reactive Form State

```lua
local nameValue = basalt.state("")
local enabledValue = basalt.state(false)
local volumeValue = basalt.state(50)

nameInput:bind("text", nameValue)
enabled:bind("checked", enabledValue)
volume:bind("value", volumeValue)
```

Editable bindings are two-way by default. Derive summaries with Computed
values rather than duplicating synchronization handlers.

## Validation

Use a named state plus an explanatory message:

```lua
nameInput:setStateStyle("invalid", {
    background = colors.red,
    foreground = colors.white,
}, 60)

local valid = #nameInput.text >= 3
nameInput:setState("invalid", not valid)

if not valid then
    status.text = "Name must contain at least three characters."
    nameInput:focus()
end
```

Clear stale validation while the user corrects the field:

```lua
nameInput:onChange(function(self)
    self:setState("invalid", false)
end)
```

Do not rely only on color.

## One Submission Function

Connect mouse and keyboard actions to one function:

```lua
submitButton:onClick(submitForm)
lastInput:onEnter(submitForm)
```

This prevents validation rules from diverging.

## Runnable Settings Form

```lua run title="Validated settings form"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

local nameValue = basalt.state("")
local alertsValue = basalt.state(true)
local volumeValue = basalt.state(50)

frame:addLabel({
    x = 2,
    y = 1,
    text = "Settings",
    foreground = colors.orange,
})

local name = frame:addInput({
    x = 2,
    y = 4,
    width = 22,
    placeholder = "Profile name",
})
name:bind("text", nameValue)
name:setStateStyle("invalid", {
    background = colors.red,
    foreground = colors.white,
}, 60)

local alerts = frame:addCheckbox({
    x = 2,
    y = 7,
    text = "Enable alerts",
})
alerts:bind("checked", alertsValue)

local volume = frame:addSlider({
    x = 2,
    y = 10,
    width = 24,
    min = 0,
    max = 100,
})
volume:bind("value", volumeValue)

local status = frame:addLabel({
    x = 29,
    y = 4,
    width = 20,
    height = 6,
    text = basalt.computed(function()
        return ("Name: %s\nAlerts: %s\nVolume: %d"):format(
            nameValue:get() ~= "" and nameValue:get() or "<empty>",
            alertsValue:get() and "on" or "off",
            volumeValue:get()
        )
    end),
    foreground = colors.lightGray,
})

local function submit()
    local valid = #name.text >= 3
    name:setState("invalid", not valid)
    if not valid then
        status.foreground = colors.red
        name:focus()
        return
    end
    status.foreground = colors.lime
end

name:onChange(function(self)
    self:setState("invalid", false)
    status.foreground = colors.lightGray
end)

frame:addButton({
    x = 2,
    y = 14,
    width = 12,
    height = 2,
    text = "Save",
}):onClick(submit)

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

name:onEnter(submit)
name:focus()
basalt.run()
```

## Common Mistakes

- Input patterns filter inserted characters; they are not complete form
  validation.
- Direct property assignments do not necessarily fire user events.
- Basalt does not automatically move focus through an application form.
- Masked text is still stored as ordinary text.
- Keep one submission function for every activation path.

## Related Guides and API

- [Text Inputs](./text-inputs)
- [Dropdowns and Suggestions](./dropdowns-and-suggestions)
- [Reactive State](../foundations/reactive-state)
- [`Checkbox`](/api/elements/Checkbox)
- [`Switch`](/api/elements/Switch)
- [`Slider`](/api/elements/Slider)

## Next Steps

Use [Dialogs](./dialogs) only for decisions that genuinely interrupt the form
workflow.

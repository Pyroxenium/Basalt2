# Text Inputs

Use Input for one editable line and TextBox for multiline text. Both
participate in Basalt focus and keyboard routing.

## Input

```lua
local input = frame:addInput({
    x = 2,
    y = 3,
    width = 24,
    placeholder = "Computer name",
})
```

Read and write `text`:

```lua
print(input.text)
input.text = "Reactor"
```

Useful Input options include maximum length, replacement characters for
password-like display, and filtering patterns. A replacement character hides
the display only; it is not encryption.

## Events

```lua
input:onChange(function(self)
    status.text = "Length: " .. #self.text
end)

input:onEnter(function(self)
    submit(self.text)
end)
```

Direct property assignment changes the value but does not imitate user input
or fire every user event.

## Focus Progression

Basalt does not invent an application-wide Tab order. Define the desired
flow:

```lua
nameInput:onEnter(function()
    passwordInput:focus()
end)

passwordInput:onEnter(submitForm)
nameInput:focus()
```

When a page or dialog closes, focus a stable visible destination.

## TextBox

TextBox handles multiline content, cursor movement, selection, and scrolling:

```lua
local notes = frame:addTextBox({
    x = 2,
    y = 3,
    width = 32,
    height = 8,
    text = "First line\nSecond line",
})
```

Use Input for names, commands, and short form fields. Use TextBox for notes,
logs that can be edited, and larger documents.

## Runnable Input Flow

```lua run title="Text input flow"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

frame:addLabel({
    x = 2,
    y = 1,
    text = "Profile",
    foreground = colors.orange,
})

local name = frame:addInput({
    x = 2,
    y = 4,
    width = 22,
    placeholder = "Name",
})

local pin = frame:addInput({
    x = 2,
    y = 7,
    width = 22,
    placeholder = "PIN",
    replaceChar = "*",
})

local status = frame:addLabel({
    x = 2,
    y = 11,
    width = 40,
    height = 3,
    text = "Enter a name.",
    foreground = colors.lightGray,
})

local function submit()
    if not name.text:match("%S") then
        status.text = "Name is required."
        status.foreground = colors.red
        name:focus()
        return
    end
    status.text = "Saved profile for " .. name.text
    status.foreground = colors.lime
end

name:onEnter(function()
    pin:focus()
end)
pin:onEnter(submit)

frame:addButton({
    x = 27,
    y = 4,
    width = 12,
    height = 2,
    text = "Save",
}):onClick(submit)

frame:addButton({
    x = 27,
    y = 8,
    width = 12,
    height = 2,
    text = "Exit",
    background = colors.red,
}):onClick(function()
    basalt.stop()
end)

name:focus()
basalt.run()
```

## Related Guides and API

- [Form Controls and Validation](./form-controls-and-validation)
- [Events and Focus](../foundations/events-and-focus)
- [`Input`](/api/elements/Input)
- [`TextBox`](/api/elements/TextBox)

## Next Steps

Combine text fields with toggles, sliders, state, and validation in
[Form Controls and Validation](./form-controls-and-validation).

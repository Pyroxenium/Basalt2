# Dropdowns and Suggestions

Dropdown and ComboBox both present compact single-choice collections.
Dropdown accepts only listed entries; ComboBox also provides editable text
and optional suggestions.

## Dropdown

```lua
local dropdown = frame:addDropdown({
    x = 2,
    y = 2,
    width = 18,
    text = "Choose one...",
    dropHeight = 5,
    items = { "Low", "Medium", "High" },
})
```

`text` is the placeholder shown before selection. Do not set `height`;
Dropdown changes it internally while opening.

```lua
dropdown:select(2)
dropdown.open = true
dropdown.open = false
```

The expanded list floats above siblings, closes after acceptance or blur,
supports scrolling, and responds to arrows, Enter, Space, and Escape.

## ComboBox

```lua
local combo = frame:addComboBox({
    x = 2,
    y = 2,
    width = 20,
    placeholder = "Assignee",
    dropHeight = 5,
    autoComplete = true,
    items = { "Alex", "Sam", "Taylor" },
})
```

With `autoComplete = true`, user input filters suggestions by
case-insensitive prefix. The editable text may still be a free-form value.
Validate it explicitly when only listed entries are allowed.

Direct assignment to `combo.text` does not imitate user editing and does not
open suggestions automatically.

Inspect the filtered view:

```lua
for _, row in ipairs(combo:getDisplayItems()) do
    print(row.index, row.text, row.item.value)
end
```

## Events

Both controls use the collection model:

```lua
dropdown:onChange(function(self, index, item)
    status.text = item and item.text or "No selection"
end)

dropdown:onSelect(function(self, index, item)
    save(item.value)
end)
```

ComboBox also exposes Input events such as `change`, `enter`, and `char`.
`select` means a suggestion was accepted; `change` means the editable text
changed.

## Runnable Example

```lua run title="Dropdown and ComboBox"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

local status = frame:addLabel({
    x = 2,
    y = 12,
    width = 45,
    height = 3,
    text = "Choose a priority or type an assignee.",
    foreground = colors.lightGray,
})

frame:addLabel({
    x = 2,
    y = 2,
    text = "Priority",
    foreground = colors.orange,
})

local priority = frame:addDropdown({
    x = 2,
    y = 4,
    width = 18,
    text = "Choose...",
    dropHeight = 5,
    items = {
        { text = "Low", value = 1 },
        { text = "Normal", value = 2 },
        { text = "Urgent", value = 3 },
    },
})

frame:addLabel({
    x = 27,
    y = 2,
    text = "Assignee",
    foreground = colors.orange,
})

local assignee = frame:addComboBox({
    x = 27,
    y = 4,
    width = 20,
    placeholder = "Type a name",
    dropHeight = 5,
    autoComplete = true,
    items = { "Alex", "Sam", "Taylor", "Toni" },
})

priority:onSelect(function(_, _, item)
    status.text = "Priority: " .. item.text
    status.foreground = item.value == 3 and colors.red or colors.lime
end)

assignee:onSelect(function(_, _, item)
    status.text = "Assigned to " .. item.text
end)

assignee:onEnter(function(self)
    status.text = "Typed assignee: " .. self.text
end)

frame:addButton({
    x = 37,
    y = 16,
    width = 10,
    height = 2,
    text = "Exit",
    background = colors.red,
}):onClick(function()
    basalt.stop()
end)

basalt.run()
```

## Common Mistakes

- Do not set Dropdown or ComboBox `height`; use `dropHeight`.
- Do not assume ComboBox text always belongs to a selected item.
- Observe `change` for text edits and `select` for accepted suggestions.
- Use collection methods instead of mutating the raw item array.

## Related Guides and API

- [Lists and Selection](./lists-and-selection)
- [Text Inputs](./text-inputs)
- [Form Controls and Validation](./form-controls-and-validation)
- [`Dropdown`](/api/elements/Dropdown)
- [`ComboBox`](/api/elements/ComboBox)

## Next Steps

Use [Tables and Trees](./tables-and-trees) for structured records with
multiple columns or hierarchy.

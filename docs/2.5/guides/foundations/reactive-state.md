# Reactive State

Reactive state keeps application data separate from UI elements. When a
signal changes, Basalt invalidates every element that depends on it and shows
the new value automatically.

## Writable Signals

Create a signal with `basalt.state()`:

```lua
local count = basalt.state(0)
```

Read and replace its value:

```lua
print(count:get())
count:set(1)
```

Update it from the current value:

```lua
count:update(function(value)
    return value + 1
end)
```

`basalt.signal()` is an alias for `basalt.state()`.

## Assigning State to Properties

A signal or computed value may be assigned directly to an element property:

```lua
local count = basalt.state(0)

local label = frame:addLabel({
    text = count:map(function(value)
        return "Count: " .. value
    end),
})
```

When `count` changes, the mapped value is evaluated again and the label is
redrawn.

This is a one-way connection from application state to the UI.

## Computed Values

Use `basalt.computed()` when a value depends on one or more signals:

```lua
local firstName = basalt.state("Alex")
local lastName = basalt.state("Smith")

local fullName = basalt.computed(function()
    return firstName:get() .. " " .. lastName:get()
end)

label.text = fullName
```

Signals read inside the computation become dependencies automatically.
Computed values are read-only.

For a single source, `map()` is a concise equivalent:

```lua
label.text = count:map(function(value)
    return "Count: " .. value
end)
```

## Two-Way Bindings

Writable controls need changes to travel in both directions. Bind a property
to a signal:

```lua
local name = basalt.state("")

local input = frame:addInput({
    width = 20,
})

input:bind("text", name)
```

The input displays the current signal value. Typing into it also writes the
new text back to `name`.

Basalt knows the default events for common writable properties:

- `text` uses `change`;
- `checked` uses `change`;
- `value` uses `change`;
- `selected` uses `select`.

For another property or event, configure it explicitly:

```lua
element:bind("propertyName", value, {
    event = "eventName",
})
```

Disable write-back with:

```lua
element:bind("text", name, {
    twoWay = false,
})
```

## Transforming Bindings

Transform a state value before assigning it:

```lua
label:bind("text", count, function(value)
    return "Count: " .. value
end)
```

For a two-way transformation, provide both directions:

```lua
input:bind("text", count, {
    fromState = function(value)
        return tostring(value)
    end,
    toState = function(text)
        return tonumber(text) or 0
    end,
})
```

Remove a binding while preserving its current resolved value:

```lua
input:unbind("text")
```

Pass `false` as the second argument to restore the class or theme default:

```lua
input:unbind("text", false)
```

## Subscriptions

Subscriptions perform work outside the visual property system:

```lua
local unsubscribe = count:subscribe(function(value, oldValue)
    print("Count changed from", oldValue, "to", value)
end)

-- Later:
unsubscribe()
```

Pass `true` as the second argument to call the listener immediately with the
current value:

```lua
count:subscribe(listener, true)
```

Use subscriptions for side effects. Prefer computed values for derived UI
content.

## Mutable Tables and `touch`

Setting the same table value does not look like a change. After mutating a
table stored in a signal, call `touch()`:

```lua
local items = basalt.state({})

table.insert(items:get(), "Iron")
items:touch()
```

Alternatively, create a new table and call `set()`.

## Reactive Functions and Expressions

Properties can also derive values from their element:

```lua
label.text = function(self)
    return "Width: " .. self.parent.width
end
```

Braced expressions offer a compact declarative syntax:

```lua
button.x = "{parent.width - self.width + 1}"
```

They can reference:

- `self`;
- `parent`;
- descendants found by `name`;
- `colors`, `math`, and `rgb`;
- helpers such as `floor`, `ceil`, `min`, `max`, and `clamp`.

Use signals for application state and expressions for short relationships
between elements.

## Complete Reactive Application

```lua run title="Reactive state counter"
local basalt = require("basalt")

local frame = basalt.getMainFrame()

local name = basalt.state("")
local count = basalt.state(0)
local excited = basalt.state(false)

frame:addLabel({
    x = 2,
    y = 2,
    text = "Name:",
})

local nameInput = frame:addInput({
    x = 9,
    y = 2,
    width = 18,
    placeholder = "Steve",
})
nameInput:bind("text", name)

local excitement = frame:addCheckbox({
    x = 2,
    y = 4,
    text = "Use exclamation marks",
})
excitement:bind("checked", excited)

local summary = basalt.computed(function()
    local currentName = name:get()
    if currentName == "" then currentName = "stranger" end

    local punctuation = excited:get() and "!!!" or "."
    return "Hello " .. currentName .. " — clicks: "
        .. count:get() .. punctuation
end)

frame:addLabel({
    x = 2,
    y = 6,
    width = 40,
    text = summary,
})

local increment = frame:addButton({
    x = 2,
    y = 8,
    width = 12,
    text = "Increment",
})

increment.disabled = name:map(function(value)
    return value:match("^%s*$") ~= nil
end)

increment:onClick(function()
    count:update(function(value)
        return value + 1
    end)
end)

frame:addButton({
    x = 16,
    y = 8,
    width = 8,
    text = "Exit",
}):onClick(function()
    basalt.stop()
end)

nameInput:focus()
basalt.run()
```

The input and checkbox update signals through two-way bindings. The summary
and disabled state derive themselves from those signals without manual redraw
logic.

## Common Mistakes

### Assigning a signal directly to an editable property

Direct assignment is ideal for one-way output. Use `bind()` when user edits
must update the source signal.

### Forgetting `get()` inside a computed function

Dependencies are collected when their values are read:

```lua
local doubled = basalt.computed(function()
    return count:get() * 2
end)
```

### Mutating a state table without notification

Call `touch()` or replace the table with `set()`.

### Using subscriptions for every derived label

Computed properties express visual dependencies more clearly and clean
themselves up with the element.

## Related API

- [`state`](/api/core/state)
- [`Element.bind()`](/api/elements/Element)
- [`reactive expressions`](/api/core/reactive)

## Next Steps

Continue with [Styling, States, and Themes](./styling-states-and-themes) to
turn application data and interaction states into a consistent visual
language.

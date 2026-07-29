# Testing

Basalt interfaces can be tested without entering the blocking event loop.
Keep domain logic as plain Lua, then use `basalt.update()` for integration
tests involving layout, focus, hit testing, and event routing.

## Test Plain Logic First

```lua
local function calculateFuel(items)
    local total = 0
    for _, item in ipairs(items) do
        assert(type(item.fuel) == "number", "fuel must be numeric")
        total = total + item.fuel
    end
    return total
end

assert(calculateFuel({
    { fuel = 80 },
    { fuel = 80 },
}) == 160)
```

This test needs no terminal or Basalt runtime.

## Test Signals

```lua
local basalt = require("basalt")
local count = basalt.state(0)
local observed = {}

local unsubscribe = count:subscribe(function(value, oldValue)
    observed[#observed + 1] = { value = value, oldValue = oldValue }
end, true)

count:set(1)

assert(#observed == 2)
assert(observed[1].value == 0)
assert(observed[2].oldValue == 0)

local doubled = basalt.computed(function()
    return count:get() * 2
end)

assert(doubled:get() == 2)
unsubscribe()
```

## Drive an Interface with `basalt.update()`

`basalt.update(event, ...)` dispatches one event and redraws every dirty root.
Without an event it only draws. Unlike `basalt.run()`, failures propagate
directly to the test program.

Create the root on a hidden window:

```lua
local width, height = term.getSize()
local testTerm = window.create(term.current(), 1, 1, width, height, false)
local frame = basalt.createFrame(testTerm)
```

Then build the interface and inject real CC event shapes:

```lua
local clicks = 0

local button = frame:addButton({
    name = "increment_button",
    x = 2,
    y = 2,
    width = 12,
    text = "Increment",
})

button:onClick(function()
    clicks = clicks + 1
end)

basalt.update()
assert(frame:find("increment_button") == button)
assert(frame:findAt(2, 2) == button)

basalt.update("mouse_click", 1, 2, 2)
basalt.update("mouse_up", 1, 2, 2)

assert(clicks == 1)
assert(frame:getFocused() == button)
```

Mouse arguments are button, terminal x, and terminal y. Keyboard events go to
the focused element:

```lua
input:focus()
basalt.update("char", "A")

assert(input.text == "A")
assert(frame:getFocused() == input)
```

## Runnable Test

This example exits after printing its result; it does not start
`basalt.run()`.

```lua run title="Deterministic interface test"
local basalt = require("basalt")

local width, height = term.getSize()
local hidden = window.create(term.current(), 1, 1, width, height, false)
local frame = basalt.createFrame(hidden)

local count = 0
local button = frame:addButton({
    name = "counter_button",
    x = 2,
    y = 2,
    width = 14,
    text = "Increment",
})

local input = frame:addInput({
    name = "name_input",
    x = 2,
    y = 5,
    width = 18,
})

button:onClick(function()
    count = count + 1
end)

basalt.update()
assert(frame:find("counter_button") == button)
assert(frame:findAt(2, 2) == button)

basalt.update("mouse_click", 1, 2, 2)
basalt.update("mouse_up", 1, 2, 2)
assert(count == 1)

input:focus()
basalt.update("char", "A")
assert(input.text == "A")

term.setCursorPos(1, 1)
term.clear()
term.setTextColor(colors.lime)
print("All interface assertions passed.")
```

## Direct Event Tests

For a narrow callback test:

```lua
local saved = false

saveButton:onClick(function()
    saved = true
end)

saveButton:fire("click", 1, 1, 1)
assert(saved)
```

This bypasses root routing, hit testing, focus, pressed state, and coordinate
conversion. Prefer `basalt.update()` for integration behavior.

## Test Errors

Use `pcall` when failure is the expected result:

```lua
local ok, err = pcall(function()
    assert(loadConfiguration("missing.json"))
end)

assert(not ok)
assert(tostring(err):find("missing", 1, true))
```

`basalt.errors.parse()` can turn a wrapped error into structured source
information for a custom test harness.

## Test Isolation

Run each interface test as a fresh CC program. Basalt retains roots and
scheduled coroutines for the lifetime of the loaded module and exposes no
test-reset operation.

Do not call `basalt.run()` in automated tests. It blocks for real events and
its error screen waits for dismissal.

## Common Mistakes

- `fire()` is not an event-routing test.
- `basalt.update()` does not advance timers on its own.
- A hidden terminal prevents output but not rendering logic.
- Reusing one Basalt instance leaks roots and schedules between tests.
- Direct property assignments do not necessarily fire user events.

## Related Guides and API

- [Debugging](./debugging)
- [Interactive Examples](./interactive-examples)
- [`basalt.update()`](/api/basalt#basalt-update-event)
- [`state`](/api/core/state)

## Next Steps

Use [Performance Tuning](./performance-tuning) after correctness tests pass
but the target hardware still feels slow.

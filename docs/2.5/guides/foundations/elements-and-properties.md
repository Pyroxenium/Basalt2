# Elements and Properties

Basalt elements are configured through properties. The same properties can be
provided while creating an element, assigned directly later, or changed with
fluent setter methods.

## Creating Elements

Containers expose an `add<Type>()` method for every registered element:

```lua
local frame = basalt.getMainFrame()

local label = frame:addLabel()
local button = frame:addButton()
local panel = frame:addFrame()
```

The new element is attached to the container immediately and returned to the
caller.

Initial properties can be provided as a table:

```lua
local button = frame:addButton({
    x = 2,
    y = 3,
    width = 14,
    height = 1,
    text = "Save",
    foreground = colors.white,
    background = colors.blue,
})
```

This is usually the clearest style for constructing an interface.

## Direct Property Assignment

Properties remain directly writable:

```lua
button.text = "Saved"
button.background = colors.green
button.disabled = true
```

Basalt automatically invalidates the required layout or rendering work.
There is no separate `redraw()` call for normal property changes.

Properties can also be read directly:

```lua
print(button.text)
print(button.width)
```

## Fluent Setters

Every declared property has generated `set...` and `get...` methods:

```lua
button
    :setText("Save")
    :setBackground(colors.blue)
    :setForeground(colors.white)
```

Setters return the element, so they can be chained. Direct assignments do not
return the element.

Frequently used groups have combined methods:

```lua
button
    :setPosition(2, 3)
    :setSize(14, 1)
    :setColors(colors.white, colors.blue)
```

The corresponding getters return multiple values:

```lua
local x, y = button:getPosition()
local width, height = button:getSize()
```

## Events in Creation Tables

An `onX` callback can be included alongside properties:

```lua
local button = frame:addButton({
    x = 2,
    y = 3,
    text = "Save",
    onClick = function(self)
        self.text = "Saved"
    end,
})
```

Use whichever style keeps the construction readable. Longer handlers are
usually easier to understand when registered separately.

## Shared Element Properties

All visible elements inherit a common property set:

| Property | Purpose |
| --- | --- |
| `x`, `y` | Parent-local position |
| `width`, `height` | Resolved size |
| `minWidth`, `maxWidth` | Horizontal size constraints |
| `minHeight`, `maxHeight` | Vertical size constraints |
| `z` | Stacking order among siblings |
| `visible` | Rendering and input visibility |
| `disabled` | Whether the element accepts input |
| `foreground` | Text or foreground color |
| `background` | Background color, or `false` for transparency |
| `name` | Lookup name used by `find()` |

Element-specific properties, such as `Input.placeholder` or
`ProgressBar.progress`, are documented in the
[Elements API](/api/).

## Naming and Finding Elements

Assign a name when another part of the application needs to locate an
element:

```lua
local content = frame:addFrame({
    name = "content",
    x = 2,
    y = 2,
    width = 30,
    height = 10,
})

content:addLabel({
    name = "status",
    x = 2,
    y = 2,
    text = "Ready",
})

local status = frame:find("status")
status.text = "Working"
```

`find()` searches descendants depth-first and returns the first matching
element.

Prefer direct Lua references for nearby code. Names are most useful across
larger subtrees, declarative XML, and reactive expressions.

## Visibility, Disabling, and Removal

Hide an element temporarily:

```lua
panel.visible = false
```

A hidden element is not rendered and does not receive input. Its children
remain attached and appear again when the parent becomes visible.

Disable a control while keeping it visible:

```lua
button.disabled = true
```

Disabled elements ignore input and automatically enter the `disabled` visual
state.

Remove an element permanently:

```lua
button:destroy()
```

Destroying a container recursively destroys its descendants. Use `visible`
for temporary screens and `destroy()` when the object is no longer needed.

## Authored and Resolved Values

Layout and reactive properties may resolve to a different effective value.
For example, an authored `basalt.fill()` width becomes a numeric terminal-cell
width during layout:

```lua
local rawWidth = panel:raw("width")
local resolvedWidth = panel.width
```

Combined raw getters are available as well:

```lua
local rawWidth, rawHeight = panel:getRawSize()
```

Most application code should use the resolved direct property. Raw values are
helpful when inspecting layout configuration.

## Complete Example

```lua run title="Element visibility and removal"
local basalt = require("basalt")

local frame = basalt.getMainFrame()

local panel = frame:addFrame({
    name = "panel",
    x = 2,
    y = 2,
    width = 28,
    height = 8,
    background = colors.gray,
})

panel:addLabel({
    name = "status",
    x = 2,
    y = 2,
    text = "Ready",
})

local action = panel:addButton({
    x = 2,
    y = 4,
    width = 12,
    text = "Run",
})

action:onClick(function(self)
    local status = frame:find("status")
    status.text = "Finished"
    status.foreground = colors.lime
    self.disabled = true
end)

panel:addButton({
    x = 16,
    y = 4,
    width = 10,
    text = "Close",
    onClick = function()
        basalt.stop()
    end,
})

basalt.run()
```

## Common Mistakes

### Mixing assignment and chaining

This is not valid Lua:

```text
button.text = "Save":setWidth(10)
```

Use separate assignments or fluent setters.

### Expecting hidden controls to keep focus

Hiding or disabling an element releases its active interaction state.

### Repeatedly searching for nearby elements

Keep the value returned by `add...()` when the same scope already owns the
element.

## Related API

- [`Element`](/api/elements/Element)
- [`Container`](/api/elements/Container)
- [Element classes](/api/)

## Next Steps

Read [Events and Focus](./events-and-focus) to make elements interactive, then
continue with [Layout Basics](./layout-basics).

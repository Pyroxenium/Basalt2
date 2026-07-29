# Layout Basics

Basalt layouts use terminal cells. Elements can have fixed sizes, derive their
intrinsic size from content, fill remaining space, or use a fraction of the
space offered by their parent.

## Fixed Position and Size

The simplest layout uses numeric properties:

```lua
local panel = frame:addFrame({
    x = 2,
    y = 2,
    width = 30,
    height = 10,
})
```

Coordinates are one-based and relative to the direct parent. The top-left
cell is `(1, 1)`.

Numeric sizes are measured in terminal cells:

```lua
panel.width = 30
panel.height = 10
```

## Intrinsic Size with `auto`

`basalt.auto()` asks an element to measure its content:

```lua
local button = frame:addButton({
    x = 2,
    y = 2,
    width = basalt.auto(),
    height = basalt.auto(),
    text = "Continue",
})
```

Labels, buttons, inputs, rows, columns, tables, trees, images, and several
other elements provide useful intrinsic measurements.

An element without a specialized measurement falls back to its configured
numeric dimensions.

## Remaining Space with `fill`

`basalt.fill()` consumes the remaining space available from the element's
position:

```lua
local panel = frame:addFrame({
    x = 2,
    y = 2,
    width = basalt.fill(),
    height = basalt.fill(),
})
```

This keeps the panel two cells from the top and left and extends it to the
parent's right and bottom edges.

Inside flex layouts, `fill()` has an additional role: it shares the remaining
space on the main axis between fill-sized children. See
[Flex Layouts](./flex-layouts).

## Fractional Size with `percent`

`basalt.percent()` takes a fraction, where `1` means 100%:

```lua
local half = frame:addFrame({
    x = 1,
    y = 1,
    width = basalt.percent(0.5),
    height = basalt.fill(),
})
```

The fraction is applied to the space available to that element on the
selected axis. In an ordinary container, that space begins at the element's
configured position.

Use `0.5` for 50%, not `50`.

## Minimum and Maximum Sizes

Constrain responsive dimensions:

```lua
local panel = frame:addFrame({
    x = 2,
    y = 2,
    width = basalt.fill(),
    minWidth = 18,
    maxWidth = 42,
    height = 8,
})
```

The common constraints are:

- `minWidth`
- `maxWidth`
- `minHeight`
- `maxHeight`

Their default value is `false`, meaning no constraint.

## Dynamic Layout Properties

A property may be a function. Basalt evaluates it with the element as its
argument:

```lua
local footer = frame:addLabel({
    x = 2,
    y = function(self)
        return self.parent.height
    end,
    text = "Ready",
})
```

Reactive expression strings provide a shorter form:

```lua
local footer = frame:addLabel({
    x = 2,
    y = "{parent.height}",
    text = "Ready",
})
```

Expressions can use `self`, `parent`, named elements, `colors`, `math`,
`rgb`, and common numeric helpers:

```lua
local centered = frame:addButton({
    width = 12,
    x = "{floor((parent.width - self.width) / 2) + 1}",
    y = 2,
    text = "Centered",
})
```

For application data, prefer signals and computed values described in
[Reactive State](./reactive-state).

## Resizing

Root frames update their size when CC:Tweaked sends `term_resize` or
`monitor_resize`. Layout values and dynamic properties are resolved again as
the tree is laid out.

This application shell follows the terminal size:

```lua
local page = frame:addFrame({
    x = 2,
    y = 2,
    width = basalt.fill(),
    height = basalt.fill(),
})
```

No resize handler is needed for ordinary fill, percentage, or dynamic
properties.

## Complete Example

```lua run title="Responsive layout basics"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

local page = frame:addFrame({
    x = 2,
    y = 2,
    width = basalt.fill(),
    height = basalt.fill(),
    minWidth = 20,
    background = colors.gray,
})

page:addLabel({
    x = 2,
    y = 2,
    width = basalt.auto(),
    text = "Responsive panel",
    foreground = colors.orange,
})

page:addProgressBar({
    x = 2,
    y = 4,
    width = basalt.percent(0.5),
    progress = 65,
    showPercentage = true,
    barColor = colors.lime,
})

page:addButton({
    x = 2,
    y = "{parent.height - 2}",
    width = 10,
    text = "Exit",
}):onClick(function()
    basalt.stop()
end)

page:addLabel({
    x = 14,
    y = "{parent.height - 2}",
    text = function(self)
        return self.parent.width .. " x " .. self.parent.height
    end,
})

basalt.run()
```

Resize the terminal to see the page, progress bar, footer, and size label
resolve again.

## Raw and Resolved Sizes

Reading `element.width` returns its resolved numeric width:

```lua
print(page.width)
```

Inspect the authored layout token with:

```lua
local configuredWidth = page:raw("width")
```

Most application logic should use the resolved value.

## Common Mistakes

### Using zero-based coordinates

Basalt uses one-based element-local coordinates.

### Passing `50` to `percent`

The amount is a fraction. Use `basalt.percent(0.5)`.

### Expecting `auto` to inspect arbitrary custom drawing

Intrinsic sizing depends on the element's `measure()` implementation. Give a
Canvas or other custom-painted surface explicit dimensions when necessary.

### Mixing absolute and flow expectations

Ordinary Frames position children by `x` and `y`. Rows, Columns, and Flex
containers position flow children automatically.

## Related API

- [`layout`](/api/core/layout)
- [`Element`](/api/elements/Element)
- [`Frame`](/api/elements/Frame)

## Next Steps

Use [Flex Layouts](./flex-layouts) to arrange complete interfaces without
manually calculating every coordinate.

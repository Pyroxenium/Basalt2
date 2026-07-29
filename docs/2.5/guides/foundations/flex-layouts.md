# Flex Layouts

Flex containers arrange visible children automatically. Use them to build
rows, columns, toolbars, sidebars, forms, and application shells that adapt to
the available terminal size.

## Flex, Row, and Column

`Flex` is the configurable base element:

```lua
local flex = frame:addFlex({
    direction = "row",
})
```

`Row` and `Column` provide convenient defaults:

```lua
local row = frame:addRow()
local column = frame:addColumn()
```

- A Row lays out children from left to right.
- A Column lays out children from top to bottom.
- Rows default to `width = basalt.fill()` and `height = basalt.auto()`.
- Columns default to `width = basalt.auto()` and
  `height = basalt.fill()`.

Set both dimensions explicitly when the container should fill a complete
area.

## Flow Children

Children use `position = "flow"` by default. Their `x` and `y` properties are
replaced by positions calculated by the flex container:

```lua
local toolbar = frame:addRow({
    x = 2,
    y = 2,
    width = basalt.fill(),
    height = basalt.auto(),
    gap = 1,
})

toolbar:addButton({
    width = basalt.auto(),
    text = "New",
})

toolbar:addButton({
    width = basalt.auto(),
    text = "Save",
})
```

The insertion order determines the flow order.

## Gap and Padding

`gap` adds cells between flow children. `padding` adds equal inner spacing on
all four sides:

```lua
local column = frame:addColumn({
    x = 1,
    y = 1,
    width = basalt.fill(),
    height = basalt.fill(),
    gap = 1,
    padding = 1,
})
```

Padding is part of the container's own size.

## Filling Remaining Space

On the main axis, fixed and intrinsic children are measured first.
`basalt.fill()` children then share what remains:

```lua
local row = frame:addRow({
    width = basalt.fill(),
    height = 5,
})

row:addFrame({
    width = 12,
    height = basalt.fill(),
})

row:addFrame({
    width = basalt.fill(),
    height = basalt.fill(),
})
```

Fill weights divide the remainder proportionally:

```lua
row:addFrame({ width = basalt.fill(1) })
row:addFrame({ width = basalt.fill(2) })
```

The second frame receives approximately twice as much remaining width.

## Cross-Axis Alignment

The container's `align` property controls children on the cross axis:

```lua
row.align = "center"
```

Supported values are:

- `"start"`
- `"center"`
- `"end"`
- `"stretch"`

Override one child with `alignSelf`:

```lua
local button = row:addButton({
    text = "Special",
    alignSelf = "end",
})
```

`stretch` expands an `auto`-sized child across the available cross axis.

## Main-Axis Justification

`justify` controls how unused main-axis space is distributed:

```lua
toolbar.justify = "spaceBetween"
```

Supported values are:

- `"start"`
- `"center"`
- `"end"`
- `"spaceBetween"`

`spaceBetween` places the extra space between children and has an effect when
at least two flow children exist.

## Shrinking

When content is wider or taller than the flex container, eligible children
shrink without crossing their minimum size.

Fill-sized children shrink automatically. Configure a fixed child explicitly:

```lua
local sidebar = row:addFrame({
    width = 18,
    minWidth = 10,
    shrink = 1,
})
```

Set `shrink = 0` to prevent shrinking. Multiple children distribute the
deficit according to their shrink weights.

Flex overflow is currently clipped. Use a scrollable Frame when content must
remain accessible beyond the viewport.

## Absolute Children

An absolute child is excluded from flow:

```lua
local closeButton = column:addButton({
    position = "absolute",
    x = "{parent.width - 3}",
    y = 1,
    width = 3,
    text = "X",
})
```

This is useful for overlays and decorations. Ordinary content should remain
in flow.

## Complete Application Shell

```lua run title="Flex application shell"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

local page = frame:addColumn({
    x = 1,
    y = 1,
    width = basalt.fill(),
    height = basalt.fill(),
    gap = 1,
    padding = 1,
})

local toolbar = page:addRow({
    width = basalt.fill(),
    height = basalt.auto(),
    gap = 1,
    justify = "spaceBetween",
})

toolbar:addLabel({
    width = basalt.auto(),
    text = "BASALT APP",
    foreground = colors.orange,
})

toolbar:addButton({
    width = basalt.auto(),
    text = "Exit",
}):onClick(function()
    basalt.stop()
end)

local content = page:addRow({
    width = basalt.fill(),
    height = basalt.fill(),
    gap = 1,
})

local sidebar = content:addFrame({
    width = 14,
    minWidth = 10,
    height = basalt.fill(),
    shrink = 1,
    background = colors.gray,
})

sidebar:addLabel({
    x = 2,
    y = 2,
    text = "Navigation",
})

local main = content:addColumn({
    width = basalt.fill(),
    height = basalt.fill(),
    gap = 1,
    padding = 1,
    background = colors.lightGray,
})

main:addLabel({
    width = basalt.auto(),
    text = "Dashboard",
    foreground = colors.black,
})

main:addProgressBar({
    width = basalt.fill(),
    progress = 72,
    showPercentage = true,
    barColor = colors.green,
})

main:addLabel({
    width = basalt.auto(),
    text = "Resize the terminal to test the layout.",
    foreground = colors.gray,
})

basalt.run()
```

The outer Column creates the vertical page structure. The content Row divides
the remaining area between a shrinkable sidebar and a fill-sized main area.

## Common Mistakes

### Setting `x` and `y` on flow children

Flex calculates their positions. Use `gap`, `padding`, `align`, and `justify`,
or set `position = "absolute"` intentionally.

### Leaving the container at its intrinsic default

Rows and Columns have convenient but different default dimensions. Set
`width` and `height` when building a full application region.

### Using `fill` without bounded parent space

A fill-sized child needs a parent that offers a meaningful numeric size.

### Expecting automatic wrapping

Flex currently lays out one row or one column. It does not wrap children onto
another line.

## Related API

- [`Flex`](/api/elements/Flex)
- [`Row`](/api/elements/Row)
- [`Column`](/api/elements/Column)
- [`layout`](/api/core/layout)

## Next Steps

Connect the application shell to data with
[Reactive State](./reactive-state).

# Animation and Responsive Layouts

The animation and responsive modules change an existing interface over time
or in response to container size. Load each module before using its methods.

## Animation

```lua
local basalt = require("basalt")
local animation = basalt.use("animation")
```

Animate numeric properties:

```lua
local handle = animation.to(
    panel,
    { x = 24, width = 18 },
    0.4,
    "easeOut",
    function(element)
        element.foreground = colors.lime
    end
)
```

Or use the Element shortcut installed by the module:

```lua
local handle = panel:animate({ x = 24 }, 0.4, "easeOut")
```

Supported easing names are `linear`, `easeIn`, `easeOut`, and `easeInOut`.
Cancel obsolete work:

```lua
handle.cancel()
```

Animation updates at roughly 20 frames per second. Geometry animation
invalidates layout; paint-only values are cheaper.

## Responsive Rules

```lua
local responsive = basalt.use("responsive")
```

Attach rules to a container:

```lua
responsive.apply(panel, {
    {
        maxWidth = 29,
        name = "compact",
        props = { direction = "column" },
    },
    {
        minWidth = 30,
        name = "wide",
        props = { direction = "row" },
    },
}, { exclusive = true })
```

The module evaluates rules during the container's layout event. A rule may
activate a named state and apply temporary properties.

Fluent breakpoints are useful for simple state changes:

```lua
panel:responsive()
    :when("parent.width < 30")
        :apply({ direction = "column" })
    :otherwise({ direction = "row" })
```

## Runnable Example

Resize the emulator to see the responsive state. Select Animate to move the
card.

```lua run title="Animation and responsive layout"
local basalt = require("basalt")
local animation = basalt.use("animation")
local responsive = basalt.use("responsive")

local frame = basalt.getMainFrame()
frame.background = colors.black

frame:addLabel({
    x = 2,
    y = 1,
    width = 47,
    text = "Resize the computer or animate the card",
    foreground = colors.orange,
})

local content = frame:addFlex({
    x = 2,
    y = 3,
    width = basalt.fill(),
    height = 7,
    direction = "row",
    gap = 1,
})

content:addFrame({
    width = basalt.fill(),
    height = basalt.fill(),
    background = colors.blue,
}):addLabel({ x = 2, y = 2, text = "Panel A" })

content:addFrame({
    width = basalt.fill(),
    height = basalt.fill(),
    background = colors.purple,
}):addLabel({ x = 2, y = 2, text = "Panel B" })

responsive.apply(content, {
    {
        maxWidth = 39,
        name = "compact",
        props = { direction = "column", gap = 0 },
    },
    {
        minWidth = 40,
        name = "wide",
        props = { direction = "row", gap = 1 },
    },
}, { exclusive = true })

local card = frame:addFrame({
    x = 2,
    y = 12,
    width = 12,
    height = 3,
    background = colors.orange,
})
card:addLabel({ x = 2, y = 2, text = "Animated" })

frame:addButton({
    x = 2,
    y = 17,
    width = 12,
    height = 2,
    text = "Animate",
}):onClick(function()
    local target = card.x == 2 and 27 or 2
    animation.to(card, { x = target }, 0.4, "easeOut")
end)

frame:addButton({
    x = 38,
    y = 17,
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

- Animation accepts numeric properties only.
- Load the module before calling `animate()` or responsive shortcuts.
- Attach responsive rules to a container with meaningful dimensions.
- Keep responsive `when` functions small and deterministic.

## Related Guides and API

- [Optional Modules](./)
- [Charts, Images, and BigFont](./charts-images-and-bigfont)
- [Flex Layouts](../foundations/flex-layouts)
- [`animation`](/api/modules/animation)
- [`responsive`](/api/modules/responsive)

## Next Steps

Use [Performance Tuning](../development/performance-tuning) when animation or
continuous resizing reveals an expensive layout.

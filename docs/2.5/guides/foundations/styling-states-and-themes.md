# Styling, States, and Themes

Basalt styling has three levels: direct element properties, state-dependent
styles, and reusable themes. This guide shows when to use each one and how
custom RGB colors fit into CC:Tweaked's 16-color terminal.

## Direct Styling

Every visible element inherits `foreground` and `background`:

```lua
local panel = frame:addFrame({
    x = 2,
    y = 2,
    width = 28,
    height = 8,
    foreground = colors.white,
    background = colors.gray,
})
```

`foreground` controls text and other foreground content. `background` fills
the element's bounds:

```lua
panel.foreground = colors.yellow
panel.background = colors.black
```

Set `background = false` for transparency:

```lua
local label = panel:addLabel({
    x = 2,
    y = 2,
    text = "Transparent label",
    background = false,
})
```

A transparent element leaves the already rendered background underneath it
untouched.

Controls add more specific color properties. Examples include:

- `ProgressBar.barColor`;
- `Slider.barColor` and `knobColor`;
- `Input.placeholderColor`;
- collection `selectionForeground` and `selectionBackground`;
- scrollbar track and thumb colors;
- Dialog title and box colors.

See the element's API page for its complete color surface.

## Custom RGB Colors

Use the native `colors.*` values when the standard CC:Tweaked palette is
sufficient:

```lua
button.background = colors.blue
button.foreground = colors.white
```

Register custom colors with `basalt.rgb()`:

```lua
local lava = basalt.rgb("#e8703a")
local stone = basalt.rgb("#22262e")

button.background = lava
panel.background = stone
```

The helper accepts several formats:

```lua
local a = basalt.rgb("#e8703a")
local b = basalt.rgb("#e73")
local c = basalt.rgb(0xE8703A)
local d = basalt.rgb(232, 112, 58)
local e = basalt.rgb(0.91, 0.44, 0.23)
```

Repeatedly registering the same RGB value returns the existing color handle.
Eight-digit `#AARRGGBB` strings are accepted, but the alpha component is
ignored. Transparency is controlled through element properties such as
`background = false`.

### The 16-color hardware limit

Basalt can register many RGB colors, but a CC:Tweaked terminal still has 16
hardware palette slots. During rendering, Basalt assigns slots to the colors
that are currently visible.

Native colors keep their slots when they are in use. Custom colors reuse
unused slots. If more than 16 distinct colors must be shown simultaneously,
additional colors fall back to the nearest assigned color.

Keep a deliberate, compact application palette for predictable results.
Basalt restores terminal palette colors when its root frames are cleaned up.

## Element States

States describe temporary conditions without replacing the element's authored
properties.

Basalt manages several common states automatically:

| State | Activated by |
| --- | --- |
| `hover` | Pointer entering the element |
| `focused` | Keyboard focus |
| `pressed` | Mouse button held on the element |
| `disabled` | `disabled = true` |
| `checked` | Checkbox or Switch selection |
| `selected` | Collection, Table, or Tree selection |

Inspect state membership:

```lua
if button:hasState("focused") then
    print("The button has focus")
end

local activeStates = button:getStates()
```

`getStates()` returns the active state names alphabetically.

## State Styles

A state style temporarily overrides selected properties:

```lua
button:setStateStyle("hover", {
    background = basalt.rgb("#3d434f"),
})

button:setStateStyle("focused", {
    foreground = colors.yellow,
})

button:setStateStyle("disabled", {
    foreground = colors.gray,
    background = colors.black,
})
```

When the state ends, the underlying authored or default values become
effective again.

State styles are instance-local. Styling one button does not affect another
button.

Unknown properties and properties that cannot be state-styled produce an
error immediately. This prevents misspelled theme properties from failing
silently.

## Custom States

Applications can define semantic states:

```lua
local statusPanel = frame:addFrame({
    background = colors.gray,
})

statusPanel:setStateStyle("warning", {
    background = colors.orange,
    foreground = colors.black,
})

statusPanel:setState("warning", true)
```

Toggle and deactivate the state:

```lua
statusPanel:toggleState("warning")
statusPanel:setState("warning", false)
```

Listen for state changes:

```lua
statusPanel:onStateChange(function(self, stateName, active)
    print(stateName, active)
end)
```

Use custom states for visual conditions such as `warning`, `connected`,
`loading`, or `invalid`. Use reactive state for the underlying application
data.

## State Priority

More than one state may override the same property. The state with the higher
priority wins.

Built-in priorities are:

| State | Priority |
| --- | ---: |
| `hover` | 10 |
| `focused` | 20 |
| `checked`, `selected` | 30 |
| `pressed` | 40 |
| custom states | 50 |
| `disabled` | 100 |

This makes a disabled style win over ordinary interaction styles. A custom
state wins over the built-in states except `disabled` unless its priority is
changed.

Set the priority while defining a state style:

```lua
button:setStateStyle("invalid", {
    background = colors.red,
}, 60)
```

Or update it separately:

```lua
button:setStatePriority("invalid", 60)
```

If active states have the same priority, the most recently activated one
wins.

## Loading the Theme Module

Themes are optional and loaded through `basalt.use()`:

```lua
local theme = basalt.use("theme")
```

The built-in `basalt` preset provides a complete dark palette and consistent
component styles:

```lua
local palette = theme.applyPreset("basalt")
```

Apply a preset before constructing the UI:

```lua
local basalt = require("basalt")
local theme = basalt.use("theme")
local palette = theme.applyPreset("basalt")

local frame = basalt.getMainFrame()
```

`applyPreset()` returns the preset's color tokens. The built-in preset
includes values such as:

```text
palette.bg
palette.surface
palette.raised
palette.border
palette.text
palette.muted
palette.lava
palette.success
palette.warning
palette.danger
palette.info
```

Use those tokens instead of duplicating RGB literals throughout the
application.

## Global Defaults with `theme.set`

`theme.set()` changes class-level defaults:

```lua
theme.set({
    Button = {
        foreground = colors.white,
        background = basalt.rgb("#405060"),
    },
    Input = {
        foreground = colors.white,
        background = basalt.rgb("#202830"),
        placeholderColor = colors.gray,
    },
})
```

The keys are Basalt class names such as `Element`, `Frame`, `Button`, or
`Input`.

The new default affects:

- elements created later;
- existing elements that never explicitly set that property.

An explicit instance property continues to win:

```lua
local special = frame:addButton({
    background = colors.red,
})

theme.set({
    Button = { background = colors.blue },
})

-- special remains red
```

State styles can be included under `states`:

```lua
theme.set({
    Button = {
        background = colors.gray,
        states = {
            hover = {
                background = colors.lightGray,
            },
            disabled = {
                foreground = colors.gray,
                background = colors.black,
            },
        },
    },
})
```

`theme.set()` is process-wide and persists until another theme call changes
the same defaults. It is best used during application startup.

Values may be functions for dynamic defaults. Braced reactive strings are not
allowed in `theme.set()` because class defaults are shared between elements.

## Styling a Subtree with `theme.apply`

`theme.apply()` writes explicit properties to matching elements in an
existing subtree:

```lua
theme.apply(settingsPanel, {
    Label = {
        foreground = colors.yellow,
    },
    Button = {
        background = colors.blue,
        states = {
            hover = {
                background = colors.lightBlue,
            },
        },
    },
})
```

This is useful when one section needs a local visual treatment.

Unlike `theme.set()`:

- it affects only elements already present in the selected subtree;
- values become explicit instance overrides;
- braced reactive expressions are supported;
- elements added later are not styled automatically.

Apply the local theme again after adding new descendants when they should
receive the same treatment.

## Loading Theme Files

Theme files separate palette tokens and component styles from application
code. JSON themes use this structure:

```json
{
  "name": "example",
  "colors": {
    "background": "#14161b",
    "surface": "#22262e",
    "accent": "#e8703a",
    "text": "#e8e6e1"
  },
  "styles": {
    "BaseFrame": {
      "background": "$background"
    },
    "Frame": {
      "background": "$surface"
    },
    "Button": {
      "background": "$accent",
      "foreground": "$background",
      "states": {
        "hover": {
          "foreground": "$text"
        }
      }
    }
  }
}
```

Values beginning with `$` reference entries from the theme's `colors` table.
Hex colors and native color names such as `"red"` or `"lightGray"` are also
resolved.

Load and apply the file:

```lua
local theme = basalt.use("theme")
local themeName = theme.load("themes/example.json")
local palette = theme.applyPreset(themeName)
```

Non-JSON theme files may use a table supported by
`textutils.unserialize()`.

## Complete Example

```lua run title="States and theme"
local basalt = require("basalt")
local theme = basalt.use("theme")
local palette = theme.applyPreset("basalt")

local frame = basalt.getMainFrame()

local panel = frame:addFrame({
    x = 2,
    y = 2,
    width = 34,
    height = 11,
    background = palette.surface,
})

panel:addLabel({
    x = 2,
    y = 2,
    text = "Styling demo",
    foreground = palette.lava,
})

local status = panel:addLabel({
    x = 2,
    y = 4,
    width = 30,
    text = "Ready",
    foreground = palette.muted,
})

local action = panel:addButton({
    x = 2,
    y = 6,
    width = 14,
    text = "Toggle alert",
})

action:setStateStyle("hover", {
    background = palette.ember,
    foreground = palette.bg,
})

action:setStateStyle("alert", {
    background = palette.danger,
    foreground = palette.text,
}, 60)

action:onClick(function(self)
    self:toggleState("alert")

    if self:hasState("alert") then
        self.text = "Clear alert"
        status.text = "Alert is active"
        status.foreground = palette.danger
    else
        self.text = "Toggle alert"
        status.text = "Ready"
        status.foreground = palette.muted
    end
end)

panel:addButton({
    x = 18,
    y = 6,
    width = 10,
    text = "Exit",
}):onClick(function()
    basalt.stop()
end)

panel:addLabel({
    x = 2,
    y = 9,
    text = "Hover, click, and focus the controls.",
    foreground = palette.muted,
})

basalt.run()
```

The global preset supplies the application palette and component defaults.
The action button adds instance-local `hover` and `alert` styles without
changing any other Button.

## Common Mistakes

### Applying a preset after creating explicit overrides

Theme defaults do not replace instance properties. Apply the main preset near
application startup.

### Expecting `theme.apply()` to style future children

It traverses the existing subtree once. Use `theme.set()` for defaults or
reapply the subtree theme after adding children.

### Using reactive strings in `theme.set()`

Shared class defaults have no single `self` or `parent`. Use a function, or
use `theme.apply()` for per-element reactive strings.

### Treating `#AARRGGBB` as transparency

The alpha byte is ignored. Use `background = false` where transparency is
supported.

### Displaying too many custom colors at once

The terminal has 16 hardware palette slots. Design around a compact set of
simultaneously visible colors.

### Styling state-marker properties

Properties such as `disabled`, `checked`, and `selected` control state and
cannot themselves be state-styled. Style visual properties such as colors,
symbols, or dimensions inside the state.

## Related API

- [`Element` states and state styles](/api/elements/Element)
- [`palette`](/api/core/palette)
- [`theme` module](/api/modules/theme)

## Next Steps

Continue with [Text Inputs](../building-interfaces/text-inputs) to
build a complete, validated interface on top of the visual system.

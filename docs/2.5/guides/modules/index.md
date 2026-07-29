# Optional Modules

Basalt keeps animation, responsive behavior, charts, images, large text,
themes, XML, and debugging outside the core runtime. Load only the features
an application needs:

```lua
local basalt = require("basalt")
local animation = basalt.use("animation")
```

Repeated calls return the loaded module. Load a module before creating any
element classes it registers.

## Choose a Module Guide

- [Animation and Responsive Layouts](./animation-and-responsive) — animate
  numeric properties and switch layout styles at breakpoints.
- [Charts, Images, and BigFont](./charts-images-and-bigfont) — visualize data,
  load image assets, and display large terminal text.
- [Styling, States, and Themes](../foundations/styling-states-and-themes) —
  apply presets and reusable styles.
- [XML Interfaces](../xml/) — construct element trees from XML.
- [Debugging](../development/debugging) — add the live debug overlay.

## Available Loader Names

| Loader | Main capability |
| --- | --- |
| `animation` | Numeric property tweening |
| `responsive` | Breakpoint-driven temporary styles |
| `charts` | Graph, PixelGraph, BarChart, and LineChart |
| `bigfont` | Large terminal text |
| `image` | BIMG and FLIMG loading and playback |
| `theme` | Presets, defaults, and subtree styling |
| `xml` | XML parsing and element construction |
| `debug` | On-screen log overlay |

## Side Effects

Some modules register new element classes or add fluent Element methods. Load
them during startup, before constructing the affected UI:

```lua
basalt.use("charts")
local graph = frame:addPixelGraph({...})
```

Module names are lowercase loader names, not element class names.

## Next Steps

Start with [Animation and Responsive Layouts](./animation-and-responsive) or
[Charts, Images, and BigFont](./charts-images-and-bigfont), depending on the
feature your interface needs.

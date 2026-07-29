# Basalt 2.5

[![Basalt 2.5 CI](https://github.com/Pyroxenium/Basalt2/actions/workflows/ci.yml/badge.svg?branch=basalt2.5)](https://github.com/Pyroxenium/Basalt2/actions/workflows/ci.yml)
[![Documentation](https://img.shields.io/badge/docs-Basalt_2.5-b84a1b)](https://basalt.madefor.cc/2.5/)

A modern UI framework for
[CC:Tweaked](https://tweaked.cc/) with reactive state, flexible layouts,
rich components, and first-class tooling.

Basalt 2.5 is an improved and extended release of Basalt 2. It modernizes
the internals and developer experience while keeping the familiar approach
to building terminal interfaces.

![Basalt 2.5 interface showcase](.github/assets/preview.gif)

## Features

- A broad component set including buttons, inputs, lists, tables, dialogs,
  menus, trees, tabs, and more
- Reactive state and computed values
- Responsive values and flex-based layouts
- RGB colors, palettes, and themes
- Optional modules for animations, charts, images, XML, debugging, and more
- Direct property access as well as method chaining
- LuaLS annotations and generated API documentation
- Readable and Shale-optimized single-file builds

## Installation

Run the following command inside CC:Tweaked:

```sh
wget run https://basalt.madefor.cc/2.5/install.lua minified
```

This downloads the recommended minified build as `basalt.lua`. You can then
load it with:

```lua
local basalt = require("basalt")
```

Run the installer without arguments to choose a version and destination
interactively:

```sh
wget run https://basalt.madefor.cc/2.5/install.lua
```

### Available builds

| Variant | Output | Intended use |
| --- | --- | --- |
| `source` | `basalt/` | Editable source files and development |
| `bundled` | `basalt.lua` | Readable single-file build |
| `minified` | `basalt.lua` | Shale-minified build with immediate startup; recommended |
| `compressed` | `basalt.lua` | Smallest [Shale](https://github.com/Pyroxenium/Shale)-powered build with a short startup delay |

A custom destination can be passed after the variant:

```sh
wget run https://basalt.madefor.cc/2.5/install.lua minified lib/basalt.lua
```

## Quick start

```lua
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame:setBackground(basalt.rgb("#1e1e2e"))

local label = frame:addLabel({
    x = 2,
    y = 2,
    text = "Hello World",
})

frame:addButton({
    x = 2,
    y = 4,
    text = "Click me",
})
    :onClick(function(self)
        self.text = "Thanks!"
        label.text = "Button clicked!"
    end)

basalt.run()
```

Elements accept properties when they are created. Most properties can also
be updated directly later:

```lua
label.text = "A new value"
label.x = 4
```

## Examples

- [`examples/basic.lua`](examples/basic.lua) is a small, commented starter
  application intended for copying and modification.
- [`examples/showcase.lua`](examples/showcase.lua) is the full animated
  Basalt 2.5 feature showcase.

## Documentation

- [Getting started](https://basalt.madefor.cc/2.5/guides/getting-started)
- [Guides](https://basalt.madefor.cc/2.5/guides/)
- [API reference](https://basalt.madefor.cc/2.5/api/)
- [Basalt 2 documentation](https://basalt.madefor.cc/2.0/)

## Community and support

- [Report a bug](https://github.com/Pyroxenium/Basalt2/issues)
- [GitHub Discussions](https://github.com/Pyroxenium/Basalt2/discussions)
- [Discord](https://discord.gg/yNNnmBVBpE)

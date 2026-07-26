# Welcome to the Basalt 2.5 Wiki

Basalt 2.5 is an improved and extended release of the Basalt 2 UI
framework for CC:Tweaked. It keeps the familiar approach to building
terminal interfaces while modernizing the internals and developer
experience.

The main improvements include:

- Clearer error messages that help developers identify and resolve issues
- Documentation generated directly from the annotated source code
- LuaLS annotations for better IDE completion and type information
- Direct property access alongside the familiar chainable API
- Reactive state, flexible layouts, responsive rules, and RGB palettes

## Features

- **Pre-built components:** Buttons, lists, text boxes, tables, dialogs,
  menus, trees, and more
- **Modern UI tools:** Reactive state, animations, themes, responsive
  layouts, palettes, and XML
- **Event system:** Flexible event handling for user interaction and
  application logic
- **Optional modules:** Add animations, charts, images, responsive rules,
  themes, XML layouts, and debugging tools as needed
- **Developer friendly:**
  - LuaLS type information for improved editor support
  - Generated API documentation that stays synchronized with the source
  - Support for minified builds

## Quick Start

```lua
local basalt = require("Basalt")

local frame = basalt.createFrame()
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

## Preview

![Basalt Demo GIF](https://raw.githubusercontent.com/Pyroxenium/Basalt/master/docs/_media/basaltPreview2.gif)

## Documentation

- [API Reference](/api/)
- [Source Code](https://github.com/Pyroxenium/Basalt2/tree/basalt2.5)
- [Basalt 2 Documentation](https://basalt.madefor.cc/2.0/)

## Community & Support

- Report bugs on [GitHub](https://github.com/Pyroxenium/Basalt2/issues)
- Join the [Discord server](https://discord.gg/yNNnmBVBpE)
- Ask questions in [GitHub Discussions](https://github.com/Pyroxenium/Basalt2/discussions)

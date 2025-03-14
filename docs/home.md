# Welcome to The Basalt Wiki

Welcome to Basalt 2, a complete reimagining of the Basalt UI framework for ComputerCraft. After maintaining the original Basalt, i identified several areas that needed fundamental improvements. This led to the decision to rebuild Basalt from the ground up, focusing on three key aspects:

- Improved error handling to help developers quickly identify and resolve issues
- Auto-generated documentation that stays in sync with the codebase
- IDE support through automatically generated LuaLS annotations
- New ways to access properties

## Features

- **Pre-built Components:** Buttons, Lists, Textboxes, and more
- **Modern UI:** Animations, themes, states, xml
- **Event System:** Powerful event handling
- **Plugin System:** Extend Basalt with custom plugins
- **Developer Friendly:** 
  - Type definitions for better IDE support
  - Extensive documentation
  - Minification support

## Quick Start

```lua
local basalt = require("basalt")

-- Create a simple UI
basalt.getMainFrame()
    :addButton()
    :setText("Hello Basalt!")
    :setPosition(5, 5)
    :setSize(14, 3)
    :onClick(function()
        -- Your code here
    end)

basalt.run()
```

## Preview

![Basalt Demo GIF](https://raw.githubusercontent.com/Pyroxenium/Basalt/master/docs/_media/basaltPreview2.gif)

## Documentation

- [Getting Started Guide](/guides/getting-started)
- [API Reference](/references/main)

## Community & Support

- Report bugs on [GitHub](https://github.com/Pyroxenium/Basalt2/issues)
- Join our [Discord](https://discord.gg/yNNnmBVBpE)
- Ask questions on [GitHub Discussions](https://github.com/Pyroxenium/Basalt2/discussions)
- Check out the [FAQ](/guides/faq)

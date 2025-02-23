# Welcome to The Basalt Wiki

Basalt is a user-friendly UI framework for CC:Tweaked (also known as "ComputerCraft: Tweaked") - a popular Minecraft mod. It was developed to enhance user interaction through visual displays.

## Installation

```lua
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua
```
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
    :onMouseClick(function()
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

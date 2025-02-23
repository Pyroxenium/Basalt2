# Frequently Asked Questions

## General

### What is Basalt?
Basalt is a UI framework for CC:Tweaked that helps you create user interfaces easily and efficiently. It provides pre-built components, event handling, and advanced features like animations and themes.

### Why should I use Basalt instead of direct terminal manipulation?
Basalt handles many complex aspects automatically:
- Event management
- Screen rendering
- Component positioning
- State management
- Layout organization

## Installation

### How do I install Basalt?
```lua
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua
```

### Can I customize my installation?
Yes! The installer allows you to:
- Choose between Release/Dev versions
- Select specific components
- Include LuaLS definitions
- Enable minification

## Common Issues

### Why isn't my UI updating?
Remember to call `basalt.run()` at the end of your program. Without it, your UI won't start.

### Why are my elements not visible?
Check:
1. Element positions are within parent bounds
2. Parent container is large enough
3. Element's `visible` property is true
4. Z-index conflicts with other elements

### How do I handle screen resizes?
Use dynamic positioning with strings, or use functions:
```lua
element:setPosition("{parent.width - 5}", 5)  -- 5 from right edge
element:setSize("{parent.width - 10}", 5)     -- 5 padding on each side
element:setPosition(function(self)            -- Another example, but as function call
    return self:getParent() - 5
end, 5)
```

## Development

### How do I add custom plugins?
Create a new plugin in the plugins directory. See [pluginExample](https://github.com/Pyroxenium/Basalt2/blob/main/examples/pluginExample.lua) for a example on how to create plugins

### Where can I find more examples?
- Check the examples directory in the repository
- Visit our [GitHub](https://github.com/Pyroxenium/Basalt2)
- Join our [Discord](https://discord.gg/yNNnmBVBpE)

### How do I contribute?
1. Fork the repository
2. Create a feature branch
3. Submit a pull request
4. Join our Discord for discussion

## Performance

### How can I optimize my Basalt application?
Basalt does already a lot of optimization:
- The render loop only runs when something visually changed (color, position, size,..) which means it only runs once, even if Basalt gets spammed with events (timer events or mouse events).
- The event system is highly optimized:
  - Events are only registered for elements that actually use them
  - Events bubble up through the element hierarchy efficiently
  - Event handlers are stored in a flat structure for quick access
  - Events are automatically cleaned up when elements are removed
  - Parent containers only receive events their children actually use

Additional tips for optimization:
- Group elements in Frames to reduce render calls
- Use `setVisible(false)` instead of removing elements you'll need again
- In case you need a LOT of elements you can use addDelayed{Element}, for example addDelayedButton instead of addButton

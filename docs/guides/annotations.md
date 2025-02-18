# Lua Annotations Guide

Writing Lua code for CC: Tweaked and Basalt becomes much more enjoyable with proper type annotations. They provide code completion, type checking, and inline documentation.

## Setting Up Annotations

### CC: Tweaked Annotations

Download the official CC: Tweaked type definitions from: [CC: Tweaked Annotations](https://github.com/nvim-computercraft/lua-ls-cc-tweaked)

The GitHub page includes a detailed installation guide that will help you set up everything correctly.

### Basalt Annotations

The Basalt Dev version includes built-in type definitions that provide:
- Complete type information for all Basalt elements
- Method parameter hints
- Return type information
- Event type definitions

To get started, simply download the Dev version of Basalt.

## IDE Configuration

### Required Extensions

For the best development experience, you'll need:
1. A Lua Language Server
2. An IDE with Lua support

For Visual Studio Code users:
- Install [Summeko Lua](https://marketplace.visualstudio.com/items?itemName=sumneko.lua)
- The extension provides full language server capabilities

## Benefits

With properly configured annotations, you get:
- ✓ Intelligent code completion
- ✓ Real-time type checking
- ✓ Documentation on hover
- ✓ Method signature help
- ✓ Better error detection
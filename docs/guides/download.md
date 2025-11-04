# Download

Basalt is available in multiple versions to suit different needs: the **Core** version for smaller projects, the **Full** version with all elements and plugins, the **Dev** version for development, and a **Custom** version for specific requirements. Basalt is also available on [PineStore](https://pinestore.cc/projects/15/basalt).

## Quick Start

To download the Basalt Installer UI using a ComputerCraft shell command:

```lua
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua
```

This launches an interactive installer where you can choose your preferred version and configuration.

## Available Versions

### Release (Core) - Recommended
The **Core** version includes only the essential elements. It's lighter, optimized for smaller projects, and perfect for most use cases.

**What's included:**
- All core systems (layouts, properties, rendering, etc.)
- Essential elements (Button, Label, Frame, List, Input, etc.)

**What's excluded:**
- Optional elements (TextBox, Display, Image, ComboBox, DropDown, Graph, LineChart, BigFont)
- Plugin files (core features are built-in)

**Best for:** Smaller projects, production use, limited storage environments

```lua
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -r
```

### Release (Full)
The **Full** version contains all elements and plugins. Use this if you need advanced or optional components in your project.

**What's included:**
- Everything from Core version
- Optional elements (TextBox, Image, ComboBox, DropDown, etc.)
- All available plugins (animation, theme, xml, etc.)

**Best for:** Large projects, advanced features, full flexibility

```lua
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -f
```

### Dev Version
The **Dev** version downloads the complete source code as individual files, maintaining the original folder structure. Perfect for development, debugging, or contributing to Basalt.

**Use cases:**
- Development and debugging
- Contributing to the project
- Learning how Basalt works internally
- Hot-reloading during development

**Note:** The source code is identical to the release versions - only the file structure differs. Contains all files uncompressed.

**Best for:** Development environments, debugging, contributions

```lua
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -d
```

### Custom Version
Available through the interactive installer, the **Custom** version lets you select exactly which elements and plugins you need.

**Features:**
- Pick individual elements and plugins
- Optional minification
- Optional single-file bundle
- Optional LuaLS type definitions

**To access:** Run the installer without arguments and select "Custom" from the dropdown.

## Command-Line Options

```bash
# Show help
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -h

# Install Core version (default, recommended)
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -r [path]

# Install Full version (all elements)
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -f [path]

# Install Dev version (source files)
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -d [path]
```

**Optional `[path]` argument:**
- For Release versions: Specifies the output filename (default: `basalt.lua`)
- For Dev version: Specifies the directory name (default: `basalt/`)

## Which Version Should I Choose?

| Version | Best For | Structure | Includes Plugins |
|---------|----------|-----------|------------------|
| **Core** | Smaller projects, limited storage | Single file | No (built-in) |
| **Full** | Large projects, all features | Single file | Yes |
| **Dev** | Development, debugging | Multiple files | Yes |
| **Custom** | Specific requirements | Configurable | Configurable |

## Examples

```lua
-- Install Core version as "myapp.lua"
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -r myapp.lua

-- Install Full version with default name
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -f

-- Install Dev version in "basalt-dev" folder
wget run https://raw.githubusercontent.com/Pyroxenium/Basalt2/main/install.lua -d basalt-dev
```

## After Installation

Once installed, you can load Basalt in your program:

```lua
local basalt = require("basalt")
```
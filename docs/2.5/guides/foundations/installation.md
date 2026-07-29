# Installation

This guide explains the available Basalt 2.5 builds, how to install them, and
how to verify that an application can load the framework.

## Requirements

Basalt 2.5 runs inside CC:Tweaked. Downloading it directly requires HTTP to be
enabled in the CC:Tweaked configuration.

## Recommended Installation

Run:

```shell
wget run https://basalt.madefor.cc/2.5/install.lua minified
```

This installs the recommended minified build as `basalt.lua` in the current
directory.

Keep the application and library together:

```text
my-app/
├── app.lua
└── basalt.lua
```

Load the library from `app.lua`:

```lua
local basalt = require("basalt")
```

## Interactive Installation

Run the installer without arguments to choose the build and destination
interactively:

```shell
wget run https://basalt.madefor.cc/2.5/install.lua
```

## Build Variants

| Variant | Output | Use it when |
| --- | --- | --- |
| `source` | `basalt/` | You want readable, editable source files. |
| `bundled` | `basalt.lua` | You want one readable file. |
| `minified` | `basalt.lua` | You want a small file with immediate startup. This is the recommended default. |
| `compressed` | `basalt.lua` | Download size matters more than a short startup delay. |

Install a specific build by passing its name:

```shell
wget run https://basalt.madefor.cc/2.5/install.lua bundled
```

A custom destination may follow the variant:

```shell
wget run https://basalt.madefor.cc/2.5/install.lua minified lib/basalt.lua
```

When using a custom destination, require the module using the corresponding
module path used by your project.

## Verify the Installation

Create `app.lua`:

```lua
local basalt = require("basalt")

print("Loaded Basalt " .. basalt.VERSION)
```

Running `app` should print the installed version without an error.

You can also verify that the UI starts correctly:

```lua
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame:addLabel({
    x = 2,
    y = 2,
    text = "Basalt is working.",
})

basalt.run()
```

Terminate this test with Ctrl+T.

## Updating Basalt

Run the installer again with the same variant and destination. Keep a backup
when updating an application that depends on development builds or internal
behavior.

Basalt 2.5 is not a drop-in replacement for a Basalt 2 application. Follow
[Migration Quickstart](../migration-quickstart) before replacing the
library used by an existing project.

## Troubleshooting

### HTTP is disabled

Enable HTTP in the CC:Tweaked configuration or transfer the selected build to
the computer by another method.

### `module 'basalt' not found`

Check that `basalt.lua` is next to the running program, or that the path passed
to `require` matches the directory where Basalt was installed.

Lua module names are case-sensitive in portable programs. Use:

```lua
local basalt = require("basalt")
```

### A source installation no longer loads

Do not move individual files out of the generated `basalt/` directory. The
source build uses its directory structure to load core files, elements, and
modules.

## Next Steps

Continue with [Getting Started](../getting-started) or learn
[How Basalt Works](./mental-model).

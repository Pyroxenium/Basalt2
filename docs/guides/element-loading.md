# Element Loading System

Basalt's Element Loading System allows you to load elements from different sources: local files, disk mounts, and even directly from the web.

## Getting the Element Manager

```lua
local basalt = require("basalt")
local elementManager = basalt.getElementManager()
```

## Configuration

Configure the loading behavior:

```lua
elementManager.configure({
    autoLoadMissing = true,           -- Auto-load elements that aren't found
    allowRemoteLoading = true,        -- Enable loading from URLs
    allowDiskLoading = true,          -- Enable loading from disk mounts
    useGlobalCache = true,            -- Cache loaded elements in _G
    globalCacheName = "_BASALT_CACHE" -- Name of the global cache variable
})
```

## Loading from Disk

Register disk mount points to load elements from external locations:

```lua
-- Register a disk mount
elementManager.registerDiskMount("/disk/basalt-elements")

-- Elements in /disk/basalt-elements/elements/ are now available
local main = basalt.getMainFrame()
local customButton = main:addCustomButton()  -- Loads from disk
```

## Loading from Remote URLs

Load elements directly from the web:

```lua
-- Enable remote loading
elementManager.configure({
    allowRemoteLoading = true
})

-- Register a remote source
elementManager.registerRemoteSource(
    "CustomElement",
    "https://example.com/elements/CustomElement.lua"
)

-- Use the element
local main = basalt.getMainFrame()
local custom = main:addCustomElement()
```

## Manual Element Loading

Load elements manually when needed:

```lua
-- Load a specific element
elementManager.loadElement("Button")

-- Get an element (loads it if not already loaded)
local ButtonClass = elementManager.getElement("Button")

-- Check if an element exists
if elementManager.hasElement("CustomWidget") then
    elementManager.loadElement("CustomWidget")
end

-- Check if an element is loaded
if not elementManager.isElementLoaded("Label") then
    elementManager.loadElement("Label")
end
```

## Preloading Elements

Preload multiple elements at startup for better performance:

```lua
-- Preload commonly used elements
elementManager.preloadElements({
    "Button",
    "Label",
    "Frame",
    "Input"
})
```

## Cache Management

When using `useGlobalCache`, elements are cached in `_G` for reuse:

```lua
-- Get cache statistics
local stats = elementManager.getCacheStats()
print("Cached elements: " .. stats.size)
for _, name in ipairs(stats.elements) do
    print("- " .. name)
end

-- Clear the cache
elementManager.clearGlobalCache()
```

## Complete Example

```lua
local basalt = require("basalt")
local elementManager = basalt.getElementManager()

-- Configure loading system
elementManager.configure({
    autoLoadMissing = true,
    allowRemoteLoading = true,
    allowDiskLoading = true,
    useGlobalCache = true
})

-- Register disk mount for custom elements
if fs.exists("/disk") then
    elementManager.registerDiskMount("/disk")
end

-- Register remote element
elementManager.registerRemoteSource(
    "SpecialButton",
    "https://raw.githubusercontent.com/user/repo/main/SpecialButton.lua"
)

-- Preload common elements
elementManager.preloadElements({"Button", "Label", "Frame"})

-- Use elements normally
local main = basalt.getMainFrame()

local btn = main:addButton()
    :setText("Standard Button")
    :setPosition(2, 2)

-- This will be loaded from disk or remote if available
local special = main:addSpecialButton()
    :setText("Special Button")
    :setPosition(2, 4)

basalt.run()
```

## Use Cases

### Remote Element Library

Load elements from a central repository:

```lua
local repository = "https://raw.githubusercontent.com/Basalt2/main/src/elements/"

elementManager.configure({allowRemoteLoading = true})
elementManager.registerRemoteSource("Chart", repository .. "Chart.lua")
elementManager.registerRemoteSource("DataGrid", repository .. "DataGrid.lua")
```

## Notes

- Remote loading requires HTTP API to be enabled in CC:Tweaked config
- Disk loading looks for `elements/` subfolder in the mount path
- Elements must follow Basalt's element structure
- Global cache persists across `basalt.run()` calls if not cleared
- Auto-loading tries disk mounts first, then remote sources

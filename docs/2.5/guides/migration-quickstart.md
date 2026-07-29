# Basalt 2 Migration Quickstart

Basalt 2.5 is a runtime rewrite, not a drop-in replacement. Migrate the
smallest running screen first, then replace removed systems one area at a
time. Use the [detailed migration reference](./migrating-from-basalt-2) only
when a specific API needs mapping.

## 1. Keep Both Versions

Back up the working Basalt 2 application or create a source-control branch.
Install 2.5 beside it:

```shell
wget run https://basalt.madefor.cc/2.5/install.lua minified basalt25.lua
```

Temporarily load:

```lua
local basalt = require("basalt25")
```

Do not overwrite the working Basalt 2 library until the port starts and its
main interactions work.

## 2. Keep Compatible Code

These patterns remain valid:

```lua
local frame = basalt.getMainFrame()

local button = frame:addButton({
    x = 2,
    y = 2,
    width = 12,
    text = "Save",
})

button:onClick(function()
    button.text = "Saved"
end)

basalt.run()
```

Generated setters such as `setText()`, `setPosition()`, and `setSize()` still
work. Do not rewrite them merely for style.

## 3. Replace the Major Differences

| Basalt 2 pattern | Basalt 2.5 direction |
| --- | --- |
| Main Frame | `basalt.getMainFrame()` |
| Additional terminal or monitor | `basalt.createFrame(terminal, name)` |
| Plugin/API loader | `basalt.use("module")` |
| Old layout strings/helpers | Numeric sizes, `auto`, `fill`, percent, Flex |
| Observed application values | `basalt.state()` and `basalt.computed()` |
| Old theme/plugin styling | State styles and the `theme` module |
| XML callbacks from globals | Explicit handler scope |
| Dynamically loaded custom elements | Built-in elements or a maintained 2.5 extension |

Load optional modules before using their elements:

```lua
local charts = basalt.use("charts")
local graph = frame:addPixelGraph({...})
```

## 4. Port One Screen at a Time

For each screen:

1. create its element tree;
2. replace removed element names or properties;
3. make fixed layout work before introducing Flex or reactive sizing;
4. reconnect events;
5. reconnect shared state;
6. test the screen with `basalt.update()` or run it directly;
7. move to the next screen.

Avoid migrating XML, themes, animations, and every screen simultaneously.

## 5. Check Common Renames and Behavior

- A root for another terminal comes from `basalt.createFrame()`, not a child
  Frame factory.
- Dropdown uses `dropHeight`; its runtime `height` changes while open.
- Collection `change` means selection movement; `select` means activation.
- Interaction states such as `hover`, `focused`, and `pressed` replace many
  manual color handlers.
- Signals assigned to visual properties invalidate dependent UI
  automatically.
- Canvas drawing receives a Render buffer, not a terminal.
- Program hosts another CC program and owns its lifecycle.

Consult the [detailed migration reference](./migrating-from-basalt-2) for
element maps, layout, scrolling, animation, charts, images, XML, and themes.

## Runnable 2.5 Port

```lua run title="Migrated settings screen"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

local enabled = basalt.state(false)
local statusText = basalt.computed(function()
    return enabled:get() and "Feature enabled" or "Feature disabled"
end)

local page = frame:addColumn({
    x = 2,
    y = 2,
    width = basalt.fill(),
    height = basalt.fill(),
    gap = 1,
    padding = 1,
    background = colors.gray,
})

page:addLabel({
    text = "Settings",
    foreground = colors.orange,
})

local toggle = page:addCheckbox({
    text = "Enable feature",
})

toggle:bind("checked", enabled, {
    twoWay = true,
    event = "change",
})

page:addLabel({
    text = statusText,
    foreground = function()
        return enabled:get() and colors.lime or colors.lightGray
    end,
})

page:addButton({
    width = 12,
    text = "Exit",
}):onClick(function()
    basalt.stop()
end)

basalt.run()
```

## Final Checklist

- The 2.5 library is installed separately during the port.
- Every optional module loads before its elements are created.
- Every display has one stable root and the application calls `run()` once.
- Removed plugin, layout, animation, XML, and custom-element behavior has an
  explicit replacement.
- Core flows work on the smallest supported terminal.
- Important interactions have non-blocking tests.
- The old library is removed only after the port is complete.

## Next Steps

Open the [detailed migration reference](./migrating-from-basalt-2) for the
specific subsystem that still needs conversion.

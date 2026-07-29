# Tabs

TabControl manages related views inside one panel. It draws one header row
and creates one persistent content Frame per tab.

## Create Tabs

```lua
local tabs = frame:addTabControl({
    x = 2,
    y = 2,
    width = 38,
    height = 12,
    background = colors.black,
    headerBackground = colors.gray,
    activeBackground = colors.blue,
    activeForeground = colors.white,
})

local general = tabs:addTab("General")
local display = tabs:addTab("Display")
```

Add controls to the returned Frames. The first tab becomes active
automatically.

## Switch and Observe

```lua
tabs:setActiveTab(2)

tabs:onChange(function(self, index, title)
    status.text = "Opened " .. title
end)
```

Read `tabs.active`, `tabs:getTabCount()`, and `tabs:getTab(index)`.
Assigning `active` updates visibility but does not fire `change`; prefer
`setActiveTab()` for navigation.

When a hidden tab releases focused children, focus a suitable control in the
new tab.

## Keyboard and Header Width

Left and Right switch tabs while TabControl itself owns focus. Child controls
receive those keys while they are focused.

Headers remain on one row. Keep their combined titles short enough for the
control width.

## Runnable Tabs

```lua run title="Persistent tabs"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

local status = frame:addLabel({
    x = 2,
    y = 1,
    width = 45,
    text = "General tab",
    foreground = colors.orange,
})

local tabs = frame:addTabControl({
    x = 2,
    y = 3,
    width = 47,
    height = 12,
    background = colors.black,
    headerBackground = colors.gray,
    activeBackground = colors.blue,
})

local general = tabs:addTab("General")
local display = tabs:addTab("Display")
local advanced = tabs:addTab("Advanced")

local name = general:addInput({
    x = 2,
    y = 3,
    width = 22,
    placeholder = "Computer name",
})

display:addCheckbox({
    x = 2,
    y = 3,
    text = "Compact mode",
})

advanced:addSlider({
    x = 2,
    y = 3,
    width = 24,
    min = 0,
    max = 100,
    value = 50,
})

local focusTargets = {
    name,
    display:getChildren()[1],
    advanced:getChildren()[1],
}

tabs:onChange(function(_, index, title)
    status.text = title .. " tab"
    if focusTargets[index] then focusTargets[index]:focus() end
end)

frame:addButton({
    x = 38,
    y = 16,
    width = 12,
    height = 2,
    text = "Exit",
    background = colors.red,
}):onClick(function()
    basalt.stop()
end)

name:focus()
basalt.run()
```

## Common Mistakes

- Do not rebuild tab content on every switch.
- Do not expect direct `active` assignment to fire `change`.
- Focus TabControl only when header arrow navigation is desired.
- Use page navigation instead of squeezing many long titles into one row.

## Related Guides and API

- [Page Navigation](./page-navigation)
- [Events and Focus](../foundations/events-and-focus)
- [`TabControl`](/api/elements/TabControl)

## Next Steps

Combine [Page Navigation](./page-navigation) for major routes with Tabs for
related settings or detail views.

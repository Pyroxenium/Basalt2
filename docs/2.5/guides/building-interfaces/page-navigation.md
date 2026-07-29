# Page Navigation

Use overlapping child Frames for major application routes such as Dashboard,
Jobs, and Settings. Build each page once, then switch visibility.

## Build Persistent Pages

```lua
local content = frame:addFrame({
    x = 14,
    y = 2,
    width = 36,
    height = 17,
})

local homePage = content:addFrame({
    width = basalt.percent(1),
    height = basalt.percent(1),
})

local settingsPage = content:addFrame({
    width = basalt.percent(1),
    height = basalt.percent(1),
    visible = false,
})
```

Switch them through one function:

```lua
local pages = { homePage, settingsPage }

local function showPage(index)
    for pageIndex, page in ipairs(pages) do
        page.visible = pageIndex == index
    end
end
```

Hiding a page preserves Input text, selection, scroll position, and handlers.
Destroy it only when it will not return.

## Focus and Active Styling

Hidden subtrees release focus. Move focus to a useful destination:

```lua
local defaultFocus = { homeSearch, settingsName }

local function showPage(index)
    for pageIndex, page in ipairs(pages) do
        page.visible = pageIndex == index
    end
    if defaultFocus[index] then defaultFocus[index]:focus() end
end
```

Update page visibility and navigation styling together so they cannot
disagree.

## Reactive Route

```lua
local currentPage = basalt.state(1)

currentPage:subscribe(function(index)
    if pages[index] then showPage(index) end
end, true)
```

Every navigation control can now call `currentPage:set(index)`.

## Runnable Sidebar

```lua run title="Persistent page navigation"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

local currentPage = basalt.state(1)

local nav = frame:addFrame({
    x = 1,
    y = 1,
    width = 13,
    height = basalt.fill(),
    background = colors.gray,
})

local content = frame:addFrame({
    x = 14,
    y = 1,
    width = basalt.fill(),
    height = basalt.fill(),
    background = colors.black,
})

local home = content:addFrame({
    width = basalt.percent(1),
    height = basalt.percent(1),
    background = colors.black,
})

home:addLabel({
    x = 2,
    y = 2,
    text = "Dashboard",
    foreground = colors.orange,
})

local search = home:addInput({
    x = 2,
    y = 5,
    width = 22,
    placeholder = "Search",
})

local settings = content:addFrame({
    width = basalt.percent(1),
    height = basalt.percent(1),
    background = colors.black,
    visible = false,
})

settings:addLabel({
    x = 2,
    y = 2,
    text = "Settings",
    foreground = colors.orange,
})

local name = settings:addInput({
    x = 2,
    y = 5,
    width = 22,
    placeholder = "Computer name",
})

local pages = { home, settings }
local focusTargets = { search, name }
local buttons = {}

local function showPage(index)
    for i, page in ipairs(pages) do page.visible = i == index end
    for i, button in ipairs(buttons) do
        button.background = i == index and colors.blue or colors.gray
    end
    focusTargets[index]:focus()
end

buttons[1] = nav:addButton({
    x = 2,
    y = 3,
    width = 10,
    height = 2,
    text = "Home",
}):onClick(function()
    currentPage:set(1)
end)

buttons[2] = nav:addButton({
    x = 2,
    y = 7,
    width = 10,
    height = 2,
    text = "Settings",
}):onClick(function()
    currentPage:set(2)
end)

nav:addButton({
    x = 2,
    y = 15,
    width = 10,
    height = 2,
    text = "Exit",
    background = colors.red,
}):onClick(function()
    basalt.stop()
end)

currentPage:subscribe(showPage, true)
basalt.run()
```

## Related Guides and API

- [Tabs](./tabs)
- [Reactive State](../foundations/reactive-state)
- [`Frame`](/api/elements/Frame)

## Next Steps

Use [Tabs](./tabs) for related views inside one page.

# Lists and Selection

List displays several rows at once. It is the best collection control for
inventories, menus, queues, and search results where users benefit from
seeing surrounding choices.

## Items

Strings become CollectionEntry values automatically:

```lua
local list = frame:addList({
    x = 2,
    y = 2,
    width = 24,
    height = 8,
    items = { "Iron", "Gold", "Diamond" },
})
```

Use tables when display text and application values differ:

```lua
list:addItem({
    text = "Iron Ingot",
    value = "minecraft:iron_ingot",
    fg = colors.lightGray,
})
```

Useful item fields include `text`, `value`, `disabled`, `selectable`, `fg`,
`bg`, selection colors, and `callback`.

## Change the Collection

```lua
local entry = list:addItem("Copper")
list:insertItem(2, "Coal")
list:removeItem(1)
list:setItems({ "One", "Two", "Three" })
list:clear()
```

Entry properties are live:

```lua
entry.text = "Copper Ingot"
entry.disabled = true
```

Do not mutate `list.items` directly. Use the collection methods so selection
and rendering remain consistent.

## Selection and Activation

Selection moves the current cursor. Activation represents accepting that
item, such as double-clicking or pressing Enter.

```lua
list:onChange(function(self, index, item, oldIndex)
    status.text = item and "Selected: " .. item.text or "Nothing selected"
end)

list:onSelect(function(self, index, item)
    status.text = "Activated: " .. item.value
end)
```

Select in code:

```lua
list:selectItem(2)
list:activateItem(2)
list:clearSelection()
```

Read the current entry:

```lua
local item = list:getSelectedItem()
local index = list:getSelectedIndex()
```

The `select` event is activation, not every selection change. Observe
`change` for cursor movement.

## Multiple Selection

```lua
list.multiSelection = true
list:selectItem(1)
list:selectItem(3)

local indices = list:getSelectedIndices()
local items = list:getSelectedItems()
```

The singular getters return the first selection. Keep Dropdown and ComboBox
in single-selection mode.

## Scrolling and Keyboard

List supports the mouse wheel, scrollbars, and Up, Down, Home, End, Page Up,
Page Down, and Enter.

```lua
list.scrollbar = "auto"
list:scrollToItem(10)
list:scrollToTop()
list:scrollToBottom()
```

## Runnable Example

```lua run title="List selection"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

frame:addLabel({
    x = 2,
    y = 1,
    text = "Resource queue",
    foreground = colors.orange,
})

local status = frame:addLabel({
    x = 28,
    y = 3,
    width = 21,
    height = 4,
    text = "Select a resource",
    foreground = colors.lightGray,
})

local list = frame:addList({
    x = 2,
    y = 3,
    width = 22,
    height = 11,
    scrollbar = "auto",
    items = {
        { text = "Iron", value = "iron", fg = colors.lightGray },
        { text = "Gold", value = "gold", fg = colors.yellow },
        { text = "Copper", value = "copper", fg = colors.orange },
        { text = "Redstone", value = "redstone", fg = colors.red },
        { text = "Diamond", value = "diamond", fg = colors.cyan },
    },
})

list:onChange(function(_, index, item)
    status.text = item
        and ("Selected #" .. index .. "\n" .. item.text)
        or "Nothing selected"
end)

list:onSelect(function(_, _, item)
    status.text = "Activated\n" .. tostring(item.value)
    status.foreground = colors.lime
end)

frame:addButton({
    x = 28,
    y = 9,
    width = 12,
    height = 2,
    text = "Add item",
}):onClick(function()
    list:addItem("Quartz #" .. (#list.items + 1))
end)

frame:addButton({
    x = 28,
    y = 13,
    width = 12,
    height = 2,
    text = "Exit",
    background = colors.red,
}):onClick(function()
    basalt.stop()
end)

list:selectItem(1)
list:focus()
basalt.run()
```

## Reactive Sources

Collection items need normalization, so subscribe instead of assigning a
Signal directly:

```lua
local available = basalt.state({ "Iron", "Gold" })

local unsubscribe = available:subscribe(function(items)
    list:setItems(items)
end, true)
```

## Related Guides and API

- [Dropdowns and Suggestions](./dropdowns-and-suggestions)
- [Tables and Trees](./tables-and-trees)
- [`List`](/api/elements/List)
- [`collection`](/api/core/collection)

## Next Steps

Use [Dropdowns and Suggestions](./dropdowns-and-suggestions) when the
selection must occupy only one row or accept typed text.

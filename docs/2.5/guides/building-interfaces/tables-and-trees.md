# Tables and Trees

Tables and Trees present structured data in two different ways:

- `Table` displays records in sortable columns;
- `Tree` displays hierarchical nodes that expand and collapse.

Both controls support selection, activation, keyboard navigation, scrolling,
and the shared scrollbar modes. Their data models are deliberately different,
however: a Table selects a stable row index, while a Tree selects the node
table itself.

## Choosing the Right Control

| Control | Best for | Selected value |
| --- | --- | --- |
| `Table` | Inventories, jobs, metrics, and comparable records | Index into `data` |
| `Tree` | Files, categories, nested menus, and scene hierarchies | The node table |
| `List` | One-dimensional choices and actions | `CollectionEntry` |

Use a Table when columns help users compare values. Use a Tree when the
parent-child relationship is part of the information. A common application
combines both: a Tree chooses a category and a Table shows its records.

## Building a Table

Define the columns and data rows when creating the element:

```lua
local inventory = frame:addTable({
    x = 2,
    y = 2,
    width = 38,
    height = 9,
    columns = {
        { title = "Item" },
        { title = "Count", width = 7 },
        { title = "Area", width = 10 },
    },
    data = {
        { "Iron ingot", 64, "Storage" },
        { "Wheat", 32, "Farm" },
        { "Diamond", 5, "Vault" },
    },
})
```

Each row is an ordinary array. Cell one belongs to column one, cell two to
column two, and so on. Additional cells are allowed but are not rendered when
there is no matching column.

### Column widths

A column can use:

- a numeric width in terminal cells;
- a percentage such as `"35%"`;
- no width, in which case it shares the remaining space.

```lua
columns = {
    { title = "Name", minWidth = 8 },
    { title = "Progress", width = "35%", minWidth = 10 },
    { title = "State", width = 9, maxWidth = 12 },
}
```

The one-cell gaps between columns are subtracted before widths are resolved.
Fixed and percentage columns are allocated first. Columns without a width
divide the remaining space.

`minWidth` defaults to one. `maxWidth` limits a resolved fixed, percentage, or
automatic width.

A string is shorthand for a fixed column:

```lua
columns = { "Name", "Count" }
```

This creates titles and names with widths based on the title length. Use full
column tables when a column should absorb free space.

Inspect a layout without changing the Table:

```lua
local resolved = inventory:calculateColumnWidths(
    inventory.columns,
    inventory.width
)

for index, column in ipairs(resolved) do
    print(index, column.visibleWidth)
end
```

## Adding and Updating Rows

Append either individual cell values or one row table:

```lua
inventory:addRow("Gold ingot", 24, "Storage")
inventory:addRow({ "Carrot", 18, "Farm" })
```

Read and update a stable data row:

```lua
local row = inventory:getRow(1)
print(row[1], row[2])

inventory:updateCell(1, 2, 63)
```

`updateCell()` redraws the element and rebuilds a sorted view when the changed
column affects ordering. Prefer it over mutating `inventory.data[index]`
directly.

Remove or clear data:

```lua
inventory:removeRow(2)
inventory:clearData()
```

Removing a row adjusts later selection indices. Removing the selected row
clears selection and fires `change`.

### Formatting display values

`setData()` can format individual columns:

```lua
inventory:setData({
    { "Iron ingot", 64, "Storage" },
    { "Diamond", 5, "Vault" },
}, {
    [2] = function(value)
        return value .. "x"
    end,
})
```

The second column displays `64x` and `5x`, but sorting that column still uses
the original numeric values. This avoids the lexical order where `64x` could
sort before `5x`.

## Sorting Tables

`sortable` is enabled by default. Clicking a header sorts ascending; clicking
the same header again reverses the direction. The active header shows an
arrow.

Sort explicitly:

```lua
inventory:sortBy(2, false)
```

The arguments mean column two, descending. Omitting the direction toggles it:

```lua
inventory:sortBy(2)
```

Sorting changes only the display order. It never reorders `inventory.data`,
and `selected` remains an index into that original data table.

```lua
inventory:onSort(function(self, columnIndex, ascending)
    print("Sorted column", columnIndex, ascending and "asc" or "desc")
end)
```

Disable header sorting when headers are informational:

```lua
inventory.sortable = false
```

### Custom sorting

Numbers sort numerically. Other values are converted with `tostring()` and
sorted lexically.

Provide a value comparator when a column needs application-specific order:

```lua
local rank = {
    offline = 1,
    idle = 2,
    running = 3,
}

inventory:setColumnSort(3, function(a, b, ascending)
    local left = rank[a] or 0
    local right = rank[b] or 0

    if ascending then
        return left < right
    end
    return left > right
end)
```

The comparator also receives both complete rows as its fourth and fifth
arguments when a tie-breaker needs other columns.

## Table Selection and Activation

A Table distinguishes selection changes from activation:

```lua
inventory:onChange(function(self, index, row, oldIndex, oldRow)
    if row then
        print("Current row:", index, row[1])
    end
end)

inventory:onSelect(function(self, index, row)
    print("Activated:", row[1])
end)
```

Mouse clicks select and activate a row. Keyboard Up, Down, Home, and End
change selection without activation. Enter activates the current row.

Select by the stable data index:

```lua
inventory:select(3)
local row = inventory:getSelectedRow()
```

Pass `false` as the second argument to suppress only the `select` event:

```lua
inventory:select(3, false)
```

The `change` event still fires when the selected row changes.

`rowSelect` is a Basalt 2 compatibility event with the same arguments as
`select`. New 2.5 code can normally use `select`.

## Building a Tree

Tree nodes are plain tables:

```lua
local nodes = {
    {
        text = "Computer",
        expanded = true,
        children = {
            {
                text = "rom",
                children = {
                    { text = "programs" },
                    { text = "startup.lua" },
                },
            },
            { text = "basalt.lua" },
        },
    },
}

local files = frame:addTree({
    x = 2,
    y = 2,
    width = 24,
    height = 10,
    nodes = nodes,
})
```

The supported structural fields are:

| Field | Purpose |
| --- | --- |
| `text` | Display value, converted with `tostring()` |
| `children` | Array of child nodes |
| `expanded` | Whether children are currently visible |

Add any application fields you need:

```lua
local node = {
    text = "Logs",
    path = "/var/log",
    kind = "directory",
    children = {},
}
```

The Tree keeps this same table as its selected value. There is no wrapper or
separate node index.

When a new `nodes` table is assigned, selection and both scroll offsets reset.
If the first root has children and does not define `expanded`, Basalt expands
that first root automatically.

## Expansion

Click the `+` or `-` marker to toggle a branch:

```lua
files:toggle(node)
files:expandNode(node)
files:collapseNode(node)
```

Listen for an individual toggle:

```lua
files:onToggle(function(self, changedNode, expanded)
    print(changedNode.text, expanded and "opened" or "closed")
end)
```

Expand or collapse the complete hierarchy:

```lua
files:expandAll()
files:collapseAll()
```

These bulk methods redraw the Tree but do not fire one `toggle` event for
every branch.

Expansion state is stored directly as `node.expanded`. Mutating that field
manually does not request a redraw; use the Tree methods.

### Saving expansion state

Capture expanded nodes as a set:

```lua
local expanded = files:getExpandedNodes()
-- expanded[node] is true for every open node
```

Restore that state later:

```lua
files:setExpandedNodes(expanded)
```

The set is keyed by node-table identity. It works while the same node objects
remain in use. If application code rebuilds the hierarchy with new tables,
store stable IDs and reconstruct the set for the new nodes instead.

## Tree Selection and Keyboard Control

Clicking a node's text selects and activates it. Clicking its marker only
toggles expansion.

```lua
files:onChange(function(self, node, oldNode)
    print("Current node:", node and node.text or "<none>")
end)

files:onSelect(function(self, node)
    print("Activated:", node.text)
end)
```

When focused, a Tree supports:

- Up and Down to change the current node;
- Right to expand a branch or enter its first child;
- Left to collapse a branch or return to its parent;
- Enter to activate the current node.

Arrow navigation fires `change` but waits for Enter before firing `select`.

Select a node reference programmatically:

```lua
files:setSelectedNode(nodes[1])
local selected = files:getSelectedNode()
```

Call `files:select(node)` when programmatic selection should also emit
`select`.

## Scrolling

Both controls support:

```lua
scrollbar = "auto" -- "auto", "always", or "hidden"
scrollbarColor = colors.gray
scrollbarThumbColor = colors.lightGray
```

The scrollbar occupies the final column when visible. Mouse-wheel movement,
selection, and scrollbar dragging keep the vertical offset clamped.

A deeply indented Tree can be shifted horizontally:

```lua
local contentWidth, visibleNodes = files:getNodeSize()
files:setHorizontalOffset(5)
```

`getNodeSize()` measures only currently visible nodes. Collapsed descendants
do not contribute.

## Complete Inventory Browser

This example uses a Tree as a category filter and a sortable Table for
inventory records. Open both branches, click headers, and navigate with the
keyboard.

```lua run title="Table and Tree inventory"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = basalt.rgb("#14161b")

frame:addLabel({
    x = 2,
    y = 1,
    text = "Inventory browser",
    foreground = colors.orange,
})

local rows = {
    { "Iron ingot", 64, "Metals" },
    { "Gold ingot", 24, "Metals" },
    { "Copper ingot", 48, "Metals" },
    { "Diamond", 5, "Gems" },
    { "Emerald", 11, "Gems" },
    { "Coal", 96, "Gems" },
    { "Wheat", 32, "Crops" },
    { "Carrot", 18, "Crops" },
    { "Potato", 27, "Crops" },
    { "Bread", 12, "Food" },
    { "Apple", 7, "Food" },
    { "Steak", 9, "Food" },
}

local nodes = {
    {
        text = "All inventory",
        expanded = true,
        children = {
            {
                text = "Storage",
                areas = { Metals = true, Gems = true },
                children = {
                    { text = "Metals", area = "Metals" },
                    { text = "Gems", area = "Gems" },
                },
            },
            {
                text = "Farm",
                areas = { Crops = true, Food = true },
                children = {
                    { text = "Crops", area = "Crops" },
                    { text = "Food", area = "Food" },
                },
            },
        },
    },
}

local tree = frame:addTree({
    x = 2,
    y = 3,
    width = 16,
    height = 11,
    nodes = nodes,
    selectionBackground = colors.orange,
    selectionForeground = colors.black,
})

local items = frame:addTable({
    x = 19,
    y = 3,
    width = 31,
    height = 11,
    columns = {
        { title = "Item", minWidth = 10 },
        { title = "Qty", width = 6 },
        { title = "Area", width = 8 },
    },
    selectionBackground = colors.blue,
})

local status = frame:addLabel({
    x = 2,
    y = 15,
    width = 48,
    text = "Choose a category or inventory row.",
    foreground = colors.lightGray,
})

local function rowsFor(node)
    local filtered = {}
    for _, row in ipairs(rows) do
        if not node.area and not node.areas
            or node.area == row[3]
            or node.areas and node.areas[row[3]]
        then
            filtered[#filtered + 1] = row
        end
    end
    return filtered
end

tree:onChange(function(self, node)
    if not node then return end
    items:setData(rowsFor(node))
    status.text = "Showing: " .. node.text
end)

tree:onSelect(function(self, node)
    status.text = "Opened category: " .. node.text
end)

items:onChange(function(self, index, row)
    if row then
        status.text = row[1] .. ": " .. row[2] .. " in " .. row[3]
    end
end)

items:onSort(function(self, column, ascending)
    status.text = "Sorted column " .. column
        .. (ascending and " ascending" or " descending")
end)

frame:addButton({
    x = 2,
    y = 17,
    width = 10,
    text = "Expand",
}):onClick(function()
    tree:expandAll()
end)

frame:addButton({
    x = 14,
    y = 17,
    width = 10,
    text = "Collapse",
}):onClick(function()
    tree:collapseAll()
end)

frame:addButton({
    x = 40,
    y = 17,
    width = 10,
    text = "Exit",
}):onClick(function()
    basalt.stop()
end)

tree:setSelectedNode(nodes[1])
tree:focus()
basalt.run()
```

The Tree's application-specific `area` and `areas` fields drive filtering.
The Table receives new display rows through `setData()`, while sorting and
selection continue to use stable indices within that filtered data set.

## Common Mistakes

### Treating a sorted Table index as a display position

`selected` and event indices refer to `data`, not the current visible row
number. Read the row with `getRow(index)`.

### Mutating Table cells directly

Direct changes do not invalidate the sorted view. Use `updateCell()` or
replace the data through `setData()`.

### Giving every column a fixed width

Unused or clipped space becomes harder to manage. Leave at least one column
without `width` when it should adapt to the Table.

### Rebuilding Tree nodes and expecting references to survive

Selection and expanded-node sets use node-table identity. Preserve node
objects or map stable application IDs onto the rebuilt hierarchy.

### Changing `node.expanded` directly

The Tree will not automatically redraw or clamp its viewport. Use `toggle()`,
`expandNode()`, or `collapseNode()`.

### Using only `select` for previews

Arrow-key navigation changes selection without activation. Use `change` for
live previews and `select` for confirmed actions.

### Forgetting the header row

A Table with `height = 8` displays one header plus at most seven data rows.

## Related API

- [`Table`](/api/elements/Table)
- [`Tree`](/api/elements/Tree)
- [`itemview`](/api/core/itemview)
- [Lists and Selection](./lists-and-selection)
- [Events and Focus](../foundations/events-and-focus)
- [Layout Basics](../foundations/layout-basics)

## Next Steps

Continue with [Page Navigation](./page-navigation) to connect selected
records and hierarchy nodes to persistent detail pages.

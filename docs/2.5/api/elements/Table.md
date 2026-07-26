# Table

*extends Element*

Table: column headers + data rows, click-to-sort, row selection.

columns = { { title = "Name", width = 8 }, { title = "Qty" } }
  (columns without width share the remaining space)
data = { { "Wheat", 12 }, { "Iron", 3 } }

Sorting never mutates `data`: a view order maps display rows to data
indices. `selected` is always a DATA index. Fires "select"(dataIndex, row)
and "sort"(columnIndex, ascending).

## Types

### `TableSortDirection`

```lua
TableSortDirection = "asc"|"desc"
```

### `TableRow`

```lua
TableRow = any[]
```

### `TableValueComparator`

```lua
TableValueComparator = fun(a: any, b: any, ascending: boolean, rowA: TableRow, rowB: TableRow): boolean
```

### `TableRowComparator`

```lua
TableRowComparator = fun(rowA: TableRow, rowB: TableRow, direction: TableSortDirection): boolean
```

### `TableFormatter`

```lua
TableFormatter = fun(value: any): any
```

### `TableColumn`

| Field | Type | Description |
| --- | --- | --- |
| title *(optional)* | `string` | Header title |
| name *(optional)* | `string` | Column name |
| width *(optional)* | `number\|string` | Fixed or percentage width |
| minWidth *(optional)* | `number` | Minimum width |
| maxWidth *(optional)* | `number` | Maximum width |

### `TableCalculatedColumn`

| Field | Type | Description |
| --- | --- | --- |
| name *(optional)* | `string` | Column name |
| width *(optional)* | `number\|string` | Requested width |
| visibleWidth | `number` | Resolved width |

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| columns | `TableColumn[]` | `false` | Column definitions: { { title, width?, minWidth?, maxWidth? }, ... } |
| data | `TableRow[]` | `false` | Row data: list of cell-value lists; never mutated by sorting |
| selected | `integer\|false` | `false` | Selected DATA row index, or false |
| offset | `number` | `0` | Scroll offset of the row viewport |
| sortable | `boolean` | `true` | Header clicks sort the view |
| sortColumn | `integer\|false` | `false` | Currently sorted column index, or false |
| sortDirection | `TableSortDirection` | `"asc"` | "asc" or "desc" |
| background | `number\|false` | `colors.black` | Background color (false = transparent) |
| headerBackground | `number` | `colors.gray` | Header row background |
| gridColor | `number` | `colors.gray` | Color of the column gap / grid lines |
| selectionBackground | `number` | `colors.blue` | Background of selected entries |
| selectionForeground | `number` | `colors.white` | Text color of selected entries |
| width | `number` | `26` | Width in terminal cells |
| height | `number` | `8` | Height in terminal cells |
| scrollbar | `ItemViewScrollbarMode` | `"auto"` | "auto", "always" or "hidden" |
| scrollbarColor | `number` | `colors.gray` | Scrollbar track color |
| scrollbarThumbColor | `number` | `colors.lightGray` | Scrollbar thumb color |
| scrollBarSymbol | `string` | `" "` | Basalt2 compat: scrollbar thumb symbol |
| scrollBarBackground | `string` | `"\127"` | Basalt2 compat: scrollbar track symbol |

## Events

| Event | Registrar | Description |
| --- | --- | --- |
| select | :onSelect(fn) | Fired on item selection with (index, item) |
| rowSelect | :onRowSelect(fn) | Fired on row selection, with (dataIndex, row) - Basalt2 compat |
| change | :onChange(fn) | Fired when the value changes |
| sort | :onSort(fn) | Fired after sorting, with (columnIndex, ascending) |

## Methods

### Table:sortBy(columnIndex, ascending)

Sorts the display order by a column; repeating flips the direction.
The data table itself is never mutated.

- **columnIndex** (`integer`) The column to sort by
- **ascending** (`boolean`, optional) Explicit direction, nil = toggle

- **returns** (`self`) 

### Table:select(dataIndex, emit)

Selects a row by its DATA index and scrolls it into view.

- **dataIndex** (`integer|false`) The data row index, or false to clear
- **emit** (`boolean`, optional) false suppresses the select event

- **returns** (`self`) 

### Table:addRow(...)

Appends a row: either one table or the cell values as arguments.

- **...** (`any`) Cell values, or one TableRow

- **returns** (`self`) 

```lua
tbl:addRow("Wheat", 12)  -- or tbl:addRow({ "Wheat", 12 })
```

### Table:removeRow(dataIndex)

Removes a data row; the selection index is kept consistent.

- **dataIndex** (`integer`) The data row index

- **returns** (`self`) 

### Table:getRow(dataIndex)

Returns one row by stable data index.

- **dataIndex** (`integer`) Data index

- **returns** **row** (`TableRow|nil`) 

### Table:updateCell(dataIndex, columnIndex, value)

Changes one cell; a sorted view re-sorts automatically.

- **dataIndex** (`integer`) The data row index
- **columnIndex** (`integer`) The column index
- **value** (`any`) The new cell value

- **returns** (`self`) 

### Table:setColumnSort(columnIndex, fn)

Registers a value comparator receiving valueA, valueB and ascending.

- **columnIndex** (`integer`) Column index
- **fn** (`TableValueComparator`, optional) Value comparator

- **returns** (`self`) 

### Table:setColumnSortFunction(columnIndex, fn)

Registers a Basalt2-style row comparator for one column.

- **columnIndex** (`integer`) Column index
- **fn** (`TableRowComparator`, optional) Comparator receiving rowA, rowB and direction

- **returns** (`self`) 

### Table:sortByColumn(columnIndex, fn)

Sorts the table view without mutating the underlying data order.

- **columnIndex** (`integer`) Column index
- **fn** (`TableRowComparator`, optional) Optional Basalt2-style row comparator

- **returns** (`self`) 

### Table:setSortColumn(columnIndex)

Selects the active sort column, or clears sorting with false/nil.

- **columnIndex** (`integer|false`, optional) Column index

- **returns** (`self`) 

### Table:setSortDirection(direction)

Sets the active sort direction.

- **direction** (`TableSortDirection`) Direction

- **returns** (`self`) 

### Table:getSelectedRow()

Returns the selected row using its stable data index.

- **returns** **row** (`TableRow|nil`) 

### Table:clearData()

Removes all rows and clears selection/scroll state.

- **returns** (`self`) 

### Table:addColumn(name, width)

Appends a named column definition.

- **name** (`string`) Header label
- **width** (`number|string`, optional) Fixed, percent or "auto" width

- **returns** (`self`) 

### Table:setData(rawData, formatters)

Replaces all rows and optionally formats individual columns for display.

- **rawData** (`TableRow[]`) Source rows
- **formatters** (`table<integer, TableFormatter>`, optional) Column formatter map

- **returns** (`self`) 

### Table:calculateColumnWidths(columns, totalWidth)

Resolves fixed, percent and automatic column widths.

- **columns** (`(string|TableColumn)[]`) Column definitions
- **totalWidth** (`number`) Available width

- **returns** **columns** (`TableCalculatedColumn[]`) Definitions containing visibleWidth

### Table:setHeaderColor(color)

Sets the table header background color.

- **color** (`number`) Color value

- **returns** (`self`) 

### Table:getHeaderColor()

Returns the table header background color.

- **returns** **color** (`number`) 

### Table:setSelectedForeground(color)

Sets selected-row foreground color.

- **color** (`number`) Color value

- **returns** (`self`) 

### Table:getSelectedForeground()

Returns selected-row foreground color.

- **returns** **color** (`number`) 

### Table:setSelectedBackground(color)

Sets selected-row background color.

- **color** (`number`) Color value

- **returns** (`self`) 

### Table:getSelectedBackground()

Returns selected-row background color.

- **returns** **color** (`number`) 

### Table:setSelectionColor(foreground, background)

Sets selected-row foreground and background colors.

- **foreground** (`number`) Foreground color
- **background** (`number`) Background color

- **returns** (`self`) 

### Table:getSelectionColor()

Returns selected-row foreground and background colors.

- **returns** **foreground** (`number`) 
- **returns** **background** (`number`) 

### Table:setShowScrollBar(show)

Enables or hides the table scrollbar.

- **show** (`boolean`) Whether the bar may be shown

- **returns** (`self`) 

### Table:getShowScrollBar()

Returns whether the table scrollbar is enabled.

- **returns** **enabled** (`boolean`) 

### Table:setScrollBarColor(color)

Sets the scrollbar thumb color.

- **color** (`number`) Color value

- **returns** (`self`) 

### Table:getScrollBarColor()

Returns the scrollbar thumb color.

- **returns** **color** (`number`) 

### Table:setScrollBarBackgroundColor(color)

Sets the scrollbar track color.

- **color** (`number`) Color value

- **returns** (`self`) 

### Table:getScrollBarBackgroundColor()

Returns the scrollbar track color.

- **returns** **color** (`number`) 

### Table:clear()

Clears all rows, selection, sorting view and scroll state.

- **returns** (`self`) 

### Table:setup()

Initializes per-instance state and input handlers.

### Table:handleMouse(event, btn, x, y)

Routes mouse input in local coordinates (wheel scrolling etc.).

- **event** (`string`) The mouse event name
- **btn** (`number`) Button or scroll direction
- **x** (`number`) Local x coordinate
- **y** (`number`) Local y coordinate

- **returns** **consumer** (`Element|nil`) The consuming element, or nil to pass through

### Table:handleKey(event, a, b)

Handles keyboard input while focused.

- **event** (`string`) The key event name (key, key_up, char, paste)
- **a** (`any`) Key code or typed text
- **b** (`any`, optional) Secondary key-event value

### Table:measure()

Intrinsic size for basalt.auto().

- **returns** **width** (`number`) The measured width
- **returns** **height** (`number`) The measured height

### Table:render(buf)

Renders the element into the buffer.

- **buf** (`Render`) The render buffer (local coordinates, pre-clipped)

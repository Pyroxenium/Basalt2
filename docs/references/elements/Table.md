# Table
_This is the table class. It provides a sortable data grid with customizable columns, row selection, and scrolling capabilities. Built on Collection for consistent item management._

Extends: `Collection`

## Usage
```lua
local people = container:addTable():setWidth(40)
```

```lua
people:setColumns({{name="Name",width=12}, {name="Age",width=10}, {name="Country",width=15}})
```

```lua
people:addRow("Alice", 30, "USA"):addRow("Bob", 25, "UK")
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|columns|table|{}|List of column definitions with {name, width} properties|
|headerColor|color|blue|Color of the column headers|
|gridColor|color|gray|Color of grid lines|
|sortDirection|string|"asc"|Sort direction ("asc" or "desc")|
|customSortFunction|table|{}|Custom sort functions for columns|
|offset|number|0|Scroll offset for vertical scrolling|
|showScrollBar|boolean|true|Whether to show the scrollbar when items exceed height|
|scrollBarSymbol|string|"|" Symbol used for the scrollbar handle|
|scrollBarBackground|string|"\127"|Symbol used for the scrollbar background|
|scrollBarColor|color|lightGray|Color of the scrollbar handle|
|scrollBarBackgroundColor|color|gray|Background color of the scrollbar|

## Events

|Event|Parameters|Description|
|---|---|---|
|onRowSelect|`rowIndex number, row table`|Fired when a row is selected|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Table:addRow](#table-addrow-any)|Table|Adds a new row with cell values|
|[Table:removeRow](#table-removerow-rowindex)|Table|Removes a row at the specified index|
|[Table:getRow](#table-getrow-rowindex)|row|Gets the row data at the specified index|
|[Table:updateCell](#table-updatecell-rowindex-colindex-value)|Table|Updates a cell value at row and column|
|[Table:getSelectedRow](#table-getselectedrow)|row|Gets the currently selected row data|
|[Table:clearData](#table-cleardata)|Table|Removes all rows from the table|
|[Table:addColumn](#table-addcolumn-name-width)|Table|Adds a new column to the table|
|[Table:setColumnSortFunction](#table-setcolumnsortfunction-columnindex-sortfn)|Table|Sets a custom sort function for a column|
|[Table:setData](#table-setdata-rawdata-formatters)|Table|Sets table data with optional column formatters|
|[Table:getData](#table-getdata)|table|Gets all rows as array of cell arrays|
|[Table:sortByColumn](#table-sortbycolumn-columnindex-fn)|Table|Sorts the table data by the specified column|
|[Table:onRowSelect](#table-onrowselect-callback)|Table|Registers a callback when a row is selected|

## Table:addRow(any)

Adds a new row to the table

### Parameters
* `any` `The` cell values for the new row

### Returns
* `Table` `self` The Table instance

### Usage
```lua
table:addRow("Alice", 30, "USA")
```

## Table:removeRow(rowIndex)

Removes a row by index

### Parameters
* `rowIndex` `number` The index of the row to remove

### Returns
* `Table` `self` The Table instance

## Table:getRow(rowIndex)

Gets a row by index

### Parameters
* `rowIndex` `number` The index of the row

### Returns
* `row` `The` row data or nil

## Table:updateCell(rowIndex, colIndex, value)

Updates a specific cell value

### Parameters
* `rowIndex` `number` The row index
* `colIndex` `number` The column index
* `value` `any` The new value

### Returns
* `Table` `self` The Table instance

## Table:getSelectedRow()

Gets the currently selected row

### Returns
* `row` `The` selected row or nil

## Table:clearData()

Clears all table data

### Returns
* `Table` `self` The Table instance

## Table:addColumn(name, width)

Adds a new column to the table

### Parameters
* `name` `string` The name of the column
* `width` `number|string` The width of the column (number, "auto", or "30%")

### Returns
* `Table` `self` The Table instance

## Table:setColumnSortFunction(columnIndex, sortFn)

Sets a custom sort function for a specific column

### Parameters
* `columnIndex` `number` The index of the column
* `sortFn` `function` Function that takes (rowA, rowB) and returns comparison result

### Returns
* `Table` `self` The Table instance

## Table:setData(rawData, formatters)

Set data with automatic formatting

### Parameters
* `rawData` `table` The raw data array (array of row arrays)
* `formatters` `table` ? Optional formatter functions for columns {[2] = function(value) return value end}

### Returns
* `Table` `self` The Table instance

### Usage
```lua
table:setData({{...}}, {[1] = tostring, [2] = function(age) return age.."y" end})
```

## Table:getData()

Gets all table data

### Returns
* `table` `data` Array of row cell arrays

## Table:sortByColumn(columnIndex, fn)

Sorts the table data by column

### Parameters
* `columnIndex` `number` The index of the column to sort by
* `fn` `function` ? Optional custom sorting function

### Returns
* `Table` `self` The Table instance

## Table:onRowSelect(callback)

Registers callback for row selection

### Parameters
* `callback` `function` The callback function(rowIndex, row)

### Returns
* `Table` `self` The Table instance

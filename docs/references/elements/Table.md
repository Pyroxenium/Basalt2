# Table : VisualElement
This is the table class. It provides a sortable data grid with customizable columns,
row selection, and scrolling capabilities.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|columns|table|{}|List of column definitions with {name, width} properties
|data|table|{}|The table data as array of row arrays
|selectedRow|number?|nil|Currently selected row index
|headerColor|color|blue|Color of the column headers
|selectedColor|color|lightBlue|Background color of selected row
|gridColor|color|gray|Color of grid lines
|sortColumn|number?|nil|Currently sorted column index
|sortDirection|string|"asc"|Sort direction ("asc" or "desc")
|scrollOffset|number|0|Current scroll position

## Functions

|Method|Returns|Description|
|---|---|---|
|[Table:sortData](#table-sortdata)|Table|Sorts the table data by the specified column


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|Table:init|Table|Initializes the Table instance
|Table:mouse_click|boolean|Handles header clicks for sorting and row selection
|Table:mouse_scroll|boolean|Handles scrolling through the table data
|Table:render|-|Renders the table with headers, data and scrollbar

## Table:sortData(columnIndex)
Sorts the table data by column

### Parameters
* `columnIndex` `number` The index of the column to sort by

### Returns
* `Table` `self` The Table instance



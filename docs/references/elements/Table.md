# Table
_This is the table class. It provides a sortable data grid with customizable columns,_
_row selection, and scrolling capabilities._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|columns|table|{}|List of column definitions with {name, width} properties|
|data|table|{}|The table data as array of row arrays|
|headerColor|color|blue|Color of the column headers|
|selectedColor|color|lightBlue|Background color of selected row|
|gridColor|color|gray|Color of grid lines|
|sortDirection|string|"asc"|Sort direction ("asc" or "desc")|
|scrollOffset|number|0|Current scroll position|
|customSortFunction|table|{}|Custom sort functions for columns|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Table.new](#table-new)|Table|Creates a new Table instance|
|[Table:init](#table-init-props-basalt)|Table|Initializes the Table instance|
|[Table:addColumn](#table-addcolumn-name-width)|Table|Adds a new column to the table|
|[Table:addData](#table-adddata-any)|Table|Adds a new row of data to the table|
|[Table:setColumnSortFunction](#table-setcolumnsortfunction-columnindex-sortfn)|Table|Sets a custom sort function for a column|
|[Table:setFormattedData](#table-setformatteddata-displaydata-sortdata)|Table|Adds formatted data with raw sort values|
|[Table:setData](#table-setdata-rawdata-formatters)|Table|Sets table data with optional column formatters|
|[Table:calculateColumnWidths](#table-calculatecolumnwidths-columns-totalwidth)|table|Calculates column widths for rendering|
|[Table:sortData](#table-sortdata-columnindex-fn)|Table|Sorts the table data by the specified column|
|[Table:mouse_click](#table-mouse-click-button-x-y)|boolean|Handles header clicks for sorting and row selection|
|[Table:mouse_scroll](#table-mouse-scroll-direction-x-y)|boolean|Handles scrolling through the table data|
|[Table:render](#table-render)|-|Renders the table with headers, data and scrollbar|

## Table.new()

Creates a new Table instance

### Returns
* `Table` `self` The newly created Table instance

## Table:init(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Table` `self` The initialized instance

## Table:addColumn(name, width)

Adds a new column to the table

### Parameters
* `name` `string` The name of the column
* `width` `number` The width of the column

### Returns
* `Table` `self` The Table instance

## Table:addData(any)

Adds a new row of data to the table

### Parameters
* `any` `The` data for the new row

### Returns
* `Table` `self` The Table instance

## Table:setColumnSortFunction(columnIndex, sortFn)

Sets a custom sort function for a specific column

### Parameters
* `columnIndex` `number` The index of the column
* `sortFn` `function` Function that takes (rowA, rowB) and returns comparison result

### Returns
* `Table` `self` The Table instance

## Table:setFormattedData(displayData, sortData)

Adds data with both display and sort values

### Parameters
* `displayData` `table` The formatted data for display
* `sortData` `table` The raw data for sorting (optional)

### Returns
* `Table` `self` The Table instance

## Table:setData(rawData, formatters)

Set data with automatic formatting

### Parameters
* `rawData` `table` The raw data array
* `formatters` `table` Optional formatter functions for columns {[2] = function(value) return value end}

### Returns
* `Table` `self` The Table instance

## Table:calculateColumnWidths(columns, totalWidth)
### Parameters
* `columns` `table` The column definitions
* `totalWidth` `number` The total available width

### Returns
* `table` `The` columns with calculated visibleWidth

## Table:sortData(columnIndex, fn)

Sorts the table data by column

### Parameters
* `columnIndex` `number` The index of the column to sort by
* `fn` `function` ? Optional custom sorting function

### Returns
* `Table` `self` The Table instance

## Table:mouse_click(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Table:mouse_scroll(direction, x, y)
### Parameters
* `direction` `number` The scroll direction (-1 up, 1 down)
* `x` `number` The x position of the scroll
* `y` `number` The y position of the scroll

### Returns
* `boolean` `handled` Whether the event was handled

## Table:render()
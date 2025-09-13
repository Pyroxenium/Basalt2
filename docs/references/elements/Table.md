# Table
_This is the table class. It provides a sortable data grid with customizable columns,
row selection, and scrolling capabilities._

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

## Functions

|Method|Returns|Description|
|---|---|---|
|[Table.new](#table-new)|Table|Creates a new Table instance|
|[Table:Table](#table-table-props-basalt)|Table|Initializes the Table instance|
|[Table:Table](#table-table-name-width)|Table|Adds a new column to the table|
|[Table:Table](#table-table-any)|Table|Adds a new row of data to the table|
|[Table:Table](#table-table-columnindex-fn)|Table|Sorts the table data by the specified column|
|[Table:Table](#table-table-button-x-y)|boolean|Handles header clicks for sorting and row selection|
|[Table:Table](#table-table-direction-x-y)|boolean|Handles scrolling through the table data|
|[Table:Table](#table-table)|-|Renders the table with headers, data and scrollbar|

## Table.new()

Creates a new Table instance

### Returns
* `Table` `self` The newly created Table instance

## Table:Table(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Table` `self` The initialized instance

## Table:Table(name, width)

Adds a new column to the table

### Parameters
* `name` `string` The name of the column
* `width` `number` The width of the column

### Returns
* `Table` `self` The Table instance

## Table:Table(any)

Adds a new row of data to the table

### Parameters
* `any` `The` data for the new row

### Returns
* `Table` `self` The Table instance

## Table:Table(columnIndex, fn)

Sorts the table data by column

### Parameters
* `columnIndex` `number` The index of the column to sort by
* `fn` `function` ? Optional custom sorting function

### Returns
* `Table` `self` The Table instance

## Table:Table(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Table:Table(direction, x, y)
### Parameters
* `direction` `number` The scroll direction (-1 up, 1 down)
* `x` `number` The x position of the scroll
* `y` `number` The y position of the scroll

### Returns
* `boolean` `handled` Whether the event was handled

## Table:Table()
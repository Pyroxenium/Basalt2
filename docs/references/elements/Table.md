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
|[Table.new](#Table.new)|Table|Creates a new Table instance
|[Table:init](#Table:init)|Table|Initializes the Table instance
|[Table:mouse_click](#Table:mouse_click)|boolean|Handles header clicks for sorting and row selection
|[Table:mouse_scroll](#Table:mouse_scroll)|boolean|Handles scrolling through the table data
|[Table:render](#Table:render)|-|Renders the table with headers, data and scrollbar
|[Table:setColumns](#Table:setColumns)|Table|Sets the table columns configuration
|[Table:setData](#Table:setData)|Table|Sets the table data
|[Table:sortData](#Table:sortData)|Table|Sorts the table data by the specified column

## Table.new()
Creates a new Table instance

### Returns
* `Table` `self` The newly created Table instance

### Usage
 ```lua
local table = Table.new()
```

## Table:init(props, basalt)
Initializes the Table instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Table` `self` The initialized instance

## Table:mouse_click(button, x, y)
Handles mouse click events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Table:mouse_scroll(direction, x, y)
Handles mouse scroll events

### Parameters
* `direction` `number` The scroll direction (-1 up, 1 down)
* `x` `number` The x position of the scroll
* `y` `number` The y position of the scroll

### Returns
* `boolean` `handled` Whether the event was handled

## Table:render()
Renders the table

## Table:setColumns(columns)
Sets the table columns

### Parameters
* `columns` `table[]` Array of column definitions {name="Name", width=10}

### Returns
* `Table` `self` The Table instance

### Usage
 ```lua
table:setColumns({{name="ID", width=4}, {name="Name", width=10}})
```

## Table:setData(data)
Sets the table data

### Parameters
* `data` `table[]` Array of row data arrays

### Returns
* `Table` `self` The Table instance

### Usage
 ```lua
table:setData({{"1", "Item One"}, {"2", "Item Two"}})
```

## Table:sortData(columnIndex)
Sorts the table data by column

### Parameters
* `columnIndex` `number` The index of the column to sort by

### Returns
* `Table` `self` The Table instance



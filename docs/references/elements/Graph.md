# Graph
_This is the base class for all graph elements. It is a point based graph._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|minValue|number|0|The minimum value of the graph|
|maxValue|number|100|The maximum value of the graph|
|series|table|{}|The series of the graph|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Graph.new](#graph-new)|Graph|Creates a new Graph instance|
|[Graph:Graph](#graph-graph-props-basalt)|Graph|Initializes the Graph instance|
|[Graph:Graph](#graph-graph-name-symbol-bgcol-fgcol-pointcount)|Graph|Adds a series to the graph|
|[Graph:Graph](#graph-graph-name)|Graph|Removes a series from the graph|
|[Graph:Graph](#graph-graph-name)|series|Gets a series from the graph|
|[Graph:Graph](#graph-graph-name-visible)|Graph|Changes the visibility of a series|
|[Graph:Graph](#graph-graph-name-value)|Graph|Adds a point to a series|
|[Graph:Graph](#graph-graph-name)|Graph|Focuses a series|
|[Graph:Graph](#graph-graph-name-count)|Graph|Sets the point count of a series|
|[Graph:Graph](#graph-graph-name)|Graph|Clears all points from a series|
|[Graph:Graph](#graph-graph)|-|Renders the graph|

## Graph.new()

Creates a new Graph instance

### Returns
* `Graph` `self` The newly created Graph instance

## Graph:Graph(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Graph` `self` The initialized instance

## Graph:Graph(name, symbol, bgCol, fgCol, pointCount)
### Parameters
* `name` `string` The name of the series
* `symbol` `string` The symbol of the series
* `bgCol` `number` The background color of the series
* `fgCol` `number` The foreground color of the series
* `pointCount` `number` The number of points in the series

### Returns
* `Graph` `self` The graph instance

## Graph:Graph(name)
### Parameters
* `name` `string` The name of the series

### Returns
* `Graph` `self` The graph instance

## Graph:Graph(name)
### Parameters
* `name` `string` The name of the series

### Returns
* `series` `The` series

## Graph:Graph(name, visible)
### Parameters
* `name` `string` The name of the series
* `visible` `boolean` Whether the series should be visible

### Returns
* `Graph` `self` The graph instance

## Graph:Graph(name, value)
### Parameters
* `name` `string` The name of the series
* `value` `number` The value of the point

### Returns
* `Graph` `self` The graph instance

## Graph:Graph(name)
### Parameters
* `name` `string` The name of the series

### Returns
* `Graph` `self` The graph instance

## Graph:Graph(name, count)
### Parameters
* `name` `string` The name of the series
* `count` `number` The number of points in the series

### Returns
* `Graph` `self` The graph instance

## Graph:Graph(name?)

Clears all points from a series

### Parameters
* `name` *(optional)* `string` The name of the series

### Returns
* `Graph` `self` The graph instance

## Graph:Graph()
# Graph : VisualElement
This is the base class for all graph elements. It is a point based graph.

### Usage
 ```lua
local graph = main:addGraph()
:addSeries("input", " ", colors.green, colors.green, 10)
:addSeries("output", " ", colors.red, colors.red, 10)

basalt.schedule(function()
while true do
graph:addPoint("input", math.random(1,100))
graph:addPoint("output", math.random(1,100))
sleep(2)
end
end)
```


## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|minValue|number|0|The minimum value of the graph
|maxValue|number|100|The maximum value of the graph
|series|table|{}|The series of the graph

## Functions

|Method|Returns|Description|
|---|---|---|
|[Graph:addPoint](#graph-addpoint)|Graph|Adds a point to a series
|[Graph:addSeries](#graph-addseries)|-|Adds a series to the graph
|[Graph:changeSeriesVisibility](#graph-changeseriesvisibility)|Graph|Changes the visibility of a series
|[Graph:clear](#graph-clear)|Graph|Clears all points from a series
|[Graph:focusSeries](#graph-focusseries)|Graph|Focuses a series
|[Graph:getSeries](#graph-getseries)|table?|Gets a series from the graph
|[Graph:removeSeries](#graph-removeseries)|Graph|Removes a series from the graph
|[Graph:setSeriesPointCount](#graph-setseriespointcount)|Graph|Sets the point count of a series


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|Graph:init|Graph|Initializes the Graph instance
|Graph:render|-|Renders the graph

## Graph:addPoint(name, value)

### Parameters
* `name` `string` The name of the series
* `value` `number` The value of the point

### Returns
* `Graph` `self` The graph instance

## Graph:addSeries(name, symbol, bgCol, fgCol, pointCount)

### Parameters
* `name` `string` The name of the series
* `symbol` `string` The symbol of the series
* `bgCol` `number` The background color of the series
* `fgCol` `number` The foreground color of the series
* `pointCount` `number` The number of points in the series

## Graph:changeSeriesVisibility(name, visible)

### Parameters
* `name` `string` The name of the series
* `visible` `boolean` Whether the series should be visible

### Returns
* `Graph` `self` The graph instance

## Graph:clear(name?)
Clears all points from a series

### Parameters
* `name` *(optional)* `string` The name of the series

### Returns
* `Graph` `self` The graph instance

## Graph:focusSeries(name)

### Parameters
* `name` `string` The name of the series

### Returns
* `Graph` `self` The graph instance

## Graph:getSeries(name)

### Parameters
* `name` `string` The name of the series

### Returns
* `table?` `series` The series

## Graph:removeSeries(name)

### Parameters
* `name` `string` The name of the series

### Returns
* `Graph` `self` The graph instance

## Graph:setSeriesPointCount(name, count)

### Parameters
* `name` `string` The name of the series
* `count` `number` The number of points in the series

### Returns
* `Graph` `self` The graph instance



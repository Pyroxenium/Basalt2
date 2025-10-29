# Graph
_This is the base class for all graph elements. It is a point based graph._

Extends: `VisualElement`

## Usage
```lua run
local graph = main:addGraph()
```

```lua run
:addSeries("input", " ", colors.green, colors.green, 10)
```

```lua run
:addSeries("output", " ", colors.red, colors.red, 10)
```

```lua run

```

```lua run
basalt.schedule(function()
```

```lua run
while true do
```

```lua run
graph:addPoint("input", math.random(1,100))
```

```lua run
graph:addPoint("output", math.random(1,100))
```

```lua run
sleep(2)
```

```lua run
end
```

```lua run
end)
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|minValue|number|0|The minimum value of the graph|
|maxValue|number|100|The maximum value of the graph|
|series|table|{}|The series of the graph|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Graph:addSeries](#graph-addseries-name-symbol-bgcol-fgcol-pointcount)|Graph|Adds a series to the graph|
|[Graph:removeSeries](#graph-removeseries-name)|Graph|Removes a series from the graph|
|[Graph:getSeries](#graph-getseries-name)|series|Gets a series from the graph|
|[Graph:changeSeriesVisibility](#graph-changeseriesvisibility-name-visible)|Graph|Changes the visibility of a series|
|[Graph:addPoint](#graph-addpoint-name-value)|Graph|Adds a point to a series|
|[Graph:focusSeries](#graph-focusseries-name)|Graph|Focuses a series|
|[Graph:setSeriesPointCount](#graph-setseriespointcount-name-count)|Graph|Sets the point count of a series|
|[Graph:clear](#graph-clear-name)|Graph|Clears all points from a series|

## Graph:addSeries(name, symbol, bgCol, fgCol, pointCount)
### Parameters
* `name` `string` The name of the series
* `symbol` `string` The symbol of the series
* `bgCol` `number` The background color of the series
* `fgCol` `number` The foreground color of the series
* `pointCount` `number` The number of points in the series

### Returns
* `Graph` `self` The graph instance

## Graph:removeSeries(name)
### Parameters
* `name` `string` The name of the series

### Returns
* `Graph` `self` The graph instance

## Graph:getSeries(name)
### Parameters
* `name` `string` The name of the series

### Returns
* `series` `The` series

## Graph:changeSeriesVisibility(name, visible)
### Parameters
* `name` `string` The name of the series
* `visible` `boolean` Whether the series should be visible

### Returns
* `Graph` `self` The graph instance

## Graph:addPoint(name, value)
### Parameters
* `name` `string` The name of the series
* `value` `number` The value of the point

### Returns
* `Graph` `self` The graph instance

## Graph:focusSeries(name)
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

## Graph:clear(name?)

Clears all points from a series

### Parameters
* `name` *(optional)* `string` The name of the series

### Returns
* `Graph` `self` The graph instance

# BarChart : Graph
The Bar Chart element is designed for visualizing data series as vertical bars. It displays multiple values as side-by-side bars where each bar's height represents its value.

### Usage
 ```lua
local chart = main:addBarChart()
:addSeries("input", " ", colors.green, colors.green, 5)
:addSeries("output", " ", colors.red, colors.red, 5)

basalt.schedule(function()
while true do
chart:addPoint("input", math.random(1,100))
chart:addPoint("output", math.random(1,100))
sleep(2)
end
end)
```



## Protected Functions

|Method|Returns|Description|
|---|---|---|
|BarChart:init|BarChart|Initializes the BarChart instance
|BarChart:render|-|Renders the BarChart



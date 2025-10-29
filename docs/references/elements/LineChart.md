# LineChart
_The Line Chart element visualizes data series as connected line graphs. It plots points on a coordinate system and connects them with lines._

Extends: `Graph`

## Usage
```lua
local chart = main:addLineChart()
:addSeries("input", " ", colors.green, colors.green, 10)
:addSeries("output", " ", colors.red, colors.red, 10)

basalt.schedule(function()
while true do
chart:addPoint("input", math.random(1,100))
chart:addPoint("output", math.random(1,100))
sleep(2)
end
end)
```

# BarChart
_A data visualization element that represents numeric data through vertical bars. Each bar's height corresponds to its value, making it ideal for comparing quantities across categories or showing data changes over time. Supports multiple data series with customizable colors and styles._

Extends: `Graph`

## Usage
```lua
-- Create a bar chart
local chart = main:addBarChart()

-- Add two data series with different colors
chart:addSeries("input", " ", colors.green, colors.green, 5)
chart:addSeries("output", " ", colors.red, colors.red, 5)

-- Continuously update the chart with random data
basalt.schedule(function()
while true do
chart:addPoint("input", math.random(1,100))
chart:addPoint("output", math.random(1,100))
sleep(2)
end
end)
```

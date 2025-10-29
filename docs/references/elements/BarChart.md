# BarChart
_A data visualization element that represents numeric data through vertical bars. Each bar's height corresponds to its value, making it ideal for comparing quantities across categories or showing data changes over time. Supports multiple data series with customizable colors and styles._

Extends: `Graph`

## Usage
```lua run
-- Create a bar chart
```

```lua run
local chart = main:addBarChart()
```

```lua run

```

```lua run
-- Add two data series with different colors
```

```lua run
chart:addSeries("input", " ", colors.green, colors.green, 5)
```

```lua run
chart:addSeries("output", " ", colors.red, colors.red, 5)
```

```lua run

```

```lua run
-- Continuously update the chart with random data
```

```lua run
basalt.schedule(function()
```

```lua run
while true do
```

```lua run
chart:addPoint("input", math.random(1,100))
```

```lua run
chart:addPoint("output", math.random(1,100))
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

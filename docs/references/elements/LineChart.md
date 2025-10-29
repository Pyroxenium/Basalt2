# LineChart
_The Line Chart element visualizes data series as connected line graphs. It plots points on a coordinate system and connects them with lines._

Extends: `Graph`

## Usage
```lua run
local chart = main:addLineChart()
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

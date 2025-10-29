# LineChart
_The Line Chart element visualizes data series as connected line graphs. It plots points on a coordinate system and connects them with lines._

Extends: `Graph`

## Usage
```lua
local chart = main:addLineChart()
```

```lua
:addSeries("input", " ", colors.green, colors.green, 10)
```

```lua
:addSeries("output", " ", colors.red, colors.red, 10)
```

```lua

```

```lua
basalt.schedule(function()
```

```lua
while true do
```

```lua
chart:addPoint("input", math.random(1,100))
```

```lua
chart:addPoint("output", math.random(1,100))
```

```lua
sleep(2)
```

```lua
end
```

```lua
end)
```

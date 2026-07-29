# Charts, Images, and BigFont

These optional modules add data visualization, image playback, and large text
without making every application load those features.

## Charts

```lua
local basalt = require("basalt")
local charts = basalt.use("charts")
```

The module registers Graph, PixelGraph, BarChart, and LineChart.

Create a streaming graph:

```lua
local graph = frame:addPixelGraph({
    x = 2,
    y = 3,
    width = 30,
    height = 10,
    minValue = 0,
    maxValue = 100,
})

graph:addSeries("Fuel", {
    color = colors.orange,
    pointCount = 60,
})
graph:addPoint("Fuel", 42)
graph:addPoint("Fuel", 55)
graph:addPoint("Fuel", 51)
```

Keep the number of retained points appropriate for the visible width. Update
charts on a meaningful schedule instead of every event.

For a fixed data set, replace its values as a batch rather than rebuilding
the element.

## BigFont

```lua
local bigfont = basalt.use("bigfont")

local heading = frame:addBigFont({
    x = 2,
    y = 2,
    text = "42",
    fontSize = 2,
    foreground = colors.orange,
})
```

BigFont caches rendered content. Change its text only when the displayed
value changes and leave enough layout space for the selected scale.

## Images

```lua
local image = basalt.use("image")
```

The module adds image elements and playback support for supported image data:

```lua
local viewer = frame:addImage({
    x = 2,
    y = 2,
})

viewer.bimg = image.load("assets/logo.bimg")
```

Animated images use Basalt's scheduler. Stop playback when the view is
discarded rather than leaving scheduled work alive.

File-backed image examples are not marked for Copy Cat because the browser
computer receives no arbitrary project assets. The chart example below is
self-contained.

## Runnable Chart

```lua run title="Streaming chart"
local basalt = require("basalt")
local charts = basalt.use("charts")

local frame = basalt.getMainFrame()
frame.background = colors.black

frame:addLabel({
    x = 2,
    y = 1,
    text = "Streaming signal",
    foreground = colors.orange,
})

local graph = frame:addPixelGraph({
    x = 2,
    y = 3,
    width = 38,
    height = 12,
    background = colors.gray,
    minValue = 0,
    maxValue = 10,
})

graph:addSeries("Signal", {
    color = colors.lime,
    pointCount = 76,
})
local tick = 0

for i = 1, 20 do
    graph:addPoint("Signal", 5 + math.sin(i / 3) * 4)
end

local status = frame:addLabel({
    x = 42,
    y = 4,
    width = 9,
    height = 4,
    text = "Running",
    foreground = colors.lightGray,
})

basalt.schedule(function()
    while true do
        sleep(0.25)
        tick = tick + 1
        local value = 5 + math.sin(tick / 2) * 4
        graph:addPoint("Signal", value)
        status.text = ("Point\n%.1f"):format(value)
    end
end)

frame:addButton({
    x = 41,
    y = 12,
    width = 9,
    height = 2,
    text = "Exit",
    background = colors.red,
}):onClick(function()
    basalt.stop()
end)

basalt.run()
```

## Load Order

Load a module before creating its registered elements:

```lua
basalt.use("charts")
local graph = frame:addLineGraph({...})
```

Module names are lowercase loader names, not element class names.

## Related Guides and API

- [Optional Modules](./)
- [Animation and Responsive Layouts](./animation-and-responsive)
- [Canvas](../building-interfaces/canvas)
- [`PixelGraph`](/api/modules/PixelGraph)
- [`Image`](/api/modules/Image)
- [`BigFont`](/api/modules/BigFont)

## Next Steps

Use [Canvas](../building-interfaces/canvas) when a visualization needs a
custom surface not provided by the charts module.

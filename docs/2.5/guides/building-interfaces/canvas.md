# Canvas

Canvas is Basalt's low-level drawing element. Use it when application data is
best rendered as rows of terminal cells instead of hundreds of child
elements: heatmaps, editors, maps, compact charts, and custom controls.

## Create a Canvas

```lua
local canvas = frame:addCanvas({
    x = 2,
    y = 3,
    width = 30,
    height = 10,
    background = colors.black,
})

canvas.draw = function(self, buffer)
    buffer:blit(2, 2, "Custom surface", colors.white, colors.blue)
end
```

The callback receives the Canvas and Basalt's Render buffer. Coordinates are
local and start at `1, 1`.

The buffer is not a CC terminal. Read dimensions from the Canvas:

```lua
canvas.draw = function(self, buffer)
    local width, height = self.width, self.height
end
```

Do not call `buffer:getSize()`.

## Drawing Methods

| Method | Purpose |
| --- | --- |
| `fill(x, y, w, h, ch, fg, bg)` | Fill a rectangle |
| `blit(x, y, text, fg, bg)` | Draw one text span |
| `drawText(x, y, text)` | Replace text while preserving colors |
| `colorBlit(x, y, text, foregrounds, backgrounds)` | Draw public colors per cell |
| `drawBlit(x, y, text, fgHex, bgHex)` | Draw ordinary CC blit strings |

For a dense surface, emit one `colorBlit()` call per visible row:

```lua
buffer:colorBlit(
    1,
    1,
    "   ",
    { colors.white, colors.white, colors.white },
    { colors.green, colors.orange, colors.red }
)
```

`drawBlit()` is useful with terminal lines:

```lua
local text, foreground, background = window.getLine(1)
buffer:drawBlit(1, 1, text, foreground, background)
```

## Redraw After Model Changes

Canvas data is usually an ordinary Lua table. Basalt cannot observe it, so
request a render after changing paint-only data:

```lua
cells[y][x] = colors.orange
canvas:markRenderDirty()
```

Use `markDirty()` only when the change can affect layout. For a Signal-driven
Canvas, subscribe explicitly:

```lua
local level = basalt.state(0)

local unsubscribe = level:subscribe(function()
    canvas:markRenderDirty()
end)
```

Keep the returned function when the subscription is temporary.

## Input

Canvas inherits normal element events. Mouse coordinates are already local:

```lua
canvas:onClick(function(self, button, x, y)
    cells[y][x] = button == 2 and colors.black or colors.orange
    self:markRenderDirty()
end)
```

Use the same coordinate-to-model calculation for drawing and input.

## Runnable Heatmap

```lua run title="Interactive Canvas heatmap"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

local mapWidth, mapHeight = 32, 12
local cells = {}

for y = 1, mapHeight do
    cells[y] = {}
    for x = 1, mapWidth do
        cells[y][x] = 0
    end
end

frame:addLabel({
    x = 2,
    y = 1,
    width = 47,
    text = "Click or drag to paint; right-click erases",
    foreground = colors.orange,
})

local canvas = frame:addCanvas({
    x = 2,
    y = 3,
    width = mapWidth,
    height = mapHeight,
    background = colors.black,
})

local heatColors = {
    colors.black,
    colors.blue,
    colors.purple,
    colors.red,
    colors.orange,
    colors.yellow,
}

canvas.draw = function(self, buffer)
    for y = 1, self.height do
        local foregrounds, backgrounds = {}, {}
        for x = 1, self.width do
            foregrounds[x] = colors.white
            backgrounds[x] = heatColors[cells[y][x] + 1]
        end
        buffer:colorBlit(
            1,
            y,
            string.rep(" ", self.width),
            foregrounds,
            backgrounds
        )
    end
end

local function paint(self, button, x, y)
    if x < 1 or x > mapWidth or y < 1 or y > mapHeight then return end
    cells[y][x] = button == 2 and 0 or math.min(5, cells[y][x] + 1)
    self:markRenderDirty()
end

canvas:onClick(paint)
canvas:onDrag(paint)

frame:addButton({
    x = 37,
    y = 4,
    width = 12,
    height = 2,
    text = "Clear",
}):onClick(function()
    for y = 1, mapHeight do
        for x = 1, mapWidth do cells[y][x] = 0 end
    end
    canvas:markRenderDirty()
end)

frame:addButton({
    x = 37,
    y = 8,
    width = 12,
    height = 2,
    text = "Exit",
    background = colors.red,
}):onClick(function()
    basalt.stop()
end)

basalt.run()
```

One Canvas replaces 384 one-cell elements. The model remains a plain Lua
table and the draw callback writes twelve rows.

## Common Mistakes

- `buffer:getSize()` does not exist; use `self.width` and `self.height`.
- Mutating Canvas data does not redraw automatically.
- `rawBlit()` uses Basalt's internal palette bytes; ordinary CC blit strings
  belong in `drawBlit()`.
- Avoid doing file IO or peripheral calls inside `draw`.

## Related Guides and API

- [Hosted Programs](./hosted-programs)
- [Performance Tuning](../development/performance-tuning)
- [`Canvas`](/api/elements/Canvas)
- [`Render`](/api/core/Render)

## Next Steps

Use [Hosted Programs](./hosted-programs) when the content already behaves
like a complete CC application with its own terminal and event loop.

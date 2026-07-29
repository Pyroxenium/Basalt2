# Performance Tuning

Measure the interaction users report as slow, change one thing, and measure
the same interaction again. A large static screen is not automatically
expensive: a clean Basalt root skips drawing.

## Render Pipeline

One event-loop turn:

1. routes the event and resumes matching schedules;
2. application code changes state or properties;
3. affected roots become dirty;
4. dirty containers resolve layout;
5. each dirty root renders its visible tree into a retained buffer;
6. only terminal rows whose final text or colors changed are blitted.

A tree redraw is Lua work. A terminal flush is IO. Basalt may redraw a tree
and write only one changed row.

## Measure Real Updates

`os.clock()` is suitable for comparisons. Measure a batch because one update
may be below the clock resolution:

```lua
local function measureUpdates(iterations, mutate)
    basalt.update() -- settle initial layout

    local started = os.clock()
    for i = 1, iterations do
        mutate(i)
        basalt.update()
    end

    return (os.clock() - started) / iterations
end

local average = measureUpdates(50, function(i)
    counter.text = "Update " .. i
end)

print(("average: %.5f s"):format(average))
```

Use the same computer, terminal size, data, and interaction. Warm up first,
avoid logging inside the loop, and compare several batches. The debug overlay
can display a result but is not a profiler.

## Choose the Narrowest Invalidation

Ordinary properties invalidate automatically:

```lua
status.foreground = colors.green -- paint-only
status.text = "Ready"            -- may affect measurement
panel.width = 30                 -- layout
```

For custom data:

| Method | Use |
| --- | --- |
| `markRenderDirty()` | Pixels change, geometry cannot |
| `markLayoutDirty()` | Size, position, children, or measurement changes |
| `markDirty()` | Same full layout path as `markLayoutDirty()` |

Canvas paint usually needs:

```lua
cells[y][x] = colors.orange
canvas:markRenderDirty()
```

## Batch Work

Basalt draws after the current event and matching schedules finish. Several
property changes in one handler therefore produce one draw:

```lua
saveButton:onClick(function()
    title.text = "Saved"
    title.foreground = colors.green
    form.disabled = true
end)
```

Do not call `basalt.update()` after each assignment.

Signal subscriptions run immediately on every distinct `set()`. Compute one
final value and write it once. For a mutable Signal table, edit the batch and
call `touch()` once.

## Keep Reactive Work Small

Computed values are lazy but not memoized. Their function runs whenever the
property is resolved:

```lua
local title = basalt.computed(function()
    return "Selected: " .. selected:get()
end)
```

Short formatting is appropriate. Move file IO, peripheral calls, large
sorting, and filtering to the event that changes their inputs, then store the
result.

For high-frequency Canvas data, subscribe and request render-only
invalidation:

```lua
local level = basalt.state(0)

local unsubscribe = level:subscribe(function()
    canvas:markRenderDirty()
end)
```

## Keep Trees and Layout Focused

- Use List, Table, and Tree instead of one child per data record.
- Use Canvas instead of one element per visual cell.
- Hidden pages skip rendering and hit testing.
- Destroy temporary subtrees that will never return.
- Avoid changing geometry every tick when a paint-only representation works.
- Keep `onLayout` callbacks free from IO and heavy model work.

Containers cache layout, z sorting, and visible children. Off-screen children
still exist and may be inspected when layout or content bounds are
invalidated.

## Schedule at a Useful Cadence

```lua
basalt.schedule(function()
    while true do
        sleep(0.5)
        local nextLevel = readLevel()
        if nextLevel ~= level:get() then level:set(nextLevel) end
    end
end)
```

Avoid `sleep(0)` polling. Match the interval to how quickly the source and
user can meaningfully observe change. Cancel obsolete animations.

## Remember Terminal Rows

The retained buffer compares complete rows. Changing one cell sends that row;
changes across ten rows may send ten blits.

Keep rapidly changing status on few rows, draw dense surfaces row-by-row, and
avoid full-screen palette animation. Custom RGB is mapped to the terminal's
limited palette on dirty flushes.

## Runnable Invalidation Lab

The lab performs a paint-only change, a width change, and 100 model changes
followed by one render invalidation. Expected deltas are `L+0 D+1`,
`L+1 D+1`, and `L+0 D+1`.

```lua run title="Basalt invalidation lab"
local basalt = require("basalt")

local frame = basalt.getMainFrame()
frame.background = colors.black

local layouts, draws, value = 0, 0, 0
local shade = colors.blue
local results = {}

local stage = frame:addFrame({
    x = 2,
    y = 3,
    width = 30,
    height = 12,
    background = colors.gray,
})

stage:onLayout(function()
    layouts = layouts + 1
end)

local canvas = stage:addCanvas({
    x = 2,
    y = 2,
    width = 26,
    height = 8,
})

canvas.draw = function(self, buffer)
    draws = draws + 1
    buffer:fill(1, 1, self.width, self.height, " ", colors.white, shade)
    buffer:blit(2, 2, "Canvas draw: " .. draws, colors.white, shade)
    buffer:blit(2, 4, "Layout: " .. layouts, colors.white, shade)
    buffer:blit(2, 6, "Model: " .. value, colors.white, shade)
end

local function sample(name, action)
    local beforeLayout, beforeDraw = layouts, draws
    action()
    basalt.update()
    results[#results + 1] = {
        name = name,
        layout = layouts - beforeLayout,
        draw = draws - beforeDraw,
    }
end

basalt.update()

sample("Paint only", function()
    shade = colors.purple
    canvas:markRenderDirty()
end)

sample("Width", function()
    canvas.width = 25
end)

sample("100 changes", function()
    for _ = 1, 100 do value = value + 1 end
    canvas:markRenderDirty()
end)

frame:addLabel({
    x = 34,
    y = 3,
    width = 16,
    text = "Measured deltas",
    foreground = colors.yellow,
})

for index, result in ipairs(results) do
    frame:addLabel({
        x = 34,
        y = 4 + index * 3,
        width = 17,
        height = 2,
        text = result.name
            .. "\nL+" .. result.layout
            .. " D+" .. result.draw,
    })
end

frame:addButton({
    x = 36,
    y = 16,
    width = 12,
    height = 2,
    text = "Exit",
    background = colors.red,
}):onClick(function()
    basalt.stop()
end)

basalt.run()
```

The displayed deltas are captured before the final result screen draw.

## Optimization Order

1. Remove unnecessary polling, logging, and repeated state writes.
2. Move heavy work out of Computed, layout, and draw callbacks.
3. Batch changes.
4. Use render-only invalidation for custom paint.
5. Replace large tiny-element trees with collection controls or Canvas.
6. Reduce changing geometry and affected terminal rows.
7. Measure again.

## Related Guides and API

- [Testing](./testing)
- [Canvas](../building-interfaces/canvas)
- [Multiple Roots and Monitors](../building-interfaces/multiple-roots-and-monitors)
- [`Element:markRenderDirty()`](/api/elements/Element#element-markrenderdirty)
- [`basalt.update()`](/api/basalt#basalt-update-event)

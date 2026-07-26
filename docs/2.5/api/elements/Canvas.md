# Canvas

*extends Element*

Canvas: a single custom-painted surface.
The draw callback receives (canvas, renderBuffer) and paints in local
coordinates. This avoids building large trees of tiny visual elements.

## Types

### `CanvasDrawCallback`

```lua
CanvasDrawCallback = fun(canvas: Canvas, buffer: Render)
```

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| draw | `CanvasDrawCallback\|false` | `false` | Custom renderer: function(canvas, renderBuffer) |

## Methods

### Canvas:render(buf)

- **buf** (`Render`) The render buffer

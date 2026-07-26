# PixelGraph

*extends Element*

Charts module: registers Graph, BarChart, LineChart and PixelGraph elements.

  basalt.use("charts")
  local graph = frame:addGraph({ x = 2, y = 2, width = 20, height = 8 })
  graph:addSeries("cpu", { symbol = " ", bg = colors.red, pointCount = 20 })
  graph:addPoint("cpu", 42)

  frame:addBarChart({ ... }).data = { 3, 8, 2, 10 }
  frame:addLineChart({ ... }).data = { 1, 5, 3, 9, 4 }

  -- PixelGraph plots at 2x3 subpixel resolution per cell (via the same
  -- mosaic engine the Image element uses for FLIMG sprites), so lines
  -- look smooth instead of one blocky point per cell.
  local pixelGraph = frame:addPixelGraph({ x = 2, y = 2, width = 20, height = 8 })
  pixelGraph:addSeries("cpu", { color = colors.red })
  pixelGraph:addPoint("cpu", 42)

## Types

### `Graph`

*extends Element*

-------------------------------------------------------------------------

### `BarChart`

*extends Element*

-------------------------------------------------------------------------

### `LineChart`

*extends Element*

-------------------------------------------------------------------------

## Properties

| Property | Type | Default | Description |
| --- | --- | --- | --- |
| minValue | `number` | `0` | Lower bound of the value axis |
| maxValue | `number` | `100` | Upper bound of the value axis |
| background | `number\|false` | `colors.black` | Background color (false = transparent) |
| width | `number` | `20` | Width in terminal cells |
| height | `number` | `8` | Height in terminal cells |
| data | `boolean` | `false` | fresh table per instance |
| barColor | `number` | `colors.lime` | Color of the bar/track |
| minValue | `number` | `0` | Lower bound of the value axis |
| maxValue | `boolean` | `false` | false = auto (data maximum) |
| background | `number\|false` | `colors.black` | Background color (false = transparent) |
| width | `number` | `20` | Width in terminal cells |
| height | `number` | `8` | Height in terminal cells |
| data | `boolean` | `false` | fresh table per instance |
| lineColor | `number` | `colors.lime` | Color of the plotted line |
| minValue | `number` | `0` | Lower bound of the value axis |
| maxValue | `number` | `100` | Upper bound of the value axis |
| background | `number\|false` | `colors.black` | Background color (false = transparent) |
| width | `number` | `20` | Width in terminal cells |
| height | `number` | `8` | Height in terminal cells |
| minValue | `number` | `0` | Lower bound of the value axis |
| maxValue | `number` | `100` | Upper bound of the value axis |
| background | `number\|false` | `colors.black` | Background color (false = transparent) |
| width | `number` | `20` | Width in terminal cells (2 subpixel columns per cell) |
| height | `number` | `8` | Height in terminal cells (3 subpixel rows per cell) |

## Methods

### Graph:setup()

Initializes per-instance state and input handlers.

### Graph:addSeries(name, opts)

opts: symbol (default " "), fg, bg, pointCount (default width),
visible (default true)
Adds a named graph series.

- **name** (`string`) Series name
- **opts** (`table|nil`) symbol/fg/bg/pointCount/visible options

- **returns** (`self`) 

### Graph:getSeries(name)

Returns a named series definition.

- **name** (`string`) Series name

- **returns** **series** (`table|nil`) 

### Graph:removeSeries(name)

Removes a named series.

- **name** (`string`) Series name

- **returns** (`self`) 

### Graph:setSeriesVisible(name, visible)

Changes visibility of one series.

- **name** (`string`) Series name
- **visible** (`boolean`) Visibility

- **returns** (`self`) 

### Graph:addPoint(name, value)

Appends a point; the series scrolls once pointCount is reached.

- **name** (`string`) Series name
- **value** (`number`) Point value

- **returns** (`self`) 

### Graph:clear(name)

Clears one series or every series when name is nil.

- **name** (`string|nil`) Series name

- **returns** (`self`) 

### Graph:render(buf)

Renders the element into the buffer.

- **buf** (`Render`) The render buffer (local coordinates, pre-clipped)

### BarChart:setup()

Initializes per-instance state and input handlers.

### BarChart:render(buf)

Renders the element into the buffer.

- **buf** (`Render`) The render buffer (local coordinates, pre-clipped)

### LineChart:setup()

Initializes per-instance state and input handlers.

### LineChart:render(buf)

Renders the element into the buffer.

- **buf** (`Render`) The render buffer (local coordinates, pre-clipped)

### PixelGraph:setup()

Initializes per-instance state.

### PixelGraph:addSeries(name, opts)

opts: color (default white), pointCount (default width*2 subpixel
columns), visible (default true)
Adds a named graph series.

- **name** (`string`) Series name
- **opts** (`table|nil`) color/pointCount/visible options

- **returns** (`self`) 

### PixelGraph:getSeries(name)

Returns a named series definition.

- **name** (`string`) Series name

- **returns** **series** (`table|nil`) 

### PixelGraph:removeSeries(name)

Removes a named series.

- **name** (`string`) Series name

- **returns** (`self`) 

### PixelGraph:setSeriesVisible(name, visible)

Changes visibility of one series.

- **name** (`string`) Series name
- **visible** (`boolean`) Visibility

- **returns** (`self`) 

### PixelGraph:addPoint(name, value)

Appends a point; the series scrolls once pointCount is reached.

- **name** (`string`) Series name
- **value** (`number`) Point value

- **returns** (`self`) 

### PixelGraph:clear(name)

Clears one series or every series when name is nil.

- **name** (`string|nil`) Series name

- **returns** (`self`) 

### PixelGraph:render(buf)

Renders every series into a 2x3-subpixel-per-cell grid and blits it
through the mosaic pixel engine.

- **buf** (`Render`) The render buffer (local coordinates, pre-clipped)

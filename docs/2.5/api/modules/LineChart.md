# LineChart

*extends Element*

Charts module: registers Graph, BarChart and LineChart elements.

  basalt.use("charts")
  local graph = frame:addGraph({ x = 2, y = 2, width = 20, height = 8 })
  graph:addSeries("cpu", { symbol = " ", bg = colors.red, pointCount = 20 })
  graph:addPoint("cpu", 42)

  frame:addBarChart({ ... }).data = { 3, 8, 2, 10 }
  frame:addLineChart({ ... }).data = { 1, 5, 3, 9, 4 }

## Types

### `Graph`

*extends Element*

-------------------------------------------------------------------------

### `BarChart`

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

-- Charts module: registers Graph, BarChart, LineChart and PixelGraph elements.
--
--   basalt.use("charts")
--   local graph = frame:addGraph({ x = 2, y = 2, width = 20, height = 8 })
--   graph:addSeries("cpu", { symbol = " ", bg = colors.red, pointCount = 20 })
--   graph:addPoint("cpu", 42)
--
--   frame:addBarChart({ ... }).data = { 3, 8, 2, 10 }
--   frame:addLineChart({ ... }).data = { 1, 5, 3, 9, 4 }
--
--   -- PixelGraph plots at 2x3 subpixel resolution per cell (via the same
--   -- mosaic engine the Image element uses for FLIMG sprites), so lines
--   -- look smooth instead of one blocky point per cell.
--   local pixelGraph = frame:addPixelGraph({ x = 2, y = 2, width = 20, height = 8 })
--   pixelGraph:addSeries("cpu", { color = colors.red })
--   pixelGraph:addPoint("cpu", 42)

local require = ...
local class = require("core/class")
local Element = require("core/element")
local Container = require("core/container")
local palette = require("core/palette")

local charts = {}

local function clamp01(v)
    if v < 0 then return 0 end
    if v > 1 then return 1 end
    return v
end

local function ratioToRow(value, minV, maxV, height)
    local ratio = maxV > minV and clamp01((value - minV) / (maxV - minV)) or 0
    return height - math.floor(ratio * (height - 1) + 0.5)
end

----------------------------------------------------------------------------
-- Graph: multiple named series of points
----------------------------------------------------------------------------

---@class Graph : Element
local Graph = class.create("Graph", Element)
--- Lower bound of the value axis
class.property(Graph, "minValue", 0)
--- Upper bound of the value axis
class.property(Graph, "maxValue", 100)
--- Background color (false = transparent)
class.property(Graph, "background", colors.black)
--- Width in terminal cells
class.property(Graph, "width", 20)
--- Height in terminal cells
class.property(Graph, "height", 8)

--- Initializes per-instance state and input handlers.
function Graph:setup()
    Element.setup(self)
    rawset(self, "_series", {})
end

--- opts: symbol (default " "), fg, bg, pointCount (default width),
--- visible (default true)
--- Adds a named graph series.
---@param name string Series name
---@param opts table|nil symbol/fg/bg/pointCount/visible options
---@return self
function Graph:addSeries(name, opts)
    opts = opts or {}
    local series = rawget(self, "_series")
    series[#series + 1] = {
        name = name,
        symbol = (opts.symbol or " "):sub(1, 1),
        fg = opts.fg or colors.white,
        bg = opts.bg or colors.white,
        pointCount = opts.pointCount or self.width,
        visible = opts.visible ~= false,
        points = {},
    }
    self:markDirty()
    return self
end

--- Returns a named series definition.
---@param name string Series name
---@return table|nil series
function Graph:getSeries(name)
    for _, series in ipairs(rawget(self, "_series")) do
        if series.name == name then return series end
    end
    return nil
end

--- Removes a named series.
---@param name string Series name
---@return self
function Graph:removeSeries(name)
    local series = rawget(self, "_series")
    for i = 1, #series do
        if series[i].name == name then
            table.remove(series, i)
            break
        end
    end
    self:markDirty()
    return self
end

--- Changes visibility of one series.
---@param name string Series name
---@param visible boolean Visibility
---@return self
function Graph:setSeriesVisible(name, visible)
    local series = self:getSeries(name)
    if series then
        series.visible = visible ~= false
        self:markDirty()
    end
    return self
end

--- Appends a point; the series scrolls once pointCount is reached.
---@param name string Series name
---@param value number Point value
---@return self
function Graph:addPoint(name, value)
    local series = self:getSeries(name)
    if not series then
        error("Basalt charts: unknown series '" .. tostring(name) .. "'", 2)
    end
    local points = series.points
    points[#points + 1] = value
    while #points > series.pointCount do
        table.remove(points, 1)
    end
    self:markDirty()
    return self
end

--- Clears one series or every series when name is nil.
---@param name string|nil Series name
---@return self
function Graph:clear(name)
    if name then
        local series = self:getSeries(name)
        if series then series.points = {} end
    else
        for _, series in ipairs(rawget(self, "_series")) do
            series.points = {}
        end
    end
    self:markDirty()
    return self
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function Graph:render(buf)
    Element.render(self, buf)
    local w, h = self.width, self.height
    local minV, maxV = self.minValue, self.maxValue
    for _, series in ipairs(rawget(self, "_series")) do
        if series.visible then
            local points = series.points
            local count = math.max(series.pointCount, 2)
            for i = 1, #points do
                local col = 1 + math.floor((i - 1) / (count - 1) * (w - 1) + 0.5)
                local row = ratioToRow(points[i], minV, maxV, h)
                buf:blit(col, row, series.symbol, series.fg, series.bg)
            end
        end
    end
end

----------------------------------------------------------------------------
-- BarChart: one bar per value in `data`
----------------------------------------------------------------------------

---@class BarChart : Element
local BarChart = class.create("BarChart", Element)
class.property(BarChart, "data", false) -- fresh table per instance
--- Color of the bar/track
class.property(BarChart, "barColor", colors.lime)
--- Lower bound of the value axis
class.property(BarChart, "minValue", 0)
class.property(BarChart, "maxValue", false) -- false = auto (data maximum)
--- Background color (false = transparent)
class.property(BarChart, "background", colors.black)
--- Width in terminal cells
class.property(BarChart, "width", 20)
--- Height in terminal cells
class.property(BarChart, "height", 8)

--- Initializes per-instance state and input handlers.
function BarChart:setup()
    Element.setup(self)
    rawget(self, "_p").data = {}
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function BarChart:render(buf)
    Element.render(self, buf)
    local data = self.data
    local count = #data
    if count == 0 then return end
    local w, h = self.width, self.height

    local maxV = self.maxValue
    if not maxV then
        maxV = -math.huge
        for i = 1, count do maxV = math.max(maxV, data[i]) end
    end
    local minV = self.minValue

    local barWidth = math.max(1, math.floor((w - (count - 1)) / count))
    local x = 1
    for i = 1, count do
        if x > w then break end
        local top = ratioToRow(data[i], minV, maxV, h)
        buf:fill(x, top, math.min(barWidth, w - x + 1), h - top + 1,
            " ", self.foreground, self.barColor)
        x = x + barWidth + 1
    end
end

----------------------------------------------------------------------------
-- LineChart: `data` sampled across the width, gaps interpolated
----------------------------------------------------------------------------

---@class LineChart : Element
local LineChart = class.create("LineChart", Element)
class.property(LineChart, "data", false) -- fresh table per instance
--- Color of the plotted line
class.property(LineChart, "lineColor", colors.lime)
--- Lower bound of the value axis
class.property(LineChart, "minValue", 0)
--- Upper bound of the value axis
class.property(LineChart, "maxValue", 100)
--- Background color (false = transparent)
class.property(LineChart, "background", colors.black)
--- Width in terminal cells
class.property(LineChart, "width", 20)
--- Height in terminal cells
class.property(LineChart, "height", 8)

--- Initializes per-instance state and input handlers.
function LineChart:setup()
    Element.setup(self)
    rawget(self, "_p").data = {}
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function LineChart:render(buf)
    Element.render(self, buf)
    local data = self.data
    local count = #data
    if count == 0 then return end
    local w, h = self.width, self.height
    local minV, maxV = self.minValue, self.maxValue

    for col = 1, w do
        local t = count > 1 and ((col - 1) / (w - 1) * (count - 1) + 1) or 1
        local lower = math.floor(t)
        local upper = math.min(count, lower + 1)
        local value = data[lower] + (data[upper] - data[lower]) * (t - lower)
        local row = ratioToRow(value, minV, maxV, h)
        buf:fill(col, row, 1, 1, " ", self.foreground, self.lineColor)
    end
end

----------------------------------------------------------------------------
-- PixelGraph: named series plotted at 2x3 subpixel resolution per cell
----------------------------------------------------------------------------

local function plotPixel(rows, pixelWidth, pixelHeight, x, y, index)
    if x < 1 or x > pixelWidth or y < 1 or y > pixelHeight then return end
    rows[y][x] = index
end

-- Bresenham's line algorithm, so points further apart than one subpixel
-- column still render as a connected line instead of dots with gaps.
local function plotLine(rows, pixelWidth, pixelHeight, x0, y0, x1, y1, index)
    local dx, dy = math.abs(x1 - x0), -math.abs(y1 - y0)
    local sx = x0 < x1 and 1 or -1
    local sy = y0 < y1 and 1 or -1
    local err = dx + dy
    local x, y = x0, y0
    while true do
        plotPixel(rows, pixelWidth, pixelHeight, x, y, index)
        if x == x1 and y == y1 then break end
        local e2 = 2 * err
        if e2 >= dy then err, x = err + dy, x + sx end
        if e2 <= dx then err, y = err + dx, y + sy end
    end
end

---@class PixelGraph : Element
local PixelGraph = class.create("PixelGraph", Element)
--- Lower bound of the value axis
class.property(PixelGraph, "minValue", 0)
--- Upper bound of the value axis
class.property(PixelGraph, "maxValue", 100)
--- Background color (false = transparent)
class.property(PixelGraph, "background", colors.black)
--- Width in terminal cells (2 subpixel columns per cell)
class.property(PixelGraph, "width", 20)
--- Height in terminal cells (3 subpixel rows per cell)
class.property(PixelGraph, "height", 8)

--- Initializes per-instance state.
function PixelGraph:setup()
    Element.setup(self)
    rawset(self, "_series", {})
end

--- opts: color (default white), pointCount (default width*2 subpixel
--- columns), visible (default true)
--- Adds a named graph series.
---@param name string Series name
---@param opts table|nil color/pointCount/visible options
---@return self
function PixelGraph:addSeries(name, opts)
    opts = opts or {}
    local series = rawget(self, "_series")
    series[#series + 1] = {
        name = name,
        color = opts.color or colors.white,
        pointCount = opts.pointCount or self.width * 2,
        visible = opts.visible ~= false,
        points = {},
    }
    self:markDirty()
    return self
end

--- Returns a named series definition.
---@param name string Series name
---@return table|nil series
function PixelGraph:getSeries(name)
    for _, series in ipairs(rawget(self, "_series")) do
        if series.name == name then return series end
    end
    return nil
end

--- Removes a named series.
---@param name string Series name
---@return self
function PixelGraph:removeSeries(name)
    local series = rawget(self, "_series")
    for i = 1, #series do
        if series[i].name == name then
            table.remove(series, i)
            break
        end
    end
    self:markDirty()
    return self
end

--- Changes visibility of one series.
---@param name string Series name
---@param visible boolean Visibility
---@return self
function PixelGraph:setSeriesVisible(name, visible)
    local series = self:getSeries(name)
    if series then
        series.visible = visible ~= false
        self:markDirty()
    end
    return self
end

--- Appends a point; the series scrolls once pointCount is reached.
---@param name string Series name
---@param value number Point value
---@return self
function PixelGraph:addPoint(name, value)
    local series = self:getSeries(name)
    if not series then
        error("Basalt charts: unknown series '" .. tostring(name) .. "'", 2)
    end
    local points = series.points
    points[#points + 1] = value
    while #points > series.pointCount do
        table.remove(points, 1)
    end
    self:markDirty()
    return self
end

--- Clears one series or every series when name is nil.
---@param name string|nil Series name
---@return self
function PixelGraph:clear(name)
    if name then
        local series = self:getSeries(name)
        if series then series.points = {} end
    else
        for _, series in ipairs(rawget(self, "_series")) do
            series.points = {}
        end
    end
    self:markDirty()
    return self
end

--- Renders every series into a 2x3-subpixel-per-cell grid and blits it
--- through the mosaic pixel engine.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function PixelGraph:render(buf)
    Element.render(self, buf)
    local pixelWidth, pixelHeight = self.width * 2, self.height * 3
    local minV, maxV = self.minValue, self.maxValue

    local rows = {}
    for y = 1, pixelHeight do rows[y] = {} end

    local paletteBytes, indexOf, nextIndex, used = {}, {}, 1, false
    for _, series in ipairs(rawget(self, "_series")) do
        if series.visible and #series.points > 0 then
            local index = indexOf[series.color]
            if not index then
                index = nextIndex
                nextIndex = nextIndex + 1
                indexOf[series.color] = index
                paletteBytes[index] = palette.charOf[series.color]
            end
            local points = series.points
            local count = math.max(series.pointCount, 2)
            local prevCol, prevRow
            for i = 1, #points do
                local col = 1 + math.floor((i - 1) / (count - 1) * (pixelWidth - 1) + 0.5)
                local row = ratioToRow(points[i], minV, maxV, pixelHeight)
                if prevCol then
                    plotLine(rows, pixelWidth, pixelHeight, prevCol, prevRow, col, row, index)
                else
                    plotPixel(rows, pixelWidth, pixelHeight, col, row, index)
                end
                prevCol, prevRow = col, row
            end
            used = true
        end
    end
    if not used then return end

    local rowStrings = {}
    for y = 1, pixelHeight do
        local chars, row = {}, rows[y]
        for x = 1, pixelWidth do
            chars[x] = string.char(row[x] or 0)
        end
        rowStrings[y] = table.concat(chars)
    end
    buf:drawPixels(1, 1, pixelWidth, pixelHeight, rowStrings, paletteBytes)
end

Container.register("Graph", Graph)
Container.register("BarChart", BarChart)
Container.register("LineChart", LineChart)
Container.register("PixelGraph", PixelGraph)

charts.Graph = Graph
charts.BarChart = BarChart
charts.LineChart = LineChart
charts.PixelGraph = PixelGraph

return charts

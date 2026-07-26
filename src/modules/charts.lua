-- Charts module: registers Graph, BarChart and LineChart elements.
--
--   basalt.use("charts")
--   local graph = frame:addGraph({ x = 2, y = 2, width = 20, height = 8 })
--   graph:addSeries("cpu", { symbol = " ", bg = colors.red, pointCount = 20 })
--   graph:addPoint("cpu", 42)
--
--   frame:addBarChart({ ... }).data = { 3, 8, 2, 10 }
--   frame:addLineChart({ ... }).data = { 1, 5, 3, 9, 4 }

local require = ...
local class = require("core/class")
local Element = require("core/element")
local Container = require("core/container")

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

Container.register("Graph", Graph)
Container.register("BarChart", BarChart)
Container.register("LineChart", LineChart)

charts.Graph = Graph
charts.BarChart = BarChart
charts.LineChart = LineChart

return charts

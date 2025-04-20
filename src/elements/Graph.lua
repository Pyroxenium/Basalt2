local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local tHex = require("libraries/colorHex")
---@configDescription A point based graph element
---@configDefault false

--- This is the base class for all graph elements. It is a point based graph.
--- @usage local graph = main:addGraph()
--- @usage :addSeries("input", " ", colors.green, colors.green, 10)
--- @usage :addSeries("output", " ", colors.red, colors.red, 10)
--- @usage 
--- @usage basalt.schedule(function()
--- @usage     while true do
--- @usage         graph:addPoint("input", math.random(1,100))
--- @usage         graph:addPoint("output", math.random(1,100))
--- @usage         sleep(2)
--- @usage     end
--- @usage end)
--- @class Graph : VisualElement
local Graph = setmetatable({}, VisualElement)
Graph.__index = Graph

---@property minValue number 0 The minimum value of the graph
Graph.defineProperty(Graph, "minValue", {default = 0, type = "number", canTriggerRender = true})
---@property maxValue number 100 The maximum value of the graph
Graph.defineProperty(Graph, "maxValue", {default = 100, type = "number", canTriggerRender = true})
---@property series table {} The series of the graph
Graph.defineProperty(Graph, "series", {default = {}, type = "table", canTriggerRender = true})

--- Creates a new Graph instance
--- @shortDescription Creates a new Graph instance
--- @return Graph self The newly created Graph instance
--- @private
function Graph.new()
    local self = setmetatable({}, Graph):__init()
    self.class = Graph
    return self
end

--- @shortDescription Initializes the Graph instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Graph self The initialized instance
--- @protected
function Graph:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Graph")
    self.set("width", 20)
    self.set("height", 10)
    return self
end

--- @shortDescription Adds a series to the graph
--- @param name string The name of the series
--- @param symbol string The symbol of the series
--- @param bgCol number The background color of the series
--- @param fgCol number The foreground color of the series
--- @param pointCount number The number of points in the series
--- @return Graph self The graph instance
function Graph:addSeries(name, symbol, bgCol, fgCol, pointCount)
    local series = self.get("series")
    table.insert(series, {
        name = name,
        symbol = symbol or " ",
        bgColor = bgCol or colors.white,
        fgColor = fgCol or colors.black,
        pointCount = pointCount or self.get("width"),
        data = {},
        visible = true
    })
    self:updateRender()
    return self
end

--- @shortDescription Removes a series from the graph
--- @param name string The name of the series
--- @return Graph self The graph instance
function Graph:removeSeries(name)
    local series = self.get("series")
    for i, s in ipairs(series) do
        if s.name == name then
            table.remove(series, i)
            break
        end
    end
    self:updateRender()
    return self
end

--- @shortDescription Gets a series from the graph
--- @param name string The name of the series
--- @return table? series The series
function Graph:getSeries(name)
    local series = self.get("series")
    for _, s in ipairs(series) do
        if s.name == name then
            return s
        end
    end
    return nil
end

--- @shortDescription Changes the visibility of a series
--- @param name string The name of the series
--- @param visible boolean Whether the series should be visible
--- @return Graph self The graph instance
function Graph:changeSeriesVisibility(name, visible)
    local series = self.get("series")
    for _, s in ipairs(series) do
        if s.name == name then
            s.visible = visible
            break
        end
    end
    self:updateRender()
    return self
end

--- @shortDescription Adds a point to a series
--- @param name string The name of the series
--- @param value number The value of the point
--- @return Graph self The graph instance
function Graph:addPoint(name, value)
    local series = self.get("series")

    for _, s in ipairs(series) do
        if s.name == name then
            table.insert(s.data, value)
            while #s.data > s.pointCount do
                table.remove(s.data, 1)
            end
            break
        end
    end
    self:updateRender()
    return self
end

--- @shortDescription Focuses a series
--- @param name string The name of the series
--- @return Graph self The graph instance
function Graph:focusSeries(name)
    local series = self.get("series")
    for index, s in ipairs(series) do
        if s.name == name then
            table.remove(series, index)
            table.insert(series, s)
            break
        end
    end
    self:updateRender()
    return self
end

--- @shortDescription Sets the point count of a series
--- @param name string The name of the series
--- @param count number The number of points in the series
--- @return Graph self The graph instance
function Graph:setSeriesPointCount(name, count)
    local series = self.get("series")
    for _, s in ipairs(series) do
        if s.name == name then
            s.pointCount = count
            while #s.data > count do
                table.remove(s.data, 1)
            end
            break
        end
    end
    self:updateRender()
    return self
end

--- Clears all points from a series
--- @shortDescription Clears all points from a series
--- @param name? string The name of the series
--- @return Graph self The graph instance
function Graph:clear(seriesName)
    local series = self.get("series")
    if seriesName then
        for _, s in ipairs(series) do
            if s.name == seriesName then
                s.data = {}
                break
            end
        end
    else
        for _, s in ipairs(series) do
            s.data = {}
        end
    end
    return self
end

--- @shortDescription Renders the graph
--- @protected
function Graph:render()
    VisualElement.render(self)

    local width = self.get("width")
    local height = self.get("height")
    local minVal = self.get("minValue")
    local maxVal = self.get("maxValue")
    local series = self.get("series")

    for _, s in pairs(series) do
        if(s.visible)then
            local dataCount = #s.data
            local spacing = (width - 1) / math.max((dataCount - 1), 1)

            for i, value in ipairs(s.data) do
                local x = math.floor(((i-1) * spacing) + 1)

                local normalizedValue = (value - minVal) / (maxVal - minVal)
                local y = math.floor(height - (normalizedValue * (height-1)))
                y = math.max(1, math.min(y, height))

                self:blit(x, y, s.symbol, tHex[s.bgColor], tHex[s.fgColor])
            end
        end
    end
end

return Graph
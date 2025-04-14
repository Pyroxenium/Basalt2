local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local Graph = elementManager.getElement("Graph")
local tHex = require("libraries/colorHex")
--- @configDescription A line chart element based on the graph element
---@configDefault false

--- The Line Chart element visualizes data series as connected line graphs. It plots points on a coordinate system and connects them with lines.
--- @usage local chart = main:addLineChart()
--- @usage :addSeries("input", " ", colors.green, colors.green, 10)
--- @usage :addSeries("output", " ", colors.red, colors.red, 10)
--- @usage 
--- @usage basalt.schedule(function()
--- @usage     while true do
--- @usage         chart:addPoint("input", math.random(1,100))
--- @usage         chart:addPoint("output", math.random(1,100))
--- @usage         sleep(2)
--- @usage     end
--- @usage end)
--- @class LineChart : Graph
local LineChart = setmetatable({}, Graph)
LineChart.__index = LineChart

--- Creates a new LineChart instance
--- @shortDescription Creates a new LineChart instance
--- @return LineChart self The newly created LineChart instance
--- @private
function LineChart.new()
    local self = setmetatable({}, LineChart):__init()
    self.class = LineChart
    return self
end

--- @shortDescription Initializes the LineChart instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return LineChart self The initialized instance
--- @protected
function LineChart:init(props, basalt)
    Graph.init(self, props, basalt)
    self.set("type", "LineChart")
    return self
end

local function drawLine(self, x1, y1, x2, y2, symbol, bgColor, fgColor)
    local dx = x2 - x1
    local dy = y2 - y1
    local steps = math.max(math.abs(dx), math.abs(dy))

    for i = 0, steps do
        local t = steps == 0 and 0 or i / steps
        local x = math.floor(x1 + dx * t)
        local y = math.floor(y1 + dy * t)
        if x >= 1 and x <= self.get("width") and y >= 1 and y <= self.get("height") then
            self:blit(x, y, symbol, tHex[bgColor], tHex[fgColor])
        end
    end
end

--- @shortDescription Renders the LineChart
--- @protected
function LineChart:render()
    VisualElement.render(self)

    local width = self.get("width")
    local height = self.get("height")
    local minVal = self.get("minValue")
    local maxVal = self.get("maxValue")
    local series = self.get("series")

    for _, s in pairs(series) do
        if(s.visible)then
            local lastX, lastY
            local dataCount = #s.data
            local spacing = (width - 1) / math.max((dataCount - 1), 1)

            for i, value in ipairs(s.data) do
                local x = math.floor(((i-1) * spacing) + 1)
                local normalizedValue = (value - minVal) / (maxVal - minVal)
                local y = math.floor(height - (normalizedValue * (height-1)))
                y = math.max(1, math.min(y, height))

                if lastX then
                    drawLine(self, lastX, lastY, x, y, s.symbol, s.bgColor, s.fgColor)
                end
                lastX, lastY = x, y
            end
        end
    end
end

return LineChart

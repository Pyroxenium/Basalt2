local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local BaseGraph = elementManager.getElement("Graph")
local tHex = require("libraries/colorHex")
--- @configDescription A bar chart element based on the graph element.
---@configDefault false

--- The Bar Chart element is designed for visualizing data series as vertical bars. It displays multiple values as side-by-side bars where each bar's height represents its value.
--- @usage local chart = main:addBarChart()
--- @usage :addSeries("input", " ", colors.green, colors.green, 5)
--- @usage :addSeries("output", " ", colors.red, colors.red, 5)
--- @usage 
--- @usage basalt.schedule(function()
--- @usage     while true do
--- @usage         chart:addPoint("input", math.random(1,100))
--- @usage         chart:addPoint("output", math.random(1,100))
--- @usage         sleep(2)
--- @usage     end
--- @usage end)
--- @class BarChart : Graph
local BarChart = setmetatable({}, BaseGraph)
BarChart.__index = BarChart

--- Creates a new BarChart instance
--- @shortDescription Creates a new BarChart instance
--- @return BarChart self The newly created BarChart instance
--- @private
function BarChart.new()
    local self = setmetatable({}, BarChart):__init()
    self.class = BarChart
    return self
end

--- @shortDescription Initializes the BarChart instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return BarChart self The initialized instance
--- @protected
function BarChart:init(props, basalt)
    BaseGraph.init(self, props, basalt)
    self.set("type", "BarChart")
    return self
end

--- @shortDescription Renders the BarChart
--- @protected
function BarChart:render()
    VisualElement.render(self)

    local width = self.get("width")
    local height = self.get("height")
    local minVal = self.get("minValue")
    local maxVal = self.get("maxValue")
    local series = self.get("series")

    local activeSeriesCount = 0
    local seriesList = {}
    for _, s in pairs(series) do
        if(s.visible)then
            if #s.data > 0 then
                activeSeriesCount = activeSeriesCount + 1
                table.insert(seriesList, s)
            end
        end
    end

    local barGroupWidth = activeSeriesCount
    local spacing = 1
    local totalGroups = math.min(seriesList[1] and seriesList[1].pointCount or 0, math.floor((width + spacing) / (barGroupWidth + spacing)))

    for groupIndex = 1, totalGroups do
        local groupX = ((groupIndex-1) * (barGroupWidth + spacing)) + 1

        for seriesIndex, s in ipairs(seriesList) do
            local value = s.data[groupIndex]
            if value then
                local x = groupX + (seriesIndex - 1)
                local normalizedValue = (value - minVal) / (maxVal - minVal)
                local y = math.floor(height - (normalizedValue * (height-1)))
                y = math.max(1, math.min(y, height))

                for barY = y, height do
                    self:blit(x, barY, s.symbol, tHex[s.fgColor], tHex[s.bgColor])
                end
            end
        end
    end
end

return BarChart

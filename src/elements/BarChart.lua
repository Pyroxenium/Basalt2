local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local BaseGraph = elementManager.getElement("Graph")
local tHex = require("libraries/colorHex")
--- @configDescription A bar chart element based on the graph element.
--- @configDefault false

--- A data visualization element that represents numeric data through vertical bars. Each bar's height corresponds to its value, making it ideal for comparing quantities across categories or showing data changes over time. Supports multiple data series with customizable colors and styles.
--- @usage [[
--- -- Create a bar chart
--- local chart = main:addBarChart()
--- 
--- -- Add two data series with different colors
--- chart:addSeries("input", " ", colors.green, colors.green, 5)
--- chart:addSeries("output", " ", colors.red, colors.red, 5)
--- 
--- -- Continuously update the chart with random data
--- basalt.schedule(function()
---     while true do
---         chart:addPoint("input", math.random(1,100))
---         chart:addPoint("output", math.random(1,100))
---         sleep(2)
---      end
--- end)
--- ]]
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

--- Renders the bar chart by calculating bar positions and heights based on data values
--- @shortDescription Draws bars for each data point in visible series
--- @protected
function BarChart:render()
    VisualElement.render(self)

    local width = self.getResolved("width")
    local height = self.getResolved("height")
    local minVal = self.getResolved("minValue")
    local maxVal = self.getResolved("maxValue")
    local series = self.getResolved("series")

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

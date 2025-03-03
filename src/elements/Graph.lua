local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("elements/VisualElement")
---@configDescription 
---@configDefault false

---@class Graph : VisualElement
local Graph = setmetatable({}, VisualElement)
Graph.__index = Graph

Graph.defineProperty(Graph, "data", {default = {}, type = "table", canTriggerRender = true})
Graph.defineProperty(Graph, "minValue", {default = 0, type = "number", canTriggerRender = true})
Graph.defineProperty(Graph, "maxValue", {default = 100, type = "number", canTriggerRender = true})
Graph.defineProperty(Graph, "graphColor", {default = colors.yellow, type = "color", canTriggerRender = true})
Graph.defineProperty(Graph, "graphSymbol", {default = "\127", type = "string", canTriggerRender = true}) -- Default: "|"

function Graph.new()
    local self = setmetatable({}, Graph):__init()
    return self
end

function Graph:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Graph")
    return self
end

function Graph:setPoint(index, value)
    local data = self.get("data")
    data[index] = value
    self:updateRender()
end

function Graph:addPoint(value)
    local data = self.get("data")
    table.insert(data, value)
    while #data > self.get("width") do
        table.remove(data, 1)
    end
    self:updateRender()
end

function Graph:render()
    VisualElement.render(self)
    
    local data = self.get("data")
    local width = self.get("width")
    local height = self.get("height")
    local minVal = self.get("minValue")
    local maxVal = self.get("maxValue")
    local symbol = self.get("graphSymbol")
    local graphColor = self.get("graphColor")

    for x = 1, width do
        if data[x] then
            local normalizedValue = (data[x] - minVal) / (maxVal - minVal)
            local y = math.floor(height - (normalizedValue * (height-1)))
            y = math.max(1, math.min(y, height))

            self:textFg(x, y, symbol, graphColor)
        end
    end
end

return Graph

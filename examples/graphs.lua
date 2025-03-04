local basalt = require("basalt")

-- This is a simple example of a line chart. It shows how to create a line chart and add points to it.
local main = basalt.getMainFrame()
local graph = main:addLineChart()--or addBarChart()

-- Add two series to the graph
graph:addSeries("red", " ", colors.red, colors.red, 5)
graph:addSeries("blue", " ", colors.blue, colors.blue, 5)

-- Add some points to the red series
graph:addPoint("red", 1)
graph:addPoint("red", 12)
graph:addPoint("red", 50)
graph:addPoint("red", 20)
graph:addPoint("red", 60)

basalt.schedule(function()
    while true do
        sleep(2)
        graph:addPoint("red", math.random(1, 100))
        graph:addPoint("blue", math.random(1, 100))
    end
end)

-- :focusSeries("red") makes the red series more important in the rendering order
-- :changeSeriesVisibility("red", false) changes the visibility of the red series without removing the ability to add new points

local vis = true
main:addButton()
    :setPosition(40, 1)
    :setText("Focus red")
    :onClick(function()
        --vis = not vis
        --graph:changeSeriesVisibility("red", vis)
        graph:focusSeries("red")
    end)

basalt.run()


local basalt = require("basalt")

local main = basalt.getMainFrame()

-- Vertical scrolling
-- This function gets the overall height of all the children in a container
local function getChildrenHeight(container)
    local height = 0
    for _, child in ipairs(container.get("children")) do
        if(child.get("visible"))then
            local newHeight = child.get("y") + child.get("height")
            if newHeight > height then
                height = newHeight
            end
        end
    end
    return height
end

-- Create a new frame
local scrollingFrame = main:addFrame({width = 20, height = 10, x = 2, y = 2, backgroundColor = colors.gray})

-- Add a scroll function to the frame
scrollingFrame:onScroll(function(self, delta)
    local offset = math.max(0, math.min(self.get("offsetY") + delta, getChildrenHeight(self) - self.get("height")))
    self:setOffsetY(offset)
end)

scrollingFrame:addButton({text = "Button 1", x=2, y = 2})
scrollingFrame:addButton({text = "Button 2", x=2, y = 6})
scrollingFrame:addButton({text = "Button 3", x=2, y = 10})

-- Horizontal scrolling
local function getChildrenWidth(container)
    local width = 0
    for _, child in ipairs(container.get("children")) do
        if(child.get("visible"))then
            local newWidth = child.get("x") + child.get("width")
            if newWidth > width then
                width = newWidth
            end
        end
    end
    return width
end

local scrollingFrame2 = main:addFrame({width = 20, height = 10, x = 25, y = 2, backgroundColor = colors.gray})
scrollingFrame2:onScroll(function(self, delta)
    local offset = math.max(0, math.min(self.get("offsetX") + delta, getChildrenWidth(self) - self.get("width")))
    self:setOffsetX(offset)
end)

scrollingFrame2:addButton({text = "Button 1", x=2, y = 2})
scrollingFrame2:addButton({text = "Button 2", x=13, y = 2})
scrollingFrame2:addButton({text = "Button 3", x=24, y = 2})

basalt.run()
local elementManager = require("elementManager")
local Container = elementManager.getElement("Container")
local tHex = require("libraries/colorHex")
---@configDescription A scrollable container that automatically displays scrollbars when content overflows.
---@configDefault false

--- A container that provides automatic scrolling capabilities with visual scrollbars. Displays vertical and/or horizontal scrollbars when child content exceeds the container's dimensions.
--- @run [[
--- local basalt = require("basalt")
--- 
--- local main = basalt.getMainFrame()
--- 
--- -- Create a ScrollFrame with content larger than the frame
--- local scrollFrame = main:addScrollFrame({
---     x = 2,
---     y = 2,
---     width = 30,
---     height = 12,
---     background = colors.lightGray
--- })
--- 
--- -- Add a title
--- scrollFrame:addLabel({
---     x = 2,
---     y = 1,
---     text = "ScrollFrame Example",
---     foreground = colors.yellow
--- })
--- 
--- -- Add multiple labels that exceed the frame height
--- for i = 1, 20 do
---     scrollFrame:addLabel({
---         x = 2,
---         y = i + 2,
---         text = "Line " .. i .. " - Scroll to see more",
---         foreground = i % 2 == 0 and colors.white or colors.lightGray
---     })
--- end
--- 
--- -- Add some interactive buttons at different positions
--- scrollFrame:addButton({
---     x = 2,
---     y = 24,
---     width = 15,
---     height = 3,
---     text = "Button 1",
---     background = colors.blue
--- })
--- :onClick(function()
---     scrollFrame:addLabel({
---         x = 18,
---         y = 24,
---         text = "Clicked!",
---         foreground = colors.lime
---     })
--- end)
--- 
--- scrollFrame:addButton({
---     x = 2,
---     y = 28,
---     width = 15,
---     height = 3,
---     text = "Button 2",
---     background = colors.green
--- })
--- :onClick(function()
---     scrollFrame:addLabel({
---         x = 18,
---         y = 28,
---         text = "Nice!",
---         foreground = colors.orange
---     })
--- end)
--- 
--- -- Info label outside the scroll frame
--- main:addLabel({
---     x = 2,
---     y = 15,
---     text = "Use mouse wheel to scroll!",
---     foreground = colors.gray
--- })
--- 
--- basalt.run()
--- ]]
---@class ScrollFrame : Container
local ScrollFrame = setmetatable({}, Container)
ScrollFrame.__index = ScrollFrame

---@property showScrollBar boolean true Whether to show scrollbars
ScrollFrame.defineProperty(ScrollFrame, "showScrollBar", {default = true, type = "boolean", canTriggerRender = true})

---@property scrollBarSymbol string "_" The symbol used for the scrollbar handle
ScrollFrame.defineProperty(ScrollFrame, "scrollBarSymbol", {default = " ", type = "string", canTriggerRender = true})

---@property scrollBarBackgroundSymbol string "\127" The symbol used for the scrollbar background
ScrollFrame.defineProperty(ScrollFrame, "scrollBarBackgroundSymbol", {default = "\127", type = "string", canTriggerRender = true})

---@property scrollBarColor color lightGray Color of the scrollbar handle
ScrollFrame.defineProperty(ScrollFrame, "scrollBarColor", {default = colors.lightGray, type = "color", canTriggerRender = true})

---@property scrollBarBackgroundColor color gray Background color of the scrollbar
ScrollFrame.defineProperty(ScrollFrame, "scrollBarBackgroundColor", {default = colors.gray, type = "color", canTriggerRender = true})

---@property scrollBarBackgroundColor2 secondary color black Background color of the scrollbar
ScrollFrame.defineProperty(ScrollFrame, "scrollBarBackgroundColor2", {default = colors.black, type = "color", canTriggerRender = true})

---@property contentWidth number 0 The total width of the content (calculated from children)
ScrollFrame.defineProperty(ScrollFrame, "contentWidth", {
    default = 0,
    type = "number",
    getter = function(self)
        local maxWidth = 0
        local children = self.getResolved("children")
        for _, child in ipairs(children) do
            local childX = child.get("x")
            local childWidth = child.get("width")
            local childRight = childX + childWidth - 1
            if childRight > maxWidth then
                maxWidth = childRight
            end
        end
        return maxWidth
    end
})

---@property contentHeight number 0 The total height of the content (calculated from children)
ScrollFrame.defineProperty(ScrollFrame, "contentHeight", {
    default = 0,
    type = "number",
    getter = function(self)
        local maxHeight = 0
        local children = self.getResolved("children")
        for _, child in ipairs(children) do
            local childY = child.get("y")
            local childHeight = child.get("height")
            local childBottom = childY + childHeight - 1
            if childBottom > maxHeight then
                maxHeight = childBottom
            end
        end
        return maxHeight
    end
})

ScrollFrame.defineEvent(ScrollFrame, "mouse_click")
ScrollFrame.defineEvent(ScrollFrame, "mouse_drag")
ScrollFrame.defineEvent(ScrollFrame, "mouse_up")
ScrollFrame.defineEvent(ScrollFrame, "mouse_scroll")

--- Creates a new ScrollFrame instance
--- @shortDescription Creates a new ScrollFrame instance
--- @return ScrollFrame self The newly created ScrollFrame instance
--- @private
function ScrollFrame.new()
    local self = setmetatable({}, ScrollFrame):__init()
    self.class = ScrollFrame
    self.set("width", 20)
    self.set("height", 10)
    self.set("z", 10)
    return self
end

--- Initializes a ScrollFrame instance
--- @shortDescription Initializes a ScrollFrame instance
--- @param props table Initial properties
--- @param basalt table The basalt instance
--- @return ScrollFrame self The initialized ScrollFrame instance
--- @private
function ScrollFrame:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "ScrollFrame")
    return self
end

--- Handles mouse click events for scrollbars and content
--- @shortDescription Handles mouse click events
--- @param button number The mouse button (1=left, 2=right, 3=middle)
--- @param x number The x-coordinate of the click
--- @param y number The y-coordinate of the click
--- @return boolean Whether the event was handled
--- @protected
function ScrollFrame:mouse_click(button, x, y)
    if Container.mouse_click(self, button, x, y) then
        local relX, relY = self:getRelativePosition(x, y)
        local width = self.getResolved("width")
        local height = self.getResolved("height")
        local showScrollBar = self.getResolved("showScrollBar")
        local contentWidth = self.getResolved("contentWidth")
        local contentHeight = self.getResolved("contentHeight")
        local needsHorizontalScrollBar = showScrollBar and contentWidth > width
        local viewportHeight = needsHorizontalScrollBar and height - 1 or height
        local needsVerticalScrollBar = showScrollBar and contentHeight > viewportHeight
        local viewportWidth = needsVerticalScrollBar and width - 1 or width

        if needsVerticalScrollBar and relX == width and (not needsHorizontalScrollBar or relY < height) then
            local scrollHeight = viewportHeight
            local handleSize = math.max(1, math.floor((viewportHeight / contentHeight) * scrollHeight))
            local maxOffset = contentHeight - viewportHeight

            local currentPercent = maxOffset > 0 and (self.getResolved("offsetY") / maxOffset * 100) or 0
            local handlePos = math.floor((currentPercent / 100) * (scrollHeight - handleSize)) + 1

            if relY >= handlePos and relY < handlePos + handleSize then
                self._scrollBarDragging = true
                self._scrollBarDragOffset = relY - handlePos
            else
                local newPercent = ((relY - 1) / (scrollHeight - handleSize)) * 100
                local newOffset = math.floor((newPercent / 100) * maxOffset + 0.5)
                self.set("offsetY", math.max(0, math.min(maxOffset, newOffset)))
            end
            return true
        end

        if needsHorizontalScrollBar and relY == height and (not needsVerticalScrollBar or relX < width) then
            local scrollWidth = viewportWidth
            local handleSize = math.max(1, math.floor((viewportWidth / contentWidth) * scrollWidth))
            local maxOffset = contentWidth - viewportWidth

            local currentPercent = maxOffset > 0 and (self.getResolved("offsetX") / maxOffset * 100) or 0
            local handlePos = math.floor((currentPercent / 100) * (scrollWidth - handleSize)) + 1

            if relX >= handlePos and relX < handlePos + handleSize then
                self._hScrollBarDragging = true
                self._hScrollBarDragOffset = relX - handlePos
            else
                local newPercent = ((relX - 1) / (scrollWidth - handleSize)) * 100
                local newOffset = math.floor((newPercent / 100) * maxOffset + 0.5)
                self.set("offsetX", math.max(0, math.min(maxOffset, newOffset)))
            end
            return true
        end

        return true
    end
    return false
end

--- Handles mouse drag events for scrollbar
--- @shortDescription Handles mouse drag events for scrollbar
--- @param button number The mouse button being dragged
--- @param x number The x-coordinate of the drag
--- @param y number The y-coordinate of the drag
--- @return boolean Whether the event was handled
--- @protected
function ScrollFrame:mouse_drag(button, x, y)
    if self._scrollBarDragging then
        local _, relY = self:getRelativePosition(x, y)
        local height = self.getResolved("height")
        local contentWidth = self.getResolved("contentWidth")
        local contentHeight = self.getResolved("contentHeight")
        local width = self.getResolved("width")
        local needsHorizontalScrollBar = self.getResolved("showScrollBar") and contentWidth > width

        local viewportHeight = needsHorizontalScrollBar and height - 1 or height
        local scrollHeight = viewportHeight
        local handleSize = math.max(1, math.floor((viewportHeight / contentHeight) * scrollHeight))
        local maxOffset = contentHeight - viewportHeight

        relY = math.max(1, math.min(scrollHeight, relY))

        local newPos = relY - (self._scrollBarDragOffset or 0)
        local newPercent = ((newPos - 1) / (scrollHeight - handleSize)) * 100
        local newOffset = math.floor((newPercent / 100) * maxOffset + 0.5)

        self.set("offsetY", math.max(0, math.min(maxOffset, newOffset)))
        return true
    end

    if self._hScrollBarDragging then
        local relX, _ = self:getRelativePosition(x, y)
        local width = self.getResolved("width")
        local contentWidth = self.getResolved("contentWidth")
        local contentHeight = self.getResolved("contentHeight")
        local height = self.getResolved("height")
        local needsHorizontalScrollBar = self.getResolved("showScrollBar") and contentWidth > width
        local viewportHeight = needsHorizontalScrollBar and height - 1 or height
        local needsVerticalScrollBar = self.getResolved("showScrollBar") and contentHeight > viewportHeight
        local viewportWidth = needsVerticalScrollBar and width - 1 or width
        local scrollWidth = viewportWidth
        local handleSize = math.max(1, math.floor((viewportWidth / contentWidth) * scrollWidth))
        local maxOffset = contentWidth - viewportWidth

        relX = math.max(1, math.min(scrollWidth, relX))

        local newPos = relX - (self._hScrollBarDragOffset or 0)
        local newPercent = ((newPos - 1) / (scrollWidth - handleSize)) * 100
        local newOffset = math.floor((newPercent / 100) * maxOffset + 0.5)

        self.set("offsetX", math.max(0, math.min(maxOffset, newOffset)))
        return true
    end

    return Container.mouse_drag and Container.mouse_drag(self, button, x, y) or false
end

--- Handles mouse up events to stop scrollbar dragging
--- @shortDescription Handles mouse up events to stop scrollbar dragging
--- @param button number The mouse button that was released
--- @param x number The x-coordinate of the release
--- @param y number The y-coordinate of the release
--- @return boolean Whether the event was handled
--- @protected
function ScrollFrame:mouse_up(button, x, y)
    if self._scrollBarDragging then
        self._scrollBarDragging = false
        self._scrollBarDragOffset = nil
        return true
    end

    if self._hScrollBarDragging then
        self._hScrollBarDragging = false
        self._hScrollBarDragOffset = nil
        return true
    end

    return Container.mouse_up and Container.mouse_up(self, button, x, y) or false
end

--- Handles mouse scroll events
--- @shortDescription Handles mouse scroll events
--- @param direction number 1 for up, -1 for down
--- @param x number Mouse x position relative to element
--- @param y number Mouse y position relative to element
--- @return boolean Whether the event was handled
--- @protected
function ScrollFrame:mouse_scroll(direction, x, y)
    if self:isInBounds(x, y) then
        local xOffset, yOffset = self.getResolved("offsetX"), self.getResolved("offsetY")
        local relX, relY = self:getRelativePosition(x + xOffset, y + yOffset)

        local success, child = self:callChildrenEvent(true, "mouse_scroll", direction, relX, relY)
        if success then
            return true
        end

        local height = self.getResolved("height")
        local width = self.getResolved("width")
        local offsetY = self.getResolved("offsetY")
        local offsetX = self.getResolved("offsetX")
        local contentWidth = self.getResolved("contentWidth")
        local contentHeight = self.getResolved("contentHeight")

        local needsHorizontalScrollBar = self.getResolved("showScrollBar") and contentWidth > width
        local viewportHeight = needsHorizontalScrollBar and height - 1 or height
        local needsVerticalScrollBar = self.getResolved("showScrollBar") and contentHeight > viewportHeight
        local viewportWidth = needsVerticalScrollBar and width - 1 or width

        if needsVerticalScrollBar then
            local maxScroll = math.max(0, contentHeight - viewportHeight)
            local newScroll = math.min(maxScroll, math.max(0, offsetY + direction))
            self.set("offsetY", newScroll)
        elseif needsHorizontalScrollBar then
            local maxScroll = math.max(0, contentWidth - viewportWidth)
            local newScroll = math.min(maxScroll, math.max(0, offsetX + direction))
            self.set("offsetX", newScroll)
        end

        return true
    end
    return false
end

--- Renders the ScrollFrame and its scrollbars
--- @shortDescription Renders the ScrollFrame and its scrollbars
--- @protected
function ScrollFrame:render()
    Container.render(self)

    local height = self.getResolved("height")
    local width = self.getResolved("width")
    local offsetY = self.getResolved("offsetY")
    local offsetX = self.getResolved("offsetX")
    local showScrollBar = self.getResolved("showScrollBar")
    local contentWidth = self.getResolved("contentWidth")
    local contentHeight = self.getResolved("contentHeight")
    local needsHorizontalScrollBar = showScrollBar and contentWidth > width
    local viewportHeight = needsHorizontalScrollBar and height - 1 or height
    local needsVerticalScrollBar = showScrollBar and contentHeight > viewportHeight
    local viewportWidth = needsVerticalScrollBar and width - 1 or width

    if needsVerticalScrollBar then
        local scrollHeight = viewportHeight
        local handleSize = math.max(1, math.floor((viewportHeight / contentHeight) * scrollHeight))
        local maxOffset = contentHeight - viewportHeight
        local scrollBarBg = self.getResolved("scrollBarBackgroundSymbol")
        local scrollBarColor = self.getResolved("scrollBarColor")
        local scrollBarBgColor = self.getResolved("scrollBarBackgroundColor")
        local scrollBarBg2Color = self.getResolved("scrollBarBackgroundColor2")

        local currentPercent = maxOffset > 0 and (offsetY / maxOffset * 100) or 0
        local handlePos = math.floor((currentPercent / 100) * (scrollHeight - handleSize)) + 1

        for i = 1, scrollHeight do
            if i >= handlePos and i < handlePos + handleSize then
                self:blit(width, i, " ", tHex[scrollBarColor], tHex[scrollBarColor])
            else
                self:blit(width, i, scrollBarBg, tHex[scrollBarBgColor], tHex[scrollBarBg2Color])
            end
        end
    end

    if needsHorizontalScrollBar then
        local scrollWidth = viewportWidth
        local handleSize = math.max(1, math.floor((viewportWidth / contentWidth) * scrollWidth))
        local maxOffset = contentWidth - viewportWidth
        local scrollBarBg = self.getResolved("scrollBarBackgroundSymbol")
        local scrollBarColor = self.getResolved("scrollBarColor")
        local scrollBarBgColor = self.getResolved("scrollBarBackgroundColor")
        local scrollBarBg2Color = self.getResolved("scrollBarBackgroundColor2")

        local currentPercent = maxOffset > 0 and (offsetX / maxOffset * 100) or 0
        local handlePos = math.floor((currentPercent / 100) * (scrollWidth - handleSize)) + 1

        for i = 1, scrollWidth do
            if i >= handlePos and i < handlePos + handleSize then
                self:blit(i, height, " ", tHex[scrollBarColor], tHex[scrollBarColor])
            else
                self:blit(i, height, scrollBarBg, tHex[scrollBarBgColor], tHex[scrollBarBg2Color])
            end
        end
    end

    if needsVerticalScrollBar and needsHorizontalScrollBar then
        local background = self.getResolved("background")
        self:blit(width, height, " ", tHex[background], tHex[background])
    end
end

return ScrollFrame

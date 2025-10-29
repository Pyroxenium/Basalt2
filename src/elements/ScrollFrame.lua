local elementManager = require("elementManager")
local Container = elementManager.getElement("Container")
local tHex = require("libraries/colorHex")
---@configDescription A scrollable container that automatically displays scrollbars when content overflows.

--- A container that provides automatic scrolling capabilities with visual scrollbars. Displays vertical and/or horizontal scrollbars when child content exceeds the container's dimensions.
---@class ScrollFrame : Container
local ScrollFrame = setmetatable({}, Container)
ScrollFrame.__index = ScrollFrame

---@property showScrollBar boolean true Whether to show scrollbars
ScrollFrame.defineProperty(ScrollFrame, "showScrollBar", {default = true, type = "boolean", canTriggerRender = true})

---@property scrollBarSymbol string " " The symbol used for the scrollbar handle
ScrollFrame.defineProperty(ScrollFrame, "scrollBarSymbol", {default = " ", type = "string", canTriggerRender = true})

---@property scrollBarBackground string "\127" The symbol used for the scrollbar background
ScrollFrame.defineProperty(ScrollFrame, "scrollBarBackground", {default = "\127", type = "string", canTriggerRender = true})

---@property scrollBarColor color lightGray Color of the scrollbar handle
ScrollFrame.defineProperty(ScrollFrame, "scrollBarColor", {default = colors.lightGray, type = "color", canTriggerRender = true})

---@property scrollBarBackgroundColor color gray Background color of the scrollbar
ScrollFrame.defineProperty(ScrollFrame, "scrollBarBackgroundColor", {default = colors.gray, type = "color", canTriggerRender = true})

---@property contentWidth number 0 The total width of the content (calculated from children)
ScrollFrame.defineProperty(ScrollFrame, "contentWidth", {
    default = 0,
    type = "number",
    getter = function(self)
        local maxWidth = 0
        local children = self.get("children")
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
        local children = self.get("children")
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
    self.set("z", 5)
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
        local width = self.get("width")
        local height = self.get("height")
        local showScrollBar = self.get("showScrollBar")
        local contentWidth = self.get("contentWidth")
        local contentHeight = self.get("contentHeight")
        local needsHorizontalScrollBar = showScrollBar and contentWidth > width
        local viewportHeight = needsHorizontalScrollBar and height - 1 or height
        local needsVerticalScrollBar = showScrollBar and contentHeight > viewportHeight
        local viewportWidth = needsVerticalScrollBar and width - 1 or width

        if needsVerticalScrollBar and relX == width and (not needsHorizontalScrollBar or relY < height) then
            local scrollHeight = viewportHeight
            local handleSize = math.max(1, math.floor((viewportHeight / contentHeight) * scrollHeight))
            local maxOffset = contentHeight - viewportHeight

            local currentPercent = maxOffset > 0 and (self.get("offsetY") / maxOffset * 100) or 0
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

            local currentPercent = maxOffset > 0 and (self.get("offsetX") / maxOffset * 100) or 0
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
        local height = self.get("height")
        local contentWidth = self.get("contentWidth")
        local contentHeight = self.get("contentHeight")
        local width = self.get("width")
        local needsHorizontalScrollBar = self.get("showScrollBar") and contentWidth > width

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
        local width = self.get("width")
        local contentWidth = self.get("contentWidth")
        local contentHeight = self.get("contentHeight")
        local height = self.get("height")
        local needsHorizontalScrollBar = self.get("showScrollBar") and contentWidth > width
        local viewportHeight = needsHorizontalScrollBar and height - 1 or height
        local needsVerticalScrollBar = self.get("showScrollBar") and contentHeight > viewportHeight
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
    local height = self.get("height")
    local width = self.get("width")
    local offsetY = self.get("offsetY")
    local contentWidth = self.get("contentWidth")
    local contentHeight = self.get("contentHeight")

    local needsHorizontalScrollBar = self.get("showScrollBar") and contentWidth > width
    local viewportHeight = needsHorizontalScrollBar and height - 1 or height
    local maxScroll = math.max(0, contentHeight - viewportHeight)

    local newScroll = math.min(maxScroll, math.max(0, offsetY + direction))
    self.set("offsetY", newScroll)

    return true
end

--- Renders the ScrollFrame and its scrollbars
--- @shortDescription Renders the ScrollFrame and its scrollbars
--- @protected
function ScrollFrame:render()
    Container.render(self)

    local height = self.get("height")
    local width = self.get("width")
    local offsetY = self.get("offsetY")
    local offsetX = self.get("offsetX")
    local showScrollBar = self.get("showScrollBar")
    local contentWidth = self.get("contentWidth")
    local contentHeight = self.get("contentHeight")
    local needsHorizontalScrollBar = showScrollBar and contentWidth > width
    local viewportHeight = needsHorizontalScrollBar and height - 1 or height
    local needsVerticalScrollBar = showScrollBar and contentHeight > viewportHeight
    local viewportWidth = needsVerticalScrollBar and width - 1 or width

    if needsVerticalScrollBar then
        local scrollHeight = viewportHeight
        local handleSize = math.max(1, math.floor((viewportHeight / contentHeight) * scrollHeight))
        local maxOffset = contentHeight - viewportHeight
        local scrollBarSymbol = self.get("scrollBarSymbol")
        local scrollBarBg = self.get("scrollBarBackground")
        local scrollBarColor = self.get("scrollBarColor")
        local scrollBarBgColor = self.get("scrollBarBackgroundColor")
        local foreground = self.get("foreground")

        local currentPercent = maxOffset > 0 and (offsetY / maxOffset * 100) or 0
        local handlePos = math.floor((currentPercent / 100) * (scrollHeight - handleSize)) + 1

        for i = 1, scrollHeight do
            if i >= handlePos and i < handlePos + handleSize then
                self:blit(width, i, scrollBarSymbol, tHex[scrollBarColor], tHex[scrollBarBgColor])
            else
                self:blit(width, i, scrollBarBg, tHex[foreground], tHex[scrollBarBgColor])
            end
        end
    end

    if needsHorizontalScrollBar then
        local scrollWidth = viewportWidth
        local handleSize = math.max(1, math.floor((viewportWidth / contentWidth) * scrollWidth))
        local maxOffset = contentWidth - viewportWidth
        local scrollBarSymbol = self.get("scrollBarSymbol")
        local scrollBarBg = self.get("scrollBarBackground")
        local scrollBarColor = self.get("scrollBarColor")
        local scrollBarBgColor = self.get("scrollBarBackgroundColor")
        local foreground = self.get("foreground")

        local currentPercent = maxOffset > 0 and (offsetX / maxOffset * 100) or 0
        local handlePos = math.floor((currentPercent / 100) * (scrollWidth - handleSize)) + 1

        for i = 1, scrollWidth do
            if i >= handlePos and i < handlePos + handleSize then
                self:blit(i, height, scrollBarSymbol, tHex[scrollBarColor], tHex[scrollBarBgColor])
            else
                self:blit(i, height, scrollBarBg, tHex[foreground], tHex[scrollBarBgColor])
            end
        end
    end

    if needsVerticalScrollBar and needsHorizontalScrollBar then
        local background = self.get("background")
        self:blit(width, height, " ", tHex[background], tHex[background])
    end
end

return ScrollFrame

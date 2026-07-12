-- Shared scrolling and internal scrollbar rendering for all Containers.

local scroll = {}

local function clamp(value, minimum, maximum)
    if value < minimum then return minimum end
    if value > maximum then return maximum end
    return value
end

local function offsets(self)
    return rawget(self, "_scrollX") or 0, rawget(self, "_scrollY") or 0
end

local function maxOffsets(self)
    return math.max(0, (rawget(self, "_contentWidth") or 0) - self.width),
        math.max(0, (rawget(self, "_contentHeight") or 0) - self.height)
end

local function barMode(self)
    local mode = self.scrollbar
    if mode ~= "auto" and mode ~= "always" and mode ~= "hidden" then
        error("Basalt scroll: scrollbar must be 'auto', 'always' or 'hidden'", 3)
    end
    return mode
end

function scroll.disable(self)
    rawset(self, "_scrollX", 0)
    rawset(self, "_scrollY", 0)
    rawset(self, "_showScrollX", false)
    rawset(self, "_showScrollY", false)
    rawset(self, "_scrollDrag", nil)
    rawset(self, "_viewportDirty", true)
end

function scroll.setup(self)
    rawset(self, "_scrollX", 0)
    rawset(self, "_scrollY", 0)
    rawset(self, "_contentWidth", 0)
    rawset(self, "_contentHeight", 0)

    self:on("drag", function(s, _, x, y)
        scroll.drag(s, x, y)
    end)
    self:on("clickUp", function(s)
        rawset(s, "_scrollDrag", nil)
    end)
end

--- Recomputes content bounds and visible scrollbar state after layout.
function scroll.update(self)
    local children = self:getChildren()
    local contentWidth, contentHeight = 0, 0
    for i = 1, #children do
        local child = children[i]
        if child.visible then
            contentWidth = math.max(contentWidth, child.x + child.width - 1)
            contentHeight = math.max(contentHeight, child.y + child.height - 1)
        end
    end
    rawset(self, "_contentWidth", contentWidth)
    rawset(self, "_contentHeight", contentHeight)

    if not self.scrollable then
        scroll.disable(self)
        return
    end

    local mode = barMode(self)
    local overflowX = self.scrollXEnabled and contentWidth > self.width
    local overflowY = self.scrollYEnabled and contentHeight > self.height
    rawset(self, "_showScrollX", mode ~= "hidden"
        and self.scrollXEnabled and (mode == "always" or overflowX))
    rawset(self, "_showScrollY", mode ~= "hidden"
        and self.scrollYEnabled and (mode == "always" or overflowY))

    local maxX, maxY = maxOffsets(self)
    local x, y = offsets(self)
    rawset(self, "_scrollX", self.scrollXEnabled and clamp(x, 0, maxX) or 0)
    rawset(self, "_scrollY", self.scrollYEnabled and clamp(y, 0, maxY) or 0)
    rawset(self, "_viewportDirty", true)
end

local function thumb(trackLength, viewport, content, offset, maximum)
    if trackLength <= 0 then return 1, 0 end
    local size = math.max(1, math.floor(trackLength * viewport
        / math.max(content, viewport)))
    size = math.min(trackLength, size)
    local travel = trackLength - size
    local pos = maximum > 0 and math.floor(travel * offset / maximum + 0.5) or 0
    return size, pos
end

function scroll.geometry(self)
    local showX = rawget(self, "_showScrollX") == true
    local showY = rawget(self, "_showScrollY") == true
    local x, y = offsets(self)
    local maxX, maxY = maxOffsets(self)
    local horizontalLength = math.max(0, self.width - (showY and 1 or 0))
    local verticalLength = math.max(0, self.height - (showX and 1 or 0))
    local hSize, hPos = thumb(horizontalLength, self.width,
        rawget(self, "_contentWidth") or 0, x, maxX)
    local vSize, vPos = thumb(verticalLength, self.height,
        rawget(self, "_contentHeight") or 0, y, maxY)
    return {
        showX = showX, showY = showY,
        horizontalLength = horizontalLength,
        verticalLength = verticalLength,
        horizontalThumbSize = hSize,
        horizontalThumbPos = hPos,
        verticalThumbSize = vSize,
        verticalThumbPos = vPos,
        maxX = maxX, maxY = maxY,
    }
end

function scroll.draw(self, buf)
    if not self.scrollable then return end
    local g = scroll.geometry(self)
    local track, thumbColor = self.scrollbarColor, self.scrollbarThumbColor
    if g.showY and g.verticalLength > 0 then
        buf:fill(self.width, 1, 1, g.verticalLength, " ", self.foreground, track)
        buf:fill(self.width, g.verticalThumbPos + 1, 1, g.verticalThumbSize,
            " ", self.foreground, thumbColor)
    end
    if g.showX and g.horizontalLength > 0 then
        buf:fill(1, self.height, g.horizontalLength, 1, " ", self.foreground, track)
        buf:fill(g.horizontalThumbPos + 1, self.height,
            g.horizontalThumbSize, 1, " ", self.foreground, thumbColor)
    end
    if g.showX and g.showY then
        buf:fill(self.width, self.height, 1, 1, " ", self.foreground, track)
    end
end

function scroll.set(self, x, y, emit)
    if not self.scrollable then return false end
    local oldX, oldY = offsets(self)
    local maxX, maxY = maxOffsets(self)
    x = self.scrollXEnabled and clamp(math.floor(x or oldX), 0, maxX) or 0
    y = self.scrollYEnabled and clamp(math.floor(y or oldY), 0, maxY) or 0
    if x == oldX and y == oldY then return false end
    rawset(self, "_scrollX", x)
    rawset(self, "_scrollY", y)
    rawset(self, "_viewportDirty", true)
    self:markRenderDirty()
    if emit ~= false then self:fire("scrollChange", x, y) end
    return true
end

function scroll.wheel(self, direction)
    if not self.scrollable then return false end
    local x, y = offsets(self)
    local amount = direction * math.max(1, math.floor(self.scrollStep))
    if self.scrollYEnabled and (rawget(self, "_contentHeight") or 0) > self.height then
        return scroll.set(self, x, y + amount)
    elseif self.scrollXEnabled then
        return scroll.set(self, x + amount, y)
    end
    return false
end

function scroll.isBarPoint(self, x, y)
    if not self.scrollable then return false end
    local g = scroll.geometry(self)
    if g.showY and x == self.width and y <= g.verticalLength then return "y", g end
    if g.showX and y == self.height and x <= g.horizontalLength then return "x", g end
    if g.showX and g.showY and x == self.width and y == self.height then return "corner", g end
    return false, g
end

function scroll.pointerDown(self, x, y)
    local axis, g = scroll.isBarPoint(self, x, y)
    if axis == "corner" or not axis then return axis == "corner" end

    local isY = axis == "y"
    local coordinate = isY and y or x
    local thumbPos = isY and g.verticalThumbPos or g.horizontalThumbPos
    local thumbSize = isY and g.verticalThumbSize or g.horizontalThumbSize
    local trackLength = isY and g.verticalLength or g.horizontalLength
    local maximum = isY and g.maxY or g.maxX
    local thumbStart = thumbPos + 1

    if coordinate >= thumbStart and coordinate < thumbStart + thumbSize then
        rawset(self, "_scrollDrag", {
            axis = axis,
            grab = coordinate - thumbStart,
        })
    else
        local travel = math.max(1, trackLength - thumbSize)
        local target = math.floor((coordinate - 1 - thumbSize / 2)
            / travel * maximum + 0.5)
        local sx, sy = offsets(self)
        scroll.set(self, isY and sx or target, isY and target or sy)
    end
    return true
end

function scroll.drag(self, x, y)
    local dragState = rawget(self, "_scrollDrag")
    if not dragState then return false end
    local g = scroll.geometry(self)
    local isY = dragState.axis == "y"
    local coordinate = isY and y or x
    local size = isY and g.verticalThumbSize or g.horizontalThumbSize
    local length = isY and g.verticalLength or g.horizontalLength
    local maximum = isY and g.maxY or g.maxX
    local travel = math.max(1, length - size)
    local pos = clamp(coordinate - 1 - dragState.grab, 0, travel)
    local target = math.floor(pos / travel * maximum + 0.5)
    local sx, sy = offsets(self)
    return scroll.set(self, isY and sx or target, isY and target or sy)
end

return scroll

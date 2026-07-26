-- Shared vertical item viewport helpers for List and Dropdown.

---@alias ItemViewScrollbarMode "auto"|"always"|"hidden"

---@class ItemViewGeometry
---@field show boolean Whether the scrollbar is visible
---@field rows integer Visible row count
---@field maximum integer Greatest valid item offset
---@field offset integer Clamped current item offset
---@field thumbSize integer Scrollbar thumb size
---@field thumbPos integer Zero-based scrollbar thumb position

local itemview = {}

--- Returns the greatest valid item offset for a viewport.
---@param count integer Item count
---@param rows integer Visible row count
---@return integer offset
function itemview.maxOffset(count, rows)
    return math.max(0, count - math.max(0, rows))
end

--- Clamps an item offset to the visible collection range.
---@param offset? number Requested offset
---@param count integer Item count
---@param rows integer Visible row count
---@return integer offset
function itemview.clampOffset(offset, count, rows)
    return math.max(0, math.min(math.floor(offset or 0),
        itemview.maxOffset(count, rows)))
end

--- Adjusts an offset until the requested item is visible.
---@param offset number Current offset
---@param index? integer Item index
---@param count integer Item count
---@param rows integer Visible row count
---@return integer offset
function itemview.ensureVisible(offset, index, count, rows)
    offset = itemview.clampOffset(offset, count, rows)
    if not index or index < 1 then return offset end
    if index <= offset then offset = index - 1 end
    if index > offset + rows then offset = index - rows end
    return itemview.clampOffset(offset, count, rows)
end

--- Calculates scrollbar geometry for an item viewport.
---@param count integer Item count
---@param rows integer Visible row count
---@param offset? number Current item offset
---@param mode ItemViewScrollbarMode Scrollbar mode
---@return ItemViewGeometry geometry
function itemview.geometry(count, rows, offset, mode)
    if mode ~= "auto" and mode ~= "always" and mode ~= "hidden" then
        error("Basalt item scrollbar: expected 'auto', 'always' or 'hidden'", 3)
    end
    rows = math.max(0, math.floor(rows or 0))
    local maximum = itemview.maxOffset(count, rows)
    offset = itemview.clampOffset(offset, count, rows)
    local show = mode ~= "hidden" and rows > 0
        and (mode == "always" or maximum > 0)
    local thumbSize = rows
    local thumbPos = 0
    if show and rows > 0 then
        thumbSize = math.max(1, math.floor(rows * rows / math.max(count, rows)))
        thumbSize = math.min(rows, thumbSize)
        local travel = rows - thumbSize
        thumbPos = maximum > 0
            and math.floor(travel * offset / maximum + 0.5) or 0
    end
    return {
        show = show,
        rows = rows,
        maximum = maximum,
        offset = offset,
        thumbSize = thumbSize,
        thumbPos = thumbPos,
    }
end

--- Draws the scrollbar(s) into the buffer.
---@param buf Render Render buffer
---@param x integer Scrollbar x position
---@param y integer Scrollbar y position
---@param geometry ItemViewGeometry Viewport geometry
---@param foreground number Foreground color
---@param track number Track color
---@param thumb number Thumb color
function itemview.draw(buf, x, y, geometry, foreground, track, thumb)
    if not geometry.show or geometry.rows <= 0 then return end
    buf:fill(x, y, 1, geometry.rows, " ", foreground, track)
    buf:fill(x, y + geometry.thumbPos, 1, geometry.thumbSize,
        " ", foreground, thumb)
end

--- Resolves a scrollbar press into a new offset or drag grab position.
---@param coordinate integer Coordinate along the scrollbar
---@param geometry ItemViewGeometry Geometry returned by itemview.geometry
---@return integer|nil offset
---@return integer|nil grab
function itemview.pointerDown(coordinate, geometry)
    if not geometry.show then return nil, nil end
    local thumbStart = geometry.thumbPos + 1
    if coordinate >= thumbStart
        and coordinate < thumbStart + geometry.thumbSize then
        return geometry.offset, coordinate - thumbStart
    end
    local travel = math.max(1, geometry.rows - geometry.thumbSize)
    local target = math.floor((coordinate - 1 - geometry.thumbSize / 2)
        / travel * geometry.maximum + 0.5)
    return itemview.clampOffset(target,
        geometry.maximum + geometry.rows, geometry.rows), nil
end

--- Converts a scrollbar drag position into an item offset.
---@param coordinate integer Coordinate along the scrollbar
---@param grab integer Thumb grab offset
---@param geometry ItemViewGeometry Geometry returned by itemview.geometry
---@return integer offset
function itemview.drag(coordinate, grab, geometry)
    local travel = math.max(1, geometry.rows - geometry.thumbSize)
    local pos = math.max(0, math.min(travel, coordinate - 1 - grab))
    local target = math.floor(pos / travel * geometry.maximum + 0.5)
    return itemview.clampOffset(target,
        geometry.maximum + geometry.rows, geometry.rows)
end

return itemview

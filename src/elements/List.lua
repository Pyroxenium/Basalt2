-- List: scrollable item list with single selection, fires "select".

local require = ...
local class = require("core/class")
local Collection = require("elements/Collection")
local itemview = require("core/itemview")

---@class List : Collection
---@field public offset number Item offset above the viewport
---@field public emptyText any Empty-list hint rendered with `tostring`
---@field public emptyTextColor number Empty-list hint color
---@field public scrollbar ItemViewScrollbarMode Scrollbar mode
---@field public scrollbarColor number Scrollbar track color
---@field public scrollbarThumbColor number Scrollbar thumb color
---@field private _itemScrollDrag? integer Active scrollbar grab offset
local List = class.create("List", Collection)

class.property(List, "offset", 0) -- first visible item index minus one
class.property(List, "emptyText", "") -- centered hint while the list is empty
--- Color of the empty-list hint
class.property(List, "emptyTextColor", colors.gray)
--- Background color (false = transparent)
class.property(List, "background", colors.black)
--- Width in terminal cells
class.property(List, "width", 16)
--- Height in terminal cells
class.property(List, "height", 8)
class.property(List, "scrollbar", "auto") -- "auto", "always" or "hidden"
--- Scrollbar track color
class.property(List, "scrollbarColor", colors.gray)
--- Scrollbar thumb color
class.property(List, "scrollbarThumbColor", colors.lightGray)

---@param self List
---@return integer offset
local function maxOffset(self)
    return itemview.maxOffset(#self.items, self.height)
end

--- Returns the scrollbar geometry (show, offset, thumb size/position, ...).
---@return ItemViewGeometry geometry The itemview geometry for the current state
function List:getScrollInfo()
    return itemview.geometry(#self.items, self.height, self.offset, self.scrollbar)
end

--- Scrolls to an absolute offset (clamped to the content).
---@param offset number Items scrolled past above the viewport
---@return self
function List:setOffset(offset)
    self.offset = itemview.clampOffset(offset, #self.items, self.height)
    return self
end

--- Scrolls the given item index into view.
---@param index number The item index to make visible
---@return self
function List:scrollToItem(index)
    self.offset = itemview.ensureVisible(self.offset, index,
        #self.items, self.height)
    return self
end

--- Selects an item (index or value) and scrolls it into view.
---@param value any Item index or item value
---@param emit? boolean false suppresses the select event
---@return self
function List:selectItem(value, emit)
    Collection.selectItem(self, value, emit)
    local index = self:indexOfItem(value) or self:getSelectedIndex()
    if index then self:scrollToItem(index) end
    return self
end

--- Initializes per-instance state and input handlers.
function List:setup()
    Collection.setup(self)

    self:on("click", function(s, _, x, y)
        local geometry = s:getScrollInfo()
        if geometry.show and x == s.width then
            local target, grab = itemview.pointerDown(y, geometry)
            s:setOffset(target)
            if grab ~= nil then rawset(s, "_itemScrollDrag", grab) end
            return
        end
        local idx = s.offset + y
        if s.items[idx] ~= nil then
            s:select(idx)
        end
    end)
    self:on("drag", function(s, _, _, y)
        local grab = rawget(s, "_itemScrollDrag")
        if grab ~= nil then
            s:setOffset(itemview.drag(y, grab, s:getScrollInfo()))
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_itemScrollDrag", nil)
    end)
end

--- The mouse wheel scrolls the list.
---@param event string The mouse event name
---@param btn number Button or scroll direction
---@param x number Local x coordinate
---@param y number Local y coordinate
---@return Element|nil consumer The consuming element, or nil to pass through
function List:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" then
        if self.disabled then return nil end
        local old = self.offset
        self:setOffset(old + btn)
        local userHandled = self:fire("scroll", btn, x, y)
        if self.offset ~= old or userHandled then return self end
        return nil
    end
    return Collection.handleMouse(self, event, btn, x, y)
end

--- Removes an item and keeps the scroll offset valid.
---@param index number The item index to remove
---@return self
function List:removeItem(index)
    Collection.removeItem(self, index)
    if self.offset > maxOffset(self) then self.offset = maxOffset(self) end
    self:markDirty()
    return self
end

--- Keyboard navigation: arrows, home/end, pageUp/pageDown, enter activates.
---@param event string The key event name
---@param a any Key code or character
---@param b? any Secondary key-event value
function List:handleKey(event, a, b)
    if event == "key" and #self.items > 0 then
        local selected = self.selected or 0
        if a == keys.up then
            self:selectItem(selected > 1 and selected - 1 or 1)
        elseif a == keys.down then
            self:selectItem(selected > 0 and math.min(#self.items, selected + 1) or 1)
        elseif a == keys.home then
            self:selectItem(1)
        elseif a == keys["end"] then
            self:selectItem(#self.items)
        elseif a == keys.pageUp then
            self:selectItem(math.max(1, (selected > 0 and selected or 1) - self.height))
        elseif a == keys.pageDown then
            self:selectItem(math.min(#self.items,
                (selected > 0 and selected or 1) + self.height))
        elseif a == keys.enter and selected > 0 then
            self:activateItem(selected)
        end
    end
    Collection.handleKey(self, event, a, b)
end

--- Removes all items and resets scrolling.
---@return self
function List:clear()
    Collection.clear(self)
    self.offset = 0
    return self
end

--- Renders visible items; supports separator items and per-item colors
--- (item.fg/item.bg/item.selectedFg/item.selectedBg). An item may also
--- provide iconChar/iconX plus iconForeground/iconBackground colors for a
--- separately colored 1x1 glyph inside its text.
---@param buf Render The render buffer
function List:render(buf)
    Collection.render(self, buf)
    local items = self.items
    local w, h = self.width, self.height

    if #items == 0 and #tostring(self.emptyText) > 0 then
        local label = tostring(self.emptyText):sub(1, w)
        buf:blit(math.floor((w - #label) / 2) + 1,
            math.floor((h - 1) / 2) + 1, label, self.emptyTextColor, nil)
        return
    end

    local off = itemview.clampOffset(self.offset, #items, h)
    rawget(self, "_p").offset = off
    local geometry = self:getScrollInfo()
    local textWidth = math.max(0, w - (geometry.show and 1 or 0))
    ---@param item CollectionEntry
    ---@param row integer
    ---@param selected boolean
    ---@param rowBackground number|false
    local function drawIcon(item, row, selected, rowBackground)
        local icon = item.iconChar
        if type(icon) == "number" then icon = string.char(icon) end
        if type(icon) ~= "string" or #icon == 0 then return end
        local x = math.floor(tonumber(item.iconX) or 1)
        if x < 1 or x > textWidth then return end
        local foreground = selected and item.selectedIconForeground
            or item.iconForeground or rowBackground
        local background = selected and item.selectedIconBackground
            or item.iconBackground
        buf:blit(x, row, icon:sub(1, 1), foreground, background)
    end
    for row = 1, h do
        local idx = off + row
        local item = items[idx]
        if item == nil then break end
        local text = tostring(item)
        if item.separator then
            local symbol = text ~= "" and text:sub(1, 1) or "-"
            buf:blit(1, row, symbol:rep(textWidth),
                item.fg or self.foreground, item.bg)
        elseif self:isSelected(idx) then
            local foreground = item.selectedFg or self.selectionForeground
            local background = item.selectedBg or self.selectionBackground
            buf:fill(1, row, textWidth, 1, " ", foreground, background)
            buf:blit(1, row, text:sub(1, textWidth), foreground, background)
            drawIcon(item, row, true, background)
        else
            local foreground = item.fg or self.foreground
            local background = item.bg
            if background then
                buf:fill(1, row, textWidth, 1, " ", foreground, background)
            end
            buf:blit(1, row, text:sub(1, textWidth), foreground, background)
            drawIcon(item, row, false, background or self.background)
        end
    end
    itemview.draw(buf, w, 1, geometry, self.foreground,
        self.scrollbarColor, self.scrollbarThumbColor)
end

return List

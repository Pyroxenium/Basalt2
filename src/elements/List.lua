-- List: scrollable item list with single selection, fires "select".

local require = ...
local class = require("core/class")
local Collection = require("elements/Collection")
local itemview = require("core/itemview")

local List = class.create("List", Collection)

class.property(List, "offset", 0)
class.property(List, "emptyText", "")
class.property(List, "emptyTextColor", colors.gray)
class.property(List, "background", colors.black)
class.property(List, "width", 16)
class.property(List, "height", 8)
class.property(List, "scrollbar", "auto")
class.property(List, "scrollbarColor", colors.gray)
class.property(List, "scrollbarThumbColor", colors.lightGray)

local function maxOffset(self)
    return itemview.maxOffset(#self.items, self.height)
end

function List:getScrollInfo()
    return itemview.geometry(#self.items, self.height, self.offset, self.scrollbar)
end

function List:setOffset(offset)
    self.offset = itemview.clampOffset(offset, #self.items, self.height)
    return self
end

function List:scrollToItem(index)
    self.offset = itemview.ensureVisible(self.offset, index,
        #self.items, self.height)
    return self
end

function List:selectItem(value, emit)
    Collection.selectItem(self, value, emit)
    local index = self:indexOfItem(value) or self:getSelectedIndex()
    if index then self:scrollToItem(index) end
    return self
end

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

function List:removeItem(index)
    Collection.removeItem(self, index)
    if self.offset > maxOffset(self) then self.offset = maxOffset(self) end
    self:markDirty()
    return self
end

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

function List:clear()
    Collection.clear(self)
    self.offset = 0
    return self
end

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
        else
            local foreground = item.fg or self.foreground
            local background = item.bg
            if background then
                buf:fill(1, row, textWidth, 1, " ", foreground, background)
            end
            buf:blit(1, row, text:sub(1, textWidth), foreground, background)
        end
    end
    itemview.draw(buf, w, 1, geometry, self.foreground,
        self.scrollbarColor, self.scrollbarThumbColor)
end

return List

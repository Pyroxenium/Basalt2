-- Dropdown: collapsed selection row that expands to an item list.
-- Fires "select"; closes on selection, on toggle, or when focus moves away.

local require = ...
local class = require("core/class")
local Collection = require("elements/Collection")
local itemview = require("core/itemview")

---@class Dropdown : Collection
---@field public text any Placeholder rendered with `tostring`
---@field public dropHeight number Maximum expanded-list height
---@field public offset number Expanded-list item offset
---@field public dropBackground number Expanded-list background
---@field public scrollbar ItemViewScrollbarMode Expanded-list scrollbar mode
---@field public scrollbarColor number Scrollbar track color
---@field public scrollbarThumbColor number Scrollbar thumb color
---@field public open boolean Whether the list is expanded
---@field private _zBefore? number Stacking order before expansion
---@field private _highlighted? integer Highlighted item index
---@field private _itemScrollDrag? integer Active scrollbar grab offset
local Dropdown = class.create("Dropdown", Collection)

class.property(Dropdown, "text", "Select...") -- placeholder while nothing is selected
class.property(Dropdown, "dropHeight", 6) -- maximum visible list rows
class.property(Dropdown, "offset", 0) -- list scroll offset
--- Background color (false = transparent)
class.property(Dropdown, "background", colors.gray)
class.property(Dropdown, "dropBackground", colors.black) -- open list background
--- Width in terminal cells
class.property(Dropdown, "width", 14)
class.property(Dropdown, "scrollbar", "auto") -- "auto", "always" or "hidden"
--- Scrollbar track color
class.property(Dropdown, "scrollbarColor", colors.gray)
--- Scrollbar thumb color
class.property(Dropdown, "scrollbarThumbColor", colors.lightGray)
--- Follows the open state; setting it explicitly breaks expansion
class.property(Dropdown, "height", function(self)
    if self.open then
        return 1 + math.min(#self.items, self.dropHeight)
    end
    return 1
end)
--- Whether the list is expanded; the element floats above siblings while open
class.property(Dropdown, "open", false, {
    onChange = function(self, v)
        -- float above siblings while expanded
        if v then
            rawset(self, "_zBefore", self.z)
            self.z = 999
            local highlighted = self.selected or (#self.items > 0 and 1 or nil)
            rawset(self, "_highlighted", highlighted)
            self.offset = itemview.ensureVisible(self.offset, highlighted,
                #self.items, math.min(#self.items, self.dropHeight))
        else
            self.z = rawget(self, "_zBefore") or self.z
            rawset(self, "_itemScrollDrag", nil)
        end
    end,
})

---@param self Dropdown
---@return integer rows
local function visibleRows(self)
    return math.min(#self.items, math.max(0, self.dropHeight))
end

--- Returns the scrollbar geometry of the open list.
---@return ItemViewGeometry geometry The itemview geometry
function Dropdown:getScrollInfo()
    return itemview.geometry(#self.items, visibleRows(self),
        self.offset, self.scrollbar)
end

--- Scrolls the open list to an absolute offset (clamped).
---@param offset number Items scrolled past above the viewport
---@return self
function Dropdown:setOffset(offset)
    self.offset = itemview.clampOffset(offset, #self.items, visibleRows(self))
    return self
end

--- Scrolls the given item index into the visible list area.
---@param index number The item index to make visible
---@return self
function Dropdown:scrollToItem(index)
    self.offset = itemview.ensureVisible(self.offset, index,
        #self.items, visibleRows(self))
    return self
end

--- Selects an item, closes the list and fires the select event.
---@param index integer The item index to select
---@param emit? boolean false suppresses the select event
---@return self
function Dropdown:select(index, emit)
    if not index or self.items[index] == nil then return self end
    Collection.select(self, index, emit)
    rawset(self, "_highlighted", index)
    self:scrollToItem(index)
    self.open = false
    return self
end

--- Initializes per-instance state and input handlers.
function Dropdown:setup()
    Collection.setup(self)

    self:on("click", function(s, _, x, y)
        if y == 1 then
            s.open = not s.open
        else
            local geometry = s:getScrollInfo()
            if geometry.show and x == s.width then
                local target, grab = itemview.pointerDown(y - 1, geometry)
                if target ~= nil then s:setOffset(target) end
                if grab ~= nil then rawset(s, "_itemScrollDrag", grab) end
                return
            end
            local idx = s.offset + y - 1
            if s.items[idx] ~= nil then
                s:select(idx)
            end
        end
    end)
    self:on("drag", function(s, _, _, y)
        local grab = rawget(s, "_itemScrollDrag")
        if grab ~= nil then
            s:setOffset(itemview.drag(y - 1, grab, s:getScrollInfo()))
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_itemScrollDrag", nil)
    end)
    self:on("blur", function(s)
        s.open = false
    end)
end

--- Removes all entries and resets selection, scroll and open state.
---@return self
function Dropdown:clear()
    Collection.clear(self)
    self.open = false
    self.offset = 0
    rawset(self, "_highlighted", nil)
    self:markDirty()
    return self
end

--- Removes an entry and clamps the dropdown scroll offset.
---@param index integer|CollectionEntry Item index or entry
---@return self
function Dropdown:removeItem(index)
    Collection.removeItem(self, index)
    self:setOffset(self.offset)
    self:markDirty()
    return self
end

--- Routes mouse input in local coordinates (wheel scrolling etc.).
---@param event string The mouse event name
---@param btn number Button or scroll direction
---@param x number Local x coordinate
---@param y number Local y coordinate
---@return Element|nil consumer The consuming element, or nil to pass through
function Dropdown:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" and not self.open then return nil end
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

--- Handles keyboard input while focused.
---@param event string The key event name (key, key_up, char, paste)
---@param a any Key code or typed text
---@param b? any Secondary key-event value
function Dropdown:handleKey(event, a, b)
    if event == "key" then
        if not self.open then
            if a == keys.enter or a == keys.space
                or a == keys.down or a == keys.up then
                self.open = true
            end
        else
            local count = #self.items
            local highlighted = rawget(self, "_highlighted") or 0
            if a == keys.escape then
                self.open = false
            elseif a == keys.enter or a == keys.space then
                if highlighted > 0 then self:select(highlighted) end
            elseif count > 0 then
                if a == keys.up then
                    highlighted = math.max(1, highlighted > 0 and highlighted - 1 or 1)
                elseif a == keys.down then
                    highlighted = math.min(count, highlighted > 0 and highlighted + 1 or 1)
                elseif a == keys.home then
                    highlighted = 1
                elseif a == keys["end"] then
                    highlighted = count
                elseif a == keys.pageUp then
                    highlighted = math.max(1, highlighted - visibleRows(self))
                elseif a == keys.pageDown then
                    highlighted = math.min(count, highlighted + visibleRows(self))
                end
                rawset(self, "_highlighted", highlighted)
                self:scrollToItem(highlighted)
                self:markDirty()
            end
        end
    end
    Collection.handleKey(self, event, a, b)
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function Dropdown:render(buf)
    local w = self.width
    local fg, bg = self.foreground, self.background
    local items, sel = self.items, self.selected
    local clampedOffset = itemview.clampOffset(self.offset,
        #items, visibleRows(self))
    rawget(self, "_p").offset = clampedOffset

    buf:fill(1, 1, w, 1, " ", fg, bg)
    local title = (sel and items[sel] ~= nil)
        and tostring(items[sel]) or tostring(self.text)
    buf:blit(1, 1, title:sub(1, w - 2), fg, bg)
    buf:blit(w, 1, self.open and "\30" or "\31", fg, bg)

    if self.open then
        local geometry = self:getScrollInfo()
        local highlighted = rawget(self, "_highlighted")
        local textWidth = math.max(0, w - (geometry.show and 1 or 0))
        for row = 1, self.height - 1 do
            local idx = clampedOffset + row
            local item = items[idx]
            local isSel = highlighted == idx or (not highlighted and sel == idx)
            local rfg = isSel and (item and item.selectedFg or self.selectionForeground)
                or (item and item.fg or fg)
            local rbg = isSel and (item and item.selectedBg or self.selectionBackground)
                or (item and item.bg or self.dropBackground)
            buf:fill(1, 1 + row, textWidth, 1, " ", rfg, rbg)
            buf:blit(1, 1 + row, tostring(item or ""):sub(1, textWidth), rfg, rbg)
        end
        itemview.draw(buf, w, 2, geometry, fg,
            self.scrollbarColor, self.scrollbarThumbColor)
    end
end

return Dropdown

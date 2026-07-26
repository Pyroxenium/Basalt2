-- Menu: horizontal menu bar with optional dropdown submenus and separators.
--
-- items entries:
--   "Save"                                 plain item
--   { text = "File", items = {"New", "Open"} }   item with submenu
--   { separator = true }                   vertical separator
--
-- Fires "select"(index, item) for plain items and
-- "select"(subIndex, subItem, parentIndex) for submenu entries.

local require = ...
local class = require("core/class")
local Collection = require("elements/Collection")

---@alias MenuSpan [number, number, string]

---@class MenuSubmenuBox
---@field x number Local x coordinate
---@field width number Box width
---@field items (CollectionItem|string)[]
---@field parent integer Parent item index

---@class Menu : Collection
---@field public spacing number Gap between top-level entries
---@field public separatorColor number Separator color
---@field public dropBackground number Expanded-list background
---@field private _openIndex? integer Open top-level submenu index
---@field private _zBefore? number Stacking order before expansion
local Menu = class.create("Menu", Collection)

---@param item any
---@return string label
local function labelOf(item)
    if type(item) == "table" then
        if item.separator then return "\149" end
        return tostring(item.text)
    end
    return tostring(item)
end

---@param item any
---@return boolean separator
local function isSeparator(item)
    return type(item) == "table" and item.separator == true
end

---@param item any
---@return (CollectionItem|string)[]? items
local function submenuItems(item)
    return type(item) == "table" and (item.items or item.dropdown) or nil
end

--- Returns {x1, x2, label} per item plus the total width.
---@param self Menu
---@return MenuSpan[] spans
---@return number width
local function spans(self)
    local out = {}
    local x = 1
    for i, item in ipairs(self.items) do
        local label = isSeparator(item)
            and labelOf(item) or (" " .. labelOf(item) .. " ")
        out[i] = { x, x + #label - 1, label }
        x = x + #label + self.spacing
    end
    return out, math.max(1, x - self.spacing - 1)
end

---@param self Menu
---@return MenuSubmenuBox? box
local function submenuBox(self)
    local index = rawget(self, "_openIndex")
    if not index then return nil end
    local item = self.items[index]
    local children = submenuItems(item)
    if not children then return nil end
    local itemSpans = spans(self)
    local w = 1
    for _, sub in ipairs(children) do
        w = math.max(w, #tostring(sub) + 2)
    end
    local x = math.min(itemSpans[index][1], math.max(1, self.width - w + 1))
    return { x = x, width = w, items = children, parent = index }
end

--- Gap between menu entries
class.property(Menu, "spacing", 1)
--- Background color (false = transparent)
class.property(Menu, "background", colors.gray)
--- Color of separator entries
class.property(Menu, "separatorColor", colors.lightGray)
--- Background of the expanded list
class.property(Menu, "dropBackground", colors.black)
--- Width in terminal cells
class.property(Menu, "width", function(self)
    local _, total = spans(self)
    return total
end)
--- Height in terminal cells
class.property(Menu, "height", function(self)
    local box = submenuBox(self)
    return box and (1 + #box.items) or 1
end)

---@param self Menu
local function closeSubmenu(self)
    if rawget(self, "_openIndex") then
        rawset(self, "_openIndex", nil)
        self.z = rawget(self, "_zBefore") or self.z
        self:markDirty()
    end
end

---@param self Menu
---@param index integer
local function openSubmenu(self, index)
    rawset(self, "_zBefore", self.z)
    rawset(self, "_openIndex", index)
    self.z = 999
    self:markDirty()
end

--- Selects a top-level item; items with a submenu toggle it open instead.
---@param index integer The item index
---@param emit? boolean false suppresses the select event
---@return self
function Menu:select(index, emit)
    local item = self.items[index]
    if item == nil or isSeparator(item) then return self end
    if submenuItems(item) then
        if rawget(self, "_openIndex") == index then
            closeSubmenu(self)
        else
            openSubmenu(self, index)
        end
        return self
    end
    closeSubmenu(self)
    Collection.select(self, index, emit)
    return self
end

--- Initializes per-instance state and input handlers.
function Menu:setup()
    Collection.setup(self)

    self:on("click", function(s, _, x, y)
        if y == 1 then
            for i, span in ipairs(spans(s)) do
                if x >= span[1] and x <= span[2] then
                    s:select(i)
                    return
                end
            end
            closeSubmenu(s)
        else
            local box = submenuBox(s)
            if box and x >= box.x and x < box.x + box.width
                and box.items[y - 1] ~= nil then
                local subIndex = y - 1
                local subItem = box.items[subIndex]
                closeSubmenu(s)
                if type(subItem) == "table" and type(subItem.callback) == "function" then
                    subItem.callback(s, subItem)
                end
                s:fire("select", subIndex, tostring(subItem), box.parent)
            else
                closeSubmenu(s)
            end
        end
    end)
    self:on("blur", function(s) closeSubmenu(s) end)
end

--- Handles keyboard input while focused.
---@param event string The key event name (key, key_up, char, paste)
---@param a any Key code or typed text
---@param b? any Secondary key-event value
function Menu:handleKey(event, a, b)
    if event == "key" and #self.items > 0 then
        local selected = self.selected or 0
        if a == keys.left then
            self:select(math.max(1, selected > 0 and selected - 1 or 1), false)
        elseif a == keys.right then
            self:select(selected > 0
                and math.min(#self.items, selected + 1) or 1, false)
        elseif a == keys.escape then
            closeSubmenu(self)
        elseif a == keys.enter and selected > 0 then
            self:select(selected)
        end
    end
    Collection.handleKey(self, event, a, b)
end

--- Removes all menu entries and closes any open submenu.
---@return self
function Menu:clear()
    Collection.clear(self)
    closeSubmenu(self)
    self:markDirty()
    return self
end

--- Intrinsic size for basalt.auto().
---@return number width The measured width
---@return number height The measured height
function Menu:measure()
    local _, total = spans(self)
    return total, 1
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function Menu:render(buf)
    local fg, bg = self.foreground, self.background
    buf:fill(1, 1, self.width, 1, " ", fg, bg)
    local sel = self.selected
    local openIndex = rawget(self, "_openIndex")
    for i, span in ipairs(spans(self)) do
        local item = self.items[i]
        if isSeparator(item) then
            buf:blit(span[1], 1, span[3], self.separatorColor, bg)
        elseif i == sel or i == openIndex then
            buf:blit(span[1], 1, span[3],
                self.selectionForeground, self.selectionBackground)
        else
            buf:blit(span[1], 1, span[3], fg, bg)
        end
    end

    local box = submenuBox(self)
    if box then
        for row, sub in ipairs(box.items) do
            buf:fill(box.x, 1 + row, box.width, 1, " ", fg, self.dropBackground)
            buf:blit(box.x + 1, 1 + row,
                tostring(sub):sub(1, box.width - 2), fg, self.dropBackground)
        end
    end
end

return Menu

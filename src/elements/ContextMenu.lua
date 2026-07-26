-- ContextMenu: floating menu opened at a position (e.g. on right-click).
--
--   local cm = frame:addContextMenu()
--   cm:setItems({ "Copy", "Paste", { separator = true }, "Delete" })
--   someElement:onClick(function(_, btn, x, y)
--       if btn == 2 then cm:openAt(ax, ay) end   -- parent-local coordinates
--   end)
--   cm:onSelect(function(_, index, item) ... end)
--
-- Closes on selection, focus loss or escape.

local require = ...
local class = require("core/class")
local Collection = require("elements/Collection")

---@class ContextMenu : Collection
---@field public separatorColor number Separator color
---@field private _highlighted? integer Highlighted item index
local ContextMenu = class.create("ContextMenu", Collection)

--- Background color (false = transparent)
class.property(ContextMenu, "background", colors.black)
--- Color of separator entries
class.property(ContextMenu, "separatorColor", colors.gray)
--- Whether the element is shown and hit by events
class.property(ContextMenu, "visible", false)
--- Width in terminal cells
class.property(ContextMenu, "width", function(self)
    local w = 4
    for _, item in ipairs(self.items) do
        if not (type(item) == "table" and item.separator) then
            w = math.max(w, #tostring(item) + 2)
        end
    end
    return w
end)
--- Height in terminal cells
class.property(ContextMenu, "height", function(self)
    return math.max(1, #self.items)
end)

---@param item any
---@return boolean separator
local function isSeparator(item)
    return type(item) == "table" and item.separator == true
end

--- Initializes per-instance state and input handlers.
function ContextMenu:setup()
    Collection.setup(self)
    self.z = 1000

    self:on("click", function(s, _, _, y)
        local item = s.items[y]
        if item ~= nil and not isSeparator(item) and not item.disabled then
            s:activateItem(y)
            s:close()
        end
    end)
    self:on("blur", function(s) s:close() end)
end

--- Opens the menu at parent-local coordinates, clamped into the parent.
---@param x number Parent-local x position
---@param y number Parent-local y position
---@return self
function ContextMenu:openAt(x, y)
    local parent = rawget(self, "parent")
    if parent then
        x = math.max(1, math.min(x, parent.width - self.width + 1))
        y = math.max(1, math.min(y, parent.height - self.height + 1))
    end
    self.x, self.y = x, y
    self.visible = true
    self:focus()
    return self
end

--- Hides the menu.
---@return self
function ContextMenu:close()
    self.visible = false
    return self
end

--- Handles keyboard input while focused.
---@param event string The key event name (key, key_up, char, paste)
---@param a any Key code or typed text
---@param b? any Secondary key-event value
function ContextMenu:handleKey(event, a, b)
    if event == "key" then
        if a == keys.escape then
            self:close()
        elseif a == keys.enter then
            local hovered = rawget(self, "_highlighted")
            local item = hovered and self.items[hovered]
            if item and not isSeparator(item) and not item.disabled then
                self:activateItem(hovered)
                self:close()
            end
        elseif a == keys.up or a == keys.down then
            local count = #self.items
            local cur = rawget(self, "_highlighted") or 0
            local dir = a == keys.down and 1 or -1
            for _ = 1, count do -- skip separators
                cur = cur + dir
                if cur < 1 then cur = count elseif cur > count then cur = 1 end
                if not isSeparator(self.items[cur]) and not self.items[cur].disabled then break end
            end
            rawset(self, "_highlighted", cur)
            self:markDirty()
        end
    end
    Collection.handleKey(self, event, a, b)
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function ContextMenu:render(buf)
    local w = self.width
    local fg, bg = self.foreground, self.background
    local highlighted = rawget(self, "_highlighted")
    for row, item in ipairs(self.items) do
        if isSeparator(item) then
            buf:fill(1, row, w, 1, "\140", self.separatorColor, bg)
        elseif row == highlighted and not item.disabled then
            buf:fill(1, row, w, 1, " ",
                self.selectionForeground, self.selectionBackground)
            buf:blit(2, row, tostring(item):sub(1, w - 2),
                self.selectionForeground, self.selectionBackground)
        else
            local itemFg = item.fg or fg
            buf:fill(1, row, w, 1, " ", fg, bg)
            buf:blit(2, row, tostring(item):sub(1, w - 2), itemFg, bg)
        end
    end
end

return ContextMenu

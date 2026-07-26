-- ComboBox: an Input with an attached dropdown list.
-- With autoComplete = true the list filters while typing (case-insensitive
-- prefix match). Fires "select"(itemIndex, item) plus everything Input fires.

local require = ...
local class = require("core/class")
local Input = require("elements/Input")
local itemview = require("core/itemview")
local collection = require("core/collection")

---@class ComboBoxDisplayEntry
---@field index integer Original collection index
---@field text string Display text
---@field item CollectionEntry Original collection entry

---@class ComboBox : Input, CollectionMixin
---@field public dropHeight number Maximum expanded-list height
---@field public autoComplete boolean Whether typed text filters suggestions
---@field public offset number Expanded-list item offset
---@field public dropBackground number Expanded-list background
---@field public dropForeground number Expanded-list foreground
---@field public scrollbar ItemViewScrollbarMode Expanded-list scrollbar mode
---@field public scrollbarColor number Scrollbar track color
---@field public scrollbarThumbColor number Scrollbar thumb color
---@field public open boolean Whether the suggestion list is expanded
---@field private _zBefore? number Stacking order before expansion
---@field private _highlighted? integer Highlighted displayed-row index
---@field private _selecting? boolean Whether text is changing from selection
---@field private _itemScrollDrag? integer Active scrollbar grab offset
local ComboBox = class.create("ComboBox", Input)

collection.install(ComboBox, { changeEvent = "selectionChange" })
class.property(ComboBox, "dropHeight", 6) -- maximum visible list rows
class.property(ComboBox, "autoComplete", false) -- filter the list while typing
class.property(ComboBox, "offset", 0) -- list scroll offset
class.property(ComboBox, "dropBackground", colors.black) -- open list background
--- Text color of the expanded list
class.property(ComboBox, "dropForeground", colors.white)
class.property(ComboBox, "scrollbar", "auto") -- "auto", "always" or "hidden"
--- Scrollbar track color
class.property(ComboBox, "scrollbarColor", colors.gray)
--- Scrollbar thumb color
class.property(ComboBox, "scrollbarThumbColor", colors.lightGray)
--- Width in terminal cells
class.property(ComboBox, "width", 14)
--- Follows the open state; setting it explicitly breaks expansion
class.property(ComboBox, "height", function(self)
    if self.open then
        return 1 + math.min(#self:getDisplayItems(), self.dropHeight)
    end
    return 1
end)
--- Whether the list is expanded; floats above siblings while open
class.property(ComboBox, "open", false, {
    onChange = function(self, isOpen)
        if isOpen then
            rawset(self, "_zBefore", self.z)
            self.z = 999
            rawset(self, "_highlighted", 1)
            self.offset = 0
        else
            self.z = rawget(self, "_zBefore") or self.z
        end
    end,
})

--- The list as displayed: filtered while typing with autoComplete,
--- otherwise all items.
---@return ComboBoxDisplayEntry[] entries
function ComboBox:getDisplayItems()
    local items = self.items
    local out = {}
    local needle = self.autoComplete and self.text:lower() or ""
    for i = 1, #items do
        local label = tostring(items[i])
        if #needle == 0 or label:lower():sub(1, #needle) == needle then
            out[#out + 1] = { index = i, text = label, item = items[i] }
        end
    end
    return out
end

---@param self ComboBox
---@param display ComboBoxDisplayEntry[]
---@return integer rows
local function visibleRows(self, display)
    return math.min(#display, math.max(0, self.dropHeight))
end

---@param self ComboBox
---@param display ComboBoxDisplayEntry[]
---@return ItemViewGeometry geometry
local function geometry(self, display)
    return itemview.geometry(#display, visibleRows(self, display),
        self.offset, self.scrollbar)
end

--- Accepts an entry of the displayed (possibly filtered) list: fills the
--- text, closes the list and activates the underlying item.
---@param displayIndex integer Row in the displayed list
---@return self
function ComboBox:selectDisplayed(displayIndex)
    local display = self:getDisplayItems()
    local entry = display[displayIndex]
    if not entry then return self end
    rawset(self, "_selecting", true)
    self.text = entry.text
    rawset(self, "_selecting", nil)
    self:_moveCursor(#entry.text + 1)
    self.open = false
    self:activateItem(entry.index)
    return self
end

--- Removes all suggestions and closes the dropdown.
---@return self
function ComboBox:clear()
    collection.methods.clear(self)
    self.open = false
    self.offset = 0
    self:markDirty()
    return self
end

--- Initializes per-instance state and input handlers.
function ComboBox:setup()
    Input.setup(self)
    collection.setup(self)

    self:on("click", function(s, _, x, y)
        if y == 1 then
            if x == s.width then
                s.open = not s.open
            end
            return
        end
        local display = s:getDisplayItems()
        local g = geometry(s, display)
        if g.show and x == s.width then
            local target, grab = itemview.pointerDown(y - 1, g)
            s.offset = target
            if grab ~= nil then rawset(s, "_itemScrollDrag", grab) end
            return
        end
        s:selectDisplayed(s.offset + y - 1)
    end)
    self:on("drag", function(s, _, _, y)
        local grab = rawget(s, "_itemScrollDrag")
        if grab ~= nil then
            s.offset = itemview.drag(y - 1, grab,
                geometry(s, s:getDisplayItems()))
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_itemScrollDrag", nil)
    end)
    self:on("change", function(s)
        if s.autoComplete and not rawget(s, "_selecting") then
            s.open = #s:getDisplayItems() > 0 and #s.text > 0
            rawset(s, "_highlighted", 1)
            s.offset = 0
        end
    end)
    self:on("blur", function(s)
        s.open = false
    end)
end

--- Routes mouse input in local coordinates (wheel scrolling etc.).
---@param event string The mouse event name
---@param btn number Button or scroll direction
---@param x number Local x coordinate
---@param y number Local y coordinate
---@return Element|nil consumer The consuming element, or nil to pass through
function ComboBox:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" and self.open then
        if self.disabled then return nil end
        local display = self:getDisplayItems()
        self.offset = itemview.clampOffset(self.offset + btn,
            #display, visibleRows(self, display))
        return self
    end
    return Input.handleMouse(self, event, btn, x, y)
end

--- Handles keyboard input while focused.
---@param event string The key event name (key, key_up, char, paste)
---@param a any Key code or typed text
---@param b? any Secondary key-event value
function ComboBox:handleKey(event, a, b)
    if event == "key" then
        if self.open then
            local display = self:getDisplayItems()
            local highlighted = rawget(self, "_highlighted") or 1
            if a == keys.escape then
                self.open = false
                return
            elseif a == keys.enter then
                self:selectDisplayed(highlighted)
                return
            elseif a == keys.up or a == keys.down then
                local delta = a == keys.down and 1 or -1
                highlighted = math.max(1,
                    math.min(#display, highlighted + delta))
                rawset(self, "_highlighted", highlighted)
                self.offset = itemview.ensureVisible(self.offset, highlighted,
                    #display, visibleRows(self, display))
                self:markDirty()
                return
            end
        elseif a == keys.down and #self:getDisplayItems() > 0 then
            self.open = true
            return
        end
    end
    Input.handleKey(self, event, a, b)
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function ComboBox:render(buf)
    Input.render(self, buf)
    local w = self.width
    buf:blit(w, 1, self.open and "\30" or "\31",
        self.foreground, self.background)

    if self.open then
        local display = self:getDisplayItems()
        local g = geometry(self, display)
        rawget(self, "_p").offset = g.offset
        local highlighted = rawget(self, "_highlighted")
        local textWidth = math.max(0, w - (g.show and 1 or 0))
        for row = 1, self.height - 1 do
            local entry = display[g.offset + row]
            if not entry then break end
            local isHl = (g.offset + row) == highlighted
            local fg = isHl and self.selectionForeground or self.dropForeground
            local bg = isHl and self.selectionBackground or self.dropBackground
            buf:fill(1, 1 + row, textWidth, 1, " ", fg, bg)
            buf:blit(1, 1 + row, entry.text:sub(1, textWidth), fg, bg)
        end
        itemview.draw(buf, w, 2, g, self.foreground,
            self.scrollbarColor, self.scrollbarThumbColor)
    end
end

return ComboBox

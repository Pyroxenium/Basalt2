-- TextBox: multiline text editor with cursor, viewport scrolling, an
-- optional vertical scrollbar and text selection. Fires "change".
--
-- Selection: shift + arrows/home/end/pageUp/pageDown, or mouse dragging.
-- Ctrl+A selects all, Ctrl+C copies, Ctrl+X cuts (Basalt-internal clipboard,
-- shared between all TextBoxes; the system clipboard arrives via the normal
-- CC paste event). Typing, enter, paste, backspace and delete replace or
-- remove the selection first. Escape collapses it.

local require = ...
local class = require("core/class")
local Element = require("core/element")
local itemview = require("core/itemview")

---@class TextBoxPoint
---@field line integer Line index
---@field col integer One-based cursor column

---@alias TextBoxMovement fun(self: TextBox, line: integer, col: integer, current: string): integer, integer

---@class TextBox : Element
---@field public text string Full newline-delimited content
---@field public scrollbar ItemViewScrollbarMode Scrollbar mode
---@field public scrollbarColor number Scrollbar track color
---@field public scrollbarThumbColor number Scrollbar thumb color
---@field public selectionBackground number Selection background
---@field public selectionForeground number Selection foreground
---@field package _lines string[] Editable lines
---@field package _curLine integer Cursor line
---@field package _curCol integer Cursor column
---@field package _viewX integer Horizontal viewport offset
---@field package _viewY integer Vertical viewport offset
---@field private _selLine? integer Selection-anchor line
---@field private _selCol? integer Selection-anchor column
---@field private _syncing? boolean Whether `text` is being synchronized internally
---@field private _mouseAnchor? TextBoxPoint Active mouse-selection anchor
---@field private _itemScrollDrag? integer Active scrollbar grab offset
---@field private _shift? boolean Whether a shift key is held
---@field private _ctrl? boolean Whether a control key is held
local TextBox = class.create("TextBox", Element)

---@type string
local internalClipboard = ""

--- Full buffer content joined with newlines (rawString: never reactive)
class.property(TextBox, "text", "", {
    rawString = true, -- user-edited content must never compile as reactive
    onChange = function(self, v)
        if rawget(self, "_syncing") then return end
        -- external assignment replaces the buffer
        local lines = {}
        for line in (v .. "\n"):gmatch("(.-)\n") do
            lines[#lines + 1] = line
        end
        if #lines == 0 then lines = { "" } end
        rawset(self, "_lines", lines)
        local curLine = math.min(rawget(self, "_curLine") or 1, #lines)
        rawset(self, "_curLine", curLine)
        rawset(self, "_curCol",
            math.min(rawget(self, "_curCol") or 1, #lines[curLine] + 1))
        rawset(self, "_selLine", nil)
        rawset(self, "_selCol", nil)
    end,
})
--- Background color (false = transparent)
class.property(TextBox, "background", colors.black)
--- Width in terminal cells
class.property(TextBox, "width", 20)
--- Height in terminal cells
class.property(TextBox, "height", 8)
class.property(TextBox, "scrollbar", "auto") -- "auto", "always" or "hidden"
--- Scrollbar track color
class.property(TextBox, "scrollbarColor", colors.gray)
--- Scrollbar thumb color
class.property(TextBox, "scrollbarThumbColor", colors.lightGray)
class.property(TextBox, "selectionBackground", colors.blue) -- text selection overlay
--- Text color of selected entries
class.property(TextBox, "selectionForeground", colors.white)

--- Fired after every edit with the full new text
class.event(TextBox, "change")

---@param self TextBox
---@return ItemViewGeometry geometry
local function geometry(self)
    return itemview.geometry(#self._lines, self.height, self._viewY,
        self.scrollbar)
end

---@param self TextBox
---@return integer width
local function textWidth(self)
    return math.max(1, self.width - (geometry(self).show and 1 or 0))
end

---@param self TextBox
local function ensureView(self)
    rawset(self, "_viewY", itemview.ensureVisible(self._viewY, self._curLine,
        #self._lines, self.height))
    local tw = textWidth(self)
    local vx, col = self._viewX, self._curCol
    if col - vx > tw then vx = col - tw end
    if col - vx < 1 then vx = col - 1 end
    rawset(self, "_viewX", vx)
end

---@param self TextBox
local function syncText(self)
    rawset(self, "_syncing", true)
    self.text = table.concat(self._lines, "\n")
    rawset(self, "_syncing", false)
    ensureView(self)
    self:fire("change", self.text)
end

--- Selection bounds ordered as (l1, c1) .. (l2, c2), or nil when empty.
--- c2 is exclusive (the cursor cell after the last selected character).
---@param self TextBox
---@return integer? firstLine
---@return integer? firstColumn
---@return integer? lastLine
---@return integer? lastColumn
local function orderedSelection(self)
    local anchorLine, anchorCol = rawget(self, "_selLine"), rawget(self, "_selCol")
    if not anchorLine then return nil end
    local curLine, curCol = self._curLine, self._curCol
    if anchorLine == curLine and anchorCol == curCol then return nil end
    if curLine < anchorLine
        or (curLine == anchorLine and curCol < anchorCol) then
        return curLine, curCol, anchorLine, anchorCol
    end
    return anchorLine, anchorCol, curLine, curCol
end

---@param self TextBox
local function clearSelection(self)
    if rawget(self, "_selLine") then
        rawset(self, "_selLine", nil)
        rawset(self, "_selCol", nil)
        self:markDirty()
    end
end

---@param self TextBox
local function anchorSelection(self)
    if not rawget(self, "_selLine") then
        rawset(self, "_selLine", self._curLine)
        rawset(self, "_selCol", self._curCol)
    end
end

---@param self TextBox
---@param line number Line index
---@param col number Cursor column
local function moveCursor(self, line, col)
    local lines = self._lines
    line = math.max(1, math.min(#lines, line))
    col = math.max(1, math.min(#lines[line] + 1, col))
    rawset(self, "_curLine", line)
    rawset(self, "_curCol", col)
    ensureView(self)
    self:markDirty()
end

--- Returns the selected text (with newlines), or nil.
---@return string? selection The selected text
function TextBox:getSelection()
    local l1, c1, l2, c2 = orderedSelection(self)
    if not l1 then return nil end
    ---@cast c1 integer
    ---@cast l2 integer
    ---@cast c2 integer
    local lines = self._lines
    if l1 == l2 then
        return lines[l1]:sub(c1, c2 - 1)
    end
    local out = { lines[l1]:sub(c1) }
    for i = l1 + 1, l2 - 1 do
        out[#out + 1] = lines[i]
    end
    out[#out + 1] = lines[l2]:sub(1, c2 - 1)
    return table.concat(out, "\n")
end

--- Removes the selected text.
---@return boolean deleted True if there was a selection to remove
function TextBox:deleteSelection()
    local l1, c1, l2, c2 = orderedSelection(self)
    if not l1 then return false end
    ---@cast c1 integer
    ---@cast l2 integer
    ---@cast c2 integer
    local lines = self._lines
    lines[l1] = lines[l1]:sub(1, c1 - 1) .. lines[l2]:sub(c2)
    for i = l2, l1 + 1, -1 do
        table.remove(lines, i)
    end
    rawset(self, "_curLine", l1)
    rawset(self, "_curCol", c1)
    clearSelection(self)
    syncText(self)
    return true
end

--- Selects the whole buffer (what ctrl+a does).
---@return self
function TextBox:selectAll()
    rawset(self, "_selLine", 1)
    rawset(self, "_selCol", 1)
    local lines = self._lines
    moveCursor(self, #lines, #lines[#lines] + 1)
    return self
end

--- Copies the selection to the Basalt-internal clipboard (ctrl+c).
---@return string? copied The copied text
function TextBox:copy()
    local selection = self:getSelection()
    if selection then internalClipboard = selection end
    return selection
end

--- Cuts the selection into the Basalt-internal clipboard (ctrl+x).
---@return string? cut The removed text
function TextBox:cut()
    local selection = self:copy()
    if selection then self:deleteSelection() end
    return selection
end

--- Returns the Basalt-internal clipboard (shared between all TextBoxes).
---@return string clipboard The clipboard content
function TextBox:getClipboard()
    return internalClipboard
end

---@param self TextBox
---@param str string Text to insert
local function insertText(self, str)
    self:deleteSelection()
    local lines = self._lines
    local line, col = self._curLine, self._curCol
    local current = lines[line]
    lines[line] = current:sub(1, col - 1) .. str .. current:sub(col)
    rawset(self, "_curCol", col + #str)
    syncText(self)
end

---@param self TextBox
---@param x number Local x coordinate
---@param y number Local y coordinate
---@return integer line
---@return integer column
local function pointFromMouse(self, x, y)
    local g = geometry(self)
    local line = math.max(1, math.min(#self._lines, g.offset + y))
    local col = math.max(1,
        math.min(#self._lines[line] + 1, self._viewX + x))
    return line, col
end

--- Initializes per-instance state and input handlers.
function TextBox:setup()
    Element.setup(self)
    rawset(self, "_lines", { "" })
    rawset(self, "_curLine", 1)
    rawset(self, "_curCol", 1)
    rawset(self, "_viewX", 0)
    rawset(self, "_viewY", 0)

    self:on("click", function(s, _, x, y)
        local g = geometry(s)
        if g.show and x == s.width then
            local target, grab = itemview.pointerDown(y, g)
            rawset(s, "_viewY", target)
            if grab ~= nil then rawset(s, "_itemScrollDrag", grab) end
            s:markDirty()
            return
        end
        clearSelection(s)
        local line, col = pointFromMouse(s, x, y)
        rawset(s, "_mouseAnchor", { line = line, col = col })
        moveCursor(s, line, col)
    end)
    self:on("drag", function(s, _, x, y)
        local grab = rawget(s, "_itemScrollDrag")
        if grab ~= nil then
            rawset(s, "_viewY", itemview.drag(y, grab, geometry(s)))
            s:markDirty()
            return
        end
        local anchor = rawget(s, "_mouseAnchor")
        if anchor then
            rawset(s, "_selLine", anchor.line)
            rawset(s, "_selCol", anchor.col)
            moveCursor(s, pointFromMouse(s, x, y))
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_itemScrollDrag", nil)
        rawset(s, "_mouseAnchor", nil)
    end)
    self:on("blur", function(s)
        rawset(s, "_shift", false)
        rawset(s, "_ctrl", false)
    end)
end

--- Routes mouse input in local coordinates (wheel scrolling etc.).
---@param event string The mouse event name
---@param btn number Button or scroll direction
---@param x number Local x coordinate
---@param y number Local y coordinate
---@return Element|nil consumer The consuming element, or nil to pass through
function TextBox:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" then
        if self.disabled then return nil end
        local old = self._viewY
        rawset(self, "_viewY", itemview.clampOffset(old + btn,
            #self._lines, self.height))
        local userHandled = self:fire("scroll", btn, x, y)
        if self._viewY ~= old or userHandled then
            self:markDirty()
            return self
        end
        return nil
    end
    return Element.handleMouse(self, event, btn, x, y)
end

---@type table<integer, TextBoxMovement>?
local movementKeys -- keys constant -> function(self, line, col, current)

local function initMovement()
    movementKeys = {
        [keys.left] = function(self, line, col)
            if col > 1 then return line, col - 1 end
            if line > 1 then return line - 1, #self._lines[line - 1] + 1 end
            return line, col
        end,
        [keys.right] = function(self, line, col, current)
            if col <= #current then return line, col + 1 end
            if line < #self._lines then return line + 1, 1 end
            return line, col
        end,
        [keys.up] = function(self, line, col) return line - 1, col end,
        [keys.down] = function(self, line, col) return line + 1, col end,
        [keys.home] = function(self, line) return line, 1 end,
        [keys["end"]] = function(self, line, _, current)
            return line, #current + 1
        end,
        [keys.pageUp] = function(self, line, col)
            return line - self.height, col
        end,
        [keys.pageDown] = function(self, line, col)
            return line + self.height, col
        end,
    }
end

--- Handles keyboard input while focused.
---@param event string The key event name (key, key_up, char, paste)
---@param a any Key code or typed text
---@param b? any Secondary key-event value
function TextBox:handleKey(event, a, b)
    if event == "char" or event == "paste" then
        insertText(self, a)
    elseif event == "key_up" then
        if a == keys.leftShift or a == keys.rightShift then
            rawset(self, "_shift", false)
        elseif a == keys.leftCtrl or a == keys.rightCtrl then
            rawset(self, "_ctrl", false)
        end
    elseif event == "key" then
        if not movementKeys then initMovement() end
        ---@cast movementKeys table<integer, TextBoxMovement>
        local lines = self._lines
        local line, col = self._curLine, self._curCol
        local current = lines[line]
        local movement = movementKeys[a]

        if a == keys.leftShift or a == keys.rightShift then
            rawset(self, "_shift", true)
        elseif a == keys.leftCtrl or a == keys.rightCtrl then
            rawset(self, "_ctrl", true)
        elseif rawget(self, "_ctrl") and a == keys.a then
            self:selectAll()
        elseif rawget(self, "_ctrl") and a == keys.c then
            self:copy()
        elseif rawget(self, "_ctrl") and a == keys.x then
            self:cut()
        elseif movement then
            if rawget(self, "_shift") then
                anchorSelection(self)
            else
                clearSelection(self)
            end
            moveCursor(self, movement(self, line, col, current))
        elseif a == keys.escape then
            clearSelection(self)
        elseif a == keys.enter then
            if self:deleteSelection() then
                lines = self._lines
                line, col = self._curLine, self._curCol
                current = lines[line]
            end
            lines[line] = current:sub(1, col - 1)
            table.insert(lines, line + 1, current:sub(col))
            rawset(self, "_curLine", line + 1)
            rawset(self, "_curCol", 1)
            syncText(self)
        elseif a == keys.backspace then
            if self:deleteSelection() then
                -- selection removal is the whole edit
            elseif col > 1 then
                lines[line] = current:sub(1, col - 2) .. current:sub(col)
                rawset(self, "_curCol", col - 1)
                syncText(self)
            elseif line > 1 then
                local previous = lines[line - 1]
                rawset(self, "_curLine", line - 1)
                rawset(self, "_curCol", #previous + 1)
                lines[line - 1] = previous .. current
                table.remove(lines, line)
                syncText(self)
            end
        elseif a == keys.delete then
            if self:deleteSelection() then
                -- selection removal is the whole edit
            elseif col <= #current then
                lines[line] = current:sub(1, col - 1) .. current:sub(col + 1)
                syncText(self)
            elseif line < #lines then
                lines[line] = current .. lines[line + 1]
                table.remove(lines, line + 1)
                syncText(self)
            end
        end
    end
    Element.handleKey(self, event, a, b)
end

--- Intrinsic size for basalt.auto().
---@return number width The measured width
---@return number height The measured height
function TextBox:measure()
    local w = 1
    for _, line in ipairs(self._lines) do
        w = math.max(w, #line)
    end
    return w + 1, math.max(1, #self._lines)
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function TextBox:render(buf)
    Element.render(self, buf)
    local lines = self._lines
    local g = geometry(self)
    rawset(self, "_viewY", g.offset)
    local tw = math.max(0, self.width - (g.show and 1 or 0))
    local vx = self._viewX

    for row = 1, self.height do
        local line = lines[g.offset + row]
        if not line then break end
        buf:blit(1, row, line:sub(vx + 1, vx + tw), self.foreground, nil)
    end

    -- selection overlay (the extra cell past a line end marks the newline)
    local l1, c1, l2, c2 = orderedSelection(self)
    if l1 then
        for row = 1, self.height do
            local lineIndex = g.offset + row
            local line = lines[lineIndex]
            if line and lineIndex >= l1 and lineIndex <= l2 then
                local startCol = (lineIndex == l1) and c1 or 1
                local endCol = (lineIndex == l2) and (c2 - 1) or (#line + 1)
                local absStart = math.max(startCol, vx + 1)
                local absEnd = math.min(endCol, vx + tw)
                if absEnd >= absStart then
                    local segment = line:sub(absStart, absEnd)
                    segment = segment
                        .. string.rep(" ", (absEnd - absStart + 1) - #segment)
                    buf:blit(absStart - vx, row, segment,
                        self.selectionForeground, self.selectionBackground)
                end
            end
        end
    end

    itemview.draw(buf, self.width, 1, g, self.foreground,
        self.scrollbarColor, self.scrollbarThumbColor)

    local root = self:getRoot()
    if root.getFocused and root:getFocused() == self then
        self:setCursor(self._curCol - vx, self._curLine - g.offset,
            true, self.foreground)
    end
end

return TextBox

-- Input: single-line text input with cursor, horizontal scrolling and
-- placeholder. Fires "change" while typing and "enter" on return.

local require = ...
local class = require("core/class")
local Element = require("core/element")

local Input = class.create("Input", Element)

class.property(Input, "text", "", {
    rawString = true, -- user-typed text must never compile as reactive
    onChange = function(self, v)
        -- keep cursor valid when text is replaced programmatically
        local cur = rawget(self, "_cursor")
        if cur and cur > #v + 1 then
            rawset(self, "_cursor", #v + 1)
            rawset(self, "_scroll", math.max(0, #v + 1 - self.width))
        end
    end,
})
class.property(Input, "placeholder", "")
class.property(Input, "placeholderColor", colors.gray)
class.property(Input, "maxLength", false)
class.property(Input, "replaceChar", false) -- e.g. "*" for password fields
class.property(Input, "pattern", false)     -- Lua pattern each char must match
-- class-level defaults so themes can restyle inputs
class.property(Input, "width", 12)
class.property(Input, "height", 1)
class.property(Input, "background", colors.lightGray)
class.property(Input, "foreground", colors.black)

class.event(Input, "change")
class.event(Input, "enter")

function Input:setup()
    Element.setup(self)
    rawset(self, "_cursor", 1) -- insert position, 1..#text+1
    rawset(self, "_scroll", 0)

    self:on("click", function(s, _, x, y)
        if y ~= 1 then return end -- subclasses may be taller (ComboBox)
        s:_moveCursor(s._scroll + x)
    end)
    self:on("focus", function(s) s:markDirty() end)
    self:on("blur", function(s) s:markDirty() end)
end

function Input:_moveCursor(pos)
    local n = #self.text
    if pos < 1 then pos = 1 end
    if pos > n + 1 then pos = n + 1 end
    rawset(self, "_cursor", pos)

    -- keep the cursor inside the visible slice
    local w, scroll = self.width, self._scroll
    if pos - scroll > w then scroll = pos - w end
    if pos - scroll < 1 then scroll = pos - 1 end
    rawset(self, "_scroll", scroll)
    self:markDirty()
end

function Input:_insert(str)
    local pattern = self.pattern
    if pattern then -- keep only characters matching the pattern
        str = str:gsub(".", function(ch)
            return ch:match(pattern) and ch or ""
        end)
        if #str == 0 then return end
    end
    local text = self.text
    local max = self.maxLength
    if max and #text + #str > max then return end
    local c = self._cursor
    self.text = text:sub(1, c - 1) .. str .. text:sub(c)
    self:_moveCursor(c + #str)
    self:fire("change", self.text)
end

function Input:handleKey(event, a, b)
    if event == "char" or event == "paste" then
        self:_insert(a)
    elseif event == "key" then
        local c = self._cursor
        local text = self.text
        if a == keys.backspace then
            if c > 1 then
                self.text = text:sub(1, c - 2) .. text:sub(c)
                self:_moveCursor(c - 1)
                self:fire("change", self.text)
            end
        elseif a == keys.delete then
            if c <= #text then
                self.text = text:sub(1, c - 1) .. text:sub(c + 1)
                self:fire("change", self.text)
            end
        elseif a == keys.left then
            self:_moveCursor(c - 1)
        elseif a == keys.right then
            self:_moveCursor(c + 1)
        elseif a == keys.home then
            self:_moveCursor(1)
        elseif a == keys["end"] then
            self:_moveCursor(#text + 1)
        elseif a == keys.enter then
            self:fire("enter", text)
        end
    end
    Element.handleKey(self, event, a, b)
end

function Input:render(buf)
    Element.render(self, buf)
    local root = self:getRoot()
    local focused = root.getFocused and root:getFocused() == self
    local text = self.text
    local w = self.width

    if #text == 0 and not focused then
        buf:blit(1, 1, self.placeholder:sub(1, w), self.placeholderColor, nil)
    else
        local visible = text:sub(self._scroll + 1, self._scroll + w)
        local rc = self.replaceChar
        if rc then visible = tostring(rc):sub(1, 1):rep(#visible) end
        buf:blit(1, 1, visible, self.foreground, nil)
    end

    if focused then
        self:setCursor(self._cursor - self._scroll, 1, true, self.foreground)
    end
end

function Input:measure()
    return math.max(1, #tostring(self.text), #tostring(self.placeholder)), 1
end

return Input

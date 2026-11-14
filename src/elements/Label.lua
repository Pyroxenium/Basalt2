-- Label: text display. The width follows the text until one is set; with a
-- width of its own (a number, a "{...}" expression, a state or a layout
-- value) the text word-wraps and the height follows the wrapped lines until
-- a height is set too.

local require = ...
local class = require("core/class")
local Element = require("core/element")
local textutil = require("core/text")

---@class Label : Element
---@field public text any Displayed value, rendered with `tostring`
local Label = class.create("Label", Element)

--- Displayed text; numbers and dynamic values are tostring-ed
class.property(Label, "text", "")
--- Follows the text until set; any width of its own enables word wrap
class.property(Label, "width", function(self)
    return math.max(#tostring(self.text), 1)
end)
local textWidth = Label.__defaults.width

-- Whether the width still follows the text. Asking the stored value instead
-- of tracking assignments also covers "{...}" expressions and states, which
-- are stored without an onChange call.
---@param self Label
---@return boolean followsText
local function followsText(self)
    return rawget(self, "_p").width == textWidth
end

-- Wrapped lines for the current text and width; both can change without
-- notice (dynamic values, layout), so the result is cached by its inputs.
---@param self Label
---@return TextLines lines
local function wrappedLines(self)
    local text, width = tostring(self.text), self.width
    if rawget(self, "_wrapText") ~= text or rawget(self, "_wrapWidth") ~= width then
        rawset(self, "_wrapText", text)
        rawset(self, "_wrapWidth", width)
        rawset(self, "_wrapLines", textutil.wrap(text, width))
    end
    return rawget(self, "_wrapLines")
end

--- Follows the wrapped text until set
class.property(Label, "height", function(self)
    if followsText(self) then return 1 end
    return #wrappedLines(self)
end)

--- Renders the label (single line, or word-wrapped with a width of its own).
---@param buf Render The render buffer
function Label:render(buf)
    Element.render(self, buf)
    local height = self.height
    if followsText(self) or height == 1 then
        -- tostring: dynamic/reactive text may evaluate to a number
        buf:blit(1, 1, tostring(self.text), self.foreground, nil)
    else
        local lines = wrappedLines(self)
        for i = 1, math.min(#lines, height) do
            buf:blit(1, i, lines[i], self.foreground, nil)
        end
    end
end

--- Intrinsic size for basalt.auto(): text length x 1.
---@return number width The measured width
---@return number height The measured height
function Label:measure()
    return math.max(1, #tostring(self.text)), 1
end

return Label

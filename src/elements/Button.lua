-- Button: clickable element with centered text and pressed feedback.
-- While the mouse button is held, foreground and background swap
-- ("pressed" state); the click event fires on press.

local require = ...
local class = require("core/class")
local Element = require("core/element")

---@class Button : Element
---@field public text any Label rendered with `tostring`
local Button = class.create("Button", Element)

--- Label text, rendered centered
class.property(Button, "text", "Button")
--- Width in terminal cells
class.property(Button, "width", 10)
--- Height in terminal cells
class.property(Button, "height", 3)
--- Background color (false = transparent)
class.property(Button, "background", colors.gray)

--- Renders the button into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function Button:render(buf)
    local fg, bg = self.foreground, self.background
    if self:hasState("pressed") and bg then
        fg, bg = bg, fg
    end
    local w, h = self.width, self.height
    if bg then buf:fill(1, 1, w, h, " ", fg, bg) end
    local t = tostring(self.text)
    buf:blit(
        math.floor((w - #t) / 2) + 1,
        math.floor((h - 1) / 2) + 1,
        t, fg, bg or nil
    )
end

--- Intrinsic size for basalt.auto(): text width + padding, 3 rows.
---@return number width The measured width
---@return number height The measured height
---@usage local btn = frame:addButton({ width = basalt.auto(), text = "Ok" })
function Button:measure()
    return math.max(3, #tostring(self.text) + 2), 3
end

return Button

-- Button: clickable element with centered text and pressed feedback.

local require = ...
local class = require("core/class")
local Element = require("core/element")

local Button = class.create("Button", Element)

class.property(Button, "text", "Button")
-- class-level defaults (instead of per-instance writes) so themes can
-- restyle buttons by changing the defaults
class.property(Button, "width", 10)
class.property(Button, "height", 3)
class.property(Button, "background", colors.gray)

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

function Button:measure()
    return math.max(3, #tostring(self.text) + 2), 3
end

return Button

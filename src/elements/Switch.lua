-- Switch: sliding on/off toggle, fires "change".

local require = ...
local class = require("core/class")
local Element = require("core/element")

local Switch = class.create("Switch", Element)

class.property(Switch, "checked", false, {
    state = "checked",
    styleable = false,
})
class.property(Switch, "onColor", colors.green)
class.property(Switch, "offColor", colors.gray)
class.property(Switch, "knobColor", colors.white)
class.property(Switch, "width", 4)

class.event(Switch, "change")

function Switch:setup()
    Element.setup(self)
    self:on("click", function(s)
        s.checked = not s.checked
        s:fire("change", s.checked)
    end)
end

function Switch:render(buf)
    local w, h = self.width, self.height
    local on = self.checked
    buf:fill(1, 1, w, h, " ", self.foreground, on and self.onColor or self.offColor)
    local knobW = math.max(1, math.floor(w / 2))
    buf:fill(on and (w - knobW + 1) or 1, 1, knobW, h, " ",
        self.foreground, self.knobColor)
end

return Switch

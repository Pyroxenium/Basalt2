-- Switch: sliding on/off toggle, fires "change".

local require = ...
local class = require("core/class")
local Element = require("core/element")

---@class Switch : Element
---@field public checked boolean Whether the switch is on
---@field public onColor number Track color while on
---@field public offColor number Track color while off
---@field public knobColor number Knob color
local Switch = class.create("Switch", Element)

--- Checked state; mirrored to the "checked" element state for styling
class.property(Switch, "checked", false, {
    state = "checked",
    styleable = false,
})
class.property(Switch, "onColor", colors.green) -- track color while on
class.property(Switch, "offColor", colors.gray) -- track color while off
--- Color of the knob
class.property(Switch, "knobColor", colors.white)
--- Width in terminal cells
class.property(Switch, "width", 4)

--- Fired after every toggle with the new checked state
class.event(Switch, "change")

--- Registers the click handler that toggles the switch.
function Switch:setup()
    Element.setup(self)
    self:on("click", function(s)
        s.checked = not s.checked
        s:fire("change", s.checked)
    end)
end

--- Renders the track and the sliding knob.
---@param buf Render The render buffer
function Switch:render(buf)
    local w, h = self.width, self.height
    local on = self.checked
    buf:fill(1, 1, w, h, " ", self.foreground, on and self.onColor or self.offColor)
    local knobW = math.max(1, math.floor(w / 2))
    buf:fill(on and (w - knobW + 1) or 1, 1, knobW, h, " ",
        self.foreground, self.knobColor)
end

return Switch

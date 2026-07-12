-- Slider: value picker (horizontal or vertical); click, drag or scroll.

local require = ...
local class = require("core/class")
local Element = require("core/element")

local Slider = class.create("Slider", Element)

class.property(Slider, "min", 0)
class.property(Slider, "max", 100)
class.property(Slider, "step", 1)
class.property(Slider, "value", 0)
class.property(Slider, "horizontal", true)
class.property(Slider, "barColor", colors.gray)
class.property(Slider, "knobColor", colors.blue)
class.property(Slider, "width", 10)

class.event(Slider, "change")

local function trackLength(self)
    return self.horizontal and self.width or self.height
end

local function setFromPos(self, x, y)
    local len = trackLength(self)
    local pos = self.horizontal and x or y
    local lo, hi, step = self.min, self.max, self.step
    if hi <= lo or len < 2 then return end
    local ratio = (pos - 1) / (len - 1)
    if ratio < 0 then ratio = 0 elseif ratio > 1 then ratio = 1 end
    local v = lo + ratio * (hi - lo)
    v = lo + math.floor((v - lo) / step + 0.5) * step
    if v < lo then v = lo elseif v > hi then v = hi end
    if v ~= self.value then
        self.value = v
        self:fire("change", v)
    end
end

function Slider:setup()
    Element.setup(self)
    self:on("click", function(s, _, x, y) setFromPos(s, x, y) end)
    self:on("drag", function(s, _, x, y) setFromPos(s, x, y) end)
end

--- The mouse wheel adjusts the value by one step (Basalt2 parity).
function Slider:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" then
        if self.disabled then return nil end
        local v = self.value + btn * self.step
        if v < self.min then v = self.min elseif v > self.max then v = self.max end
        if v ~= self.value then
            self.value = v
            self:fire("change", v)
        end
        return self -- always consume over the slider
    end
    return Element.handleMouse(self, event, btn, x, y)
end

function Slider:render(buf)
    Element.render(self, buf)
    local len = trackLength(self)
    local lo, hi = self.min, self.max
    local knob = 1
    if hi > lo then
        knob = 1 + math.floor((self.value - lo) / (hi - lo) * (len - 1) + 0.5)
    end
    if self.horizontal then
        buf:blit(1, 1, string.rep("\140", len), self.barColor, nil)
        buf:fill(knob, 1, 1, 1, " ", self.foreground, self.knobColor)
    else
        for row = 1, len do
            buf:blit(1, row, "\149", self.barColor, nil)
        end
        buf:fill(1, knob, 1, 1, " ", self.foreground, self.knobColor)
    end
end

return Slider

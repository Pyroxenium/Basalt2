-- ProgressBar: progress 0-100, fills in any direction, optional % text.

local require = ...
local class = require("core/class")
local Element = require("core/element")

---@alias ProgressBarDirection "right"|"left"|"up"|"down"

---@class ProgressBar : Element
---@field public progress number Fill percentage from 0 through 100
---@field public barColor number Filled-region color
---@field public direction ProgressBarDirection Fill direction
---@field public showPercentage boolean Whether to render a centered percentage
local ProgressBar = class.create("ProgressBar", Element)

--- Fill level 0-100, clamped automatically
class.property(ProgressBar, "progress", 0, {
    onChange = function(self, v)
        local p = rawget(self, "_p")
        if v < 0 then p.progress = 0 elseif v > 100 then p.progress = 100 end
    end,
})
class.property(ProgressBar, "barColor", colors.lime) -- color of the filled part
--- Background color (false = transparent)
class.property(ProgressBar, "background", colors.gray)
--- Width in terminal cells
class.property(ProgressBar, "width", 16)
class.property(ProgressBar, "direction", "right") -- right, left, up or down
class.property(ProgressBar, "showPercentage", false) -- centered "42%" text

--- Renders the bar; the fill grows in the configured direction.
---@param buf Render The render buffer
function ProgressBar:render(buf)
    Element.render(self, buf)
    local w, h = self.width, self.height
    -- clamp again: dynamic/reactive progress skips the onChange clamp
    local pr = math.min(100, math.max(0, self.progress))
    local dir = self.direction

    if dir == "up" or dir == "down" then
        local filled = math.floor(h * pr / 100 + 0.5)
        if filled > 0 then
            buf:fill(1, dir == "up" and (h - filled + 1) or 1, w, filled,
                " ", self.foreground, self.barColor)
        end
    else
        local filled = math.floor(w * pr / 100 + 0.5)
        if filled > 0 then
            buf:fill(dir == "left" and (w - filled + 1) or 1, 1, filled, h,
                " ", self.foreground, self.barColor)
        end
    end

    if self.showPercentage then
        local label = math.floor(pr + 0.5) .. "%"
        buf:drawText(math.floor((w - #label) / 2) + 1,
            math.floor((h - 1) / 2) + 1, label)
    end
end

return ProgressBar

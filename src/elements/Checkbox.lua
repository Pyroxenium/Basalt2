-- Checkbox: "[x] label", toggles on click, fires "change".

local require = ...
local class = require("core/class")
local Element = require("core/element")

---@class Checkbox : Element
---@field public checked boolean Whether the checkbox is selected
---@field public text any Label rendered with `tostring`
---@field public checkedSymbol any Symbol rendered while checked
---@field public uncheckedSymbol any Symbol rendered while unchecked
local Checkbox = class.create("Checkbox", Element)

--- Checked state; mirrored to the "checked" element state for styling
class.property(Checkbox, "checked", false, {
    state = "checked",
    styleable = false,
})
class.property(Checkbox, "text", "") -- label shown right of the box
class.property(Checkbox, "checkedSymbol", "x") -- single character inside [ ]
--- Single character inside [ ] while unchecked
class.property(Checkbox, "uncheckedSymbol", " ")
--- Auto-sizes to the label until set explicitly
class.property(Checkbox, "width", function(self)
    return #tostring(self.text) + 4
end)

--- Fired after every toggle with the new checked state
class.event(Checkbox, "change")

--- Sets up the checkbox's click handler to toggle its checked state and fire a "change" event.
function Checkbox:setup()
    Element.setup(self)
    self:on("click", function(s)
        s.checked = not s.checked
        s:fire("change", s.checked)
    end)
end

--- Renders the checkbox as "[x] label".
---@param buf Render The render buffer
function Checkbox:render(buf)
    Element.render(self, buf)
    local symbol = self.checked and self.checkedSymbol or self.uncheckedSymbol
    buf:blit(1, 1, "[" .. tostring(symbol):sub(1, 1) .. "] "
        .. tostring(self.text), self.foreground, nil)
end

return Checkbox

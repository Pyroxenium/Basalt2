-- Checkbox: "[x] label", toggles on click, fires "change".

local require = ...
local class = require("core/class")
local Element = require("core/element")

local Checkbox = class.create("Checkbox", Element)

class.property(Checkbox, "checked", false, {
    state = "checked",
    styleable = false,
})
class.property(Checkbox, "text", "")
class.property(Checkbox, "checkedSymbol", "x")
class.property(Checkbox, "uncheckedSymbol", " ")
-- dynamic default: sizes itself to the label unless width is set explicitly
class.property(Checkbox, "width", function(self)
    return #tostring(self.text) + 4
end)

class.event(Checkbox, "change")

function Checkbox:setup()
    Element.setup(self)
    self:on("click", function(s)
        s.checked = not s.checked
        s:fire("change", s.checked)
    end)
end

function Checkbox:render(buf)
    Element.render(self, buf)
    local symbol = self.checked and self.checkedSymbol or self.uncheckedSymbol
    buf:blit(1, 1, "[" .. tostring(symbol):sub(1, 1) .. "] "
        .. tostring(self.text), self.foreground, nil)
end

return Checkbox

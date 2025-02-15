local VisualElement = require("elements/VisualElement")

---@class Checkbox : VisualElement
local Checkbox = setmetatable({}, VisualElement)
Checkbox.__index = Checkbox

---@property checked boolean Whether checkbox is checked
Checkbox.defineProperty(Checkbox, "checked", {default = false, type = "boolean", canTriggerRender = true})
---@property text string Label text
Checkbox.defineProperty(Checkbox, "text", {default = "", type = "string", canTriggerRender = true})
---@property symbol string Check symbol
Checkbox.defineProperty(Checkbox, "symbol", {default = "x", type = "string"})

Checkbox.listenTo(Checkbox, "mouse_click")

function Checkbox.new(props, basalt)
    local self = setmetatable({}, Checkbox):__init()
    self.set("width", 1)
    self.set("height", 1)
    self:init(props, basalt)
    return self
end

function Checkbox:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Checkbox")
end

function Checkbox:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        self.set("checked", not self.get("checked"))
        self:fireEvent("change", self.get("checked"))
        return true
    end
end

function Checkbox:render()
    VisualElement.render(self)

    local text = self.get("checked") and self.get("symbol") or " "
    self:textFg(1, 1, "["..text.."]", self.get("foreground"))

    local label = self.get("text")
    if #label > 0 then
        self:textFg(4, 1, label, self.get("foreground"))
    end
end

return Checkbox
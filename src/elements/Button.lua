local VisualElement = require("elements/VisualElement")
local getCenteredPosition = require("libraries/utils").getCenteredPosition

local Button = setmetatable({}, VisualElement)
Button.__index = Button

Button.defineProperty(Button, "text", {default = "Button", type = "string"})
Button.listenTo(Button, "mouse_click")

---@diagnostic disable-next-line: duplicate-set-field
function Button.new(id, basalt)
    local self = setmetatable({}, Button):__init()
    self:init(id, basalt)
    self.set("type", "Button")
    self.set("width", 10)
    self.set("height", 3)
    self.set("z", 5)
    return self
end

---@diagnostic disable-next-line: duplicate-set-field
function Button:render()
    VisualElement.render(self)
    local text = self.get("text")
    local xO, yO = getCenteredPosition(text, self.get("width"), self.get("height"))
    self:textFg(xO, yO, text, self.get("foreground"))
end

return Button
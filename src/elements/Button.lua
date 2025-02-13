local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local getCenteredPosition = require("libraries/utils").getCenteredPosition

---@class Button : VisualElement
local Button = setmetatable({}, VisualElement)
Button.__index = Button

---@property text string Button Button text
Button.defineProperty(Button, "text", {default = "Button", type = "string", canTriggerRender = true})

---@event mouse_click The event that is triggered when the button is clicked
Button.listenTo(Button, "mouse_click")

function Button.new(props, basalt)
    local self = setmetatable({}, Button):__init()
    self:init(props, basalt)
    self.set("width", 10)
    self.set("height", 3)
    self.set("z", 5)
    return self
end

function Button:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Button")
end

function Button:render()
    VisualElement.render(self)
    local text = self.get("text")
    local xO, yO = getCenteredPosition(text, self.get("width"), self.get("height"))
    self:textFg(xO, yO, text, self.get("foreground"))
end

return Button
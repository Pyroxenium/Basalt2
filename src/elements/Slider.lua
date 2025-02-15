local VisualElement = require("elements/VisualElement")

---@class Slider : VisualElement
local Slider = setmetatable({}, VisualElement)
Slider.__index = Slider

---@property step number 1 Current step position (1 to width/height)
Slider.defineProperty(Slider, "step", {default = 1, type = "number", canTriggerRender = true})
---@property max number 100 Maximum value for value conversion
Slider.defineProperty(Slider, "max", {default = 100, type = "number"})
---@property horizontal boolean true Whether the slider is horizontal
Slider.defineProperty(Slider, "horizontal", {default = true, type = "boolean", canTriggerRender = true})
---@property barColor color color Colors for the slider bar
Slider.defineProperty(Slider, "barColor", {default = colors.gray, type = "number", canTriggerRender = true})
---@property sliderColor color The color of the slider handle
Slider.defineProperty(Slider, "sliderColor", {default = colors.blue, type = "number", canTriggerRender = true})

Slider.listenTo(Slider, "mouse_click")
Slider.listenTo(Slider, "mouse_drag")
Slider.listenTo(Slider, "mouse_up")

function Slider.new(props, basalt)
    local self = setmetatable({}, Slider):__init()
    self.set("width", 8)
    self.set("height", 1)
    self.set("backgroundEnabled", false)
    self:init(props, basalt)
    return self
end

function Slider:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Slider")
end

function Slider:getValue()
    local step = self.get("step")
    local max = self.get("max")
    local maxSteps = self.get("horizontal") and self.get("width") or self.get("height")
    return math.floor((step - 1) * (max / (maxSteps - 1)))
end

function Slider:mouse_click(button, x, y)
    if button == 1 and self:isInBounds(x, y) then
        local relX, relY = self:getRelativePosition(x, y)
        local pos = self.get("horizontal") and relX or relY
        local maxSteps = self.get("horizontal") and self.get("width") or self.get("height")

        self.set("step", math.min(maxSteps, math.max(1, pos)))
        self:updateRender()
        return true
    end
end
Slider.mouse_drag = Slider.mouse_click

function Slider:mouse_scroll(direction, x, y)
    if self:isInBounds(x, y) then
        local step = self.get("step")
        local maxSteps = self.get("horizontal") and self.get("width") or self.get("height")
        self.set("step", math.min(maxSteps, math.max(1, step + direction)))
        self:updateRender()
        return true
    end
end

function Slider:render()
    VisualElement.render(self)
    local width = self.get("width")
    local height = self.get("height")
    local horizontal = self.get("horizontal")
    local step = self.get("step")

    local barChar = horizontal and "\140" or "│"
    local text = string.rep(barChar, horizontal and width or height)

    if horizontal then
        self:textFg(1, 1, text, self.get("barColor"))
        self:textBg(step, 1, " ", self.get("sliderColor"))
    else
        for y = 1, height do
            self:textFg(1, y, barChar, self.get("barColor"))
        end
        self:textFg(1, step, "\140", self.get("sliderColor"))
    end
end

return Slider
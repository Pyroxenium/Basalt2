local VisualElement = require("elements/VisualElement")

---@class ProgressBar : VisualElement
local ProgressBar = setmetatable({}, VisualElement)
ProgressBar.__index = ProgressBar

---@property progress number Current progress (0-100)
ProgressBar.defineProperty(ProgressBar, "progress", {default = 0, type = "number", canTriggerRender = true})
---@property showPercentage boolean Show percentage text
ProgressBar.defineProperty(ProgressBar, "showPercentage", {default = false, type = "boolean"})
---@property progressColor color Progress bar color
ProgressBar.defineProperty(ProgressBar, "progressColor", {default = colors.lime, type = "number"})

function ProgressBar.new()
    local self = setmetatable({}, ProgressBar):__init()
    self.set("width", 10)
    self.set("height", 1)
    return self
end

function ProgressBar:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "ProgressBar")
end

function ProgressBar:render()
    VisualElement.render(self)
    local width = self.get("width")
    local progress = math.min(100, math.max(0, self.get("progress")))
    local fillWidth = math.floor((width * progress) / 100)

    self:textBg(1, 1, string.rep(" ", fillWidth), self.get("progressColor"))

    if self.get("showPercentage") then
        local text = tostring(progress).."%"
        local x = math.floor((width - #text) / 2) + 1
        self:textFg(x, 1, text, self.get("foreground"))
    end
end

return ProgressBar
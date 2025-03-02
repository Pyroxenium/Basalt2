local VisualElement = require("elements/VisualElement")

--- This is the progress bar class. It provides a visual representation of progress
--- with optional percentage display and customizable colors.
---@class ProgressBar : VisualElement
local ProgressBar = setmetatable({}, VisualElement)
ProgressBar.__index = ProgressBar

---@property progress number 0 Current progress value (0-100)
ProgressBar.defineProperty(ProgressBar, "progress", {default = 0, type = "number", canTriggerRender = true})
---@property showPercentage boolean false Whether to show the percentage text in the center
ProgressBar.defineProperty(ProgressBar, "showPercentage", {default = false, type = "boolean"})
---@property progressColor color lime The color used for the filled portion of the progress bar
ProgressBar.defineProperty(ProgressBar, "progressColor", {default = colors.black, type = "color"})

--- Creates a new ProgressBar instance
--- @shortDescription Creates a new ProgressBar instance
--- @return ProgressBar self The newly created ProgressBar instance
--- @private
function ProgressBar.new()
    local self = setmetatable({}, ProgressBar):__init()
    self.set("width", 10)
    self.set("height", 1)
    return self
end

--- @shortDescription Initializes the ProgressBar instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return ProgressBar self The initialized instance
--- @protected
function ProgressBar:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "ProgressBar")
end

--- @shortDescription Renders the progress bar with filled portion and optional percentage text
--- @protected
function ProgressBar:render()
    VisualElement.render(self)
    local width = self.get("width")
    local progress = math.min(100, math.max(0, self.get("progress")))
    local fillWidth = math.floor((width * progress) / 100)

    for i = 1, self.get("height") do
        self:textBg(1, i, string.rep(" ", fillWidth), self.get("progressColor"))
    end

    if self.get("showPercentage") then
        local text = tostring(progress).."%"
        local x = math.floor((width - #text) / 2) + 1
        self:textFg(x, 1, text, self.get("foreground"))
    end
end

return ProgressBar
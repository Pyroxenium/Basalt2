local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")

--- This is the progress bar class. It provides a visual representation of progress
--- with optional percentage display and customizable colors.
--- @usage local progressBar = main:addProgressBar()
--- @usage progressBar:setDirection("up") 
--- @usage progressBar:setProgress(50)
---@class ProgressBar : VisualElement
local ProgressBar = setmetatable({}, VisualElement)
ProgressBar.__index = ProgressBar

---@property progress number 0 Current progress value (0-100)
ProgressBar.defineProperty(ProgressBar, "progress", {default = 0, type = "number", canTriggerRender = true})
---@property showPercentage boolean false Whether to show the percentage text in the center
ProgressBar.defineProperty(ProgressBar, "showPercentage", {default = false, type = "boolean"})
---@property progressColor color lime The color used for the filled portion of the progress bar
ProgressBar.defineProperty(ProgressBar, "progressColor", {default = colors.black, type = "color"})
---@property direction string right The direction of the progress bar ("up", "down", "left", "right")
ProgressBar.defineProperty(ProgressBar, "direction", {default = "right", type = "string"})

--- Creates a new ProgressBar instance
--- @shortDescription Creates a new ProgressBar instance
--- @return ProgressBar self The newly created ProgressBar instance
--- @private
function ProgressBar.new()
    local self = setmetatable({}, ProgressBar):__init()
    self.class = ProgressBar
    self.set("width", 25)
    self.set("height", 3)
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
    local height = self.get("height")
    local progress = math.min(100, math.max(0, self.get("progress")))
    local fillWidth = math.floor((width * progress) / 100)
    local fillHeight = math.floor((height * progress) / 100)
    local direction = self.get("direction")
    local progressColor = self.get("progressColor")

    if direction == "right" then
        self:multiBlit(1, 1, fillWidth, height, " ", tHex[self.get("foreground")], tHex[progressColor])
    elseif direction == "left" then
        self:multiBlit(width - fillWidth + 1, 1, fillWidth, height, " ", tHex[self.get("foreground")], tHex[progressColor])
    elseif direction == "up" then
        self:multiBlit(1, height - fillHeight + 1, width, fillHeight, " ", tHex[self.get("foreground")], tHex[progressColor])
    elseif direction == "down" then
        self:multiBlit(1, 1, width, fillHeight, " ", tHex[self.get("foreground")], tHex[progressColor])
    end

    if self.get("showPercentage") then
        local text = tostring(progress).."%"
        local x = math.floor((width - #text) / 2) + 1
        local y = math.floor((height - 1) / 2) + 1
        self:textFg(x, y, text, self.get("foreground"))
    end
end

return ProgressBar
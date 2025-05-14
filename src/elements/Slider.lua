local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")

--- This is the slider class. It provides a draggable slider control that can be either horizontal or vertical,
--- with customizable colors and value ranges.
---@class Slider : VisualElement
local Slider = setmetatable({}, VisualElement)
Slider.__index = Slider

---@property step number 1 Current position of the slider handle (1 to width/height)
Slider.defineProperty(Slider, "step", {default = 1, type = "number", canTriggerRender = true})
---@property max number 100 Maximum value for value conversion (maps slider position to this range)
Slider.defineProperty(Slider, "max", {default = 100, type = "number"})
---@property horizontal boolean true Whether the slider is horizontal (false for vertical)
Slider.defineProperty(Slider, "horizontal", {default = true, type = "boolean", canTriggerRender = true, setter=function(self, value)
    if value then
        self.set("backgroundEnabled", false)
    else
        self.set("backgroundEnabled", true)
    end
end})
---@property barColor color gray Color of the slider track
Slider.defineProperty(Slider, "barColor", {default = colors.gray, type = "color", canTriggerRender = true})
---@property sliderColor color blue Color of the slider handle
Slider.defineProperty(Slider, "sliderColor", {default = colors.blue, type = "color", canTriggerRender = true})

---@event onChange {value number} Fired when the slider value changes
Slider.defineEvent(Slider, "mouse_click")
Slider.defineEvent(Slider, "mouse_drag")
Slider.defineEvent(Slider, "mouse_up")
Slider.defineEvent(Slider, "mouse_scroll")

--- Creates a new Slider instance
--- @shortDescription Creates a new Slider instance
--- @return Slider self The newly created Slider instance
--- @private
function Slider.new()
    local self = setmetatable({}, Slider):__init()
    self.class = Slider
    self.set("width", 8)
    self.set("height", 1)
    self.set("backgroundEnabled", false)
    return self
end

--- @shortDescription Initializes the Slider instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Slider self The initialized instance
--- @protected
function Slider:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Slider")
end

--- Gets the current value of the slider
--- @shortDescription Gets the current value mapped to the max range
--- @return number value The current value (0 to max)
--- @usage local value = slider:getValue()
function Slider:getValue()
    local step = self.get("step")
    local max = self.get("max")
    local maxSteps = self.get("horizontal") and self.get("width") or self.get("height")
    return math.floor((step - 1) * (max / (maxSteps - 1)))
end

--- @shortDescription Updates slider position on mouse click
--- @param button number The mouse button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function Slider:mouse_click(button, x, y)
    if self:isInBounds(x, y) then
        local relX, relY = self:getRelativePosition(x, y)
        local pos = self.get("horizontal") and relX or relY
        local maxSteps = self.get("horizontal") and self.get("width") or self.get("height")

        self.set("step", math.min(maxSteps, math.max(1, pos)))
        self:updateRender()
        return true
    end
    return false
end
Slider.mouse_drag = Slider.mouse_click

--- @shortDescription Handles mouse release events
--- @param button number The mouse button that was released
--- @param x number The x position of the release
--- @param y number The y position of the release
--- @return boolean handled Whether the event was handled
--- @protected
function Slider:mouse_scroll(direction, x, y)
    if self:isInBounds(x, y) then
        local step = self.get("step")
        local maxSteps = self.get("horizontal") and self.get("width") or self.get("height")
        self.set("step", math.min(maxSteps, math.max(1, step + direction)))
        self:updateRender()
        return true
    end
    return false
end

--- @shortDescription Renders the slider with track and handle
--- @protected
function Slider:render()
    VisualElement.render(self)
    local width = self.get("width")
    local height = self.get("height")
    local horizontal = self.get("horizontal")
    local step = self.get("step")

    local barChar = horizontal and "\140" or " "
    local text = string.rep(barChar, horizontal and width or height)

    if horizontal then
        self:textFg(1, 1, text, self.get("barColor"))
        self:textBg(step, 1, " ", self.get("sliderColor"))
    else
        local bg = self.get("background")
        for y = 1, height do
            self:textBg(1, y, " ", bg)
        end
        self:textBg(1, step, " ", self.get("sliderColor"))
    end
end

return Slider
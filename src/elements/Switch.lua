local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local tHex = require("libraries/colorHex")
---@configDescription The Switch is a standard Switch element with click handling and state management.
---@configDefault false

--- The Switch is a standard Switch element with click handling and state management.
---@class Switch : VisualElement
local Switch = setmetatable({}, VisualElement)
Switch.__index = Switch

---@property checked boolean Whether switch is checked
Switch.defineProperty(Switch, "checked", {default = false, type = "boolean", canTriggerRender = true})
---@property text string Text to display next to switch
Switch.defineProperty(Switch, "text", {default = "", type = "string", canTriggerRender = true})
---@property autoSize boolean Whether to automatically size the element to fit switch and text
Switch.defineProperty(Switch, "autoSize", {default = false, type = "boolean"})
---@property onBackground number Background color when ON
Switch.defineProperty(Switch, "onBackground", {default = colors.green, type = "number", canTriggerRender = true})
---@property offBackground number Background color when OFF
Switch.defineProperty(Switch, "offBackground", {default = colors.red, type = "number", canTriggerRender = true})

Switch.defineEvent(Switch, "mouse_click")
Switch.defineEvent(Switch, "mouse_up")

--- @shortDescription Creates a new Switch instance
--- @return table self The created instance
--- @private
function Switch.new()
    local self = setmetatable({}, Switch):__init()
    self.class = Switch
    self.set("width", 2)
    self.set("height", 1)
    self.set("z", 5)
    self.set("backgroundEnabled", true)
    return self
end

--- @shortDescription Initializes the Switch instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @protected
function Switch:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Switch")
end

--- @shortDescription Handles mouse click events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean Whether the event was handled
--- @protected
function Switch:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        self.set("checked", not self.get("checked"))
        return true
    end
    return false
end

--- @shortDescription Renders the Switch
--- @protected
function Switch:render()
    local checked = self.get("checked")
    local text = self.get("text")
    local switchWidth = self.get("width")
    local switchHeight = self.get("height")

    local bgColor = checked and self.get("onBackground") or self.get("offBackground")
    self:multiBlit(1, 1, switchWidth, switchHeight, " ", tHex[self.get("foreground")], tHex[bgColor])

    local sliderSize = math.floor(switchWidth / 2)
    local sliderStart = checked and (switchWidth - sliderSize + 1) or 1
    self:multiBlit(sliderStart, 1, sliderSize, switchHeight, " ", tHex[self.get("foreground")], tHex[self.get("background")])

    if text ~= "" then
        self:textFg(switchWidth + 2, 1, text, self.get("foreground"))
    end
end

return Switch

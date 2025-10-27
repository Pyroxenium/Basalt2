local VisualElement = require("elements/VisualElement")
---@configDescription This is a checkbox. It is a visual element that can be checked.

--- A toggleable UI element that can be checked or unchecked. Displays different text based on its state and supports automatic sizing. Commonly used in forms and settings interfaces for boolean options.
--- @usage -- Create a checkbox for a setting
--- @usage local checkbox = parent:addCheckBox()
--- @usage     :setText("Enable Feature")
--- @usage     :setCheckedText("✓")
--- @usage     :onChange("checked", function(self, checked)
--- @usage         -- React to checkbox state changes
--- @usage         if checked then
--- @usage             -- Handle enabled state
--- @usage         else
--- @usage             -- Handle disabled state
--- @usage         end
--- @usage     end)
--- @class CheckBox : VisualElement
local CheckBox = setmetatable({}, VisualElement)
CheckBox.__index = CheckBox

---@property checked boolean false The current state of the checkbox (true=checked, false=unchecked)
CheckBox.defineProperty(CheckBox, "checked", {default = false, type = "boolean", canTriggerRender = true})
---@property text string empty Text shown when the checkbox is unchecked
CheckBox.defineProperty(CheckBox, "text", {default = " ", type = "string", canTriggerRender = true, setter=function(self, value)
    local checkedText = self.get("checkedText")
    local width = math.max(#value, #checkedText)
    if(self.get("autoSize"))then
        self.set("width", width)
    end
    return value
end})
---@property checkedText string x Text shown when the checkbox is checked
CheckBox.defineProperty(CheckBox, "checkedText", {default = "x", type = "string", canTriggerRender = true, setter=function(self, value)
    local text = self.get("text")
    local width = math.max(#value, #text)
    if(self.get("autoSize"))then
        self.set("width", width)
    end
    return value
end})
---@property autoSize boolean true Automatically adjusts width based on text length
CheckBox.defineProperty(CheckBox, "autoSize", {default = true, type = "boolean"})

CheckBox.defineEvent(CheckBox, "mouse_click")
CheckBox.defineEvent(CheckBox, "mouse_up")

--- @shortDescription Creates a new CheckBox instance
--- @return CheckBox self The created instance
--- @protected
function CheckBox.new()
    local self = setmetatable({}, CheckBox):__init()
    self.class = CheckBox
    self.set("backgroundEnabled", false)
    return self
end

--- @shortDescription Initializes the CheckBox instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @protected
function CheckBox:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "CheckBox")
end

--- Handles mouse interactions to toggle the checkbox state
--- @shortDescription Toggles checked state on mouse click
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean Clicked Whether the event was handled
--- @protected
function CheckBox:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        self.set("checked", not self.get("checked"))
        return true
    end
    return false
end

--- @shortDescription Renders the CheckBox
--- @protected
function CheckBox:render()
    VisualElement.render(self)

    local checked = self.getResolved("checked")
    local defaultText = self.getResolved("text")
    local checkedText = self.getResolved("checkedText")
    local text = string.sub(checked and checkedText or defaultText, 1, self.get("width"))

    self:textFg(1, 1, text, self.getResolved("foreground"))
end

return CheckBox
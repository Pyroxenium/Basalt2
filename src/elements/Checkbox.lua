local VisualElement = require("elements/VisualElement")

--- This is the checkbox class. It is a visual element that can be checked.
---@class Checkbox : VisualElement
local Checkbox = setmetatable({}, VisualElement)
Checkbox.__index = Checkbox

---@property checked boolean Whether checkbox is checked
Checkbox.defineProperty(Checkbox, "checked", {default = false, type = "boolean", canTriggerRender = true})
---@property text string empty Text to display
Checkbox.defineProperty(Checkbox, "text", {default = " ", type = "string", canTriggerRender = true, setter=function(self, value)
    local checkedText = self.get("checkedText")
    local width = math.max(#value, #checkedText)
    if(self.get("autoSize"))then
        self.set("width", width)
    end
    return value
end})
---@property checkedText string Text when checked
Checkbox.defineProperty(Checkbox, "checkedText", {default = "x", type = "string", canTriggerRender = true, setter=function(self, value)
    local text = self.get("text")
    local width = math.max(#value, #text)
    if(self.get("autoSize"))then
        self.set("width", width)
    end
    return value
end})
---@property autoSize boolean true Whether to automatically size the checkbox
Checkbox.defineProperty(Checkbox, "autoSize", {default = true, type = "boolean"})

Checkbox.listenTo(Checkbox, "mouse_click")

--- Creates a new Checkbox instance
--- @shortDescription Creates a new Checkbox instance
--- @return Checkbox self The created instance
function Checkbox.new()
    local self = setmetatable({}, Checkbox):__init()
    return self
end

--- Initializes the Checkbox instance
--- @shortDescription Initializes the Checkbox instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
function Checkbox:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Checkbox")
end

--- Handles mouse click events
--- @shortDescription Handles mouse click events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean Clicked Whether the event was handled
function Checkbox:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        self.set("checked", not self.get("checked"))
        self:fireEvent("change", self.get("checked"))
        return true
    end
    return false
end

--- Renders the Checkbox
--- @shortDescription Renders the Checkbox
function Checkbox:render()
    VisualElement.render(self)

    local checked = self.get("checked")
    local defaultText = self.get("text")
    local checkedText = self.get("checkedText")
    local text = string.sub(checked and checkedText or defaultText, 1, self.get("width"))

    self:textFg(1, 1, text, self.get("foreground"))
end

return Checkbox
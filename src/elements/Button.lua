local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local getCenteredPosition = require("libraries/utils").getCenteredPosition
---@cofnigDescription The Button is a standard button element with click handling and state management.

--- The Button is a standard button element with click handling and state management.
---@class Button : VisualElement
---@configDescription Standard button element with click handling and state management
local Button = setmetatable({}, VisualElement)
Button.__index = Button

---@property text string Button Button text
Button.defineProperty(Button, "text", {default = "Button", type = "string", canTriggerRender = true})

---@event mouse_click The event that is triggered when the button is clicked
Button.defineEvent(Button, "mouse_click")
Button.defineEvent(Button, "mouse_up")

--- Creates a new Button instance
--- @shortDescription Creates a new Button instance
--- @return table self The created instance
function Button.new()
    local self = setmetatable({}, Button):__init()
    self.set("width", 10)
    self.set("height", 3)
    self.set("z", 5)
    return self
end

--- Initializes the Button instance
--- @shortDescription Initializes the Button instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
function Button:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Button")
end

--- Renders the Button
--- @shortDescription Renders the Button
function Button:render()
    VisualElement.render(self)
    local text = self.get("text")
    text = text:sub(1, self.get("width"))
    local xO, yO = getCenteredPosition(text, self.get("width"), self.get("height"))
    self:textFg(xO, yO, text, self.get("foreground"))
end

return Button
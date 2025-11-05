local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local getCenteredPosition = require("libraries/utils").getCenteredPosition
---@configDescription The Button is a standard button element with click handling and state management.

--- A clickable interface element that triggers actions when pressed. Supports text labels, custom styling, and automatic text centering. Commonly used for user interactions and form submissions.
--- @usage [[
--- -- Create a simple action button
--- local button = parent:addButton()
---     :setPosition(5, 5)
---     :setText("Click me!")
---     :setBackground(colors.blue)
---     :setForeground(colors.white)
---
--- -- Add click handling
--- button:onClick(function(self, button, x, y)
---     -- Change appearance when clicked
---     self:setBackground(colors.green)
---     self:setText("Success!")
---     
---     -- Revert after delay
---     basalt.schedule(function()
---         sleep(1)
---         self:setBackground(colors.blue)
---         self:setText("Click me!")
---     end)
--- end)
--- ]]
---@class Button : VisualElement
local Button = setmetatable({}, VisualElement)
Button.__index = Button

---@property text string Button Label text displayed centered within the button
Button.defineProperty(Button, "text", {default = "Button", type = "string", canTriggerRender = true})

Button.defineEvent(Button, "mouse_click")
Button.defineEvent(Button, "mouse_up")

--- @shortDescription Creates a new Button instance
--- @return table self The created instance
--- @private
function Button.new()
    local self = setmetatable({}, Button):__init()
    self.class = Button
    self.set("width", 10)
    self.set("height", 3)
    self.set("z", 5)
    return self
end

--- @shortDescription Initializes the Button instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @protected
function Button:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Button")
end

--- @shortDescription Renders the Button
--- @protected
function Button:render()
    VisualElement.render(self)
    local text = self.getResolved("text")
    text = text:sub(1, self.getResolved("width"))
    local xO, yO = getCenteredPosition(text, self.getResolved("width"), self.getResolved("height"))
    self:textFg(xO, yO, text, self.getResolved("foreground"))
end

return Button
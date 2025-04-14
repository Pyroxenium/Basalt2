local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
---@cofnigDescription The Switch is a standard Switch element with click handling and state management.

--- The Switch is a standard Switch element with click handling and state management.
---@class Switch : VisualElement
local Switch = setmetatable({}, VisualElement)
Switch.__index = Switch

---@property checked boolean Whether switch is checked
Switch.defineProperty(Switch, "checked", {default = false, type = "boolean", canTriggerRender = true})

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

--- @shortDescription Renders the Switch
--- @protected
function Switch:render()
    VisualElement.render(self)
end

return Switch
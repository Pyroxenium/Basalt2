local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")

---@class Label : VisualElement
local Label = setmetatable({}, VisualElement)
Label.__index = Label

---@property text string Label Label text to be displayed
Label.defineProperty(Label, "text", {default = "Label", type = "string", setter = function(self, value)
    if(type(value)=="function")then value = value() end
    self.set("width", #value)
    return value
end})

--- Creates a new Label instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Label object The newly created Label instance
--- @usage local element = Label.new("myId", basalt)
function Label.new(props, basalt)
    local self = setmetatable({}, Label):__init()
    self.set("z", 3)
    self.set("foreground", colors.black)
    self.set("backgroundEnabled", false)
    self:init(props, basalt)
    return self
end

function Label:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Label")
end

function Label:render()
    VisualElement.render(self)
    local text = self.get("text")
    self:textFg(1, 1, text, self.get("foreground"))
end

return Label
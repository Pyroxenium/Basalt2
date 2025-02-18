local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")

--- This is the label class. It provides a simple text display element that automatically
--- resizes its width based on the text content.
---@class Label : VisualElement
local Label = setmetatable({}, VisualElement)
Label.__index = Label

---@property text string Label The text content to display. Can be a string or a function that returns a string
Label.defineProperty(Label, "text", {default = "Label", type = "string", setter = function(self, value)
    if(type(value)=="function")then value = value() end
    self.set("width", #value)
    return value
end})

--- Creates a new Label instance
--- @shortDescription Creates a new Label instance
--- @return Label self The newly created Label instance
--- @usage local label = Label.new()
function Label.new()
    local self = setmetatable({}, Label):__init()
    self.set("z", 3)
    self.set("foreground", colors.black)
    self.set("backgroundEnabled", false)
    return self
end

--- Initializes the Label instance
--- @shortDescription Initializes the Label instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Label self The initialized instance
function Label:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Label")
    return self
end

--- Renders the Label
--- @shortDescription Renders the Label by drawing its text content
function Label:render()
    VisualElement.render(self)
    local text = self.get("text")
    self:textFg(1, 1, text, self.get("foreground"))
end

return Label
local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local wrapText = require("libraries/utils").wrapText
---@configDescription A simple text display element that automatically resizes its width based on the text content.

--- This is the label class. It provides a simple text display element that automatically
--- resizes its width based on the text content.
---@class Label : VisualElement
local Label = setmetatable({}, VisualElement)
Label.__index = Label

---@property text string Label The text content to display. Can be a string or a function that returns a string
Label.defineProperty(Label, "text", {default = "Label", type = "string", canTriggerRender = true, setter = function(self, value)
    if(type(value)=="function")then value = value() end
    if(self.get("autoSize"))then
        self.set("width", #value)
    else
        self.set("height", #wrapText(value, self.get("width")))
    end
    return value
end})

---@property autoSize boolean true Whether the label should automatically resize its width based on the text content
Label.defineProperty(Label, "autoSize", {default = true, type = "boolean", canTriggerRender = true, setter = function(self, value)
    if(value)then
        self.set("width", #self.get("text"))
    else
        self.set("height", #wrapText(self.get("text"), self.get("width")))
    end
    return value
end})

--- Creates a new Label instance
--- @shortDescription Creates a new Label instance
--- @return Label self The newly created Label instance
--- @private
function Label.new()
    local self = setmetatable({}, Label):__init()
    self.class = Label
    self.set("z", 3)
    self.set("foreground", colors.black)
    self.set("backgroundEnabled", false)
    return self
end

--- @shortDescription Initializes the Label instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Label self The initialized instance
--- @protected
function Label:init(props, basalt)
    VisualElement.init(self, props, basalt)
    if(self.parent)then
        self.set("background", self.parent.get("background"))
        self.set("foreground", self.parent.get("foreground"))
    end
    self.set("type", "Label")
    return self
end

--- Gets the wrapped lines of the Label
--- @shortDescription Gets the wrapped lines of the Label
--- @return table wrappedText The wrapped lines of the Label
function Label:getWrappedText()
    local text = self.get("text")
    local wrappedText = wrapText(text, self.get("width"))
    return wrappedText
end

--- @shortDescription Renders the Label by drawing its text content
--- @protected
function Label:render()
    VisualElement.render(self)
    local text = self.get("text")
    if(self.get("autoSize"))then
        self:textFg(1, 1, text, self.get("foreground"))
    else
        local wrappedText = wrapText(text, self.get("width"))
        for i, line in ipairs(wrappedText) do
            self:textFg(1, i, line, self.get("foreground"))
        end
    end
end

return Label
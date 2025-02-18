local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")

---A scrollbar element that can be attached to other elements to control their scroll properties
---@class Scrollbar : VisualElement
local Scrollbar = setmetatable({}, VisualElement)
Scrollbar.__index = Scrollbar

---@property value number 0 Current scroll value
Scrollbar.defineProperty(Scrollbar, "value", {default = 0, type = "number", canTriggerRender = true})
---@property min number 0 Minimum scroll value
Scrollbar.defineProperty(Scrollbar, "min", {default = 0, type = "number", canTriggerRender = true})
---@property max number 100 Maximum scroll value
Scrollbar.defineProperty(Scrollbar, "max", {default = 100, type = "number", canTriggerRender = true})
---@property step number 1 Step size for scroll operations
Scrollbar.defineProperty(Scrollbar, "step", {default = 10, type = "number"})
---@property dragMultiplier number 1 How fast the scrollbar moves when dragging
Scrollbar.defineProperty(Scrollbar, "dragMultiplier", {default = 1, type = "number"})
---@property symbol string " " Symbol used for the scrollbar handle
Scrollbar.defineProperty(Scrollbar, "symbol", {default = " ", type = "string", canTriggerRender = true})
---@property backgroundSymbol string "\127" Symbol used for the scrollbar background
Scrollbar.defineProperty(Scrollbar, "symbolColor", {default = colors.gray, type = "number", canTriggerRender = true})
---@property symbolBackgroundColor color black Background color of the scrollbar handle
Scrollbar.defineProperty(Scrollbar, "symbolBackgroundColor", {default = colors.black, type = "number", canTriggerRender = true})
---@property backgroundSymbol string "\127" Symbol used for the scrollbar background
Scrollbar.defineProperty(Scrollbar, "backgroundSymbol", {default = "\127", type = "string", canTriggerRender = true})
---@property attachedElement table? nil The element this scrollbar is attached to
Scrollbar.defineProperty(Scrollbar, "attachedElement", {default = nil, type = "table"})
---@property attachedProperty string? nil The property being controlled
Scrollbar.defineProperty(Scrollbar, "attachedProperty", {default = nil, type = "string"})
---@property minValue number|function 0 Minimum value or function that returns it
Scrollbar.defineProperty(Scrollbar, "minValue", {default = 0, type = "number"})
---@property maxValue number|function 100 Maximum value or function that returns it
Scrollbar.defineProperty(Scrollbar, "maxValue", {default = 100, type = "number"})
---@property orientation string vertical Orientation of the scrollbar ("vertical" or "horizontal")
Scrollbar.defineProperty(Scrollbar, "orientation", {default = "vertical", type = "string", canTriggerRender = true})

---@property handleSize number 2 Size of the scrollbar handle in characters
Scrollbar.defineProperty(Scrollbar, "handleSize", {default = 2, type = "number", canTriggerRender = true})

Scrollbar.listenTo(Scrollbar, "mouse_click")
Scrollbar.listenTo(Scrollbar, "mouse_release")
Scrollbar.listenTo(Scrollbar, "mouse_drag")
Scrollbar.listenTo(Scrollbar, "mouse_scroll")

--- Creates a new Scrollbar instance
--- @shortDescription Creates a new Scrollbar instance
--- @return Scrollbar self The newly created Scrollbar instance
--- @usage local scrollbar = Scrollbar.new()
function Scrollbar.new()
    local self = setmetatable({}, Scrollbar):__init()
    self.set("width", 1)
    self.set("height", 10)
    return self
end

function Scrollbar:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Scrollbar")
    return self
end

--- Attaches the scrollbar to an element's property
--- @param element BaseElement The element to attach to
--- @param config table Configuration {property = "propertyName", min = number|function, max = number|function}
--- @return Scrollbar self The scrollbar instance
function Scrollbar:attach(element, config)
    self.set("attachedElement", element)
    self.set("attachedProperty", config.property)
    self.set("minValue", config.min or 0)
    self.set("maxValue", config.max or 100)
    return self
end

function Scrollbar:updateAttachedElement()
    local element = self.get("attachedElement")
    if not element then return end

    local value = self.get("value")
    local min = self.get("minValue")
    local max = self.get("maxValue")

    if type(min) == "function" then min = min() end
    if type(max) == "function" then max = max() end

    local mappedValue = min + (value / 100) * (max - min)
    element.set(self.get("attachedProperty"), math.floor(mappedValue + 0.5))
end

local function getScrollbarSize(self)
    return self.get("orientation") == "vertical" and self.get("height") or self.get("width")
end

local function getRelativeScrollPosition(self, x, y)
    local relX, relY = self:getRelativePosition(x, y)
    return self.get("orientation") == "vertical" and relY or relX
end

function Scrollbar:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        local size = getScrollbarSize(self)
        local value = self.get("value")
        local handleSize = self.get("handleSize")

        local handlePos = math.floor((value / 100) * (size - handleSize)) + 1
        local relPos = getRelativeScrollPosition(self, x, y)

        if relPos >= handlePos and relPos < handlePos + handleSize then
            self.dragOffset = relPos - handlePos
        else
            local newValue = ((relPos - 1) / (size - handleSize)) * 100
            self.set("value", math.min(100, math.max(0, newValue)))
            self:updateAttachedElement()
        end
        return true
    end
end

function Scrollbar:mouse_drag(button, x, y)
    if(VisualElement.mouse_drag(self, button, x, y))then
        local size = getScrollbarSize(self)
        local handleSize = self.get("handleSize")
        local dragMultiplier = self.get("dragMultiplier")
        local relPos = getRelativeScrollPosition(self, x, y)

        relPos = math.max(1, math.min(size, relPos))

        local newPos = relPos - (self.dragOffset or 0)
        local newValue = (newPos - 1) / (size - handleSize) * 100 * dragMultiplier

        self.set("value", math.min(100, math.max(0, newValue)))
        self:updateAttachedElement()
        return true
    end
end

function Scrollbar:mouse_scroll(direction, x, y)
    if not self:isInBounds(x, y) then return false end
    direction = direction > 0 and -1 or 1
    local step = self.get("step")
    local currentValue = self.get("value")
    local newValue = currentValue - direction * step

    self.set("value", math.min(100, math.max(0, newValue)))
    self:updateAttachedElement()
    return true
end

function Scrollbar:render()
    VisualElement.render(self)

    local size = getScrollbarSize(self)
    local value = self.get("value")
    local handleSize = self.get("handleSize")
    local symbol = self.get("symbol")
    local symbolColor = self.get("symbolColor")
    local symbolBackgroundColor = self.get("symbolBackgroundColor")
    local bgSymbol = self.get("backgroundSymbol")
    local isVertical = self.get("orientation") == "vertical"

    local handlePos = math.floor((value / 100) * (size - handleSize)) + 1

    for i = 1, size do
        if isVertical then
            self:blit(1, i, bgSymbol, tHex[self.get("foreground")], tHex[self.get("background")])
        else
            self:blit(i, 1, bgSymbol, tHex[self.get("foreground")], tHex[self.get("background")])
        end
    end

    for i = handlePos, handlePos + handleSize - 1 do
        if isVertical then
            self:blit(1, i, symbol, tHex[symbolColor], tHex[symbolBackgroundColor])
        else
            self:blit(i, 1, symbol, tHex[symbolColor], tHex[symbolBackgroundColor])
        end
    end
end

return Scrollbar

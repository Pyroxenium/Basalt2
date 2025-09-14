local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")

---A ScrollBar element that can be attached to other elements to control their scroll properties
---@class ScrollBar : VisualElement
local ScrollBar = setmetatable({}, VisualElement)
ScrollBar.__index = ScrollBar

---@property value number 0 Current scroll value
ScrollBar.defineProperty(ScrollBar, "value", {default = 0, type = "number", canTriggerRender = true})
---@property min number 0 Minimum scroll value
ScrollBar.defineProperty(ScrollBar, "min", {default = 0, type = "number", canTriggerRender = true})
---@property max number 100 Maximum scroll value
ScrollBar.defineProperty(ScrollBar, "max", {default = 100, type = "number", canTriggerRender = true})
---@property step number 1 Step size for scroll operations
ScrollBar.defineProperty(ScrollBar, "step", {default = 10, type = "number"})
---@property dragMultiplier number 1 How fast the ScrollBar moves when dragging
ScrollBar.defineProperty(ScrollBar, "dragMultiplier", {default = 1, type = "number"})
---@property symbol string " " Symbol used for the ScrollBar handle
ScrollBar.defineProperty(ScrollBar, "symbol", {default = " ", type = "string", canTriggerRender = true})
---@property backgroundSymbol string "\127" Symbol used for the ScrollBar background
ScrollBar.defineProperty(ScrollBar, "symbolColor", {default = colors.gray, type = "color", canTriggerRender = true})
---@property symbolBackgroundColor color black Background color of the ScrollBar handle
ScrollBar.defineProperty(ScrollBar, "symbolBackgroundColor", {default = colors.black, type = "color", canTriggerRender = true})
---@property backgroundSymbol string "\127" Symbol used for the ScrollBar background
ScrollBar.defineProperty(ScrollBar, "backgroundSymbol", {default = "\127", type = "string", canTriggerRender = true})
---@property attachedElement table? nil The element this ScrollBar is attached to
ScrollBar.defineProperty(ScrollBar, "attachedElement", {default = nil, type = "table"})
---@property attachedProperty string? nil The property being controlled
ScrollBar.defineProperty(ScrollBar, "attachedProperty", {default = nil, type = "string"})
---@property minValue number|function 0 Minimum value or function that returns it
ScrollBar.defineProperty(ScrollBar, "minValue", {default = 0, type = "number"})
---@property maxValue number|function 100 Maximum value or function that returns it
ScrollBar.defineProperty(ScrollBar, "maxValue", {default = 100, type = "number"})
---@property orientation string vertical Orientation of the ScrollBar ("vertical" or "horizontal")
ScrollBar.defineProperty(ScrollBar, "orientation", {default = "vertical", type = "string", canTriggerRender = true})

---@property handleSize number 2 Size of the ScrollBar handle in characters
ScrollBar.defineProperty(ScrollBar, "handleSize", {default = 2, type = "number", canTriggerRender = true})

ScrollBar.defineEvent(ScrollBar, "mouse_click")
ScrollBar.defineEvent(ScrollBar, "mouse_release")
ScrollBar.defineEvent(ScrollBar, "mouse_drag")
ScrollBar.defineEvent(ScrollBar, "mouse_scroll")

--- Creates a new ScrollBar instance
--- @shortDescription Creates a new ScrollBar instance
--- @return ScrollBar self The newly created ScrollBar instance
--- @private
function ScrollBar.new()
    local self = setmetatable({}, ScrollBar):__init()
    self.class = ScrollBar
    self.set("width", 1)
    self.set("height", 10)
    return self
end

--- @shortDescription Initializes the ScrollBar instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return ScrollBar self The initialized instance
--- @protected
function ScrollBar:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "ScrollBar")
    return self
end

--- Attaches the ScrollBar to an element's property
--- @shortDescription Attaches the ScrollBar to an element's property
--- @param element BaseElement The element to attach to
--- @param config table Configuration {property = "propertyName", min = number|function, max = number|function}
--- @return ScrollBar self The ScrollBar instance
function ScrollBar:attach(element, config)
    self.set("attachedElement", element)
    self.set("attachedProperty", config.property)
    self.set("minValue", config.min or 0)
    self.set("maxValue", config.max or 100)
    element:observe(config.property, function(_, value)
        if value then
            local min = self.get("minValue")
            local max = self.get("maxValue")
            if min == max then return end
            
            self.set("value", math.floor(
                (value - min) / (max - min) * 100 + 0.5
            ))
        end
    end)
    return self
end

--- Updates the attached element's property based on the ScrollBar value
--- @shortDescription Updates the attached element's property based on the ScrollBar value
--- @return ScrollBar self The ScrollBar instance
function ScrollBar:updateAttachedElement()
    local element = self.get("attachedElement")
    if not element then return end

    local value = self.get("value")
    local min = self.get("minValue")
    local max = self.get("maxValue")

    if type(min) == "function" then min = min() end
    if type(max) == "function" then max = max() end

    local mappedValue = min + (value / 100) * (max - min)
    element.set(self.get("attachedProperty"), math.floor(mappedValue + 0.5))
    return self
end

local function getScrollbarSize(self)
    return self.get("orientation") == "vertical" and self.get("height") or self.get("width")
end

local function getRelativeScrollPosition(self, x, y)
    local relX, relY = self:getRelativePosition(x, y)
    return self.get("orientation") == "vertical" and relY or relX
end

--- @shortDescription Handles mouse click events
--- @param button number The mouse button clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean Whether the event was handled
--- @protected
function ScrollBar:mouse_click(button, x, y)
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

--- @shortDescription Handles mouse drag events
--- @param button number The mouse button being dragged
--- @param x number The x position of the drag
--- @param y number The y position of the drag
--- @return boolean Whether the event was handled
--- @protected
function ScrollBar:mouse_drag(button, x, y)
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

--- @shortDescription Handles mouse scroll events
--- @param direction number The scroll direction (1 for up, -1 for down)
--- @param x number The x position of the scroll
--- @param y number The y position of the scroll
--- @return boolean Whether the event was handled
--- @protected
function ScrollBar:mouse_scroll(direction, x, y)
    if not self:isInBounds(x, y) then return false end
    direction = direction > 0 and -1 or 1
    local step = self.get("step")
    local currentValue = self.get("value")
    local newValue = currentValue - direction * step

    self.set("value", math.min(100, math.max(0, newValue)))
    self:updateAttachedElement()
    return true
end

--- @shortDescription Renders the ScrollBar
--- @protected
function ScrollBar:render()
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

return ScrollBar

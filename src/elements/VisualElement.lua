---@diagnostic disable: duplicate-set-field, undefined-field, undefined-doc-name, param-type-mismatch, redundant-return-value
local elementManager = require("elementManager")
local BaseElement = elementManager.getElement("BaseElement")
local tHex = require("libraries/colorHex")
---@configDescription The Visual Element class which is the base class for all visual UI elements

--- This is the visual element class. It serves as the base class for all visual UI elements
--- and provides core functionality for positioning, sizing, colors, and rendering.
---@class VisualElement : BaseElement
local VisualElement = setmetatable({}, BaseElement)
VisualElement.__index = VisualElement

---@property x number 1 The horizontal position relative to parent
VisualElement.defineProperty(VisualElement, "x", {default = 1, type = "number", canTriggerRender = true})
---@property y number 1 The vertical position relative to parent
VisualElement.defineProperty(VisualElement, "y", {default = 1, type = "number", canTriggerRender = true})
---@property z number 1 The z-index for layering elements
VisualElement.defineProperty(VisualElement, "z", {default = 1, type = "number", canTriggerRender = true, setter = function(self, value)
    if self.parent then
        self.parent:sortChildren()
    end
    return value
end})


VisualElement.defineProperty(VisualElement, "constraints", {
    default = {},
    type = "table"
})

---@property width number 1 The width of the element
VisualElement.defineProperty(VisualElement, "width", {default = 1, type = "number", canTriggerRender = true})
---@property height number 1 The height of the element
VisualElement.defineProperty(VisualElement, "height", {default = 1, type = "number", canTriggerRender = true})
---@property background color black The background color
VisualElement.defineProperty(VisualElement, "background", {default = colors.black, type = "color", canTriggerRender = true})
---@property foreground color white The text/foreground color
VisualElement.defineProperty(VisualElement, "foreground", {default = colors.white, type = "color", canTriggerRender = true})
---@property backgroundEnabled boolean true Whether to render the background
VisualElement.defineProperty(VisualElement, "backgroundEnabled", {default = true, type = "boolean", canTriggerRender = true})
---@property borderTop boolean false Draw top border
VisualElement.defineProperty(VisualElement, "borderTop", {default = false, type = "boolean", canTriggerRender = true})
---@property borderBottom boolean false Draw bottom border
VisualElement.defineProperty(VisualElement, "borderBottom", {default = false, type = "boolean", canTriggerRender = true})
---@property borderLeft boolean false Draw left border
VisualElement.defineProperty(VisualElement, "borderLeft", {default = false, type = "boolean", canTriggerRender = true})
---@property borderRight boolean false Draw right border
VisualElement.defineProperty(VisualElement, "borderRight", {default = false, type = "boolean", canTriggerRender = true})
---@property borderColor color white Border color
VisualElement.defineProperty(VisualElement, "borderColor", {default = colors.white, type = "color", canTriggerRender = true})

---@property visible boolean true Whether the element is visible
VisualElement.defineProperty(VisualElement, "visible", {default = true, type = "boolean", canTriggerRender = true, setter=function(self, value)
    if(self.parent~=nil)then
        self.parent.set("childrenSorted", false)
        self.parent.set("childrenEventsSorted", false)
    end
    if(value==false)then
        self:unsetState("clicked")
    end
    return value
end})

---@property ignoreOffset boolean false Whether to ignore the parent's offset
VisualElement.defineProperty(VisualElement, "ignoreOffset", {default = false, type = "boolean"})

---@combinedProperty position {x number, y number} Combined x, y position
VisualElement.combineProperties(VisualElement, "position", "x", "y")
---@combinedProperty size {width number, height number} Combined width, height
VisualElement.combineProperties(VisualElement, "size", "width", "height")
---@combinedProperty color {foreground number, background number} Combined foreground, background colors
VisualElement.combineProperties(VisualElement, "color", "foreground", "background")

---@event onClick {button string, x number, y number} Fired on mouse click
---@event onMouseUp {button, x, y} Fired on mouse button release
---@event onRelease {button, x, y} Fired when mouse leaves while clicked
---@event onDrag {button, x, y} Fired when mouse moves while clicked
---@event onScroll {direction, x, y} Fired on mouse scroll
---@event onEnter {-} Fired when mouse enters element
---@event onLeave {-} Fired when mouse leaves element
---@event onFocus {-} Fired when element receives focus
---@event onBlur {-} Fired when element loses focus
---@event onKey {key} Fired on key press
---@event onKeyUp {key} Fired on key release
---@event onChar {char} Fired on character input

VisualElement.defineEvent(VisualElement, "focus")
VisualElement.defineEvent(VisualElement, "blur")

VisualElement.registerEventCallback(VisualElement, "Click", "mouse_click", "mouse_up")
VisualElement.registerEventCallback(VisualElement, "ClickUp", "mouse_up", "mouse_click")
VisualElement.registerEventCallback(VisualElement, "Drag", "mouse_drag", "mouse_click", "mouse_up")
VisualElement.registerEventCallback(VisualElement, "Scroll", "mouse_scroll")
VisualElement.registerEventCallback(VisualElement, "Enter", "mouse_enter", "mouse_move")
VisualElement.registerEventCallback(VisualElement, "LeEave", "mouse_leave", "mouse_move")
VisualElement.registerEventCallback(VisualElement, "Focus", "focus", "blur")
VisualElement.registerEventCallback(VisualElement, "Blur", "blur", "focus")
VisualElement.registerEventCallback(VisualElement, "Key", "key", "key_up")
VisualElement.registerEventCallback(VisualElement, "Char", "char")
VisualElement.registerEventCallback(VisualElement, "KeyUp", "key_up", "key")

local max, min = math.max, math.min

--- Creates a new VisualElement instance
--- @shortDescription Creates a new visual element
--- @return VisualElement object The newly created VisualElement instance
--- @private
function VisualElement.new()
    local self = setmetatable({}, VisualElement):__init()
    self.class = VisualElement
    return self
end

--- @shortDescription Initializes a new visual element with properties
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @protected
function VisualElement:init(props, basalt)
    BaseElement.init(self, props, basalt)
    self.set("type", "VisualElement")
    self:registerState("disabled", nil, 1000)
    self:registerState("clicked", nil, 500)
    self:registerState("hover", nil, 400)
    self:registerState("focused", nil, 300)
    self:registerState("dragging", nil, 600)

    self:observe("x", function()
        if self.parent then
            self.parent.set("childrenSorted", false)
        end
    end)
    self:observe("y", function()
        if self.parent then
            self.parent.set("childrenSorted", false)
        end
    end)
    self:observe("width", function()
        if self.parent then
            self.parent.set("childrenSorted", false)
        end
    end)
    self:observe("height", function()
        if self.parent then
            self.parent.set("childrenSorted", false)
        end
    end)
    self:observe("visible", function()
        if self.parent then
            self.parent.set("childrenSorted", false)
        end
    end)
end

--- Sets a constraint on a property relative to another element's property
--- @shortDescription Sets a constraint on a property relative to another element's property
--- @param property string The property to constrain (x, y, width, height, left, right, top, bottom, centerX, centerY)
--- @param targetElement BaseElement|string The target element or "parent"
--- @param targetProperty string The target property to constrain to (left, right, top, bottom, centerX, centerY, width, height)
--- @param offset number The offset to apply (negative = inside, positive = outside, fractional = percentage)
--- @return VisualElement self The element instance
function VisualElement:setConstraint(property, targetElement, targetProperty, offset)
    local constraints = self.get("constraints")
    if constraints[property] then
        self:_removeConstraintObservers(property, constraints[property])
    end

    constraints[property] = {
        element = targetElement,
        property = targetProperty,
        offset = offset or 0
    }

    self.set("constraints", constraints)
    self:_addConstraintObservers(property, constraints[property])

    self._constraintsDirty = true
    self:updateRender()
    return self
end

--- Resolves all constraints for the element
--- @shortDescription Resolves all constraints for the element
--- @return VisualElement self The element instance
function VisualElement:resolveAllConstraints()
    if not self._constraintsDirty then return self end
    local constraints = self.get("constraints")
    if not constraints or not next(constraints) then return self end

    local order = {"width", "height", "left", "right", "top", "bottom", "x", "y", "centerX", "centerY"}

    for _, property in ipairs(order) do
        if constraints[property] then
            local value = self:_resolveConstraint(property, constraints[property])
            self:_applyConstraintValue(property, value)
        end
    end
    self._constraintsDirty = false
    return self
end

--- Applies a resolved constraint value to the appropriate property
--- @private
function VisualElement:_applyConstraintValue(property, value)
    if property == "x" or property == "left" then
        self.set("x", value)
    elseif property == "y" or property == "top" then
        self.set("y", value)
    elseif property == "right" then
        local width = self.get("width")
        self.set("x", value - width + 1)
    elseif property == "bottom" then
        local height = self.get("height")
        self.set("y", value - height + 1)
    elseif property == "centerX" then
        local width = self.get("width")
        self.set("x", value - math.floor(width / 2))
    elseif property == "centerY" then
        local height = self.get("height")
        self.set("y", value - math.floor(height / 2))
    elseif property == "width" then
        self.set("width", value)
    elseif property == "height" then
        self.set("height", value)
    end
end

--- Adds observers for a specific constraint to track changes in the target element
--- @private
function VisualElement:_addConstraintObservers(constraintProp, constraint)
    local targetEl = constraint.element
    local targetProp = constraint.property

    if targetEl == "parent" then
        targetEl = self.parent
    end

    if not targetEl then return end

    local callback = function()
        self._constraintsDirty = true
        self:resolveAllConstraints()
        self:updateRender()
    end

    if not self._constraintObserverCallbacks then
        self._constraintObserverCallbacks = {}
    end

    if not self._constraintObserverCallbacks[constraintProp] then
        self._constraintObserverCallbacks[constraintProp] = {}
    end

    local observeProps = {}

    if targetProp == "left" or targetProp == "x" then
        observeProps = {"x"}
    elseif targetProp == "right" then
        observeProps = {"x", "width"}
    elseif targetProp == "top" or targetProp == "y" then
        observeProps = {"y"}
    elseif targetProp == "bottom" then
        observeProps = {"y", "height"}
    elseif targetProp == "centerX" then
        observeProps = {"x", "width"}
    elseif targetProp == "centerY" then
        observeProps = {"y", "height"}
    elseif targetProp == "width" then
        observeProps = {"width"}
    elseif targetProp == "height" then
        observeProps = {"height"}
    end

    for _, prop in ipairs(observeProps) do
        targetEl:observe(prop, callback)
        table.insert(self._constraintObserverCallbacks[constraintProp], {
            element = targetEl,
            property = prop,
            callback = callback
        })
    end
end

--- Removes observers for a specific constraint
--- @private
function VisualElement:_removeConstraintObservers(constraintProp, constraint)
    if not self._constraintObserverCallbacks or not self._constraintObserverCallbacks[constraintProp] then
        return
    end

    for _, observer in ipairs(self._constraintObserverCallbacks[constraintProp]) do
        observer.element:removeObserver(observer.property, observer.callback)
    end

    self._constraintObserverCallbacks[constraintProp] = nil
end

--- Removes all constraint observers from the element
--- @private
function VisualElement:_removeAllConstraintObservers()
    if not self._constraintObserverCallbacks then return end

    for constraintProp, observers in pairs(self._constraintObserverCallbacks) do
        for _, observer in ipairs(observers) do
            observer.element:removeObserver(observer.property, observer.callback)
        end
    end

    self._constraintObserverCallbacks = nil
end

--- Removes a constraint from the element
--- @shortDescription Removes a constraint from the element
--- @param property string The property of the constraint to remove
--- @return VisualElement self The element instance
function VisualElement:removeConstraint(property)
    local constraints = self.get("constraints")
    constraints[property] = nil
    self.set("constraints", constraints)
    self:updateConstraints()
    return self
end

--- Updates all constraints, recalculating positions and sizes
--- @shortDescription Updates all constraints, recalculating positions and sizes
--- @return VisualElement self The element instance
function VisualElement:updateConstraints()
    local constraints = self.get("constraints")

    for property, constraint in pairs(constraints) do
        local value = self:_resolveConstraint(property, constraint)

        if property == "x" or property == "left" then
            self.set("x", value)
        elseif property == "y" or property == "top" then
            self.set("y", value)
        elseif property == "right" then
            local width = self.get("width")
            self.set("x", value - width + 1)
        elseif property == "bottom" then
            local height = self.get("height")
            self.set("y", value - height + 1)
        elseif property == "centerX" then
            local width = self.get("width")
            self.set("x", value - math.floor(width / 2))
        elseif property == "centerY" then
            local height = self.get("height")
            self.set("y", value - math.floor(height / 2))
        elseif property == "width" then
            self.set("width", value)
        elseif property == "height" then
            self.set("height", value)
        end
    end
end

--- Resolves a constraint to an absolute value
--- @private
function VisualElement:_resolveConstraint(property, constraint)
    local targetEl = constraint.element
    local targetProp = constraint.property
    local offset = constraint.offset

    if targetEl == "parent" then
        targetEl = self.parent
    end

    if not targetEl then
        return self.get(property) or 1
    end

    local value
    if targetProp == "left" or targetProp == "x" then
        value = targetEl.get("x")
    elseif targetProp == "right" then
        value = targetEl.get("x") + targetEl.get("width") - 1
    elseif targetProp == "top" or targetProp == "y" then
        value = targetEl.get("y")
    elseif targetProp == "bottom" then
        value = targetEl.get("y") + targetEl.get("height") - 1
    elseif targetProp == "centerX" then
        value = targetEl.get("x") + math.floor(targetEl.get("width") / 2)
    elseif targetProp == "centerY" then
        value = targetEl.get("y") + math.floor(targetEl.get("height") / 2)
    elseif targetProp == "width" then
        value = targetEl.get("width")
    elseif targetProp == "height" then
        value = targetEl.get("height")
    end

    if type(offset) == "number" then
        if offset > -1 and offset < 1 and offset ~= 0 then
            return math.floor(value * offset)
        else
            return value + offset
        end
    end

    return value
end

--- Aligns the element's right edge to the target's right edge with optional offset
--- @shortDescription Aligns the element's right edge to the target's right edge with optional offset
--- @param target BaseElement|string The target element or "parent"
--- @param offset? number Offset from the edge (negative = inside, positive = outside, default: 0)
--- @return VisualElement self
function VisualElement:alignRight(target, offset)
    offset = offset or 0
    return self:setConstraint("right", target, "right", offset)
end

--- Aligns the element's left edge to the target's left edge with optional offset
--- @shortDescription Aligns the element's left edge to the target's left edge with optional offset
--- @param target BaseElement|string The target element or "parent"
--- @param offset? number Offset from the edge (negative = inside, positive = outside, default: 0)
--- @return VisualElement self
function VisualElement:alignLeft(target, offset)
    offset = offset or 0
    return self:setConstraint("left", target, "left", offset)
end

--- Aligns the element's top edge to the target's top edge with optional offset
--- @shortDescription Aligns the element's top edge to the target's top edge with optional offset
--- @param target BaseElement|string The target element or "parent"
--- @param offset? number Offset from the edge (negative = inside, positive = outside, default: 0)
--- @return VisualElement self
function VisualElement:alignTop(target, offset)
    offset = offset or 0
    return self:setConstraint("top", target, "top", offset)
end

--- Aligns the element's bottom edge to the target's bottom edge with optional offset
--- @shortDescription Aligns the element's bottom edge to the target's bottom edge with optional offset
--- @param target BaseElement|string The target element or "parent"
--- @param offset? number Offset from the edge (negative = inside, positive = outside, default: 0)
--- @return VisualElement self
function VisualElement:alignBottom(target, offset)
    offset = offset or 0
    return self:setConstraint("bottom", target, "bottom", offset)
end

--- Centers the element horizontally relative to the target with optional offset
--- @shortDescription Centers the element horizontally relative to the target with optional offset
--- @param target BaseElement|string The target element or "parent"
--- @param offset? number Horizontal offset from center (default: 0)
--- @return VisualElement self
function VisualElement:centerHorizontal(target, offset)
    offset = offset or 0
    return self:setConstraint("centerX", target, "centerX", offset)
end

--- Centers the element vertically relative to the target with optional offset
--- @shortDescription Centers the element vertically relative to the target with optional offset
--- @param target BaseElement|string The target element or "parent"
--- @param offset? number Vertical offset from center (default: 0)
--- @return VisualElement self
function VisualElement:centerVertical(target, offset)
    offset = offset or 0
    return self:setConstraint("centerY", target, "centerY", offset)
end

--- Centers the element both horizontally and vertically relative to the target
--- @shortDescription Centers the element both horizontally and vertically relative to the target
--- @param target BaseElement|string The target element or "parent"
--- @return VisualElement self
function VisualElement:centerIn(target)
    return self:centerHorizontal(target):centerVertical(target)
end

--- Positions the element to the right of the target with optional gap
--- @shortDescription Positions the element to the right of the target with optional gap
--- @param target BaseElement|string The target element or "parent"
--- @param gap? number Gap between elements (default: 0)
--- @return VisualElement self
function VisualElement:rightOf(target, gap)
    gap = gap or 0
    return self:setConstraint("left", target, "right", gap)
end

--- Positions the element to the left of the target with optional gap
--- @shortDescription Positions the element to the left of the target with optional gap
--- @param target BaseElement|string The target element or "parent"
--- @param gap? number Gap between elements (default: 0)
--- @return VisualElement self
function VisualElement:leftOf(target, gap)
    gap = gap or 0
    return self:setConstraint("right", target, "left", -gap)
end

--- Positions the element below the target with optional gap
--- @shortDescription Positions the element below the target with optional gap
--- @param target BaseElement|string The target element or "parent"
--- @param gap? number Gap between elements (default: 0)
--- @return VisualElement self
function VisualElement:below(target, gap)
    gap = gap or 0
    return self:setConstraint("top", target, "bottom", gap)
end

--- Positions the element above the target with optional gap
--- @shortDescription Positions the element above the target with optional gap
--- @param target BaseElement|string The target element or "parent"
--- @param gap? number Gap between elements (default: 0)
--- @return VisualElement self
function VisualElement:above(target, gap)
    gap = gap or 0
    return self:setConstraint("bottom", target, "top", -gap)
end

--- Stretches the element to match the target's width with optional margin
--- @shortDescription Stretches the element to match the target's width with optional margin
--- @param target BaseElement|string The target element or "parent"
--- @param margin? number Margin on each side (default: 0)
--- @return VisualElement self
function VisualElement:stretchWidth(target, margin)
    margin = margin or 0
    return self
        :setConstraint("left", target, "left", margin)
        :setConstraint("right", target, "right", -margin)
end

--- Stretches the element to match the target's height with optional margin
--- @shortDescription Stretches the element to match the target's height with optional margin
--- @param target BaseElement|string The target element or "parent"
--- @param margin? number Margin on top and bottom (default: 0)
--- @return VisualElement self
function VisualElement:stretchHeight(target, margin)
    margin = margin or 0
    return self
        :setConstraint("top", target, "top", margin)
        :setConstraint("bottom", target, "bottom", -margin)
end

--- Stretches the element to match the target's width and height with optional margin
--- @shortDescription Stretches the element to match the target's width and height with optional margin
--- @param target BaseElement|string The target element or "parent"
--- @param margin? number Margin on all sides (default: 0)
--- @return VisualElement self
function VisualElement:stretch(target, margin)
    return self:stretchWidth(target, margin):stretchHeight(target, margin)
end

--- Sets the element's width as a percentage of the target's width
--- @shortDescription Sets the element's width as a percentage of the target's width
--- @param target BaseElement|string The target element or "parent"
--- @param percent number Percentage of target's width (0-100)
--- @return VisualElement self
function VisualElement:widthPercent(target, percent)
    return self:setConstraint("width", target, "width", percent / 100)
end

--- Sets the element's height as a percentage of the target's height
--- @shortDescription Sets the element's height as a percentage of the target's height
--- @param target BaseElement|string The target element or "parent"
--- @param percent number Percentage of target's height (0-100)
--- @return VisualElement self
function VisualElement:heightPercent(target, percent)
    return self:setConstraint("height", target, "height", percent / 100)
end

--- Matches the element's width to the target's width with optional offset
--- @shortDescription Matches the element's width to the target's width with optional offset
--- @param target BaseElement|string The target element or "parent"
--- @param offset? number Offset to add to target's width (default: 0)
--- @return VisualElement self
function VisualElement:matchWidth(target, offset)
    offset = offset or 0
    return self:setConstraint("width", target, "width", offset)
end

--- Matches the element's height to the target's height with optional offset
--- @shortDescription Matches the element's height to the target's height with optional offset
--- @param target BaseElement|string The target element or "parent"
--- @param offset? number Offset to add to target's height (default: 0)
--- @return VisualElement self
function VisualElement:matchHeight(target, offset)
    offset = offset or 0
    return self:setConstraint("height", target, "height", offset)
end

--- Stretches the element to fill its parent's width and height with optional margin
--- @shortDescription Stretches the element to fill its parent's width and height with optional margin
--- @param margin? number Margin on all sides (default: 0)
--- @return VisualElement self
function VisualElement:fillParent(margin)
    return self:stretch("parent", margin)
end

--- Stretches the element to fill its parent's width with optional margin
--- @shortDescription Stretches the element to fill its parent's width with optional margin
--- @param margin? number Margin on left and right (default: 0)
--- @return VisualElement self
function VisualElement:fillWidth(margin)
    return self:stretchWidth("parent", margin)
end

--- Stretches the element to fill its parent's height with optional margin
--- @shortDescription Stretches the element to fill its parent's height with optional margin
--- @param margin? number Margin on top and bottom (default: 0)
--- @return VisualElement self
function VisualElement:fillHeight(margin)
    return self:stretchHeight("parent", margin)
end

--- Centers the element within its parent both horizontally and vertically
--- @shortDescription Centers the element within its parent both horizontally and vertically
--- @return VisualElement self
function VisualElement:center()
    return self:centerIn("parent")
end

--- Aligns the element's right edge to its parent's right edge with optional gap
--- @shortDescription Aligns the element's right edge to its parent's right edge with optional gap
--- @param gap? number Gap from the edge (default: 0)
--- @return VisualElement self
function VisualElement:toRight(gap)
    return self:alignRight("parent", -(gap or 0))
end

--- Aligns the element's left edge to its parent's left edge with optional gap
--- @shortDescription Aligns the element's left edge to its parent's left edge with optional gap
--- @param gap? number Gap from the edge (default: 0)
--- @return VisualElement self
function VisualElement:toLeft(gap)
    return self:alignLeft("parent", gap or 0)
end

--- Aligns the element's top edge to its parent's top edge with optional gap
--- @shortDescription Aligns the element's top edge to its parent's top edge with optional gap
--- @param gap? number Gap from the edge (default: 0)
--- @return VisualElement self
function VisualElement:toTop(gap)
    return self:alignTop("parent", gap or 0)
end

--- Aligns the element's bottom edge to its parent's bottom edge with optional gap
--- @shortDescription Aligns the element's bottom edge to its parent's bottom edge with optional gap
--- @param gap? number Gap from the edge (default: 0)
--- @return VisualElement self
function VisualElement:toBottom(gap)
    return self:alignBottom("parent", -(gap or 0))
end

--- @shortDescription Multi-character drawing with colors
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param width number The width of the area to draw
--- @param height number The height of the area to draw
--- @param text string The text to draw
--- @param fg string The foreground color
--- @param bg string The background color
--- @protected
function VisualElement:multiBlit(x, y, width, height, text, fg, bg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:multiBlit(x, y, width, height, text, fg, bg)
end

--- @shortDescription Draws text with foreground color
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param text string The text char to draw
--- @param fg color The foreground color
--- @protected
function VisualElement:textFg(x, y, text, fg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:textFg(x, y, text, fg)
end

--- @shortDescription Draws text with background color
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param text string The text char to draw
--- @param bg color The background color
--- @protected
function VisualElement:textBg(x, y, text, bg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:textBg(x, y, text, bg)
end

function VisualElement:drawText(x, y, text)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:drawText(x, y, text)
end

function VisualElement:drawFg(x, y, fg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:drawFg(x, y, fg)
end

function VisualElement:drawBg(x, y, bg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:drawBg(x, y, bg)
end

--- @shortDescription Draws text with both colors
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param text string The text char to draw
--- @param fg string The foreground color
--- @param bg string The background color
--- @protected
function VisualElement:blit(x, y, text, fg, bg)
    local xElement, yElement = self:calculatePosition()
    x = x + xElement - 1
    y = y + yElement - 1
    self.parent:blit(x, y, text, fg, bg)
end

--- Checks if the specified coordinates are within the bounds of the element
--- @shortDescription Checks if point is within bounds
--- @param x number The x position to check
--- @param y number The y position to check
--- @return boolean isInBounds Whether the coordinates are within the bounds of the element
function VisualElement:isInBounds(x, y)
    local xPos, yPos = self.get("x"), self.get("y")
    local width, height = self.get("width"), self.get("height")
    if(self.get("ignoreOffset"))then
        if(self.parent)then
            x = x - self.parent.get("offsetX")
            y = y - self.parent.get("offsetY")
        end
    end

    return x >= xPos and x <= xPos + width - 1 and
           y >= yPos and y <= yPos + height - 1
end

--- @shortDescription Handles a mouse click event
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean clicked Whether the element was clicked
--- @protected
function VisualElement:mouse_click(button, x, y)
    if self:isInBounds(x, y) then
        self:setState("clicked")
        self:fireEvent("mouse_click", button, self:getRelativePosition(x, y))
        return true
    end
    return false
end

--- @shortDescription Handles a mouse up event
--- @param button number The button that was released
--- @param x number The x position of the release
--- @param y number The y position of the release
--- @return boolean release Whether the element was released on the element
--- @protected
function VisualElement:mouse_up(button, x, y)
    if self:isInBounds(x, y) then
        self:unsetState("clicked")
        self:unsetState("dragging")
        self:fireEvent("mouse_up", button, self:getRelativePosition(x, y))
        return true
    end
    return false
end

--- @shortDescription Handles a mouse release event
--- @param button number The button that was released
--- @param x number The x position of the release
--- @param y number The y position of the release
--- @protected
function VisualElement:mouse_release(button, x, y)
    self:fireEvent("mouse_release", button, self:getRelativePosition(x, y))
    self:unsetState("clicked")
    self:unsetState("dragging")
end

---@shortDescription Handles a mouse move event
---@param _ number unknown
---@param x number The x position of the mouse
---@param y number The y position of the mouse
---@return boolean hover Whether the mouse has moved over the element
--- @protected
function VisualElement:mouse_move(_, x, y)
    if(x==nil)or(y==nil)then return false end
    local hover = self.get("hover")
    if(self:isInBounds(x, y))then
        if(not hover)then
            self.set("hover", true)
            self:fireEvent("mouse_enter", self:getRelativePosition(x, y))
        end
        return true
    else
        if(hover)then
            self.set("hover", false)
            self:fireEvent("mouse_leave", self:getRelativePosition(x, y))
        end
    end
    return false
end

--- @shortDescription Handles a mouse scroll event
--- @param direction number The scroll direction
--- @param x number The x position of the scroll
--- @param y number The y position of the scroll
--- @return boolean scroll Whether the element was scrolled
--- @protected
function VisualElement:mouse_scroll(direction, x, y)
    if(self:isInBounds(x, y))then
        self:fireEvent("mouse_scroll", direction, self:getRelativePosition(x, y))
        return true
    end
    return false
end

--- @shortDescription Handles a mouse drag event
--- @param button number The button that was clicked while dragging
--- @param x number The x position of the drag
--- @param y number The y position of the drag
--- @return boolean drag Whether the element was dragged
--- @protected
function VisualElement:mouse_drag(button, x, y)
    if(self:hasState("clicked"))then
        self:fireEvent("mouse_drag", button, self:getRelativePosition(x, y))
        return true
    end
    return false
end

--- Sets or removes focus from this element
--- @shortDescription Sets focus state
--- @param focused boolean Whether to focus or blur
--- @param internal? boolean Internal flag to prevent parent notification
--- @return VisualElement self
function VisualElement:setFocused(focused, internal)
    local currentlyFocused = self:hasState("focused")

    if focused == currentlyFocused then
        return self
    end

    if focused then
        self:setState("focused")
        self:focus()

        if not internal and self.parent then
            self.parent:setFocusedChild(self)
        end
    else
        self:unsetState("focused")
        self:blur()

        if not internal and self.parent then
            self.parent:setFocusedChild(nil)
        end
    end

    return self
end

--- Gets whether this element is focused
--- @shortDescription Checks if element is focused
--- @return boolean isFocused
function VisualElement:isFocused()
    return self:hasState("focused")
end

--- @shortDescription Handles a focus event
--- @protected
function VisualElement:focus()
    self:fireEvent("focus")
end

--- @shortDescription Handles a blur event
--- @protected
function VisualElement:blur()
    self:fireEvent("blur")
    -- Attempt to clear cursor; signature may expect (x,y,blink,fg,bg)
    pcall(function() self:setCursor(1,1,false, self.get and self.getResolved("foreground")) end)
end

--- Gets whether this element is focused
--- @shortDescription Checks if element is focused
--- @return boolean isFocused
function VisualElement:isFocused()
    return self:hasState("focused")
end

--- Adds or updates a drawable character border around the element. The border will automatically adapt to size/background changes because the command reads current properties each render.
--- @param colorOrOptions any Border color or options table
--- @param sideOptions? table Side options table (if color is provided as first argument)
--- @return VisualElement self
function VisualElement:addBorder(colorOrOptions, sideOptions)
    local col = nil
    local spec = nil
    if type(colorOrOptions) == "table" and (colorOrOptions.color or colorOrOptions.top ~= nil or colorOrOptions.left ~= nil) then
        col = colorOrOptions.color
        spec = colorOrOptions
    else
        col = colorOrOptions
        spec = sideOptions
    end
    if spec then
        if spec.top ~= nil then self.set("borderTop", spec.top) end
        if spec.bottom ~= nil then self.set("borderBottom", spec.bottom) end
        if spec.left ~= nil then self.set("borderLeft", spec.left) end
        if spec.right ~= nil then self.set("borderRight", spec.right) end
    else
        -- default: enable all sides
        self.set("borderTop", true)
        self.set("borderBottom", true)
        self.set("borderLeft", true)
        self.set("borderRight", true)
    end
    if col then self.set("borderColor", col) end
    return self
end

--- Removes the previously added border (if any)
--- @return VisualElement self
function VisualElement:removeBorder()
    self.set("borderTop", false)
    self.set("borderBottom", false)
    self.set("borderLeft", false)
    self.set("borderRight", false)
    return self
end

--- @shortDescription Handles a key event
--- @param key number The key that was pressed
--- @protected
function VisualElement:key(key, held)
    if(self:hasState("focused"))then
        self:fireEvent("key", key, held)
    end
end

--- @shortDescription Handles a key up event
--- @param key number The key that was released
--- @protected
function VisualElement:key_up(key)
    if(self:hasState("focused"))then
        self:fireEvent("key_up", key)
    end
end

--- @shortDescription Handles a character event
--- @param char string The character that was pressed
--- @protected
function VisualElement:char(char)
    if(self:hasState("focused"))then
        self:fireEvent("char", char)
    end
end

--- Calculates the position of the element relative to its parent
--- @shortDescription Calculates the position of the element
--- @return number x The x position
--- @return number y The y position
function VisualElement:calculatePosition()
    self:resolveAllConstraints()
    local x, y = self.get("x"), self.get("y")
    if not self.get("ignoreOffset") then
        if self.parent ~= nil then
            local xO, yO = self.parent.get("offsetX"), self.parent.get("offsetY")
            x = x - xO
            y = y - yO
        end
    end
    return x, y
end

--- Returns the absolute position of the element or the given coordinates.
--- @shortDescription Returns the absolute position of the element
---@param x? number x position
---@param y? number y position
---@return number x The absolute x position
---@return number y The absolute y position
function VisualElement:getAbsolutePosition(x, y)
    local xPos, yPos = self.get("x"), self.get("y")
    if(x ~= nil) then
        xPos = xPos + x - 1
    end
    if(y ~= nil) then
        yPos = yPos + y - 1
    end

    local parent = self.parent
    while parent do
        local px, py = parent.get("x"), parent.get("y")
        xPos = xPos + px - 1
        yPos = yPos + py - 1
        parent = parent.parent
    end

    return xPos, yPos
end

--- Returns the relative position of the element or the given coordinates.
--- @shortDescription Returns the relative position of the element
--- @param x? number x position
--- @param y? number y position
--- @return number x The relative x position
--- @return number y The relative y position
function VisualElement:getRelativePosition(x, y)
    if (x == nil) or (y == nil) then
        x, y = self.get("x"), self.get("y")
    end

    local parentX, parentY = 1, 1
    if self.parent then
        parentX, parentY = self.parent:getRelativePosition()
    end

    local elementX, elementY = self.get("x"), self.get("y")
    return x - (elementX - 1) - (parentX - 1),
           y - (elementY - 1) - (parentY - 1)
end

--- @shortDescription Sets the cursor position
--- @param x number The x position of the cursor
--- @param y number The y position of the cursor
--- @param blink boolean Whether the cursor should blink
--- @param color number The color of the cursor
--- @return VisualElement self The VisualElement instance
--- @protected
function VisualElement:setCursor(x, y, blink, color)
    if self.parent then
        local xPos, yPos = self:calculatePosition()
        if(x + xPos - 1<1)or(x + xPos - 1>self.parent.get("width"))or
        (y + yPos - 1<1)or(y + yPos - 1>self.parent.get("height"))then
            return self.parent:setCursor(x + xPos - 1, y + yPos - 1, false)
        end
        return self.parent:setCursor(x + xPos - 1, y + yPos - 1, blink, color)
    end
    return self
end

--- This function is used to prioritize the element by moving it to the top of its parent's children. It removes the element from its parent and adds it back, effectively changing its order.
--- @shortDescription Prioritizes the element by moving it to the top of its parent's children
--- @return VisualElement self The VisualElement instance
function VisualElement:prioritize()
    if(self.parent)then
        local parent = self.parent
        parent:removeChild(self)
        parent:addChild(self)
        self:updateRender()
    end
    return self
end

--- @shortDescription Renders the element
--- @protected
function VisualElement:render()
    if(not self.getResolved("backgroundEnabled"))then return end
    local width, height = self.get("width"), self.get("height")
    local fgHex = tHex[self.getResolved("foreground")]
    local bgHex = tHex[self.getResolved("background")]
    local bTop, bBottom, bLeft, bRight =
        self.getResolved("borderTop"),
        self.getResolved("borderBottom"),
        self.getResolved("borderLeft"),
        self.getResolved("borderRight")
    self:multiBlit(1, 1, width, height, " ", fgHex, bgHex)
    if (bTop or bBottom or bLeft or bRight) then
        local bColor = self.getResolved("borderColor") or self.getResolved("foreground")
        local bHex = tHex[bColor] or fgHex
        if bTop then
            self:textFg(1,1,("\131"):rep(width), bColor)
        end
        if bBottom then
            self:multiBlit(1,height,width,1,"\143", bgHex, bHex)
        end
        if bLeft then
            self:multiBlit(1,1,1,height,"\149", bHex, bgHex)
        end
        if bRight then
            self:multiBlit(width,1,1,height,"\149", bgHex, bHex)
        end
        -- Corners
        if bTop and bLeft then self:blit(1,1,"\151", bHex, bgHex) end
        if bTop and bRight then self:blit(width,1,"\148", bgHex, bHex) end
        if bBottom and bLeft then self:blit(1,height,"\138", bgHex, bHex) end
        if bBottom and bRight then self:blit(width,height,"\133", bgHex, bHex) end
    end
end

--- @shortDescription Post-rendering function for the element
--- @protected
function VisualElement:postRender()
end

function VisualElement:destroy()
    self:_removeAllConstraintObservers()
    self.set("visible", false)
    BaseElement.destroy(self)
end

return VisualElement
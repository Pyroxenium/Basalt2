-- Responsive layout primitives and shared geometry helpers.

local require = ...
local state = require("core/state")

---@alias LayoutValueKind "auto"|"fill"|"percent"
---@alias LayoutAxis "width"|"height"
---@alias LayoutSpecification number|string|LayoutValue

local layout = {}

---@class LayoutValue
---@field kind LayoutValueKind Layout behavior
---@field value? number Fill weight or parent-size fraction
local Token = {}
Token.__index = Token
Token.__basaltLayoutValue = true

---@param kind LayoutValueKind Layout behavior
---@param value? number Fill weight or parent-size fraction
---@return LayoutValue value
local function token(kind, value)
    return setmetatable({ kind = kind, value = value }, Token)
end

--- Creates an intrinsic-size layout value.
---@return LayoutValue value
function layout.auto()
    return token("auto")
end

--- Creates a weighted fill layout value.
---@param weight? number Fill weight, default 1
---@return LayoutValue value
function layout.fill(weight)
    weight = weight or 1
    if type(weight) ~= "number" or weight <= 0 then
        error("Basalt layout: fill weight must be greater than zero", 2)
    end
    return token("fill", weight)
end

--- Creates a fractional parent-size layout value (1 = 100%).
---@param amount number Fraction of available size
---@return LayoutValue value
function layout.percent(amount)
    if type(amount) ~= "number" or amount < 0 then
        error("Basalt layout: percent must be a non-negative number", 2)
    end
    return token("percent", amount)
end

--- Tests whether a value is a Basalt layout token.
---@param value any Candidate value
---@return boolean isLayoutValue
function layout.is(value)
    local mt = type(value) == "table" and getmetatable(value)
    return mt and mt.__basaltLayoutValue == true or false
end

--- Returns an authored/resolved property before token-to-number conversion.
---@param el Element Element
---@param propName string Property name
---@return any specification
function layout.spec(el, propName)
    local c = rawget(el, "_class")
    if c and c.__getPropertySpec then
        local found, value = c.__getPropertySpec(el, propName)
        if found then return value end
    end
    return el:raw(propName)
end

---@param value number Value to round
---@return integer rounded
local function round(value)
    return math.floor(value + 0.5)
end

---@param value number Value to constrain
---@param minimum? number Minimum value
---@param maximum? number Maximum value
---@return integer constrained
local function clamp(value, minimum, maximum)
    if minimum and value < minimum then value = minimum end
    if maximum and value > maximum then value = maximum end
    return math.max(0, round(value))
end

--- Applies min/max constraints and integer rounding to an axis size.
---@param el Element Element
---@param axis LayoutAxis Axis
---@param value number Proposed value
---@return integer size
function layout.constrain(el, axis, value)
    local minName = axis == "width" and "minWidth" or "minHeight"
    local maxName = axis == "width" and "maxWidth" or "maxHeight"
    local minimum, maximum = el[minName], el[maxName]
    if minimum == false then minimum = nil end
    if maximum == false then maximum = nil end
    return clamp(value, minimum, maximum)
end

--- Intrinsic size for basalt.auto().
---@param el Element Element to measure
---@param availableWidth? number Available width
---@param availableHeight? number Available height
---@return number width The measured width
---@return number height The measured height
function layout.measure(el, availableWidth, availableHeight)
    if el.measure then return el:measure(availableWidth, availableHeight) end
    return 1, 1
end

--- Resolves one authored size specification to terminal cells.
---@param el Element Element being measured
---@param axis LayoutAxis Axis to resolve
---@param spec LayoutSpecification Numeric size or layout token
---@param availableWidth number Available width
---@param availableHeight number Available height
---@return integer size
function layout.resolveSize(el, axis, spec, availableWidth, availableHeight)
    local available = axis == "width" and availableWidth or availableHeight
    local measuredW, measuredH
    local value
    if layout.is(spec) then
        if spec.kind == "percent" then
            value = available * spec.value
        elseif spec.kind == "fill" then
            value = available
        else
            measuredW, measuredH = layout.measure(el, availableWidth, availableHeight)
            value = axis == "width" and measuredW or measuredH
        end
    else
        value = tonumber(spec) or 1
    end
    return layout.constrain(el, axis, value)
end

--- Resolves a token read before a formal layout pass (useful for inspection).
---@param value LayoutValue Layout token
---@param el Element Owning element
---@param propName LayoutAxis Property being resolved
---@return integer value
function layout.resolveToken(value, el, propName)
    local parent = rawget(el, "parent")
    local availableWidth = parent and parent.width or 1
    local availableHeight = parent and parent.height or 1
    if value.kind == "fill" and parent then
        if propName == "width" then
            availableWidth = math.max(0, availableWidth - (tonumber(layout.spec(el, "x")) or 1) + 1)
        elseif propName == "height" then
            availableHeight = math.max(0, availableHeight - (tonumber(layout.spec(el, "y")) or 1) + 1)
        end
    end
    return layout.resolveSize(el, propName, value, availableWidth, availableHeight)
end

--- Resolves auto/fill/percent for a child of an ordinary absolute container.
---@param parent Container Parent container
---@param child Element Child element
function layout.resolveFreeChild(parent, child)
    local xSpec, ySpec = layout.spec(child, "x"), layout.spec(child, "y")
    local wSpec, hSpec = layout.spec(child, "width"), layout.spec(child, "height")
    local hasToken = layout.is(xSpec) or layout.is(ySpec)
        or layout.is(wSpec) or layout.is(hSpec)
    if not hasToken then
        local old = rawget(child, "_layoutBox")
        rawset(child, "_layoutBox", nil)
        if old and rawget(child, "_children") then
            rawset(child, "_layoutDirty", true)
            rawset(child, "_viewportDirty", true)
        end
        return
    end

    local pw, ph = parent.width, parent.height
    local x = tonumber(xSpec) or 1
    local y = tonumber(ySpec) or 1
    local aw, ah = math.max(0, pw - x + 1), math.max(0, ph - y + 1)
    local w = layout.resolveSize(child, "width", wSpec, aw, ah)
    local h = layout.resolveSize(child, "height", hSpec, aw, ah)
    local old = rawget(child, "_layoutBox")
    rawset(child, "_layoutBox", { x = round(x), y = round(y), width = w, height = h })
    if rawget(child, "_children") and (not old
        or old.width ~= w or old.height ~= h) then
        rawset(child, "_layoutDirty", true)
        rawset(child, "_viewportDirty", true)
    end
end

--- Resolves layout tokens for every child of an absolute container.
---@param parent Container Parent container
function layout.resolveFreeChildren(parent)
    local children = parent:getChildren()
    for i = 1, #children do layout.resolveFreeChild(parent, children[i]) end
end

--- Stores a resolved layout box and invalidates changed nested layouts.
---@param el Element Element to update
---@param x number Resolved x position
---@param y number Resolved y position
---@param width number Resolved width
---@param height number Resolved height
function layout.setBox(el, x, y, width, height)
    local box = {
        x = round(x), y = round(y),
        width = math.max(0, round(width)),
        height = math.max(0, round(height)),
    }
    local old = rawget(el, "_layoutBox")
    rawset(el, "_layoutBox", box)
    if rawget(el, "_children") and (not old
        or old.width ~= box.width or old.height ~= box.height) then
        rawset(el, "_layoutDirty", true)
        rawset(el, "_viewportDirty", true)
    end
end

return layout

-- Responsive layout primitives and shared geometry helpers.

local require = ...
local state = require("core/state")

local layout = {}
local Token = {}
Token.__index = Token
Token.__basaltLayoutValue = true

local function token(kind, value)
    return setmetatable({ kind = kind, value = value }, Token)
end

function layout.auto()
    return token("auto")
end

function layout.fill(weight)
    weight = weight or 1
    if type(weight) ~= "number" or weight <= 0 then
        error("Basalt layout: fill weight must be greater than zero", 2)
    end
    return token("fill", weight)
end

function layout.percent(amount)
    if type(amount) ~= "number" or amount < 0 then
        error("Basalt layout: percent must be a non-negative number", 2)
    end
    return token("percent", amount)
end

function layout.is(value)
    local mt = type(value) == "table" and getmetatable(value)
    return mt and mt.__basaltLayoutValue == true or false
end

--- Returns the authored property value, resolving signals/functions but not
--- layout tokens. Layout containers need the token kind and weight intact.
function layout.spec(el, propName)
    local c = rawget(el, "_class")
    if c and c.__getPropertySpec then
        local found, value = c.__getPropertySpec(el, propName)
        if found then return value end
    end
    return el:raw(propName)
end

local function round(value)
    return math.floor(value + 0.5)
end

local function clamp(value, minimum, maximum)
    if minimum and value < minimum then value = minimum end
    if maximum and value > maximum then value = maximum end
    return math.max(0, round(value))
end

function layout.constrain(el, axis, value)
    local minName = axis == "width" and "minWidth" or "minHeight"
    local maxName = axis == "width" and "maxWidth" or "maxHeight"
    local minimum, maximum = el[minName], el[maxName]
    if minimum == false then minimum = nil end
    if maximum == false then maximum = nil end
    return clamp(value, minimum, maximum)
end

function layout.measure(el, availableWidth, availableHeight)
    if el.measure then return el:measure(availableWidth, availableHeight) end
    return 1, 1
end

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

function layout.resolveFreeChildren(parent)
    local children = parent:getChildren()
    for i = 1, #children do layout.resolveFreeChild(parent, children[i]) end
end

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

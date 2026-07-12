-- Reactive expressions: "{parent.width - 12}" compiles to a dynamic value.
--
-- The string between the braces is a plain Lua expression. It runs in a
-- sandboxed environment where identifiers resolve lazily on every read:
--   self    -> the element the expression is set on
--   parent  -> its current parent
--   <name>  -> the element with that .name, searched from the root
--   colors, math, rgb, tostring, tonumber, clamp, round, floor, ceil,
--   abs, min, max
-- Because identifier lookup happens at evaluation time (not compile time),
-- expressions can be set before the element is added to a parent.
--
-- No observers are needed: the compiled function is stored as a dynamic
-- value, so it is re-evaluated on every read / redraw automatically.

local require = ...
local palette = require("core/palette")

local reactive = {}

local helpers = {
    colors = colors,
    math = math,
    rgb = palette.rgb,
    tostring = tostring,
    tonumber = tonumber,
    clamp = function(v, lo, hi) return math.min(math.max(v, lo), hi) end,
    round = function(v) return math.floor(v + 0.5) end,
    floor = math.floor,
    ceil = math.ceil,
    abs = math.abs,
    min = math.min,
    max = math.max,
}

--- Compiles "{expr}" for an element; returns a dynamic-value function.
function reactive.compile(str, element)
    local expr = str:sub(2, -2)

    local env = setmetatable({}, {
        __index = function(_, key)
            if key == "self" then return element end
            if key == "parent" then return rawget(element, "parent") end
            local h = helpers[key]
            if h ~= nil then return h end
            local root = element:getRoot()
            if root.find then return root:find(key) end
            return nil
        end,
    })

    local fn, err = load("return " .. expr, "reactive" .. str, "t", env)
    if not fn then
        error("Basalt: invalid reactive expression " .. str
            .. ": " .. tostring(err), 3)
    end
    return fn
end

return reactive

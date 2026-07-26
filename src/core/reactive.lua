-- Reactive expressions: "{parent.width - 12}" compiles to a dynamic value.

local require = ...
local palette = require("core/palette")

---@alias ReactiveResolver fun(element?: Element): any

---@class ReactiveHelpers
---@field colors table CC color constants
---@field math table Lua math library
---@field rgb fun(r: number|string, g?: number, b?: number): number RGB color helper
---@field tostring fun(value: any): string
---@field tonumber fun(value: any, base?: integer): number|nil
---@field clamp fun(value: number, minimum: number, maximum: number): number
---@field round fun(value: number): integer
---@field floor fun(value: number): integer
---@field ceil fun(value: number): integer
---@field abs fun(value: number): number
---@field min fun(value: number, ...: number): number
---@field max fun(value: number, ...: number): number

---@class ReactiveEnvironment : ReactiveHelpers
---@field self Element Expression owner
---@field parent? Container Current parent
---@field [string] any Named elements are resolved dynamically

local reactive = {}

---@type ReactiveHelpers
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

--- Compiles a {property/path/expression} string into a dynamic property value.
---@param str string Braced reactive expression
---@param element Element Expression owner
---@return ReactiveResolver resolver
function reactive.compile(str, element)
    local expr = str:sub(2, -2)

    ---@type ReactiveEnvironment
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

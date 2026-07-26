-- Animation module: tweens numeric properties over time.
--
--   local anim = basalt.use("animation")
--   anim.to(label, { x = 20, y = 5 }, 0.5, "easeOut", function(el) ... end)
--   label:animate({ x = 20 }, 0.5)          -- sugar added to Element
--
-- Standalone module: drives itself through a basalt.schedule coroutine
-- (sleep-based, ~20 fps) and touches no core files.

local require = ...
local basalt = require("main")
local Element = require("core/element")

local animation = {}

local easings = {
    linear = function(t) return t end,
    easeIn = function(t) return t * t end,
    easeOut = function(t) return t * (2 - t) end,
    easeInOut = function(t)
        if t < 0.5 then return 2 * t * t end
        return -1 + (4 - 2 * t) * t
    end,
}
animation.easings = easings

local active = {}
local loopRunning = false

local function startLoop()
    if loopRunning then return end
    loopRunning = true
    basalt.schedule(function()
        while #active > 0 do
            sleep(0.05)
            local now = os.clock()
            for i = #active, 1, -1 do
                local a = active[i]
                local t = (now - a.start) / a.duration
                if t >= 1 then
                    for prop, target in pairs(a.to) do
                        a.el[prop] = target
                    end
                    table.remove(active, i)
                    if a.onDone then a.onDone(a.el) end
                else
                    local e = a.easing(t)
                    for prop, target in pairs(a.to) do
                        local from = a.from[prop]
                        a.el[prop] = math.floor(from + (target - from) * e + 0.5)
                    end
                end
            end
        end
        loopRunning = false
    end)
end

--- Tweens the given numeric properties to their target values.
---@param el table The element to animate
---@param props table Target values, e.g. { x = 20, y = 5 }
---@param duration number|nil Seconds, default 0.3
---@param easing string|nil "linear", "easeIn", "easeOut" or "easeInOut"
---@param onDone function|nil Called with the element after completion
---@return table handle Handle with :cancel()
function animation.to(el, props, duration, easing, onDone)
    local a = {
        el = el,
        to = props,
        from = {},
        start = os.clock(),
        duration = duration or 0.3,
        easing = easings[easing or "easeInOut"]
            or error("Basalt animation: unknown easing '" .. tostring(easing) .. "'", 2),
        onDone = onDone,
    }
    for prop in pairs(props) do
        local v = el[prop]
        if type(v) ~= "number" then
            error("Basalt animation: property '" .. prop .. "' is not a number", 2)
        end
        a.from[prop] = v
    end
    active[#active + 1] = a
    startLoop()

    return {
        cancel = function()
            for i = 1, #active do
                if active[i] == a then
                    table.remove(active, i)
                    break
                end
            end
        end,
    }
end

--- Sugar on Element: el:animate({x = 20}, 0.5, "easeOut", onDone)
--- Fluent element shortcut for animation.to().
---@param props table Target property values
---@param duration number|nil Seconds, default 0.3
---@param easing string|nil Easing name
---@param onDone function|nil Completion callback
---@return table handle Cancellable animation handle
function Element:animate(props, duration, easing, onDone)
    return animation.to(self, props, duration, easing, onDone)
end

return animation

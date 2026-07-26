-- Basalt entry point.
-- Uses its own tiny module loader instead of touching package.path
local args = { ... }
local dir = fs.getDir(args[2] or "basalt")

local modules = {}
local function load(name)
    local cached = modules[name]
    if cached ~= nil then return cached end
    local path = fs.combine(dir, name .. ".lua")
    local fn, err = loadfile(path, nil, _ENV)
    if not fn then
        error("Basalt: failed to load module '" .. name .. "': " .. tostring(err), 0)
    end
    local result = fn(load, dir)
    modules[name] = result == nil and true or result
    return modules[name]
end

return load("main")

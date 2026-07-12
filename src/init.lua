-- Basalt 2.5 entry point.
-- Uses its own tiny module loader instead of touching package.path, so it
-- never collides with other libraries (or another Basalt version) and the
-- whole project can later be bundled into a single file trivially.
local args = { ... }
local dir = fs.getDir(args[2] or "Basalt3/src")

local modules = {}
local function load(name)
    local cached = modules[name]
    if cached ~= nil then return cached end
    local path = fs.combine(dir, name .. ".lua")
    local fn, err = loadfile(path, nil, _ENV)
    if not fn then
        error("Basalt 2.5: failed to load module '" .. name .. "': " .. tostring(err), 0)
    end
    local result = fn(load, dir)
    modules[name] = result == nil and true or result
    return modules[name]
end

return load("main")

-- Reactive application state for Basalt3.
--
-- Signals are ordinary values outside the UI. When read through an element
-- property they remember that element weakly; changing the signal then marks
-- every dependent UI tree dirty. Computed values collect these dependencies
-- implicitly while their function runs.

local state = {}
local unpack = table.unpack or unpack
local currentWatcher = nil

local Signal = {}
Signal.__index = Signal
Signal.__basaltStateValue = true

local Computed = {}
Computed.__index = Computed
Computed.__basaltStateValue = true

local function registerWatcher(signal, watcher)
    watcher = watcher or currentWatcher
    if watcher and watcher.markDirty then
        signal._watchers[watcher] = true
        local dependencies = rawget(watcher, "_stateDependencies")
        if not dependencies then
            dependencies = setmetatable({}, { __mode = "k" })
            rawset(watcher, "_stateDependencies", dependencies)
        end
        dependencies[signal] = true
    end
end

--- Removes dependencies collected during the previous render pass.
function state.clearWatcher(watcher)
    local dependencies = rawget(watcher, "_stateDependencies")
    if not dependencies then return end
    for signal in pairs(dependencies) do
        signal._watchers[watcher] = nil
        dependencies[signal] = nil
    end
end

--- Runs fn while signal reads register watcher as a dependency.
function state.withWatcher(watcher, fn, ...)
    local previous = currentWatcher
    currentWatcher = watcher or previous
    local result = table.pack(pcall(fn, ...))
    currentWatcher = previous
    if not result[1] then error(result[2], 0) end
    return unpack(result, 2, result.n)
end

function state.is(value)
    local mt = type(value) == "table" and getmetatable(value)
    return mt and mt.__basaltStateValue == true or false
end

function state.read(value, watcher)
    return value:get(watcher)
end

function state.isWritable(value)
    return getmetatable(value) == Signal
end

function Signal:get(watcher)
    registerWatcher(self, watcher)
    return self._value
end

function Signal:set(value)
    local old = self._value
    if old == value then return self end
    self._value = value

    for watcher in pairs(self._watchers) do
        if watcher.markLayoutDirty then
            watcher:markLayoutDirty()
        else
            watcher:markDirty()
        end
    end
    for listener in pairs(self._listeners) do
        listener(value, old)
    end
    return self
end

function Signal:update(fn)
    if type(fn) ~= "function" then
        error("Basalt state: update expects a function", 2)
    end
    return self:set(fn(self._value))
end

--- Notifies dependents after mutating a table-valued state in place.
function Signal:touch()
    for watcher in pairs(self._watchers) do
        if watcher.markLayoutDirty then
            watcher:markLayoutDirty()
        else
            watcher:markDirty()
        end
    end
    for listener in pairs(self._listeners) do
        listener(self._value, self._value)
    end
    return self
end

--- Subscribes to writes. Returns an unsubscribe function.
function Signal:subscribe(fn, immediate)
    if type(fn) ~= "function" then
        error("Basalt state: subscribe expects a function", 2)
    end
    self._listeners[fn] = true
    if immediate then fn(self._value, nil) end
    local active = true
    return function()
        if active then
            self._listeners[fn] = nil
            active = false
        end
    end
end

function Signal:map(fn)
    if type(fn) ~= "function" then
        error("Basalt state: map expects a function", 2)
    end
    local source = self
    return state.computed(function()
        return fn(source:get())
    end)
end

function Signal:__tostring()
    return tostring(self._value)
end

function Computed:get(watcher)
    return state.withWatcher(watcher, self._compute)
end

function Computed:map(fn)
    if type(fn) ~= "function" then
        error("Basalt state: map expects a function", 2)
    end
    local source = self
    return state.computed(function()
        return fn(source:get())
    end)
end

function Computed:__tostring()
    return tostring(self:get())
end

--- Creates a writable signal.
function state.create(initialValue)
    return setmetatable({
        _value = initialValue,
        _watchers = setmetatable({}, { __mode = "k" }),
        _listeners = {},
    }, Signal)
end

--- Creates a lazily evaluated, read-only value with implicit dependencies.
function state.computed(fn)
    if type(fn) ~= "function" then
        error("Basalt computed: expected a function", 2)
    end
    return setmetatable({ _compute = fn }, Computed)
end

return state

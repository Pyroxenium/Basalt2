-- Reactive application state for Basalt 2.
--
-- Signals are ordinary values outside the UI. When read through an element
-- property they remember that element weakly; changing the signal then marks
-- every dependent UI tree dirty. Computed values collect these dependencies
-- implicitly while their function runs.

local state = {}
local unpack = table.unpack or unpack
---@type Element?
local currentWatcher = nil

---@alias StateListener<T> fun(value: T, oldValue: T?)
---@alias StateUnsubscribe fun()

---@class Signal<T>
---@field private _value T Current value
---@field package _watchers table<Element, boolean> Weak set of dependent elements
---@field private _listeners table<StateListener<T>, boolean> Active write listeners
local Signal = {}
Signal.__index = Signal
Signal.__basaltStateValue = true

---@class Computed<T>
---@field private _compute fun(): T Lazy computation
local Computed = {}
Computed.__index = Computed
Computed.__basaltStateValue = true

---@param signal Signal<any> Signal being read
---@param watcher? Element Explicit watcher, or the current watcher when omitted
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
---@param watcher Element Watcher to detach
function state.clearWatcher(watcher)
    local dependencies = rawget(watcher, "_stateDependencies")
    if not dependencies then return end
    for signal in pairs(dependencies) do
        signal._watchers[watcher] = nil
        dependencies[signal] = nil
    end
end

--- Runs fn while signal reads register watcher as a dependency.
---@param watcher? Element Watcher collecting dependencies
---@param fn fun(...: any): ...any Function to execute
---@param ... any Arguments forwarded to fn
---@return ...any Values returned by fn
function state.withWatcher(watcher, fn, ...)
    local previous = currentWatcher
    currentWatcher = watcher or previous
    local result = table.pack(pcall(fn, ...))
    currentWatcher = previous
    if not result[1] then error(result[2], 0) end
    return unpack(result, 2, result.n)
end

--- Tests whether a value is a State or Computed value.
---@param value any Candidate value
---@return boolean isState
function state.is(value)
    local mt = type(value) == "table" and getmetatable(value)
    return mt and mt.__basaltStateValue == true or false
end

--- Reads a State or Computed value with optional dependency tracking.
---@generic T
---@param value Signal<T>|Computed<T> State-like value
---@param watcher? Element Dependent element
---@return T value
function state.read(value, watcher)
    --- LuaLS 3.18 treats the identical optional Element parameters on the
    --- Signal and Computed branches as distinct while resolving this union.
    ---@diagnostic disable-next-line: param-type-mismatch
    return value:get(watcher)
end

--- Tests whether a state-like value supports set/update operations.
---@param value any Candidate value
---@return boolean writable
function state.isWritable(value)
    return getmetatable(value) == Signal
end

--- Returns the current value and optionally registers a UI watcher.
---@param watcher? Element Dependent element
---@return T value
function Signal:get(watcher)
    registerWatcher(self, watcher)
    return self._value
end

--- Replaces the state value and invalidates dependents.
---@param value T New value
---@return self
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

--- Replaces the value with fn(currentValue).
---@param fn fun(value: T): T Update function
---@return self
function Signal:update(fn)
    if type(fn) ~= "function" then
        error("Basalt state: update expects a function", 2)
    end
    return self:set(fn(self._value))
end

--- Notifies dependents after mutating a table value in place.
---@return self
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

--- Subscribes to writes and returns an unsubscribe closure.
---@param fn StateListener<T> Listener receiving value and oldValue
---@param immediate? boolean Call immediately with the current value
---@return StateUnsubscribe unsubscribe
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

--- Creates a computed value derived from this state.
---@generic U
---@param fn fun(value: T): U Mapping function
---@return Computed<U> computed
function Signal:map(fn)
    if type(fn) ~= "function" then
        error("Basalt state: map expects a function", 2)
    end
    local source = self
    return state.computed(function()
        return fn(source:get())
    end)
end

---@return string value
function Signal:__tostring()
    return tostring(self._value)
end

--- Evaluates and returns the computed value.
---@param watcher? Element Dependent element
---@return T value
function Computed:get(watcher)
    return state.withWatcher(watcher, self._compute)
end

--- Creates another computed value from this one.
---@generic U
---@param fn fun(value: T): U Mapping function
---@return Computed<U> computed
function Computed:map(fn)
    if type(fn) ~= "function" then
        error("Basalt state: map expects a function", 2)
    end
    local source = self
    return state.computed(function()
        return fn(source:get())
    end)
end

---@return string value
function Computed:__tostring()
    return tostring(self:get())
end

--- Creates a writable reactive state.
---@generic T
---@param initialValue T Initial value
---@return Signal<T> state
function state.create(initialValue)
    return setmetatable({
        _value = initialValue,
        _watchers = setmetatable({}, { __mode = "k" }),
        _listeners = {},
    }, Signal)
end

--- Creates a lazily evaluated computed value.
---@generic T
---@param fn fun(): T Computation function
---@return Computed<T> computed
function state.computed(fn)
    if type(fn) ~= "function" then
        error("Basalt computed: expected a function", 2)
    end
    return setmetatable({ _compute = fn }, Computed)
end

return state

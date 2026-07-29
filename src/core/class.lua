-- Minimal class & property system for Basalt.

local require = ...
local reactive = require("core/reactive")
local state = require("core/state")
local layout = require("core/layout")

--- A minimal class system with property support.
---@class Class
local class = {}
local unpack = table.unpack or unpack

local function syncMirroredState(t, prop, value)
    if prop.state and t.setState then
        local active = prop.stateWhen and prop.stateWhen(value, t) or not not value
        t:setState(prop.state, active)
    end
end

local function resolveSpecValue(t, prop, value)
    if state.is(value) then
        value = state.read(value, t)
    elseif type(value) == "function" and not prop.rawFunction then
        value = state.withWatcher(t, value, t)
    end
    syncMirroredState(t, prop, value)
    return value
end

local function capitalize(s)
    return s:sub(1, 1):upper() .. s:sub(2)
end

--- Creates a new Basalt class deriving from an optional parent class.
---@param name string Class name
---@param parent? table Parent class
---@return table class
function class.create(name, parent)
    local c = {}
    c.__name = name
    c.__parent = parent
    c.__props = setmetatable({}, parent and { __index = parent.__props } or nil)
    c.__defaults = setmetatable({}, parent and { __index = parent.__defaults } or nil)
    c.__stateStyles = {}
    c.__pmeta = { __index = c.__defaults }

    if parent then setmetatable(c, { __index = parent }) end

    c.__getPropertySpec = function(t, k)
        local prop = c.__props[k]
        if not prop then return false end
        local resolver = c.__stateResolver
        if prop.styleable and resolver then
            local found, stateValue = resolver(t, k, c)
            if found then
                return true, resolveSpecValue(t, prop, stateValue), prop
            end
        end
        local value = rawget(t, "_p")[k]
        if value ~= nil then
            return true, resolveSpecValue(t, prop, value), prop
        end
        return false
    end

    c.__meta = {
        __index = function(t, k)
            local box = rawget(t, "_layoutBox")
            if box and box[k] ~= nil then return box[k] end
            local found, value = c.__getPropertySpec(t, k)
            if found then
                if layout.is(value) then
                    ---@cast value LayoutValue
                    return layout.resolveToken(value, t, k)
                end
                return value
            end
            return c[k]
        end,
        __newindex = function(t, k, v)
            local prop = c.__props[k]
            if prop then
                if type(v) == "string" and not prop.rawString
                    and v:sub(1, 1) == "{" and v:sub(-1) == "}" then
                    v = reactive.compile(v, t)
                end
                local p = rawget(t, "_p")
                local old = p[k]
                if old ~= v then
                    p[k] = v
                    if (type(v) == "function" and not prop.rawFunction)
                        or state.is(v) then
                        if prop.visual then
                            if t.invalidateLayout then t:invalidateLayout(k) end
                            if t.markRenderDirty then
                                t:markRenderDirty()
                            else
                                t:markDirty()
                            end
                        end
                    else
                        if prop.onChange then prop.onChange(t, v, old) end
                        syncMirroredState(t, prop, v)
                        if prop.visual then
                            if t.invalidateLayout then t:invalidateLayout(k) end
                            if t.markRenderDirty then
                                t:markRenderDirty()
                            else
                                t:markDirty()
                            end
                        end
                    end
                end
            else
                rawset(t, k, v)
            end
        end,
        __tostring = function(t)
            return name
        end,
    }

    c.new = function(props)
        local self = setmetatable({
            _p = setmetatable({}, c.__pmeta),
            _handlers = {},
            _class = c,
        }, c.__meta)
        self:setup()
        if props then self:apply(props) end
        return self
    end

    return c
end

--- Defines a property on a class and generates :setX()/:getX() accessors.
--- opts.visual (default true): marks the UI dirty when the value changes.
--- opts.onChange(self, new, old): runs after the value is stored.
--- opts.rawFunction: functions are stored as-is instead of being treated
--- as dynamic values.
--- opts.rawString: "{...}" strings are stored as-is instead of being
--- compiled as reactive expressions (for user-entered text).
--- opts.state: mirrors the property's truthiness to a named element state.
--- opts.stateWhen(value, self): custom predicate for the mirrored state.
--- opts.styleable=false: state styles cannot override this property.
---@param c table Target class
---@param propName string Property name
---@param default any Shared default value
---@param opts? table Property behavior options
function class.property(c, propName, default, opts)
    opts = opts or {}
    c.__props[propName] = {
        visual = opts.visual ~= false,
        onChange = opts.onChange,
        rawFunction = opts.rawFunction,
        rawString = opts.rawString,
        state = opts.state,
        stateWhen = opts.stateWhen,
        styleable = opts.styleable ~= false,
    }
    c.__defaults[propName] = default

    local cap = capitalize(propName)
    c["set" .. cap] = function(self, v)
        self[propName] = v
        return self
    end
    c["get" .. cap] = function(self)
        return self[propName]
    end
end

--- Defines a fluent setter plus effective/raw getters spanning multiple
--- existing properties. The combination stores no value of its own.
---
--- class.combinedProperty(Element, "Position", { "x", "y" }) creates:
---   element:setPosition(x, y)
---   element:getPosition()       -- effective/resolved values
---   element:getRawPosition()    -- authored/default values
---@param c table Target class
---@param combinedName string Public combined-property name
---@param propertyNames string[] Ordered component property names
function class.combinedProperty(c, combinedName, propertyNames)
    if type(combinedName) ~= "string" or combinedName == "" then
        error("Basalt class: combined property name must be a non-empty string", 2)
    end
    if type(propertyNames) ~= "table" or #propertyNames == 0 then
        error("Basalt class: combined property list must not be empty", 2)
    end

    local names = {}
    for i = 1, #propertyNames do
        local propName = propertyNames[i]
        if type(propName) ~= "string" or c.__props[propName] == nil then
            error("Basalt class: unknown property '" .. tostring(propName)
                .. "' in combined property " .. combinedName, 2)
        end
        names[i] = propName
    end

    local setterName = "set" .. combinedName
    local getterName = "get" .. combinedName
    local rawGetterName = "getRaw" .. combinedName

    c[setterName] = function(self, ...)
        local values = table.pack(...)
        if values.n ~= #names then
            error("Basalt: " .. setterName .. " expects " .. #names
                .. " values, got " .. values.n, 2)
        end
        for i = 1, #names do self[names[i]] = values[i] end
        return self
    end

    c[getterName] = function(self)
        local values = { n = #names }
        for i = 1, #names do values[i] = self[names[i]] end
        return unpack(values, 1, values.n)
    end

    c[rawGetterName] = function(self)
        local values = { n = #names }
        for i = 1, #names do values[i] = self:raw(names[i]) end
        return unpack(values, 1, values.n)
    end
end

--- Declares an event on a class and generates its :onX(fn) registrar.
---@param c table Target class
---@param eventName string Event name
function class.event(c, eventName)
    c["on" .. capitalize(eventName)] = function(self, fn)
        return self:on(eventName, fn)
    end
end

return class

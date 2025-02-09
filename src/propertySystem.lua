local deepCopy = require("libraries/utils").deepCopy
local expect = require("libraries/expect")

local PropertySystem = {}
PropertySystem.__index = PropertySystem

PropertySystem._properties = {}

function PropertySystem.defineProperty(class, name, config)
    if not rawget(class, '_properties') then
        class._properties = {}
    end

    class._properties[name] = {
        type = config.type,
        default = config.default,
        canTriggerRender = config.canTriggerRender,
        getter = config.getter,
        setter = config.setter,
    }

    local capitalizedName = name:sub(1,1):upper() .. name:sub(2)

    class["get" .. capitalizedName] = function(self)
        expect(1, self, "element")
        local value = self._values[name]
        return config.getter and config.getter(value) or value
    end

    class["set" .. capitalizedName] = function(self, value)
        expect(1, self, "element")
        expect(2, value, config.type)
        if config.setter then
            value = config.setter(self, value)
        end

        self:_updateProperty(name, value)
        return self
    end
end

function PropertySystem:__init()
    self._values = {}
    self._observers = {}

    self.set = function(name, value)
        local oldValue = self._values[name]
        self._values[name] = value
        if(self._properties[name].setter) then
            value = self._properties[name].setter(self, value)
        end
        if oldValue ~= value and self._observers[name] then
            for _, callback in ipairs(self._observers[name]) do
                callback(self, value, oldValue)
            end
        end
    end

    self.get = function(name)
        return self._values[name]
    end

    local properties = {}
    local currentClass = getmetatable(self).__index

    while currentClass do
        if rawget(currentClass, '_properties') then
            for name, config in pairs(currentClass._properties) do
                if not properties[name] then
                    properties[name] = config
                end
            end
        end
        currentClass = getmetatable(currentClass) and rawget(getmetatable(currentClass), '__index')
    end

    self._properties = properties

    local originalMT = getmetatable(self)
    local originalIndex = originalMT.__index
    setmetatable(self, {
        __index = function(t, k)
            if self._properties[k] then
                return self._values[k]
            end
            if type(originalIndex) == "function" then
                return originalIndex(t, k)
            else
                return originalIndex[k]
            end
        end,
        __newindex = function(t, k, v)
            if self._properties[k] then
                if self._properties[k].setter then
                    v = self._properties[k].setter(self, v)
                end
                self:_updateProperty(k, v)
            else
                rawset(t, k, v)
            end
        end,
        __tostring = function(self)
            return string.format("Object: %s (id: %s)", self._values.type, self.id)
        end
    })

    for name, config in pairs(properties) do
        if self._values[name] == nil then
            if type(config.default) == "table" then
                self._values[name] = deepCopy(config.default)
            else
                self._values[name] = config.default
            end
        end
    end

    return self
end

function PropertySystem:_updateProperty(name, value)
    local oldValue = self._values[name]
    if oldValue ~= value then
        self._values[name] = value
        if self._properties[name].canTriggerRender then
            self:updateRender()
        end
        if self._observers[name] then
            for _, callback in ipairs(self._observers[name]) do
                callback(self, value, oldValue)
            end
        end
    end
end

function PropertySystem:observe(name, callback)
    self._observers[name] = self._observers[name] or {}
    table.insert(self._observers[name], callback)
    return self
end

return PropertySystem
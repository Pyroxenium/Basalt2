local deepCopy = require("libraries/utils").deepCopy
local expect = require("libraries/expect")
local errorManager = require("errorManager")

--- PropertySystem is a class that allows Elements to have properties that can be observed and updated.
--- It also allows for properties to have custom getters and setters. This is the base system for all Elements.
--- @class PropertySystem
--- @field _properties table A table containing all property configurations
--- @field _values table A table containing all property values
--- @field _observers table A table containing all property observers
--- @field set function A function to set a property value
--- @field get function A function to get a property value
local PropertySystem = {}
PropertySystem.__index = PropertySystem

PropertySystem._properties = {}
local blueprintTemplates = {}

PropertySystem._setterHooks = {}

--- Adds a setter hook to the PropertySystem. Setter hooks are functions that are called before a property is set.
--- @shortDescription Adds a setter hook to the PropertySystem
--- @param hook function The hook function to add
function PropertySystem.addSetterHook(hook)
    table.insert(PropertySystem._setterHooks, hook)
end

local function applyHooks(element, propertyName, value, config)
    for _, hook in ipairs(PropertySystem._setterHooks) do
        local newValue = hook(element, propertyName, value, config)
        if newValue ~= nil then
            value = newValue
        end
    end
    return value
end

--- Defines a property for an element class
--- @shortDescription Defines a property for an element class
--- @param class table The element class to define the property for
--- @param name string The name of the property
--- @param config table The configuration of the property
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
        allowNil = config.allowNil,
    }

    local capitalizedName = name:sub(1,1):upper() .. name:sub(2)

    class["get" .. capitalizedName] = function(self, ...)
        expect(1, self, "element")
        local value = self._values[name]
        if type(value) == "function" and config.type ~= "function" then
            value = value(self)
        end
        return config.getter and config.getter(self, value, ...) or value
    end

    class["set" .. capitalizedName] = function(self, value, ...)
        expect(1, self, "element")
        value = applyHooks(self, name, value, config)

        if type(value) ~= "function" then
            if config.type == "table" then
                if value == nil then
                    if not config.allowNil then
                        expect(2, value, config.type)
                    end
                end
            else
                expect(2, value, config.type)
            end
        end

        if config.setter then
            value = config.setter(self, value, ...)
        end

        self:_updateProperty(name, value)
        return self
    end
end

--- Combines multiple properties into a single getter and setter
--- @shortDescription Combines multiple properties
--- @param class table The element class to combine the properties for
--- @param name string The name of the combined property
--- @vararg string The names of the properties to combine
function PropertySystem.combineProperties(class, name, ...)
    local properties = {...}
    for k,v in pairs(properties)do
        if not class._properties[v] then errorManager.error("Property not found: "..v) end
    end
    local capitalizedName = name:sub(1,1):upper() .. name:sub(2)

    class["get" .. capitalizedName] = function(self)
        expect(1, self, "element")
        local value = {}
        for _,v in pairs(properties)do
            table.insert(value, self.get(v))
        end
        return table.unpack(value)
    end

    class["set" .. capitalizedName] = function(self, ...)
        expect(1, self, "element")
        local values = {...}
        for i,v in pairs(properties)do
            self.set(v, values[i])
        end
        return self
    end
end

--- Creates a blueprint of an element class with all its properties
--- @shortDescription Creates a blueprint of an element class
--- @param elementClass table The element class to create a blueprint from
--- @return table blueprint A table containing all property definitions
function PropertySystem.blueprint(elementClass, properties, basalt, parent)
    if not blueprintTemplates[elementClass] then
        local template = {
            basalt = basalt,
            __isBlueprint = true,
            _values = properties or {},
            _events = {},
            render = function() end,
            dispatchEvent = function() end,
            init = function() end,
        }

        template.loaded = function(self, callback)
            self.loadedCallback = callback
            return template
        end

        template.create = function(self)
            local element = elementClass.new()
            element:init({}, self.basalt)
            for name, value in pairs(self._values) do
                element._values[name] = value
            end
            for name, callbacks in pairs(self._events) do
                for _, callback in ipairs(callbacks) do
                    element[name](element, callback)
                end
            end
            if(parent~=nil)then
                parent:addChild(element)
            end
            element:updateRender()
            self.loadedCallback(element)
            element:postInit()
            return element
        end

        local currentClass = elementClass
        while currentClass do
            if rawget(currentClass, '_properties') then
                for name, config in pairs(currentClass._properties) do
                    if type(config.default) == "table" then
                        template._values[name] = deepCopy(config.default)
                    else
                        template._values[name] = config.default
                    end
                end
            end
            currentClass = getmetatable(currentClass) and rawget(getmetatable(currentClass), '__index')
        end

        blueprintTemplates[elementClass] = template
    end

    local blueprint = {
        _values = {},
        _events = {},
        loadedCallback = function() end,
    }

    blueprint.get = function(name)
        local value = blueprint._values[name]
        local config = elementClass._properties[name]
        if type(value) == "function" and config.type ~= "function" then
            value = value(blueprint)
        end
        return value
    end
    blueprint.set = function(name, value)
        blueprint._values[name] = value
        return blueprint
    end

    setmetatable(blueprint, {
        __index = function(self, k)
            if k:match("^on%u") then
                return function(_, callback)
                    self._events[k] = self._events[k] or {}
                    table.insert(self._events[k], callback)
                    return self
                end
            end
            if k:match("^get%u") then
                local propName = k:sub(4,4):lower() .. k:sub(5)
                return function()
                    return self._values[propName]
                end
            end
            if k:match("^set%u") then
                local propName = k:sub(4,4):lower() .. k:sub(5)
                return function(_, value)
                    self._values[propName] = value
                    return self
                end
            end
            return blueprintTemplates[elementClass][k]
        end
    })

    return blueprint
end

--- Creates an element from a blueprint
--- @shortDescription Creates an element from a blueprint
--- @param elementClass table The element class to create from the blueprint
--- @param blueprint table The blueprint to create the element from
--- @return table element The created element
function PropertySystem.createFromBlueprint(elementClass, blueprint, basalt)
    local element = elementClass.new({}, basalt)
    for name, value in pairs(blueprint._values) do
        if type(value) == "table" then
            element._values[name] = deepCopy(value)
        else
            element._values[name] = value
        end
    end

    return element
end

--- Initializes the PropertySystem IS USED INTERNALLY
--- @shortDescription Initializes the PropertySystem
--- @return table self The PropertySystem
function PropertySystem:__init()
    self._values = {}
    self._observers = {}

    self.set = function(name, value, ...)
        local oldValue = self._values[name]
        local config = self._properties[name]
        if(config~=nil)then
            if(config.setter) then
                value = config.setter(self, value, ...)
            end
            if config.canTriggerRender then
                self:updateRender()
            end
            self._values[name] = applyHooks(self, name, value, config)
            if oldValue ~= value and self._observers[name] then
                for _, callback in ipairs(self._observers[name]) do
                    callback(self, value, oldValue)
                end
            end
        end
    end

    self.get = function(name, ...)
        local value = self._values[name]
        local config = self._properties[name]
        if(config==nil)then errorManager.error("Property not found: "..name) return end
        if type(value) == "function" and config.type ~= "function" then
            value = value(self)
        end
        return config.getter and config.getter(self, value, ...) or value
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
            local config = self._properties[k]
            if config then
                local value = self._values[k]
                if type(value) == "function" and config.type ~= "function" then
                    value = value(self)
                end
                return value
            end
            if type(originalIndex) == "function" then
                return originalIndex(t, k)
            else
                return originalIndex[k]
            end
        end,
        __newindex = function(t, k, v)
            local config = self._properties[k]
            if config then
                if config.setter then
                    v = config.setter(self, v)
                end
                v = applyHooks(self, k, v, config)
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

--- Update call for a property IS USED INTERNALLY
--- @shortDescription Update call for a property
--- @param name string The name of the property
--- @param value any The value of the property
--- @return table self The PropertySystem
function PropertySystem:_updateProperty(name, value)
    local oldValue = self._values[name]
    if type(oldValue) == "function" then
        oldValue = oldValue(self)
    end

    self._values[name] = value
    local newValue = type(value) == "function" and value(self) or value

    if oldValue ~= newValue then
        if self._properties[name].canTriggerRender then
            self:updateRender()
        end
        if self._observers[name] then
            for _, callback in ipairs(self._observers[name]) do
                callback(self, newValue, oldValue)
            end
        end
    end
    return self
end

--- Observers a property
--- @shortDescription Observers a property
--- @param name string The name of the property
--- @param callback function The callback function to call when the property changes
--- @return table self The PropertySystem
function PropertySystem:observe(name, callback)
    self._observers[name] = self._observers[name] or {}
    table.insert(self._observers[name], callback)
    return self
end

--- Removes an observer from a property
--- @shortDescription Removes an observer from a property
--- @param name string The name of the property
--- @param callback function The callback function to remove
--- @return table self The PropertySystem
function PropertySystem:removeObserver(name, callback)
    if self._observers[name] then
        for i, cb in ipairs(self._observers[name]) do
            if cb == callback then
                table.remove(self._observers[name], i)
                if #self._observers[name] == 0 then
                    self._observers[name] = nil
                end
                break
            end
        end
    end
    return self
end

--- Removes all observers from a property
--- @shortDescription Removes all observers from a property
--- @param name? string The name of the property
--- @return table self The PropertySystem
function PropertySystem:removeAllObservers(name)
    if name then
        self._observers[name] = nil
    else
        self._observers = {}
    end
    return self
end

--- Adds a property to the PropertySystem on instance level
--- @shortDescription Adds a property to the PropertySystem on instance level
--- @param name string The name of the property
--- @param config table The configuration of the property
--- @return table self The PropertySystem
function PropertySystem:instanceProperty(name, config)
    PropertySystem.defineProperty(self, name, config)
    self._values[name] = config.default
    return self
end

--- Removes a property from the PropertySystem on instance level
--- @shortDescription Removes a property from the PropertySystem
--- @param name string The name of the property
--- @return table self The PropertySystem
function PropertySystem:removeProperty(name)
    self._values[name] = nil
    self._properties[name] = nil
    self._observers[name] = nil

    local capitalizedName = name:sub(1,1):upper() .. name:sub(2)
    self["get" .. capitalizedName] = nil
    self["set" .. capitalizedName] = nil
    return self
end

--- Gets a property configuration
--- @shortDescription Gets a property configuration
--- @param name string The name of the property
--- @return table config The configuration of the property
function PropertySystem:getPropertyConfig(name)
    return self._properties[name]
end

return PropertySystem
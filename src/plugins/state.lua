local PropertySystem = require("propertySystem")
local errorManager = require("errorManager")

---@class BaseFrame : Container
local BaseFrame = {}

function BaseFrame.setup(element)
    element.defineProperty(element, "states", {default = {}, type = "table"})
    element.defineProperty(element, "stateObserver", {default = {}, type = "table"})
end

--- Initializes a new state for this element
--- @shortDescription Initializes a new state
--- @param self BaseFrame The element to initialize state for
--- @param name string The name of the state
--- @param default any The default value of the state
--- @param persist? boolean Whether to persist the state to disk
--- @param path? string Custom file path for persistence
--- @return BaseFrame self The element instance
function BaseFrame:initializeState(name, default, persist, path)
    local states = self.get("states")

    if states[name] then
        errorManager.error("State '" .. name .. "' already exists")
        return self
    end

    local file = path or "states/" .. self.get("name") .. ".state"
    local persistedData = {}

    if persist and fs.exists(file) then
        local f = fs.open(file, "r")
        persistedData = textutils.unserialize(f.readAll()) or {}
        f.close()
    end

    states[name] = {
        value = persist and persistedData[name] or default,
        persist = persist,
    }

    return self
end


--- This is the state plugin. It provides a state management system for UI elements with support for
--- persistent states, computed states, and state sharing between elements.
---@class BaseElement
local BaseElement = {}

--- Sets the value of a state
--- @shortDescription Sets a state value
--- @param self BaseElement The element to set state for
--- @param name string The name of the state
--- @param value any The new value for the state
--- @return BaseElement self The element instance
function BaseElement:setState(name, value)
    local main = self:getBaseFrame()
    local states = main.get("states")
    local observers = main.get("stateObserver")
    if not states[name] then
        errorManager.error("State '"..name.."' not initialized")
    end

    if states[name].persist then
        local file = "states/" .. main.get("name") .. ".state"
        local persistedData = {}

        if fs.exists(file) then
            local f = fs.open(file, "r")
            persistedData = textutils.unserialize(f.readAll()) or {}
            f.close()
        end

        persistedData[name] = value

        local dir = fs.getDir(file)
        if not fs.exists(dir) then
            fs.makeDir(dir)
        end

        local f = fs.open(file, "w")
        f.write(textutils.serialize(persistedData))
        f.close()
    end

    states[name].value = value

    -- Trigger observers
    if observers[name] then
        for _, callback in ipairs(observers[name]) do
            callback(name, value)
        end
    end

    -- Recompute all computed states
    for stateName, state in pairs(states) do
        if state.computed then
            state.value = state.computeFn(self)
            if observers[stateName] then
                for _, callback in ipairs(observers[stateName]) do
                    callback(stateName, state.value)
                end
            end
        end
    end

    return self
end

--- Gets the value of a state
--- @shortDescription Gets a state value
--- @param self BaseElement The element to get state from
--- @param name string The name of the state
--- @return any value The current state value
function BaseElement:getState(name)
    local main = self:getBaseFrame()
    local states = main.get("states")

    if not states[name] then
        errorManager.error("State '"..name.."' not initialized")
    end

    if states[name].computed then
        return states[name].computeFn(self)
    end
    return states[name].value
end

--- Registers a callback for state changes
--- @shortDescription Watches for state changes
--- @param self BaseElement The element to watch
--- @param stateName string The state to watch
--- @param callback function Called with (element, newValue, oldValue)
--- @return BaseElement self The element instance
function BaseElement:onStateChange(stateName, callback)
    local main = self:getBaseFrame()
    local state = main.get("states")[stateName]
    if not state then
        errorManager.error("Cannot observe state '" .. stateName .. "': State not initialized")
        return self
    end
    local observers = main.get("stateObserver")
    if not observers[stateName] then
        observers[stateName] = {}
    end
    table.insert(observers[stateName], callback)
    return self
end

--- Removes a state change observer
--- @shortDescription Removes a state change observer
--- @param self BaseElement The element to remove observer from
--- @param stateName string The state to remove observer from
--- @param callback function The callback function to remove
--- @return BaseElement self The element instance
function BaseElement:removeStateChange(stateName, callback)
    local main = self:getBaseFrame()
    local observers = main.get("stateObserver")

    if observers[stateName] then
        for i, observer in ipairs(observers[stateName]) do
            if observer == callback then
                table.remove(observers[stateName], i)
                break
            end
        end
    end
    return self
end

function BaseElement:computed(name, func)
    local main = self:getBaseFrame()
    local states = main.get("states")

    if states[name] then
        errorManager.error("Computed state '" .. name .. "' already exists")
        return self
    end

    states[name] = {
        computeFn = func,
        value = func(self),
        computed = true,
    }

    return self
end

--- Binds a property to a state
--- @param self BaseElement The element to bind
--- @param propertyName string The property to bind
--- @param stateName string The state to bind to (optional, uses propertyName if not provided)
--- @return BaseElement self The element instance
function BaseElement:bind(propertyName, stateName)
    stateName = stateName or propertyName
    local main = self:getBaseFrame()
    local internalCall = false

    if self.get(propertyName) ~= nil then
        self.set(propertyName, main:getState(stateName))
    end

    self:onChange(propertyName, function(self, value)
        if internalCall then return end
        internalCall = true
        self:setState(stateName, value)
        internalCall = false
    end)

    self:onStateChange(stateName, function(name, value)
        if internalCall then return end
        internalCall = true
        if self.get(propertyName) ~= nil then
            self.set(propertyName, value)
        end
        internalCall = false
    end)

    return self
end

return {
    BaseElement = BaseElement,
    BaseFrame = BaseFrame
}

local PropertySystem = require("propertySystem")
local errorManager = require("errorManager")

--- This is the state plugin. It provides a state management system for UI elements with support for
--- persistent states, computed states, and state sharing between elements.
---@class BaseElement
local BaseElement = {}

---@private
function BaseElement.setup(element)
    element.defineProperty(element, "states", {default = {}, type = "table"})
    element.defineProperty(element, "computedStates", {default = {}, type = "table"})
    element.defineProperty(element, "stateUpdate", {
        default = {key = "", value = nil, oldValue = nil},
        type = "table"
    })
end

--- Initializes a new state for this element
--- @shortDescription Initializes a new state
--- @param self BaseElement The element to initialize state for
--- @param name string The name of the state
--- @param default any The default value of the state
--- @param canTriggerRender? boolean Whether state changes trigger a render
--- @param persist? boolean Whether to persist the state to disk
--- @param path? string Custom file path for persistence
--- @return BaseElement self The element instance
function BaseElement:initializeState(name, default, canTriggerRender, persist, path)
    local states = self.get("states")

    if states[name] then
        errorManager.error("State '" .. name .. "' already exists")
        return self
    end

    if persist then
        local file = path or ("states/" .. self.get("name") .. "_" .. name .. ".state")

        if fs.exists(file) then
            local f = fs.open(file, "r")
            states[name] = {
                value = textutils.unserialize(f.readAll()),
                persist = true,
                file = file
            }
            f.close()
        else
            states[name] = {
                value = default,
                persist = true,
                file = file,
                canTriggerRender = canTriggerRender
            }
        end
    else
        states[name] = {
            value = default,
            canTriggerRender = canTriggerRender
        }
    end
    return self
end

--- Sets the value of a state
--- @shortDescription Sets a state value
--- @param self BaseElement The element to set state for
--- @param name string The name of the state
--- @param value any The new value for the state
--- @return BaseElement self The element instance
function BaseElement:setState(name, value)
    local states = self.get("states")
    if not states[name] then
        error("State '"..name.."' not initialized")
    end

    local oldValue = states[name].value
    states[name].value = value

    if states[name].persist then
        local dir = fs.getDir(states[name].file)
        if not fs.exists(dir) then
            fs.makeDir(dir)
        end
        local f = fs.open(states[name].file, "w")
        f.write(textutils.serialize(value))
        f.close()
    end

    if states[name].canTriggerRender then
        self:updateRender()
    end

    self.set("stateUpdate", {
        key = name,
        value = value,
        oldValue = oldValue
    })
    return self
end

--- Gets the value of a state
--- @shortDescription Gets a state value
--- @param self BaseElement The element to get state from
--- @param name string The name of the state
--- @return any value The current state value
function BaseElement:getState(name)
    local states = self.get("states")
    if not states[name] then
        errorManager.error("State '"..name.."' not initialized")
    end
    return states[name].value
end

--- Creates a computed state that derives its value from other states
--- @shortDescription Creates a computed state
--- @param self BaseElement The element to create computed state for
--- @param key string The name of the computed state
--- @param computeFn function Function that computes the state value
--- @return BaseElement self The element instance
function BaseElement:computed(key, computeFn)
    local computed = self.get("computedStates")
    computed[key] = setmetatable({}, {
        __call = function()
            return computeFn(self)
        end
    })
    return self
end

--- Shares a state with other elements, keeping them in sync
--- @shortDescription Shares state between elements
--- @param self BaseElement The source element
--- @param stateKey string The state to share
--- @vararg BaseElement The target elements to share with
--- @return BaseElement self The source element
function BaseElement:shareState(stateKey, ...)
    local value = self:getState(stateKey)

    for _, element in ipairs({...}) do
        if element.get("states")[stateKey] then
            errorManager.error("Cannot share state '" .. stateKey .. "': Target element already has this state")
            return self
        end
        
        element:initializeState(stateKey, value)

        self:observe("stateUpdate", function(self, update)
            if update.key == stateKey then
                element:setState(stateKey, update.value)
            end
        end)
    end
    return self
end

--- Registers a callback for state changes
--- @shortDescription Watches for state changes
--- @param self BaseElement The element to watch
--- @param stateName string The state to watch
--- @param callback function Called with (element, newValue, oldValue)
--- @return BaseElement self The element instance
function BaseElement:onStateChange(stateName, callback)
    if not self.get("states")[stateName] then
        errorManager.error("Cannot observe state '" .. stateName .. "': State not initialized")
        return self
    end

    self:observe("stateUpdate", function(self, update)
        if update.key == stateName then
            callback(self, update.value, update.oldValue)
        end
    end)
    return self
end

return {
    BaseElement = BaseElement
}

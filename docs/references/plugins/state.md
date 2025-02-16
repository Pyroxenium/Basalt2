local PropertySystem = require("propertySystem")
local errorManager = require("errorManager")
local BaseElement = {}

function BaseElement.setup(element)
    element.defineProperty(element, "states", {default = {}, type = "table"})
    element.defineProperty(element, "computedStates", {default = {}, type = "table"})
    element.defineProperty(element, "stateUpdate", {
        default = {key = "", value = nil, oldValue = nil},
        type = "table"
    })
end

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

function BaseElement:getState(name)
    local states = self.get("states")
    if not states[name] then
        errorManager.error("State '"..name.."' not initialized")
    end
    return states[name].value
end

function BaseElement:computed(key, computeFn)
    local computed = self.get("computedStates")
    computed[key] = setmetatable({}, {
        __call = function()
            return computeFn(self)
        end
    })
    return self
end

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

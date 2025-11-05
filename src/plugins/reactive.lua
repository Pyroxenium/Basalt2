local errorManager = require("errorManager")
local PropertySystem = require("propertySystem")
---@configDefault false

local protectedNames = {
    colors = true,
    math = true,
    clamp = true,
    round = true
}

local mathEnv = {
    clamp = function(val, min, max)
        return math.min(math.max(val, min), max)
    end,
    round = function(val)
        return math.floor(val + 0.5)
    end,
    floor = math.floor,
    ceil = math.ceil,
    abs = math.abs
}

local function analyzeDependencies(expr)
    return {
        parent = expr:find("parent%."),
        self = expr:find("self%."),
        other = expr:find("[^(parent)][^(self)]%.")
    }
end

local function parseExpression(expr, element, propName)
    local deps = analyzeDependencies(expr)

    if deps.parent and not element.parent then
        errorManager.header = "Reactive evaluation error"
        errorManager.error("Expression uses parent but no parent available")
        return function() return nil end
    end

    expr = expr:gsub("^{(.+)}$", "%1")

    expr = expr:gsub("([%w_]+)%$([%w_]+)", function(obj, prop)
        if obj == "self" then
            return string.format('__getState("%s")', prop)
        elseif obj == "parent" then
            return string.format('__getParentState("%s")', prop)
        else
            return string.format('__getElementState("%s", "%s")', obj, prop)
        end
    end)

    expr = expr:gsub("([%w_]+)%.([%w_]+)", function(obj, prop)
        if protectedNames[obj] then 
            return obj.."."..prop
        end
        if tonumber(obj) then
            return obj.."."..prop
        end
        return string.format('__getProperty("%s", "%s")', obj, prop)
    end)

    local env = setmetatable({
        colors = colors,
        math = math,
        tostring = tostring,
        tonumber = tonumber,
        __getState = function(prop)
            return element:getState(prop)
        end,
        __getParentState = function(prop)
            return element.parent:getState(prop)
        end,
        __getElementState = function(objName, prop)
            if tonumber(objName) then
                return nil
            end
            local target = element:getBaseFrame():getChild(objName)
            if not target then
                errorManager.header = "Reactive evaluation error"
                errorManager.error("Could not find element: " .. objName)
                return nil
            end
            return target:getState(prop).value
        end,
        __getProperty = function(objName, propName)
            if tonumber(objName) then
                return nil
            end
            if objName == "self" then
                -- Check if property exists
                if element._properties[propName] then
                    return element.getResolved(propName)
                end
                if element._registeredStates and element._registeredStates[propName] then
                    return element:hasState(propName)
                end
                local states = element.get("states")
                if states and states[propName] ~= nil then
                    return true
                end
                errorManager.header = "Reactive evaluation error"
                errorManager.error("Property or state '" .. propName .. "' not found in element '" .. element:getType() .. "'")
                return nil
            elseif objName == "parent" then
                if element.parent._properties[propName] then
                    return element.parent.getResolved(propName)
                end
                if element.parent._registeredStates and element.parent._registeredStates[propName] then
                    return element.parent:hasState(propName)
                end
                local states = element.parent.get("states")
                if states and states[propName] ~= nil then
                    return true
                end
                errorManager.header = "Reactive evaluation error"
                errorManager.error("Property or state '" .. propName .. "' not found in parent element")
                return nil
            else
                local target = element.parent:getChild(objName)
                if not target then
                    errorManager.header = "Reactive evaluation error"
                    errorManager.error("Could not find element: " .. objName)
                    return nil
                end

                if target._properties[propName] then
                    return target.getResolved(propName)
                end
                if target._registeredStates and target._registeredStates[propName] then
                    return target:hasState(propName)
                end
                local states = target.get("states")
                if states and states[propName] ~= nil then
                    return true
                end
                errorManager.header = "Reactive evaluation error"
                errorManager.error("Property or state '" .. propName .. "' not found in element '" .. objName .. "'")
                return nil
            end
        end
    }, { __index = mathEnv })

    if(element._properties[propName].type == "string")then
        expr = "tostring(" .. expr .. ")"
    elseif(element._properties[propName].type == "number")then
        expr = "tonumber(" .. expr .. ")"
    end

    local func, err = load("return "..expr, "reactive", "t", env)
    if not func then
        errorManager.header = "Reactive evaluation error"
        errorManager.error("Invalid expression: " .. err)
        return function() return nil end
    end

    return func
end

local function validateReferences(expr, element)
    for ref in expr:gmatch("([%w_]+)%.") do
        if not protectedNames[ref] then
            if ref == "self" then
            elseif ref == "parent" then
                if not element.parent then
                    errorManager.header = "Reactive evaluation error"
                    errorManager.error("No parent element available")
                    return false
                end
            else
                if(tonumber(ref) == nil)then
                    local target = element.parent:getChild(ref)
                    if not target then
                        errorManager.header = "Reactive evaluation error"
                        errorManager.error("Referenced element not found: " .. ref)
                        return false
                    end
                end
            end
        end
    end
    return true
end

local functionCache = setmetatable({}, {__mode = "k"})

local observerCache = setmetatable({}, {
    __mode = "k",
    __index = function(t, k)
        t[k] = {}
        return t[k]
    end
})

local valueCache = setmetatable({}, {
    __mode = "k",
    __index = function(t, k)
        t[k] = {}
        return t[k]
    end
})

local function setupObservers(element, expr, propertyName)
    local deps = analyzeDependencies(expr)

    if observerCache[element][propertyName] then
        for _, observer in ipairs(observerCache[element][propertyName]) do
            observer.target:removeObserver(observer.property, observer.callback)
        end
    end

    local observers = {}
    for ref, prop in expr:gmatch("([%w_]+)%.([%w_]+)") do
        if not protectedNames[ref] then
            local target
            if ref == "self" and deps.self then
                target = element
            elseif ref == "parent" and deps.parent then
                target = element.parent
            elseif deps.other then
                target = element:getBaseFrame():getChild(ref)
            end

            if target then
                local isState = false
                if target._properties[prop] then
                    isState = false
                elseif target._registeredStates and target._registeredStates[prop] then
                    isState = true
                else
                    local states = target.get("states")
                    if states and states[prop] ~= nil then
                        isState = true
                    end
                end

                local observer = {
                    target = target,
                    property = isState and "states" or prop,
                    callback = function()
                        local oldValue = valueCache[element][propertyName]
                        local newValue = element.get(propertyName)

                        if oldValue ~= newValue then
                            valueCache[element][propertyName] = newValue

                            if element._observers and element._observers[propertyName] then
                                for _, obs in ipairs(element._observers[propertyName]) do
                                    obs()
                                end
                            end

                            element:updateRender()
                        end
                    end
                }
                target:observe(observer.property, observer.callback)
                table.insert(observers, observer)
            end
        end
    end

    observerCache[element][propertyName] = observers
end

PropertySystem.addSetterHook(function(element, propertyName, value, config)
    if type(value) == "string" and value:match("^{.+}$") then
        local expr = value:gsub("^{(.+)}$", "%1")
        local deps = analyzeDependencies(expr)

        if deps.parent and not element.parent then
            return config.default
        end
        if not validateReferences(expr, element) then
            return config.default
        end

        setupObservers(element, expr, propertyName)

        if not functionCache[element] then
            functionCache[element] = {}
        end
        if not functionCache[element][value] then
            local parsedFunc = parseExpression(value, element, propertyName)
            functionCache[element][value] = parsedFunc
        end

        return function(self)
            if element._destroyed or (deps.parent and not element.parent) then
                return config.default
            end

            local success, result = pcall(functionCache[element][value])
            if not success then
                if result and result:match("attempt to index.-nil value") then
                    return config.default
                end
                errorManager.header = "Reactive evaluation error"
                if type(result) == "string" then
                    errorManager.error("Error evaluating expression: " .. result)
                else
                    errorManager.error("Error evaluating expression")
                end
                return config.default
            end

            valueCache[element][propertyName] = result
            return result
        end
    end
end)

--- This module provides reactive functionality for elements, it adds no new functionality for elements. 
--- It is used to evaluate expressions in property values and update the element when the expression changes.
--- @usage local button = main:addButton({text="Exit"})
--- @usage button:setX("{parent.x - 12}")
--- @usage button:setBackground("{self.clicked and colors.red or colors.green}")
--- @usage button:setWidth("{#self.text + 2}")
---@class Reactive
local BaseElement = {}

BaseElement.hooks = {
    destroy = function(self)
        if observerCache[self] then
            for propName, observers in pairs(observerCache[self]) do
                for _, observer in ipairs(observers) do
                    observer.target:removeObserver(observer.property, observer.callback)
                end
            end
            observerCache[self] = nil
            valueCache[self] = nil
            functionCache[self] = nil
        end
    end
}

return {
    BaseElement = BaseElement
}

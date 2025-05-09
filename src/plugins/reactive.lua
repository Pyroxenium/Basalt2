local errorManager = require("errorManager")
local PropertySystem = require("propertySystem")

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

local function parseExpression(expr, element, propName)
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
                return element.get(propName)
            elseif objName == "parent" then
                return element.parent.get(propName)
            else
                local target = element.parent:getChild(objName)
                if not target then
                    errorManager.header = "Reactive evaluation error"
                    errorManager.error("Could not find element: " .. objName)
                    return nil
                end

                return target.get(propName)
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

local function setupObservers(element, expr, propertyName)
    if observerCache[element][propertyName] then
        for _, observer in ipairs(observerCache[element][propertyName]) do
            observer.target:removeObserver(observer.property, observer.callback)
        end
    end

    local observers = {}
    for ref, prop in expr:gmatch("([%w_]+)%.([%w_]+)") do
        if not protectedNames[ref] then
            local target
            if ref == "self" then
                target = element
            elseif ref == "parent" then
                target = element.parent
            else
                target = element:getBaseFrame():getChild(ref)
            end

            if target then
                local observer = {
                    target = target,
                    property = prop,
                    callback = function()
                        element:updateRender()
                    end
                }
                target:observe(prop, observer.callback)
                table.insert(observers, observer)
            end
        end
    end

    observerCache[element][propertyName] = observers
end

PropertySystem.addSetterHook(function(element, propertyName, value, config)
    if type(value) == "string" and value:match("^{.+}$") then
        local expr = value:gsub("^{(.+)}$", "%1")
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
            local success, result = pcall(functionCache[element][value])
            if not success then
                errorManager.header = "Reactive evaluation error"
                if type(result) == "string" then
                    errorManager.error("Error evaluating expression: " .. result)
                else
                    errorManager.error("Error evaluating expression")
                end
                return config.default
            end
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
        end
    end
}

return {
    BaseElement = BaseElement
}

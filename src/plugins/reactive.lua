local errorManager = require("errorManager")
local PropertySystem = require("propertySystem")
local log = require("log")

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
    end
}

local function parseExpression(expr, element)
    expr = expr:gsub("^{(.+)}$", "%1")

    for k,v in pairs(colors) do
        if type(k) == "string" then
            expr = expr:gsub("%f[%w]"..k.."%f[%W]", "colors."..k)
        end
    end

    expr = expr:gsub("([%w_]+)%.([%w_]+)", function(obj, prop)
        if protectedNames[obj] then 
            return obj.."."..prop
        end
        return string.format('__getProperty("%s", "%s")', obj, prop)
    end)

    local env = setmetatable({
        colors = colors,
        math = math,
        __getProperty = function(objName, propName)
            if objName == "self" then
                return element.get(propName)
            elseif objName == "parent" then
                return element.parent.get(propName)
            else
                local target = element:getBaseFrame():getChild(objName)
                if not target then
                    errorManager.header = "Reactive evaluation error"
                    errorManager.error("Could not find element: " .. objName)
                    return nil
                end

                return target.get(propName)
            end
        end
    }, { __index = mathEnv })

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
            if ref == "parent" then
                if not element.parent then
                    errorManager.header = "Reactive evaluation error"
                    errorManager.error("No parent element available")
                    return false
                end
            else
                local target = element:getBaseFrame():getChild(ref)
                if not target then
                    errorManager.header = "Reactive evaluation error"
                    errorManager.error("Referenced element not found: " .. ref)
                    return false
                end
            end
        end
    end
    return true
end

local functionCache = {}
local observerCache = setmetatable({}, {__mode = "k"})

local function setupObservers(element, expr)
    if observerCache[element] then
        for _, observer in ipairs(observerCache[element]) do
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

    observerCache[element] = observers
end

PropertySystem.addSetterHook(function(element, propertyName, value, config)
    if type(value) == "string" and value:match("^{.+}$") then
        local expr = value:gsub("^{(.+)}$", "%1")
        if not validateReferences(expr, element) then
            return config.default
        end

        setupObservers(element, expr)

        if not functionCache[value] then
            local parsedFunc = parseExpression(value, element)
            functionCache[value] = parsedFunc
        end

        return function(self)
            local success, result = pcall(functionCache[value])
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

local BaseElement = {}

BaseElement.hooks = {
    destroy = function(self)
        if observerCache[self] then
            for _, observer in ipairs(observerCache[self]) do
                observer.target:observe(observer.property, observer.callback)
            end
            observerCache[self] = nil
        end
    end
}

return {
    BaseElement = BaseElement
}

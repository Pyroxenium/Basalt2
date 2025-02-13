local function setupReactiveProperty(element, propertyName, expression)

end

local function createReactiveFunction(expression, scope)
    local code = expression:gsub(
        "(%w+)%s*%?%s*([^:]+)%s*:%s*([^}]+)",
        "%1 and %2 or %3"
    )

    return load(string.format([[
        return function(self)
            return %s
        end
    ]], code), "reactive", "t", scope)()
end

local BaseElement = {}

function BaseElement:setReactiveProperty(propertyName, expression)
    setupReactiveProperty(self, propertyName, expression)
    return self
end

function BaseElement:setReactive(propertyName, expression)
    local reactiveFunc = createReactiveFunction(expression, self)
    self.set(propertyName, reactiveFunc)
    return self
end

return {
    BaseElement = BaseElement
}

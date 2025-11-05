local errorManager = require("errorManager")
---@configDefault false

--- This is the responsive plugin. It provides a fluent builder API for creating responsive states with an intuitive when/apply/otherwise syntax.
---@class BaseElement
local BaseElement = {}

--- Creates a responsive builder for defining responsive states
--- @shortDescription Creates a responsive state builder
--- @param self BaseElement The element to create the builder for
--- @return ResponsiveBuilder builder The responsive builder instance
function BaseElement:responsive()
    local builder = {
        _element = self,
        _rules = {},
        _currentStateName = nil,
        _currentCondition = nil,
        _stateCounter = 0
    }

    --- Defines a condition for responsive behavior
    --- @param condition string|function The condition as string expression or function
    --- @return ResponsiveBuilder self For method chaining
    function builder:when(condition)
        if self._currentCondition then
            errorManager.header = "Responsive Builder Error"
            errorManager.error("Previous when() must be followed by apply() before starting a new when()")
        end

        self._stateCounter = self._stateCounter + 1
        self._currentStateName = "__responsive_" .. self._stateCounter
        self._currentCondition = condition

        return self
    end

    --- Applies properties when the current condition is met
    --- @param properties table The properties to apply {property = value, ...}
    --- @return ResponsiveBuilder self For method chaining
    function builder:apply(properties)
        if not self._currentCondition then
            errorManager.header = "Responsive Builder Error"
            errorManager.error("apply() must follow a when() call")
        end

        if type(properties) ~= "table" then
            errorManager.header = "Responsive Builder Error"
            errorManager.error("apply() requires a table of properties")
        end

        self._element:registerResponsiveState(
            self._currentStateName,
            self._currentCondition,
            100
        )

        for propName, value in pairs(properties) do
            local capitalizedName = propName:sub(1,1):upper() .. propName:sub(2)
            local setter = "set" .. capitalizedName .. "State"

            if self._element[setter] then
                self._element[setter](self._element, self._currentStateName, value)
            else
                errorManager.header = "Responsive Builder Error"
                errorManager.error("Unknown property: " .. propName)
            end
        end

        table.insert(self._rules, {
            stateName = self._currentStateName,
            condition = self._currentCondition,
            properties = properties
        })

        self._currentCondition = nil
        self._currentStateName = nil

        return self
    end

    --- Defines a fallback condition (else case)
    --- @param properties table The properties to apply when no other conditions match
    --- @return ResponsiveBuilder self For method chaining
    function builder:otherwise(properties)
        if self._currentCondition then
            errorManager.header = "Responsive Builder Error"
            errorManager.error("otherwise() cannot be used after when() without apply()")
        end

        if type(properties) ~= "table" then
            errorManager.header = "Responsive Builder Error"
            errorManager.error("otherwise() requires a table of properties")
        end

        self._stateCounter = self._stateCounter + 1
        local otherwiseStateName = "__responsive_otherwise_" .. self._stateCounter

        local otherRules = {}
        for _, rule in ipairs(self._rules) do
            table.insert(otherRules, rule.condition)
        end

        local otherwiseCondition
        if type(otherRules[1]) == "string" then
            local negatedExprs = {}
            for _, cond in ipairs(otherRules) do
                table.insert(negatedExprs, "not (" .. cond .. ")")
            end
            otherwiseCondition = table.concat(negatedExprs, " and ")
        else
            otherwiseCondition = function(elem)
                for _, cond in ipairs(otherRules) do
                    if cond(elem) then
                        return false
                    end
                end
                return true
            end
        end

        self._element:registerResponsiveState(
            otherwiseStateName,
            otherwiseCondition,
            50
        )

        for propName, value in pairs(properties) do
            local capitalizedName = propName:sub(1,1):upper() .. propName:sub(2)
            local setter = "set" .. capitalizedName .. "State"

            if self._element[setter] then
                self._element[setter](self._element, otherwiseStateName, value)
            else
                errorManager.header = "Responsive Builder Error"
                errorManager.error("Unknown property: " .. propName)
            end
        end

        return self
    end

    --- Completes the builder (optional, for clarity)
    --- @return BaseElement element The original element
    function builder:done()
        if self._currentCondition then
            errorManager.header = "Responsive Builder Error"
            errorManager.error("Unfinished when() without apply()")
        end
        return self._element
    end

    return builder
end

return {
    BaseElement = BaseElement
}
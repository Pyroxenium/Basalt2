-- Optional responsive breakpoints built on element states and layout hooks.
--
-- local responsive = basalt.use("responsive")
-- responsive.apply(panel, {
--   { name = "compact", maxWidth = 30,
--     props = { direction = "column" } },
--   { name = "wide", minWidth = 31,
--     props = { direction = "row" } },
-- })
--
-- local sidebar = parent:addFrame()
--     :responsive()
--         :when("parent.width < 15")
--             :apply({ width = 10 })
--         :otherwise({ width = 15 })

local require = ...
local Element = require("core/element")

local responsive = {}
local Builder = {}
Builder.__index = Builder

local OPERATORS = { "<=", ">=", "==", "~=", "<", ">" }

local function trim(value)
    return value:match("^%s*(.-)%s*$")
end

local function readOperand(expression, element)
    local number = tonumber(expression)
    if number ~= nil then return number end

    local scope, property = expression:match("^([%a_][%w_]*)%.([%a_][%w_]*)$")
    if scope ~= "self" and scope ~= "parent" then
        error("Basalt responsive: unsupported operand '" .. expression .. "'", 3)
    end
    if property ~= "width" and property ~= "height" then
        error("Basalt responsive: only width and height can be read", 3)
    end

    local target = scope == "self" and element or rawget(element, "parent")
    return target and target[property] or nil
end

local function compare(left, operator, right)
    if left == nil or right == nil then return false end
    if operator == "<" then return left < right end
    if operator == ">" then return left > right end
    if operator == "<=" then return left <= right end
    if operator == ">=" then return left >= right end
    if operator == "==" then return left == right end
    return left ~= right
end

local function compileCondition(expression)
    if type(expression) == "function" then return expression end
    if type(expression) ~= "string" or trim(expression) == "" then
        error("Basalt responsive: condition must be a non-empty string or function", 3)
    end

    expression = trim(expression)
    local left, operator, right
    for i = 1, #OPERATORS do
        local candidate = OPERATORS[i]
        local start = expression:find(candidate, 1, true)
        if start then
            left = trim(expression:sub(1, start - 1))
            operator = candidate
            right = trim(expression:sub(start + #candidate))
            break
        end
    end
    if not operator or left == "" or right == "" then
        error("Basalt responsive: expected '<operand> <operator> <operand>'", 3)
    end

    -- Validate the grammar now so errors point at :when(), not the next render.
    local function validateOperand(operand)
        if tonumber(operand) ~= nil then return end
        local scope, property = operand:match("^([%a_][%w_]*)%.([%a_][%w_]*)$")
        if (scope ~= "self" and scope ~= "parent")
            or (property ~= "width" and property ~= "height") then
            error("Basalt responsive: unsupported operand '" .. operand .. "'", 4)
        end
    end
    validateOperand(left)
    validateOperand(right)

    return function(element)
        return compare(readOperand(left, element), operator,
            readOperand(right, element))
    end
end

local function matches(rule, element, width, height)
    if rule.minWidth and width < rule.minWidth then return false end
    if rule.maxWidth and width > rule.maxWidth then return false end
    if rule.minHeight and height < rule.minHeight then return false end
    if rule.maxHeight and height > rule.maxHeight then return false end
    if rule.when and not rule.when(element, width, height) then return false end
    return true
end

--- Attaches ordered responsive breakpoint rules to an element.
---@param element Element Target element
---@param rules table[] Responsive rules
---@param options table|nil Options; exclusive makes only the first match active
---@return Element element
function responsive.apply(element, rules, options)
    if type(rules) ~= "table" then
        error("Basalt responsive: rules must be a table", 2)
    end
    if not element.getChildren then
        error("Basalt responsive: target must be a container", 2)
    end

    local old = rawget(element, "_responsiveController")
    if old then old:destroy() end

    local prepared, names = {}, {}
    for i = 1, #rules do
        local rule = rules[i]
        if type(rule) ~= "table" then
            error("Basalt responsive: rule " .. i .. " must be a table", 2)
        end
        if rule.when ~= nil and type(rule.when) ~= "function" then
            error("Basalt responsive: rule.when must be a function", 2)
        end
        if rule.props ~= nil and type(rule.props) ~= "table" then
            error("Basalt responsive: rule.props must be a table", 2)
        end
        if rule.name then
            if type(rule.name) ~= "string" or rule.name == "" then
                error("Basalt responsive: rule.name must be a non-empty string", 2)
            end
            if names[rule.name] then
                error("Basalt responsive: duplicate state name '" .. rule.name .. "'", 2)
            end
            names[rule.name] = true
        end

        local internalState = "__responsive_" .. i
        element:setStateStyle(internalState, rule.props or {}, -1000 + i)
        prepared[i] = {
            rule = rule,
            internalState = internalState,
            active = false,
        }
    end

    local controller = {
        element = element,
        rules = prepared,
        exclusive = options and options.exclusive == true,
    }

    function controller:refresh()
        local el = self.element
        local width, height = el.width, el.height
        local matched = false
        for i = 1, #self.rules do
            local entry = self.rules[i]
            local active = (not self.exclusive or not matched)
                and matches(entry.rule, el, width, height)
            if active then matched = true end
            entry.active = active
            el:setState(entry.internalState, active)
            if entry.rule.name then el:setState(entry.rule.name, active) end
        end
        return self
    end

    function controller:destroy()
        local el = self.element
        if not el then return end
        if self.handler then el:off("layout", self.handler) end
        for i = 1, #self.rules do
            local entry = self.rules[i]
            el:setState(entry.internalState, false)
            if entry.rule.name then el:setState(entry.rule.name, false) end
        end
        if rawget(el, "_responsiveController") == self then
            rawset(el, "_responsiveController", nil)
        end
        self.element = nil
    end

    controller.handler = function() controller:refresh() end
    element:on("layout", controller.handler)
    rawset(element, "_responsiveController", controller)
    controller:refresh()
    return controller
end

function Builder:_sync()
    responsive.apply(self.element, self.rules, { exclusive = true })
    return self
end

--- Starts the next first-match responsive rule.
---@param condition string|function Comparison such as "parent.width < 20"
---@return ResponsiveBuilder builder
function Builder:when(condition)
    if self.finished then
        error("Basalt responsive: otherwise() must be the final rule", 2)
    end
    if self.pending then
        error("Basalt responsive: call apply() before the next when()", 2)
    end
    self.pending = { when = compileCondition(condition) }
    return self
end

--- Assigns properties to the preceding when() rule.
---@param props table Responsive property overrides
---@return ResponsiveBuilder builder
function Builder:apply(props)
    if not self.pending then
        error("Basalt responsive: apply() requires a preceding when()", 2)
    end
    if type(props) ~= "table" then
        error("Basalt responsive: apply() expects a property table", 2)
    end
    self.pending.props = props
    self.rules[#self.rules + 1] = self.pending
    self.pending = nil
    return self:_sync()
end

--- Adds the fallback rule, installs the finished rules and returns the element.
---@param props table Responsive property overrides
---@return Element element
function Builder:otherwise(props)
    if self.pending then
        error("Basalt responsive: call apply() before otherwise()", 2)
    end
    if self.finished then
        error("Basalt responsive: otherwise() can only be used once", 2)
    end
    if type(props) ~= "table" then
        error("Basalt responsive: otherwise() expects a property table", 2)
    end
    self.rules[#self.rules + 1] = { props = props }
    self.finished = true
    self:_sync()
    return self.element
end

--- Installs rules without an otherwise() fallback and returns the element.
---@return Element element
function Builder:done()
    if self.pending then
        error("Basalt responsive: call apply() before done()", 2)
    end
    self:_sync()
    return self.element
end

--- Creates a first-match responsive rule builder for an element.
---@param element Element Target element
---@return ResponsiveBuilder builder
function responsive.builder(element)
    if not element.getChildren then
        error("Basalt responsive: target must be a container", 2)
    end
    return setmetatable({ element = element, rules = {} }, Builder)
end

--- Returns the responsive controller currently attached to an element.
---@param element Element Target element
---@return table|nil controller
function responsive.get(element)
    return rawget(element, "_responsiveController")
end

--- Fluent shortcut for responsive.apply().
---@param rules table[] Responsive rules
---@return self
function Element:setResponsive(rules)
    responsive.apply(self, rules)
    return self
end

--- Starts a fluent first-match responsive rule builder.
---@return ResponsiveBuilder builder
---@usage panel:responsive():when("parent.width < 30"):apply({ width = 10 }):otherwise({ width = 20 })
function Element:responsive()
    return responsive.builder(self)
end

--- Removes responsive rules and their temporary states/styles.
---@return self
function Element:clearResponsive()
    local controller = rawget(self, "_responsiveController")
    if controller then controller:destroy() end
    return self
end

return responsive

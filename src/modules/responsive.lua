-- Optional responsive breakpoints built on element states and layout hooks.
--
-- local responsive = basalt.use("responsive")
-- responsive.apply(panel, {
--   { name = "compact", maxWidth = 30,
--     props = { direction = "column" } },
--   { name = "wide", minWidth = 31,
--     props = { direction = "row" } },
-- })

local require = ...
local Element = require("core/element")

local responsive = {}

local function matches(rule, element, width, height)
    if rule.minWidth and width < rule.minWidth then return false end
    if rule.maxWidth and width > rule.maxWidth then return false end
    if rule.minHeight and height < rule.minHeight then return false end
    if rule.maxHeight and height > rule.maxHeight then return false end
    if rule.when and not rule.when(element, width, height) then return false end
    return true
end

function responsive.apply(element, rules)
    if type(rules) ~= "table" then
        error("Basalt 2.5 responsive: rules must be a table", 2)
    end
    if not element.getChildren then
        error("Basalt 2.5 responsive: target must be a container", 2)
    end

    local old = rawget(element, "_responsiveController")
    if old then old:destroy() end

    local prepared, names = {}, {}
    for i = 1, #rules do
        local rule = rules[i]
        if type(rule) ~= "table" then
            error("Basalt 2.5 responsive: rule " .. i .. " must be a table", 2)
        end
        if rule.when ~= nil and type(rule.when) ~= "function" then
            error("Basalt 2.5 responsive: rule.when must be a function", 2)
        end
        if rule.props ~= nil and type(rule.props) ~= "table" then
            error("Basalt 2.5 responsive: rule.props must be a table", 2)
        end
        if rule.name then
            if type(rule.name) ~= "string" or rule.name == "" then
                error("Basalt 2.5 responsive: rule.name must be a non-empty string", 2)
            end
            if names[rule.name] then
                error("Basalt 2.5 responsive: duplicate state name '" .. rule.name .. "'", 2)
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

    local controller = { element = element, rules = prepared }

    function controller:refresh()
        local el = self.element
        local width, height = el.width, el.height
        for i = 1, #self.rules do
            local entry = self.rules[i]
            local active = matches(entry.rule, el, width, height)
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

function responsive.get(element)
    return rawget(element, "_responsiveController")
end

function Element:setResponsive(rules)
    responsive.apply(self, rules)
    return self
end

function Element:clearResponsive()
    local controller = rawget(self, "_responsiveController")
    if controller then controller:destroy() end
    return self
end

return responsive

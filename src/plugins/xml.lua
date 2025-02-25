local errorManager = require("errorManager")

local function parseTag(str)
    local tag = {
        attributes = {}
    }
    tag.name = str:match("<(%w+)")
    for k,v in str:gmatch('%s(%w+)="([^"]-)"') do
        tag.attributes[k] = v
    end
    return tag
end

local function parseXML(self, xmlString)
    local stack = {}
    local root = {children = {}}
    local current = root
    local inCDATA = false
    local cdataContent = ""

    for line in xmlString:gmatch("[^\r\n]+") do
        line = line:match("^%s*(.-)%s*$")

        if line:match("^<!%[CDATA%[") then
            inCDATA = true
            cdataContent = ""
        elseif line:match("%]%]>$") and inCDATA then
            inCDATA = false
            current.content = cdataContent
        elseif inCDATA then
            cdataContent = cdataContent .. line .. "\n"
        elseif line:match("^<[^/]") then
            local tag = parseTag(line)
            tag.children = {}
            tag.content = ""
            table.insert(current.children, tag)

            if not line:match("/>$") then
                table.insert(stack, current)
                current = tag
            end
        elseif line:match("^</") then
            current = table.remove(stack)
        end
    end
    return root
end

local function evaluateExpression(expr, scope)
    if not expr:match("^%${.*}$") then
        return expr:gsub("%${(.-)}", function(e)
            local env = setmetatable({}, {__index = function(_, k)
                return scope and scope[k] or _ENV[k]
            end})

            local func, err = load("return " .. e, "expression", "t", env)
            if not func then
                errorManager.error("Failed to parse expression: " .. err)
            end
            return tostring(func())
        end)
    end

    expr = expr:match("^%${(.*)}$")
    local env = setmetatable({}, {__index = function(_, k)
        return scope and scope[k] or _ENV[k]
    end})

    local func, err = load("return " .. expr, "expression", "t", env)
    if not func then
        errorManager.error("Failed to parse expression: " .. err)
    end
    return func()
end

local function convertValue(value, propertyType, scope)
    if propertyType == "string" and type(value) == "string" then
        if value:find("${") then
            return evaluateExpression(value, scope)
        end
    end

    if type(value) == "string" and value:match("^%${.*}$") then
        return evaluateExpression(value, scope)
    end

    if propertyType == "number" then
        if(tonumber(value) == nil) then
            return value
        end
        return tonumber(value)
    elseif propertyType == "boolean" then
        return value == "true"
    elseif propertyType == "color" then
        return colors[value]
    elseif propertyType == "table" then
        local env = setmetatable({}, { __index = _ENV })
        local func = load("return "..value, nil, "t", env)
        if func then
            return func()
        end
    end
    return value
end

local function handleEvent(node, element, scope)
    for attr, value in pairs(node.attributes) do
        if attr:match("^on%u") then
            local eventName = attr:sub(3,3):lower() .. attr:sub(4)
            if scope[value] then
                element["on"..eventName:sub(1,1):upper()..eventName:sub(2)](element, scope[value])
            end
        end
    end

    for _, child in ipairs(node.children or {}) do
        if child.name and child.name:match("^on%u") then
            local eventName = child.name:sub(3,3):lower() .. child.name:sub(4)

            if child.content then
                local code = child.content:gsub("^%s+", ""):gsub("%s+$", "")

                local func, err = load(string.format([[
                    return %s
                ]], code), "event", "t", scope)

                if err then
                    errorManager.error("Failed to parse event: " .. err)
                elseif func then
                    element["on"..eventName:sub(1,1):upper()..eventName:sub(2)](element, func())
                end
            end
        end
    end
end

--- The XML plugin provides XML parsing and UI creation from XML markup
---@class BaseElement
local BaseElement = {}

--- Creates an element from an XML node
--- @shortDescription Creates element from XML node
--- @param self BaseElement The element instance
--- @param node table The XML node to create from
--- @return BaseElement self The element instance
function BaseElement:fromXML(node)
    for attr, value in pairs(node.attributes) do
        local config = self:getPropertyConfig(attr)
        if config then
            local convertedValue = convertValue(value, config.type)
            self.set(attr, convertedValue)
        end
    end
    return self
end

---@class Container
local Container = {}

--- Loads and creates UI elements from XML content
--- @shortDescription Loads UI from XML string
--- @param self Container The container to load into
--- @param content string The XML content to parse
--- @param scope? table Optional scope for variable resolution
--- @return Container self The container instance
--- @usage
--- local xml = [[
---   <Frame>
---     <Button name="myButton" x="5" y="5"/>
---   </Frame>
--- ]]
--- container:loadXML(xml)
function Container:loadXML(content, scope)
    local tree = parseXML(self, content)

    local function createElements(nodes, parent, scope)
        for _, node in ipairs(nodes.children) do
            if not node.name:match("^on") then
                local elementType = node.name:sub(1,1):upper() .. node.name:sub(2)
                local element = parent["add"..elementType](parent, node.attributes.name)

                for attr, value in pairs(node.attributes) do
                    local config = element:getPropertyConfig(attr)
                    if config then
                        local convertedValue = convertValue(value, config.type, scope)
                        element.set(attr, convertedValue)
                    end
                end

                handleEvent(node, element, scope)

                if #node.children > 0 then
                    createElements(node, element, scope)
                end
            end
        end
    end

    createElements(tree, self, scope)
    return self
end

return {
    BaseElement = BaseElement,
    Container = Container
}


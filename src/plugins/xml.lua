local errorManager = require("errorManager")

local XMLParser = {}
local TokenType = {
    TAG_OPEN = "TAG_OPEN",
    TAG_CLOSE = "TAG_CLOSE",
    TAG_SELF_CLOSE = "TAG_SELF_CLOSE",
    ATTRIBUTE = "ATTRIBUTE",
    TEXT = "TEXT",
    CDATA = "CDATA",
    COMMENT = "COMMENT"
}

local function tokenize(xml)
    local tokens = {}
    local position = 1
    local lineNumber = 1

    while position <= #xml do
        local char = xml:sub(position, position)

        if char:match("%s") then
            position = position + 1
        elseif xml:sub(position, position + 8) == "<![CDATA[" then
            local endPos = xml:find("]]>", position + 9)
            if not endPos then errorManager.error("Unclosed CDATA section") end
            table.insert(tokens, {
                type = TokenType.CDATA,
                value = xml:sub(position + 9, endPos - 1)
            })
            position = endPos + 3
        elseif xml:sub(position, position + 3) == "<!--" then
            local endPos = xml:find("-->", position + 4)
            if not endPos then errorManager.error("Unclosed comment") end
            table.insert(tokens, {
                type = TokenType.COMMENT,
                value = xml:sub(position + 4, endPos - 1)
            })
            position = endPos + 3
        elseif char == "<" then
            if xml:sub(position + 1, position + 1) == "/" then
                local endPos = xml:find(">", position)
                if not endPos then errorManager.error("Unclosed tag") end
                table.insert(tokens, {
                    type = TokenType.TAG_CLOSE,
                    value = xml:sub(position + 2, endPos - 1):match("^%s*(.-)%s*$")
                })
                position = endPos + 1
            else
                local tagContent = ""
                position = position + 1
                local selfClosing = false

                while position <= #xml do
                    char = xml:sub(position, position)
                    if char == ">" then
                        table.insert(tokens, {
                            type = selfClosing and TokenType.TAG_SELF_CLOSE or TokenType.TAG_OPEN,
                            value = tagContent:match("^%s*(.-)%s*$")
                        })
                        position = position + 1
                        break
                    elseif char == "/" and xml:sub(position + 1, position + 1) == ">" then

                        table.insert(tokens, {
                            type = TokenType.TAG_SELF_CLOSE,
                            value = tagContent:match("^%s*(.-)%s*$")
                        })
                        position = position + 2
                        break
                    elseif char == "/" and xml:sub(position - 1, position - 1):match("%s") then

                        selfClosing = true
                    else
                        tagContent = tagContent .. char
                    end
                    position = position + 1
                end
            end
        else
            local text = ""
            while position <= #xml and xml:sub(position, position) ~= "<" do
                text = text .. xml:sub(position, position)
                position = position + 1
            end
            if text:match("%S") then
                table.insert(tokens, {
                    type = TokenType.TEXT,
                    value = text:match("^%s*(.-)%s*$")
                })
            end
        end

        if char == "\n" then
            lineNumber = lineNumber + 1
        end
    end
    return tokens
end

local function parse(tokens)
    local root = {
        name = "root",
        children = {},
        attributes = {}
    }
    local stack = {root}
    local current = root

    local i = 1
    while i <= #tokens do
        local token = tokens[i]

        if token.type == TokenType.TAG_OPEN then
            local tagName, attributes = token.value:match("(%S+)(.*)")
            local node = {
                name = tagName,
                attributes = {},
                children = {},
                parent = current,
                line = token.line
            }

            for key, value in attributes:gmatch('%s(%w+)="([^"]-)"') do
                node.attributes[key] = value
            end

            table.insert(current.children, node)
            table.insert(stack, node)
            current = node

        elseif token.type == TokenType.TAG_SELF_CLOSE then

            local tagName, attributes = token.value:match("(%S+)(.*)")
            local node = {
                name = tagName,
                attributes = {},
                children = {},
                parent = current,
                line = token.line
            }

            for key, value in attributes:gmatch('%s(%w+)="([^"]-)"') do
                node.attributes[key] = value
            end

            table.insert(current.children, node)

        elseif token.type == TokenType.TAG_CLOSE then
            if current.name ~= token.value then
                errorManager.error(string.format("Mismatched closing tag: expected </%s>, got </%s>",
                    current.name, token.value))
            end
            table.remove(stack)
            current = stack[#stack]

        elseif token.type == TokenType.TEXT then
            table.insert(current.children, {
                name = "#text",
                value = token.value,
                line = token.line
            })

        elseif token.type == TokenType.CDATA then
            table.insert(current.children, {
                name = "#cdata",
                value = token.value,
                line = token.line
            })

        elseif token.type == TokenType.COMMENT then
            table.insert(current.children, {
                name = "#comment",
                value = token.value,
                line = token.line
            })
        end

        i = i + 1
    end

    return root
end

function XMLParser.parse(xmlString)
    local tokens = tokenize(xmlString)
    return parse(tokens)
end

local function evaluateExpression(expr, scope)
    if not expr then return expr end

    if expr:match("^%${.*}$") then
        local inner = expr:match("^%${(.*)}$")
        if inner:match("^[%w_]+$") then
            if scope and scope[inner] then
                return scope[inner]
            else
                errorManager.error(string.format('Variable "%s" not found in scope', inner))
                return expr
            end
        end

        local env = setmetatable({}, {
            __index = function(_, k)
                if scope and scope[k] then
                    return scope[k]
                elseif _ENV[k] then
                    return _ENV[k]
                else
                    error(string.format('Variable "%s" not found in scope', k))
                end
            end
        })

        local func, err = load("return " .. inner, "expression", "t", env)
        if not func then
            errorManager.error("Failed to parse expression: " .. err)
            return expr
        end

        local ok, result = pcall(func)
        if not ok then
            errorManager.error("Failed to evaluate expression: " .. result)
            return expr
        end

        return result
    end

    return expr:gsub("%${([^}]+)}", function(e)
        if e:match("^[%w_]+$") then
            if scope and scope[e] then
                return tostring(scope[e])
            else
                errorManager.error(string.format('Variable "%s" not found in scope', e))
                return e
            end
        end
        local env = setmetatable({}, {__index = function(_, k)
            return scope and scope[k] or _ENV[k]
        end})
        local func, err = load("return " .. e, "expression", "t", env)
        if not func then
            errorManager.error("Failed to parse expression: " .. err)
            return e
        end
        return tostring(func())
    end)
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

local actionHandlers = {
    setProperty = function(node, element, scope)
        return function(...)
            local target = node.attributes.target or "self"
            local targetElement

            if target == "self" then
                targetElement = element
            elseif target == "parent" then
                targetElement = element.parent
            else
                targetElement = element:getBaseFrame():getChild(target)
            end

            if not targetElement then
                errorManager.error(string.format('Target "%s" not found', target))
                return
            end

            local property = node.attributes.property
            local propertyConfig = targetElement:getPropertyConfig(property)
            if not propertyConfig then
                errorManager.error(string.format('Unknown property "%s"', property))
                return
            end

            local value = convertValue(node.attributes.value, propertyConfig.type, scope)
            targetElement.set(property, value)
        end
    end,

    execute = function(node, element, scope)
        return function(...)
            local funcName = node.attributes["function"]
            if not scope[funcName] then
                errorManager.error(string.format('Function "%s" not found in scope', funcName))
                return
            end
            scope[funcName](element, ...)
        end
    end,

    setValue = function(node, element, scope)
        return function(...)
            local name = node.attributes.name
            local value = convertValue(node.attributes.value, "string", scope)
            scope[name] = value
        end
    end
}

local eventParameters = {
    onClick = {"self", "button", "x", "y"},
    onScroll = {"self", "direction", "x", "y"},
    onDrag = {"self", "button", "x", "y"},
    onKey = {"self", "key"},
    onChar = {"self", "char"},
    onKeyUp = {"self", "key"},

}

local function handleEvent(node, element, scope)
    local isEventNode = node.name:match("^on%u")
    if not isEventNode then return end

    local eventName = node.name:sub(3,3):lower() .. node.name:sub(4)
    local handlers = {}

    for _, child in ipairs(node.children or {}) do
        if child.name == "#cdata" then
            if not isEventNode then
                errorManager.error("CDATA blocks can only be used inside event tags")
                return
            end

            local eventName = node.name:sub(3)
            local params = eventParameters["on"..eventName] or {"self"}

            local paramString = table.concat(params, ", ")

            local codeTemplate = [[
                return function(%s)
                    %s
                end
            ]]

            local env = {}
            if scope then
                for k,v in pairs(scope) do
                    env[k] = v
                end
            end

            env.colors = colors
            env.term = term
            env.math = math

            local code = child.value:gsub("^%s+", ""):gsub("%s+$", "")
            local finalCode = string.format(codeTemplate, paramString, code)

            local func, err = load(finalCode, "event", "t", env)
            if err then
                errorManager.error("Failed to parse event: " .. err)
            elseif func then
                local eventName = node.name:sub(3,3):lower() .. node.name:sub(4)
                element["on"..eventName:sub(1,1):upper()..eventName:sub(2)](element, func())
            end
        elseif child.name ~= "#text" then
            local handler = actionHandlers[child.name]
            if not handler then
                errorManager.error(string.format('Unknown action tag "%s"', child.name))
                return
            end
            table.insert(handlers, handler(child, element, scope))
        end
    end

    if #handlers > 0 then
        element["on"..eventName:sub(1,1):upper()..eventName:sub(2)](element, function(...)
            for _, handler in ipairs(handlers) do
                handler(...)
            end
        end)
    end
end

local function parsePropertyTag(node, element, scope)
    local propertyConfig = element:getPropertyConfig(node.name)

    if propertyConfig then
        if propertyConfig.type == "table" then
            local tableData = {}

            for _, child in ipairs(node.children) do
                if child.name == "item" or child.name == "entry" then
                    local entry = {}

                    for attr, value in pairs(child.attributes) do
                        if(colors[value])then
                            entry[attr] = colors[value]
                        else
                            entry[attr] = convertValue(value, "string", scope)
                        end
                    end

                    for _, prop in ipairs(child.children) do
                        if prop.name ~= "#text" and prop.name ~= "#cdata" then
                            if prop.children and #prop.children > 0 then
                                local firstChild = prop.children[1]
                                if firstChild.name == "#text" then
                                    entry[prop.name] = convertValue(firstChild.value, "string", scope)
                                end
                            else
                                local subEntry = {}
                                for subAttr, subValue in pairs(prop.attributes) do
                                    subEntry[subAttr] = convertValue(subValue, "string", scope)
                                end
                                entry[prop.name] = next(subEntry) and subEntry or ""
                            end
                        end
                    end

                    table.insert(tableData, entry)
                end
            end

            element.set(node.name, tableData)
            return true
        else
            local textNode = node.children[1]
            if textNode and textNode.name == "#text" then
                element.set(node.name, convertValue(textNode.value, propertyConfig.type, scope))
                return true
            end
        end
    end
    return false
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
    scope = scope or {}
    local tree = XMLParser.parse(content)

    local function createElements(nodes, parent, scope)
        for _, node in ipairs(nodes.children) do
            if node.name:sub(1,1) ~= "#" then
                if node.name:match("^on") then
                    handleEvent(node, parent, scope)
                else
                    local handled = parsePropertyTag(node, parent, scope)

                    if not handled then
                        local elementType = node.name:sub(1,1):upper() .. node.name:sub(2)
                        local addMethod = "add"..elementType

                        if not parent[addMethod] then
                            local parentType = parent.get and parent.get("type") or "Unknown"
                            errorManager.error(string.format(
                                'Tag <%s> is not valid inside <%s>',
                                node.name, parentType:lower()
                            ))
                            return
                        end

                        local element = parent[addMethod](parent, node.attributes.name)

                        for attr, value in pairs(node.attributes) do
                            local config = element:getPropertyConfig(attr)
                            if config then
                                local convertedValue = convertValue(value, config.type, scope)
                                element.set(attr, convertedValue)
                            end
                        end

                        if #node.children > 0 then
                            createElements(node, element, scope)
                        end
                    end
                end
            end
        end
    end

    createElements(tree, self, scope)
    return self
end

return {
    Container = Container
}
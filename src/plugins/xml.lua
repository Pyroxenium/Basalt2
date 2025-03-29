local errorManager = require("errorManager")
local log = require("log")
local XMLNode = {
    new = function(tag)
        return {
            tag = tag,
            value = nil,
            attributes = {},
            children = {},

            addChild = function(self, child)
                table.insert(self.children, child)
            end,

            addAttribute = function(self, tag, value)
                self.attributes[tag] = value
            end
        }
    end
}

local parseAttributes = function(node, s)
    local _, _ = string.gsub(s, "(%w+)=([\"'])(.-)%2", function(attribute, _, value)
        node:addAttribute(attribute, "\"" .. value .. "\"")
    end)
    local _, _ = string.gsub(s, "(%w+)={(.-)}", function(attribute, expression)
        node:addAttribute(attribute, expression)
    end)
end

local XMLParser = {
    parseText = function(xmlText)
        local stack = {}
        local top = XMLNode.new()
        table.insert(stack, top)
        local ni, c, label, xarg, empty
        local i, j = 1, 1
        while true do
            ni, j, c, label, xarg, empty = string.find(xmlText, "<(%/?)([%w_:]+)(.-)(%/?)>", i)
            if not ni then break end
            local text = string.sub(xmlText, i, ni - 1);
            if not string.find(text, "^%s*$") then
                local lVal = (top.value or "") .. text
                stack[#stack].value = lVal
            end
            if empty == "/" then
                local lNode = XMLNode.new(label)
                parseAttributes(lNode, xarg)
                top:addChild(lNode)
            elseif c == "" then
                local lNode = XMLNode.new(label)
                parseAttributes(lNode, xarg)
                table.insert(stack, lNode)
                top = lNode
            else
                local toclose = table.remove(stack)

                top = stack[#stack]
                if #stack < 1 then
                    errorManager.error("XMLParser: nothing to close with " .. label)
                end
                if toclose.tag ~= label then
                    errorManager.error("XMLParser: trying to close " .. toclose.tag .. " with " .. label)
                end
                top:addChild(toclose)
            end
            i = j + 1
        end
        if #stack > 1 then
            error("XMLParser: unclosed " .. stack[#stack].tag)
        end
        return top.children
    end
}

local function findExpressions(text)
    local expressions = {}
    local lastIndex = 1

    while true do
        local startPos, endPos, expr = text:find("%${([^}]+)}", lastIndex)
        if not startPos then break end

        table.insert(expressions, {
            start = startPos,
            ending = endPos, 
            expression = expr,
            raw = text:sub(startPos, endPos)
        })

        lastIndex = endPos + 1
    end

    return expressions
end

local function convertValue(value, scope)
    if value:sub(1,1) == "\"" and value:sub(-1) == "\"" then
        value = value:sub(2, -2)
    end

    local expressions = findExpressions(value)

    for _, expr in ipairs(expressions) do
        local expression = expr.expression
        local startPos = expr.start - 1
        local endPos = expr.ending + 1

        if scope[expression] then
            value = value:sub(1, startPos) .. tostring(scope[expression]) .. value:sub(endPos)
        else
            errorManager.error("XMLParser: variable '" .. expression .. "' not found in scope")
        end
    end

    if value:match("^%s*<!%[CDATA%[.*%]%]>%s*$") then
        local cdata = value:match("<!%[CDATA%[(.*)%]%]>")
        local env = _ENV
        for k,v in pairs(scope) do
            env[k] = v
        end
        return load("return " .. cdata, nil, "bt", env)()
    end

    if value == "true" then
        return true
    elseif value == "false" then
        return false
    elseif colors[value] then
        return colors[value]
    elseif tonumber(value) then
        return tonumber(value)
    else
        return value
    end
end

local function createTableFromNode(node, scope)
    local list = {}

    for _, child in pairs(node.children) do
        if child.tag == "item" or child.tag == "entry" then
            local item = {}

            for attrName, attrValue in pairs(child.attributes) do
                item[attrName] = convertValue(attrValue, scope)
            end

            for _, subChild in pairs(child.children) do
                if subChild.value then
                    item[subChild.tag] = convertValue(subChild.value, scope)
                elseif #subChild.children > 0 then
                    item[subChild.tag] = createTableFromNode(subChild)
                end
            end

            table.insert(list, item)
        else
            if child.value then
                list[child.tag] = convertValue(child.value, scope)
            elseif #child.children > 0 then
                list[child.tag] = createTableFromNode(child)
            end
        end
    end

    return list
end

local BaseElement = {}

function BaseElement.setup(element)
    element.defineProperty(element, "customXML", {default = {attributes={},children={}}, type = "table"})
end

--- Generates this element from XML nodes
--- @shortDescription Generates this element from XML nodes
--- @param self BaseElement The element to generate from XML nodes
--- @param node table The XML nodes to generate from
--- @param scope table The scope to use
--- @return BaseElement self The element instance
function BaseElement:fromXML(node, scope)
    if(node.attributes)then
        for k, v in pairs(node.attributes) do
            if(self._properties[k])then
                self.set(k, convertValue(v, scope))
            elseif self[k] then
                if(k:sub(1,2)=="on")then
                    local val = v:gsub("\"", "")
                    if(scope[val])then
                        if(type(scope[val]) ~= "function")then
                            errorManager.error("XMLParser: variable '" .. val .. "' is not a function for element '" .. self:getType() .. "' "..k)
                        end
                        self[k](self, scope[val])
                    else
                        errorManager.error("XMLParser: variable '" .. val .. "' not found in scope")
                    end
                else
                    errorManager.error("XMLParser: property '" .. k .. "' not found in element '" .. self:getType() .. "'")
                end
            else
                local customXML = self.get("customXML")
                customXML.attributes[k] = convertValue(v, scope)
            end
        end
    end

    if(node.children)then
        for _, child in pairs(node.children) do
            if(self._properties[child.tag])then
                if(self._properties[child.tag].type == "table")then
                    self.set(child.tag, createTableFromNode(child, scope))
                else
                    self.set(child.tag, convertValue(child.value, scope))
                end
            else
                local args = {}
                if(child.children)then
                    for _, child in pairs(child.children) do
                        if(child.tag == "param")then
                            table.insert(args, convertValue(child.value, scope))
                        elseif (child.tag == "table")then
                            table.insert(args, createTableFromNode(child, scope))
                        end
                    end
                end

                if(self[child.tag])then
                    if(#args > 0)then
                        self[child.tag](self, table.unpack(args))
                    elseif(child.value)then
                        self[child.tag](self, convertValue(child.value, scope))
                    else
                        self[child.tag](self)
                    end
                else
                    local customXML = self.get("customXML")
                    child.value = convertValue(child.value, scope)
                    customXML.children[child.tag] = child
                end
            end
        end
    end
    return self
end

local Container = {}

--- Loads an XML string and parses it into the element
--- @shortDescription Loads an XML string and parses it into the element
--- @param self Container The element to load the XML into
--- @param content string The XML string to load
--- @param scope table The scope to use
--- @return Container self The element instance
function Container:loadXML(content, scope)
    scope = scope or {}
    local nodes = XMLParser.parseText(content)
    self:fromXML(nodes, scope)
    if(nodes)then
        for _, node in ipairs(nodes) do
            local capitalizedName = node.tag:sub(1,1):upper() .. node.tag:sub(2)
            if self["add"..capitalizedName] then
                local element = self["add"..capitalizedName](self)
                element:fromXML(node, scope)
            end
        end
    end
    return self
end

--- Generates this element from XML nodes
--- @shortDescription Generates this element from XML nodes
--- @param self Container The element to generate from XML nodes
--- @param nodes table The XML nodes to generate from
--- @param scope table The scope to use
--- @return Container self The element instance
function Container:fromXML(nodes, scope)
    BaseElement.fromXML(self, nodes, scope)
    if(nodes.children)then
        for _, node in ipairs(nodes.children) do
            local capitalizedName = node.tag:sub(1,1):upper() .. node.tag:sub(2)
            if self["add"..capitalizedName] then
                local element = self["add"..capitalizedName](self)
                element:fromXML(node, scope)
            end
        end
    end
    return self
end

return {
    API = XMLParser,
    Container = Container,
    BaseElement = BaseElement
}
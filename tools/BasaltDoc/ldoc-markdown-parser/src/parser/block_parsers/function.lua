local FunctionParser = {}

--- Check if a block represents a function
function FunctionParser.canParse(block)
    return block.context and block.context.type == "function"
end

--- Parse a complete function documentation block
function FunctionParser.parse(block)
    local functionDoc = {
        type = "function",
        name = block.context.name,
        shortDescription = nil,
        params = {},
        returns = {},
        visibility = "public", -- default
        context = block.context,
        content = {}
    }
    
    for _, line in ipairs(block.comments) do
        -- Parse shortDescription
        local shortDesc = line:match("^%-*%s*@shortDescription%s+(.*)$")
        if shortDesc then
            functionDoc.shortDescription = shortDesc
        
        -- Parse param
        elseif line:match("^%-*%s*@param") then
            local paramName, paramType, paramDesc = line:match("^%-*%s*@param%s+(%S+)%s+(%S+)%s+(.*)$")
            if paramName then
                table.insert(functionDoc.params, {
                    name = paramName,
                    type = paramType,
                    description = paramDesc or ""
                })
            end
        
        -- Parse return
        elseif line:match("^%-*%s*@return") then
            local returnType, returnName, returnDesc = line:match("^%-*%s*@return%s+(%S+)%s+(%S+)%s+(.*)$")
            if returnType then
                table.insert(functionDoc.returns, {
                    type = returnType,
                    name = returnName or "",
                    description = returnDesc or ""
                })
            end
        
        -- Parse visibility
        elseif line:match("^%-*%s*@private%s*$") then
            functionDoc.visibility = "private"
        elseif line:match("^%-*%s*@protected%s*$") then
            functionDoc.visibility = "protected"
        
        -- Regular content
        else
            table.insert(functionDoc.content, line)
        end
    end
    
    return functionDoc
end

return FunctionParser

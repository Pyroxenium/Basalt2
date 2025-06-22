local MarkdownGenerator = {}

--- Generate markdown for a block
function MarkdownGenerator.generateBlock(block, tags)
    if not block.codeContext then
        return MarkdownGenerator.generateStandaloneComment(tags)
    end
    
    if block.codeContext.type == "function" then
        return MarkdownGenerator.generateFunction(block.codeContext, tags)
    elseif block.codeContext.type == "class" then
        return MarkdownGenerator.generateClass(block.codeContext, tags)
    elseif block.codeContext.type == "variable" then
        return MarkdownGenerator.generateVariable(block.codeContext, tags)
    else
        return MarkdownGenerator.generateGeneric(block.codeContext, tags)
    end
end

--- Generate markdown for function
function MarkdownGenerator.generateFunction(context, tags)
    local md = {}
    
    table.insert(md, string.format("### %s", context.name))
    table.insert(md, "")
    
    if tags.shortDescription then
        table.insert(md, tags.shortDescription)
        table.insert(md, "")
    end
    
    if #tags.description > 0 then
        table.insert(md, table.concat(tags.description, " "))
        table.insert(md, "")
    end
    
    if #tags.params > 0 then
        table.insert(md, "**Parameters:**")
        for _, param in ipairs(tags.params) do
            table.insert(md, string.format("- `%s` (%s): %s", param.name, param.dataType, param.description))
        end
        table.insert(md, "")
    end
    
    if #tags.returns > 0 then
        table.insert(md, "**Returns:**")
        for _, ret in ipairs(tags.returns) do
            table.insert(md, string.format("- `%s` (%s): %s", ret.name, ret.dataType, ret.description))
        end
        table.insert(md, "")
    end
    
    if tags.visibility ~= "public" then
        table.insert(md, string.format("**Visibility:** %s", tags.visibility))
        table.insert(md, "")
    end
    
    return table.concat(md, "\n")
end

--- Generate markdown for class
function MarkdownGenerator.generateClass(context, tags)
    local md = {}
    
    table.insert(md, string.format("## Class: %s", context.name))
    if tags.class and tags.class.parent then
        table.insert(md, string.format("*Extends: %s*", tags.class.parent))
    end
    table.insert(md, "")
    
    if tags.shortDescription then
        table.insert(md, tags.shortDescription)
        table.insert(md, "")
    end
    
    if #tags.description > 0 then
        table.insert(md, table.concat(tags.description, " "))
        table.insert(md, "")
    end
    
    return table.concat(md, "\n")
end

--- Generate markdown for standalone comments or properties
function MarkdownGenerator.generateStandaloneComment(tags)
    local md = {}
    
    if #tags.properties > 0 then
        for _, prop in ipairs(tags.properties) do
            table.insert(md, string.format("**Property:** `%s` (%s) - %s", prop.name, prop.dataType, prop.description))
        end
        table.insert(md, "")
    end
    
    if #tags.description > 0 then
        table.insert(md, table.concat(tags.description, " "))
        table.insert(md, "")
    end
    
    return table.concat(md, "\n")
end

--- Generate markdown for variables
function MarkdownGenerator.generateVariable(context, tags)
    local md = {}
    
    table.insert(md, string.format("### %s", context.name))
    table.insert(md, "")
    
    if tags.shortDescription then
        table.insert(md, tags.shortDescription)
        table.insert(md, "")
    end
    
    if #tags.description > 0 then
        table.insert(md, table.concat(tags.description, " "))
        table.insert(md, "")
    end
    
    return table.concat(md, "\n")
end

--- Generate markdown for generic code
function MarkdownGenerator.generateGeneric(context, tags)
    local md = {}
    
    table.insert(md, string.format("### %s", context.name))
    table.insert(md, "")
    
    if tags.shortDescription then
        table.insert(md, tags.shortDescription)
        table.insert(md, "")
    end
    
    if #tags.description > 0 then
        table.insert(md, table.concat(tags.description, " "))
        table.insert(md, "")
    end
    
    return table.concat(md, "\n")
end

return MarkdownGenerator
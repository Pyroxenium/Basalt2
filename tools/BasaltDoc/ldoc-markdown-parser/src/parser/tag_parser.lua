local TagParser = {}

--- Parse all tags from a list of comment lines
function TagParser.parseAllTags(commentLines)
    local tags = {
        shortDescription = nil,
        description = {},
        params = {},
        returns = {},
        visibility = "public",
        properties = {},
        class = nil,
        other = {}
    }
    
    for _, line in ipairs(commentLines) do
        local parsed = TagParser.parseSingleLine(line)
        if parsed then
            TagParser.addToTags(tags, parsed)
        else
            -- Regular description line
            local desc = line:match("^%-*%s*(.+)$")
            if desc and not desc:match("^@") then
                table.insert(tags.description, desc)
            end
        end
    end
    
    return tags
end

--- Parse a single comment line for tags
function TagParser.parseSingleLine(line)
    -- @shortDescription
    local shortDesc = line:match("^%-*%s*@shortDescription%s+(.+)$")
    if shortDesc then
        return {type = "shortDescription", value = shortDesc}
    end
    
    -- @param name type description
    local paramName, paramType, paramDesc = line:match("^%-*%s*@param%s+(%S+)%s+(%S+)%s*(.*)$")
    if paramName then
        return {
            type = "param", 
            name = paramName, 
            dataType = paramType, 
            description = paramDesc or ""
        }
    end
    
    -- @return type name description
    local returnType, returnName, returnDesc = line:match("^%-*%s*@return%s+(%S+)%s+(%S+)%s*(.*)$")
    if returnType then
        return {
            type = "return", 
            dataType = returnType, 
            name = returnName or "", 
            description = returnDesc or ""
        }
    end
    
    -- @property name type description
    local propName, propType, propDesc = line:match("^%-*%s*@property%s+(%S+)%s+(%S+)%s*(.*)$")
    if propName then
        return {
            type = "property", 
            name = propName, 
            dataType = propType, 
            description = propDesc or ""
        }
    end
    
    -- @class name : parent
    local className, parentClass = line:match("^%-*%s*@class%s+(%S+)%s*:%s*(%S+)")
    if not className then
        className = line:match("^%-*%s*@class%s+(%S+)")
    end
    if className then
        return {
            type = "class", 
            name = className, 
            parent = parentClass or nil
        }
    end
    
    -- Visibility tags
    if line:match("^%-*%s*@private%s*$") then
        return {type = "visibility", value = "private"}
    end
    
    if line:match("^%-*%s*@protected%s*$") then
        return {type = "visibility", value = "protected"}
    end
    
    return nil
end

--- Add parsed tag to the tags collection
function TagParser.addToTags(tags, parsed)
    if parsed.type == "shortDescription" then
        tags.shortDescription = parsed.value
    elseif parsed.type == "param" then
        table.insert(tags.params, parsed)
    elseif parsed.type == "return" then
        table.insert(tags.returns, parsed)
    elseif parsed.type == "property" then
        table.insert(tags.properties, parsed)
    elseif parsed.type == "class" then
        tags.class = parsed
    elseif parsed.type == "visibility" then
        tags.visibility = parsed.value
    else
        table.insert(tags.other, parsed)
    end
end

return TagParser
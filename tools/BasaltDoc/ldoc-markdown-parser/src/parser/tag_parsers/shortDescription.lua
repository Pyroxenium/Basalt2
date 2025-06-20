local ShortDescriptionParser = {}

--- Parse @shortDescription tag
--- Example: --- @shortDescription Creates a new Button instance
function ShortDescriptionParser.parse(line)
    local pattern = "^%-*%s*@shortDescription%s+(.*)$"
    local description = line:match(pattern)
    
    if description then
        return {
            type = "shortDescription",
            description = description
        }
    end
    
    return nil
end

return ShortDescriptionParser

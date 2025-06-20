local PropertyParser = {}

--- Parse @property tag
--- Example: ---@property text string Button Button text
function PropertyParser.parse(line)
    local pattern = "^%-*%s*@property%s+(%S+)%s+(%S+)%s+(.*)$"
    local name, dataType, description = line:match(pattern)
    
    if name and dataType then
        return {
            type = "property",
            name = name,
            dataType = dataType,
            description = description or ""
        }
    end
    
    return nil
end

return PropertyParser

local helper = require("utils.helper")
local propertyParser = {}

function propertyParser.parse(annotations, line)
    local propLine = helper.findAnnotationLine(annotations, "property")
    if not propLine then return nil end
    local content = table.concat(annotations, " ")
    local name, type, default, desc = propLine:match("^%-%-%-?%s*@property%s*([%w_]+)%s+([%w_|%[%]]+)%s+([^%s]+)%s*(.*)")
    if not name then
        print("Warning: Could not parse @property annotation: " .. propLine)
        return nil
    end
    local prop = {
        type = "property",
        name = name,
        propType = type or "any",
        default = default or "nil",
        description = desc or ""
    }

    helper.applyAnnotations(annotations, prop, propertyParser.handlers)

    return prop
end

function propertyParser.setHandlers(handlers)
    propertyParser.handlers = handlers
end

return propertyParser

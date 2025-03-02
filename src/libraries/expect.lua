local errorManager = require("errorManager")

-- Simple type checking without stack traces
local function expect(position, value, expectedType)
    local valueType = type(value)

    if expectedType == "element" then
        if valueType == "table" and value.get("type") ~= nil then
            return true
        end
    end

    if expectedType == "color" then
        if valueType == "number" then
            return true
        end
        if valueType == "string" and colors[value] then
            return true
        end
    end

    if valueType ~= expectedType then
        errorManager.header = "Basalt Type Error"
        errorManager.error(string.format(
            "Bad argument #%d: expected %s, got %s",
            position,
            expectedType,
            valueType
        ))
    end

    return true
end

return expect
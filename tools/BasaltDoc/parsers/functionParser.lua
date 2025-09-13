local helper = require("utils.helper")
local functionParser = {}

function functionParser.parse(annotations, line)
    local funcName = line:match("function ([%w_%.]+:?[%w_]*)")
    if not funcName then
        print("Warning: Could not extract function name from line: " .. line)
        return nil
    end
    local f = {
        type = "function",
        name = funcName,
        description = nil,
        shortDescription = nil,
        params = {},
        returns = {},
        visibility = "public"
    }

    if functionParser.handlers then
        helper.applyAnnotations(annotations, f, functionParser.handlers)
    end

    if funcName:find(":") then
        f.name = funcName:match(":([%w_]+)")
    elseif funcName:find("%.") then
        f.name = funcName:match("%.([%w_]+)")
    else
        f.name = funcName
    end
    
    if line:match("function [%w_%.]+:") then
        f.static = false
    else
        f.static = true
    end

    return f
end

function functionParser.setHandlers(handlers)
    functionParser.handlers = handlers
end

return functionParser

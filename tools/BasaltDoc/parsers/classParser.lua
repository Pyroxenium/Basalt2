local helper = require("utils.helper")
local logger = require("utils.logger")
local classParser = {}

function classParser.parse(annotations, line)
    local classLine = helper.findAnnotationLine(annotations, "class")
    if not classLine then 
        return nil 
    end
    local name, extends = classLine:match("^%-%-%-?%s*@class%s*([%w_%.]+)%s*:?%s*([%w_%.]*)")

    local class = {
        type = "class",
        name = name,
        extends = extends ~= "" and extends or nil,
        description = nil,
        properties = {},
        events = {},
        functions = {},
        tableTypes = {},
        skip = false
    }

    if classParser.handlers then
        helper.applyAnnotations(annotations, class, classParser.handlers)
    end

    return class
end

function classParser.setHandlers(handlers)
    classParser.handlers = handlers
end

return classParser
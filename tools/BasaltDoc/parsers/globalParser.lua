local helper = require("utils.helper")
local logger = require("utils.logger")
local globalParser = {}

function globalParser.parse(annotations, line)
    local global = {
        description = nil
    }

    if globalParser.handlers then
        helper.applyAnnotations(annotations, global, globalParser.handlers)
    end
    return global
end

function globalParser.setHandlers(handlers)
    globalParser.handlers = handlers
end

return globalParser


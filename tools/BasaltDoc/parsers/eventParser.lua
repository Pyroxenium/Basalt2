local helper = require("utils.helper")
local eventParser = {}

function eventParser.parse(annotations, line)
    local eventLine = helper.findAnnotationLine(annotations, "event")
    if not eventLine then return nil end
    local content = table.concat(annotations, " ")
    local name, params, desc = eventLine:match("^%-%-%-?%s*@event%s*([%w_]+)%s*({[^}]*})%s*(.*)")

    if not name then
        name, desc = eventLine:match("^%-%-%-?%s*@event%s*([%w_]+)%s+(.*)")
        params = "{}"
    end

    if not name then
        print("Warning: Could not parse @event annotation: " .. eventLine)
        return nil
    end

    local evt = {
        type = "event",
        name = name,
        params = params or "{}",
        description = desc or ""
    }

    helper.applyAnnotations(annotations, evt, eventParser.handlers)

    return evt
end

function eventParser.setHandlers(handlers)
    eventParser.handlers = handlers
end

return eventParser


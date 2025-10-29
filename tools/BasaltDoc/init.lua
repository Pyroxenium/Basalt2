local BasaltDoc = {}

local defaultPath = package.path
if fs then
    local args = {...}
    local docsPath = fs.getDir(args[2])
    local format = "path/?.lua;path/?/init.lua;"
    local main = format:gsub("path", docsPath)
    package.path = main.."rom/?;"..defaultPath
else
    local format = "path/?.lua;path/?/init.lua;"
    local main = format:gsub("path", "tools/BasaltDoc")
    package.path = main .. ";" .. defaultPath
end

local classParser = require("parsers.classParser")

local functionParser = require("parsers.functionParser")

local propertyParser = require("parsers.propertyParser")

local eventParser = require("parsers.eventParser")

local globalParser = require("parsers.globalParser")

local helper = require("utils.helper")

local markdownGenerator = require("utils.markdownGenerator")

BasaltDoc.annotationHandlers = {}

function BasaltDoc.registerAnnotation(tag, handler)
    BasaltDoc.annotationHandlers[tag] = handler
end

----------------------------------------------------------------
-- Standard Annotation Handlers
----------------------------------------------------------------
BasaltDoc.registerAnnotation("@param", function(target, args)
    if target.type == "function" then
        local paramName, optional, paramType, paramDesc = args:match("([%w_]+)(%??)[%s]*([%w_|]+)[%s]*(.*)")
        if paramName then
            table.insert(target.params, {
                name = paramName, 
                type = paramType or "any", 
                description = paramDesc or "",
                optional = optional == "?"
            })
        end
    end
end)

BasaltDoc.registerAnnotation("@return", function(target, args)
    if target.type == "function" then
        local returnType, returnName, returnDesc = args:match("([%w_|]+)[%s]+([%w_]+)[%s]+(.*)")
        if returnType then
            table.insert(target.returns, {
                type = returnType,
                name = returnName or "",
                description = returnDesc or ""
            })
        else
            table.insert(target.returns, {
                type = args:match("([%w_|]+)") or "any",
                name = "",
                description = args:match("[%w_|]+[%s]+(.*)" ) or ""
            })
        end
    end
end)

BasaltDoc.registerAnnotation("@returns", function(target, args)
    BasaltDoc.annotationHandlers["@return"](target, args)
end)

BasaltDoc.registerAnnotation("@usage", function(target, args)
    if not target.usage then target.usage = {} end
    table.insert(target.usage, args)
end)

BasaltDoc.registerAnnotation("@example", function(target, args)
    if not target.examples then target.examples = {} end
    table.insert(target.examples, args)
end)

BasaltDoc.registerAnnotation("@see", function(target, args)
    if not target.see then target.see = {} end
    table.insert(target.see, args)
end)

BasaltDoc.registerAnnotation("@since", function(target, args)
    target.since = args
end)

BasaltDoc.registerAnnotation("@deprecated", function(target, args)
    target.deprecated = args ~= "" and args or true
end)

BasaltDoc.registerAnnotation("@private", function(target, args)
    target.visibility = "private"
end)

BasaltDoc.registerAnnotation("@protected", function(target, args)
    target.visibility = "protected"
end)

BasaltDoc.registerAnnotation("@configDescription", function(target, args)
    if target.type == "class" then
        target.configDescription = args
    end
end)

BasaltDoc.registerAnnotation("@shortDescription", function(target, args)
    if target.type == "function" then
        target.shortDescription = args
    end
end)

BasaltDoc.registerAnnotation("@run", function(target, args)
    if not target.run then target.run = {} end
    table.insert(target.run, args)
end)

BasaltDoc.registerAnnotation("@title", function(target, args)
    target.title = args
end)

BasaltDoc.registerAnnotation("@skipFunctionList", function(target, args)
    target.skipFunctionList = true
end)

BasaltDoc.registerAnnotation("@skipPropertyList", function(target, args)
    target.skipPropertyList = true
end)

BasaltDoc.registerAnnotation("@skipDetailedFunctionList", function(target, args)
    target.skipDetailedFunctionList = true
end)

BasaltDoc.registerAnnotation("@skip", function(target, args)
    target.skip = true
end)

BasaltDoc.registerAnnotation("@note", function(target, args)
    if not target.notes then target.notes = {} end
    table.insert(target.notes, args)
end)

BasaltDoc.registerAnnotation("@globalDescription", function(target, args)
    if args and args ~= "" then
        target.description = args
    end
end)

BasaltDoc.registerAnnotation("@tableType", function(target, args)
    if not target.tableTypes then target.tableTypes = {} end
    local tableName = args:match("^%s*(%S+)")
    if tableName then
        target._currentTableType = {
            name = tableName,
            fields = {}
        }
        table.insert(target.tableTypes, target._currentTableType)
    end
end)

BasaltDoc.registerAnnotation("@tableField", function(target, args)
    if target._currentTableType then
        local fieldName, fieldType, fieldDesc = args:match("^%s*([%w_]+)%s+([%w_|]+)%s+(.*)")
        if fieldName and fieldType then
            table.insert(target._currentTableType.fields, {
                name = fieldName,
                type = fieldType,
                description = fieldDesc or ""
            })
        end
    end
end)

if classParser then classParser.setHandlers(BasaltDoc.annotationHandlers) end
if functionParser then functionParser.setHandlers(BasaltDoc.annotationHandlers) end
if propertyParser then propertyParser.setHandlers(BasaltDoc.annotationHandlers) end
if eventParser then eventParser.setHandlers(BasaltDoc.annotationHandlers) end
if globalParser then globalParser.setHandlers(BasaltDoc.annotationHandlers) end

----------------------------------------------------------------
-- Main Parser
----------------------------------------------------------------
function BasaltDoc.parse(content)
    local ast = { classes = {}, global = nil }

    local rawLines = {}
    for line in content:gmatch("([^\r\n]*)\r?\n?") do
        table.insert(rawLines, line)
    end

    local lines = {}
    local i = 1
    while i <= #rawLines do
        local line = rawLines[i]
        if line:match("@globalDescription") then
            local globalAnnotations = {line}
            i = i + 1
            if i <= #rawLines and rawLines[i]:match("%-%-?%[%[") then
                i = i + 1
                while i <= #rawLines and not rawLines[i]:match("%]%]") do
                    table.insert(globalAnnotations, "--- " .. rawLines[i])
                    i = i + 1
                end
                if i <= #rawLines and rawLines[i]:match("%]%]") then
                    i = i + 1
                end
                if #globalAnnotations > 0 and globalParser then
                    local global = globalParser.parse(globalAnnotations, table.concat(globalAnnotations, "\n"))
                    ast.global = global
                end
            end
        else
            table.insert(lines, line)
            i = i + 1
        end
    end

    local annotationBuffer = {}
    local currentClass = nil
    local firstTag = nil
    local pendingTableTypes = {}

    local blockStartTags = {
        ["@class"] = true,
        ["@property"] = true, 
        ["@event"] = true,
        ["@skip"] = true,
        ["@tableType"] = true
    }

    local i = 1
    while i <= #lines do
        local line = lines[i]
        if line:match("^%-%-%-?") then
            table.insert(annotationBuffer, line)
            if not firstTag then
                local tag = line:match("@%S+")
                if tag and blockStartTags[tag] then
                    firstTag = tag
                end
            end
            i = i + 1
        elseif #annotationBuffer > 0 then
            local nextLine = lines[i]
            local skip = false
            if nextLine and nextLine:match("^function") and currentClass and functionParser then
                local fn = functionParser.parse(annotationBuffer, nextLine)
                if fn then
                    table.insert(currentClass.functions, fn)
                end
                skip = true
            elseif firstTag then
                if firstTag == "@class" and classParser then
                    local class = classParser.parse(annotationBuffer, table.concat(annotationBuffer, "\n"))
                    if class and not class.skip then
                        if #pendingTableTypes > 0 then
                            for _, tableType in ipairs(pendingTableTypes) do
                                table.insert(class.tableTypes, tableType)
                            end
                            pendingTableTypes = {}
                        end
                        table.insert(ast.classes, class)
                        currentClass = class
                    end
                elseif firstTag == "@tableType" then
                    local tempTarget = {tableTypes = {}}
                    if classParser and classParser.handlers then
                        helper.applyAnnotations(annotationBuffer, tempTarget, classParser.handlers)
                    end
                    if tempTarget.tableTypes and #tempTarget.tableTypes > 0 then
                        for _, tt in ipairs(tempTarget.tableTypes) do
                            table.insert(pendingTableTypes, tt)
                        end
                    end
                elseif firstTag == "@property" and currentClass and propertyParser then
                    local prop = propertyParser.parse(annotationBuffer, table.concat(annotationBuffer, "\n"))
                    if prop then
                        table.insert(currentClass.properties, prop)
                    end
                elseif firstTag == "@event" and currentClass and eventParser then
                    local evt = eventParser.parse(annotationBuffer, table.concat(annotationBuffer, "\n"))
                    if evt then
                        table.insert(currentClass.events, evt)
                    end
                end
            end
            if skip then i = i + 1 end
            annotationBuffer = {}
            firstTag = nil
            i = i + 1
        else
            i = i + 1
        end
    end

    if #annotationBuffer > 0 and firstTag then
        if firstTag == "@class" and classParser then
            local class = classParser.parse(annotationBuffer, table.concat(annotationBuffer, "\n"))
            if class and not class.skip then
                table.insert(ast.classes, class)
                currentClass = class
            end
        end
    end

    return ast
end

function BasaltDoc.generateMarkdown(ast)
    if markdownGenerator then
        local result = markdownGenerator.generate(ast)
        return result
    else
        return {}
    end
end

package.path = defaultPath

return BasaltDoc
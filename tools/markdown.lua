local markdown = {
    blocks = {}
}

local commentTypes = {
    "module",
    "class",
    "param",
    "return",
    "usage",
    "function",
    "local",
    "shortDescription",
    "property",
    "combinedProperty",
    "event",
    "private",
    "protected",
    "field",
    "vararg",
    "splitClass",
    "title"
}

local function extractComment(line)
    local tripleContent = line:match("^%-%-%-%s*(.*)")
    if tripleContent then
        return tripleContent, true
    end

    local doubleContent = line:match("^%-%- %s*(.*)")
    if doubleContent then
        return doubleContent, false
    end

    return nil, false
end

local function getCommentType(comment)
    for _, pattern in pairs(commentTypes) do
        if comment:match("^@"..pattern) then
            local content = comment:sub(#pattern + 2):gsub("^%s*", "")
            return pattern, content
        end
    end

    return "desc", comment
end

local function hasBlockContent(block)
    for key, _ in pairs(block) do
        if(key~="type")and(key~="desc")then
            return true
        end
    end
    if(#block.desc > 0)then
        return true
    end

    return false
end

local function getFunctionName(line)
    local pattern = "^function%s+([%w_%.:]-)%s*%("
    return line:match(pattern)
end

function markdown.parse(content, file)
    local blocks = {}
    local properties = {}
    local combinedProperties = {}
    local events = {}
    local fields = {}
    local currentBlock = {type = "comment", desc = {}, file = file}
    local skipNextFunction = false
    local currentClass = "None"
    local splitNextClass = false

    for line in content:gsub("\r\n", "\n"):gmatch("([^\n]*)\n?") do
        if line:match("^%s*$") or line == "" then
            if hasBlockContent(currentBlock) then
                table.insert(blocks, currentBlock)
                currentBlock = {type = "comment", desc = {}, file = file}
            end
        else
            local comment, isDoc = extractComment(line)
            if comment then
                local commentType, value = getCommentType(comment)
                if(commentType == "desc") then
                    currentBlock.usageIsActive = false
                    table.insert(currentBlock.desc, value)
                elseif(commentType == "private")then
                    skipNextFunction = true
                elseif(commentType == "splitClass")then
                    splitNextClass = true
                elseif(commentType == "protected")then
                    currentBlock.protected = true
                elseif(commentType == "title")then
                    currentBlock.title = value
                    currentBlock.type = "title"
                else
                    if(commentType == "module")then
                        currentBlock.usageIsActive = false
                        currentBlock.type = "module"
                        currentBlock.moduleName = value:match("([^%s]+)")
                    elseif(commentType == "class")then
                        currentBlock.usageIsActive = false
                        currentBlock.type = "class"
                        currentBlock.className = value
                        currentBlock.splitClass = splitNextClass
                        splitNextClass = false
                        currentClass = value
                        fields[currentClass] = {}
                        properties[currentClass] = {}
                        combinedProperties[currentClass] = {}
                        events[currentClass] = {}
                    end
                    if(commentType == "usage")then
                        currentBlock.usage = currentBlock.usage or {}
                        if(currentBlock.usageIsActive~=true)then
                            currentBlock.usageIsActive = true
                            table.insert(currentBlock.usage, {line=#currentBlock.desc+1, content={value}})
                        else
                            table.insert(currentBlock.usage[#currentBlock.usage].content, value)
                        end
                    elseif(commentType == "shortDescription")then
                        currentBlock.usageIsActive = false
                        currentBlock.shortDescription = value
                    elseif(commentType == "property")then
                        currentBlock = {type = "comment", desc = {}}
                        table.insert(properties[currentClass], value)
                    elseif(commentType == "combinedProperty")then
                        currentBlock = {type = "comment", desc = {}}
                        table.insert(combinedProperties[currentClass], value)
                    elseif(commentType == "field")then
                        if currentClass then
                            table.insert(fields[currentClass], value)
                        end
                    elseif(commentType == "event")then
                        currentBlock = {type = "comment", desc = {}}
                        table.insert(events[currentClass], value)
                    else
                        currentBlock.usageIsActive = false
                        currentBlock[commentType] = currentBlock[commentType] or {}
                        table.insert(currentBlock[commentType], value)
                    end



                end
            else
                if(skipNextFunction)then
                    skipNextFunction = false
                else
                    local funcName = getFunctionName(line)
                    if funcName then
                        currentBlock.func = funcName
                        currentBlock.type = "function"
                        currentBlock.className = currentClass
                    end
                end
            end
        end
    end

    if hasBlockContent(currentBlock) then
        table.insert(blocks, currentBlock)
    end

    local functionBlocks = {}
    local otherBlocks = {}

    for _, block in ipairs(blocks) do
        if block.type == "function" then
            table.insert(functionBlocks, block)
        else
            table.insert(otherBlocks, block)
        end
    end

    table.sort(functionBlocks, function(a, b)
        return a.func < b.func
    end)

    markdown.blocks = {combinedProperties = combinedProperties, properties = properties, events = events, fields = fields}
    for _, block in ipairs(otherBlocks) do
        table.insert(markdown.blocks, block)
    end
    for _, block in ipairs(functionBlocks) do
        table.insert(markdown.blocks, block)
    end
    return markdown.blocks
end

local function markdownFunction(block)
    local fOutput = "## " .. block.func .. "("
    local output = ""
    if block.desc then
        for _, line in pairs(block.desc) do
            output = output .. line .. "\n"
        end
    end
    if(block.param or block.vararg)then
        output = output .. "\n### Parameters\n"
        if(block.param)then
            for _, line in pairs(block.param) do
                local name, paramType, desc = line:match("([^%s]+)%s+([^%s]+)%s+(.*)")
                fOutput = fOutput .. name .. (block.param[#block.param] == line and "" or ", ")
                if name:match("%?$") then
                    name = name:sub(1, -2)
                    output = output .. string.format("* `%s` *(optional)* `%s` %s\n", name, paramType, desc)
                else
                    output = output .. string.format("* `%s` `%s` %s\n", name, paramType, desc)
                end
            end
        end
        if(block.vararg)then
            for _, line in pairs(block.vararg) do
                local paramType, desc = line:match("([^%s]+)%s+(.*)")
                fOutput = fOutput .. "..."
                output = output .. string.format("* `...` *(vararg)* `%s` %s\n", paramType, desc)
            end
        end
    end
    if(block["return"])then
        output = output .. "\n### Returns\n"
        for _, line in pairs(block["return"]) do
            local name, paramType, desc = line:match("([^%s]+)%s+([^%s]+)%s+(.*)")
            output = output .. string.format("* `%s` `%s` %s\n", name, paramType, desc)
        end
    end
    if(block.usage)then
        for k,v in pairs(block.usage) do
            output = output .. "\n### Usage\n ```lua\n"
            for _, line in pairs(v.content) do
                output = output .. line .. "\n"
            end
            output = output .. "```\n"
        end
    end

    output = fOutput ..")\n" .. output .. "\n"
    return output
end

local function markdownFields(className)
    if(#markdown.blocks.fields[className]<=0)then
        return ""
    end
    local output = "\n## Fields\n\n|Field|Type|Description|\n|---|---|---|\n"
    for _, block in pairs(markdown.blocks.fields[className]) do
        local name, rest = block:match("([%w_]+)%s+(.+)")
        if name and rest then
            local fieldType, desc = rest:match("([^%s].-)%s+([^%s].*)")
            if fieldType and desc then
                output = output .. string.format("|%s|`%s`|%s|\n",
                    name,
                    fieldType,
                    desc or ""
                )
            end
        end
    end
    return output
end

local function markdownProperties(className)
    if(#markdown.blocks.properties[className]<=0)then
        return ""
    end
    local output = "\n## Properties\n\n|Property|Type|Default|Description|\n|---|---|---|---|\n"
    for _, block in pairs(markdown.blocks.properties[className]) do
        local name, paramType, defaultValue, desc = block:match("([^%s]+)%s+([^%s]+)%s+([^%s]+)%s+(.*)")
        output = output .. string.format("|%s|%s|%s|%s\n", name, paramType, defaultValue, desc)
    end
    return output
end

local function markdownCombinedProperties(className)
    if(markdown.blocks.combinedProperties[className]==nil)then
        return ""
    end
    if(#markdown.blocks.combinedProperties[className]<=0)then
        return ""
    end
    local output = "\n## Combined Properties\n\n|Name|Properties|Description|\n|---|---|---|\n"
    for _, block in pairs(markdown.blocks.combinedProperties[className]) do
        local name, params, desc = block:match("([%w_]+)%s+{([^}]+)}%s*(.*)")
        if name and params then
            local formattedParams = params:gsub("%s*,%s*", ", ")
            output = output .. string.format("|%s|`%s`|%s|\n",
                name,
                formattedParams,
                desc or ""
            )
        end
    end
    return output
end

local function markdownEvents(className)
    if(#markdown.blocks.events[className]<=0)then
        return ""
    end
    local output = "\n## Events\n\n|Event|Parameters|Description|\n|---|---|---|\n"
    
    for _, event in pairs(markdown.blocks.events[className]) do
        local name, params, desc = event:match("([%w_]+)%s+{([^}]+)}%s*(.*)")
        if name and params then
            local formattedParams = params:gsub("%s*,%s*", ", ")
            output = output .. string.format("|%s|`%s`|%s|\n",
                name,
                formattedParams,
                desc or ""
            )
        end
    end
    return output
end

local function formatLink(str)
    local base, params = str:match("([^(]+)%(([^)]*%))")
    local baseName = (base or str):lower():gsub("[:]", "-"):gsub("[%.]", "-")

    if params and params ~= "" then
        local paramNames = {}
        for param in params:gmatch("([^,]+)") do
            table.insert(paramNames, param:match("%s*(%w+)"))
        end
        return baseName .. "-" .. table.concat(paramNames, "-")
    end
    return baseName
end

local function markdownClassFunctionList(className)
    if(#markdown.blocks<=0)then
        return ""
    end
    local fList = {}
    for _, v in pairs(markdown.blocks) do
        if(v.type=="function")and(v.protected~=true)then
            if(v.className==className)then
                table.insert(fList, v)
            end
        end
    end
    if(#fList<=0)then
        return ""
    end

    local output = "\n## Functions\n\n|Method|Returns|Description|\n|---|---|---|\n"
    for _, block in pairs(fList) do
        if block.type == "function" then
            output = output .. "|[" .. block.func .. "](#" .. formatLink(block.func) .. ")|"
            if(block["return"]~=nil)then
                local returnType = block["return"][1]:match("^(%S+)")
                output = output .. returnType.."|"
            else
                output = output .. "-|"
            end
            if(block.shortDescription~=nil)then
                output = output .. block.shortDescription.."\n"
            else
                output = output .. "\n"
            end
        end
    end
    return output
end

local function markdownProtectedFunctions(className)
    if(#markdown.blocks<=0)then
        return ""
    end
    local fList = {}
    for _, v in pairs(markdown.blocks) do
        if(v.type=="function")and(v.protected==true)then
            if(v.className==className)then
                table.insert(fList, v)
            end
        end
    end
    if(#fList<=0)then
        return ""
    end
    local output = "Protected functions can be overwritten."
    output = "\n## Protected Functions\n\n|Method|Returns|Description|\n|---|---|---|\n"
    for _, block in pairs(fList) do
        if block.type == "function" then
            output = output .. "|"..block.func.."|"
            if(block["return"]~=nil)then
                local returnType = block["return"][1]:match("^(%S+)")
                output = output .. returnType.."|"
            else
                output = output .. "-|"
            end
            if(block.shortDescription~=nil)then
                output = output .. block.shortDescription.."\n"
            else
                output = output .. "\n"
            end
        end
    end
    return output
end

local function markdownClass(block)
    local output = "# ".. block.className.."\n"
    if(block.usage~=nil)then
        if(#block.usage > 0)then
            for k,v in pairs(block.usage) do
                local _output = "\n### Usage\n ```lua\n"
                for _, line in pairs(v.content) do
                    _output = _output .. line .. "\n"
                end
                _output = _output .. "```\n"
                table.insert(block.desc, v.line, _output)
            end
        end
    end
    for _, line in pairs(block.desc) do
        output = output .. line .. "\n"
    end

    output = output .. markdownFields(block.className)
    output = output .. markdownProperties(block.className)
    output = output .. markdownCombinedProperties(block.className)
    output = output .. markdownEvents(block.className)
    output = output .. markdownClassFunctionList(block.className) .. "\n"
    output = output .. markdownProtectedFunctions(block.className) .. "\n"
    for k,v in pairs(markdown.blocks) do
        if(v.type=="function")then
            if(v.className==block.className)and(v.protected~=true)then
                output = output .. markdownFunction(v)
            end
        end
    end
    output = output .. "\n"
    return output
end

local function markdownClassGroup(blocks)

end

local log = require("Basalt2/src/log")
log._enabled = true
log._logToFile = true
function markdown.makeMarkdown()
    local classes = {}
    local output = ""
    for _, block in pairs(markdown.blocks) do
        if block.type == "comment" then
            for _, line in pairs(block.desc) do
                output = output .. line .. "\n"
            end
        --[[elseif block.type == "module" then
            output = output .. markdownModule(block)]]
        elseif block.type == "class" then
            classes[block.className] = {content=markdownClass(block), data=block}
            log.debug("Class found: " .. block.className)
        end
    end

    return classes
end

function markdown.parseFile(source)
    local file = io.open(source, "r")
    if not file then
        error("File not found: " .. source)
    end

    local input = file:read("*a")
    file:close()

    return markdown.parse(input, source)
end

function markdown.saveToFile(source, output)
    local mainFile
    local mainFileCount = 0

    local sortedOutput = {}
    for _, v in pairs(output) do
        table.insert(sortedOutput, v)
    end

    table.sort(sortedOutput, function(a, b)
        return a.data.className < b.data.className
    end)

    for k,v in pairs(sortedOutput) do
        if(v.data.splitClass)then
            local subFile = io.open(source.."_"..v.data.className:gsub(":", "_"):gsub(" ", "")..".md", "w")
            if not subFile then
                error("Could not open file for writing: " .. source.."_"..v.data.className..".md")
            end
            subFile:write(v.content)
            subFile:close()
        else
            if(mainFile==nil)then
                mainFile = io.open(source..".md", "w")
            end
            if(mainFileCount>0)then
                mainFile:write("---\n<br>\n\n")
            end
            if not mainFile then
                error("Could not open file for writing: " .. source..".md")
            end
            mainFile:write(v.content)
            mainFileCount = mainFileCount + 1
        end

    end
    if(mainFile~=nil)then
        mainFile:close()
    end




        --[[local file = io.open(source..".md", "w")
        if not file then
            error("Could not open file for writing: " .. source..".md")
        end
        for _, content in pairs(output) do
            file:write(content)
        end
        file:close()]]
end

return markdown
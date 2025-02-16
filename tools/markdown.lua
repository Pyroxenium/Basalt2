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
    "property"
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

function markdown.parse(content)
    local blocks = {}
    local properties = {}
    local events = {}
    local currentBlock = {type = "comment", desc = {}}

    for line in content:gsub("\r\n", "\n"):gmatch("([^\n]*)\n?") do
        if line:match("^%s*$") or line == "" then
            if hasBlockContent(currentBlock) then
                table.insert(blocks, currentBlock)
                currentBlock = {type = "comment", desc = {}}
            end
        else
            local comment, isDoc = extractComment(line)
            if comment then
                local commentType, value = getCommentType(comment)
                if(commentType == "desc") then
                    currentBlock.usageIsActive = false
                    table.insert(currentBlock.desc, value)
                else
                    if(commentType == "module")then
                        currentBlock.usageIsActive = false
                        currentBlock.type = "module"
                        currentBlock.moduleName = value:match("([^%s]+)")
                    elseif(commentType == "class")then
                        currentBlock.usageIsActive = false
                        currentBlock.type = "class"
                        currentBlock.className = value
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
                        table.insert(properties, value)
                    elseif(commentType == "event")then
                        currentBlock = {type = "comment", desc = {}}
                        table.insert(events, value)
                    else
                        currentBlock.usageIsActive = false
                        currentBlock[commentType] = currentBlock[commentType] or {}
                        table.insert(currentBlock[commentType], value)
                    end



                end
            else
                local funcName = getFunctionName(line)
                if funcName then
                    currentBlock.func = funcName
                    currentBlock.type = "function"
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

    markdown.blocks = {properties = properties, events = events}
    for _, block in ipairs(otherBlocks) do
        table.insert(markdown.blocks, block)
    end
    for _, block in ipairs(functionBlocks) do
        table.insert(markdown.blocks, block)
    end
end

local function markdownFunction(block)
    local fOutput = "## " .. block.func .. "("
    local output = ""
    if block.desc then
        for _, line in pairs(block.desc) do
            output = output .. line .. "\n"
        end
    end
    if(block.param)then
        output = output .. "\n### Parameters\n"
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

local function markdownProperties()
    if(#markdown.blocks.properties<=0)then
        return ""
    end
    local output = "\n## Properties\n\n|Property|Type|Default|Description|\n|---|---|---|---|\n"
    for _, block in pairs(markdown.blocks.properties) do
        local name, paramType, defaultValue, desc = block:match("([^%s]+)%s+([^%s]+)%s+([^%s]+)%s+(.*)")
        output = output .. string.format("|%s|%s|%s|%s\n", name, paramType, defaultValue, desc)
    end
    return output
end

local function markdownEvents()
    if(#markdown.blocks.events<=0)then
        return ""
    end
    local output = "\n## Events\n\n"
    for _, block in pairs(markdown.blocks) do
        if block.type == "module" or block.type == "class" then
            if(block.event~=nil)then
                for _, line in pairs(block.event) do
                    output = output .. "* " .. line .. "\n"
                end
            end
        end
    end
    return output
end

local function markdownModuleOrClassFunctions()
    if(#markdown.blocks<=0)then
        return ""
    end
    local output = "\n## Functions\n\n|Method|Returns|Description|\n|---|---|---|\n"
    for _, block in pairs(markdown.blocks) do
        if block.type == "function" then
            output = output .. "|[" .. block.func .. "](#" .. block.func .. ")|"
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

local function markdownModule(block)
    local output = "# ".. block.moduleName.."\n"
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

    output = output .. markdownProperties()
    output = output .. markdownEvents()
    output = output .. markdownModuleOrClassFunctions(block)
    output = output .. "\n"
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

    output = output .. markdownProperties()
    output = output .. markdownEvents()
    output = output .. markdownModuleOrClassFunctions(block)
    output = output .. "\n"
    return output
end

function markdown.makeMarkdown()
    local output = ""
    for _, block in pairs(markdown.blocks) do
        if block.type == "function" then
            output = output .. markdownFunction(block)
        elseif block.type == "comment" then
            for _, line in pairs(block.desc) do
                output = output .. line .. "\n"
            end
        elseif block.type == "module" then
            output = output .. markdownModule(block)
        elseif block.type == "class" then
            output = output .. markdownClass(block)
        end
    end

    return output
end

function markdown.parseFile(source)
    local file = io.open(source, "r")
    if not file then
        error("File not found: " .. source)
    end

    local input = file:read("*a")
    file:close()

    return markdown.parse(input)
end

function markdown.saveToFile(source, output)
    local file = io.open(source, "w")
    if not file then
        error("Could not open file for writing: " .. source)
    end

    file:write(output)
    file:close()
end

return markdown
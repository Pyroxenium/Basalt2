local args = {...}

local commentTypes = {
    "module",
    "class",
    "param",
    "return",
    "usage",
    "function",
    "local",
    "property",
    "combinedProperty",
    "event",
    "private",
    "protected",
    "field",
    "vararg",
    "shortDescription",
}

local elementList = {}

local function getFilesInCC(path)
    local files = {}

    local function scanDir(dir)
        for _, item in ipairs(fs.list(dir)) do
            local fullPath = fs.combine(dir, item)
            if fs.isDir(fullPath) then
                scanDir(fullPath)
            elseif item:match("%.lua$") then
                if(fullPath:find("elements"))then
                    local itemName = item:gsub("%.lua$", "")
                    table.insert(elementList, itemName)
                end
                local file = fs.open(fullPath, "r")
                if file then
                    files[fullPath] = file.readAll()
                    file.close()
                end
            end
        end
    end

    scanDir(path)
    return files
end

local function getFilesInLua(path)
    local files = {}

    local function scanDir(dir)
        local p = io.popen('dir "'..dir..'" /b /s')
        if not p then return end

        for file in p:lines() do
            if file:match("%.lua$") then
                if(file:find("elements"))then
                    local itemName = file:gsub("%.lua$", "")
                    itemName = itemName:match("([^/\\]+)$")
                    table.insert(elementList, itemName)
                end
                local f = io.open(file, "r")
                if f then
                    files[file] = f:read("*a")
                    f:close()
                end
            end
        end
        p:close()
    end

    scanDir(path)
    return files
end

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

local function split(str, delimiter)
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

local function getClassName(content)
    return split(content:gsub("^%s*", ""):gsub("%s*$", ""):gsub(" ", ""), ":")
end

local function parseFile(content)
    local fileContent = {}
    local class = {functions = {}, properties = {}, events = {}, fields = {}}
    local func = {params={}, returns={}, desc=""}
    local skipNextFunction = false

    for line in content:gsub("\r\n", "\n"):gmatch("([^\n]*)\n?") do
        if line:match("^%s*$") or line == "" then
            -- Skip empty lines
            func = {params={}, returns={}, desc=""}
        else
            local comment, isDoc = extractComment(line)
            if comment then
                local commentType, content = getCommentType(comment)
                if(commentType=="module")then
                    class.module = content
                elseif(commentType=="class")then
                    if(class.class)then
                        fileContent[class.class] = class
                        class = {functions = {}, properties = {}, events = {}, fields = {}}
                    end
                    class.class, class.parent = table.unpack(getClassName(content))
                    if(class.class=="Container")then
                        for _,v in ipairs(elementList)do
                            class.functions["Container:add"..v] = {params={{name="self", type="Container", desc="self"}, {name="props", type="table", desc="Optional: properties for the element.", optional=true}}, returns={{type=v, desc="element A new "..v.." element."}}, desc="Creates a new "..v.." element.\n"}
                        end
                    end
                elseif(commentType=="param")then
                    if func then
                        local paramName, paramType, paramDesc = content:match("^%s*([%w_]+)%s+([%w_]+)%s*(.*)$")
                        if paramName then
                            table.insert(func.params, {name=paramName, type=paramType, desc=paramDesc or ""})
                        end
                    end
                elseif(commentType=="return")then
                    if func then
                        local returnType, returnDesc = content:match("^%s*([%w_]+)%s*(.*)$")
                        if returnType then
                            table.insert(func.returns, {type=returnType, desc=returnDesc or ""})
                        end
                    end
                elseif(commentType=="usage")then
                    if func then
                        func.usage = content
                    end
                elseif(commentType=="desc")then
                    if func then
                        func.desc = (func.desc or "") .. content .. "\n"
                    end
                elseif(commentType=="private")then
                    skipNextFunction = true
                elseif(commentType=="protected")then
                    if func then
                        func.protected = true
                    end
                elseif(commentType=="shortDescription")then
                    -- skip
                elseif(commentType=="property")then
                    local propertyName, propertyType, propertyDesc = content:match("^%s*([%w_]+)%s+([%w_]+)%s*(.*)$")
                    if propertyName then
                        class.fields[propertyName] = {type=propertyType, desc=propertyDesc:gsub("^%S+%s*", "") or ""}
                        propertyName = propertyName:sub(1,1):upper() .. propertyName:sub(2)
                        class.functions[class.class..":get" .. propertyName] = {params={{name="self", type=class.class, desc="self"}}, returns={{type=propertyType, desc=propertyDesc or ""}}, desc="Gets the value of the " .. propertyName .. " property.\n"}
                        class.functions[class.class..":set" .. propertyName] = {params={{name="self", type=class.class, desc="self"}, {name=propertyName, type=propertyType, desc=propertyDesc:gsub("^%S+%s*", "") or ""}}, returns={}, desc="Sets the value of the " .. propertyName .. " property.\n"}
                    end
                end

            else
                if not skipNextFunction then
                    local functionName = getFunctionName(line)
                    if functionName then
                        if func and hasBlockContent(func) then
                            class.functions[functionName] = func
                        end
                        func = {params={}, returns={}, desc=""}
                    end
                else
                    skipNextFunction = false
                end
            end
        end

    end
    if(class.class)then
        fileContent[class.class] = class
    end
    return fileContent
end

local function generateLuaLS(finalContent)
    local output = {"---@meta\n\n"}

    for filepath, block in pairs(finalContent) do
        if block.class then
            if(block.parent~=nil)then
                table.insert(output, string.format("---@class %s : %s\n", block.class, block.parent))
            else
                table.insert(output, string.format("---@class %s\n", block.class))
            end
            for k,v in pairs(block.fields)do
                table.insert(output, string.format("---@field %s %s %s\n", k, v.type, v.desc))
            end
            table.insert(output, string.format("local %s = {}\n\n", block.class))

            for funcName, funcData in pairs(block.functions) do
                if funcData.desc~="" then
                    table.insert(output, string.format("---%s", funcData.desc))
                end
                if(funcData.protected)then
                    table.insert(output, string.format("---This function is protected und should not be called outside of basalt, however you can overwrite it if you know what you're doing.\n"))
                end
                for _, param in ipairs(funcData.params) do
                    table.insert(output, string.format("---@param %s %s %s\n", (param.optional and param.name.."?" or param.name), param.type, param.desc))
                end
                for _, ret in ipairs(funcData.returns) do
                    table.insert(output, string.format("---@return %s %s\n", ret.type, ret.desc))
                end
                if(funcData.protected)then
                    table.insert(output, string.format("---@protected\n"))
                end

                local paramNames = {}
                for _, param in ipairs(funcData.params) do
                    table.insert(paramNames, param.name)
                end

                table.insert(output, string.format("function %s(%s) end\n\n",
                    funcName,
                    table.concat(paramNames, ", ")))
            end
        end
    end
    
    return table.concat(output)
end

local function mergeTables(t1, t2)
    local merged = {}
    for k, v in pairs(t1) do
        merged[k] = v
    end
    for k, v in pairs(t2) do
        if type(v) == "table" and type(merged[k]) == "table" then
            merged[k] = mergeTables(merged[k], v)
        else
            merged[k] = v
        end
    end
    return merged
end

local function parseFiles(files)
    local finalContent = {}
    for k,v in pairs(files)do
        local fileContent = parseFile(v)
        if fileContent then
            finalContent = mergeTables(finalContent, fileContent)
        end
    end

    local lualsContent = generateLuaLS(finalContent)
    local outFile = io.open("LuaLS.lua", "w")
    if outFile then
        outFile:write(lualsContent)
        outFile:close()
    end
end

if _G.fs then
    parseFiles(getFilesInCC(args[1]))
else
    parseFiles(getFilesInLua(args[1]))
end
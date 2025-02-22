local customElements = {}
local customPlugins = {}

local function serialize(t, indent)
    indent = indent or ""
    local result = "{\n"
    for k, v in pairs(t) do
        result = result .. indent .. "  "
        if type(k) == "string" then
            result = result .. "[\"" .. k .. "\"] = "
        else
            result = result .. "[" .. k .. "] = "
        end
        if type(v) == "table" then
            result = result .. serialize(v, indent .. "  ")
        elseif type(v) == "string" then
            result = result .. "\"" .. v .. "\""
        else
            result = result .. tostring(v)
        end
        result = result .. ",\n"
    end
    return result .. indent .. "}"
end

local function parseFile(filePath)
    if filePath:match("LuaLS%.lua$") then return nil end
    
    local file = io.open(filePath, "r")
    if not file then return nil end
    
    local content = file:read("*all")
    local size = #content
    file:close()

    local config = {
        description = "",
        default = true,
        requires = {},
        size = size
    }

    local description = content:match("%-%-%-@configDescription%s*(.-)%s*\n")
    if description then
        config.description = description
    end

    local default = content:match("%-%-%-@configDefault%s*(%w+)")
    if default then
        config.default = default == "true"
    end

    for required in content:gmatch("%-%-%-@requires%s*(%w+)") do
        table.insert(config.requires, required)
    end

    local className, parent = content:match("%-%-%-@class%s*([^%s:]+)%s*:%s*([^%s\n]+)")
    if className and parent and parent ~= "PropertySystem" then
        table.insert(config.requires, parent)
    end

    return config
end

local function categorizeFile(path)
    if path:match("/elements/") then
        return "elements", "UI Elements"
    elseif path:match("/plugins/") then
        return "plugins", "Plugins"
    elseif path:match("/libraries/") then
        return "libraries", "Libraries"
    elseif path:match("^src/[^/]+%.lua$") then
        return "core", "Core Files"
    end
    return "other", "Other Files"
end

local function scanDirectory(srcPath)
    local files = {}

    local function scanRecursive(dir)
        local pipe = io.popen('find "' .. dir .. '" -name "*.lua"')
        if not pipe then return end

        for path in pipe:lines() do
            if(path~="LuaLS.lua")then
                local config = parseFile(path)
                if config then
                    config.name = path:match("([^/]+)%.lua$")
                    config.path = path:gsub("^" .. srcPath .. "/", "")
                    files[path] = config
                end
            end
        end
        pipe:close()
    end

    scanRecursive(srcPath)
    return files
end

local function generateConfig(srcPath)
    local files = scanDirectory(srcPath)
    local categories = {}

    for path, fileConfig in pairs(files) do
        local category, categoryDesc = categorizeFile(path)
        if not categories[category] then
            categories[category] = {
                description = categoryDesc,
                files = {}
            }
        end
        categories[category].files[fileConfig.name] = {
            path = fileConfig.path,
            description = fileConfig.description,
            default = fileConfig.default,
            requires = fileConfig.requires,
            size = fileConfig.size
        }
    end

    for catName, cat in pairs(categories) do
        for fileName, file in pairs(cat.files) do
            for _, req in ipairs(file.requires or {}) do
                local found = false
                for _, checkCat in pairs(categories) do
                    if checkCat.files[req] then
                        found = true
                        break
                    end
                end
                if not found then
                    error(string.format("Missing dependency %s for %s", req, fileName))
                end
            end
        end
    end

    return {
        categories = categories,
        metadata = {
            generated = os.date(),
            version = "2.0"
        }
    }
end

local config = generateConfig("src")
local configFile = io.open("config.lua", "w")
configFile:write("return " .. serialize(config))
configFile:close()

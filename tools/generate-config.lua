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
    local file = fs.open(filePath, "r")
    local content = file.readAll()
    file.close()

    local config = {
        description = "",
        default = true,
        requires = {}
    }

    -- Description aus @configDescription
    local description = content:match("%-%-%-@configDescription%s*(.-)%s*\n")
    if description then
        config.description = description
    end

    -- Default aus @configDefault
    local default = content:match("%-%-%-@configDefault%s*(%w+)")
    if default then
        config.default = default == "true"
    end

    -- Dependencies aus @requires
    for required in content:gmatch("%-%-%-@requires%s*(%w+)") do
        table.insert(config.requires, required)
    end

    -- Dependencies aus @class inheritance
    local className, parent = content:match("%-%-%-@class%s*([^%s:]+)%s*:%s*([^%s\n]+)")
    if className and parent and parent ~= "PropertySystem" then
        table.insert(config.requires, parent)
    end

    return config
end

local function categorizeFile(path)
    if path:match("^elements/") then
        return "elements", "UI Elements"
    elseif path:match("^plugins/") then
        return "plugins", "Plugins"
    elseif path:match("^libraries/") then
        return "libraries", "Libraries"
    else
        return "core", "Core Files"
    end
end

local function scanDirectory(baseDir, relativePath)
    local files = {}
    local items = fs.list(fs.combine(baseDir, relativePath))
    
    for _, item in ipairs(items) do
        local fullPath = fs.combine(relativePath, item)
        local absPath = fs.combine(baseDir, fullPath)
        
        if fs.isDir(absPath) then
            for path, config in pairs(scanDirectory(baseDir, fullPath)) do
                files[path] = config
            end
        elseif item:match("%.lua$") then
            local config = parseFile(absPath)
            config.name = item:gsub("%.lua$", "")
            config.path = fullPath
            files[fullPath] = config
        end
    end
    
    return files
end

local function generateConfig(srcPath)
    local files = scanDirectory(srcPath, "")
    local categories = {}
    
    -- Files in Kategorien einordnen
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
            requires = fileConfig.requires
        }
    end

    -- Dependencies validieren
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

-- Config generieren
local config = generateConfig("/c:/Users/rjsha/AppData/Roaming/CraftOS-PC/computer/0/Basalt2/src")

-- Config speichern
local configFile = fs.open("/c:/Users/rjsha/AppData/Roaming/CraftOS-PC/computer/0/Basalt2/config.lua", "w")
configFile.write("return " .. serialize(config))
configFile.close()

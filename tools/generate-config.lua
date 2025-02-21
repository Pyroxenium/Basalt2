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
    local file = io.open(filePath, "r")
    if not file then return nil end
    
    local content = file:read("*all")
    file:close()

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
    -- Relativen Pfad verwenden
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
    local basePath = srcPath:match("^(.+)/$") or srcPath

    -- Rekursive Funktion zum Scannen von Ordnern
    local function scanRecursive(dir)
        local pipe = io.popen('dir "' .. dir .. '" /b')
        if not pipe then return end
        
        for entry in pipe:lines() do
            local fullPath = dir .. "\\" .. entry
            
            if entry:match("%.lua$") then
                local config = parseFile(fullPath)
                if config then
                    config.name = entry:gsub("%.lua$", "")
                    -- Relativen Pfad mit Forward Slashes erstellen
                    config.path = fullPath:gsub("^" .. basePath .. "\\", ""):gsub("\\", "/")
                    files[fullPath] = config
                end
            elseif io.popen('dir "' .. fullPath .. '" /ad'):read("*l") then
                -- Rekursiv in Unterordner gehen
                scanRecursive(fullPath)
            end
        end
        pipe:close()
    end

    scanRecursive(basePath)
    return files
end

local function generateConfig(srcPath)
    local files = scanDirectory(srcPath)
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

-- Config generieren und speichern
local config = generateConfig("src")
local configFile = io.open("config.lua", "w")
configFile:write("return " .. serialize(config))
configFile:close()

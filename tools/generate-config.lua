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

local function extractConfigDescription(filePath)
    local f = io.open(filePath, "r")
    if not f then return nil end

    local content = f:read("*all")
    f:close()

    return content:match("%-%-%-@configDescription%s*(.-)%s*[\n\r]") or "No description available"
end

local function categorizeFile(path)
    if path:match("^src/elements/") then
        return "elements", "UI Elements"
    elseif path:match("^src/plugins/") then
        return "plugins", "Plugins and Extensions"
    elseif path:match("^src/libraries/") then
        return "libraries", "Utility Libraries"
    elseif path:match("^src/[^/]+%.lua$") then
        return "core", "Core Framework Files"
    else
        return "other", "Other Files"
    end
end

local function sortFiles(files)
    local categories = {}
    for path, info in pairs(files) do
        local category, categoryDesc = categorizeFile(path)
        if not categories[category] then
            categories[category] = {
                description = categoryDesc,
                files = {}
            }
        end
        table.insert(categories[category].files, {
            path = path,
            name = info.name,
            description = info.description
        })
    end

    for _, cat in pairs(categories) do
        table.sort(cat.files, function(a, b)
            return a.name < b.name
        end)
    end

    return categories
end

local function scanDir(dir)
    local files = {}
    for file in io.popen('find "'..dir..'" -maxdepth 1 -type f -name "*.lua"'):lines() do
        local name = file:match("([^/]+)%.lua$")
        if name then
            files[file] = {
                name = name,
                path = file:gsub("^src/", ""),
                description = extractConfigDescription(file)
            }
        end
    end

    for file in io.popen('find "'..dir..'/elements" "'..dir..'/plugins" "'..dir..'/libraries" -type f -name "*.lua"'):lines() do
        local name = file:match("([^/]+)%.lua$")
        if name then
            files[file] = {
                name = name,
                path = file:gsub("^src/", ""),
                description = extractConfigDescription(file)
            }
        end
    end
    return files
end

local sourceFiles = scanDir("src")
local categories = sortFiles(sourceFiles)

local config = {
    categories = categories,
    metadata = {
        generated = os.date(),
        version = "2.0"
    }
}

local f = io.open("config.lua", "w")
if f then
    f:write("return " .. serialize(config))
    f:close()
end

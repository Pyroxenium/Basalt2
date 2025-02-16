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

local function scanDir(dir)
    local files = {}
    for file in io.popen('find "'..dir..'" -type f -name "*.lua"'):lines() do
        local f = io.open(file, "r")
        if f then
            local content = f:read("*all")
            f:close()
            -- Entferne den src/ Prefix vom Pfad für die Config
            local configPath = file:gsub("^src/", "")
            files[configPath] = content
        end
    end
    return files
end

local sourceFiles = scanDir("src")
local config = {
    files = sourceFiles,
}

local f = io.open("config.lua", "w")
if f then
    f:write("return " .. serialize(config))
    f:close()
end

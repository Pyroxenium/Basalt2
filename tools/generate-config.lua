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
    for _, file in ipairs(fs.list(dir)) do
        local path = fs.combine(dir, file)
        if fs.isDir(path) then
            for subFile, content in pairs(scanDir(path)) do
                files[fs.combine(file, subFile)] = content
            end
        else
            local f = fs.open(path, "r")
            files[file] = f.readAll()
            f.close()
        end
    end
    return files
end

local sourceFiles = scanDir("src")
local config = {
    files = sourceFiles,
}

local f = fs.open("config.lua", "w")
f.write("return " .. serialize(config))
f.close()

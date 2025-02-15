local function scanDir(dir)
    local files = {}
    for file in io.popen('find "'..dir..'" -type f -name "*.lua"'):lines() do
        local name = file:match("([^/]+)%.lua$")
        if name then
            files[file] = {
                name = name,
                path = file:gsub("^src", ""),
            }
        end
    end
    return files
end

local config = {
    repo = "https://raw.githubusercontent.com/Pyroxenium/Basalt2/master",
    required = {
        ["src/init.lua"] = "/init.lua",
        ["src/render.lua"] = "/render.lua",
    },
    elements = scanDir("src/elements"),
    plugins = scanDir("src/plugins")
}

local f = io.open("config.lua", "w")
f:write("return " .. textutils.serialize(config))
f:close()

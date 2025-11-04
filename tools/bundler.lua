local minify = loadfile("tools/minify.lua")()

local function loadConfig()
    local config = dofile("config.lua")
    return config
end

local function isDefaultFile(path, config)
    for _, category in pairs(config.categories) do
        for fileName, fileInfo in pairs(category.files) do
            if fileInfo.path == path and fileInfo.default == true then
                return true
            end
        end
    end
    return false
end

local function scanDir(dir)
    local files = {}
    for file in io.popen('find "'..dir..'" -type f -name "*.lua"'):lines() do
        if not file:match("LuaLS.lua$") then
            table.insert(files, {
                path = file:gsub("^src/", ""),
                fullPath = file
            })
        end
    end
    return files
end

local function bundle(coreOnly)
    local outputFile = coreOnly and "release/basalt-core.lua" or "release/basalt-full.lua"
    local config = coreOnly and loadConfig() or nil
    local files = scanDir("src")

    local output = {
        'local minified = true\n',
        'local minified_elementDirectory = {}\n',
        'local minified_pluginDirectory = {}\n',
        'local project = {}\n',
        'local loadedProject = {}\n',
        'local baseRequire = require\n',
        'require = function(path) if(project[path..".lua"])then if(loadedProject[path]==nil)then loadedProject[path] = project[path..".lua"]() end return loadedProject[path] end return baseRequire(path) end\n'
    }

    for _, file in ipairs(files) do
        if not coreOnly or isDefaultFile(file.path, config) then
            local elementName = file.path:match("^elements/(.+)%.lua$")
            if elementName then
                table.insert(output, string.format(
                    'minified_elementDirectory["%s"] = {}\n',
                    elementName
                ))
            end

            local pluginName = file.path:match("^plugins/(.+)%.lua$")
            if pluginName then
                table.insert(output, string.format(
                    'minified_pluginDirectory["%s"] = {}\n',
                    pluginName
                ))
            end
        end
    end

    local includedFiles = {}
    for _, file in ipairs(files) do
        if not coreOnly or isDefaultFile(file.path, config) then
            table.insert(includedFiles, file)

            local f = io.open(file.fullPath, "r")
            local content = f:read("*all")
            f:close()

            local success, minified = minify(content)
            if not success then
                print("Failed to minify " .. file.path)
                os.exit(1)
            end

            table.insert(output, string.format(
                'project["%s"] = function(...) %s end\n',
                file.path, minified
            ))
        end
    end

    table.insert(output, 'return project["main.lua"]()')

    local out = io.open(outputFile, "w")
    out:write(table.concat(output))
    out:close()

    print("Successfully bundled " .. outputFile .. ":")
    for _, file in ipairs(includedFiles) do
        print("- " .. file.path)
    end
    print("Total files: " .. #includedFiles)
end

print("=== Building Full Version ===")
bundle(false)
print("\n=== Building Core Version ===")
bundle(true)

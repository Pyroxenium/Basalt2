local minify = loadfile("tools/minify.lua")()

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

local function bundle()
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

    for _, file in ipairs(files) do
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

    table.insert(output, 'return project["main.lua"]()')

    local out = io.open("release/basalt.lua", "w")
    out:write(table.concat(output))
    out:close()

    print("Successfully bundled files:")
    for _, file in ipairs(files) do
        print("- " .. file.path)
    end
end

bundle()

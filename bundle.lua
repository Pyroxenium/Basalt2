local args = {...} -- example: bundle basalt main basalt.lua
local availableFiles = {}

local minifyURL = "https://raw.githubusercontent.com/Pyroxenium/basalt-docs/main/minify.lua"

local content = [[local bundled = true
local bundled_basaltContent = {}
local bundled_basaltLoaded = {}
local bundled_availableFiles = {}

local baseRequire = require
require = function(name)
    if(bundled_basaltContent["basalt/"..name])then
        if(bundled_basaltLoaded["basalt/"..name]==nil)then
            bundled_basaltLoaded["basalt/"..name] = bundled_basaltContent["basalt/"..name]()
        end
        return bundled_basaltLoaded["basalt/"..name]
    end
    if(bundled_basaltContent["basalt/elements/"..name])then
        if(bundled_basaltLoaded["basalt/elements/"..name]==nil)then
            bundled_basaltLoaded["basalt/elements/"..name] = bundled_basaltContent["basalt/elements/"..name]()
        end
        return bundled_basaltLoaded["basalt/elements/"..name]
    end
    if(bundled_basaltContent["basalt/extensions/"..name])then
        if(bundled_basaltLoaded["basalt/extensions/"..name]==nil)then
            bundled_basaltLoaded["basalt/extensions/"..name] = bundled_basaltContent["basalt/extensions/"..name]()
        end
        return bundled_basaltLoaded["basalt/extensions/"..name]
    end
    if(bundled_basaltContent["basalt/libraries/"..name])then
        if(bundled_basaltLoaded["basalt/libraries/"..name]==nil)then
            bundled_basaltLoaded["basalt/libraries/"..name] = bundled_basaltContent["basalt/libraries/"..name]()
        end
        return bundled_basaltLoaded["basalt/libraries/"..name]
    end

    return baseRequire(name)
end
]]

local function bundleProject(mainFolder, mainFile, fileName, minify)
local function generateSingleFile(folder)
    local newFolder = {}
    for k,file in pairs(fs.list(folder)) do
        if fs.isDir(fs.combine(folder, file)) then
            generateSingleFile(fs.combine(folder, file))
        else
            local fileContent = fs.open(fs.combine(folder, file), "r")
            local fileData = fileContent.readAll()
            fileContent.close()
            table.insert(newFolder, file)
            local fName = file:gsub(".lua", "")
            content = content .. "\nbundled_basaltContent[\"" .. fs.combine(folder, fName) .. "\"] = function(...)\n"..fileData.."\nend"
        end
    end
    availableFiles[folder] = newFolder
end

generateSingleFile(mainFolder)

for k,v in pairs(availableFiles) do
    content = content .. "\nbundled_availableFiles[\"" .. k .. "\"] = {"
    for _,file in pairs(v) do
        content = content .. "\"" .. file .. "\","
    end
    content = content .. "}"
end

content = content .. "\nreturn bundled_basaltContent['basalt/"..mainFile.."']()"

if(minify)then
    local minScript = http.get(minifyURL)
    print("Downloading minify script...")
    if(minScript)then
        local min = load(minScript.readAll(), nil, "t", _ENV)()
        minScript.close()
        local success, data = min(content)
        if(success)then
            content = data
        else
            error(data)
        end
    else
        print("Failed to download minify script")
    end
end
local file = fs.open(fileName, "w")
file.write(content:gsub("\t", " "):gsub("\n", " "))
file.close()
end

if(#args>=1)then
    --bundleProject(args[1], args[2] or "main", args[3] or "basalt.lua", args[4] or false)
end

return bundleProject
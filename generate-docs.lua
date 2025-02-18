local markdown = require("tools/markdown")
local log = require("src/log")

if not fs.exists("docs/references") then
    fs.makeDir("docs/references")
end

local function processFile(inputFile)
    local parsed = markdown.parseFile(inputFile)
    local md = markdown.makeMarkdown(parsed)

    local relativePath = inputFile:match("Basalt2/src/(.+)")
    if not relativePath then return end

    local outputFile = "docs/references/" .. relativePath:gsub("%.lua$", "")

    local dir = fs.getDir(outputFile)
    if not fs.exists(dir) then
        fs.makeDir(dir)
    end

    --print(string.format("Processing: %s -> %s", inputFile, outputFile))

    markdown.saveToFile(outputFile, md)
end


local function processDirectory(path)
    for _, file in ipairs(fs.list(path)) do
        local fullPath = fs.combine(path, file)
        if fs.isDir(fullPath) then
            processDirectory(fullPath)
        elseif file:match("%.lua$") and not file:match("LuaLS%.lua$") then
            processFile(fullPath)
        end
    end
end

processDirectory("Basalt2/src")

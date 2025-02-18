local markdown = require("tools/markdown")

local function ensureDirectory(path)
    local dir = path:match("(.*)/[^/]*$")
    if dir then
        os.execute('mkdir -p "' .. dir .. '"')
    end
end

local function processFile(inputFile)
    local parsed = markdown.parseFile(inputFile)
    local md = markdown.makeMarkdown(parsed)

    local outputFile = "build_docs/docs/references/" .. inputFile:match("^src/(.+)"):gsub("%.lua$", "")

    ensureDirectory(outputFile)
    --print(string.format("Processing: %s -> %s", inputFile, outputFile))

    markdown.saveToFile(outputFile, md)
end

for file in io.popen('find "src" -type f -name "*.lua"'):lines() do
    if not file:match("LuaLS.lua$") then
        processFile(file)
    end
end

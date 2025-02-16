local function ensureDirectory(path)
    local dir = path:match("(.*)/[^/]*$")
    if dir then
        os.execute('mkdir -p "' .. dir .. '"')
    end
end

local function processFile(inputFile)
    local f = io.open(inputFile, "r")
    local content = f:read("*all")
    f:close()

    local outputFile
    if inputFile:match("^src/[^/]+%.lua$") then
        outputFile = "build_docs/docs/references/" .. inputFile:match("^src/(.+)"):gsub("%.lua$", ".md")
    else
        outputFile = "build_docs/docs/references/" .. inputFile:match("^src/(.+)"):gsub("%.lua$", ".md")
    end

    ensureDirectory(outputFile)
    print(string.format("Processing: %s -> %s", inputFile, outputFile))

    local out = io.open(outputFile, "w")
    out:write(content)
    out:close()
end

for file in io.popen('find "src" -type f -name "*.lua"'):lines() do
    if not file:match("LuaLS.lua$") then
        processFile(file)
    end
end

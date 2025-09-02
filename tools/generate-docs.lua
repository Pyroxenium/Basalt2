
local oldPath = package.path

local scriptSource = debug.getinfo(1, "S").source
local scriptDir = nil
if scriptSource and scriptSource:sub(1,1) == "@" then
    local scriptPath = scriptSource:sub(2)
    scriptDir = scriptPath:match("^(.*)[/\\]") or "."
else
    scriptDir = "."
end

local parserSrc = scriptDir .. "/BasaltDoc/ldoc-markdown-parser/src/"
package.path = package.path .. ";" .. parserSrc .. "?.lua;" .. parserSrc .. "?/init.lua"
local ok, parser = pcall(require, "parser.init")
local ioAdaptor = require("tools.io")
package.path = oldPath

if not ok or not parser then
    -- try dofile fallback
    local initPath = parserSrc .. "/parser/init.lua"
    local ok2, module = pcall(dofile, initPath)
    if ok2 and module then
        parser = module
    else
        error("Failed to load parser.init via require and dofile (tried: "..tostring(initPath)..")")
    end
end

local function processFile(inputFile)
    local content = ioAdaptor.readFile(inputFile)
    if not content then
        io.stderr:write("Failed to read: " .. tostring(inputFile) .. "\n")
        return
    end

    local commentBlocks = parser.extractComments(content)
    local md = parser.generateMarkdown(commentBlocks)

    local outputFile = "build_docs/docs/references/" .. inputFile:match("^src/(.+)"):gsub("%.lua$", "")
    ioAdaptor.ensureDirectory(outputFile)
    ioAdaptor.writeFile(outputFile .. ".md", md)
end

local files = ioAdaptor.listFiles("src", "*.lua")
for _, file in ipairs(files) do
    if not file:match("LuaLS.lua$") then
        processFile(file)
    end
end

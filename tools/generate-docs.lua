-- generate-docs.lua

-- Argumente
local arg = arg or {...}
local SRC_DIR = arg[1] or "src"
local OUT_DIR = arg[2] or "build_docs/docs/references"

package.path = package.path .. ";./tools/?.lua"

local BasaltDoc = require("tools/BasaltDoc")

--------------------------------------------------------
-- Filesystem Abstraction
--------------------------------------------------------

local fileSystem

if fs then
    fileSystem = {
        list = fs.list,
        combine = fs.combine,
        isDir = fs.isDir,
        exists = fs.exists,
        makeDir = fs.makeDir,
        open = function(path, mode) return fs.open(path, mode) end,
        getDir = fs.getDir,
        readAll = function(file) return file.readAll() end,
        write = function(file, data) file.write(data) end,
        close = function(file) file.close() end
    }
else
    local function executeCommand(cmd)
        local handle = io.popen(cmd)
        if not handle then return "", false, 1 end
        local result = handle:read("*a")
        local ok, _, code = handle:close()
        return result, ok, code
    end

    local function pathExists(path)
        local _, _, code = executeCommand("[ -e '" .. path .. "' ]")
        return code == 0
    end

    local function isDirectory(path)
        local _, _, code = executeCommand("[ -d '" .. path .. "' ]")
        return code == 0
    end

    local function makeDirectory(path)
        local _, ok = executeCommand("mkdir -p '" .. path .. "'")
        return ok
    end

    local function listDirectory(dir)
        local result, ok = executeCommand("ls -1 '" .. dir .. "' 2>/dev/null")
        if not ok then return {} end
        local items = {}
        for item in result:gmatch("[^\r\n]+") do
            if item ~= "" then
                table.insert(items, item)
            end
        end
        return items
    end

    local function combinePath(a, b)
        if a:sub(-1) == "/" then
            return a .. b
        else
            return a .. "/" .. b
        end
    end

    local function getDirectory(path)
        return path:match("(.+)/[^/]*$") or ""
    end

    fileSystem = {
        list = listDirectory,
        combine = combinePath,
        isDir = isDirectory,
        exists = pathExists,
        makeDir = makeDirectory,
        open = io.open,
        getDir = getDirectory,
        readAll = function(file) return file:read("*all") end,
        write = function(file, data) file:write(data) end,
        close = function(file) file:close() end
    }
end

--------------------------------------------------------
-- Main
--------------------------------------------------------

print("Starting documentation generation...")
print("Source directory: " .. SRC_DIR)
print("Output directory: " .. OUT_DIR)

if not fileSystem.exists(OUT_DIR) then
    print("Output directory does not exist, creating it...")
    fileSystem.makeDir(OUT_DIR)
else
    print("Output directory already exists")
end

local function getLuaFiles(dir)
    print("Scanning directory: " .. dir)
    if not fileSystem.exists(dir) then
        print("Directory does not exist: " .. dir)
        return {}
    end

    local files = {}
    local list = fileSystem.list(dir)
    print("Found " .. #list .. " items in " .. dir)

    for _, item in ipairs(list) do
        local path = fileSystem.combine(dir, item)
        if fileSystem.isDir(path) then
            print("  -> Directory, scanning recursively: " .. path)
            local subFiles = getLuaFiles(path)
            for _, subFile in ipairs(subFiles) do
                table.insert(files, subFile)
            end
        elseif item:match("%.lua$") then
            print("  -> Lua file found: " .. path)
            table.insert(files, path)
        else
            print("  -> Skipping: " .. item)
        end
    end
    return files
end

local luaFiles = getLuaFiles(SRC_DIR)
print("Found " .. #luaFiles .. " Lua files to process")

for _, filePath in ipairs(luaFiles) do
    local file = fileSystem.open(filePath, "r")
    if file then
        local content = fileSystem.readAll(file)
        fileSystem.close(file)

        local ast = BasaltDoc.parse(content)
        local markdown = BasaltDoc.generateMarkdown(ast)

        local relativePath = filePath:gsub("^" .. SRC_DIR .. "/", ""):gsub("%.lua$", ".md")
        local outPath = fileSystem.combine(OUT_DIR, relativePath)

        local outDir = fileSystem.getDir(outPath)
        if outDir and outDir ~= "" and not fileSystem.exists(outDir) then
            fileSystem.makeDir(outDir)
        end

        local outFile = fileSystem.open(outPath, "w")
        if outFile then
            fileSystem.write(outFile, table.concat(markdown, "\n"))
            fileSystem.close(outFile)
            print("Generated: " .. outPath)
        else
            print("Error writing: " .. outPath)
        end
    else
        print("Error reading: " .. filePath)
    end
end

print("Documentation generation complete.")

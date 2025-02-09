
local args = {...}

local basaltPath = args[1] or "basalt"

local defaultPath = package.path
local format = "path;/path/?.lua;/path/?/init.lua;"

local main = format:gsub("path", basaltPath)
package.path = main.."rom/?"

local function errorHandler(err)
    local errorManager = require("errorManager")
    errorManager.header = "Basalt Loading Error"
    errorManager.error(err)
end

-- Use xpcall with error handler
local ok, result = pcall(require, "main")

if not ok then
    errorHandler(result)
else
    return result
end
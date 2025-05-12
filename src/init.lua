local args = {...}
local basaltPath = fs.getDir(args[2])

local defaultPath = package.path
local format = "path;/path/?.lua;/path/?/init.lua;"

local main = format:gsub("path", basaltPath)
package.path = main.."rom/?;"..defaultPath

local function errorHandler(err)
    package.path = main.."rom/?"
    local errorManager = require("errorManager")
    package.path = defaultPath
    errorManager.header = "Basalt Loading Error"
    errorManager.error(err)
end

local ok, result = pcall(require, "main")
package.loaded.log = nil

package.path = defaultPath
if not ok then
    errorHandler(result)
else
    return result
end
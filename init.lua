-- Development shim: the framework lives in src/. This keeps
-- require("Basalt3") (and the examples in this folder) working when running
-- straight from the repository. Release builds bundle src/ into one file.
local args = { ... }
local dir = fs.getDir(args[2] or "Basalt3")
local initPath = fs.combine(dir, "src/init.lua")
return assert(loadfile(initPath, nil, _ENV))(args[1], initPath)

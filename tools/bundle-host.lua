-- Host-Lua compatibility runner for tools/bundle.lua.
--
-- The bundler uses the small CraftOS fs/shell API. This file provides the
-- required subset with standard Lua so release bundles can be built without
-- running CraftOS-PC.

local cliArgs = { ... }
local separator = package.config:sub(1, 1)

local function normalize(path)
    return (path:gsub("[/\\]", separator))
end

local function combine(...)
    local result = ""
    for index = 1, select("#", ...) do
        local part = normalize(tostring(select(index, ...)))
        if part ~= "" then
            if result == "" then
                result = part
            else
                result = result:gsub("[/\\]+$", "")
                    .. separator
                    .. part:gsub("^[/\\]+", "")
            end
        end
    end
    return result
end

local function getDir(path)
    path = normalize(path):gsub("[/\\]+$", "")
    return path:match("^(.*)[/\\][^/\\]+$") or ""
end

local function exists(path)
    local handle = io.open(path, "rb")
    if handle then
        handle:close()
        return true
    end
    local ok, _, code = os.rename(path, path)
    return ok or code == 13
end

local function shellQuote(path)
    if separator == "\\" then
        return '"' .. path:gsub('"', '""') .. '"'
    end
    return "'" .. path:gsub("'", "'\\''") .. "'"
end

local function list(path)
    local command
    if separator == "\\" then
        command = "dir /b /a " .. shellQuote(path)
    else
        command = "find " .. shellQuote(path)
            .. " -mindepth 1 -maxdepth 1 -printf '%f\\n'"
    end

    local process = assert(io.popen(command, "r"))
    local entries = {}
    for entry in process:lines() do
        entries[#entries + 1] = entry
    end
    local ok = process:close()
    if ok == nil then
        error("bundle-host: cannot list " .. path, 0)
    end
    return entries
end

local function open(path, mode)
    local handle = io.open(path, mode == "r" and "rb" or "wb")
    if not handle then return nil end
    return {
        readAll = function()
            return handle:read("*a")
        end,
        write = function(content)
            handle:write(content)
        end,
        close = function()
            handle:close()
        end,
    }
end

local runningProgram = arg and arg[0] or "tools/bundle-host.lua"
local toolsDir = getDir(runningProgram)
if toolsDir == "" then toolsDir = "tools" end
local bundlePath = combine(toolsDir, "bundle.lua")

fs = {
    combine = combine,
    exists = exists,
    getDir = getDir,
    list = list,
    open = open,
}
shell = {
    getRunningProgram = function()
        return bundlePath
    end,
}

local runBundle = assert(loadfile(bundlePath))
local unpackArgs = table.unpack or unpack
return runBundle(unpackArgs(cliArgs))

---@class Log
---@field _logs table
---@field _enabled boolean
---@field _logToFile boolean
---@field _logFile string
local Log = {}
Log._logs = {}
Log._enabled = true
Log._logToFile = true
Log._logFile = "basalt.log"

fs.delete(Log._logFile)

Log.LEVEL = {
    DEBUG = 1,
    INFO = 2,
    WARN = 3,
    ERROR = 4
}

local levelMessages = {
    [Log.LEVEL.DEBUG] = "Debug",
    [Log.LEVEL.INFO] = "Info",
    [Log.LEVEL.WARN] = "Warn",
    [Log.LEVEL.ERROR] = "Error"
}

local levelColors = {
    [Log.LEVEL.DEBUG] = colors.lightGray,
    [Log.LEVEL.INFO] = colors.white,
    [Log.LEVEL.WARN] = colors.yellow,
    [Log.LEVEL.ERROR] = colors.red
}

--- Sets if the logger should log to a file.
function Log.setLogToFile(enable)
    Log._logToFile = enable
end

--- sets if the logger should log
function Log.setEnabled(enable)
    Log._enabled = enable
end

local function writeToFile(message)
    if Log._logToFile then
        local file = io.open(Log._logFile, "a")
        if file then
            file:write(message.."\n")
            file:close()
        end
    end
end

local function log(level, ...)
    if not Log._enabled then return end

    local timeStr = os.date("%H:%M:%S")

    local info = debug.getinfo(3, "Sl")
    local source = info.source:match("@?(.*)")
    local line = info.currentline
    local levelStr = string.format("[%s:%d]", source:match("([^/\\]+)%.lua$"), line)

    local levelMsg = "[" .. levelMessages[level] .. "]"

    local message = ""
    for i, v in ipairs(table.pack(...)) do
        if i > 1 then
            message = message .. " "
        end
        message = message .. tostring(v)
    end

    local fullMessage = string.format("%s %s%s %s", timeStr, levelStr, levelMsg, message)

    writeToFile(fullMessage)
    table.insert(Log._logs, {
        time = timeStr,
        level = level,
        message = message
    })
end

--- Sends a debug message to the logger.
--- @vararg string The message to log
function Log.debug(...) log(Log.LEVEL.DEBUG, ...) end
--- Sends an info message to the logger.
--- @vararg string The message to log
function Log.info(...) log(Log.LEVEL.INFO, ...) end
--- Sends a warning message to the logger.
--- @vararg string The message to log
function Log.warn(...) log(Log.LEVEL.WARN, ...) end
--- Sends an error message to the logger.
--- @vararg string The message to log
function Log.error(...) log(Log.LEVEL.ERROR, ...) end

Log.info("Logger initialized")

return Log
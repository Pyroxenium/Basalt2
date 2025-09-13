local logger = {}

local logFile

function logger.init()
    if not logFile then
        logFile = io.open("BasaltDoc/debug_log.txt", "w")
    end
end

function logger.log(message)
    if not logFile then logger.init() end
    if logFile then
        logFile:write(os.date("%Y-%m-%d %H:%M:%S") .. ": " .. message .. "\n")
        logFile:flush()
    end
end

function logger.close()
    if logFile then
        logFile:close()
        logFile = nil
    end
end

return logger

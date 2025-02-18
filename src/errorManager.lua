local LOGGER = require("log")

--- This is Basalt's error handler. All the errors are handled by this module.
--- @class ErrorHandler
--- @field tracebackEnabled boolean If the error handler should print a stack trace
--- @field header string The header of the error message
local errorHandler = {
    tracebackEnabled = true,
    header = "Basalt Error"
}

local function coloredPrint(message, color)
    term.setTextColor(color)
    print(message)
    term.setTextColor(colors.white)
end

--- Handles an error
--- @param errMsg string The error message
--- @usage errorHandler.error("An error occurred")
function errorHandler.error(errMsg)
    if errorHandler.errorHandled then
        error()
    end
    term.setBackgroundColor(colors.black)

    term.clear()
    term.setCursorPos(1, 1)

    coloredPrint(errorHandler.header..":", colors.red)
    print()

    local level = 2
    local topInfo
    while true do
        local info = debug.getinfo(level, "Sl")
        if not info then break end
        topInfo = info
        level = level + 1
    end
    local info = topInfo or debug.getinfo(2, "Sl")
    local fileName = info.source:sub(2)
    local lineNumber = info.currentline
    local errorMessage = errMsg

        if(errorHandler.tracebackEnabled)then
            local stackTrace = debug.traceback()
            if stackTrace then
                --coloredPrint("Stack traceback:", colors.gray)
                for line in stackTrace:gmatch("[^\r\n]+") do
                    local fileNameInTraceback, lineNumberInTraceback = line:match("([^:]+):(%d+):")
                    if fileNameInTraceback and lineNumberInTraceback then
                        term.setTextColor(colors.lightGray)
                        term.write(fileNameInTraceback)
                        term.setTextColor(colors.gray)
                        term.write(":")
                        term.setTextColor(colors.lightBlue)
                        term.write(lineNumberInTraceback)
                        term.setTextColor(colors.gray)
                        line = line:gsub(fileNameInTraceback .. ":" .. lineNumberInTraceback, "")
                    end
                    coloredPrint(line, colors.gray)
                end
                print()
            end
        end

    if fileName and lineNumber then
        term.setTextColor(colors.red)
        term.write("Error in ")
        term.setTextColor(colors.white)
        term.write(fileName)
        term.setTextColor(colors.red)
        term.write(":")
        term.setTextColor(colors.lightBlue)
        term.write(lineNumber)
        term.setTextColor(colors.red)
        term.write(": ")


        if errorMessage then
            errorMessage = string.gsub(errorMessage, "stack traceback:.*", "")
            if errorMessage ~= "" then
                coloredPrint(errorMessage, colors.red)
            else
                coloredPrint("Error message not available", colors.gray)
            end
        else
            coloredPrint("Error message not available", colors.gray)
        end

        local file = fs.open(fileName, "r")
        if file then
            local lineContent = ""
            local currentLineNumber = 1
            repeat
                lineContent = file.readLine()
                if currentLineNumber == tonumber(lineNumber) then
                    coloredPrint("\149Line " .. lineNumber, colors.cyan)
                    coloredPrint(lineContent, colors.lightGray)
                    break
                end
                currentLineNumber = currentLineNumber + 1
            until not lineContent
            file.close()
        end
    end

    term.setBackgroundColor(colors.black)
    LOGGER.error(errMsg)
    errorHandler.errorHandled = true
    error()
end

return errorHandler
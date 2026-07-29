-- Error handling for Basalt 2.
--
-- errors.parse() turns an error + traceback into structured info and is
-- side-effect free (testable). errors.show() renders the error screen; it
-- must be called AFTER the terminal/palette has been cleaned up, so the
-- message is never displayed with hijacked palette slots.
--
-- The screen highlights two locations:
--  * the error site (where it was thrown, often inside Basalt 2)
--  * the first stack frame in USER code — that's usually the actual cause,
--    so its source line is shown as an excerpt.

local require, basaltDir = ...

---@class BasaltErrorInfo
---@field message string Normalized error message
---@field file? string Source file of the error site
---@field line? integer Source line of the error site
---@field userFile? string Source file of the first user-code frame
---@field userLine? integer Source line of the first user-code frame
---@field trace string[] Cleaned traceback lines

---@class BasaltWrappedError
---@field __basaltError boolean Wrapped-error marker
---@field err any Original error value
---@field trace? string Captured traceback

local errors = {}

---@param s string Text to trim
---@return string trimmed
local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

---@param file string Source identifier
---@return boolean|integer internal
local function isInternal(file)
    return file == "[C]"
        or file:sub(1, 1) == "("            -- e.g. (...tail calls...)
        or file:find("^reactive{")           -- compiled reactive expressions
        or (basaltDir ~= "" and file:find(basaltDir, 1, true) == 1)
end

--- Normalizes an error value and traceback into displayable lines.
---@param err any Error value
---@param trace? string Traceback text
---@return BasaltErrorInfo info
function errors.parse(err, trace)
    local msg = tostring(err)
    local file, line, rest = msg:match("^(.-):(%d+): (.*)$")

    local lines = {}
    if trace then
        for tl in trace:gmatch("[^\n]+") do
            tl = trim(tl)
            if tl ~= "" and tl ~= "stack traceback:"
                and not tl:find("in function 'xpcall'", 1, true) then
                lines[#lines + 1] = tl
            end
        end
    end

    local userFile, userLine
    for _, tl in ipairs(lines) do
        local f, l = tl:match("^(.-):(%d+):")
        if f and not isInternal(f) then
            userFile, userLine = f, tonumber(l)
            break
        end
    end

    return {
        message = rest or msg,
        file = file,
        line = line and tonumber(line),
        userFile = userFile,
        userLine = userLine,
        trace = lines,
    }
end

---@param text any Text to print
---@param color number Text color
local function cprint(text, color)
    term.setTextColor(color)
    print(text)
end

---@param file string Source file
---@param lineNo integer One-based line number
---@return string|nil line
local function readSourceLine(file, lineNo)
    if not fs.exists(file) or fs.isDir(file) then return nil end
    local h = fs.open(file, "r")
    if not h then return nil end
    local content, n = nil, 0
    repeat
        content = h.readLine()
        n = n + 1
    until n == lineNo or content == nil
    h.close()
    return content
end

--- Renders an error screen on the active terminal.
---@param err any Error value
---@param trace? string Traceback text
---@param showTrace? boolean Whether traceback lines are shown
function errors.show(err, trace, showTrace)
    local info = errors.parse(err, trace)

    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1, 1)

    cprint("Basalt Error", colors.red)
    print()
    cprint(info.message, colors.white)
    print()

    -- source excerpt: prefer the user's code over the throw site
    local exFile = info.userFile or info.file
    local exLine = info.userLine or info.line
    if exFile and exLine then
        local src = readSourceLine(exFile, exLine)
        cprint("\26 " .. exFile .. ":" .. exLine, colors.cyan)
        if src then cprint("  " .. trim(src), colors.lightGray) end
        print()
    end

    if showTrace ~= false and #info.trace > 0 then
        cprint("Traceback:", colors.gray)
        for i = 1, math.min(#info.trace, 6) do
            local tl = info.trace[i]
            local f = tl:match("^(.-):%d+:")
            cprint("  " .. tl, (f and not isInternal(f))
                and colors.lightGray or colors.gray)
        end
        if #info.trace > 6 then
            cprint("  ... (" .. (#info.trace - 6) .. " more)", colors.gray)
        end
        print()
    end

    cprint("Press any key to exit", colors.orange)
        while true do
            ---@diagnostic disable-next-line: undefined-field
            local e = os.pullEventRaw()
        if e == "key" or e == "mouse_click"
            or e == "monitor_touch" or e == "terminate" then
            break
        end
    end

    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    term.setCursorPos(1, 1)
end

--- Wraps an error and traceback for Basalt's protected event loop.
---@param err any Error value
---@param trace? string Traceback text
---@return BasaltWrappedError wrapped
function errors.wrap(err, trace)
    return setmetatable({ __basaltError = true, err = err, trace = trace }, {
        __tostring = function(t) return tostring(t.err) end,
    })
end

return errors

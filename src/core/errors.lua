-- Error handling for Basalt3.
--
-- errors.parse() turns an error + traceback into structured info and is
-- side-effect free (testable). errors.show() renders the error screen; it
-- must be called AFTER the terminal/palette has been cleaned up, so the
-- message is never displayed with hijacked palette slots.
--
-- The screen highlights two locations:
--  * the error site (where it was thrown, often inside Basalt3)
--  * the first stack frame in USER code — that's usually the actual cause,
--    so its source line is shown as an excerpt.

local require, basaltDir = ...

local errors = {}

local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

local function isInternal(file)
    return file == "[C]"
        or file:sub(1, 1) == "("            -- e.g. (...tail calls...)
        or file:find("^reactive{")           -- compiled reactive expressions
        or (basaltDir ~= "" and file:find(basaltDir, 1, true) == 1)
end

--- Parses an error value and an optional traceback into a table:
--- message, file, line (error site), userFile, userLine (first user frame),
--- trace (cleaned traceback lines).
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

local function cprint(text, color)
    term.setTextColor(color)
    print(text)
end

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

--- Renders the error screen and waits for a key press.
--- showTrace=false hides the traceback section.
function errors.show(err, trace, showTrace)
    local info = errors.parse(err, trace)

    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1, 1)

    cprint("Basalt 2.5 Error", colors.red)
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

--- Wraps an error value so the runtime keeps an already-captured traceback
--- (used for coroutine errors, where the stack is gone once resume returns).
--- tostring() falls back to the original message, so a wrapped error that
--- escapes to the shell still prints readably.
function errors.wrap(err, trace)
    return setmetatable({ __basaltError = true, err = err, trace = trace }, {
        __tostring = function(t) return tostring(t.err) end,
    })
end

return errors

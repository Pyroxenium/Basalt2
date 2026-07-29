-- Program: runs another CC program inside the element.
--
--   local prog = frame:addProgram({ x = 2, y = 2, width = 30, height = 12 })
--   prog:execute("rom/programs/fun/worm.lua")
--
-- The program draws into an invisible window; its content is copied into
-- the render buffer every frame. Mouse events arrive element-relative when
-- the element is hit, keyboard events while it is focused, and every other
-- event (timers, redstone, ...) is forwarded by a scheduled pump coroutine.
-- Fires "done"(ok, result) and "error"(err, traceback); without an error
-- handler a crashing program takes down the app through the normal Basalt 2
-- error screen (with the program's own traceback).

local require = ...
local class = require("core/class")
local Element = require("core/element")
local errors = require("core/errors")
local palette = require("core/palette")

---@class ProgramWindow : PaletteTerminal
---@field getSize fun(): integer, integer
---@field reposition fun(x: number, y: number, width: number, height: number)
---@field getLine fun(y: number): string?, string?, string?
---@field getCursorPos fun(): number, number
---@field getCursorBlink fun(): boolean
---@field getTextColor fun(): number
---@field native? fun(): ProgramWindow
---@field current? fun(): table
---@field redirect? fun(target: table): table

---@class ProgramPackedValues
---@field n integer Number of packed values
---@field [integer] any

---@class ProgramProcess
---@field window ProgramWindow Hosted window
---@field term table Current program redirect target
---@field args ProgramPackedValues Initial program arguments
---@field filter? string Yielded event filter
---@field co thread Program coroutine

---@class Program : Element
---@field public path string Resolved program path
---@field public running boolean Whether the program is active
---@field public env table<string, any>|false Globals merged into the environment
---@field private _proc? ProgramProcess Active hosted process
local Program = class.create("Program", Element)

-- events the element already receives through normal routing; everything
-- else is forwarded by the pump
---@type table<string, boolean>
local ROUTED = {
    mouse_click = true, mouse_up = true, mouse_drag = true,
    mouse_scroll = true, mouse_move = true,
    key = true, key_up = true, char = true, paste = true,
}

---@type fun(self: Program, proc: ProgramProcess, event: string, ...: any)
local resume -- forward declaration (used by property hooks)

-- Reactive properties are evaluated lazily, so their effective value may
-- change without class.__newindex running the property's onChange hook. Keep
-- the redirected CC window synchronized with the resolved element size at
-- render/event boundaries as well as for ordinary numeric assignments.
---@param self Program
---@param proc? ProgramProcess
---@param notify boolean
---@return boolean resized
local function syncWindowSize(self, proc, notify)
    if not proc or not proc.window then return false end
    local width = math.max(1, math.floor(tonumber(self.width) or 1))
    local height = math.max(1, math.floor(tonumber(self.height) or 1))
    local current_width, current_height = proc.window.getSize()
    if current_width == width and current_height == height then return false end

    proc.window.reposition(1, 1, width, height)
    if notify and resume then resume(self, proc, "term_resize") end
    return true
end

---@param self Program
local function onResize(self)
    local proc = rawget(self, "_proc")
    if proc then syncWindowSize(self, proc, true) end
end

--- Resolved path of the running program (read-only)
class.property(Program, "path", "", { visual = false })
--- Whether a program is currently running (read-only)
class.property(Program, "running", false, { visual = false, styleable = false })
--- Extra globals merged into the program environment
class.property(Program, "env", false, { visual = false })
--- Background color (false = transparent)
class.property(Program, "background", colors.black)
--- Width in terminal cells
class.property(Program, "width", 30, { onChange = onResize })
--- Height in terminal cells
class.property(Program, "height", 12, { onChange = onResize })

--- Fired when the program finishes, with (ok, result)
class.event(Program, "done")
--- Fired when the program crashes, with (err, traceback)
class.event(Program, "error")

---@param self Program
---@param proc ProgramProcess
---@param ok boolean
---@param result any
local function finish(self, proc, ok, result)
    if rawget(self, "_proc") == proc then
        rawset(self, "_proc", nil)
    end
    self.running = false
    self:fire("done", ok, result)
end

---@param result any
---@return boolean terminated
local function isTerminationError(result)
    local message = tostring(result or "")
    return message == "Terminated" or message:match(": Terminated$") ~= nil
end

---@param self Program
---@param proc ProgramProcess
---@param ok boolean
---@param result any
---@param terminating? boolean
local function afterResume(self, proc, ok, result, terminating)
    if not ok then
        -- os.pullEvent raises "Terminated" when it receives the native
        -- terminate event. Closing a hosted Program is therefore a normal
        -- completion, not an application crash.
        if terminating and isTerminationError(result) then
            finish(self, proc, true, nil)
            return
        end
        local trace = debug.traceback(proc.co) or ""
        finish(self, proc, false, result)
        if rawget(self, "_handlers").error then
            self:fire("error", result, trace)
        else
            error(errors.wrap(result, trace), 0)
        end
        return
    end
    proc.filter = result
    if coroutine.status(proc.co) == "dead" then
        finish(self, proc, true, result)
    end
    self:markDirty()
end

resume = function(self, proc, event, ...)
    local co = proc.co
    if not co or coroutine.status(co) == "dead" then return end
    if event ~= "term_resize" then
        syncWindowSize(self, proc, true)
        if rawget(self, "_proc") ~= proc or coroutine.status(co) == "dead" then return end
    end
    if proc.filter ~= nil and event ~= proc.filter and event ~= "terminate" then
        return
    end
    proc.filter = nil
    -- restore whatever the program had redirected to when it yielded
    -- (multishell-style), so program-internal redirects survive
    local previous = term.redirect(proc.term)
    local ok, result = coroutine.resume(co, event, ...)
    proc.term = term.current()
    term.redirect(previous)
    afterResume(self, proc, ok, result, event == "terminate")
end

---@param self Program
---@param path string
---@param win ProgramWindow
---@return table<string, any> environment
local function buildEnv(self, path, win)
    -- programs see the window as their terminal; term.redirect() around
    -- every resume makes term.current() correct inside the program
    win.native = function() return win end
    win.current = term.current
    win.redirect = term.redirect

    local env = setmetatable({}, { __index = _ENV })
    env.term = win
    if shell then
        env.shell, env.multishell = shell, multishell
    end
    if fs.exists("rom/modules/main/cc/require.lua") then
        local make = dofile("rom/modules/main/cc/require.lua").make
        env.require, env.package = make(env, fs.getDir(path))
    end
    local extra = self.env
    if type(extra) == "table" then
        for k, v in pairs(extra) do env[k] = v end
    end
    return env
end

--- Loads and starts a program; extra arguments are passed to it.
---@param path string Program path (resolved via shell if not found directly)
---@param ... any Program arguments
---@return self
---@usage prog:execute("rom/programs/fun/worm.lua")
function Program:execute(path, ...)
    self:stop()

    local resolved
    if fs.exists(path) and not fs.isDir(path) then
        resolved = path
    elseif shell then
        resolved = shell.resolveProgram(path)
    end
    if not resolved then
        error("Basalt Program: program not found: " .. tostring(path), 2)
    end

    local root = self:getRoot()
    local parentTerm = rawget(root, "term")
    if not parentTerm then
        error("Basalt Program: element must be inside a frame before execute()", 2)
    end

    local file = fs.open(resolved, "r")
    local content = file.readAll()
    file.close()

    local win = window.create(parentTerm, 1, 1, self.width, self.height, false)
    local fn, err = load(content, "@/" .. resolved, nil, buildEnv(self, resolved, win))
    if not fn then
        error("Basalt Program: failed to load " .. resolved .. ": " .. tostring(err), 2)
    end

    local proc = {
        window = win,
        term = win, -- the program's current redirect target between resumes
        args = table.pack(...),
        filter = nil,
    }
    proc.co = coroutine.create(fn)
    rawset(self, "_proc", proc)
    self.path = resolved
    self.running = true

    -- first resume: program arguments, run until the first yield
    local previous = term.redirect(win)
    local ok, result = coroutine.resume(proc.co,
        table.unpack(proc.args, 1, proc.args.n))
    proc.term = term.current()
    term.redirect(previous)
    afterResume(self, proc, ok, result)

    -- pump every non-routed event (timers, redstone, ...) into the program
    if rawget(self, "_proc") == proc then
        local basalt = require("main")
        basalt.schedule(function()
            while rawget(self, "_proc") == proc
                and coroutine.status(proc.co) ~= "dead" do
                ---@diagnostic disable-next-line: undefined-field
                local ev = table.pack(os.pullEventRaw())
                if not ROUTED[ev[1]] then
                    resume(self, proc, table.unpack(ev, 1, ev.n))
                end
            end
        end)
    end
    return self
end

--- Stops (closes) the running program coroutine. Unlike a program that
--- finishes on its own, a manual stop fires no "done" event.
---@return self
function Program:stop()
    local proc = rawget(self, "_proc")
    if not proc then return self end
    rawset(self, "_proc", nil)
    if proc.co and coroutine.close and coroutine.status(proc.co) ~= "dead" then
        coroutine.close(proc.co)
    end
    self.running = false
    return self
end

--- Requests a native, graceful program shutdown and then force-stops a
--- coroutine that ignored the terminate event. Programs using pullEventRaw
--- can release resources; programs using pullEvent end normally via the
--- conventional "Terminated" error.
---@return self
function Program:terminate()
    local proc = rawget(self, "_proc")
    if not proc then return self end
    resume(self, proc, "terminate")
    if rawget(self, "_proc") == proc then self:stop() end
    return self
end

--- Injects an event into the program (as if it came from the event queue).
---@param event string The event name
---@param ... any Event arguments
---@return self
function Program:sendEvent(event, ...)
    local proc = rawget(self, "_proc")
    if proc then resume(self, proc, event, ...) end
    return self
end

--- Initializes per-instance state and input handlers.
function Program:setup()
    Element.setup(self)
    self:on("click", function(s, btn, x, y)
        local proc = rawget(s, "_proc")
        if proc then resume(s, proc, "mouse_click", btn, x, y) end
    end)
    self:on("clickUp", function(s, btn, x, y)
        local proc = rawget(s, "_proc")
        if proc then resume(s, proc, "mouse_up", btn, x, y) end
    end)
    self:on("drag", function(s, btn, x, y)
        local proc = rawget(s, "_proc")
        if proc then resume(s, proc, "mouse_drag", btn, x, y) end
    end)
    self:on("scroll", function(s, dir, x, y)
        local proc = rawget(s, "_proc")
        if proc then resume(s, proc, "mouse_scroll", dir, x, y) end
    end)
end

--- Handles keyboard input while focused.
---@param event string The key event name (key, key_up, char, paste)
---@param a any Key code or typed text
---@param b? any Secondary key-event value
function Program:handleKey(event, a, b)
    local proc = rawget(self, "_proc")
    if proc then resume(self, proc, event, a, b) end
    Element.handleKey(self, event, a, b)
end

--- Stops the program before removing the element.
---@return self
function Program:destroy()
    self:terminate()
    Element.destroy(self)
    return self
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function Program:render(buf)
    Element.render(self, buf)
    local proc = rawget(self, "_proc")
    if not proc then return end
    syncWindowSize(self, proc, true)
    if rawget(self, "_proc") ~= proc then return end

    local win = proc.window
    local _, height = win.getSize()
    -- Programs that manage the window palette themselves (e.g. Obsidian's
    -- renderer) get their colors registered instead of silently reset.
    local translate = palette.windowTranslation(win)
    for y = 1, height do
        local text, fg, bg = win.getLine(y)
        if text then
            if translate then
                buf:rawBlit(1, y, text,
                    (fg:gsub(".", translate)), (bg:gsub(".", translate)))
            else
                buf:drawBlit(1, y, text, fg, bg)
            end
        end
    end

    local root = self:getRoot()
    if root.getFocused and root:getFocused() == self then
        local cx, cy = win.getCursorPos()
        self:setCursor(cx, cy, win.getCursorBlink(), win.getTextColor())
    end
end

return Program

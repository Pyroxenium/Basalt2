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
-- handler a crashing program takes down the app through the normal Basalt3
-- error screen (with the program's own traceback).

local require = ...
local class = require("core/class")
local Element = require("core/element")
local errors = require("core/errors")

local Program = class.create("Program", Element)

-- events the element already receives through normal routing; everything
-- else is forwarded by the pump
local ROUTED = {
    mouse_click = true, mouse_up = true, mouse_drag = true,
    mouse_scroll = true, mouse_move = true,
    key = true, key_up = true, char = true, paste = true,
}

local resume -- forward declaration (used by property hooks)

local function onResize(self)
    local proc = rawget(self, "_proc")
    if proc then
        proc.window.reposition(1, 1, self.width, self.height)
        resume(self, proc, "term_resize")
    end
end

class.property(Program, "path", "", { visual = false })
class.property(Program, "running", false, { visual = false, styleable = false })
class.property(Program, "env", false, { visual = false })
class.property(Program, "background", colors.black)
class.property(Program, "width", 30, { onChange = onResize })
class.property(Program, "height", 12, { onChange = onResize })

class.event(Program, "done")
class.event(Program, "error")

local function finish(self, proc, ok, result)
    if rawget(self, "_proc") == proc then
        rawset(self, "_proc", nil)
    end
    self.running = false
    self:fire("done", ok, result)
end

local function afterResume(self, proc, ok, result)
    if not ok then
        local trace = debug.traceback(proc.co) or ""
        finish(self, proc, false, result)
        if self._handlers.error then
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
    afterResume(self, proc, ok, result)
end

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
function Program:execute(path, ...)
    self:stop()

    local resolved
    if fs.exists(path) and not fs.isDir(path) then
        resolved = path
    elseif shell then
        resolved = shell.resolveProgram(path)
    end
    if not resolved then
        error("Basalt 2.5 Program: program not found: " .. tostring(path), 2)
    end

    local root = self:getRoot()
    local parentTerm = rawget(root, "term")
    if not parentTerm then
        error("Basalt 2.5 Program: element must be inside a frame before execute()", 2)
    end

    local file = fs.open(resolved, "r")
    local content = file.readAll()
    file.close()

    local win = window.create(parentTerm, 1, 1, self.width, self.height, false)
    local fn, err = load(content, "@/" .. resolved, nil, buildEnv(self, resolved, win))
    if not fn then
        error("Basalt 2.5 Program: failed to load " .. resolved .. ": " .. tostring(err), 2)
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
                local ev = table.pack(os.pullEventRaw())
                if not ROUTED[ev[1]] then
                    resume(self, proc, table.unpack(ev, 1, ev.n))
                end
            end
        end)
    end
    return self
end

--- Stops the running program (no "done" event is fired).
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

--- Injects an event into the program (as if it came from the event queue).
function Program:sendEvent(event, ...)
    local proc = rawget(self, "_proc")
    if proc then resume(self, proc, event, ...) end
    return self
end

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

function Program:handleKey(event, a, b)
    local proc = rawget(self, "_proc")
    if proc then resume(self, proc, event, a, b) end
    Element.handleKey(self, event, a, b)
end

function Program:destroy()
    self:stop()
    return Element.destroy(self)
end

function Program:render(buf)
    Element.render(self, buf)
    local proc = rawget(self, "_proc")
    if not proc then return end

    local win = proc.window
    local _, height = win.getSize()
    for y = 1, height do
        local text, fg, bg = win.getLine(y)
        if text then
            buf:drawBlit(1, y, text, fg, bg)
        end
    end

    local root = self:getRoot()
    if root.getFocused and root:getFocused() == self then
        local cx, cy = win.getCursorPos()
        self:setCursor(cx, cy, win.getCursorBlink(), win.getTextColor())
    end
end

return Program

local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local errorManager = require("errorManager")

--- @configDescription A program that runs in a window

--- This is the program class. It provides a program that runs in a window.
---@class Program : VisualElement
local Program = setmetatable({}, VisualElement)
Program.__index = Program

--- @property program table nil The program instance
Program.defineProperty(Program, "program", {default = nil, type = "table"})
--- @property path string "" The path to the program
Program.defineProperty(Program, "path", {default = "", type = "string"})
--- @property running boolean false Whether the program is running
Program.defineProperty(Program, "running", {default = false, type = "boolean"})
--- @property errorCallback function nil The error callback function
Program.defineProperty(Program, "errorCallback", {default = nil, type = "function"})

Program.defineEvent(Program, "*")

local BasaltProgram = {}
BasaltProgram.__index = BasaltProgram
local newPackage = dofile("rom/modules/main/cc/require.lua").make

---@private
function BasaltProgram.new(program, env, addEnvironment)
    local self = setmetatable({}, BasaltProgram)
    self.env = env or {}
    self.args = {}
    self.addEnvironment = addEnvironment == nil and true or addEnvironment
    self.program = program
    return self
end

local function createShellEnv(dir)
    local env = { shell = shell, multishell = multishell }
    env.require, env.package = newPackage(env, dir)
    return env
end

---@private
function BasaltProgram:run(path, width, height)
    self.window = window.create(self.program:getBaseFrame():getTerm(), 1, 1, width, height, false)
    local pPath = shell.resolveProgram(path) or fs.exists(path) and path or nil
    if(pPath~=nil)then
        if(fs.exists(pPath)) then
            local file = fs.open(pPath, "r")
            local content = file.readAll()
            file.close()

            local env = setmetatable(createShellEnv(fs.getDir(path)), { __index = _ENV })
            env.term = self.window
            env.term.current = term.current
            env.term.native = function ()
                return self.window
            end
            if(self.addEnvironment)then
                for k,v in pairs(self.env) do
                    env[k] = v
                end
            else
                env = self.env
            end


            self.coroutine = coroutine.create(function()
                local program = load(content, "@/" .. path, nil, env)
                if program then
                    local result = program(table.unpack(self.args))
                    return result
                end
            end)
            local current = term.current()
            term.redirect(self.window)
            local ok, result = coroutine.resume(self.coroutine)
            term.redirect(current)
            if not ok then
                local errorCallback = self.program.get("errorCallback")
                if errorCallback then
                    local trace = debug.traceback(self.coroutine, result)
                    local _result = errorCallback(self.program, result, trace:gsub(result, ""))
                    if(_result==false)then
                        self.filter = nil
                        return ok, result
                    end
                end
                errorManager.header = "Basalt Program Error ".. path
                errorManager.error(result)
            end
        else
            errorManager.header = "Basalt Program Error ".. path
            errorManager.error("File not found")
        end
    else
        errorManager.header = "Basalt Program Error"
        errorManager.error("Program "..path.." not found")
    end
end

---@private
function BasaltProgram:resize(width, height)
    self.window.reposition(1, 1, width, height)
end

---@private
function BasaltProgram:resume(event, ...)
    local args = {...}
    if(event:find("mouse_"))then
        args[2], args[3] = self.program:getRelativePosition(args[2], args[3])
    end
    if self.coroutine==nil or coroutine.status(self.coroutine)=="dead" then self.program.set("running", false) return end
    if(self.filter~=nil)then
        if(event~=self.filter)then return end
        self.filter=nil
    end
    local current = term.current()
    term.redirect(self.window)
    local ok, result = coroutine.resume(self.coroutine, event, table.unpack(args))
    term.redirect(current)

    if ok then
        self.filter = result
    else
        local errorCallback = self.program.get("errorCallback")
        if errorCallback then
            local trace = debug.traceback(self.coroutine, result)
            local _result = errorCallback(self.program, result, trace:gsub(result, ""))
            if(_result==false)then
                self.filter = nil
                return ok, result
            end
        end
        errorManager.header = "Basalt Program Error"
        errorManager.error(result)
    end
    return ok, result
end

---@private
function BasaltProgram:stop()
    if self.coroutine==nil or coroutine.status(self.coroutine)=="dead" then self.program.set("running", false) return end
    coroutine.close(self.coroutine)
    self.coroutine = nil
end

--- @shortDescription Creates a new Program instance
--- @return Program object The newly created Program instance
--- @private
function Program.new()
    local self = setmetatable({}, Program):__init()
    self.class = Program
    self.set("z", 5)
    self.set("width", 30)
    self.set("height", 12)
    return self
end

--- @shortDescription Initializes the Program instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Program self The initialized instance
--- @protected
function Program:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Program")
    return self
end

--- Executes a program
--- @shortDescription Executes a program
--- @param path string The path to the program
--- @param env? table The environment to run the program in
--- @param addEnvironment? boolean Whether to add the environment to the program's environment (false = overwrite instead of adding)
--- @return Program self The Program instance
function Program:execute(path, env, addEnvironment)
    self.set("path", path)
    self.set("running", true)
    local program = BasaltProgram.new(self, env, addEnvironment)
    self.set("program", program)
    program:run(path, self.get("width"), self.get("height"))
    self:updateRender()
    return self
end

--- Stops the program
--- @shortDescription Stops the program
--- @return Program self The Program instance
function Program:stop()
    local program = self.get("program")
    if program then
        program:stop()
        self.set("running", false)
        self.set("program", nil)
    end
    return self
end

--- Sends an event to the program
--- @shortDescription Sends an event to the program
--- @param event string The event to send
--- @param ... any The event arguments
--- @return Program self The Program instance
function Program:sendEvent(event, ...)
    self:dispatchEvent(event, ...)
    return self
end

--- Registers a callback for the program's error event, if the function returns false, the program won't stop
--- @shortDescription Registers a callback for the program's error event
--- @param fn function The callback function to register
--- @return Program self The Program instance
function Program:onError(fn)
    self.set("errorCallback", fn)
    return self
end

--- @shortDescription Handles all incomming events
--- @param event string The event to handle
--- @param ... any The event arguments
--- @return any result The event result
--- @protected
function Program:dispatchEvent(event, ...)
    local program = self.get("program")
    local result = VisualElement.dispatchEvent(self, event, ...)
    if program then
        program:resume(event, ...)
        if(self.get("focused"))then
            local cursorBlink = program.window.getCursorBlink()
            local cursorX, cursorY = program.window.getCursorPos()
            self:setCursor(cursorX, cursorY, cursorBlink, program.window.getTextColor())
        end
        self:updateRender()
    end
    return result
end

--- @shortDescription Gets called when the element gets focused
--- @protected
function Program:focus()
    if(VisualElement.focus(self))then
        local program = self.get("program")
        if program then
            local cursorBlink = program.window.getCursorBlink()
            local cursorX, cursorY = program.window.getCursorPos()
            self:setCursor(cursorX, cursorY, cursorBlink, program.window.getTextColor())
        end
    end
end

--- @shortDescription Renders the program
--- @protected
function Program:render()
    VisualElement.render(self)
    local program = self.get("program")
    if program then
        local _, height = program.window.getSize()
        for y = 1, height do
            local text, fg, bg = program.window.getLine(y)
            if text then
                self:blit(1, y, text, fg, bg)
            end
        end
    end
end

return Program
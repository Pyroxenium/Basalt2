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

Program.defineEvent(Program, "key")
Program.defineEvent(Program, "char")
Program.defineEvent(Program, "key_up")
Program.defineEvent(Program, "paste")
Program.defineEvent(Program, "mouse_click")
Program.defineEvent(Program, "mouse_drag")
Program.defineEvent(Program, "mouse_scroll")
Program.defineEvent(Program, "mouse_up")

local BasaltProgram = {}
BasaltProgram.__index = BasaltProgram
local newPackage = dofile("rom/modules/main/cc/require.lua").make

---@private
function BasaltProgram.new()
    local self = setmetatable({}, BasaltProgram)
    self.env = {}
    self.args = {}
    return self
end

---@private
function BasaltProgram:run(path, width, height)
    self.window = window.create(term.current(), 1, 1, width, height, false)
    local pPath = shell.resolveProgram(path)
    if(pPath~=nil)then
        if(fs.exists(pPath)) then
            local file = fs.open(pPath, "r")
            local content = file.readAll()
            file.close()
            local env = setmetatable(self.env, {__index=_ENV})
            env.shell = shell
            env.term = self.window
            env.require, env.package = newPackage(env, fs.getDir(pPath))
            env.term.current = term.current
            env.term.redirect = term.redirect
            env.term.native = term.native

            self.coroutine = coroutine.create(function()
                local program = load(content, path, "bt", env)
                if program then
                    local current = term.current()
                    term.redirect(self.window)
                    local result = program(path, table.unpack(self.args))
                    term.redirect(current)
                    return result
                end
            end)
            local current = term.current()
            term.redirect(self.window)
            local ok, result = coroutine.resume(self.coroutine)
            term.redirect(current)
            if not ok then
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
    if self.coroutine==nil or coroutine.status(self.coroutine)=="dead" then return end
    if(self.filter~=nil)then
        if(event~=self.filter)then return end
        self.filter=nil
    end
    local current = term.current()
    term.redirect(self.window)
    local ok, result = coroutine.resume(self.coroutine, event, ...)
    term.redirect(current)

    if ok then
        self.filter = result
    else
        errorManager.header = "Basalt Program Error"
        errorManager.error(result)
    end
    return ok, result
end

---@private
function BasaltProgram:stop()

end

--- Creates a new Program instance
--- @shortDescription Creates a new Program instance
--- @return Program object The newly created Program instance
--- @usage local element = Program.new("myId", basalt)
function Program.new()
    local self = setmetatable({}, Program):__init()
    self.set("z", 5)
    self.set("width", 30)
    self.set("height", 12)
    return self
end

--- Initializes the Program instanceProperty
--- @shortDescription Initializes the Program instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Program self The initialized instance
function Program:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Program")
    return self
end

--- Executes a program
--- @shortDescription Executes a program
--- @param path string The path to the program
--- @return Program self The Program instance
function Program:execute(path)
    self.set("path", path)
    self.set("running", true)
    local program = BasaltProgram.new()
    self.set("program", program)
    program:run(path, self.get("width"), self.get("height"))
    self:updateRender()
    return self
end

--- Handles all incomming events
--- @shortDescription Handles all incomming events
--- @param event string The event to handle
--- @param ... any The event arguments
--- @return any result The event result
function Program:dispatchEvent(event, ...)
    local program = self.get("program")
    local result = VisualElement.dispatchEvent(self, event, ...)
    if program then
        program:resume(event, ...)
        if(self.get("focused"))then
            local cursorBlink = program.window.getCursorBlink()
            local cursorX, cursorY = program.window.getCursorPos()
            self:setCursor(cursorX, cursorY, cursorBlink)
        end
        self:updateRender()
    end
    return result
end

--- Gets called when the element gets focused
--- @shortDescription Gets called when the element gets focused
function Program:focus()
    if(VisualElement.focus(self))then
        local program = self.get("program")
        if program then
            local cursorBlink = program.window.getCursorBlink()
            local cursorX, cursorY = program.window.getCursorPos()
            self:setCursor(cursorX, cursorY, cursorBlink)
        end
    end
end

--- Renders the program
--- @shortDescription Renders the program
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
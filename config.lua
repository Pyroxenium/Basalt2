return {
  ["files"] = {
    ["libraries/expect.lua"] = "local errorManager = require("errorManager")

-- Simple type checking without stack traces
local function expect(position, value, expectedType)
    local valueType = type(value)

    if expectedType == "element" then
        if valueType == "table" and value.get("type") ~= nil then
            return true
        end
    end

    if expectedType == "color" then
        if valueType == "number" and value >= 1 and value <= 32768 then
            return true
        end
        if valueType == "string" and colors[value] then
            return true
        end
    end

    if valueType ~= expectedType then
        errorManager.header = "Basalt Type Error"
        errorManager.error(string.format(
            "Bad argument #%d: expected %s, got %s",
            position,
            expectedType,
            valueType
        ))
    end

    return true
end

return expect",
    ["elements/BaseElement.lua"] = "local PropertySystem = require("propertySystem")
local uuid = require("/libraries/utils").uuid

--- The base class for all UI elements in Basalt
--- @class BaseElement : PropertySystem
local BaseElement = setmetatable({}, PropertySystem)
BaseElement.__index = BaseElement
BaseElement._events = {}

--- @property type string BaseElement The type identifier of the element
BaseElement.defineProperty(BaseElement, "type", {default = {"BaseElement"}, type = "string", setter=function(self, value)
    if type(value) == "string" then
        table.insert(self._values.type, 1, value)
        return self._values.type
    end
    return value
end, getter = function(self, _, index)
    if index~= nil and index < 1 then
        return self._values.type
    end
    return self._values.type[index or 1]
end})

--- @property id string BaseElement The unique identifier for the element
BaseElement.defineProperty(BaseElement, "id", {default = "", type = "string", readonly = true})

--- @property name string BaseElement The name of the element
BaseElement.defineProperty(BaseElement, "name", {default = "", type = "string"})

--- @property eventCallbacks table {} Table containing all registered event callbacks
BaseElement.defineProperty(BaseElement, "eventCallbacks", {default = {}, type = "table"})

--- Registers an event that this class can listen to
--- @param class table The class to add the event to
--- @param eventName string The name of the event to register
--- @usage BaseElement.listenTo(MyClass, "mouse_click")
function BaseElement.listenTo(class, eventName)
    if not class._events then
        class._events = {}
    end
    class._events[eventName] = true
end

--- Creates a new BaseElement instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return table The newly created BaseElement instance
--- @usage local element = BaseElement.new("myId", basalt)
function BaseElement.new()
    local self = setmetatable({}, BaseElement):__init()
    return self
end

--- Initializes the BaseElement instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return table self The initialized instance
function BaseElement:init(props, basalt)
    self._props = props
    self._values.id = uuid()
    self.basalt = basalt
    self._registeredEvents = {}
    if BaseElement._events then
        for event in pairs(BaseElement._events) do
            self._registeredEvents[event] = true
            local handlerName = "on" .. event:gsub("_(%l)", function(c)
                return c:upper()
            end):gsub("^%l", string.upper)
            self[handlerName] = function(self, ...)
                self:registerCallback(event, ...)
                return self
            end
        end
    end
    return self
end

--- Post initialization hook
--- @return table self The BaseElement instance
function BaseElement:postInit()
    if(self._props)then
        for k,v in pairs(self._props)do
            self.set(k, v)
        end
    end
    self._props = nil
    return self
end

--- Checks if the element is a specific type
--- @param type string The type to check for
--- @return boolean Whether the element is of the specified type
function BaseElement:isType(type)
    for _, t in ipairs(self._values.type) do
        if t == type then
            return true
        end
    end
    return false
end

--- Enables or disables event listening for a specific event
--- @param eventName string The name of the event to listen for
--- @param enable? boolean Whether to enable or disable the event (default: true)
--- @return table self The BaseElement instance
--- @usage element:listenEvent("mouse_click", true)
function BaseElement:listenEvent(eventName, enable)
    enable = enable ~= false
    if enable ~= (self._registeredEvents[eventName] or false) then
        if enable then
            self._registeredEvents[eventName] = true
            if self.parent then
                self.parent:registerChildEvent(self, eventName)
            end
        else
            self._registeredEvents[eventName] = nil
            if self.parent then
                self.parent:unregisterChildEvent(self, eventName)
            end
        end
    end
    return self
end

--- Registers a callback function for an event
--- @param event string The event to register the callback for
--- @param callback function The callback function to register
--- @return table self The BaseElement instance
--- @usage element:registerCallback("mouse_click", function(self, ...) end)
function BaseElement:registerCallback(event, callback)
    if not self._registeredEvents[event] then
        self:listenEvent(event, true)
    end

    if not self._values.eventCallbacks[event] then
        self._values.eventCallbacks[event] = {}
    end

    table.insert(self._values.eventCallbacks[event], callback)
    return self
end

--- Triggers an event and calls all registered callbacks
--- @param event string The event to fire
--- @param ... any Additional arguments to pass to the callbacks
--- @return table self The BaseElement instance
--- @usage element:fireEvent("mouse_click", 1, 2)
function BaseElement:fireEvent(event, ...)
    if self._values.eventCallbacks[event] then
        for _, callback in ipairs(self._values.eventCallbacks[event]) do
            local result = callback(self, ...)
            return result
        end
    end
    return self
end

--- Handles all events
--- @param event string The event to handle
--- @vararg any The arguments for the event
--- @return boolean? handled Whether the event was handled
function BaseElement:dispatchEvent(event, ...)
    if self[event] then
        return self[event](self, ...)
    end
    return self:handleEvent(event, ...)
end

--- The default event handler for all events
--- @param event string The event to handle
--- @vararg any The arguments for the event
--- @return boolean? handled Whether the event was handled
function BaseElement:handleEvent(event, ...)
    return false
end

function BaseElement:getBaseFrame()
    if self.parent then
        return self.parent:getBaseFrame()
    end
    return self
end

function BaseElement:destroy()

end

--- Requests a render update for this element
--- @usage element:updateRender()
function BaseElement:updateRender()
    if(self.parent) then
        self.parent:updateRender()
    else
        self._renderUpdate = true
    end
end

return BaseElement",
    ["plugins/pluginTemplate.lua"] = "-- Will temporary exist so that we don't lose track of how the plugin system works

local VisualElement = {hooks={init={}}}

-- Called on Class level to define properties and setup before instance is created
function VisualElement.setup(element)
    element.defineProperty(element, "testProp", {default = 5, type = "number"})
end

-- Hooks into existing methods (you can also use init.pre or init.post)
function VisualElement.hooks.init(self)
    --self.basalt.LOGGER.debug("VisualElement initialized")
end

-- Adds a new method to the class
function VisualElement:testFunc()
    --self.basalt.LOGGER.debug("Hello World", self.get("testProp"))
end

return {
    VisualElement = VisualElement
}

",
    ["elements/VisualElement.lua"] = "local elementManager = require("elementManager")
local BaseElement = elementManager.getElement("BaseElement")
local tHex = require("libraries/colorHex")

---@alias color number

---@class VisualElement : BaseElement
local VisualElement = setmetatable({}, BaseElement)
VisualElement.__index = VisualElement

---@property x number 1 x position of the element
VisualElement.defineProperty(VisualElement, "x", {default = 1, type = "number", canTriggerRender = true})
---@property y number 1 y position of the element
VisualElement.defineProperty(VisualElement, "y", {default = 1, type = "number", canTriggerRender = true})
---@property z number 1 z position of the element
VisualElement.defineProperty(VisualElement, "z", {default = 1, type = "number", canTriggerRender = true, setter = function(self, value)
    if self.parent then
        self.parent:sortChildren()
    end
    return value
end})

---@property width number 1 width of the element
VisualElement.defineProperty(VisualElement, "width", {default = 1, type = "number", canTriggerRender = true})
---@property height number 1 height of the element
VisualElement.defineProperty(VisualElement, "height", {default = 1, type = "number", canTriggerRender = true})
---@property background color black background color of the element
VisualElement.defineProperty(VisualElement, "background", {default = colors.black, type = "number", canTriggerRender = true})
---@property foreground color white foreground color of the element
VisualElement.defineProperty(VisualElement, "foreground", {default = colors.white, type = "number", canTriggerRender = true})
---@property clicked boole an false element is currently clicked
VisualElement.defineProperty(VisualElement, "clicked", {default = false, type = "boolean"})
---@property backgroundEnabled boolean true whether the background is enabled
VisualElement.defineProperty(VisualElement, "backgroundEnabled", {default = true, type = "boolean", canTriggerRender = true})
---@property focused boolean false whether the element is focused
VisualElement.defineProperty(VisualElement, "focused", {default = false, type = "boolean", setter = function(self, value, internal)
    local curValue = self.get("focused")
    if value == curValue then return value end

    if value then
        self:focus()
    else
        self:blur()
    end

    if not internal and self.parent then
        if value then
            self.parent:setFocusedChild(self)
        else
            self.parent:setFocusedChild(nil)
        end
    end
    return value
end})

VisualElement.defineProperty(VisualElement, "visible", {default = true, type = "boolean", canTriggerRender = true, setter=function(self, value)
    if(self.parent~=nil)then
        self.parent.set("childrenSorted", false)
        self.parent.set("childrenEventsSorted", false)
    end
    return value
end})

VisualElement.combineProperties(VisualElement, "position", "x", "y")
VisualElement.combineProperties(VisualElement, "size", "width", "height")
VisualElement.combineProperties(VisualElement, "color", "foreground", "background")

VisualElement.listenTo(VisualElement, "focus")
VisualElement.listenTo(VisualElement, "blur")

local max, min = math.max, math.min

--- Creates a new VisualElement instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return VisualElement object The newly created VisualElement instance
--- @usage local element = VisualElement.new("myId", basalt)
function VisualElement.new()
    local self = setmetatable({}, VisualElement):__init()
    return self
end

function VisualElement:init(props, basalt)
    BaseElement.init(self, props, basalt)
    self.set("type", "VisualElement")
end

--- Draws a text character/fg/bg at the specified position with a certain size, used in the rendering system
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param width number The width of the element
--- @param height number The height of the element
--- @param text string The text char to draw
--- @param fg color The foreground color
--- @param bg color The background color
function VisualElement:multiBlit(x, y, width, height, text, fg, bg)
    x = x + self.get("x") - 1
    y = y + self.get("y") - 1
    self.parent:multiBlit(x, y, width, height, text, fg, bg)
end

--- Draws a text character at the specified position, used in the rendering system
--- @param x number The x position to draw
--- @param y number The y position to draw
--- @param text string The text char to draw
--- @param fg color The foreground color
function VisualElement:textFg(x, y, text, fg)
    x = x + self.get("x") - 1
    y = y + self.get("y") - 1
    self.parent:textFg(x, y, text, fg)
end

function VisualElement:textBg(x, y, text, bg)
    x = x + self.get("x") - 1
    y = y + self.get("y") - 1
    self.parent:textBg(x, y, text, bg)
end

function VisualElement:blit(x, y, text, fg, bg)
    x = x + self.get("x") - 1
    y = y + self.get("y") - 1
    self.parent:blit(x, y, text, fg, bg)
end

--- Checks if the specified coordinates are within the bounds of the element
--- @param x number The x position to check
--- @param y number The y position to check
--- @return boolean isInBounds Whether the coordinates are within the bounds of the element
function VisualElement:isInBounds(x, y)
    local xPos, yPos = self.get("x"), self.get("y")
    local width, height = self.get("width"), self.get("height")

    return x >= xPos and x <= xPos + width - 1 and
           y >= yPos and y <= yPos + height - 1
end

--- Handles a mouse click event
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean clicked Whether the element was clicked
function VisualElement:mouse_click(button, x, y)
    if self:isInBounds(x, y) then
        self.set("clicked", true)
        self:fireEvent("mouse_click", button, self:getRelativePosition(x, y))
        return true
    end
    return false
end

function VisualElement:mouse_up(button, x, y)
    self.set("clicked", false)
    if self:isInBounds(x, y) then
        self:fireEvent("mouse_up", button, x, y)
        return true
    end
    self:fireEvent("mouse_release", button, self:getRelativePosition(x, y))
end

function VisualElement:mouse_release()
    self.set("clicked", false)
end

function VisualElement:focus()
    self:fireEvent("focus")
end

function VisualElement:blur()
    self:fireEvent("blur")
    self:setCursor(1,1, false)
end

--- Returns the absolute position of the element or the given coordinates.
---@param x? number x position
---@param y? number y position
function VisualElement:getAbsolutePosition(x, y)
    local xPos, yPos = self.get("x"), self.get("y")
    if(x ~= nil) then
        xPos = xPos + x - 1
    end
    if(y ~= nil) then
        yPos = yPos + y - 1
    end

    local parent = self.parent
    while parent do
        local px, py = parent.get("x"), parent.get("y")
        xPos = xPos + px - 1
        yPos = yPos + py - 1
        parent = parent.parent
    end

    return xPos, yPos
end

--- Returns the relative position of the element or the given coordinates.
---@param x? number x position
---@param y? number y position
---@return number, number
function VisualElement:getRelativePosition(x, y)
    if (x == nil) or (y == nil) then
        x, y = self.get("x"), self.get("y")
    end

    local parentX, parentY = 1, 1
    if self.parent then
        parentX, parentY = self.parent:getRelativePosition()
    end

    local elementX = self.get("x")
    local elementY = self.get("y")

    return x - (elementX - 1) - (parentX - 1),
           y - (elementY - 1) - (parentY - 1)
end

function VisualElement:setCursor(x, y, blink)
    if self.parent then
        local absX, absY = self:getAbsolutePosition(x, y)
        absX = max(self.get("x"), min(absX, self.get("width") + self.get("x") - 1))
        return self.parent:setCursor(absX, absY, blink)
    end
end

--- Renders the element
--- @usage element:render()
function VisualElement:render()
    if(not self.get("backgroundEnabled"))then
        return
    end
    local width, height = self.get("width"), self.get("height")
    self:multiBlit(1, 1, width, height, " ", tHex[self.get("foreground")], tHex[self.get("background")])
end

return VisualElement",
    ["log.lua"] = "local Log = {}
Log._logs = {}
Log._enabled = true
Log._logToFile = true
Log._logFile = "basalt.log"

fs.delete(Log._logFile)

-- Log levels
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

function Log.setLogToFile(enable)
    Log._logToFile = enable
end

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

    -- Get caller info (skip log function and Log.debug/info/etc functions)
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

    -- File output
    writeToFile(fullMessage)
    -- Store in memory
    table.insert(Log._logs, {
        time = timeStr,
        level = level,
        message = message
    })
end

function Log.debug(...) log(Log.LEVEL.DEBUG, ...) end
function Log.info(...) log(Log.LEVEL.INFO, ...) end
function Log.warn(...) log(Log.LEVEL.WARN, ...) end
function Log.error(...) log(Log.LEVEL.ERROR, ...) end

Log.info("Logger initialized")

return Log",
    ["elements/Program.lua"] = "local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local errorManager = require("errorManager")

--TODO:
-- Rendering optimization (only render when screen changed)
-- Eventsystem improvement
-- Cursor is sometimes not visible on time

---@class Program : VisualElement
local Program = setmetatable({}, VisualElement)
Program.__index = Program

Program.defineProperty(Program, "program", {default = nil, type = "table"})
Program.defineProperty(Program, "path", {default = "", type = "string"})
Program.defineProperty(Program, "running", {default = false, type = "boolean"})

Program.listenTo(Program, "key")
Program.listenTo(Program, "char")
Program.listenTo(Program, "key_up")
Program.listenTo(Program, "paste")
Program.listenTo(Program, "mouse_click")
Program.listenTo(Program, "mouse_drag")
Program.listenTo(Program, "mouse_scroll")
Program.listenTo(Program, "mouse_up")

local BasaltProgram = {}
BasaltProgram.__index = BasaltProgram
local newPackage = dofile("rom/modules/main/cc/require.lua").make

function BasaltProgram.new()
    local self = setmetatable({}, BasaltProgram)
    self.env = {}
    self.args = {}
    return self
end

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

function BasaltProgram:resize(width, height)
    self.window.reposition(1, 1, width, height)
end

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

function BasaltProgram:stop()

end

--- Creates a new Program instance
--- @return Program object The newly created Program instance
--- @usage local element = Program.new("myId", basalt)
function Program.new()
    local self = setmetatable({}, Program):__init()
    self.set("z", 5)
    self.set("width", 30)
    self.set("height", 12)
    return self
end

function Program:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Program")
end

function Program:execute(path)
    self.set("path", path)
    self.set("running", true)
    local program = BasaltProgram.new()
    self.set("program", program)
    program:run(path, self.get("width"), self.get("height"))
    self:updateRender()
    return self
end

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

return Program",
    ["plugins/state.lua"] = "local PropertySystem = require("propertySystem")
local errorManager = require("errorManager")
local BaseElement = {}

function BaseElement.setup(element)
    element.defineProperty(element, "states", {default = {}, type = "table"})
    element.defineProperty(element, "computedStates", {default = {}, type = "table"})
    element.defineProperty(element, "stateUpdate", {
        default = {key = "", value = nil, oldValue = nil},
        type = "table"
    })
end

function BaseElement:initializeState(name, default, canTriggerRender, persist, path)
    local states = self.get("states")

    if states[name] then
        errorManager.error("State '" .. name .. "' already exists")
        return self
    end

    if persist then
        local file = path or ("states/" .. self.get("name") .. "_" .. name .. ".state")

        if fs.exists(file) then
            local f = fs.open(file, "r")
            states[name] = {
                value = textutils.unserialize(f.readAll()),
                persist = true,
                file = file
            }
            f.close()
        else
            states[name] = {
                value = default,
                persist = true,
                file = file,
                canTriggerRender = canTriggerRender
            }
        end
    else
        states[name] = {
            value = default,
            canTriggerRender = canTriggerRender
        }
    end
    return self
end

function BaseElement:setState(name, value)
    local states = self.get("states")
    if not states[name] then
        error("State '"..name.."' not initialized")
    end

    local oldValue = states[name].value
    states[name].value = value

    if states[name].persist then
        local dir = fs.getDir(states[name].file)
        if not fs.exists(dir) then
            fs.makeDir(dir)
        end
        local f = fs.open(states[name].file, "w")
        f.write(textutils.serialize(value))
        f.close()
    end

    if states[name].canTriggerRender then
        self:updateRender()
    end

    self.set("stateUpdate", {
        key = name,
        value = value,
        oldValue = oldValue
    })
    return self
end

function BaseElement:getState(name)
    local states = self.get("states")
    if not states[name] then
        errorManager.error("State '"..name.."' not initialized")
    end
    return states[name].value
end

function BaseElement:computed(key, computeFn)
    local computed = self.get("computedStates")
    computed[key] = setmetatable({}, {
        __call = function()
            return computeFn(self)
        end
    })
    return self
end

function BaseElement:shareState(stateKey, ...)
    local value = self:getState(stateKey)

    for _, element in ipairs({...}) do
        if element.get("states")[stateKey] then
            errorManager.error("Cannot share state '" .. stateKey .. "': Target element already has this state")
            return self
        end
        
        element:initializeState(stateKey, value)

        self:observe("stateUpdate", function(self, update)
            if update.key == stateKey then
                element:setState(stateKey, update.value)
            end
        end)
    end
    return self
end

function BaseElement:onStateChange(stateName, callback)
    if not self.get("states")[stateName] then
        errorManager.error("Cannot observe state '" .. stateName .. "': State not initialized")
        return self
    end

    self:observe("stateUpdate", function(self, update)
        if update.key == stateName then
            callback(self, update.value, update.oldValue)
        end
    end)
    return self
end

return {
    BaseElement = BaseElement
}
",
    ["elements/Table.lua"] = "local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")

---@class Table : VisualElement
local Table = setmetatable({}, VisualElement)
Table.__index = Table

Table.defineProperty(Table, "columns", {default = {}, type = "table"})
Table.defineProperty(Table, "data", {default = {}, type = "table", canTriggerRender = true})
Table.defineProperty(Table, "selectedRow", {default = nil, type = "number", canTriggerRender = true})
Table.defineProperty(Table, "headerColor", {default = colors.blue, type = "number"})
Table.defineProperty(Table, "selectedColor", {default = colors.lightBlue, type = "number"})
Table.defineProperty(Table, "gridColor", {default = colors.gray, type = "number"})
Table.defineProperty(Table, "sortColumn", {default = nil, type = "number"})
Table.defineProperty(Table, "sortDirection", {default = "asc", type = "string"})
Table.defineProperty(Table, "scrollOffset", {default = 0, type = "number", canTriggerRender = true})

Table.listenTo(Table, "mouse_click")
Table.listenTo(Table, "mouse_scroll")

function Table.new()
    local self = setmetatable({}, Table):__init()
    self.set("width", 30)
    self.set("height", 10)
    self.set("z", 5)
    return self
end

function Table:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Table")
    return self
end

function Table:setColumns(columns)
    -- Columns Format: {{name="ID", width=4}, {name="Name", width=10}}
    self.set("columns", columns)
    return self
end

function Table:setData(data)
    -- Data Format: {{"1", "Item One"}, {"2", "Item Two"}}
    self.set("data", data)
    return self
end

function Table:sortData(columnIndex)
    local data = self.get("data")
    local direction = self.get("sortDirection")
    
    table.sort(data, function(a, b)
        if direction == "asc" then
            return a[columnIndex] < b[columnIndex]
        else
            return a[columnIndex] > b[columnIndex]
        end
    end)
    
    self.set("data", data)
    return self
end

function Table:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end

    local relX, relY = self:getRelativePosition(x, y)

    -- Header-Click für Sorting
    if relY == 1 then
        local currentX = 1
        for i, col in ipairs(self.get("columns")) do
            if relX >= currentX and relX < currentX + col.width then
                if self.get("sortColumn") == i then
                    self.set("sortDirection", self.get("sortDirection") == "asc" and "desc" or "asc")
                else
                    self.set("sortColumn", i)
                    self.set("sortDirection", "asc")
                end
                self:sortData(i)
                break
            end
            currentX = currentX + col.width
        end
    end

    -- Row-Selection (berücksichtigt Scroll-Offset)
    if relY > 1 then
        local rowIndex = relY - 2 + self.get("scrollOffset")
        if rowIndex >= 0 and rowIndex < #self.get("data") then
            self.set("selectedRow", rowIndex + 1)
        end
    end

    return true
end

function Table:mouse_scroll(direction, x, y)
    local data = self.get("data")
    local height = self.get("height")
    local visibleRows = height - 2
    local maxScroll = math.max(0, #data - visibleRows + 1)  -- +1 korrigiert den Scroll-Bereich
    local newOffset = math.min(maxScroll, math.max(0, self.get("scrollOffset") + direction))

    self.set("scrollOffset", newOffset)
    return true
end

function Table:render()
    VisualElement.render(self)

    local columns = self.get("columns")
    local data = self.get("data")
    local selected = self.get("selectedRow")
    local sortCol = self.get("sortColumn")
    local scrollOffset = self.get("scrollOffset")
    local height = self.get("height")

    local currentX = 1
    for i, col in ipairs(columns) do
        local text = col.name
        if i == sortCol then
            text = text .. (self.get("sortDirection") == "asc" and "\30" or "\31")
        end
        self:textFg(currentX, 1, text:sub(1, col.width), self.get("headerColor"))
        currentX = currentX + col.width
    end

    -- Angepasste Berechnung der sichtbaren Zeilen
    local visibleRows = height - 2  -- Verfügbare Zeilen (minus Header)
    for y = 2, height do
        local rowIndex = y - 2 + scrollOffset
        local rowData = data[rowIndex + 1]

        -- Zeile nur rendern wenn es auch Daten dafür gibt
        if rowData and (rowIndex + 1) <= #data then  -- Korrigierte Bedingung
            currentX = 1
            local bg = (rowIndex + 1) == selected and self.get("selectedColor") or self.get("background")

            for i, col in ipairs(columns) do
                local cellText = rowData[i] or ""
                local paddedText = cellText .. string.rep(" ", col.width - #cellText)
                self:blit(currentX, y, paddedText,
                    string.rep(tHex[self.get("foreground")], col.width),
                    string.rep(tHex[bg], col.width))
                currentX = currentX + col.width
            end
        else
            -- Leere Zeile füllen
            self:blit(1, y, string.rep(" ", self.get("width")),
                string.rep(tHex[self.get("foreground")], self.get("width")),
                string.rep(tHex[self.get("background")], self.get("width")))
        end
    end

    -- Scrollbar Berechnung überarbeitet
    if #data > height - 2 then
        local scrollbarHeight = height - 2
        local thumbSize = math.max(1, math.floor(scrollbarHeight * (height - 2) / #data))
        
        -- Thumb Position korrigiert
        local maxScroll = #data - (height - 2) + 1  -- +1 für korrekte End-Position
        local scrollPercent = scrollOffset / maxScroll
        local thumbPos = 2 + math.floor(scrollPercent * (scrollbarHeight - thumbSize))
        
        if scrollOffset >= maxScroll then
            thumbPos = height - thumbSize  -- Exakt am Ende
        end

        -- Scrollbar Background
        for y = 2, height do
            self:blit(self.get("width"), y, "\127", tHex[colors.gray], tHex[colors.gray])
        end

        -- Thumb zeichnen
        for y = thumbPos, math.min(height, thumbPos + thumbSize - 1) do
            self:blit(self.get("width"), y, "\127", tHex[colors.white], tHex[colors.white])
        end
    end
end

return Table",
    ["init.lua"] = "local args = {...}
local basaltPath = fs.getDir(args[2])

local defaultPath = package.path
local format = "path;/path/?.lua;/path/?/init.lua;"

local main = format:gsub("path", basaltPath)
package.path = main.."rom/?"

local function errorHandler(err)
    local errorManager = require("errorManager")
    errorManager.header = "Basalt Loading Error"
    errorManager.error(err)
end

local ok, result = pcall(require, "main")

package.path = defaultPath
if not ok then
    errorHandler(result)
else
    return result
end",
    ["elements/Slider.lua"] = "local VisualElement = require("elements/VisualElement")

---@class Slider : VisualElement
local Slider = setmetatable({}, VisualElement)
Slider.__index = Slider

---@property step number 1 Current step position (1 to width/height)
Slider.defineProperty(Slider, "step", {default = 1, type = "number", canTriggerRender = true})
---@property max number 100 Maximum value for value conversion
Slider.defineProperty(Slider, "max", {default = 100, type = "number"})
---@property horizontal boolean true Whether the slider is horizontal
Slider.defineProperty(Slider, "horizontal", {default = true, type = "boolean", canTriggerRender = true})
---@property barColor color color Colors for the slider bar
Slider.defineProperty(Slider, "barColor", {default = colors.gray, type = "number", canTriggerRender = true})
---@property sliderColor color The color of the slider handle
Slider.defineProperty(Slider, "sliderColor", {default = colors.blue, type = "number", canTriggerRender = true})

Slider.listenTo(Slider, "mouse_click")
Slider.listenTo(Slider, "mouse_drag")
Slider.listenTo(Slider, "mouse_up")

function Slider.new()
    local self = setmetatable({}, Slider):__init()
    self.set("width", 8)
    self.set("height", 1)
    self.set("backgroundEnabled", false)
    return self
end

function Slider:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Slider")
end

function Slider:getValue()
    local step = self.get("step")
    local max = self.get("max")
    local maxSteps = self.get("horizontal") and self.get("width") or self.get("height")
    return math.floor((step - 1) * (max / (maxSteps - 1)))
end

function Slider:mouse_click(button, x, y)
    if button == 1 and self:isInBounds(x, y) then
        local relX, relY = self:getRelativePosition(x, y)
        local pos = self.get("horizontal") and relX or relY
        local maxSteps = self.get("horizontal") and self.get("width") or self.get("height")

        self.set("step", math.min(maxSteps, math.max(1, pos)))
        self:updateRender()
        return true
    end
end
Slider.mouse_drag = Slider.mouse_click

function Slider:mouse_scroll(direction, x, y)
    if self:isInBounds(x, y) then
        local step = self.get("step")
        local maxSteps = self.get("horizontal") and self.get("width") or self.get("height")
        self.set("step", math.min(maxSteps, math.max(1, step + direction)))
        self:updateRender()
        return true
    end
end

function Slider:render()
    VisualElement.render(self)
    local width = self.get("width")
    local height = self.get("height")
    local horizontal = self.get("horizontal")
    local step = self.get("step")

    local barChar = horizontal and "\140" or "│"
    local text = string.rep(barChar, horizontal and width or height)

    if horizontal then
        self:textFg(1, 1, text, self.get("barColor"))
        self:textBg(step, 1, " ", self.get("sliderColor"))
    else
        for y = 1, height do
            self:textFg(1, y, barChar, self.get("barColor"))
        end
        self:textFg(1, step, "\140", self.get("sliderColor"))
    end
end

return Slider",
    ["errorManager.lua"] = "local LOGGER = require("log")

local errorHandler = {
    tracebackEnabled = true,
    header = "Basalt Error"
}

local function coloredPrint(message, color)
    term.setTextColor(color)
    print(message)
    term.setTextColor(colors.white)
end

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

return errorHandler",
    ["elements/Container.lua"] = "local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local expect = require("libraries/expect")
local split = require("libraries/utils").split

local max = math.max

---@class Container : VisualElement
local Container = setmetatable({}, VisualElement)
Container.__index = Container

Container.defineProperty(Container, "children", {default = {}, type = "table"})
Container.defineProperty(Container, "childrenSorted", {default = true, type = "boolean"})
Container.defineProperty(Container, "childrenEventsSorted", {default = true, type = "boolean"})
Container.defineProperty(Container, "childrenEvents", {default = {}, type = "table"})
Container.defineProperty(Container, "eventListenerCount", {default = {}, type = "table"})
Container.defineProperty(Container, "focusedChild", {default = nil, type = "table", setter = function(self, value, internal)
    local oldChild = self._values.focusedChild

    if value == oldChild then return value end

    if oldChild then
        if oldChild:isType("Container") then
            oldChild.set("focusedChild", nil, true)
        end
        oldChild.set("focused", false, true)
    end

    if value and not internal then
        value.set("focused", true, true)
        if self.parent then
            self.parent:setFocusedChild(self)
        end
    end

    return value
end})

Container.defineProperty(Container, "visibleChildren", {default = {}, type = "table"})
Container.defineProperty(Container, "visibleChildrenEvents", {default = {}, type = "table"})

function Container:isChildVisible(child)
    local childX, childY = child.get("x"), child.get("y")
    local childW, childH = child.get("width"), child.get("height")
    local containerW, containerH = self.get("width"), self.get("height")

    return childX <= containerW and
           childY <= containerH and
           childX + childW > 0 and
           childY + childH > 0
end

for k, _ in pairs(elementManager:getElementList()) do
    local capitalizedName = k:sub(1,1):upper() .. k:sub(2)
    if capitalizedName ~= "BaseFrame" then
        Container["add"..capitalizedName] = function(self, ...)
            expect(1, self, "table")
            local element = self.basalt.create(k, ...)
            self:addChild(element)
            element:postInit()
            return element
        end
        Container["addDelayed"..capitalizedName] = function(self, prop)
            expect(1, self, "table")
            local element = self.basalt.create(k, prop, true, self)
            return element
        end
    end
end

function Container.new()
    local self = setmetatable({}, Container):__init()
    return self
end

function Container:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Container")
end

function Container:addChild(child)
    if child == self then
        error("Cannot add container to itself")
    end

    table.insert(self._values.children, child)
    child.parent = self
    self.set("childrenSorted", false)
    self:registerChildrenEvents(child)
    return self
end

local function sortAndFilterChildren(self, children)
    local visibleChildren = {}
    
    for _, child in ipairs(children) do
        if self:isChildVisible(child) and child.get("visible") then
            table.insert(visibleChildren, child)
        end
    end

    for i = 2, #visibleChildren do
        local current = visibleChildren[i]
        local currentZ = current.get("z")
        local j = i - 1
        while j > 0 do
            local compare = visibleChildren[j].get("z")
            if compare > currentZ then
                visibleChildren[j + 1] = visibleChildren[j]
                j = j - 1
            else
                break
            end
        end
        visibleChildren[j + 1] = current
    end

    return visibleChildren
end

function Container:clear()
    self.set("children", {})
    self.set("childrenEvents", {})
    self.set("visibleChildren", {})
    self.set("visibleChildrenEvents", {})
    self.set("childrenSorted", true)
    self.set("childrenEventsSorted", true)
end

function Container:sortChildren()
    self.set("visibleChildren", sortAndFilterChildren(self, self._values.children))
    self.set("childrenSorted", true)
end

function Container:sortChildrenEvents(eventName)
    if self._values.childrenEvents[eventName] then
        self._values.visibleChildrenEvents[eventName] = sortAndFilterChildren(self, self._values.childrenEvents[eventName])
    end
    self.set("childrenEventsSorted", true)
end

function Container:registerChildrenEvents(child)
    if(child._registeredEvents == nil)then return end
    for event in pairs(child._registeredEvents) do
        self:registerChildEvent(child, event)
    end
end

function Container:registerChildEvent(child, eventName)
    if not self._values.childrenEvents[eventName] then
        self._values.childrenEvents[eventName] = {}
        self._values.eventListenerCount[eventName] = 0

        if self.parent then
            self.parent:registerChildEvent(self, eventName)
        end
    end

    for _, registeredChild in ipairs(self._values.childrenEvents[eventName]) do
        if registeredChild == child then
            return
        end
    end

    self.set("childrenEventsSorted", false)
    table.insert(self._values.childrenEvents[eventName], child)
    self._values.eventListenerCount[eventName] = self._values.eventListenerCount[eventName] + 1
end

function Container:removeChildrenEvents(child)
    if(child._registeredEvents == nil)then return end
    for event in pairs(child._registeredEvents) do
        self:unregisterChildEvent(child, event)
    end
end

function Container:unregisterChildEvent(child, eventName)
    if self._values.childrenEvents[eventName] then
        for i, listener in ipairs(self._values.childrenEvents[eventName]) do
            if listener == child then
                table.remove(self._values.childrenEvents[eventName], i)
                self._values.eventListenerCount[eventName] = self._values.eventListenerCount[eventName] - 1

                if self._values.eventListenerCount[eventName] <= 0 then
                    self._values.childrenEvents[eventName] = nil
                    self._values.eventListenerCount[eventName] = nil

                    if self.parent then
                        self.parent:unregisterChildEvent(self, eventName)
                    end
                end
                break
            end
        end
    end
end

function Container:removeChild(child)
    for i,v in ipairs(self._values.children) do
        if v == child then
            table.remove(self._values.children, i)
            child.parent = nil
            break
        end
    end
    self:removeChildrenEvents(child)
    return self
end

function Container:getChild(path)
    if type(path) == "string" then
        local parts = split(path, "/")
        for _,v in pairs(self._values.children) do
            if v.get("name") == parts[1] then
                if #parts == 1 then
                    return v
                else
                    if(v:isType("Container"))then
                        return v:find(table.concat(parts, "/", 2))
                    end
                end
            end
        end
    end
    return nil
end

local function convertMousePosition(self, event, ...)
    local args = {...}
    if event:find("mouse_") then
        local button, absX, absY = ...
        local relX, relY = self:getRelativePosition(absX, absY)
        args = {button, relX, relY}
    end
    return args
end

local function callChildrenEvents(self, visibleOnly, event, ...)
    local children = visibleOnly and self.get("visibleChildrenEvents") or self.get("childrenEvents")
    if children[event] then
        local events = children[event]
        for i = #events, 1, -1 do
            local child = events[i]
            if(child:dispatchEvent(event, ...))then
                    return true, child
            end
        end
    end
    return false
end

function Container:handleEvent(event, ...)
    VisualElement.handleEvent(self, event, ...)
    local args = convertMousePosition(self, event, ...)
    return callChildrenEvents(self, false, event, table.unpack(args))
end


function Container:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        local args = convertMousePosition(self, "mouse_click", button, x, y)
        local success, child = callChildrenEvents(self, true, "mouse_click", table.unpack(args))
        if(success)then
            self.set("focusedChild", child)
            return true
        end
        self.set("focusedChild", nil)
    end
end

function Container:mouse_up(button, x, y)
    if VisualElement.mouse_up(self, button, x, y) then
        local args = convertMousePosition(self, "mouse_up", button, x, y)
        local success, child = callChildrenEvents(self, true, "mouse_up", table.unpack(args))
        if(success)then
            return true
        end
    end
end

function Container:key(key)
    if self.get("focusedChild") then
        return self.get("focusedChild"):dispatchEvent("key", key)
    end
    return true
end

function Container:char(char)
    if self.get("focusedChild") then
        return self.get("focusedChild"):dispatchEvent("char", char)
    end
    return true
end

function Container:key_up(key)
    if self.get("focusedChild") then
        return self.get("focusedChild"):dispatchEvent("key_up", key)
    end
    return true
end

function Container:multiBlit(x, y, width, height, text, fg, bg)
    local w, h = self.get("width"), self.get("height")

    width = x < 1 and math.min(width + x - 1, w) or math.min(width, math.max(0, w - x + 1))
    height = y < 1 and math.min(height + y - 1, h) or math.min(height, math.max(0, h - y + 1))

    if width <= 0 or height <= 0 then return end

    VisualElement.multiBlit(self, math.max(1, x), math.max(1, y), width, height, text, fg, bg)
end

function Container:textFg(x, y, text, fg)
    local w, h = self.get("width"), self.get("height")

    if y < 1 or y > h then return end

    local textStart = x < 1 and (2 - x) or 1
    local textLen = math.min(#text - textStart + 1, w - math.max(1, x) + 1)

    if textLen <= 0 then return end

    VisualElement.textFg(self, math.max(1, x), math.max(1, y), text:sub(textStart, textStart + textLen - 1), fg)
end

function Container:blit(x, y, text, fg, bg)
    local w, h = self.get("width"), self.get("height")

    if y < 1 or y > h then return end

    local textStart = x < 1 and (2 - x) or 1
    local textLen = math.min(#text - textStart + 1, w - math.max(1, x) + 1)
    local fgLen = math.min(#fg - textStart + 1, w - math.max(1, x) + 1)
    local bgLen = math.min(#bg - textStart + 1, w - math.max(1, x) + 1)

    if textLen <= 0 then return end

    local finalText = text:sub(textStart, textStart + textLen - 1)
    local finalFg = fg:sub(textStart, textStart + fgLen - 1)
    local finalBg = bg:sub(textStart, textStart + bgLen - 1)

    VisualElement.blit(self, math.max(1, x), math.max(1, y), finalText, finalFg, finalBg)
end

function Container:render()
    VisualElement.render(self)
    if not self.get("childrenSorted")then
        self:sortChildren()
    end
    if not self.get("childrenEventsSorted")then
        for event in pairs(self._values.childrenEvents) do
            self:sortChildrenEvents(event)
        end
    end
    for _, child in ipairs(self.get("visibleChildren")) do
        if child == self then
            self.basalt.LOGGER.error("CIRCULAR REFERENCE DETECTED!")
            return
        end
        child:render()
    end
end

return Container",
    ["libraries/colorHex.lua"] = "local colorHex = {}

for i = 0, 15 do
    colorHex[2^i] = ("%x"):format(i)
    colorHex[("%x"):format(i)] = 2^i
end

return colorHex",
    ["elements/Flexbox.lua"] = "local elementManager = require("elementManager")
local Container = elementManager.getElement("Container")

---@class Flexbox : Container
local Flexbox = setmetatable({}, Container)
Flexbox.__index = Flexbox

Flexbox.defineProperty(Flexbox, "flexDirection", {default = "row", type = "string"})
Flexbox.defineProperty(Flexbox, "flexSpacing", {default = 1, type = "number"})
Flexbox.defineProperty(Flexbox, "flexJustifyContent", {
    default = "flex-start",
    type = "string",
    setter = function(self, value)
        if not value:match("^flex%-") then
            value = "flex-" .. value
        end
        return value
    end
})
Flexbox.defineProperty(Flexbox, "flexWrap", {default = false, type = "boolean"})
Flexbox.defineProperty(Flexbox, "flexUpdateLayout", {default = false, type = "boolean"})

local lineBreakElement = {
  getHeight = function(self) return 0 end,
  getWidth = function(self) return 0 end,
  getZ = function(self) return 1 end,
  getPosition = function(self) return 0, 0 end,
  getSize = function(self) return 0, 0 end,
  isType = function(self) return false end,
  getType = function(self) return "lineBreak" end,
  getName = function(self) return "lineBreak" end,
  setPosition = function(self) end,
  setParent = function(self) end,
  setSize = function(self) end,
  getFlexGrow = function(self) return 0 end,
  getFlexShrink = function(self) return 0 end,
  getFlexBasis = function(self) return 0 end,
  init = function(self) end,
  getVisible = function(self) return true end,
}


local function sortElements(self, direction, spacing, wrap)
    local elements = self.get("children")
    local sortedElements = {}
    if not(wrap)then
      local index = 1
      local lineSize = 1
      local lineOffset = 1
      for _,v in pairs(elements)do
          if(sortedElements[index]==nil)then sortedElements[index]={offset=1} end

          local childHeight = direction == "row" and v.get("height") or v.get("width")
          if childHeight > lineSize then
              lineSize = childHeight
          end
          if(v == lineBreakElement)then
              lineOffset = lineOffset + lineSize + spacing
              lineSize = 1
              index = index + 1
              sortedElements[index] = {offset=lineOffset}
          else
              table.insert(sortedElements[index], v)
          end
      end
    elseif(wrap)then
      local lineSize = 1
      local lineOffset = 1

      local maxSize = direction == "row" and self.get("width") or self.get("height")
      local usedSize = 0
      local index = 1

      for _,v in pairs(elements) do
          if(sortedElements[index]==nil) then sortedElements[index]={offset=1} end

          if v:getType() == "lineBreak" then
              lineOffset = lineOffset + lineSize + spacing
              usedSize = 0
              lineSize = 1
              index = index + 1
              sortedElements[index] = {offset=lineOffset}
          else
              local objSize = direction == "row" and v.get("width") or v.get("height")
              if(objSize+usedSize<=maxSize) then
                  table.insert(sortedElements[index], v)
                  usedSize = usedSize + objSize + spacing
              else
                  lineOffset = lineOffset + lineSize + spacing
                  lineSize = direction == "row" and v.get("height") or v.get("width")
                  index = index + 1
                  usedSize = objSize + spacing
                  sortedElements[index] = {offset=lineOffset, v}
              end

              local childHeight = direction == "row" and v.get("height") or v.get("width")
              if childHeight > lineSize then
                  lineSize = childHeight
              end
          end
      end
  end
    return sortedElements
end

local function calculateRow(self, children, spacing, justifyContent)
    local containerWidth = self.get("width")

    local usedSpace = spacing * (#children - 1)
    local totalFlexGrow = 0

    for _, child in ipairs(children) do
        if child ~= lineBreakElement then
            usedSpace = usedSpace + child.get("width")
            totalFlexGrow = totalFlexGrow + child.get("flexGrow")
        end
    end

    local remainingSpace = containerWidth - usedSpace
    local extraSpacePerUnit = totalFlexGrow > 0 and (remainingSpace / totalFlexGrow) or 0
    local distributedSpace = 0

    local currentX = 1
    for i, child in ipairs(children) do
        if child ~= lineBreakElement then
            local childWidth = child.get("width")

            if child.get("flexGrow") > 0 then

                if i == #children then
                    local extraSpace = remainingSpace - distributedSpace
                    childWidth = childWidth + extraSpace
                else
                    local extraSpace = math.floor(extraSpacePerUnit * child.get("flexGrow"))
                    childWidth = childWidth + extraSpace
                    distributedSpace = distributedSpace + extraSpace
                end
            end

            child.set("x", currentX)
            child.set("y", children.offset or 1)
            child.set("width", childWidth)
            currentX = currentX + childWidth + spacing
        end
    end

    if justifyContent == "flex-end" then
        local offset = containerWidth - (currentX - spacing - 1)
        for _, child in ipairs(children) do
            child.set("x", child.get("x") + offset)
        end
    elseif justifyContent == "flex-center" or justifyContent == "center" then -- Akzeptiere beide Formate
        local offset = math.floor((containerWidth - (currentX - spacing - 1)) / 2)
        for _, child in ipairs(children) do
            child.set("x", child.get("x") + offset)
        end
    end
end

local function calculateColumn(self, children, spacing, justifyContent)
    local containerHeight = self.get("height")

    local usedSpace = spacing * (#children - 1)
    local totalFlexGrow = 0

    for _, child in ipairs(children) do
        if child ~= lineBreakElement then
            usedSpace = usedSpace + child.get("height")
            totalFlexGrow = totalFlexGrow + child.get("flexGrow")
        end
    end

    local remainingSpace = containerHeight - usedSpace
    local extraSpacePerUnit = totalFlexGrow > 0 and (remainingSpace / totalFlexGrow) or 0
    local distributedSpace = 0

    local currentY = 1
    for i, child in ipairs(children) do
        if child ~= lineBreakElement then
            local childHeight = child.get("height")

            if child.get("flexGrow") > 0 then

                if i == #children then
                    local extraSpace = remainingSpace - distributedSpace
                    childHeight = childHeight + extraSpace
                else
                    local extraSpace = math.floor(extraSpacePerUnit * child.get("flexGrow"))
                    childHeight = childHeight + extraSpace
                    distributedSpace = distributedSpace + extraSpace
                end
            end

            child.set("x", children.offset or 1)
            child.set("y", currentY)
            child.set("height", childHeight)
            currentY = currentY + childHeight + spacing
        end
    end

    if justifyContent == "flex-end" then
        local offset = containerHeight - (currentY - spacing - 1)
        for _, child in ipairs(children) do
            child.set("y", child.get("y") + offset)
        end
    elseif justifyContent == "flex-center" or justifyContent == "center" then -- Akzeptiere beide Formate
        local offset = math.floor((containerHeight - (currentY - spacing - 1)) / 2)
        for _, child in ipairs(children) do
            child.set("y", child.get("y") + offset)
        end
    end
end

local function updateLayout(self, direction, spacing, justifyContent, wrap)
  local elements = sortElements(self, direction, spacing, wrap)
    if direction == "row" then
        for _,v in pairs(elements)do
            calculateRow(self, v, spacing, justifyContent)
        end
    else
        for _,v in pairs(elements)do
            calculateColumn(self, v, spacing, justifyContent)
        end
    end
    self.set("flexUpdateLayout", false)
end

--- Creates a new Flexbox instance
--- @return Flexbox object The newly created Flexbox instance
--- @usage local element = Flexbox.new("myId", basalt)
function Flexbox.new()
    local self = setmetatable({}, Flexbox):__init()
    self.set("width", 12)
    self.set("height", 6)
    self.set("background", colors.blue)
    self.set("z", 10)
    self:observe("width", function() self.set("flexUpdateLayout", true) end)
    self:observe("height", function() self.set("flexUpdateLayout", true) end)
    return self
end

function Flexbox:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "Flexbox")
end

function Flexbox:addChild(element)
    Container.addChild(self, element)

    if(element~=lineBreakElement)then
        element:instanceProperty("flexGrow", {default = 0, type = "number"})
        element:instanceProperty("flexShrink", {default = 0, type = "number"})
        element:instanceProperty("flexBasis", {default = 0, type = "number"})
    end

    self.set("flexUpdateLayout", true)
    return self
end

function Flexbox:removeChild(element)
  Container.removeChild(self, element)

  if(element~=lineBreakElement)then
    element.setFlexGrow = nil
    element.setFlexShrink = nil
    element.setFlexBasis = nil
    element.getFlexGrow = nil
    element.getFlexShrink = nil
    element.getFlexBasis = nil
    element.set("flexGrow", nil)
    element.set("flexShrink", nil)
    element.set("flexBasis", nil)
  end

  self.set("flexUpdateLayout", true)
  return self
end

--- Adds a new line break to the flexbox.
---@param self Flexbox The element itself
---@return Flexbox
function Flexbox:addLineBreak()
  self:addChild(lineBreakElement)
  return self
end

function Flexbox:render()
  if(self.get("flexUpdateLayout"))then
    updateLayout(self, self.get("flexDirection"), self.get("flexSpacing"), self.get("flexJustifyContent"), self.get("flexWrap"))
  end
  Container.render(self)
end

return Flexbox",
    ["elements/Label.lua"] = "local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")

---@class Label : VisualElement
local Label = setmetatable({}, VisualElement)
Label.__index = Label

---@property text string Label Label text to be displayed
Label.defineProperty(Label, "text", {default = "Label", type = "string", setter = function(self, value)
    if(type(value)=="function")then value = value() end
    self.set("width", #value)
    return value
end})

--- Creates a new Label instance
--- @return Label object The newly created Label instance
--- @usage local element = Label.new("myId", basalt)
function Label.new()
    local self = setmetatable({}, Label):__init()
    self.set("z", 3)
    self.set("foreground", colors.black)
    self.set("backgroundEnabled", false)
    return self
end

function Label:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Label")
end

function Label:render()
    VisualElement.render(self)
    local text = self.get("text")
    self:textFg(1, 1, text, self.get("foreground"))
end

return Label",
    ["plugins/theme.lua"] = "local defaultTheme = {
    default = {
        background = colors.lightGray,
        foreground = colors.black,
    },
    BaseFrame = {
        background = colors.white,
        foreground = colors.black,

        Frame = {
            background = colors.black,
            names = {
                basaltDebugLogClose = {
                    background = colors.blue,
                    foreground = colors.white
                }
            },
        },
        Button = {
            background = "{self.clicked and colors.black or colors.cyan}",
            foreground = "{self.clicked and colors.cyan or colors.black}",
        },

        names = {
            basaltDebugLog = {
                background = colors.red,
                foreground = colors.white
            },
            test = {
                background = "{self.clicked and colors.black or colors.green}",
                foreground = "{self.clicked and colors.green or colors.black}"
            }
        },
    }
}

local themes = {
    default = defaultTheme
}

local currentTheme = "default"

local BaseElement = {
    hooks = {
        postInit = {
            pre = function(self)
            self:applyTheme()
        end}
    }
}

function BaseElement.____getElementPath(self, types)
    if types then
        table.insert(types, 1, self._values.type)
    else
        types = {self._values.type}
    end
    local parent = self.parent
    if parent then
        return parent.____getElementPath(parent, types)
    else
        return types
    end
end

local function lookUpTemplate(theme, path)
    local current = theme

    for i = 1, #path do
        local found = false
        local types = path[i]

        for _, elementType in ipairs(types) do
            if current[elementType] then
                current = current[elementType]
                found = true
                break
            end
        end

        if not found then
            return nil
        end
    end

    return current
end

local function getDefaultProperties(theme, elementType)
    local result = {}
    if theme.default then
        for k,v in pairs(theme.default) do
            if type(v) ~= "table" then
                result[k] = v
            end
        end

        if theme.default[elementType] then
            for k,v in pairs(theme.default[elementType]) do
                if type(v) ~= "table" then
                    result[k] = v
                end
            end
        end
    end
    return result
end

local function applyNamedStyles(result, theme, elementType, elementName, themeTable)
    if theme.default and theme.default.names and theme.default.names[elementName] then
        for k,v in pairs(theme.default.names[elementName]) do
            if type(v) ~= "table" then result[k] = v end
        end
    end

    if theme.default and theme.default[elementType] and theme.default[elementType].names 
       and theme.default[elementType].names[elementName] then
        for k,v in pairs(theme.default[elementType].names[elementName]) do
            if type(v) ~= "table" then result[k] = v end
        end
    end

    if themeTable and themeTable.names and themeTable.names[elementName] then
        for k,v in pairs(themeTable.names[elementName]) do
            if type(v) ~= "table" then result[k] = v end
        end
    end
end

local function collectThemeProps(theme, path, elementType, elementName)
    local result = {}
    local themeTable = lookUpTemplate(theme, path)
    if themeTable then
        for k,v in pairs(themeTable) do
            if type(v) ~= "table" then
                result[k] = v
            end
        end
    end

    if next(result) == nil then
        result = getDefaultProperties(theme, elementType)
    end

    applyNamedStyles(result, theme, elementType, elementName, themeTable)

    return result
end

 function BaseElement:applyTheme()
    local styles = self:getTheme()
    if(styles ~= nil) then
        for prop, value in pairs(styles) do
            self.set(prop, value)
        end
    end
end

function BaseElement:getTheme()
    local path = self:____getElementPath()
    local elementType = self.get("type")
    local elementName = self.get("name")

    return collectThemeProps(themes[currentTheme], path, elementType, elementName)
end

local themeAPI = {
    setTheme = function(newTheme)
        defaultTheme = newTheme
    end,

    getTheme = function()
        return defaultTheme
    end,

    loadTheme = function(path)
        local file = fs.open(path, "r")
        if file then
            local content = file.readAll()
            file.close()
            defaultTheme = textutils.unserializeJSON(content)
        end
    end
}

local Theme = {
    BaseElement = BaseElement,
    API = themeAPI
}

return Theme
",
    ["plugins/animation.lua"] = "local Animation = {}
Animation.__index = Animation

local registeredAnimations = {}

function Animation.registerAnimation(name, handlers)
    registeredAnimations[name] = handlers

    Animation[name] = function(self, ...)
        local args = {...}
        local easing = "linear"
        if(type(args[#args]) == "string") then
            easing = table.remove(args, #args)
        end
        local duration = table.remove(args, #args)
        return self:addAnimation(name, args, duration, easing)
    end
end

local easings = {
    linear = function(progress)
        return progress
    end,

    easeInQuad = function(progress)
        return progress * progress
    end,

    easeOutQuad = function(progress)
        return 1 - (1 - progress) * (1 - progress)
    end,

    easeInOutQuad = function(progress)
        if progress < 0.5 then
            return 2 * progress * progress
        end
        return 1 - (-2 * progress + 2)^2 / 2
    end
}

function Animation.registerEasing(name, func)
    easings[name] = func
end

local AnimationInstance = {}
AnimationInstance.__index = AnimationInstance

function AnimationInstance.new(element, animType, args, duration, easing)
    local self = setmetatable({}, AnimationInstance)
    self.element = element
    self.type = animType
    self.args = args
    self.duration = duration
    self.startTime = 0
    self.isPaused = false
    self.handlers = registeredAnimations[animType]
    self.easing = easing
    return self
end

function AnimationInstance:start()
    self.startTime = os.epoch("local") / 1000
    if self.handlers.start then
        self.handlers.start(self)
    end
end

function AnimationInstance:update(elapsed)
    local rawProgress = math.min(1, elapsed / self.duration)
    local progress = easings[self.easing](rawProgress)
    return self.handlers.update(self, progress)
end

function AnimationInstance:complete()
    if self.handlers.complete then
        self.handlers.complete(self)
    end
end

function Animation.new(element)
    local self = {}
    self.element = element
    self.sequences = {{}}
    self.sequenceCallbacks = {}
    self.currentSequence = 1
    self.timer = nil
    setmetatable(self, Animation)
    return self
end

function Animation:sequence()
    table.insert(self.sequences, {})
    self.currentSequence = #self.sequences
    self.sequenceCallbacks[self.currentSequence] = {
        start = nil,
        update = nil,
        complete = nil
    }
    return self
end

function Animation:onStart(callback)
    if not self.sequenceCallbacks[self.currentSequence] then
        self.sequenceCallbacks[self.currentSequence] = {}
    end
    self.sequenceCallbacks[self.currentSequence].start = callback
    return self
end

function Animation:onUpdate(callback)
    if not self.sequenceCallbacks[self.currentSequence] then
        self.sequenceCallbacks[self.currentSequence] = {}
    end
    self.sequenceCallbacks[self.currentSequence].update = callback
    return self
end

function Animation:onComplete(callback)
    if not self.sequenceCallbacks[self.currentSequence] then
        self.sequenceCallbacks[self.currentSequence] = {}
    end
    self.sequenceCallbacks[self.currentSequence].complete = callback
    return self
end

function Animation:addAnimation(type, args, duration, easing)
    local anim = AnimationInstance.new(self.element, type, args, duration, easing)
    table.insert(self.sequences[self.currentSequence], anim)
    return self
end

function Animation:start()

    self.currentSequence = 1
    if(self.sequenceCallbacks[self.currentSequence])then
        if(self.sequenceCallbacks[self.currentSequence].start) then
            self.sequenceCallbacks[self.currentSequence].start(self.element)
        end
    end
    if #self.sequences[self.currentSequence] > 0 then
        self.timer = os.startTimer(0.05)
        for _, anim in ipairs(self.sequences[self.currentSequence]) do
            anim:start()
        end
    end
    return self
end

function Animation:event(event, timerId)
    if event == "timer" and timerId == self.timer then
        local currentTime = os.epoch("local") / 1000
        local sequenceFinished = true
        local remaining = {}
        local callbacks = self.sequenceCallbacks[self.currentSequence]

        for _, anim in ipairs(self.sequences[self.currentSequence]) do
            local elapsed = currentTime - anim.startTime
            local progress = elapsed / anim.duration
            local finished = anim:update(elapsed)

            if callbacks and callbacks.update then
                callbacks.update(self.element, progress)
            end

            if not finished then
                table.insert(remaining, anim)
                sequenceFinished = false
            else
                anim:complete()
            end
        end

        if sequenceFinished then
            if callbacks and callbacks.complete then
                callbacks.complete(self.element)
            end

            if self.currentSequence < #self.sequences then
                self.currentSequence = self.currentSequence + 1
                remaining = {}

                local nextCallbacks = self.sequenceCallbacks[self.currentSequence]
                if nextCallbacks and nextCallbacks.start then
                    nextCallbacks.start(self.element)
                end

                for _, anim in ipairs(self.sequences[self.currentSequence]) do
                    anim:start()
                    table.insert(remaining, anim)
                end
            end
        end

        if #remaining > 0 then
            self.timer = os.startTimer(0.05)
        end
    end
end

Animation.registerAnimation("move", {
    start = function(anim)
        anim.startX = anim.element.get("x")
        anim.startY = anim.element.get("y")
    end,

    update = function(anim, progress)
        local x = anim.startX + (anim.args[1] - anim.startX) * progress
        local y = anim.startY + (anim.args[2] - anim.startY) * progress
        anim.element.set("x", math.floor(x))
        anim.element.set("y", math.floor(y))
        return progress >= 1
    end,

    complete = function(anim)
        anim.element.set("x", anim.args[1])
        anim.element.set("y", anim.args[2])
    end
})

Animation.registerAnimation("morphText", {
    start = function(anim)
        local startText = anim.element.get(anim.args[1])
        local targetText = anim.args[2]
        local maxLength = math.max(#startText, #targetText)
        local startSpace = string.rep(" ", math.floor(maxLength - #startText)/2)
        anim.startText = startSpace .. startText .. startSpace
        anim.targetText = targetText .. string.rep(" ", maxLength - #targetText)
        anim.length = maxLength
    end,

    update = function(anim, progress)
        local currentText = ""

        for i = 1, anim.length do
            local startChar = anim.startText:sub(i,i)
            local targetChar = anim.targetText:sub(i,i)

            if progress < 0.5 then
                currentText = currentText .. (math.random() > progress*2 and startChar or " ")
            else
                currentText = currentText .. (math.random() > (progress-0.5)*2 and " " or targetChar)
            end
        end

        anim.element.set(anim.args[1], currentText)
        return progress >= 1
    end,

    complete = function(anim)
        anim.element.set(anim.args[1], anim.targetText:gsub("%s+$", ""))  -- Entferne trailing spaces
    end
})

Animation.registerAnimation("typewrite", {
    start = function(anim)
        anim.targetText = anim.args[2]
        anim.element.set(anim.args[1], "")
    end,

    update = function(anim, progress)
        local length = math.floor(#anim.targetText * progress)
        anim.element.set(anim.args[1], anim.targetText:sub(1, length))
        return progress >= 1
    end
})

Animation.registerAnimation("fadeText", {
    start = function(anim)
        anim.chars = {}
        for i=1, #anim.args[2] do
            anim.chars[i] = {char = anim.args[2]:sub(i,i), visible = false}
        end
    end,

    update = function(anim, progress)
        local text = ""
        for i, charData in ipairs(anim.chars) do
            if math.random() < progress then
                charData.visible = true
            end
            text = text .. (charData.visible and charData.char or " ")
        end
        anim.element.set(anim.args[1], text)
        return progress >= 1
    end
})

Animation.registerAnimation("scrollText", {
    start = function(anim)
        anim.width = anim.element.get("width")
        anim.targetText = anim.args[2]
        anim.element.set(anim.args[1], "")
    end,

    update = function(anim, progress)
        local offset = math.floor(anim.width * (1-progress))
        local spaces = string.rep(" ", offset)
        anim.element.set(anim.args[1], spaces .. anim.targetText)
        return progress >= 1
    end
})

local VisualElement = {hooks={}}

function VisualElement.hooks.dispatchEvent(self, event, ...)
    if event == "timer" then
        local animation = self.get("animation")
        if animation then
            animation:event(event, ...)
        end
    end
end

function VisualElement.setup(element)
    VisualElementBaseDispatchEvent = element.dispatchEvent
    element.defineProperty(element, "animation", {default = nil, type = "table"})
    element.listenTo(element, "timer")
end

function VisualElement:animate()
    local animation = Animation.new(self)
    self.set("animation", animation)
    return animation
end

return {
    VisualElement = VisualElement
}",
    ["plugins/debug.lua"] = "local log = require("log")
local tHex = require("libraries/colorHex")

local maxLines = 10
local isVisible = false

local function createDebugger(element)
    local elementInfo = {
        renderCount = 0,
        eventCount = {},
        lastRender = os.epoch("utc"),
        properties = {},
        children = {}
    }

    return {
        trackProperty = function(name, value)
            elementInfo.properties[name] = value
        end,

        trackRender = function()
            elementInfo.renderCount = elementInfo.renderCount + 1
            elementInfo.lastRender = os.epoch("utc")
        end,

        trackEvent = function(event)
            elementInfo.eventCount[event] = (elementInfo.eventCount[event] or 0) + 1
        end,

        dump = function()
            return {
                type = element.get("type"),
                id = element.get("id"),
                stats = elementInfo
            }
        end
    }
end

local BaseElement = {
    debug = function(self, level)
        self._debugger = createDebugger(self)
        self._debugLevel = level or DEBUG_LEVELS.INFO
        return self
    end,

    dumpDebug = function(self)
        if not self._debugger then return end
        return self._debugger.dump()
    end
}

local BaseFrame = {
    showDebugLog = function(self)
        if not self._debugFrame then
            local width = self.get("width")
            local height = self.get("height")
            self._debugFrame = self:addFrame("basaltDebugLog")
                :setWidth(width)
                :setHeight(height)
                :setZ(999)
                :listenEvent("mouse_scroll", true)
            self.basalt.LOGGER.debug("Created debug log frame " .. self._debugFrame.get("name"))

            self._debugFrame:addButton("basaltDebugLogClose")
            :setWidth(9)
            :setHeight(1)
            :setX(width - 8)
            :setY(height)
            :setText("Close")
            :onMouseClick(function()
                self:hideDebugLog()
            end)

            self._debugFrame._scrollOffset = 0
            self._debugFrame._processedLogs = {}

            local function wrapText(text, width)
                local lines = {}
                while #text > 0 do
                    local line = text:sub(1, width)
                    table.insert(lines, line)
                    text = text:sub(width + 1)
                end
                return lines
            end

            local function processLogs()
                local processed = {}
                local width = self._debugFrame.get("width")

                for _, entry in ipairs(log._logs) do
                    local lines = wrapText(entry.message, width)
                    for _, line in ipairs(lines) do
                        table.insert(processed, {
                            text = line,
                            level = entry.level
                        })
                    end
                end
                return processed
            end

            local totalLines = #processLogs() - self.get("height")
            self._scrollOffset = totalLines

            local originalRender = self._debugFrame.render
            self._debugFrame.render = function(frame)
                originalRender(frame)
                frame._processedLogs = processLogs()

                local height = frame.get("height")-2
                local totalLines = #frame._processedLogs
                local maxScroll = math.max(0, totalLines - height)
                frame._scrollOffset = math.min(frame._scrollOffset, maxScroll)

                for i = 1, height-2 do
                    local logIndex = i + frame._scrollOffset
                    local entry = frame._processedLogs[logIndex]

                    if entry then
                        local color = entry.level == log.LEVEL.ERROR and colors.red
                            or entry.level == log.LEVEL.WARN and colors.yellow
                            or entry.level == log.LEVEL.DEBUG and colors.lightGray
                            or colors.white

                        frame:textFg(2, i, entry.text, color)
                    end
                end
            end

            local baseDispatchEvent = self._debugFrame.dispatchEvent
            self._debugFrame.dispatchEvent = function(self, event, direction, ...)
                if(event == "mouse_scroll") then
                    self._scrollOffset = math.max(0, self._scrollOffset + direction)
                    self:updateRender()
                    return true
                else
                    baseDispatchEvent(self, event, direction, ...)
                end
            end
        end
        self._debugFrame.set("visible", true)
        return self
    end,

    hideDebugLog = function(self)
        if self._debugFrame then
            self._debugFrame.set("visible", false)
        end
        return self
    end,

    toggleDebugLog = function(self)
        if self._debugFrame and self._debugFrame:isVisible() then
            self:hideDebugLog()
        else
            self:showDebugLog()
        end
        return self
    end
}


local Container = {
    debugChildren = function(self, level)
        self:debug(level)
        for _, child in pairs(self.get("children")) do
            if child.debug then
                child:debug(level)
            end
        end
        return self
    end
}

return {
    BaseElement = BaseElement,
    Container = Container,
    BaseFrame = BaseFrame,
}
",
    ["elements/Frame.lua"] = "local elementManager = require("elementManager")
local Container = elementManager.getElement("Container")

---@class Frame : Container
local Frame = setmetatable({}, Container)
Frame.__index = Frame

--- Creates a new Frame instance
--- @return Frame object The newly created Frame instance
--- @usage local element = Frame.new("myId", basalt)
function Frame.new()
    local self = setmetatable({}, Frame):__init()
    self.set("width", 12)
    self.set("height", 6)
    self.set("background", colors.gray)
    self.set("z", 10)
    return self
end

function Frame:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "Frame")
end

return Frame",
    ["render.lua"] = "local Render = {}
Render.__index = Render
local colorChars = require("libraries/colorHex")

function Render.new(terminal)
    local self = setmetatable({}, Render)
    self.terminal = terminal
    self.width, self.height = terminal.getSize()

    self.buffer = {
        text = {},
        fg = {},
        bg = {},
        dirtyRects = {}
    }

    for y=1, self.height do
        self.buffer.text[y] = string.rep(" ", self.width)
        self.buffer.fg[y] = string.rep("0", self.width)
        self.buffer.bg[y] = string.rep("f", self.width)
    end

    return self
end

function Render:addDirtyRect(x, y, width, height)
    table.insert(self.buffer.dirtyRects, {
        x = x,
        y = y,
        width = width,
        height = height
    })
end

function Render:blit(x, y, text, fg, bg)
    if y < 1 or y > self.height then return self end
    if(#text ~= #fg or #text ~= #bg)then
        error("Text, fg, and bg must be the same length")
    end

    self.buffer.text[y] = self.buffer.text[y]:sub(1,x-1) .. text .. self.buffer.text[y]:sub(x+#text)
    self.buffer.fg[y] = self.buffer.fg[y]:sub(1,x-1) .. fg .. self.buffer.fg[y]:sub(x+#fg)
    self.buffer.bg[y] = self.buffer.bg[y]:sub(1,x-1) .. bg .. self.buffer.bg[y]:sub(x+#bg)
    self:addDirtyRect(x, y, #text, 1)

    return self
end

function Render:multiBlit(x, y, width, height, text, fg, bg)
    if y < 1 or y > self.height then return self end
    if(#text ~= #fg or #text ~= #bg)then
        error("Text, fg, and bg must be the same length")
    end

    text = text:rep(width)
    fg = fg:rep(width)
    bg = bg:rep(width)

    for dy=0, height-1 do
        local cy = y + dy
        if cy >= 1 and cy <= self.height then
            self.buffer.text[cy] = self.buffer.text[cy]:sub(1,x-1) .. text .. self.buffer.text[cy]:sub(x+#text)
            self.buffer.fg[cy] = self.buffer.fg[cy]:sub(1,x-1) .. fg .. self.buffer.fg[cy]:sub(x+#fg)
            self.buffer.bg[cy] = self.buffer.bg[cy]:sub(1,x-1) .. bg .. self.buffer.bg[cy]:sub(x+#bg)
        end
    end

    self:addDirtyRect(x, y, width, height)
    return self
end

function Render:textFg(x, y, text, fg)
    if y < 1 or y > self.height then return self end
    fg = colorChars[fg] or "0"

    self.buffer.text[y] = self.buffer.text[y]:sub(1,x-1) .. text .. self.buffer.text[y]:sub(x+#text)
    self.buffer.fg[y] = self.buffer.fg[y]:sub(1,x-1) .. fg:rep(#text) .. self.buffer.fg[y]:sub(x+#text)
    self:addDirtyRect(x, y, #text, 1)

    return self
end

function Render:textBg(x, y, text, bg)
    if y < 1 or y > self.height then return self end
    bg = colorChars[bg] or "f"

    self.buffer.text[y] = self.buffer.text[y]:sub(1,x-1) .. text .. self.buffer.text[y]:sub(x+#text)
    self.buffer.bg[y] = self.buffer.bg[y]:sub(1,x-1) .. bg:rep(#text) .. self.buffer.bg[y]:sub(x+#text)
    self:addDirtyRect(x, y, #text, 1)

    return self
end

function Render:text(x, y, text)
    if y < 1 or y > self.height then return self end

    self.buffer.text[y] = self.buffer.text[y]:sub(1,x-1) .. text .. self.buffer.text[y]:sub(x+#text)
    self:addDirtyRect(x, y, #text, 1)

    return self
end

function Render:fg(x, y, fg)
    if y < 1 or y > self.height then return self end

    self.buffer.fg[y] = self.buffer.fg[y]:sub(1,x-1) .. fg .. self.buffer.fg[y]:sub(x+#fg)
    self:addDirtyRect(x, y, #fg, 1)

    return self
end

function Render:bg(x, y, bg)
    if y < 1 or y > self.height then return self end

    self.buffer.bg[y] = self.buffer.bg[y]:sub(1,x-1) .. bg .. self.buffer.bg[y]:sub(x+#bg)
    self:addDirtyRect(x, y, #bg, 1)

    return self
end

function Render:blit(x, y, text, fg, bg)
    if y < 1 or y > self.height then return self end
    if(#text ~= #fg or #text ~= #bg)then
        error("Text, fg, and bg must be the same length")
    end

    self.buffer.text[y] = self.buffer.text[y]:sub(1,x-1) .. text .. self.buffer.text[y]:sub(x+#text)
    self.buffer.fg[y] = self.buffer.fg[y]:sub(1,x-1) .. fg .. self.buffer.fg[y]:sub(x+#fg)
    self.buffer.bg[y] = self.buffer.bg[y]:sub(1,x-1) .. bg .. self.buffer.bg[y]:sub(x+#bg)
    self:addDirtyRect(x, y, #text, 1)

    return self
end

function Render:clear(bg)
    local bgChar = colorChars[bg] or "f"
    for y=1, self.height do
        self.buffer.text[y] = string.rep(" ", self.width)
        self.buffer.fg[y] = string.rep("0", self.width)
        self.buffer.bg[y] = string.rep(bgChar, self.width)
        self:addDirtyRect(1, y, self.width, 1)
    end
    return self
end

function Render:render()

    local mergedRects = {}
    for _, rect in ipairs(self.buffer.dirtyRects) do
        local merged = false
        for _, existing in ipairs(mergedRects) do
            if self:rectOverlaps(rect, existing) then
                self:mergeRects(existing, rect)
                merged = true
                break
            end
        end
        if not merged then
            table.insert(mergedRects, rect)
        end
    end

    for _, rect in ipairs(mergedRects) do
        for y = rect.y, rect.y + rect.height - 1 do
            if y >= 1 and y <= self.height then
                self.terminal.setCursorPos(rect.x, y)
                self.terminal.blit(
                    self.buffer.text[y]:sub(rect.x, rect.x + rect.width - 1),
                    self.buffer.fg[y]:sub(rect.x, rect.x + rect.width - 1),
                    self.buffer.bg[y]:sub(rect.x, rect.x + rect.width - 1)
                )
            end
        end
    end

    self.buffer.dirtyRects = {}

    if self.blink then
        self.terminal.setCursorPos(self.xCursor, self.yCursor)
        self.terminal.setCursorBlink(true)
    else
        self.terminal.setCursorBlink(false)
    end

    return self
end

function Render:rectOverlaps(r1, r2)
    return not (r1.x + r1.width <= r2.x or
               r2.x + r2.width <= r1.x or
               r1.y + r1.height <= r2.y or
               r2.y + r2.height <= r1.y)
end

function Render:mergeRects(target, source)
    local x1 = math.min(target.x, source.x)
    local y1 = math.min(target.y, source.y)
    local x2 = math.max(target.x + target.width, source.x + source.width)
    local y2 = math.max(target.y + target.height, source.y + source.height)
    
    target.x = x1
    target.y = y1
    target.width = x2 - x1
    target.height = y2 - y1
end

function Render:setCursor(x, y, blink)
    self.terminal.setCursorPos(x, y)
    self.terminal.setCursorBlink(blink)
    self.xCursor = x
    self.yCursor = y
    self.blink = blink
    return self
end

function Render:clearArea(x, y, width, height, bg)
    local bgChar = colorChars[bg] or "f"
    for dy=0, height-1 do
        local cy = y + dy
        if cy >= 1 and cy <= self.height then
            local text = string.rep(" ", width)
            local color = string.rep(bgChar, width)
            self:blit(x, cy, text, "0", bgChar)
        end
    end
    return self
end

function Render:getSize()
    return self.width, self.height
end

return Render",
    ["propertySystem.lua"] = "local deepCopy = require("libraries/utils").deepCopy
local expect = require("libraries/expect")
local errorManager = require("errorManager")
local log = require("log")

--- @class PropertySystem
local PropertySystem = {}
PropertySystem.__index = PropertySystem

PropertySystem._properties = {}
local blueprintTemplates = {}

PropertySystem._setterHooks = {}

function PropertySystem.addSetterHook(hook)
    table.insert(PropertySystem._setterHooks, hook)
end

local function applyHooks(element, propertyName, value, config)
    for _, hook in ipairs(PropertySystem._setterHooks) do
        local newValue = hook(element, propertyName, value, config)
        if newValue ~= nil then
            value = newValue
        end
    end
    return value
end

function PropertySystem.defineProperty(class, name, config)
    if not rawget(class, '_properties') then
        class._properties = {}
    end

    class._properties[name] = {
        type = config.type,
        default = config.default,
        canTriggerRender = config.canTriggerRender,
        getter = config.getter,
        setter = config.setter,
    }

    local capitalizedName = name:sub(1,1):upper() .. name:sub(2)

    class["get" .. capitalizedName] = function(self, ...)
        expect(1, self, "element")
        local value = self._values[name]
        if type(value) == "function" and config.type ~= "function" then
            value = value(self)
        end
        return config.getter and config.getter(self, value, ...) or value
    end

    class["set" .. capitalizedName] = function(self, value, ...)
        expect(1, self, "element")
        value = applyHooks(self, name, value, config)

        if type(value) ~= "function" then
            expect(2, value, config.type)
        end

        if config.setter then
            value = config.setter(self, value, ...)
        end

        self:_updateProperty(name, value)
        return self
    end
end

function PropertySystem.combineProperties(class, name, ...)
    local properties = {...}
    for k,v in pairs(properties)do
        if not class._properties[v] then errorManager.error("Property not found: "..v) end
    end
    local capitalizedName = name:sub(1,1):upper() .. name:sub(2)

    class["get" .. capitalizedName] = function(self, ...)
        expect(1, self, "element")
        local value = {}
        for _,v in pairs(properties)do
            value[v] = self.get(v)
        end
        return table.unpack(value)
    end

    class["set" .. capitalizedName] = function(self, ...)
        expect(1, self, "element")
        local values = {...}
        for i,v in pairs(properties)do
            self.set(v, values[i])
        end
        return self
    end
end

--- Creates a blueprint of an element class with all its properties
--- @param elementClass table The element class to create a blueprint from
--- @return table blueprint A table containing all property definitions
function PropertySystem.blueprint(elementClass, properties, basalt, parent)
    if not blueprintTemplates[elementClass] then
        local template = {
            basalt = basalt,
            __isBlueprint = true,
            _values = properties or {},
            _events = {},
            render = function() end,
            dispatchEvent = function() end,
            init = function() end,
        }

        template.loaded = function(self, callback)
            self.loadedCallback = callback
            return template
        end

        template.create = function(self)
            local element = elementClass.new()
            element:init({}, self.basalt)
            for name, value in pairs(self._values) do
                element._values[name] = value
            end
            for name, callbacks in pairs(self._events) do
                for _, callback in ipairs(callbacks) do
                    element[name](element, callback)
                end
            end
            if(parent~=nil)then
                parent:addChild(element)
            end
            element:updateRender()
            self.loadedCallback(element)
            element:postInit()
            return element
        end

        local currentClass = elementClass
        while currentClass do
            if rawget(currentClass, '_properties') then
                for name, config in pairs(currentClass._properties) do
                    if type(config.default) == "table" then
                        template._values[name] = deepCopy(config.default)
                    else
                        template._values[name] = config.default
                    end
                end
            end
            currentClass = getmetatable(currentClass) and rawget(getmetatable(currentClass), '__index')
        end

        blueprintTemplates[elementClass] = template
    end

    local blueprint = {
        _values = {},
        _events = {},
        loadedCallback = function() end,
    }

    blueprint.get = function(name)
        local value = blueprint._values[name]
        local config = elementClass._properties[name]
        if type(value) == "function" and config.type ~= "function" then
            value = value(blueprint)
        end
        return value
    end
    blueprint.set = function(name, value)
        blueprint._values[name] = value
        return blueprint
    end

    setmetatable(blueprint, {
        __index = function(self, k)
            if k:match("^on%u") then
                return function(_, callback)
                    self._events[k] = self._events[k] or {}
                    table.insert(self._events[k], callback)
                    return self
                end
            end
            if k:match("^get%u") then
                local propName = k:sub(4,4):lower() .. k:sub(5)
                return function()
                    return self._values[propName]
                end
            end
            if k:match("^set%u") then
                local propName = k:sub(4,4):lower() .. k:sub(5)
                return function(_, value)
                    self._values[propName] = value
                    return self
                end
            end
            return blueprintTemplates[elementClass][k]
        end
    })

    return blueprint
end

function PropertySystem.createFromBlueprint(elementClass, blueprint, basalt)
    local element = elementClass.new({}, basalt)
    for name, value in pairs(blueprint._values) do
        if type(value) == "table" then
            element._values[name] = deepCopy(value)
        else
            element._values[name] = value
        end
    end

    return element
end

function PropertySystem:__init()
    self._values = {}
    self._observers = {}

    self.set = function(name, value, ...)
        local oldValue = self._values[name]
        local config = self._properties[name]
        if(config~=nil)then
            if(config.setter) then
                value = config.setter(self, value, ...)
            end
            if config.canTriggerRender then
                self:updateRender()
            end
            self._values[name] = applyHooks(self, name, value, config)
            if oldValue ~= value and self._observers[name] then
                for _, callback in ipairs(self._observers[name]) do
                    callback(self, value, oldValue)
                end
            end
        end
    end

    self.get = function(name, ...)
        local value = self._values[name]
        local config = self._properties[name]
        if(config==nil)then errorManager.error("Property not found: "..name) return end
        if type(value) == "function" and config.type ~= "function" then
            value = value(self)
        end
        return config.getter and config.getter(self, value, ...) or value
    end

    local properties = {}
    local currentClass = getmetatable(self).__index

    while currentClass do
        if rawget(currentClass, '_properties') then
            for name, config in pairs(currentClass._properties) do
                if not properties[name] then
                    properties[name] = config
                end
            end
        end
        currentClass = getmetatable(currentClass) and rawget(getmetatable(currentClass), '__index')
    end

    self._properties = properties

    local originalMT = getmetatable(self)
    local originalIndex = originalMT.__index
    setmetatable(self, {
        __index = function(t, k)
            local config = self._properties[k]
            if config then
                local value = self._values[k]
                if type(value) == "function" and config.type ~= "function" then
                    value = value(self)
                end
                return value
            end
            if type(originalIndex) == "function" then
                return originalIndex(t, k)
            else
                return originalIndex[k]
            end
        end,
        __newindex = function(t, k, v)
            local config = self._properties[k]
            if config then
                if config.setter then
                    v = config.setter(self, v)
                end
                v = applyHooks(self, k, v, config)
                self:_updateProperty(k, v)
            else
                rawset(t, k, v)
            end
        end,
        __tostring = function(self)
            return string.format("Object: %s (id: %s)", self._values.type, self.id)
        end
    })

    for name, config in pairs(properties) do
        if self._values[name] == nil then
            if type(config.default) == "table" then
                self._values[name] = deepCopy(config.default)
            else
                self._values[name] = config.default
            end
        end
    end

    return self
end

function PropertySystem:_updateProperty(name, value)
    local oldValue = self._values[name]
    if type(oldValue) == "function" then
        oldValue = oldValue(self)
    end

    self._values[name] = value
    local newValue = type(value) == "function" and value(self) or value

    if oldValue ~= newValue then
        if self._properties[name].canTriggerRender then
            self:updateRender()
        end
        if self._observers[name] then
            for _, callback in ipairs(self._observers[name]) do
                callback(self, newValue, oldValue)
            end
        end
    end
end

function PropertySystem:observe(name, callback)
    self._observers[name] = self._observers[name] or {}
    table.insert(self._observers[name], callback)
    return self
end

function PropertySystem:removeObserver(name, callback)
    if self._observers[name] then
        for i, cb in ipairs(self._observers[name]) do
            if cb == callback then
                table.remove(self._observers[name], i)
                if #self._observers[name] == 0 then
                    self._observers[name] = nil
                end
                break
            end
        end
    end
    return self
end

function PropertySystem:removeAllObservers(name)
    if name then
        self._observers[name] = nil
    else
        self._observers = {}
    end
    return self
end

function PropertySystem:instanceProperty(name, config)
    PropertySystem.defineProperty(self, name, config)
    self._values[name] = config.default
    return self
end

function PropertySystem:removeProperty(name)
    self._values[name] = nil
    self._properties[name] = nil
    self._observers[name] = nil

    local capitalizedName = name:sub(1,1):upper() .. name:sub(2)
    self["get" .. capitalizedName] = nil
    self["set" .. capitalizedName] = nil
    return self
end

function PropertySystem:getPropertyConfig(name)
    return self._properties[name]
end

return PropertySystem",
    ["elements/Dropdown.lua"] = "local VisualElement = require("elements/VisualElement")
local List = require("elements/List")
local tHex = require("libraries/colorHex")

---@class Dropdown : List
local Dropdown = setmetatable({}, List)
Dropdown.__index = Dropdown

Dropdown.defineProperty(Dropdown, "isOpen", {default = false, type = "boolean", canTriggerRender = true})
Dropdown.defineProperty(Dropdown, "dropdownHeight", {default = 5, type = "number"})
Dropdown.defineProperty(Dropdown, "selectedText", {default = "", type = "string"})
Dropdown.defineProperty(Dropdown, "dropSymbol", {default = "\31", type = "string"})  -- ▼ Symbol

function Dropdown.new()
    local self = setmetatable({}, Dropdown):__init()
    self.set("width", 16)
    self.set("height", 1)
    self.set("z", 8)
    return self
end

function Dropdown:init(props, basalt)
    List.init(self, props, basalt)
    self.set("type", "Dropdown")
end

function Dropdown:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end
    
    local relX, relY = self:getRelativePosition(x, y)
    
    if relY == 1 then  -- Klick auf Header
        self.set("isOpen", not self.get("isOpen"))
        if not self.get("isOpen") then
            self.set("height", 1)
        else
            self.set("height", 1 + math.min(self.get("dropdownHeight"), #self.get("items")))
        end
        return true
    elseif self.get("isOpen") and relY > 1 then
        -- Offset für die Liste korrigieren (relY - 1 wegen Header)
        local index = relY - 1 + self.get("offset")
        local items = self.get("items")

        if index <= #items then
            local item = items[index]
            if type(item) == "table" and item.separator then
                return false
            end
            
            self.set("selectedIndex", index)
            self.set("isOpen", false)
            self.set("height", 1)

            if type(item) == "table" and item.callback then
                item.callback(self)
            end

            self:fireEvent("select", index, item)
            return true
        end
    end
    return false
end

function Dropdown:render()
    VisualElement.render(self)
    
    -- Header rendern
    local text = self.get("selectedText")
    if #text == 0 and self.get("selectedIndex") > 0 then
        local item = self.get("items")[self.get("selectedIndex")]
        text = type(item) == "table" and item.text or tostring(item)
    end
    
    self:blit(1, 1, text .. string.rep(" ", self.get("width") - #text - 1) .. (self.get("isOpen") and "\31" or "\17"),
        string.rep(tHex[self.get("foreground")], self.get("width")),
        string.rep(tHex[self.get("background")], self.get("width")))

    -- Items nur rendern wenn offen
    if self.get("isOpen") then
        local items = self.get("items")
        local offset = self.get("offset")
        local selected = self.get("selectedIndex")
        local width = self.get("width")

        -- Liste ab Zeile 2 rendern (unterhalb des Headers)
        for i = 2, self.get("height") do
            local itemIndex = i - 1 + offset  -- -1 wegen Header
            local item = items[itemIndex]

            if item then
                if type(item) == "table" and item.separator then
                    local separatorChar = (item.text or "-"):sub(1,1)
                    local separatorText = string.rep(separatorChar, width)
                    local fg = item.foreground or self.get("foreground")
                    local bg = item.background or self.get("background")

                    self:textBg(1, i, string.rep(" ", width), bg)
                    self:textFg(1, i, separatorText, fg)
                else
                    local itemText = type(item) == "table" and item.text or tostring(item)
                    local isSelected = itemIndex == selected
                    
                    local bg = isSelected and 
                        (item.selectedBackground or self.get("selectedColor")) or
                        (item.background or self.get("background"))

                    local fg = isSelected and 
                        (item.selectedForeground or colors.white) or 
                        (item.foreground or self.get("foreground"))

                    self:textBg(1, i, string.rep(" ", width), bg)
                    self:textFg(1, i, itemText, fg)
                end
            end
        end
    end
end

return Dropdown
",
    ["elements/Input.lua"] = "local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")

---@class Input : VisualElement
local Input = setmetatable({}, VisualElement)
Input.__index = Input

---@property text string Input - text to be displayed
Input.defineProperty(Input, "text", {default = "", type = "string", canTriggerRender = true})

---@property cursorPos number Input - current cursor position
Input.defineProperty(Input, "cursorPos", {default = 1, type = "number"})

---@property viewOffset number Input - offset of view
Input.defineProperty(Input, "viewOffset", {default = 0, type = "number", canTriggerRender = true})

-- Neue Properties
Input.defineProperty(Input, "maxLength", {default = nil, type = "number"})
Input.defineProperty(Input, "placeholder", {default = "asd", type = "string"})
Input.defineProperty(Input, "placeholderColor", {default = colors.gray, type = "number"})
Input.defineProperty(Input, "focusedColor", {default = colors.blue, type = "number"})
Input.defineProperty(Input, "pattern", {default = nil, type = "string"})

Input.listenTo(Input, "mouse_click")
Input.listenTo(Input, "key")
Input.listenTo(Input, "char")

--- Creates a new Input instance
--- @return Input object The newly created Input instance
--- @usage local element = Input.new("myId", basalt)
function Input.new()
    local self = setmetatable({}, Input):__init()
    self.set("width", 8)
    self.set("z", 3)
    return self
end

function Input:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Input")
end

function Input:char(char)
    if not self.get("focused") then return end
    local text = self.get("text")
    local pos = self.get("cursorPos")
    local maxLength = self.get("maxLength")
    local pattern = self.get("pattern")

    if maxLength and #text >= maxLength then return end
    if pattern and not char:match(pattern) then return end

    self.set("text", text:sub(1, pos-1) .. char .. text:sub(pos))
    self.set("cursorPos", pos + 1)
    self:updateRender()
    self:updateViewport()
end

function Input:key(key)
    if not self.get("focused") then return end
    local pos = self.get("cursorPos")
    local text = self.get("text")
    local viewOffset = self.get("viewOffset")
    local width = self.get("width")

    if key == keys.left then
        if pos > 1 then
            self.set("cursorPos", pos - 1)
            if pos - 1 <= viewOffset then
                self.set("viewOffset", math.max(0, pos - 2))
            end
        end
    elseif key == keys.right then
        if pos <= #text then
            self.set("cursorPos", pos + 1)
            if pos - viewOffset >= width then
                self.set("viewOffset", pos - width + 1)
            end
        end
    elseif key == keys.backspace then
        if pos > 1 then
            self.set("text", text:sub(1, pos-2) .. text:sub(pos))
            self.set("cursorPos", pos - 1)
            self:updateRender()
            self:updateViewport()
        end
    end

    local relativePos = self.get("cursorPos") - self.get("viewOffset")
    self:setCursor(relativePos, 1, true)
end

function Input:focus()
    VisualElement.focus(self)
    self:updateRender()
end

function Input:blur()
    VisualElement.blur(self)
    self:updateRender()
end

function Input:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        local relX, relY = self:getRelativePosition(x, y)
        local text = self.get("text")
        self:setCursor(math.min(relX, #text + 1), relY, true)
        self:set("cursorPos", relX + self.get("viewOffset"))
        return true
    end
end

function Input:updateViewport()
    local width = self.get("width")
    local cursorPos = self.get("cursorPos")
    local viewOffset = self.get("viewOffset")
    local textLength = #self.get("text")

    if cursorPos - viewOffset > width then
        self.set("viewOffset", cursorPos - width)
    elseif cursorPos <= viewOffset then

        self.set("viewOffset", math.max(0, cursorPos - 1))
    end

    if viewOffset > textLength - width then
        self.set("viewOffset", math.max(0, textLength - width))
    end
end

function Input:render()
    local text = self.get("text")
    local viewOffset = self.get("viewOffset")
    local width = self.get("width")
    local placeholder = self.get("placeholder")
    local focusedColor = self.get("focusedColor")
    local focused = self.get("focused")
    local width, height = self.get("width"), self.get("height")
    self:multiBlit(1, 1, width, height, " ", tHex[self.get("foreground")], tHex[focused and focusedColor or self.get("background")])

    if #text == 0 and #placeholder ~= 0 and self.get("focused") == false then
        self:textFg(1, 1, placeholder:sub(1, width), self.get("placeholderColor"))
        return
    end

    local visibleText = text:sub(viewOffset + 1, viewOffset + width)
    self:textFg(1, 1, visibleText, self.get("foreground"))
end

return Input",
    ["plugins/benchmark.lua"] = "local log = require("log")

local activeProfiles = setmetatable({}, {__mode = "k"})

local function createProfile()
    return {
        methods = {},
    }
end

local function wrapMethod(element, methodName)
    local originalMethod = element[methodName]

    if not activeProfiles[element] then
        activeProfiles[element] = createProfile()
    end
    if not activeProfiles[element].methods[methodName] then
        activeProfiles[element].methods[methodName] = {
            calls = 0,
            totalTime = 0,
            minTime = math.huge,
            maxTime = 0,
            lastTime = 0,
            startTime = 0,
            path = {},
            methodName = methodName,
            originalMethod = originalMethod
        }
    end

    element[methodName] = function(self, ...)
        self:startProfile(methodName)
        local result = originalMethod(self, ...)
        self:endProfile(methodName)
        return result
    end
end

local BaseElement = {}

function BaseElement:startProfile(methodName)
    local profile = activeProfiles[self]
    if not profile then 
        profile = createProfile()
        activeProfiles[self] = profile
    end

    if not profile.methods[methodName] then
        profile.methods[methodName] = {
            calls = 0,
            totalTime = 0,
            minTime = math.huge,
            maxTime = 0,
            lastTime = 0,
            startTime = 0,
            path = {},
            methodName = methodName
        }
    end

    local methodProfile = profile.methods[methodName]
    methodProfile.startTime = os.clock() * 1000
    methodProfile.path = {}

    local current = self
    while current do
        table.insert(methodProfile.path, 1, current.get("name") or current.get("id"))
        current = current.parent
    end
    return self
end

function BaseElement:endProfile(methodName)
    local profile = activeProfiles[self]
    if not profile or not profile.methods[methodName] then return self end

    local methodProfile = profile.methods[methodName]
    local endTime = os.clock() * 1000
    local duration = endTime - methodProfile.startTime

    methodProfile.calls = methodProfile.calls + 1
    methodProfile.totalTime = methodProfile.totalTime + duration
    methodProfile.minTime = math.min(methodProfile.minTime, duration)
    methodProfile.maxTime = math.max(methodProfile.maxTime, duration)
    methodProfile.lastTime = duration

    return self
end

function BaseElement:benchmark(methodName)
    if not self[methodName] then
        log.error("Method " .. methodName .. " does not exist")
        return self
    end

    activeProfiles[self] = createProfile()
    activeProfiles[self].methodName = methodName
    activeProfiles[self].isRunning = true

    wrapMethod(self, methodName)
    return self
end

function BaseElement:logBenchmark(methodName)
    local profile = activeProfiles[self]
    if not profile or not profile.methods[methodName] then return self end

    local stats = profile.methods[methodName]
    if stats then
        local averageTime = stats.calls > 0 and (stats.totalTime / stats.calls) or 0
        log.info(string.format(
            "Benchmark results for %s.%s: " ..
            "Path: %s " ..
            "Calls: %d " ..
            "Average time: %.2fms " ..
            "Min time: %.2fms " ..
            "Max time: %.2fms " ..
            "Last time: %.2fms " ..
            "Total time: %.2fms",
            table.concat(stats.path, "."),
            stats.methodName,
            table.concat(stats.path, "/"),
            stats.calls,
            averageTime,
            stats.minTime ~= math.huge and stats.minTime or 0,
            stats.maxTime,
            stats.lastTime,
            stats.totalTime
        ))
    end
    return self
end

function BaseElement:stopBenchmark(methodName)
    local profile = activeProfiles[self]
    if not profile or not profile.methods[methodName] then return self end

    local stats = profile.methods[methodName]
    if stats and stats.originalMethod then
        self[methodName] = stats.originalMethod
    end

    profile.methods[methodName] = nil
    if not next(profile.methods) then
        activeProfiles[self] = nil
    end
    return self
end

function BaseElement:getBenchmarkStats(methodName)
    local profile = activeProfiles[self]
    if not profile or not profile.methods[methodName] then return nil end

    local stats = profile.methods[methodName]
    return {
        averageTime = stats.totalTime / stats.calls,
        totalTime = stats.totalTime,
        calls = stats.calls,
        minTime = stats.minTime,
        maxTime = stats.maxTime,
        lastTime = stats.lastTime
    }
end

local Container = {}

function Container:benchmarkContainer(methodName)
    self:benchmark(methodName)

    for _, child in pairs(self.get("children")) do
        child:benchmark(methodName)

        if child:isType("Container") then
            child:benchmarkContainer(methodName)
        end
    end
    return self
end

function Container:logContainerBenchmarks(methodName, depth)
    depth = depth or 0
    local indent = string.rep("  ", depth)
    local childrenTotalTime = 0
    local childrenStats = {}

    for _, child in pairs(self.get("children")) do
        local profile = activeProfiles[child]
        if profile and profile.methods[methodName] then
            local stats = profile.methods[methodName]
            childrenTotalTime = childrenTotalTime + stats.totalTime
            table.insert(childrenStats, {
                element = child,
                type = child.get("type"),
                calls = stats.calls,
                totalTime = stats.totalTime,
                avgTime = stats.totalTime / stats.calls
            })
        end
    end

    local profile = activeProfiles[self]
    if profile and profile.methods[methodName] then
        local stats = profile.methods[methodName]
        local selfTime = stats.totalTime - childrenTotalTime
        local avgSelfTime = selfTime / stats.calls

        log.info(string.format(
            "%sBenchmark %s (%s): " ..
            "%.2fms/call (Self: %.2fms/call) " ..
            "[Total: %dms, Calls: %d]",
            indent,
            self.get("type"),
            methodName,
            stats.totalTime / stats.calls,
            avgSelfTime,
            stats.totalTime,
            stats.calls
        ))

        if #childrenStats > 0 then
            for _, childStat in ipairs(childrenStats) do
                if childStat.element:isType("Container") then
                    childStat.element:logContainerBenchmarks(methodName, depth + 1)
                else
                    log.info(string.format("%s> %s: %.2fms/call [Total: %dms, Calls: %d]",
                        indent .. " ",
                        childStat.type,
                        childStat.avgTime,
                        childStat.totalTime,
                        childStat.calls
                    ))
                end
            end
        end
    end
    
    return self
end

function Container:stopContainerBenchmark(methodName)
    for _, child in pairs(self.get("children")) do
        if child:isType("Container") then
            child:stopContainerBenchmark(methodName)
        else
            child:stopBenchmark(methodName)
        end
    end

    self:stopBenchmark(methodName)
    return self
end

local API = {
    start = function(name, options)
        options = options or {}
        local profile = createProfile()
        profile.name = name
        profile.startTime = os.clock() * 1000
        profile.custom = true
        activeProfiles[name] = profile
    end,

    stop = function(name)
        local profile = activeProfiles[name]
        if not profile or not profile.custom then return end

        local endTime = os.clock() * 1000
        local duration = endTime - profile.startTime

        profile.calls = profile.calls + 1
        profile.totalTime = profile.totalTime + duration
        profile.minTime = math.min(profile.minTime, duration)
        profile.maxTime = math.max(profile.maxTime, duration)
        profile.lastTime = duration

        log.info(string.format(
            "Custom Benchmark '%s': " ..
            "Calls: %d " ..
            "Average time: %.2fms " ..
            "Min time: %.2fms " ..
            "Max time: %.2fms " ..
            "Last time: %.2fms " ..
            "Total time: %.2fms",
            name,
            profile.calls,
            profile.totalTime / profile.calls,
            profile.minTime,
            profile.maxTime,
            profile.lastTime,
            profile.totalTime
        ))
    end,

    getStats = function(name)
        local profile = activeProfiles[name]
        if not profile then return nil end

        return {
            averageTime = profile.totalTime / profile.calls,
            totalTime = profile.totalTime,
            calls = profile.calls,
            minTime = profile.minTime,
            maxTime = profile.maxTime,
            lastTime = profile.lastTime
        }
    end,

    clear = function(name)
        activeProfiles[name] = nil
    end,

    clearAll = function()
        for k,v in pairs(activeProfiles) do
            if v.custom then
                activeProfiles[k] = nil
            end
        end
    end
}

return {
    BaseElement = BaseElement,
    Container = Container,
    API = API
}",
    ["elements/Menu.lua"] = "local VisualElement = require("elements/VisualElement")
local List = require("elements/List")
local tHex = require("libraries/colorHex")

---@class Menu : List
local Menu = setmetatable({}, List)
Menu.__index = Menu

Menu.defineProperty(Menu, "separatorColor", {default = colors.gray, type = "number"})

function Menu.new()
    local self = setmetatable({}, Menu):__init()
    self.set("width", 30)
    self.set("height", 1)
    self.set("background", colors.gray)
    return self
end

function Menu:init(props, basalt)
    List.init(self, props, basalt)
    self.set("type", "Menu")
    return self
end

function Menu:setItems(items)
    local listItems = {}
    local totalWidth = 0
    for _, item in ipairs(items) do
        if item.separator then
            table.insert(listItems, {text = item.text or "|", selectable = false})
            totalWidth = totalWidth + 1
        else
            local text = " " .. item.text .. " "
            item.text = text
            table.insert(listItems, item)
            totalWidth = totalWidth + #text
        end
    end
    self.set("width", totalWidth)
    return List.setItems(self, listItems)
end

function Menu:render()
    VisualElement.render(self)
    local currentX = 1

    for i, item in ipairs(self.get("items")) do
        local isSelected = i == self.get("selectedIndex")

        local fg = item.selectable == false and self.get("separatorColor") or
            (isSelected and (item.selectedForeground or self.get("foreground")) or
            (item.foreground or self.get("foreground")))

        local bg = isSelected and
            (item.selectedBackground or self.get("selectedColor")) or
            (item.background or self.get("background"))

        self:blit(currentX, 1, item.text,
            string.rep(tHex[fg], #item.text),
            string.rep(tHex[bg], #item.text))

        currentX = currentX + #item.text
    end
end

function Menu:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end
    if(self.get("selectable") == false) then return false end
    local relX = select(1, self:getRelativePosition(x, y))
    local currentX = 1

    for i, item in ipairs(self.get("items")) do
        if relX >= currentX and relX < currentX + #item.text then
            if item.selectable ~= false then
                self.set("selectedIndex", i)
                if type(item) == "table" then
                    if item.callback then
                        item.callback(self)
                    end
                end
                self:fireEvent("select", i, item)
            end
            return true
        end
        currentX = currentX + #item.text
    end
    return false
end

return Menu
",
    ["elements/BaseFrame.lua"] = "local elementManager = require("elementManager")
local Container = elementManager.getElement("Container")
local Render = require("render")

---@class BaseFrame : Container
local BaseFrame = setmetatable({}, Container)
BaseFrame.__index = BaseFrame

---@property text term term nil text
BaseFrame.defineProperty(BaseFrame, "term", {default = nil, type = "table", setter = function(self, value)
    if value == nil or value.setCursorPos == nil then
        return value
    end
    self._render = Render.new(value)
    self._renderUpdate = true
    local width, height = value.getSize()
    self.set("width", width)
    self.set("height", height)
    return value
end})

function BaseFrame.new()
    local self = setmetatable({}, BaseFrame):__init()
    self.set("term", term.current())
    self.set("background", colors.lightGray)
    return self
end

function BaseFrame:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "BaseFrame")
end

function BaseFrame:multiBlit(x, y, width, height, text, fg, bg)
    self._render:multiBlit(x, y, width, height, text, fg, bg)
end

function BaseFrame:textFg(x, y, text, fg)
    self._render:textFg(x, y, text, fg)
end

function BaseFrame:textBg(x, y, text, bg)
    self._render:textBg(x, y, text, bg)
end

function BaseFrame:blit(x, y, text, fg, bg)
    self._render:blit(x, y, text, fg, bg)
end

function BaseFrame:setCursor(x, y, blink)
    local term = self.get("term")
    self._render:setCursor(x, y, blink)
end

function BaseFrame:render()
    if(self._renderUpdate) then
        if self._render ~= nil then
            Container.render(self)
            self._render:render()
            self._renderUpdate = false
        end
    end
end

return BaseFrame",
    ["LuaLS.lua"] = "---@class BaseFrame
---@field text term
local BaseFrame = {}

--- Gets the nil text
---@generic Element: BaseFrame
---@param self Element
---@return term
function BaseFrame:getText()
    return self.text
end

--- Sets the nil text
---@generic Element: BaseFrame
---@param self Element
---@param text term
---@return Element
function BaseFrame:setText(text)
    self.text = text
    return self
end


---@class Button
---@field text string
local Button = {}

--- Gets the Button text
---@generic Element: Button
---@param self Element
---@return string
function Button:getText()
    return self.text
end

--- Sets the Button text
---@generic Element: Button
---@param self Element
---@param text string
---@return Element
function Button:setText(text)
    self.text = text
    return self
end

--- The event that is triggered when the button is clicked
---@generic Element: Button
---@param self Element
---@param callback function
---@return Element
function Button:onMouseClick(callback)
    return self
end


---@class Checkbox
---@field checked boolean
---@field text string
---@field symbol string
local Checkbox = {}

--- Gets the checkbox is checked
---@generic Element: Checkbox
---@param self Element
---@return boolean
function Checkbox:getChecked()
    return self.checked
end

--- Sets the checkbox is checked
---@generic Element: Checkbox
---@param self Element
---@param checked boolean
---@return Element
function Checkbox:setChecked(checked)
    self.checked = checked
    return self
end

--- Gets the text
---@generic Element: Checkbox
---@param self Element
---@return string
function Checkbox:getText()
    return self.text
end

--- Sets the text
---@generic Element: Checkbox
---@param self Element
---@param text string
---@return Element
function Checkbox:setText(text)
    self.text = text
    return self
end

--- Gets the symbol
---@generic Element: Checkbox
---@param self Element
---@return string
function Checkbox:getSymbol()
    return self.symbol
end

--- Sets the symbol
---@generic Element: Checkbox
---@param self Element
---@param symbol string
---@return Element
function Checkbox:setSymbol(symbol)
    self.symbol = symbol
    return self
end


---@class Container
local Container = {}

--- Adds a new Button to the container
---@generic Element: Container
---@param self Element
---@return Button
function Container:addButton()
    return self
end

--- Adds a new Checkbox to the container
---@generic Element: Container
---@param self Element
---@return Checkbox
function Container:addCheckbox()
    return self
end

--- Adds a new Container to the container
---@generic Element: Container
---@param self Element
---@return Container
function Container:addContainer()
    return self
end

--- Adds a new Dropdown to the container
---@generic Element: Container
---@param self Element
---@return Dropdown
function Container:addDropdown()
    return self
end

--- Adds a new Flexbox to the container
---@generic Element: Container
---@param self Element
---@return Flexbox
function Container:addFlexbox()
    return self
end

--- Adds a new Frame to the container
---@generic Element: Container
---@param self Element
---@return Frame
function Container:addFrame()
    return self
end

--- Adds a new Input to the container
---@generic Element: Container
---@param self Element
---@return Input
function Container:addInput()
    return self
end

--- Adds a new Label to the container
---@generic Element: Container
---@param self Element
---@return Label
function Container:addLabel()
    return self
end

--- Adds a new List to the container
---@generic Element: Container
---@param self Element
---@return List
function Container:addList()
    return self
end

--- Adds a new Menu to the container
---@generic Element: Container
---@param self Element
---@return Menu
function Container:addMenu()
    return self
end

--- Adds a new Program to the container
---@generic Element: Container
---@param self Element
---@return Program
function Container:addProgram()
    return self
end

--- Adds a new ProgressBar to the container
---@generic Element: Container
---@param self Element
---@return ProgressBar
function Container:addProgressBar()
    return self
end

--- Adds a new Slider to the container
---@generic Element: Container
---@param self Element
---@return Slider
function Container:addSlider()
    return self
end

--- Adds a new Table to the container
---@generic Element: Container
---@param self Element
---@return Table
function Container:addTable()
    return self
end

--- Adds a new Tree to the container
---@generic Element: Container
---@param self Element
---@return Tree
function Container:addTree()
    return self
end

--- Adds a new VisualElement to the container
---@generic Element: Container
---@param self Element
---@return VisualElement
function Container:addVisualElement()
    return self
end


---@class Input
---@field text string
---@field cursorPos number
---@field viewOffset number
local Input = {}

--- Gets the - text to be displayed
---@generic Element: Input
---@param self Element
---@return string
function Input:getText()
    return self.text
end

--- Sets the - text to be displayed
---@generic Element: Input
---@param self Element
---@param text string
---@return Element
function Input:setText(text)
    self.text = text
    return self
end

--- Gets the - current cursor position
---@generic Element: Input
---@param self Element
---@return number
function Input:getCursorPos()
    return self.cursorPos
end

--- Sets the - current cursor position
---@generic Element: Input
---@param self Element
---@param cursorPos number
---@return Element
function Input:setCursorPos(cursorPos)
    self.cursorPos = cursorPos
    return self
end

--- Gets the - offset of view
---@generic Element: Input
---@param self Element
---@return number
function Input:getViewOffset()
    return self.viewOffset
end

--- Sets the - offset of view
---@generic Element: Input
---@param self Element
---@param viewOffset number
---@return Element
function Input:setViewOffset(viewOffset)
    self.viewOffset = viewOffset
    return self
end


---@class Label
---@field text string
local Label = {}

--- Gets the Label text to be displayed
---@generic Element: Label
---@param self Element
---@return string
function Label:getText()
    return self.text
end

--- Sets the Label text to be displayed
---@generic Element: Label
---@param self Element
---@param text string
---@return Element
function Label:setText(text)
    self.text = text
    return self
end


---@class List
---@field items table
---@field selectedIndex number
---@field selectable boolean
---@field offset number
---@field selectedColor color
local List = {}

--- Gets the of items to display
---@generic Element: List
---@param self Element
---@return table
function List:getItems()
    return self.items
end

--- Sets the of items to display
---@generic Element: List
---@param self Element
---@param items table
---@return Element
function List:setItems(items)
    self.items = items
    return self
end

--- Gets the selected item index
---@generic Element: List
---@param self Element
---@return number
function List:getSelectedIndex()
    return self.selectedIndex
end

--- Sets the selected item index
---@generic Element: List
---@param self Element
---@param selectedIndex number
---@return Element
function List:setSelectedIndex(selectedIndex)
    self.selectedIndex = selectedIndex
    return self
end

--- Gets the items can be selected
---@generic Element: List
---@param self Element
---@return boolean
function List:getSelectable()
    return self.selectable
end

--- Sets the items can be selected
---@generic Element: List
---@param self Element
---@param selectable boolean
---@return Element
function List:setSelectable(selectable)
    self.selectable = selectable
    return self
end

--- Gets the offset
---@generic Element: List
---@param self Element
---@return number
function List:getOffset()
    return self.offset
end

--- Sets the offset
---@generic Element: List
---@param self Element
---@param offset number
---@return Element
function List:setOffset(offset)
    self.offset = offset
    return self
end

--- Gets the for selected item
---@generic Element: List
---@param self Element
---@return color
function List:getSelectedColor()
    return self.selectedColor
end

--- Sets the for selected item
---@generic Element: List
---@param self Element
---@param selectedColor color
---@return Element
function List:setSelectedColor(selectedColor)
    self.selectedColor = selectedColor
    return self
end


---@class ProgressBar
---@field progress number
---@field showPercentage boolean
---@field progressColor color
local ProgressBar = {}

--- Gets the progress (0-100)
---@generic Element: ProgressBar
---@param self Element
---@return number
function ProgressBar:getProgress()
    return self.progress
end

--- Sets the progress (0-100)
---@generic Element: ProgressBar
---@param self Element
---@param progress number
---@return Element
function ProgressBar:setProgress(progress)
    self.progress = progress
    return self
end

--- Gets the percentage text
---@generic Element: ProgressBar
---@param self Element
---@return boolean
function ProgressBar:getShowPercentage()
    return self.showPercentage
end

--- Sets the percentage text
---@generic Element: ProgressBar
---@param self Element
---@param showPercentage boolean
---@return Element
function ProgressBar:setShowPercentage(showPercentage)
    self.showPercentage = showPercentage
    return self
end

--- Gets the bar color
---@generic Element: ProgressBar
---@param self Element
---@return color
function ProgressBar:getProgressColor()
    return self.progressColor
end

--- Sets the bar color
---@generic Element: ProgressBar
---@param self Element
---@param progressColor color
---@return Element
function ProgressBar:setProgressColor(progressColor)
    self.progressColor = progressColor
    return self
end


---@class Slider
---@field step number
---@field max number
---@field horizontal boolean
---@field barColor color
---@field sliderColor color
local Slider = {}

--- Gets the Current step position (1 to width/height)
---@generic Element: Slider
---@param self Element
---@return number
function Slider:getStep()
    return self.step
end

--- Sets the Current step position (1 to width/height)
---@generic Element: Slider
---@param self Element
---@param step number
---@return Element
function Slider:setStep(step)
    self.step = step
    return self
end

--- Gets the Maximum value for value conversion
---@generic Element: Slider
---@param self Element
---@return number
function Slider:getMax()
    return self.max
end

--- Sets the Maximum value for value conversion
---@generic Element: Slider
---@param self Element
---@param max number
---@return Element
function Slider:setMax(max)
    self.max = max
    return self
end

--- Gets the Whether the slider is horizontal
---@generic Element: Slider
---@param self Element
---@return boolean
function Slider:getHorizontal()
    return self.horizontal
end

--- Sets the Whether the slider is horizontal
---@generic Element: Slider
---@param self Element
---@param horizontal boolean
---@return Element
function Slider:setHorizontal(horizontal)
    self.horizontal = horizontal
    return self
end

--- Gets the Colors for the slider bar
---@generic Element: Slider
---@param self Element
---@return color
function Slider:getBarColor()
    return self.barColor
end

--- Sets the Colors for the slider bar
---@generic Element: Slider
---@param self Element
---@param barColor color
---@return Element
function Slider:setBarColor(barColor)
    self.barColor = barColor
    return self
end

--- Gets the color of the slider handle
---@generic Element: Slider
---@param self Element
---@return color
function Slider:getSliderColor()
    return self.sliderColor
end

--- Sets the color of the slider handle
---@generic Element: Slider
---@param self Element
---@param sliderColor color
---@return Element
function Slider:setSliderColor(sliderColor)
    self.sliderColor = sliderColor
    return self
end


---@class VisualElement
---@field x number
---@field y number
---@field z number
---@field width number
---@field height number
---@field background color
---@field foreground color
---@field clicked boole
---@field backgroundEnabled boolean
---@field focused boolean
local VisualElement = {}

--- Gets the x position of the element
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getX()
    return self.x
end

--- Sets the x position of the element
---@generic Element: VisualElement
---@param self Element
---@param x number
---@return Element
function VisualElement:setX(x)
    self.x = x
    return self
end

--- Gets the y position of the element
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getY()
    return self.y
end

--- Sets the y position of the element
---@generic Element: VisualElement
---@param self Element
---@param y number
---@return Element
function VisualElement:setY(y)
    self.y = y
    return self
end

--- Gets the z position of the element
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getZ()
    return self.z
end

--- Sets the z position of the element
---@generic Element: VisualElement
---@param self Element
---@param z number
---@return Element
function VisualElement:setZ(z)
    self.z = z
    return self
end

--- Gets the width of the element
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getWidth()
    return self.width
end

--- Sets the width of the element
---@generic Element: VisualElement
---@param self Element
---@param width number
---@return Element
function VisualElement:setWidth(width)
    self.width = width
    return self
end

--- Gets the height of the element
---@generic Element: VisualElement
---@param self Element
---@return number
function VisualElement:getHeight()
    return self.height
end

--- Sets the height of the element
---@generic Element: VisualElement
---@param self Element
---@param height number
---@return Element
function VisualElement:setHeight(height)
    self.height = height
    return self
end

--- Gets the background color of the element
---@generic Element: VisualElement
---@param self Element
---@return color
function VisualElement:getBackground()
    return self.background
end

--- Sets the background color of the element
---@generic Element: VisualElement
---@param self Element
---@param background color
---@return Element
function VisualElement:setBackground(background)
    self.background = background
    return self
end

--- Gets the foreground color of the element
---@generic Element: VisualElement
---@param self Element
---@return color
function VisualElement:getForeground()
    return self.foreground
end

--- Sets the foreground color of the element
---@generic Element: VisualElement
---@param self Element
---@param foreground color
---@return Element
function VisualElement:setForeground(foreground)
    self.foreground = foreground
    return self
end

--- Gets the false element is currently clicked
---@generic Element: VisualElement
---@param self Element
---@return boole
function VisualElement:getClicked()
    return self.clicked
end

--- Sets the false element is currently clicked
---@generic Element: VisualElement
---@param self Element
---@param clicked boole
---@return Element
function VisualElement:setClicked(clicked)
    self.clicked = clicked
    return self
end

--- Gets the whether the background is enabled
---@generic Element: VisualElement
---@param self Element
---@return boolean
function VisualElement:getBackgroundEnabled()
    return self.backgroundEnabled
end

--- Sets the whether the background is enabled
---@generic Element: VisualElement
---@param self Element
---@param backgroundEnabled boolean
---@return Element
function VisualElement:setBackgroundEnabled(backgroundEnabled)
    self.backgroundEnabled = backgroundEnabled
    return self
end

--- Gets the whether the element is focused
---@generic Element: VisualElement
---@param self Element
---@return boolean
function VisualElement:getFocused()
    return self.focused
end

--- Sets the whether the element is focused
---@generic Element: VisualElement
---@param self Element
---@param focused boolean
---@return Element
function VisualElement:setFocused(focused)
    self.focused = focused
    return self
end
",
    ["elements/Tree.lua"] = "local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")

---@class Tree : VisualElement
local Tree = setmetatable({}, VisualElement)
Tree.__index = Tree

Tree.defineProperty(Tree, "nodes", {default = {}, type = "table", canTriggerRender = true})
Tree.defineProperty(Tree, "selectedNode", {default = nil, type = "table", canTriggerRender = true})
Tree.defineProperty(Tree, "expandedNodes", {default = {}, type = "table", canTriggerRender = true})
Tree.defineProperty(Tree, "scrollOffset", {default = 0, type = "number", canTriggerRender = true})
Tree.defineProperty(Tree, "nodeColor", {default = colors.white, type = "number"})
Tree.defineProperty(Tree, "selectedColor", {default = colors.lightBlue, type = "number"})

Tree.listenTo(Tree, "mouse_click")
Tree.listenTo(Tree, "mouse_scroll")

function Tree.new()
    local self = setmetatable({}, Tree):__init()
    self.set("width", 30)
    self.set("height", 10)
    self.set("z", 5)
    return self
end

function Tree:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Tree")
    return self
end

function Tree:setNodes(nodes)
    self.set("nodes", nodes)
    if #nodes > 0 then
        self.get("expandedNodes")[nodes[1]] = true
    end
    return self
end

function Tree:expandNode(node)
    self.get("expandedNodes")[node] = true
    self:updateRender()
    return self
end

function Tree:collapseNode(node)
    self.get("expandedNodes")[node] = nil
    self:updateRender()
    return self
end

function Tree:toggleNode(node)
    if self.get("expandedNodes")[node] then
        self:collapseNode(node)
    else
        self:expandNode(node)
    end
    return self
end

local function flattenTree(nodes, expandedNodes, level, result)
    result = result or {}
    level = level or 0

    for _, node in ipairs(nodes) do
        table.insert(result, {node = node, level = level})
        if expandedNodes[node] and node.children then
            flattenTree(node.children, expandedNodes, level + 1, result)
        end
    end
    return result
end

function Tree:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end

    local relX, relY = self:getRelativePosition(x, y)
    local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
    local visibleIndex = relY + self.get("scrollOffset")

    if flatNodes[visibleIndex] then
        local nodeInfo = flatNodes[visibleIndex]
        local node = nodeInfo.node

        if relX <= nodeInfo.level * 2 + 2 then
            self:toggleNode(node)
        end

        self.set("selectedNode", node)
        self:fireEvent("node_select", node)
    end
    return true
end

function Tree:onSelect(callback)
    self:registerCallback("node_select", callback)
    return self
end

function Tree:mouse_scroll(direction)
    local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
    local maxScroll = math.max(0, #flatNodes - self.get("height"))
    local newScroll = math.min(maxScroll, math.max(0, self.get("scrollOffset") + direction))
    
    self.set("scrollOffset", newScroll)
    return true
end

function Tree:render()
    VisualElement.render(self)
    
    local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
    local height = self.get("height")
    local selectedNode = self.get("selectedNode")
    local expandedNodes = self.get("expandedNodes")
    local scrollOffset = self.get("scrollOffset")

    for y = 1, height do
        local nodeInfo = flatNodes[y + scrollOffset]
        if nodeInfo then
            local node = nodeInfo.node
            local level = nodeInfo.level
            local indent = string.rep("  ", level)
            
            -- Expand/Collapse Symbol
            local symbol = " "
            if node.children and #node.children > 0 then
                symbol = expandedNodes[node] and "\31" or "\16"
            end

            local bg = node == selectedNode and self.get("selectedColor") or self.get("background")
            local text = indent .. symbol .." " .. (node.text or "Node")
            
            self:blit(1, y, text .. string.rep(" ", self.get("width") - #text),
                string.rep(tHex[self.get("nodeColor")], self.get("width")),
                string.rep(tHex[bg], self.get("width")))
        else
            -- Leere Zeile
            self:blit(1, y, string.rep(" ", self.get("width")),
                string.rep(tHex[self.get("foreground")], self.get("width")),
                string.rep(tHex[self.get("background")], self.get("width")))
        end
    end
end

return Tree
",
    ["plugins/xml.lua"] = "local errorManager = require("errorManager")

local function parseTag(str)
    local tag = {
        attributes = {}
    }
    tag.name = str:match("<(%w+)")
    for k,v in str:gmatch('%s(%w+)="([^"]-)"') do
        tag.attributes[k] = v
    end
    return tag
end

local function parseXML(self, xmlString)
    local stack = {}
    local root = {children = {}}
    local current = root
    local inCDATA = false
    local cdataContent = ""

    for line in xmlString:gmatch("[^\r\n]+") do
        line = line:match("^%s*(.-)%s*$")
        self.basalt.LOGGER.debug("Parsing line: " .. line)

        if line:match("^<!%[CDATA%[") then
            inCDATA = true
            cdataContent = ""
        elseif line:match("%]%]>$") and inCDATA then
            inCDATA = false
            current.content = cdataContent
        elseif inCDATA then
            cdataContent = cdataContent .. line .. "\n"
        elseif line:match("^<[^/]") then
            local tag = parseTag(line)
            tag.children = {}
            tag.content = ""
            table.insert(current.children, tag)

            if not line:match("/>$") then
                table.insert(stack, current)
                current = tag
            end
        elseif line:match("^</") then
            current = table.remove(stack)
        end
    end
    return root
end

local function evaluateExpression(expr, scope)
    if not expr:match("^%${.*}$") then
        return expr:gsub("%${(.-)}", function(e)
            local env = setmetatable({}, {__index = function(_, k)
                return scope and scope[k] or _ENV[k]
            end})

            local func, err = load("return " .. e, "expression", "t", env)
            if not func then
                errorManager.error("Failed to parse expression: " .. err)
            end
            return tostring(func())
        end)
    end

    expr = expr:match("^%${(.*)}$")
    local env = setmetatable({}, {__index = function(_, k)
        return scope and scope[k] or _ENV[k]
    end})

    local func, err = load("return " .. expr, "expression", "t", env)
    if not func then
        errorManager.error("Failed to parse expression: " .. err)
    end
    return func()
end

local function convertValue(value, propertyType, scope)
    if propertyType == "string" and type(value) == "string" then
        if value:find("${") then
            return evaluateExpression(value, scope)
        end
    end

    if type(value) == "string" and value:match("^%${.*}$") then
        return evaluateExpression(value, scope)
    end

    if propertyType == "number" then
        return tonumber(value)
    elseif propertyType == "boolean" then
        return value == "true"
    elseif propertyType == "color" then
        return colors[value]
    elseif propertyType == "table" then
        local env = setmetatable({}, { __index = _ENV })
        local func = load("return "..value, nil, "t", env)
        if func then
            return func()
        end
    end
    return value
end

local function handleEvent(node, element, scope)
    for attr, value in pairs(node.attributes) do
        if attr:match("^on%u") then
            local eventName = attr:sub(3,3):lower() .. attr:sub(4)
            if scope[value] then
                element["on"..eventName:sub(1,1):upper()..eventName:sub(2)](element, scope[value])
            end
        end
    end

    for _, child in ipairs(node.children or {}) do
        if child.name and child.name:match("^on%u") then
            local eventName = child.name:sub(3,3):lower() .. child.name:sub(4)

            if child.content then
                local code = child.content:gsub("^%s+", ""):gsub("%s+$", "")

                local func, err = load(string.format([[
                    return %s
                ]], code), "event", "t", scope)

                if err then
                    errorManager.error("Failed to parse event: " .. err)
                elseif func then
                    element["on"..eventName:sub(1,1):upper()..eventName:sub(2)](element, func())
                end
            end
        end
    end
end

local BaseElement = {}

function BaseElement:fromXML(node)
    for attr, value in pairs(node.attributes) do
        local config = self:getPropertyConfig(attr)
        if config then
            local convertedValue = convertValue(value, config.type)
            self.set(attr, convertedValue)
        end
    end
    return self
end

local Container = {}

function Container:loadXML(content, scope)
    local tree = parseXML(self, content)

    local function createElements(nodes, parent, scope)
        for _, node in ipairs(nodes.children) do
            if not node.name:match("^on") then
                local elementType = node.name:sub(1,1):upper() .. node.name:sub(2)
                local element = parent["add"..elementType](parent, node.attributes.name)

                for attr, value in pairs(node.attributes) do
                    local config = element:getPropertyConfig(attr)
                    if config then
                        local convertedValue = convertValue(value, config.type, scope)
                        element.set(attr, convertedValue)
                    end
                end

                handleEvent(node, element, scope)

                if #node.children > 0 then
                    createElements(node, element, scope)
                end
            end
        end
    end

    createElements(tree, self, scope)
    return self
end

return {
    BaseElement = BaseElement,
    Container = Container
}

",
    ["elements/List.lua"] = "local VisualElement = require("elements/VisualElement")

---@class List : VisualElement
local List = setmetatable({}, VisualElement)
List.__index = List

---@property items table List of items to display
List.defineProperty(List, "items", {default = {}, type = "table", canTriggerRender = true})
---@property selectedIndex number Currently selected item index
List.defineProperty(List, "selectedIndex", {default = 0, type = "number", canTriggerRender = true})
---@property selectable boolean Whether items can be selected
List.defineProperty(List, "selectable", {default = true, type = "boolean"})
---@property offset number Scrolling offset
List.defineProperty(List, "offset", {default = 0, type = "number", canTriggerRender = true})
---@property selectedColor color Color for selected item
List.defineProperty(List, "selectedColor", {default = colors.blue, type = "number"})

List.listenTo(List, "mouse_click")
List.listenTo(List, "mouse_scroll")

function List.new()
    local self = setmetatable({}, List):__init()
    self.set("width", 16)
    self.set("height", 8)
    self.set("background", colors.gray)
    return self
end

function List:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "List")
end

function List:addItem(text)
    local items = self.get("items")
    table.insert(items, text)
    self:updateRender()
    return self
end

function List:removeItem(index)
    local items = self.get("items")
    table.remove(items, index)
    self:updateRender()
    return self
end

function List:clear()
    self.set("items", {})
    self.set("selectedIndex", 0)
    self:updateRender()
    return self
end

function List:mouse_click(button, x, y)
    if button == 1 and self:isInBounds(x, y) and self.get("selectable") then
        local _, index = self:getRelativePosition(x, y)
        
        local adjustedIndex = index + self.get("offset")
        local items = self.get("items")

        if adjustedIndex <= #items then
            local item = items[adjustedIndex]
            self.set("selectedIndex", adjustedIndex)

            if type(item) == "table" and item.callback then
                item.callback(self)
            end

            self:fireEvent("select", adjustedIndex, item)
            self:updateRender()
            return true
        end
    end
    return false
end

function List:mouse_scroll(direction, x, y)
    if self:isInBounds(x, y) then
        local offset = self.get("offset")
        local maxOffset = math.max(0, #self.get("items") - self.get("height"))
        
        offset = math.min(maxOffset, math.max(0, offset + direction))
        self.set("offset", offset)
        return true
    end
end

function List:onSelect(callback)
    self:registerCallback("select", callback)
    return self
end

function List:render()
    VisualElement.render(self)

    local items = self.get("items")
    local height = self.get("height")
    local offset = self.get("offset")
    local selected = self.get("selectedIndex")
    local width = self.get("width")

    for i = 1, height do
        local itemIndex = i + offset
        local item = items[itemIndex]

        if item then
            if type(item) == "table" and item.separator then
                local separatorChar = (item.text or "-"):sub(1,1)
                local separatorText = string.rep(separatorChar, width)
                local fg = item.foreground or self.get("foreground")
                local bg = item.background or self.get("background")

                self:textBg(1, i, string.rep(" ", width), bg)
                self:textFg(1, i, separatorText, fg)
            else
                local text = type(item) == "table" and item.text or item
                local isSelected = itemIndex == selected

                local bg = isSelected and 
                    (item.selectedBackground or self.get("selectedColor")) or
                    (item.background or self.get("background"))

                local fg = isSelected and 
                    (item.selectedForeground or colors.white) or 
                    (item.foreground or self.get("foreground"))

                self:textBg(1, i, string.rep(" ", width), bg)
                self:textFg(1, i, text, fg)
            end
        end
    end
end

return List
",
    ["libraries/utils.lua"] = "local floor, len = math.floor, string.len

local utils = {}

function utils.getCenteredPosition(text, totalWidth, totalHeight)
    local textLength = len(text)

    local x = floor((totalWidth - textLength+1) / 2 + 0.5)
    local y = floor(totalHeight / 2 + 0.5)

    return x, y
end

function utils.deepCopy(obj)
    if type(obj) ~= "table" then
        return obj
    end

    local copy = {}
    for k, v in pairs(obj) do
        copy[utils.deepCopy(k)] = utils.deepCopy(v)
    end

    return copy
end

function utils.copy(obj)
    local new = {}
    for k,v in pairs(obj)do
        new[k] = v
    end
    return new
end

function utils.reverse(t)
    local reversed = {}
    for i = #t, 1, -1 do
        table.insert(reversed, t[i])
    end
    return reversed
end

function utils.uuid()
    return string.format('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
    math.random(0, 0xffff), math.random(0, 0xffff), math.random(0, 0xffff),
    math.random(0, 0x0fff) + 0x4000, math.random(0, 0x3fff) + 0x8000,
    math.random(0, 0xffff), math.random(0, 0xffff), math.random(0, 0xffff))
end

function utils.split(str, sep)
    local parts = {}
    local start = 1
    local len = len(str)
    local splitIndex = 1

    while true do
        local index = str:find(sep, start, true)
        if not index then
            parts[splitIndex] = str:sub(start, len)
            break
        end

        parts[splitIndex] = str:sub(start, index - 1)
        start = index + 1
        splitIndex = splitIndex + 1
    end

    return parts
end

return utils",
    ["elements/ProgressBar.lua"] = "local VisualElement = require("elements/VisualElement")

---@class ProgressBar : VisualElement
local ProgressBar = setmetatable({}, VisualElement)
ProgressBar.__index = ProgressBar

---@property progress number Current progress (0-100)
ProgressBar.defineProperty(ProgressBar, "progress", {default = 0, type = "number", canTriggerRender = true})
---@property showPercentage boolean Show percentage text
ProgressBar.defineProperty(ProgressBar, "showPercentage", {default = false, type = "boolean"})
---@property progressColor color Progress bar color
ProgressBar.defineProperty(ProgressBar, "progressColor", {default = colors.lime, type = "number"})

function ProgressBar.new()
    local self = setmetatable({}, ProgressBar):__init()
    self.set("width", 10)
    self.set("height", 1)
    return self
end

function ProgressBar:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "ProgressBar")
end

function ProgressBar:render()
    VisualElement.render(self)
    local width = self.get("width")
    local progress = math.min(100, math.max(0, self.get("progress")))
    local fillWidth = math.floor((width * progress) / 100)

    self:textBg(1, 1, string.rep(" ", fillWidth), self.get("progressColor"))

    if self.get("showPercentage") then
        local text = tostring(progress).."%"
        local x = math.floor((width - #text) / 2) + 1
        self:textFg(x, 1, text, self.get("foreground"))
    end
end

return ProgressBar",
    ["elementManager.lua"] = "local args = table.pack(...)
local dir = fs.getDir(args[2] or "basalt")
local subDir = args[1]
if(dir==nil)then
    error("Unable to find directory "..args[2].." please report this bug to our discord.")
end

local log = require("log")
local defaultPath = package.path
local format = "path;/path/?.lua;/path/?/init.lua;"
local main = format:gsub("path", dir)

local ElementManager = {}
ElementManager._elements = {}
ElementManager._plugins = {}
ElementManager._APIs = {}
local elementsDirectory = fs.combine(dir, "elements")
local pluginsDirectory = fs.combine(dir, "plugins")

log.info("Loading elements from "..elementsDirectory)
if fs.exists(elementsDirectory) then
    for _, file in ipairs(fs.list(elementsDirectory)) do
        local name = file:match("(.+).lua")
        if name then
            log.debug("Found element: "..name)
            ElementManager._elements[name] = {
                class = nil,
                plugins = {},
                loaded = false
            }
        end
    end
end

log.info("Loading plugins from "..pluginsDirectory)
if fs.exists(pluginsDirectory) then
    for _, file in ipairs(fs.list(pluginsDirectory)) do
        local name = file:match("(.+).lua")
        if name then
            log.debug("Found plugin: "..name)
            local plugin = require(fs.combine("plugins", name))
            if type(plugin) == "table" then
                for k,v in pairs(plugin) do
                    if(k ~= "API")then
                        if(ElementManager._plugins[k]==nil)then
                            ElementManager._plugins[k] = {}
                        end
                        table.insert(ElementManager._plugins[k], v)
                    else
                        ElementManager._APIs[name] = v
                    end
                end
            end
        end
    end
end

function ElementManager.loadElement(name)
    if not ElementManager._elements[name].loaded then
        package.path = main.."rom/?"
        local element = require(fs.combine("elements", name))
        package.path = defaultPath
        ElementManager._elements[name] = {
            class = element,
            plugins = element.plugins,
            loaded = true
        }
        log.debug("Loaded element: "..name)

        if(ElementManager._plugins[name]~=nil)then
            for _, plugin in pairs(ElementManager._plugins[name]) do
                if(plugin.setup)then
                    plugin.setup(element)
                end

                if(plugin.hooks)then
                    for methodName, hooks in pairs(plugin.hooks) do
                        local original = element[methodName]
                        if(type(original)~="function")then
                            error("Element "..name.." does not have a method "..methodName)
                        end
                        if(type(hooks)=="function")then
                            element[methodName] = function(self, ...)
                                local result = original(self, ...)
                                local hookResult = hooks(self, ...)
                                return hookResult == nil and result or hookResult
                            end
                        elseif(type(hooks)=="table")then
                            element[methodName] = function(self, ...)
                                if hooks.pre then hooks.pre(self, ...) end
                                local result = original(self, ...)
                                if hooks.post then hooks.post(self, ...) end
                                return result
                            end
                        end
                    end
                end

                for funcName, func in pairs(plugin) do
                    if funcName ~= "setup" and funcName ~= "hooks" then
                        element[funcName] = func
                    end
                end
            end
        end
    end
end

function ElementManager.getElement(name)
    if not ElementManager._elements[name].loaded then
        ElementManager.loadElement(name)
    end
    return ElementManager._elements[name].class
end

function ElementManager.getElementList()
    return ElementManager._elements
end

function ElementManager.getAPI(name)
    return ElementManager._APIs[name]
end

return ElementManager",
    ["elements/Checkbox.lua"] = "local VisualElement = require("elements/VisualElement")

---@class Checkbox : VisualElement
local Checkbox = setmetatable({}, VisualElement)
Checkbox.__index = Checkbox

---@property checked boolean Whether checkbox is checked
Checkbox.defineProperty(Checkbox, "checked", {default = false, type = "boolean", canTriggerRender = true})
---@property text string Label text
Checkbox.defineProperty(Checkbox, "text", {default = "", type = "string", canTriggerRender = true})
---@property symbol string Check symbol
Checkbox.defineProperty(Checkbox, "symbol", {default = "x", type = "string"})

Checkbox.listenTo(Checkbox, "mouse_click")

function Checkbox.new()
    local self = setmetatable({}, Checkbox):__init()
    self.set("width", 1)
    self.set("height", 1)
    return self
end

function Checkbox:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Checkbox")
end

function Checkbox:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        self.set("checked", not self.get("checked"))
        self:fireEvent("change", self.get("checked"))
        return true
    end
end

function Checkbox:render()
    VisualElement.render(self)

    local text = self.get("checked") and self.get("symbol") or " "
    self:textFg(1, 1, "["..text.."]", self.get("foreground"))

    local label = self.get("text")
    if #label > 0 then
        self:textFg(4, 1, label, self.get("foreground"))
    end
end

return Checkbox",
    ["plugins/reactive.lua"] = "local errorManager = require("errorManager")
local PropertySystem = require("propertySystem")
local log = require("log")

local protectedNames = {
    colors = true,
    math = true,
    clamp = true,
    round = true
}

local mathEnv = {
    clamp = function(val, min, max)
        return math.min(math.max(val, min), max)
    end,
    round = function(val)
        return math.floor(val + 0.5)
    end
}

local function parseExpression(expr, element, propName)
    expr = expr:gsub("^{(.+)}$", "%1")

    expr = expr:gsub("([%w_]+)%$([%w_]+)", function(obj, prop)
        if obj == "self" then
            return string.format('__getState("%s")', prop)
        elseif obj == "parent" then
            return string.format('__getParentState("%s")', prop)
        else
            return string.format('__getElementState("%s", "%s")', obj, prop)
        end
    end)

    expr = expr:gsub("([%w_]+)%.([%w_]+)", function(obj, prop)
        if protectedNames[obj] then 
            return obj.."."..prop
        end
        return string.format('__getProperty("%s", "%s")', obj, prop)
    end)

    local env = setmetatable({
        colors = colors,
        math = math,
        tostring = tostring,
        tonumber = tonumber,
        __getState = function(prop)
            return element:getState(prop)
        end,
        __getParentState = function(prop)
            return element.parent:getState(prop)
        end,
        __getElementState = function(objName, prop)
            local target = element:getBaseFrame():getChild(objName)
            if not target then
                errorManager.header = "Reactive evaluation error"
                errorManager.error("Could not find element: " .. objName)
                return nil
            end
            return target:getState(prop).value
        end,
        __getProperty = function(objName, propName)
            if objName == "self" then
                return element.get(propName)
            elseif objName == "parent" then
                return element.parent.get(propName)
            else
                local target = element:getBaseFrame():getChild(objName)
                if not target then
                    errorManager.header = "Reactive evaluation error"
                    errorManager.error("Could not find element: " .. objName)
                    return nil
                end

                return target.get(propName)
            end
        end
    }, { __index = mathEnv })

    if(element._properties[propName].type == "string")then
        expr = "tostring(" .. expr .. ")"
    elseif(element._properties[propName].type == "number")then
        expr = "tonumber(" .. expr .. ")"
    end

    local func, err = load("return "..expr, "reactive", "t", env)
    if not func then
        errorManager.header = "Reactive evaluation error"
        errorManager.error("Invalid expression: " .. err)
        return function() return nil end
    end

    return func
end

local function validateReferences(expr, element)
    for ref in expr:gmatch("([%w_]+)%.") do
        if not protectedNames[ref] then
            if ref == "self" then
            elseif ref == "parent" then
                if not element.parent then
                    errorManager.header = "Reactive evaluation error"
                    errorManager.error("No parent element available")
                    return false
                end
            else
                local target = element:getBaseFrame():getChild(ref)
                if not target then
                    errorManager.header = "Reactive evaluation error"
                    errorManager.error("Referenced element not found: " .. ref)
                    return false
                end
            end
        end
    end
    return true
end

local functionCache = setmetatable({}, {__mode = "k"})

local observerCache = setmetatable({}, {
    __mode = "k",
    __index = function(t, k)
        t[k] = {}
        return t[k]
    end
})

local function setupObservers(element, expr, propertyName)
    if observerCache[element][propertyName] then
        for _, observer in ipairs(observerCache[element][propertyName]) do
            observer.target:removeObserver(observer.property, observer.callback)
        end
    end

    local observers = {}
    for ref, prop in expr:gmatch("([%w_]+)%.([%w_]+)") do
        if not protectedNames[ref] then
            local target
            if ref == "self" then
                target = element
            elseif ref == "parent" then
                target = element.parent
            else
                target = element:getBaseFrame():getChild(ref)
            end

            if target then
                local observer = {
                    target = target,
                    property = prop,
                    callback = function() 
                        element:updateRender()
                    end
                }
                target:observe(prop, observer.callback)
                table.insert(observers, observer)
            end
        end
    end

    observerCache[element][propertyName] = observers
end

PropertySystem.addSetterHook(function(element, propertyName, value, config)
    if type(value) == "string" and value:match("^{.+}$") then
        local expr = value:gsub("^{(.+)}$", "%1")
        if not validateReferences(expr, element) then
            return config.default
        end

        setupObservers(element, expr, propertyName)

        if not functionCache[element] then
            functionCache[element] = {}
        end
        if not functionCache[element][value] then
            local parsedFunc = parseExpression(value, element, propertyName)
            functionCache[element][value] = parsedFunc
        end

        return function(self)
            local success, result = pcall(functionCache[element][value])
            if not success then
                errorManager.header = "Reactive evaluation error"
                if type(result) == "string" then
                    errorManager.error("Error evaluating expression: " .. result)
                else
                    errorManager.error("Error evaluating expression")
                end
                return config.default
            end
            return result
        end
    end
end)

local BaseElement = {}

BaseElement.hooks = {
    destroy = function(self)
        if observerCache[self] then
            for propName, observers in pairs(observerCache[self]) do
                for _, observer in ipairs(observers) do
                    observer.target:removeObserver(observer.property, observer.callback)
                end
            end
            observerCache[self] = nil
        end
    end
}

return {
    BaseElement = BaseElement
}
",
    ["elements/Button.lua"] = "local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local getCenteredPosition = require("libraries/utils").getCenteredPosition

---@class Button : VisualElement
local Button = setmetatable({}, VisualElement)
Button.__index = Button

---@property text string Button Button text
Button.defineProperty(Button, "text", {default = "Button", type = "string", canTriggerRender = true})

---@event mouse_click The event that is triggered when the button is clicked
Button.listenTo(Button, "mouse_click")
Button.listenTo(Button, "mouse_up")

function Button.new()
    local self = setmetatable({}, Button):__init()
    self.set("width", 10)
    self.set("height", 3)
    self.set("z", 5)
    return self
end

function Button:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Button")
end

function Button:render()
    VisualElement.render(self)
    local text = self.get("text")
    local xO, yO = getCenteredPosition(text, self.get("width"), self.get("height"))
    self:textFg(xO, yO, text, self.get("foreground"))
end

return Button",
    ["main.lua"] = "local elementManager = require("elementManager")
local errorManager = require("errorManager")
local propertySystem = require("propertySystem")


--- This is the UI Manager and the starting point for your project. The following functions allow you to influence the default behavior of Basalt.
---
--- Before you can access Basalt, you need to add the following code on top of your file:
--- @usage local basalt = require("basalt")
--- What this code does is it loads basalt into the project, and you can access it by using the variable defined as "basalt".
-- @module Basalt
local basalt = {}
basalt.traceback = true
basalt._events = {}
basalt._schedule = {}
basalt._plugins = {}
basalt.LOGGER = require("log")
basalt.path = fs.getDir(select(2, ...))

local mainFrame = nil
local updaterActive = false
local _type = type

local lazyElements = {}
local lazyElementCount = 10
local lazyElementsTimer = 0
local isLazyElementsTimerActive = false


local function queueLazyElements()
    if(isLazyElementsTimerActive)then return end
    lazyElementsTimer = os.startTimer(0.2)
    isLazyElementsTimerActive = true
end

local function loadLazyElements(count)
    for _=1,count do
        local blueprint = lazyElements[1]
        if(blueprint)then
            blueprint:create()
        end
        table.remove(lazyElements, 1)
    end
end

local function lazyElementsEventHandler(event, timerId)
    if(event=="timer")then
        if(timerId==lazyElementsTimer)then
            loadLazyElements(lazyElementCount)
            isLazyElementsTimerActive = false
            lazyElementsTimer = 0
            if(#lazyElements>0)then
                queueLazyElements()
            end
            return true
        end
    end
end

--- Creates and returns a new UI element of the specified type.
--- @shortDescription Creates a new UI element
--- @param type string The type of element to create (e.g. "Button", "Label", "BaseFrame")
--- @param properties? string|table Optional name for the element or a table with properties to initialize the element with
--- @return table element The created element instance
--- @usage local button = basalt.create("Button")
function basalt.create(type, properties, lazyLoading, parent)
    if(_type(properties)=="string")then properties = {name=properties} end
    if(properties == nil)then properties = {name = type} end
    local elementClass = elementManager.getElement(type)
    if(lazyLoading)then
        local blueprint = propertySystem.blueprint(elementClass, properties, basalt, parent)
        table.insert(lazyElements, blueprint)
        queueLazyElements()
        return blueprint
    else
        local element = elementClass.new()
        element:init(properties, basalt)
        return element
    end
end

--- Creates and returns a new frame
--- @return table BaseFrame The created frame instance
--- @usage local mainFrame = basalt.createFrame()
function basalt.createFrame()
    local frame = basalt.create("BaseFrame")
    frame:postInit()
    mainFrame = frame
    return frame
end

--- Returns the element manager instance
--- @return table ElementManager The element manager
--- @usage local manager = basalt.getElementManager()
function basalt.getElementManager()
    return elementManager
end

--- Gets or creates the main frame
--- @return BaseFrame table The main frame instance
--- @usage local frame = basalt.getMainFrame()
function basalt.getMainFrame()
    if(mainFrame == nil)then
        mainFrame = basalt.createFrame()
    end
    return mainFrame
end

--- Sets the active frame
--- @param frame table The frame to set as active
--- @usage basalt.setActiveFrame(myFrame)
function basalt.setActiveFrame(frame)
    mainFrame = frame
end

--- Schedules a function to be updated
--- @function scheduleUpdate
--- @param func function The function to schedule
--- @return number Id The schedule ID
--- @usage local id = basalt.scheduleUpdate(myFunction)
function basalt.scheduleUpdate(func)
    table.insert(basalt._schedule, func)
    return #basalt._schedule
end

--- Removes a scheduled update
--- @function removeSchedule
--- @param id number The schedule ID to remove
--- @usage basalt.removeSchedule(scheduleId)
function basalt.removeSchedule(id)
    basalt._schedule[id] = nil
end

--- @local Internal event handler
local function updateEvent(event, ...)
    if(event=="terminate")then basalt.stop() end
    if lazyElementsEventHandler(event, ...) then return end

    if(mainFrame)then
        if(mainFrame:dispatchEvent(event, ...))then
            return
        end
    end

    if basalt._events[event] then
        for _, callback in ipairs(basalt._events[event]) do
            callback(...)
        end
    end
end

--- @local Internal render function
local function renderFrames()
    if(mainFrame)then
        mainFrame:render()
    end
end

--- Updates all scheduled functions
--- @usage basalt.update()
function basalt.update()
    for k,v in pairs(basalt._schedule) do
        if type(v)=="function" then
            v()
        end
    end
end

--- Stops the Basalt runtime
--- @usage basalt.stop()
function basalt.stop()
    term.clear()
    term.setCursorPos(1,1)
    updaterActive = false
end

--- Starts the Basalt runtime
--- @param isActive? boolean Whether to start active (default: true)
--- @usage basalt.run()
--- @usage basalt.run(false)
function basalt.run(isActive)
    updaterActive = isActive
    if(isActive==nil)then updaterActive = true end
    local function f()
        renderFrames()
        while updaterActive do
            updateEvent(os.pullEventRaw())
            renderFrames()
        end
    end
    while updaterActive do
        local ok, err = pcall(f)
        if not(ok)then
            errorManager.header = "Basalt Runtime Error"
            errorManager.error(err)
        end
    end
end

function basalt.getAPI(name)
    return elementManager.getAPI(name)
end


return basalt",
  },
}
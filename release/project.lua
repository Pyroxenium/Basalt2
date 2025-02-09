local project = {}
local Render = {}
Render.__index = Render
local colorChars = require("libraries/colorHex")
local log = require("log")

function Render.new(terminal)
    local self = setmetatable({}, Render)
    self.terminal = terminal
    self.width, self.height = terminal.getSize()

    self.buffer = {
        text = {},
        fg = {},
        bg = {},
        changed = {}
    }

    for y=1, self.height do
        self.buffer.text[y] = string.rep(" ", self.width)
        self.buffer.fg[y] = string.rep("0", self.width)
        self.buffer.bg[y] = string.rep("f", self.width)
        self.buffer.changed[y] = false
    end

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
    self.buffer.changed[y] = true

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
            self.buffer.changed[cy] = true
        end
    end

    return self
end

function Render:textFg(x, y, text, fg)
    if y < 1 or y > self.height then return self end
    fg = colorChars[fg] or "0"

    self.buffer.text[y] = self.buffer.text[y]:sub(1,x-1) .. text .. self.buffer.text[y]:sub(x+#text)
    self.buffer.fg[y] = self.buffer.fg[y]:sub(1,x-1) .. fg:rep(#text) .. self.buffer.fg[y]:sub(x+#text)
    self.buffer.changed[y] = true

    return self
end

function Render:text(x, y, text)
    if y < 1 or y > self.height then return self end

    self.buffer.text[y] = self.buffer.text[y]:sub(1,x-1) .. text .. self.buffer.text[y]:sub(x+#text)
    self.buffer.changed[y] = true

    return self
end

function Render:fg(x, y, fg)
    if y < 1 or y > self.height then return self end

    self.buffer.fg[y] = self.buffer.fg[y]:sub(1,x-1) .. fg .. self.buffer.fg[y]:sub(x+#fg)
    self.buffer.changed[y] = true

    return self
end

function Render:bg(x, y, bg)
    if y < 1 or y > self.height then return self end

    self.buffer.bg[y] = self.buffer.bg[y]:sub(1,x-1) .. bg .. self.buffer.bg[y]:sub(x+#bg)
    self.buffer.changed[y] = true

    return self
end

function Render:clear(bg)
    local bgChar = colorChars[bg] or "f"
    for y=1, self.height do
        self.buffer.text[y] = string.rep(" ", self.width)
        self.buffer.fg[y] = string.rep("0", self.width)
        self.buffer.bg[y] = string.rep(bgChar, self.width)
        self.buffer.changed[y] = true
    end
    return self
end

function Render:render()
    for y=1, self.height do
        if self.buffer.changed[y] then
            self.terminal.setCursorPos(1, y)
            self.terminal.blit(
                self.buffer.text[y],
                self.buffer.fg[y],
                self.buffer.bg[y]
            )
            self.buffer.changed[y] = false
        end
    end
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

return Renderlocal args = table.pack(...)
local dir = fs.getDir(args[2] or "basalt")
if(dir==nil)then
    error("Unable to find directory "..args[2].." please report this bug to our discord.")
end

local log = require("log")

local ElementManager = {}
ElementManager._elements = {}
ElementManager._plugins = {}
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

function ElementManager.extendMethod(element, methodName, newMethod, originalMethod)
    if not originalMethod then
        element[methodName] = newMethod
        return
    end
    element[methodName] = function(self, ...)
        if newMethod.before then
            newMethod.before(self, ...)
        end

        local results
        if newMethod.override then
            results = {newMethod.override(self, originalMethod, ...)}
        else
            results = {originalMethod(self, ...)}
        end

        if newMethod.after then
            newMethod.after(self, ...)
        end

        return table.unpack(results)
    end
end

function ElementManager.loadPlugin(name)
    local plugin = require("plugins/"..name)

    -- Apply plugin to each targeted element
    for elementName, pluginData in pairs(plugin) do
        local element = ElementManager._elements[elementName]
        if element then
            -- Register properties
            if pluginData.properties then
                element.class.initialize(elementName.."Plugin")
                for propName, config in pairs(pluginData.properties) do
                    element.class.registerProperty(propName, config)
                end
            end

            -- Register/extend methods
            if pluginData.methods then
                for methodName, methodData in pairs(pluginData.methods) do
                    ElementManager.extendMethod(
                        element.class,
                        methodName,
                        methodData,
                        element.class[methodName]
                    )
                end
            end
        end
    end
end

function ElementManager.loadElement(name)
    if not ElementManager._elements[name].loaded then
        local element = require("elements/"..name)
        ElementManager._elements[name] = {
            class = element,
            plugins = element.plugins,
            loaded = true
        }
        log.debug("Loaded element: "..name)

        -- Load element's required plugins
        if element.requires then
            for pluginName, _ in pairs(element.requires) do
                --ElementManager.loadPlugin(pluginName)
            end
        end
    end
end

function ElementManager.registerPlugin(name, plugin)
    if not plugin.provides then
        error("Plugin must specify what it provides")
    end
    ElementManager._plugins[name] = plugin
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

function ElementManager.generateId()
    return string.format('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
    math.random(0, 0xffff), math.random(0, 0xffff), math.random(0, 0xffff),
    math.random(0, 0x0fff) + 0x4000, math.random(0, 0x3fff) + 0x8000,
    math.random(0, 0xffff), math.random(0, 0xffff), math.random(0, 0xffff))
end

return ElementManager
local args = {...}

local basaltPath = args[1] or "basalt"

local defaultPath = package.path
local format = "path;/path/?.lua;/path/?/init.lua;"

local main = format:gsub("path", basaltPath)
package.path = main.."rom/?"

local function errorHandler(err)
    local errorManager = require("errorManager")
    errorManager.header = "Basalt Loading Error"
    errorManager.error(err)
end

-- Use xpcall with error handler
local ok, result = pcall(require, "main")

if not ok then
    errorHandler(result)
else
    return result
endlocal Container = require("elements/Container")
local Render = require("render")

local BaseFrame = setmetatable({}, Container)
BaseFrame.__index = BaseFrame

---@diagnostic disable-next-line: duplicate-set-field
function BaseFrame.new(id, basalt)
    local self = setmetatable({}, BaseFrame):__init()
    self:init(id, basalt)
    self.terminal = term.current() -- change to :setTerm later!!
    self._render = Render.new(self.terminal)
    self._renderUpdate = true
    local width, height = self.terminal.getSize()
    self.set("width", width)
    self.set("height", height)
    self.set("background", colors.red)
    self.set("type", "BaseFrame")
    return self
end

function BaseFrame:multiBlit(x, y, width, height, text, fg, bg)
    self._render:multiBlit(x, y, width, height, text, fg, bg)
end

function BaseFrame:textFg(x, y, text, fg)
    self._render:textFg(x, y, text, fg)
end

---@diagnostic disable-next-line: duplicate-set-field
function BaseFrame:render()
    if(self._renderUpdate) then
        Container.render(self)
        self._render:render()
        self._renderUpdate = false
    end
end

return BaseFramelocal VisualElement = require("elements/VisualElement")
local getCenteredPosition = require("libraries/utils").getCenteredPosition

local Button = setmetatable({}, VisualElement)
Button.__index = Button

Button.defineProperty(Button, "text", {default = "Button", type = "string"})
Button.listenTo(Button, "mouse_click")

---@diagnostic disable-next-line: duplicate-set-field
function Button.new(id, basalt)
    local self = setmetatable({}, Button):__init()
    self:init(id, basalt)
    self.set("type", "Button")
    self.set("width", 10)
    self.set("height", 3)
    self.set("z", 5)
    return self
end

---@diagnostic disable-next-line: duplicate-set-field
function Button:render()
    VisualElement.render(self)
    local text = self.get("text")
    local xO, yO = getCenteredPosition(text, self.get("width"), self.get("height"))
    self:textFg(xO, yO, text, self.get("foreground"))
end

return Buttonlocal BaseElement = require("elements/BaseElement")
local VisualElement = setmetatable({}, BaseElement)
VisualElement.__index = VisualElement
local tHex = require("libraries/colorHex")

BaseElement.defineProperty(VisualElement, "x", {default = 1, type = "number", canTriggerRender = true})
BaseElement.defineProperty(VisualElement, "y", {default = 1, type = "number", canTriggerRender = true})
BaseElement.defineProperty(VisualElement, "z", {default = 1, type = "number", canTriggerRender = true, setter = function(self, value)
    self.basalt.LOGGER.debug("Setting z to " .. value)
    if self.parent then
        self.parent:sortChildren()
    end
    return value
end})
BaseElement.defineProperty(VisualElement, "width", {default = 1, type = "number", canTriggerRender = true})
BaseElement.defineProperty(VisualElement, "height", {default = 1, type = "number", canTriggerRender = true})
BaseElement.defineProperty(VisualElement, "background", {default = colors.black, type = "number", canTriggerRender = true})
BaseElement.defineProperty(VisualElement, "foreground", {default = colors.white, type = "number", canTriggerRender = true})
BaseElement.defineProperty(VisualElement, "clicked", {default = false, type = "boolean"})

---@diagnostic disable-next-line: duplicate-set-field
function VisualElement.new(id, basalt)
    local self = setmetatable({}, VisualElement):__init()
    self:init(id, basalt)
    self.set("type", "VisualElement")
    return self
end

function VisualElement:multiBlit(x, y, width, height, text, fg, bg)
    x = x + self.get("x") - 1
    y = y + self.get("y") - 1
    self.parent:multiBlit(x, y, width, height, text, fg, bg)
end

function VisualElement:textFg(x, y, text, fg)
    x = x + self.get("x") - 1
    y = y + self.get("y") - 1
    self.parent:textFg(x, y, text, fg)
end

function VisualElement:isInBounds(x, y)
    local xPos, yPos = self.get("x"), self.get("y")
    local width, height = self.get("width"), self.get("height")

    return x >= xPos and x <= xPos + width - 1 and
           y >= yPos and y <= yPos + height - 1
end

function VisualElement:mouse_click(button, x, y)
    if self:isInBounds(x, y) then
        self.set("clicked", true)
        self:fireEvent("mouse_click", button, x, y)
        return true
    end
end

function VisualElement:mouse_up(button, x, y)
    if self:isInBounds(x, y) then
        self.set("clicked", false)
        self:fireEvent("mouse_up", button, x, y)
        return true
    end
    self:fireEvent("mouse_release", button, x, y)
end

function VisualElement:mouse_release()
    self.set("clicked", false)
end

function VisualElement:handleEvent(event, ...)
    if(self[event])then
        return self[event](self, ...)
    end
end

--- Returns the absolute position of the element or the given coordinates.
---@param x? number -- x position
---@param y? number -- y position
function VisualElement:getAbsolutePosition(x, y)
    if (x == nil) or (y == nil) then
        x, y = self.get("x"), self.get("y")
    end

    local parent = self.parent
    while parent do
        local px, py = parent.get("x"), parent.get("y")
        x = x + px - 1
        y = y + py - 1
        parent = parent.parent
    end

    return x, y
end

--- Returns the relative position of the element or the given coordinates.
---@param x? number -- x position
---@param y? number -- y position
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


---@diagnostic disable-next-line: duplicate-set-field
function VisualElement:render()
    local width, height = self.get("width"), self.get("height")
    self:multiBlit(1, 1, width, height, " ", tHex[self.get("foreground")], tHex[self.get("background")])
end

return VisualElementlocal PropertySystem = require("propertySystem") -- muss geändert werden.

local BaseElement = setmetatable({}, PropertySystem)
BaseElement.__index = BaseElement
BaseElement._events = {}

BaseElement.defineProperty(BaseElement, "type", {default = "BaseElement", type = "string"})
BaseElement.defineProperty(BaseElement, "eventCallbacks", {default = {}, type = "table"})

function BaseElement.new(id, basalt)
    local self = setmetatable({}, BaseElement):__init()
    self:init(id, basalt)
    self.set("type", "BaseElement")
    return self
end

function BaseElement:init(id, basalt)
    self.id = id
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
            end
        end
    end
    return self
end

function BaseElement.listenTo(class, eventName)
    if not class._events then
        class._events = {}
    end
    class._events[eventName] = true
end

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

function BaseElement:fireEvent(event, ...)
    if self._values.eventCallbacks[event] then
        for _, callback in ipairs(self._values.eventCallbacks[event]) do
            local result = callback(self, ...)
            return result
        end
    end
    return self
end

function BaseElement:updateRender()
    if(self.parent) then
        self.parent:updateRender()
    else
        self._renderUpdate = true
    end
end

return BaseElementlocal VisualElement = require("elements/VisualElement")
local elementManager = require("elementManager")
local expect = require("libraries/expect")

local max = math.max

local Container = setmetatable({}, VisualElement)
Container.__index = Container

Container.defineProperty(Container, "children", {default = {}, type = "table"})
Container.defineProperty(Container, "childrenEvents", {default = {}, type = "table"})
Container.defineProperty(Container, "eventListenerCount", {default = {}, type = "table"})

for k, _ in pairs(elementManager:getElementList()) do
    local capitalizedName = k:sub(1,1):upper() .. k:sub(2)
    --if not capitalizedName == "BaseFrame" then
        Container["add"..capitalizedName] = function(self, ...)
            expect(1, self, "table")
            local element = self.basalt.create(k, ...)
            self.basalt.LOGGER.debug(capitalizedName.." created with ID: " .. element.id)
            self:addChild(element)
            return element
        end
    --end
end

---@diagnostic disable-next-line: duplicate-set-field
function Container.new(id, basalt)
    local self = setmetatable({}, Container):__init()
    self:init(id, basalt)
    self.set("type", "Container")
    return self
end

function Container:addChild(child)
    if child == self then
        error("Cannot add container to itself")
    end

    local childZ = child.get("z")
    local pos = 1
    for i, existing in ipairs(self._values.children) do
        if existing.get("z") > childZ then
            break
        end
        pos = i + 1
    end

    table.insert(self._values.children, pos, child)
    child.parent = self
    self:registerChildrenEvents(child)
    return self
end

function Container:sortChildren()
    table.sort(self._values.children, function(a, b)
        return a.get("z") < b.get("z")
    end)
end

function Container:sortChildrenEvents(eventName)
    if self._values.childrenEvents[eventName] then
        table.sort(self._values.childrenEvents[eventName], function(a, b)
            return a.get("z") > b.get("z")
        end)
    end
end

function Container:registerChildrenEvents(child)
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

    local childZ = child.get("z")
    local pos = 1
    for i, existing in ipairs(self._values.childrenEvents[eventName]) do
        if existing.get("z") < childZ then
            break
        end
        pos = i + 1
    end

    table.insert(self._values.childrenEvents[eventName], pos, child)
    self._values.eventListenerCount[eventName] = self._values.eventListenerCount[eventName] + 1
end

function Container:removeChildrenEvents(child)
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
    for i,v in ipairs(self.children) do
        if v == child then
            table.remove(self._values.children, i)
            child.parent = nil
            break
        end
    end
    return self
end

function Container:handleEvent(event, ...)
    if(VisualElement.handleEvent(self, event, ...))then
        local args = {...}
        if event:find("mouse_") then
            local button, absX, absY = ...
            local relX, relY = self:getRelativePosition(absX, absY)
            args = {button, relX, relY}
        end
        if self._values.childrenEvents[event] then
            for _, child in ipairs(self._values.childrenEvents[event]) do
                if(child:handleEvent(event, table.unpack(args)))then
                    return true
                end
            end
        end
    end
end

--[[function Container:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        if self._values.childrenEvents.mouse_click then
            for _, child in ipairs(self._values.childrenEvents.mouse_click) do
                if child:mouse_click(button, x, y) then
                    return true
                end
            end
        end
    end
end]]

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

---@diagnostic disable-next-line: duplicate-set-field
function Container:render()
    VisualElement.render(self)
    for _, child in ipairs(self._values.children) do
        if child == self then
            self.basalt.LOGGER.error("CIRCULAR REFERENCE DETECTED!")
            return
        end
        child:render()
    end
end

return Containerlocal Container = require("elements/Container")

local Frame = setmetatable({}, Container)
Frame.__index = Frame

---@diagnostic disable-next-line: duplicate-set-field
function Frame.new(id, basalt)
    local self = setmetatable({}, Frame):__init()
    self:init(id, basalt)
    self.set("width", 12)
    self.set("height", 6)
    self.set("background", colors.blue)
    self.set("type", "Frame")
    self.set("z", 10)
    return self
end

return Framelocal LOGGER = require("log")

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
    error()
end

return errorHandlerlocal floor, len = math.floor, string.len

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

return utilslocal errorManager = require("errorManager")

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

return expectlocal colorHex = {}

for i = 0, 15 do
    colorHex[2^i] = ("%x"):format(i)
    colorHex[("%x"):format(i)] = 2^i
end

return colorHexlocal Log = {}
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

return Loglocal elementManager = require("elementManager")
local expect = require("libraries/expect")
local errorManager = require("errorManager")

local basalt = {}
basalt.traceback = true
basalt._events = {}
basalt._schedule = {}
basalt._plugins = {}
basalt.LOGGER = require("log")

local mainFrame = nil
local updaterActive = false

function basalt.create(type, id)
    if(id==nil)then id = elementManager.generateId() end
    local element = elementManager.getElement(type).new(id, basalt)
    local ok, result = pcall(require, "main")
    if not ok then
        errorManager(false, result)
    end
    return element
end

function basalt.createFrame()
    local frame = basalt.create("BaseFrame")
    mainFrame = frame
    return frame
end

function basalt.getElementManager()
    return elementManager
end

function basalt.getMainFrame()
    if(mainFrame == nil)then
        mainFrame = basalt.createFrame()
    end
    return mainFrame
end

function basalt.setActiveFrame(frame)
    mainFrame = frame
    return false
end

function basalt.scheduleUpdate(func)
    table.insert(basalt._schedule, func)
    return #basalt._schedule
end

function basalt.removeSchedule(id)
    basalt._schedule[id] = nil
end

local function updateEvent(event, ...)
    if(event=="terminate")then basalt.stop() end

    if event:find("mouse") then
        if mainFrame then
            mainFrame:handleEvent(event, ...)
        end
    end

    if event:find("key") then
        if mainFrame then
            mainFrame:handleEvent(event, ...)
        end
    end

    if basalt._events[event] then
        for _, callback in ipairs(basalt._events[event]) do
            callback(...)
        end
    end
end

local function renderFrames()
    if(mainFrame)then
        mainFrame:render()
    end
end

function basalt.update()
    for k,v in pairs(basalt._schedule) do
        if type(v)=="function" then
            v()
        end
    end
end

function basalt.stop()
    term.clear()
    term.setCursorPos(1,1)
    updaterActive = false
end

function basalt.run(isActive)
    updaterActive = isActive
    if(isActive==nil)then updaterActive = true end
    local function f()
        renderFrames()
        while updaterActive do
            updateEvent(os.pullEventRaw())
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
basalt.autoUpdate = basalt.run

return basaltlocal deepCopy = require("libraries/utils").deepCopy
local expect = require("libraries/expect")

local PropertySystem = {}
PropertySystem.__index = PropertySystem

PropertySystem._properties = {}

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

    class["get" .. capitalizedName] = function(self)
        expect(1, self, "element")
        local value = self._values[name]
        return config.getter and config.getter(value) or value
    end

    class["set" .. capitalizedName] = function(self, value)
        expect(1, self, "element")
        expect(2, value, config.type)
        if config.setter then
            value = config.setter(self, value)
        end

        self:_updateProperty(name, value)
        return self
    end
end

function PropertySystem:__init()
    self._values = {}
    self._observers = {}

    self.set = function(name, value)
        local oldValue = self._values[name]
        self._values[name] = value
        if(self._properties[name].setter) then
            value = self._properties[name].setter(self, value)
        end
        if oldValue ~= value and self._observers[name] then
            for _, callback in ipairs(self._observers[name]) do
                callback(self, value, oldValue)
            end
        end
    end

    self.get = function(name)
        return self._values[name]
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
            if self._properties[k] then
                return self._values[k]
            end
            if type(originalIndex) == "function" then
                return originalIndex(t, k)
            else
                return originalIndex[k]
            end
        end,
        __newindex = function(t, k, v)
            if self._properties[k] then
                if self._properties[k].setter then
                    v = self._properties[k].setter(self, v)
                end
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
    if oldValue ~= value then
        self._values[name] = value
        if self._properties[name].canTriggerRender then
            self:updateRender()
        end
        if self._observers[name] then
            for _, callback in ipairs(self._observers[name]) do
                callback(self, value, oldValue)
            end
        end
    end
end

function PropertySystem:observe(name, callback)
    self._observers[name] = self._observers[name] or {}
    table.insert(self._observers[name], callback)
    return self
end

return PropertySystem
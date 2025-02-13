local VisualElement = require("elements/VisualElement")

---@class Input : VisualElement
local Input = setmetatable({}, VisualElement)
Input.__index = Input

---@property text string Input - text to be displayed
Input.defineProperty(Input, "text", {default = "", type = "string", canTriggerRender = true})

---@property cursorPos number Input - current cursor position
Input.defineProperty(Input, "cursorPos", {default = 1, type = "number"})

---@property viewOffset number Input - offset für Text-Viewport
Input.defineProperty(Input, "viewOffset", {default = 0, type = "number"})

Input.listenTo(Input, "mouse_click")
Input.listenTo(Input, "key")
Input.listenTo(Input, "char")

--- Creates a new Input instance
--- @param id string The unique identifier for this element
--- @param basalt table The basalt instance
--- @return Input object The newly created Input instance
--- @usage local element = Input.new("myId", basalt)
function Input.new(id, basalt)
    local self = setmetatable({}, Input):__init()
    self:init(id, basalt)
    self.set("width", 8)
    self.set("z", 3)
    return self
end

function Input:init(id, basalt)
    VisualElement.init(self, id, basalt)
    self.set("type", "Input")
end

function Input:char(char)
    if not self.get("focused") then return end
    local text = self.get("text")
    local pos = self.get("cursorPos")
    self.set("text", text:sub(1, pos-1) .. char .. text:sub(pos))
    self.set("cursorPos", pos + 1)
    self:updateViewport()
end

function Input:key(key)
    if not self.get("focused") then return end
    local pos = self.get("cursorPos")
    local text = self.get("text")

    if key == keys.left and pos > 1 then
        self.set("cursorPos", pos - 1)
        self:setCursor(pos - 1,1, true)
    elseif key == keys.right and pos <= #text then
        self.set("cursorPos", pos + 1)
        self:setCursor(pos + 1,1, true)
    elseif key == keys.backspace and pos > 1 then
        self.set("text", text:sub(1, pos-2) .. text:sub(pos))
        self.set("cursorPos", pos - 1)
        self:setCursor(pos - 1,1, true)
    end
    self:updateViewport()
end

function Input:focus()
    VisualElement.focus(self)
    self.set("background", colors.blue)
    self:setCursor(1,1, true)
end

function Input:blur()
    VisualElement.blur(self)
    self.set("background", colors.green)
end

function Input:updateViewport()
    local width = self.get("width")
    local text = self.get("text")
    local cursorPos = self.get("cursorPos")
    local viewOffset = self.get("viewOffset")
    
    -- Wenn Cursor außerhalb des sichtbaren Bereichs nach rechts
    if cursorPos - viewOffset > width then
        self.set("viewOffset", cursorPos - width)
    end
    
    -- Wenn Cursor außerhalb des sichtbaren Bereichs nach links
    if cursorPos <= viewOffset then
        self.set("viewOffset", cursorPos - 1)
    end
end

function Input:render()
    VisualElement.render(self)
    local text = self.get("text")
    local viewOffset = self.get("viewOffset")
    local width = self.get("width")
    
    -- Nur den sichtbaren Teil des Textes rendern
    local visibleText = text:sub(viewOffset + 1, viewOffset + width)
    self:textFg(1, 1, visibleText, self.get("foreground"))
    
    if self.get("focused") then
        local cursorPos = self.get("cursorPos")
        -- Cursor relativ zum Viewport positionieren
        self:setCursor(cursorPos - viewOffset, 1, true)
    end
end

return Input
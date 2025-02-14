local VisualElement = require("elements/VisualElement")
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
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Input object The newly created Input instance
--- @usage local element = Input.new("myId", basalt)
function Input.new(props, basalt)
    local self = setmetatable({}, Input):__init()
    self:init(id, basalt)
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

return Input
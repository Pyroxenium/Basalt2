local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")
---@configDescription A text input field with various features

--- This is the input class. It provides a text input field that can handle user input with various features like
--- cursor movement, text manipulation, placeholder text, and input validation.
---@class Input : VisualElement
local Input = setmetatable({}, VisualElement)
Input.__index = Input

---@property text string - The current text content of the input
Input.defineProperty(Input, "text", {default = "", type = "string", canTriggerRender = true})
---@property cursorPos number 1 The current cursor position in the text
Input.defineProperty(Input, "cursorPos", {default = 1, type = "number"})
---@property viewOffset number 0 The horizontal scroll offset for viewing long text
Input.defineProperty(Input, "viewOffset", {default = 0, type = "number", canTriggerRender = true})
---@property maxLength number? nil Maximum length of input text (optional)
Input.defineProperty(Input, "maxLength", {default = nil, type = "number"})
---@property placeholder string ... Text to display when input is empty
Input.defineProperty(Input, "placeholder", {default = "...", type = "string"})
---@property placeholderColor color gray Color of the placeholder text
Input.defineProperty(Input, "placeholderColor", {default = colors.gray, type = "number"})
---@property focusedColor color blue Background color when input is focused
Input.defineProperty(Input, "focusedColor", {default = colors.blue, type = "number"})
---@property pattern string? nil Regular expression pattern for input validation
Input.defineProperty(Input, "pattern", {default = nil, type = "string"})
---@property cursorColor number nil Color of the cursor
Input.defineProperty(Input, "cursorColor", {default = nil, type = "number"})

Input.defineEvent(Input, "mouse_click")
Input.defineEvent(Input, "key")
Input.defineEvent(Input, "char")

--- Creates a new Input instance
--- @shortDescription Creates a new Input instance
--- @return Input object The newly created Input instance
--- @usage local element = Input.new("myId", basalt)
function Input.new()
    local self = setmetatable({}, Input):__init()
    self.set("width", 8)
    self.set("z", 3)
    return self
end

--- Initializes the Input instance
--- @shortDescription Initializes the Input instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Input self The initialized instance
function Input:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Input")
    return self
end

--- Handles char events
--- @shortDescription Handles char events
--- @param char string The character that was typed
--- @return boolean handled Whether the event was handled
function Input:char(char)
    if not self.get("focused") then return false end
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
    return true
end

--- Handles key events
--- @shortDescription Handles key events
--- @param key number The key that was pressed
--- @return boolean handled Whether the event was handled
function Input:key(key)
    if not self.get("focused") then return false end
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
    self:setCursor(relativePos, 1, true, self.get("cursorColor") or self.get("foreground"))
    return true
end

--- Handles focus events
--- @shortDescription Handles focus events
function Input:focus()
    VisualElement.focus(self)
    self:updateRender()
end

--- Handles blur events
--- @shortDescription Handles blur events
function Input:blur()
    VisualElement.blur(self)
    self:updateRender()
end

--- Handles mouse click events
--- @shortDescription Handles mouse click events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
function Input:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        local relX, relY = self:getRelativePosition(x, y)
        local text = self.get("text")
        self:setCursor(math.min(relX, #text + 1), relY, true, self.get("cursorColor") or self.get("foreground"))
        self:set("cursorPos", relX + self.get("viewOffset"))
        return true
    end
end

--- Updates the input's viewport
--- @shortDescription Updates the input's viewport
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

--- Renders the input element
--- @shortDescription Renders the input element
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
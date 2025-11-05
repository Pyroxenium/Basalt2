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
Input.defineProperty(Input, "placeholderColor", {default = colors.gray, type = "color"})
---@property pattern string? nil Regular expression pattern for input validation
Input.defineProperty(Input, "pattern", {default = nil, type = "string"})
---@property cursorColor number nil Color of the cursor
Input.defineProperty(Input, "cursorColor", {default = nil, type = "number"})
---@property replaceChar string nil Character to replace the input with (for password fields)
Input.defineProperty(Input, "replaceChar", {default = nil, type = "string", canTriggerRender = true})

Input.defineEvent(Input, "mouse_click")
Input.defineEvent(Input, "mouse_up")
Input.defineEvent(Input, "key")
Input.defineEvent(Input, "char")
Input.defineEvent(Input, "paste")

--- @shortDescription Creates a new Input instance
--- @return Input object The newly created Input instance
--- @private
function Input.new()
    local self = setmetatable({}, Input):__init()
    self.class = Input
    self.set("width", 8)
    self.set("z", 3)
    return self
end

--- @shortDescription Initializes the Input instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Input self The initialized instance
--- @protected
function Input:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Input")
    return self
end

--- Sets the cursor position and color
--- @shortDescription Sets the cursor position and color
--- @param x number The x position of the cursor
--- @param y number The y position of the cursor
--- @param blink boolean Whether the cursor should blink
--- @param color number The color of the cursor
function Input:setCursor(x, y, blink, color)
    x = math.min(self.getResolved("width"), math.max(1, x))
    return VisualElement.setCursor(self, x, y, blink, color)
end

--- @shortDescription Handles char events
--- @param char string The character that was typed
--- @return boolean handled Whether the event was handled
--- @protected
function Input:char(char)
    if not self:hasState("focused") then return false end
    local text = self.getResolved("text")
    local pos = self.getResolved("cursorPos")
    local maxLength = self.getResolved("maxLength")
    local pattern = self.getResolved("pattern")

    if maxLength and #text >= maxLength then return false end
    if pattern and not char:match(pattern) then return false end

    self.set("text", text:sub(1, pos-1) .. char .. text:sub(pos))
    self.set("cursorPos", pos + 1)
    self:updateViewport()

    local relPos = self.getResolved("cursorPos") - self.getResolved("viewOffset")
    self:setCursor(relPos, 1, true, self.getResolved("cursorColor") or self.getResolved("foreground"))
    VisualElement.char(self, char)
    return true
end

--- @shortDescription Handles key events
--- @param key number The key that was pressed
--- @return boolean handled Whether the event was handled
--- @protected
function Input:key(key, held)
    if not self:hasState("focused") then return false end
    local pos = self.getResolved("cursorPos")
    local text = self.getResolved("text")
    local viewOffset = self.getResolved("viewOffset")
    local width = self.getResolved("width")

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

    local relativePos = self.getResolved("cursorPos") - self.getResolved("viewOffset")
    self:setCursor(relativePos, 1, true, self.getResolved("cursorColor") or self.getResolved("foreground"))
    VisualElement.key(self, key, held)
    return true
end

--- @shortDescription Handles mouse click events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function Input:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        local relX, relY = self:getRelativePosition(x, y)
        local text = self.getResolved("text")
        local viewOffset = self.getResolved("viewOffset")

        local maxPos = #text + 1
        local targetPos = math.min(maxPos, viewOffset + relX)

        self.set("cursorPos", targetPos)
        local visualX = targetPos - viewOffset
        self:setCursor(visualX, 1, true, self.getResolved("cursorColor") or self.getResolved("foreground"))

        return true
    end
    return false
end

--- Updates the input's viewport
--- @shortDescription Updates the input's viewport
--- @return Input self The updated instance
function Input:updateViewport()
    local width = self.getResolved("width")
    local cursorPos = self.getResolved("cursorPos")
    local viewOffset = self.getResolved("viewOffset")
    local textLength = #self.getResolved("text")

    if cursorPos - viewOffset >= width then
        self.set("viewOffset", cursorPos - width + 1)
    elseif cursorPos <= viewOffset then
        self.set("viewOffset", cursorPos - 1)
    end

    self.set("viewOffset", math.max(0, math.min(self.getResolved("viewOffset"), textLength - width + 1)))

    return self
end

--- @shortDescription Handles a focus event
--- @protected
function Input:focus()
    VisualElement.focus(self)
    self:setCursor(self.getResolved("cursorPos") - self.getResolved("viewOffset"), 1, true, self.getResolved("cursorColor") or self.getResolved("foreground"))
    self:updateRender()
end

--- @shortDescription Handles a blur event
--- @protected
function Input:blur()
    VisualElement.blur(self)
    self:setCursor(1, 1, false, self.getResolved("cursorColor") or self.getResolved("foreground"))
    self:updateRender()
end

--- @shortDescription Handles paste events
--- @protected
function Input:paste(content)
    if not self:hasState("focused") then return false end
    local text = self.getResolved("text")
    local pos = self.getResolved("cursorPos")
    local maxLength = self.getResolved("maxLength")
    local pattern = self.getResolved("pattern")
    local newText = text:sub(1, pos - 1) .. content .. text:sub(pos)
    if maxLength and #newText > maxLength then
        newText = newText:sub(1, maxLength)
    end
    if pattern and not newText:match(pattern) then
        return false
    end
    self.set("text", newText)
    self.set("cursorPos", pos + #content)
    self:updateViewport()
end

--- @shortDescription Renders the input element
--- @protected
function Input:render()
    local text = self.getResolved("text")
    local viewOffset = self.getResolved("viewOffset")
    local placeholder = self.getResolved("placeholder")
    local focused = self:hasState("focused")
    local width, height = self.getResolved("width"), self.getResolved("height")
    local replaceChar = self.getResolved("replaceChar")
    self:multiBlit(1, 1, width, height, " ", tHex[self.getResolved("foreground")], tHex[self.getResolved("background")])

    if #text == 0 and #placeholder ~= 0 and not focused then
        self:textFg(1, 1, placeholder:sub(1, width), self.getResolved("placeholderColor"))
        return
    end

    if(focused) then
        self:setCursor(self.getResolved("cursorPos") - viewOffset, 1, true, self.getResolved("cursorColor") or self.getResolved("foreground"))
    end

    local visibleText = text:sub(viewOffset + 1, viewOffset + width)
    if replaceChar and #replaceChar > 0 then
        visibleText = replaceChar:rep(#visibleText)
    end
    self:textFg(1, 1, visibleText, self.getResolved("foreground"))
end

return Input
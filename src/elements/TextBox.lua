local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")
---@configDescription A multi-line text editor component with cursor support and text manipulation features
---@configDefault false

---A multi-line text editor component with cursor support and text manipulation features
---@class TextBox : VisualElement
local TextBox = setmetatable({}, VisualElement)
TextBox.__index = TextBox

---@property lines table {} Array of text lines
TextBox.defineProperty(TextBox, "lines", {default = {""}, type = "table", canTriggerRender = true})
---@property cursorX number 1 Cursor X position
TextBox.defineProperty(TextBox, "cursorX", {default = 1, type = "number"})
---@property cursorY number 1 Cursor Y position (line number)
TextBox.defineProperty(TextBox, "cursorY", {default = 1, type = "number"})
---@property scrollX number 0 Horizontal scroll offset
TextBox.defineProperty(TextBox, "scrollX", {default = 0, type = "number", canTriggerRender = true})
---@property scrollY number 0 Vertical scroll offset
TextBox.defineProperty(TextBox, "scrollY", {default = 0, type = "number", canTriggerRender = true})
---@property editable boolean true Whether text can be edited
TextBox.defineProperty(TextBox, "editable", {default = true, type = "boolean"})
---@property syntaxPatterns table {} Syntax highlighting patterns
TextBox.defineProperty(TextBox, "syntaxPatterns", {default = {}, type = "table"})
---@property cursorColor number nil Color of the cursor
TextBox.defineProperty(TextBox, "cursorColor", {default = nil, type = "color"})

TextBox.defineEvent(TextBox, "mouse_click")
TextBox.defineEvent(TextBox, "key")
TextBox.defineEvent(TextBox, "char")
TextBox.defineEvent(TextBox, "mouse_scroll")
TextBox.defineEvent(TextBox, "paste")

--- Creates a new TextBox instance
--- @shortDescription Creates a new TextBox instance
--- @return TextBox self The newly created TextBox instance
--- @private
function TextBox.new()
    local self = setmetatable({}, TextBox):__init()
    self.class = TextBox
    self.set("width", 20)
    self.set("height", 10)
    return self
end

--- @shortDescription Initializes the TextBox instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return TextBox self The initialized instance
--- @protected
function TextBox:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "TextBox")
    return self
end

--- Adds a new syntax highlighting pattern
--- @shortDescription Adds a new syntax highlighting pattern
--- @param pattern string The regex pattern to match
--- @param color colors The color to apply
--- @return TextBox self The TextBox instance
function TextBox:addSyntaxPattern(pattern, color)
    table.insert(self.get("syntaxPatterns"), {pattern = pattern, color = color})
    return self
end

local function insertChar(self, char)
    local lines = self.get("lines")
    local cursorX = self.get("cursorX")
    local cursorY = self.get("cursorY")
    local currentLine = lines[cursorY]
    lines[cursorY] = currentLine:sub(1, cursorX-1) .. char .. currentLine:sub(cursorX)
    self.set("cursorX", cursorX + 1)
    self:updateViewport()
    self:updateRender()
end

local function newLine(self)
    local lines = self.get("lines")
    local cursorX = self.get("cursorX")
    local cursorY = self.get("cursorY")
    local currentLine = lines[cursorY]

    local restOfLine = currentLine:sub(cursorX)
    lines[cursorY] = currentLine:sub(1, cursorX-1)
    table.insert(lines, cursorY + 1, restOfLine)

    self.set("cursorX", 1)
    self.set("cursorY", cursorY + 1)
    self:updateViewport()
    self:updateRender()
end

local function backspace(self)
    local lines = self.get("lines")
    local cursorX = self.get("cursorX")
    local cursorY = self.get("cursorY")
    local currentLine = lines[cursorY]

    if cursorX > 1 then
        lines[cursorY] = currentLine:sub(1, cursorX-2) .. currentLine:sub(cursorX)
        self.set("cursorX", cursorX - 1)
    elseif cursorY > 1 then
        local previousLine = lines[cursorY-1]
        self.set("cursorX", #previousLine + 1)
        self.set("cursorY", cursorY - 1)
        lines[cursorY-1] = previousLine .. currentLine
        table.remove(lines, cursorY)
    end
    self:updateViewport()
    self:updateRender()
end

--- Updates the viewport to keep the cursor in view
--- @shortDescription Updates the viewport to keep the cursor in view
--- @return TextBox self The TextBox instance
function TextBox:updateViewport()
    local cursorX = self.get("cursorX")
    local cursorY = self.get("cursorY")
    local scrollX = self.get("scrollX")
    local scrollY = self.get("scrollY")
    local width = self.get("width")
    local height = self.get("height")

    -- Horizontal scrolling
    if cursorX - scrollX > width then
        self.set("scrollX", cursorX - width)
    elseif cursorX - scrollX < 1 then
        self.set("scrollX", cursorX - 1)
    end

    -- Vertical scrolling
    if cursorY - scrollY > height then
        self.set("scrollY", cursorY - height)
    elseif cursorY - scrollY < 1 then
        self.set("scrollY", cursorY - 1)
    end
    return self
end

--- @shortDescription Handles character input
--- @param char string The character that was typed
--- @return boolean handled Whether the event was handled
--- @protected
function TextBox:char(char)
    if not self.get("editable") or not self.get("focused") then return false end
    insertChar(self, char)
    return true
end

--- @shortDescription Handles key events
--- @param key number The key that was pressed
--- @return boolean handled Whether the event was handled
--- @protected
function TextBox:key(key)
    if not self.get("editable") or not self.get("focused") then return false end
    local lines = self.get("lines")
    local cursorX = self.get("cursorX")
    local cursorY = self.get("cursorY")

    if key == keys.enter then
        newLine(self)
    elseif key == keys.backspace then
        backspace(self)
    elseif key == keys.left then
        if cursorX > 1 then
            self.set("cursorX", cursorX - 1)
        elseif cursorY > 1 then
            self.set("cursorY", cursorY - 1)
            self.set("cursorX", #lines[cursorY-1] + 1)
        end
    elseif key == keys.right then
        if cursorX <= #lines[cursorY] then
            self.set("cursorX", cursorX + 1)
        elseif cursorY < #lines then
            self.set("cursorY", cursorY + 1)
            self.set("cursorX", 1)
        end
    elseif key == keys.up and cursorY > 1 then
        self.set("cursorY", cursorY - 1)
        self.set("cursorX", math.min(cursorX, #lines[cursorY-1] + 1))
    elseif key == keys.down and cursorY < #lines then
        self.set("cursorY", cursorY + 1)
        self.set("cursorX", math.min(cursorX, #lines[cursorY+1] + 1))
    end
    self:updateRender()
    self:updateViewport()
    return true
end

--- @shortDescription Handles mouse scroll events
--- @param direction number The scroll direction
--- @param x number The x position of the scroll
--- @param y number The y position of the scroll
--- @return boolean handled Whether the event was handled
--- @protected
function TextBox:mouse_scroll(direction, x, y)
    if self:isInBounds(x, y) then
        local scrollY = self.get("scrollY")
        local height = self.get("height")
        local lines = self.get("lines")

        local maxScroll = math.max(0, #lines - height + 2)

        local newScroll = math.max(0, math.min(maxScroll, scrollY + direction))

        self.set("scrollY", newScroll)
        self:updateRender()
        return true
    end
    return false
end

--- @shortDescription Handles mouse click events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function TextBox:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        local relX, relY = self:getRelativePosition(x, y)
        local scrollX = self.get("scrollX")
        local scrollY = self.get("scrollY")

        local targetY = relY + scrollY
        local lines = self.get("lines")

        if targetY <= #lines then
            self.set("cursorY", targetY)
            self.set("cursorX", math.min(relX + scrollX, #lines[targetY] + 1))
        end
        self:updateRender()
        return true
    end
    return false
end

--- @shortDescription Handles paste events
--- @protected
function TextBox:paste(text)
    if not self.get("editable") or not self.get("focused") then return false end

    for char in text:gmatch(".") do
        if char == "\n" then
            newLine(self)
        else
            insertChar(self, char)
        end
    end

    return true
end

--- Sets the text of the TextBox
--- @shortDescription Sets the text of the TextBox
--- @param text string The text to set
--- @return TextBox self The TextBox instance
function TextBox:setText(text)
    local lines = {}
    if text == "" then
        lines = {""}
    else
        for line in (text.."\n"):gmatch("([^\n]*)\n") do
            table.insert(lines, line)
        end
    end
    self.set("lines", lines)
    return self
end

--- Gets the text of the TextBox
--- @shortDescription Gets the text of the TextBox
--- @return string text The text of the TextBox
function TextBox:getText()
    return table.concat(self.get("lines"), "\n")
end

local function applySyntaxHighlighting(self, line)
    local text = line
    local colors = string.rep(tHex[self.get("foreground")], #text)
    local patterns = self.get("syntaxPatterns")

    for _, syntax in ipairs(patterns) do
        local start = 1
        while true do
            local s, e = text:find(syntax.pattern, start)
            if not s then break end
            colors = colors:sub(1, s-1) .. string.rep(tHex[syntax.color], e-s+1) .. colors:sub(e+1)
            start = e + 1
        end
    end

    return text, colors
end

--- @shortDescription Renders the TextBox with syntax highlighting
--- @protected
function TextBox:render()
    VisualElement.render(self)

    local lines = self.get("lines")
    local scrollX = self.get("scrollX")
    local scrollY = self.get("scrollY")
    local width = self.get("width")
    local height = self.get("height")
    local fg = tHex[self.get("foreground")]
    local bg = tHex[self.get("background")]

    for y = 1, height do
        local lineNum = y + scrollY
        local line = lines[lineNum] or ""
        local visibleText = line:sub(scrollX + 1, scrollX + width)
        if #visibleText < width then
            visibleText = visibleText .. string.rep(" ", width - #visibleText)
        end

        local text, colors = applySyntaxHighlighting(self, visibleText)
        self:blit(1, y, text, colors, string.rep(bg, #visibleText))
    end

    if self.get("focused") then
        local relativeX = self.get("cursorX") - scrollX
        local relativeY = self.get("cursorY") - scrollY
        if relativeX >= 1 and relativeX <= width and relativeY >= 1 and relativeY <= height then
            self:setCursor(relativeX, relativeY, true, self.get("cursorColor") or self.get("foreground"))
        end
    end
end

return TextBox
local colorChars = require("libraries/colorHex")
local log = require("log")

--- This is the render module for Basalt. It tries to mimic the functionality of the `term` API. but with additional 
--- functionality. It also has a buffer system to reduce the number of calls
--- @class Render
--- @field terminal table The terminal object to render to
--- @field width number The width of the render
--- @field height number The height of the render
--- @field buffer table The buffer to render
--- @field xCursor number The x position of the cursor
--- @field yCursor number The y position of the cursor
--- @field blink boolean Whether the cursor should blink
local Render = {}
Render.__index = Render

local sub = string.sub

--- Creates a new Render object
--- @param terminal table The terminal object to render to
--- @return Render
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

--- Adds a dirty rectangle to the buffer
--- @param x number The x position of the rectangle
--- @param y number The y position of the rectangle
--- @param width number The width of the rectangle
--- @param height number The height of the rectangle
--- @return Render
function Render:addDirtyRect(x, y, width, height)
    table.insert(self.buffer.dirtyRects, {
        x = x,
        y = y,
        width = width,
        height = height
    })
    return self
end

--- Blits text to the screen
--- @param x number The x position to blit to
--- @param y number The y position to blit to
--- @param text string The text to blit
--- @param fg string The foreground color of the text
--- @param bg string The background color of the text
--- @return Render
function Render:blit(x, y, text, fg, bg)
    if y < 1 or y > self.height then return self end
    if(#text ~= #fg or #text ~= #bg)then
        error("Text, fg, and bg must be the same length")
    end

    self.buffer.text[y] = sub(self.buffer.text[y]:sub(1,x-1) .. text .. self.buffer.text[y]:sub(x+#text), 1, self.width)
    self.buffer.fg[y] = sub(self.buffer.fg[y]:sub(1,x-1) .. fg .. self.buffer.fg[y]:sub(x+#fg), 1, self.width)
    self.buffer.bg[y] = sub(self.buffer.bg[y]:sub(1,x-1) .. bg .. self.buffer.bg[y]:sub(x+#bg), 1, self.width)
    self:addDirtyRect(x, y, #text, 1)

    return self
end

--- Blits text to the screen with multiple lines
--- @param x number The x position to blit to
--- @param y number The y position to blit to
--- @param width number The width of the text
--- @param height number The height of the text
--- @param text string The text to blit
--- @param fg colors The foreground color of the text
--- @param bg colors The background color of the text
--- @return Render
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
            self.buffer.text[cy] = sub(self.buffer.text[cy]:sub(1,x-1) .. text .. self.buffer.text[cy]:sub(x+#text), 1, self.width)
            self.buffer.fg[cy] = sub(self.buffer.fg[cy]:sub(1,x-1) .. fg .. self.buffer.fg[cy]:sub(x+#fg), 1, self.width)
            self.buffer.bg[cy] = sub(self.buffer.bg[cy]:sub(1,x-1) .. bg .. self.buffer.bg[cy]:sub(x+#bg), 1, self.width)
        end
    end

    self:addDirtyRect(x, y, width, height)
    return self
end

--- Blits text to the screen with a foreground color
--- @param x number The x position to blit to
--- @param y number The y position to blit to
--- @param text string The text to blit
--- @param fg colors The foreground color of the text
--- @return Render
function Render:textFg(x, y, text, fg)
    if y < 1 or y > self.height then return self end
    fg = colorChars[fg] or "0"
    fg = fg:rep(#text)
    self.buffer.text[y] = sub(self.buffer.text[y]:sub(1,x-1) .. text .. self.buffer.text[y]:sub(x+#text), 1, self.width)
    self.buffer.fg[y] = sub(self.buffer.fg[y]:sub(1,x-1) .. fg .. self.buffer.fg[y]:sub(x+#fg), 1, self.width)
    self:addDirtyRect(x, y, #text, 1)

    return self
end

--- Blits text to the screen with a background color
--- @param x number The x position to blit to
--- @param y number The y position to blit to
--- @param text string The text to blit
--- @param bg colors The background color of the text
--- @return Render
function Render:textBg(x, y, text, bg)
    if y < 1 or y > self.height then return self end
    bg = colorChars[bg] or "f"

    self.buffer.text[y] = sub(self.buffer.text[y]:sub(1,x-1) .. text .. self.buffer.text[y]:sub(x+#text), 1, self.width)
    self.buffer.bg[y] = sub(self.buffer.bg[y]:sub(1,x-1) .. bg:rep(#text) .. self.buffer.bg[y]:sub(x+#text), 1, self.width)
    self:addDirtyRect(x, y, #text, 1)

    return self
end

--- Renders the text to the screen
--- @param x number The x position to blit to
--- @param y number The y position to blit to
--- @param text string The text to blit
--- @return Render
function Render:text(x, y, text)
    if y < 1 or y > self.height then return self end

    self.buffer.text[y] = sub(self.buffer.text[y]:sub(1,x-1) .. text .. self.buffer.text[y]:sub(x+#text), 1, self.width)
    self:addDirtyRect(x, y, #text, 1)

    return self
end

--- Blits a foreground color to the screen
--- @param x number The x position
--- @param y number The y position
--- @param fg string The foreground color to blit
--- @return Render
function Render:fg(x, y, fg)
    if y < 1 or y > self.height then return self end

    self.buffer.fg[y] = sub(self.buffer.fg[y]:sub(1,x-1) .. fg .. self.buffer.fg[y]:sub(x+#fg), 1, self.width)
    self:addDirtyRect(x, y, #fg, 1)

    return self
end

--- Blits a background color to the screen
--- @param x number The x position
--- @param y number The y position
--- @param bg string The background color to blit
--- @return Render
function Render:bg(x, y, bg)
    if y < 1 or y > self.height then return self end

    self.buffer.bg[y] = sub(self.buffer.bg[y]:sub(1,x-1) .. bg .. self.buffer.bg[y]:sub(x+#bg), 1, self.width)
    self:addDirtyRect(x, y, #bg, 1)

    return self
end

--- Blits text to the screen
--- @param x number The x position to blit to
--- @param y number The y position to blit to
--- @param text string The text to blit
--- @return Render
function Render:text(x, y, text)
    if y < 1 or y > self.height then return self end

    self.buffer.text[y] = sub(self.buffer.text[y]:sub(1,x-1) .. text .. self.buffer.text[y]:sub(x+#text), 1, self.width)
    self:addDirtyRect(x, y, #text, 1)

    return self
end

--- Blits a foreground color to the screen
--- @param x number The x position
--- @param y number The y position
--- @param fg string The foreground color to blit
--- @return Render
function Render:fg(x, y, fg)
    if y < 1 or y > self.height then return self end

    self.buffer.fg[y] = sub(self.buffer.fg[y]:sub(1,x-1) .. fg .. self.buffer.fg[y]:sub(x+#fg), 1, self.width)
    self:addDirtyRect(x, y, #fg, 1)

    return self
end

--- Blits a background color to the screen
--- @param x number The x position
--- @param y number The y position
--- @param bg string The background color to blit
--- @return Render
function Render:bg(x, y, bg)
    if y < 1 or y > self.height then return self end

    self.buffer.bg[y] = sub(self.buffer.bg[y]:sub(1,x-1) .. bg .. self.buffer.bg[y]:sub(x+#bg), 1, self.width)
    self:addDirtyRect(x, y, #bg, 1)

    return self
end

--- Clears the screen
--- @param bg colors The background color to clear the screen with
--- @return Render
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

--- Renders the buffer to the screen
--- @return Render
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
        self.terminal.setTextColor(self.cursorColor or colors.white)
        self.terminal.setCursorPos(self.xCursor, self.yCursor)
        self.terminal.setCursorBlink(true)
    else
        self.terminal.setCursorBlink(false)
    end

    return self
end

--- Checks if two rectangles overlap
--- @param r1 table The first rectangle
--- @param r2 table The second rectangle
--- @return boolean
function Render:rectOverlaps(r1, r2)
    return not (r1.x + r1.width <= r2.x or
               r2.x + r2.width <= r1.x or
               r1.y + r1.height <= r2.y or
               r2.y + r2.height <= r1.y)
end

--- Merges two rectangles
--- @param target table The target rectangle
--- @param source table The source rectangle
--- @return Render
function Render:mergeRects(target, source)
    local x1 = math.min(target.x, source.x)
    local y1 = math.min(target.y, source.y)
    local x2 = math.max(target.x + target.width, source.x + source.width)
    local y2 = math.max(target.y + target.height, source.y + source.height)
    
    target.x = x1
    target.y = y1
    target.width = x2 - x1
    target.height = y2 - y1
    return self
end

--- Sets the cursor position
--- @param x number The x position of the cursor
--- @param y number The y position of the cursor
--- @param blink boolean Whether the cursor should blink
--- @return Render
function Render:setCursor(x, y, blink, color)
    if color ~= nil then self.terminal.setTextColor(color) end
    self.terminal.setCursorPos(x, y)
    self.terminal.setCursorBlink(blink)
    self.xCursor = x
    self.yCursor = y
    self.blink = blink
    self.cursorColor = color
    return self
end

--- Clears an area of the screen
--- @param x number The x position of the area
--- @param y number The y position of the area
--- @param width number The width of the area
--- @param height number The height of the area
--- @param bg colors The background color to clear the area with
--- @return Render
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

--- Gets the size of the render
--- @return number, number
function Render:getSize()
    return self.width, self.height
end

--- Sets the size of the render
--- @param width number The width of the render
--- @param height number The height of the render
--- @return Render
function Render:setSize(width, height)
    self.width = width
    self.height = height
    for y=1, self.height do
        self.buffer.text[y] = string.rep(" ", self.width)
        self.buffer.fg[y] = string.rep("0", self.width)
        self.buffer.bg[y] = string.rep("f", self.width)
    end
    return self
end

return Render
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

return Render
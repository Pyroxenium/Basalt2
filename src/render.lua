local Render = {}
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
    local benchmark = require("benchmark")
    benchmark.start("render")

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

    -- Nur die Dirty Rectangles rendern
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

    benchmark.update("render")
    self.buffer.dirtyRects = {}

    if self.blink then
        self.terminal.setCursorPos(self.xCursor, self.yCursor)
        self.terminal.setCursorBlink(true)
    else
        self.terminal.setCursorBlink(false)
    end

    --benchmark.stop("render")
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

return Render
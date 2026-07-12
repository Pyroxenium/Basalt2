-- Render buffer for Basalt3.
--
-- Holds the screen as three string arrays (text / fg / bg). Colors are stored
-- as raw bytes (registry indices from core/palette), which is what allows
-- more than 16 colors in the buffer. On flush, only lines that actually
-- differ from what the terminal currently shows are blitted, and color bytes
-- are translated to blit hex chars through the palette mapper.
--
-- Also provides a translation + clipping stack so containers can render
-- children in local coordinates.

local require = ...
local palette = require("core/palette")

local rep, sub = string.rep, string.sub
local charOf = palette.charOf

local Render = {}
Render.__index = Render

function Render.new(t)
    local self = setmetatable({}, Render)
    self.term = t
    self.mapper = palette.newMapper(t)
    self:resize(t.getSize())
    return self
end

function Render:resize(w, h)
    self.width, self.height = w, h
    self.text, self.fg, self.bg = {}, {}, {}
    self.prevText, self.prevFg, self.prevBg = {}, {}, {}
    local blankT = rep(" ", w)
    local blankF = rep("\0", w)          -- white
    local blankB = rep(string.char(15), w) -- black
    for y = 1, h do
        self.text[y], self.fg[y], self.bg[y] = blankT, blankF, blankB
    end
    self.dirty = true
    self.ox, self.oy = 0, 0
    self.cx1, self.cy1, self.cx2, self.cy2 = 1, 1, w, h
    self.stack, self.stackN = {}, 0
    return self
end

--- Pushes a child region: translates the origin to (x, y) in the current
--- space and intersects the clip rect with the w*h area.
function Render:push(x, y, w, h)
    local n, s = self.stackN, self.stack
    s[n + 1], s[n + 2], s[n + 3] = self.ox, self.oy, self.cx1
    s[n + 4], s[n + 5], s[n + 6] = self.cy1, self.cx2, self.cy2
    self.stackN = n + 6

    local ox, oy = self.ox + x - 1, self.oy + y - 1
    self.ox, self.oy = ox, oy
    if ox + 1 > self.cx1 then self.cx1 = ox + 1 end
    if oy + 1 > self.cy1 then self.cy1 = oy + 1 end
    if ox + w < self.cx2 then self.cx2 = ox + w end
    if oy + h < self.cy2 then self.cy2 = oy + h end
    return self
end

function Render:pop()
    local n, s = self.stackN, self.stack
    self.ox, self.oy, self.cx1 = s[n - 5], s[n - 4], s[n - 3]
    self.cy1, self.cx2, self.cy2 = s[n - 2], s[n - 1], s[n]
    self.stackN = n - 6
    return self
end

local function splice(line, x, str)
    return sub(line, 1, x - 1) .. str .. sub(line, x + #str)
end

--- Core write. fgChar/bgChar are single-byte strings or nil (keep existing).
function Render:write(x, y, str, fgChar, bgChar)
    local ay = y + self.oy
    if ay < self.cy1 or ay > self.cy2 then return self end

    local ax = x + self.ox
    local s, e = ax, ax + #str - 1
    local x1, x2 = self.cx1, self.cx2
    if s < x1 then
        str = sub(str, x1 - s + 1)
        s = x1
    end
    if e > x2 then
        str = sub(str, 1, x2 - s + 1)
        e = x2
    end
    if s > e then return self end

    self.text[ay] = splice(self.text[ay], s, str)
    if fgChar then self.fg[ay] = splice(self.fg[ay], s, rep(fgChar, e - s + 1)) end
    if bgChar then self.bg[ay] = splice(self.bg[ay], s, rep(bgChar, e - s + 1)) end
    self.dirty = true
    return self
end

local function colorChar(color)
    if not color then return nil end
    local c = charOf[color]
    if not c then
        error("Basalt 2.5: unknown color value " .. tostring(color)
            .. " (use colors.* or basalt.rgb)", 3)
    end
    return c
end

--- Writes text with optional fg/bg colors (public color values, nil = keep).
function Render:blit(x, y, str, fg, bg)
    return self:write(x, y, str, colorChar(fg), colorChar(bg))
end

--- Writes plain text, keeping the colors underneath.
--- (named drawText because .text is the buffer's line array)
function Render:drawText(x, y, str)
    return self:write(x, y, str)
end

--- Writes a pre-encoded span: fgStr/bgStr are byte strings (registry
--- indices) with the same length as str, or nil to keep existing colors.
function Render:rawBlit(x, y, str, fgStr, bgStr)
    local ay = y + self.oy
    if ay < self.cy1 or ay > self.cy2 then return self end
    local ax = x + self.ox
    local s, e = ax, ax + #str - 1
    local x1, x2 = self.cx1, self.cx2
    local cutFront = s < x1 and (x1 - s) or 0
    local cutBack = e > x2 and (e - x2) or 0
    if cutFront > 0 or cutBack > 0 then
        s = s + cutFront
        e = e - cutBack
        if s > e then return self end
        str = sub(str, 1 + cutFront, #str - cutBack)
        if fgStr then fgStr = sub(fgStr, 1 + cutFront, #fgStr - cutBack) end
        if bgStr then bgStr = sub(bgStr, 1 + cutFront, #bgStr - cutBack) end
    end
    self.text[ay] = splice(self.text[ay], s, str)
    if fgStr then self.fg[ay] = splice(self.fg[ay], s, fgStr) end
    if bgStr then self.bg[ay] = splice(self.bg[ay], s, bgStr) end
    self.dirty = true
    return self
end

local HEXBYTE = {}
for i = 0, 15 do
    HEXBYTE[("%x"):format(i)] = string.char(i)
    HEXBYTE[("%X"):format(i)] = string.char(i)
end

--- Writes a blit triple with hex color strings ("0"-"f"), e.g. straight
--- from window.getLine() — used to embed foreign terminal content.
function Render:drawBlit(x, y, str, fgHex, bgHex)
    return self:rawBlit(x, y, str,
        fgHex and (fgHex:gsub(".", HEXBYTE)),
        bgHex and (bgHex:gsub(".", HEXBYTE)))
end

--- Fills a w*h area with a character and optional colors.
function Render:fill(x, y, w, h, ch, fg, bg)
    local row = rep(ch, w)
    local f, b = colorChar(fg), colorChar(bg)
    for dy = 0, h - 1 do
        self:write(x, y + dy, row, f, b)
    end
    return self
end

function Render:setCursor(x, y, blink, color)
    self.cursorX, self.cursorY, self.cursorBlink = x, y, blink
    self.cursorColor = color
    self.dirty = true
    return self
end

local function scanLine(line, used)
    for i = 1, #line do
        used[line:byte(i)] = true
    end
end

--- Diffs the buffer against the terminal state and blits changed lines only.
function Render:flush()
    if not self.dirty then return self end
    local t = self.term

    local map, force
    if palette.hasVirtual() then
        local used = {}
        for y = 1, self.height do
            scanLine(self.fg[y], used)
            scanLine(self.bg[y], used)
        end
        map, force = self.mapper:build(used)
    else
        map, force = palette.identityMap, false
    end

    local prevT, prevF, prevB = self.prevText, self.prevFg, self.prevBg
    for y = 1, self.height do
        local tx, f, b = self.text[y], self.fg[y], self.bg[y]
        if force or tx ~= prevT[y] or f ~= prevF[y] or b ~= prevB[y] then
            t.setCursorPos(1, y)
            t.blit(tx, (f:gsub(".", map)), (b:gsub(".", map)))
            prevT[y], prevF[y], prevB[y] = tx, f, b
        end
    end

    if self.cursorBlink then
        -- translate the cursor color through the current palette mapping
        local ch = self.cursorColor and charOf[self.cursorColor]
        local hex = ch and map[ch]
        if hex then t.setTextColor(2 ^ tonumber(hex, 16)) end
        t.setCursorPos(self.cursorX, self.cursorY)
        t.setCursorBlink(true)
    else
        t.setCursorBlink(false)
    end

    self.dirty = false
    return self
end

return Render

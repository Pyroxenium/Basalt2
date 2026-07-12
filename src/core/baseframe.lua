-- BaseFrame: the root of a UI tree, bound to a terminal.
-- Owns the render buffer, keyboard focus and mouse capture state.

local require = ...
local class = require("core/class")
local Container = require("core/container")
local Render = require("core/render")
local state = require("core/state")

local BaseFrame = class.create("BaseFrame", Container)

class.property(BaseFrame, "background", colors.black)

function BaseFrame:setTerm(t)
    rawset(self, "term", t)
    rawset(self, "_render", Render.new(t))
    local w, h = t.getSize()
    self._p.width, self._p.height = w, h
    self:markDirty()
    return self
end

--- Redraws the whole tree into the buffer if anything changed, then flushes
--- the line diff to the terminal.
function BaseFrame:draw()
    if not rawget(self, "_dirty") then return end
    -- Cursor requests belong to one render pass. A focused input that became
    -- hidden or was removed must not leave the old terminal cursor blinking.
    self._render:setCursor(1, 1, false)
    -- A layout hook may activate responsive states while rendering. Allow one
    -- settling pass without swallowing dirty marks created during the pass.
    for _ = 1, 2 do
        rawset(self, "_dirty", false)
        state.clearWatcher(self)
        self:render(self._render)
        if not rawget(self, "_dirty") then break end
    end
    self._render:flush()
end

function BaseFrame:setFocused(el)
    local old = rawget(self, "_focused")
    if old == el then return end
    rawset(self, "_focused", el)
    -- hide the cursor; the newly focused element re-requests it while rendering
    local r = rawget(self, "_render")
    if r then r:setCursor(1, 1, false) end
    if old and old ~= self then old:fire("blur") end
    if el and el ~= self then el:fire("focus") end
    self:markDirty()
end

--- Applies a cursor request from a focused element (absolute coordinates).
function BaseFrame:setCursor(x, y, blink, color)
    local r = rawget(self, "_render")
    if r then r:setCursor(x, y, blink, color) end
    return self
end

function BaseFrame:getFocused()
    return rawget(self, "_focused")
end

function BaseFrame:_updateHovered(x, y)
    local hovered = self:findAt(x, y)
    if hovered == self then hovered = nil end
    local old = rawget(self, "_hovered")
    if old == hovered then return end
    rawset(self, "_hovered", hovered)
    if old then
        old:setState("hover", false)
        old:fire("mouseLeave")
    end
    if hovered then
        hovered:setState("hover", true)
        hovered:fire("mouseEnter")
    end
end

local function isInside(el, ancestor)
    while el do
        if el == ancestor then return true end
        el = rawget(el, "parent")
    end
    return false
end

--- Releases interaction state owned by an element or any of its descendants.
--- keepHover is useful for disabled controls that remain under the pointer.
function BaseFrame:_releaseSubtree(el, keepHover)
    local focused = rawget(self, "_focused")
    if focused and isInside(focused, el) then self:setFocused(nil) end

    local clicked = rawget(self, "_clicked")
    if clicked and isInside(clicked, el) then
        clicked:setState("pressed", false)
        rawset(self, "_clicked", false)
    end

    local hovered = rawget(self, "_hovered")
    if not keepHover and hovered and isInside(hovered, el) then
        hovered:setState("hover", false)
        hovered:fire("mouseLeave")
        rawset(self, "_hovered", nil)
    end
end

--- Entry point for raw CC events, called by the runtime.
function BaseFrame:handleEvent(event, a, b, c)
    if event == "mouse_click" then
        self:_updateHovered(b, c)
        rawset(self, "_clicked", self:handleMouse(event, a, b, c))
    elseif event == "mouse_move" then
        -- CraftOS-PC may provide either (x, y) or an additional leading
        -- monitor/button value as (value, x, y), depending on the source.
        local x, y = a, b
        if c ~= nil then x, y = b, c end
        if type(x) == "number" and type(y) == "number" then
            self:_updateHovered(x, y)
        end
    elseif event == "mouse_up" or event == "mouse_drag" then
        self:_updateHovered(b, c)
        local el = rawget(self, "_clicked")
        if el then
            local ax, ay = el:getAbsolutePosition()
            if event == "mouse_up" then
                el:setState("pressed", false)
                el:fire("clickUp", a, b - ax + 1, c - ay + 1)
                rawset(self, "_clicked", false)
            else
                el:fire("drag", a, b - ax + 1, c - ay + 1)
            end
        end
    elseif event == "mouse_scroll" then
        self:handleMouse(event, a, b, c)
        self:_updateHovered(b, c)
    elseif event == "key" or event == "key_up" or event == "char"
        or event == "paste" then
        local f = rawget(self, "_focused")
        if f and f ~= self then f:handleKey(event, a, b) end
    elseif event == "term_resize" then
        local w, h = self.term.getSize()
        self._p.width, self._p.height = w, h
        self._render:resize(w, h)
        self:markDirty()
    end
end

--- Restores the terminal (palette, colors, cursor).
function BaseFrame:cleanup()
    local r = rawget(self, "_render")
    if r then r.mapper:restore() end
    local t = rawget(self, "term")
    if t then
        t.setBackgroundColor(colors.black)
        t.setTextColor(colors.white)
        t.clear()
        t.setCursorPos(1, 1)
        t.setCursorBlink(false)
    end
end

return BaseFrame

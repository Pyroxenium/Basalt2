-- BaseFrame: the root of a UI tree, bound to a terminal.
-- Owns the render buffer, keyboard focus and mouse capture state.

local require = ...
local class = require("core/class")
local Container = require("core/container")
local Render = require("core/render")
local state = require("core/state")

--- BaseFrame is the root of a UI tree, bound to a terminal-like object.
---@class BaseFrame : Container
---@field public background number Background color (false = transparent)
---@field private term table Terminal or monitor redirect
---@field private _render Render Render buffer
---@field private _focused Element|nil Element that currently owns keyboard focus
---@field private _hovered Element|nil Element that currently owns mouse hover state
---@field private _clicked Element|nil Element that currently owns mouse capture state
---@field private _keysDown table<number, boolean> Keyboard keys currently held down
---@field private _dirty boolean Whether the frame needs to be redrawn
---@field private _p table Properties table (width, height)
local BaseFrame = class.create("BaseFrame", Container)

--- Background color (false = transparent)
class.property(BaseFrame, "background", colors.black)

--- Initializes a new BaseFrame instance.
function BaseFrame:setup()
    Container.setup(self)
    rawset(self, "_keysDown", {})
end

--- Returns whether a keyboard key is currently held down.
---@param keyCode number ComputerCraft key code
---@return boolean down
function BaseFrame:isKeyDown(keyCode)
    return rawget(self, "_keysDown")[keyCode] == true
end

--- Binds the root frame to a terminal-like object and resizes its buffer.
---@param t table Terminal or monitor redirect
---@return self
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

--- Moves keyboard focus to an element, or clears it with nil.
---@param el Element|nil New focused element
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
--- Forwards an absolute cursor request to the render buffer.
---@param x number Absolute x coordinate
---@param y number Absolute y coordinate
---@param blink boolean Cursor blink state
---@param color number|nil Cursor color
---@return self
function BaseFrame:setCursor(x, y, blink, color)
    local r = rawget(self, "_render")
    if r then r:setCursor(x, y, blink, color) end
    return self
end

--- Returns the element that currently owns keyboard focus.
---@return Element|nil element
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
--- Dispatches one raw ComputerCraft event into this frame.
---@param event string Event name
---@param a any First event argument
---@param b any Second event argument
---@param c any Third event argument
function BaseFrame:handleEvent(event, a, b, c)
    if event == "key" then
        rawget(self, "_keysDown")[a] = true
    elseif event == "key_up" then
        rawget(self, "_keysDown")[a] = nil
    end
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

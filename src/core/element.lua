-- Base class for everything visible in Basalt3.

local require = ...
local class = require("core/class")
local state = require("core/state")
local layout = require("core/layout")

local Element = class.create("Element")

class.property(Element, "x", 1)
class.property(Element, "y", 1)
class.property(Element, "z", 0, {
    onChange = function(self)
        local p = rawget(self, "parent")
        if p then p._sortDirty = true end
    end,
})
class.property(Element, "width", 1)
class.property(Element, "height", 1)
class.property(Element, "minWidth", false)
class.property(Element, "maxWidth", false)
class.property(Element, "minHeight", false)
class.property(Element, "maxHeight", false)
class.property(Element, "position", "flow")
class.property(Element, "alignSelf", false)
class.property(Element, "shrink", false)
class.property(Element, "visible", true, {
    onChange = function(self, visible)
        if not visible then
            local root = self:getRoot()
            if root._releaseSubtree then root:_releaseSubtree(self) end
        end
    end,
})
class.property(Element, "background", false)      -- false = transparent
class.property(Element, "foreground", colors.white)
class.property(Element, "name", "", { visual = false })
class.property(Element, "disabled", false, {
    state = "disabled",
    styleable = false,
    onChange = function(self, disabled)
        if disabled then
            local root = self:getRoot()
            if root._releaseSubtree then root:_releaseSubtree(self, true) end
        end
    end,
})

class.combinedProperty(Element, "Position", { "x", "y" })
class.combinedProperty(Element, "Size", { "width", "height" })
class.combinedProperty(Element, "Bounds", { "x", "y", "width", "height" })
class.combinedProperty(Element, "Colors", { "foreground", "background" })
class.combinedProperty(Element, "MinSize", { "minWidth", "minHeight" })
class.combinedProperty(Element, "MaxSize", { "maxWidth", "maxHeight" })

class.event(Element, "click")
class.event(Element, "clickUp")
class.event(Element, "drag")
class.event(Element, "scroll")
class.event(Element, "focus")
class.event(Element, "blur")
class.event(Element, "key")
class.event(Element, "keyUp")
class.event(Element, "char")
class.event(Element, "paste")
class.event(Element, "stateChange")
class.event(Element, "mouseEnter")
class.event(Element, "mouseLeave")
class.event(Element, "layout")

local statePriorities = {
    hover = 10,
    focused = 20,
    checked = 30,
    selected = 30,
    pressed = 40,
    disabled = 100,
}

-- Properties that can change pixels or interaction state without changing
-- an element's measured size or position. Everything else is conservatively
-- treated as layout-affecting so custom elements remain correct by default.
local paintOnlyProperties = {
    disabled = true,
    checked = true,
    selected = true,
    active = true,
    progress = true,
    value = true,
    offset = true,
    horizontalOffset = true,
    replaceChar = true,
    sortable = true,
    sortColumn = true,
    sortDirection = true,
}

local function propertyAffectsLayout(propName)
    if not propName then return true end
    if paintOnlyProperties[propName] then return false end
    local lower = propName:lower()
    if lower:find("color", 1, true)
        or lower:find("background", 1, true)
        or lower:find("foreground", 1, true)
        or lower:find("symbol", 1, true) then
        return false
    end
    return true
end

local function styleAffectsLayout(style)
    if not style then return false end
    for propName in pairs(style) do
        if propertyAffectsLayout(propName) then return true end
    end
    return false
end

local function stateStyleAffectsLayout(self, stateName)
    local localStyle = rawget(self, "_stateStyles")[stateName]
    if styleAffectsLayout(localStyle) then return true end
    local c = rawget(self, "_class")
    while c do
        local styles = rawget(c, "__stateStyles")
        if styles and styleAffectsLayout(styles[stateName]) then return true end
        c = rawget(c, "__parent")
    end
    return false
end

local function statePriority(self, stateName)
    local custom = rawget(self, "_statePriorities")
    return (custom and custom[stateName]) or statePriorities[stateName] or 50
end

local function activeStates(self)
    local cached = rawget(self, "_activeStates")
    if cached then return cached end

    local states, seq = rawget(self, "_states"), rawget(self, "_stateSequence")
    cached = {}
    for stateName, active in pairs(states) do
        if active then cached[#cached + 1] = stateName end
    end
    table.sort(cached, function(a, b)
        local ap, bp = statePriority(self, a), statePriority(self, b)
        if ap ~= bp then return ap > bp end
        return (seq[a] or 0) > (seq[b] or 0)
    end)
    rawset(self, "_activeStates", cached)
    return cached
end

local function classStateValue(c, stateName, propName)
    while c do
        local styles = rawget(c, "__stateStyles")
        local stateStyle = styles and styles[stateName]
        if stateStyle and stateStyle[propName] ~= nil then
            return true, stateStyle[propName]
        end
        c = rawget(c, "__parent")
    end
    return false
end

-- Hook used by core/class while resolving effective property values.
Element.__stateResolver = function(self, propName, c)
    local styles = rawget(self, "_stateStyles")
    local active = activeStates(self)
    for i = 1, #active do
        local stateName = active[i]
        local localStyle = styles[stateName]
        if localStyle and localStyle[propName] ~= nil then
            return true, localStyle[propName]
        end
        local found, value = classStateValue(c, stateName, propName)
        if found then return true, value end
    end
    return false
end

--- Per-instance initialization; subclasses override and call Element.setup.
function Element:setup()
    rawset(self, "_states", {})
    rawset(self, "_stateStyles", {})
    rawset(self, "_statePriorities", {})
    rawset(self, "_stateSequence", {})
    rawset(self, "_stateSequenceN", 0)
    rawset(self, "_bindings", {})

    self:on("focus", function(s) s:setState("focused", true) end)
    self:on("blur", function(s) s:setState("focused", false) end)
end

--- Activates or deactivates a named state. State changes are idempotent.
function Element:setState(stateName, active)
    if type(stateName) ~= "string" or stateName == "" then
        error("Basalt 2.5: state name must be a non-empty string", 2)
    end
    active = active ~= false and active ~= nil
    local states = rawget(self, "_states")
    if states[stateName] == active then return self end

    states[stateName] = active
    if active then
        local n = rawget(self, "_stateSequenceN") + 1
        rawset(self, "_stateSequenceN", n)
        rawget(self, "_stateSequence")[stateName] = n
    end
    rawset(self, "_activeStates", nil)
    if stateStyleAffectsLayout(self, stateName) then
        self:markLayoutDirty()
    else
        self:markRenderDirty()
    end
    self:fire("stateChange", stateName, active)
    return self
end

function Element:hasState(stateName)
    return rawget(self, "_states")[stateName] == true
end

function Element:toggleState(stateName)
    return self:setState(stateName, not self:hasState(stateName))
end

function Element:getStates()
    local result = {}
    for stateName, active in pairs(rawget(self, "_states")) do
        if active then result[#result + 1] = stateName end
    end
    table.sort(result)
    return result
end

--- Defines per-element property overrides for a state.
function Element:setStateStyle(stateName, props, priority)
    if type(props) ~= "table" then
        error("Basalt 2.5: state style must be a table", 2)
    end
    local c = rawget(self, "_class")
    local style = {}
    for propName, value in pairs(props) do
        local prop = c.__props[propName]
        if not prop then
            error("Basalt 2.5: unknown state style property '" .. tostring(propName) .. "'", 2)
        end
        if not prop.styleable then
            error("Basalt 2.5: property '" .. propName .. "' cannot be state-styled", 2)
        end
        style[propName] = value
    end
    rawget(self, "_stateStyles")[stateName] = style
    if priority ~= nil then self:setStatePriority(stateName, priority) end
    if self:hasState(stateName) and styleAffectsLayout(style) then
        self:markLayoutDirty()
    else
        self:markRenderDirty()
    end
    return self
end

function Element:setStatePriority(stateName, priority)
    if type(priority) ~= "number" then
        error("Basalt 2.5: state priority must be a number", 2)
    end
    rawget(self, "_statePriorities")[stateName] = priority
    rawset(self, "_activeStates", nil)
    self:markLayoutDirty()
    return self
end

--- Applies a table of properties; keys like onClick with a function value
--- are registered as event handlers.
function Element:apply(props)
    for k, v in pairs(props) do
        if type(v) == "function" and k:find("^on%u") and self[k] then
            self[k](self, v)
        else
            self[k] = v
        end
    end
    return self
end

--- Returns the stored property value without evaluating dynamic values
--- (i.e. the function itself instead of its result).
function Element:raw(propName)
    return rawget(self, "_p")[propName]
end

function Element:on(eventName, fn)
    local hs = self._handlers[eventName]
    if not hs then
        hs = {}
        self._handlers[eventName] = hs
    end
    hs[#hs + 1] = fn
    return self
end

--- Removes one previously registered event handler.
function Element:off(eventName, fn)
    local hs = self._handlers[eventName]
    if not hs then return self end
    for i = #hs, 1, -1 do
        if hs[i] == fn then
            table.remove(hs, i)
            break
        end
    end
    return self
end

local defaultBindingEvents = {
    text = "change",
    checked = "change",
    value = "change",
    selected = "select",
}

--- Binds a property to application state.
---
--- options may be a function (state -> property transform) or a table:
---   fromState(value, self) -> displayed property value
---   toState(value, self, ...) -> value written back by control events
---   event = "change" / "select" / custom event name
---   twoWay = false to explicitly disable automatic event write-back
function Element:bind(propName, source, options)
    local c = rawget(self, "_class")
    if not c.__props[propName] then
        error("Basalt 2.5: cannot bind unknown property '" .. tostring(propName) .. "'", 2)
    end
    if not state.is(source) then
        error("Basalt 2.5: bind expects a state or computed value", 2)
    end

    if type(options) == "function" then
        options = { fromState = options }
    else
        options = options or {}
    end
    if type(options) ~= "table" then
        error("Basalt 2.5: bind options must be a function or table", 2)
    end

    self:unbind(propName)

    local boundValue = source
    if options.fromState then
        local transform = options.fromState
        if type(transform) ~= "function" then
            error("Basalt 2.5: fromState must be a function", 2)
        end
        local el = self
        boundValue = state.computed(function()
            return transform(source:get(), el)
        end)
    end

    local binding = { source = source, value = boundValue }
    local eventName = options.event or defaultBindingEvents[propName]
    local twoWay = options.twoWay ~= false and state.isWritable(source)
        and eventName ~= nil

    if twoWay then
        local toState = options.toState
        if toState ~= nil and type(toState) ~= "function" then
            error("Basalt 2.5: toState must be a function", 2)
        end
        binding.event = eventName
        binding.handler = function(_, value, ...)
            if toState then value = toState(value, self, ...) end
            source:set(value)
            -- Controls assign their property before firing change/select.
            -- Restore the reactive property after the write-back.
            self[propName] = boundValue
        end
        self:on(eventName, binding.handler)
    end

    rawget(self, "_bindings")[propName] = binding
    self[propName] = boundValue
    local _ = self[propName] -- resolve once (also synchronizes mirrored states)
    return self
end

--- Removes a binding. By default the currently displayed value is retained;
--- pass false to fall back to the class default instead.
function Element:unbind(propName, keepCurrent)
    local bindings = rawget(self, "_bindings")
    local binding = bindings and bindings[propName]
    if not binding then return self end

    local current = self[propName]
    if binding.handler then self:off(binding.event, binding.handler) end
    bindings[propName] = nil

    if keepCurrent == false then
        rawget(self, "_p")[propName] = nil
        self:markDirty()
    else
        self[propName] = current
    end
    return self
end

function Element:fire(eventName, ...)
    local hs = self._handlers[eventName]
    if not hs then return false end
    for i = 1, #hs do
        hs[i](self, ...)
    end
    return true
end

--- Marks the UI tree this element belongs to as needing a redraw.
--- Only the root's flag matters: the tree is redrawn as a whole and the line
--- diff in the render buffer keeps the actual terminal IO minimal.
function Element:markDirty()
    return self:markLayoutDirty()
end

--- Marks only the retained render tree dirty. Scrolling and paint-only state
--- changes use this path so cached layout remains valid.
function Element:markRenderDirty()
    local n = self
    local p = rawget(n, "parent")
    while p do
        n = p
        p = rawget(n, "parent")
    end
    rawset(n, "_dirty", true)
    return self
end

--- Invalidates cached layout/content bounds for this element's container
--- chain. Paint-only properties deliberately skip this expensive path.
function Element:invalidateLayout(propName)
    if propName and not propertyAffectsLayout(propName) then return self end
    local n = self
    while n do
        if rawget(n, "_children") then
            rawset(n, "_layoutDirty", true)
            rawset(n, "_viewportDirty", true)
        end
        n = rawget(n, "parent")
    end
    return self
end

function Element:markLayoutDirty()
    self:invalidateLayout()
    return self:markRenderDirty()
end

--- Point test in parent-local coordinates.
function Element:contains(px, py)
    local x, y = self.x, self.y
    return px >= x and py >= y and px < x + self.width and py < y + self.height
end

function Element:getRoot()
    local n = self
    while rawget(n, "parent") do
        n = rawget(n, "parent")
    end
    return n
end

function Element:getAbsolutePosition()
    local x, y = self.x, self.y
    local p = rawget(self, "parent")
    while p do
        x = x + p.x - 1 - (rawget(p, "_scrollX") or 0)
        y = y + p.y - 1 - (rawget(p, "_scrollY") or 0)
        p = rawget(p, "parent")
    end
    return x, y
end

--- Returns the intrinsic size used by basalt.auto(). Elements with content
--- override this; the base implementation keeps numeric authored dimensions.
function Element:measure()
    local w, h = layout.spec(self, "width"), layout.spec(self, "height")
    return type(w) == "number" and w or 1, type(h) == "number" and h or 1
end

function Element:focus()
    if self.disabled then return self end
    local root = self:getRoot()
    if root.setFocused then root:setFocused(self) end
    return self
end

--- Requests the terminal cursor at a local position; only honored while this
--- element has focus. Pass blink=false to hide it.
function Element:setCursor(x, y, blink, color)
    local root = self:getRoot()
    if root ~= self and root.setCursor and root.getFocused
        and root:getFocused() == self then
        local ax, ay = self:getAbsolutePosition()
        local cursorX, cursorY = ax + x - 1, ay + y - 1
        local visible = x >= 1 and y >= 1 and x <= self.width and y <= self.height
        local p = rawget(self, "parent")
        while visible and p do
            local px, py = p:getAbsolutePosition()
            if cursorX < px or cursorY < py
                or cursorX >= px + p.width or cursorY >= py + p.height then
                visible = false
            end
            p = rawget(p, "parent")
        end
        if visible then
            root:setCursor(cursorX, cursorY, blink, color)
        else
            root:setCursor(1, 1, false, color)
        end
    end
    return self
end

function Element:destroy()
    local p = rawget(self, "parent")
    if p then p:removeChild(self) end
    return self
end

--- Draws the element into the buffer (local coordinates, pre-clipped).
function Element:render(buf)
    local bg = self.background
    if bg then
        buf:fill(1, 1, self.width, self.height, " ", self.foreground, bg)
    end
end

--- Handles a positional mouse event in local coordinates.
--- Returns the consuming element, or nil to let it pass through.
function Element:handleMouse(event, btn, x, y)
    if self.disabled then return nil end
    if event == "mouse_click" then
        if self.background or self._handlers.click then
            self:setState("pressed", true)
            self:focus()
            self:fire("click", btn, x, y)
            return self
        end
    elseif event == "mouse_scroll" then
        if self._handlers.scroll then
            self:fire("scroll", btn, x, y)
            return self
        end
    end
    return nil
end

--- Handles a keyboard event (element must be focused).
function Element:handleKey(event, a, b)
    if self.disabled then return end
    if event == "key" then
        self:fire("key", a, b)
    elseif event == "key_up" then
        self:fire("keyUp", a)
    elseif event == "char" then
        self:fire("char", a)
    elseif event == "paste" then
        self:fire("paste", a)
    end
end

return Element

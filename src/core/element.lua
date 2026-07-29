-- Base class for everything visible in Basalt 2.

local require = ...
local class = require("core/class")
local state = require("core/state")
local layout = require("core/layout")

---@alias ElementPositionMode "flow"|"absolute"
---@alias ElementAlignment "start"|"center"|"end"|"stretch"
---@alias ElementEventHandler<T> fun(self: T, ...: any)

---@class ElementLayoutBox
---@field x number Resolved parent-local x position
---@field y number Resolved parent-local y position
---@field width number Resolved width
---@field height number Resolved height

---@class ElementBindingOptions
---@field fromState? fun(value: any, element: Element): any State-to-property transform
---@field toState? fun(value: any, element: Element, ...: any): any Property-to-state transform
---@field event? string Event used for two-way updates
---@field twoWay? boolean Whether writable state is updated from the element

---@class ElementBinding
---@field source Signal|Computed Bound state value
---@field value Signal|Computed State or transformed computed value
---@field event? string Event registered for two-way updates
---@field handler? ElementEventHandler<Element> Registered two-way event handler

---@class Element
---@field public x number Parent-local horizontal position
---@field public y number Parent-local vertical position
---@field public z number Stacking order among siblings
---@field public width number Resolved width
---@field public height number Resolved height
---@field public minWidth number|false Minimum width, or false for none
---@field public maxWidth number|false Maximum width, or false for none
---@field public minHeight number|false Minimum height, or false for none
---@field public maxHeight number|false Maximum height, or false for none
---@field public position ElementPositionMode Positioning mode inside flex layouts
---@field public alignSelf ElementAlignment|false Per-child cross-axis alignment
---@field public shrink number|false Flex shrink weight, or false for automatic behavior
---@field public visible boolean Whether the element is rendered and receives input
---@field public background number|false Background color, or false for transparency
---@field public foreground number Foreground color
---@field public name string Lookup name
---@field public disabled boolean Whether input is disabled
---@field public parent? Container Owning container
---@field __name? string Runtime class name resolved through the class metatable
---@field find? fun(self: Element, name: string): Element? Optional container lookup
---@field findAt? fun(self: Element, x: number, y: number): Element? Optional container hit test
---@field getChildren? fun(self: Element): Element[] Optional container child access
---@field setFocused? fun(self: Element, element?: Element) Optional root focus setter
---@field getFocused? fun(self: Element): Element? Optional root focus getter
---@field _releaseSubtree? fun(self: Element, element: Element) Optional root interaction cleanup
---@field onClick fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onClickUp fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onDrag fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onScroll fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onFocus fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onBlur fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onKey fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onKeyUp fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onChar fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onPaste fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onStateChange fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onMouseEnter fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onMouseLeave fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field onLayout fun(self: Element, fn: ElementEventHandler<Element>): Element
---@field animate? fun(self: Element, props: table, duration?: number, easing?: string, onDone?: function): Element Optional animation-module shortcut
---@field setResponsive? fun(self: Element, rules: table[]): Element Optional responsive-module shortcut
---@field responsive? fun(self: Element): ResponsiveBuilder Optional responsive rule builder
---@field clearResponsive? fun(self: Element): Element Optional responsive-module cleanup
---@field private _p table<string, any> Authored property values
---@field package _handlers table<string, ElementEventHandler<Element>[]> Event handlers by name
---@field private _class table Runtime class table
---@field private _layoutBox? ElementLayoutBox Resolved layout override
---@field private _order? integer Stable insertion order within the parent
---@field private _states table<string, boolean> Active-state map
---@field private _stateStyles table<string, table<string, any>> Per-state property overrides
---@field private _statePriorities table<string, number> Per-state priority overrides
---@field private _stateSequence table<string, integer> State activation sequence
---@field private _stateSequenceN integer Latest activation sequence number
---@field private _activeStates? string[] Cached active states in resolution order
---@field private _bindings table<string, ElementBinding> Property bindings
---@field private _stateDependencies? table<Signal|Computed, boolean> Reactive dependencies
---@field private _dirty? boolean Root render-dirty flag
local Element = class.create("Element")

class.property(Element, "x", 1) -- horizontal position, parent-local, 1-based
class.property(Element, "y", 1) -- vertical position, parent-local, 1-based
--- Stacking order among siblings; higher z renders on top
class.property(Element, "z", 0, {
    onChange = function(self)
        local p = rawget(self, "parent")
        if p then p._sortDirty = true end
    end,
})
class.property(Element, "width", 1) -- number, basalt.auto/fill/percent or dynamic
class.property(Element, "height", 1) -- number, basalt.auto/fill/percent or dynamic
class.property(Element, "minWidth", false) -- layout constraint, false = none
class.property(Element, "maxWidth", false) -- layout constraint, false = none
class.property(Element, "minHeight", false) -- layout constraint, false = none
class.property(Element, "maxHeight", false) -- layout constraint, false = none
class.property(Element, "position", "flow") -- "flow" or "absolute" (flex layouts)
class.property(Element, "alignSelf", false) -- per-child cross-axis override
class.property(Element, "shrink", false) -- may shrink below its desired size
--- Hidden elements are neither rendered nor hit by events
class.property(Element, "visible", true, {
    onChange = function(self, visible)
        if not visible then
            local root = self:getRoot()
            if root._releaseSubtree then root:_releaseSubtree(self) end
        end
    end,
})
class.property(Element, "background", false) -- colors.*, basalt.rgb or false = transparent
class.property(Element, "foreground", colors.white) -- text color
class.property(Element, "name", "", { visual = false }) -- lookup key for find() and reactive refs
--- Disabled elements ignore all input; mirrored to the "disabled" state
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

--- Fired on mouse press with (button, x, y) in local coordinates
class.event(Element, "click")
--- Fired on mouse release with (button, x, y), also when released outside
class.event(Element, "clickUp")
--- Fired while dragging with (button, x, y) relative to the element
class.event(Element, "drag")
--- Fired on mouse wheel with (direction, x, y)
class.event(Element, "scroll")
--- Fired when the element gains keyboard focus
class.event(Element, "focus")
--- Fired when the element loses keyboard focus
class.event(Element, "blur")
--- Fired on key press with the key code (while focused)
class.event(Element, "key")
--- Fired on key release with the key code
class.event(Element, "keyUp")
--- Fired on character input with the typed character
class.event(Element, "char")
--- Fired on ctrl+v with the pasted text
class.event(Element, "paste")
--- Fired when a named state toggles, with (stateName, active)
class.event(Element, "stateChange")
--- Fired when the pointer moves onto the element
class.event(Element, "mouseEnter")
--- Fired when the pointer leaves the element
class.event(Element, "mouseLeave")
--- Fired before children are laid out, with (width, height)
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
---@param stateName string The state name (e.g. "hover", "checked")
---@param active? boolean false or nil deactivates the state
---@return self
function Element:setState(stateName, active)
    if type(stateName) ~= "string" or stateName == "" then
        error("Basalt: state name must be a non-empty string", 2)
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

--- Returns whether a named state is active.
---@param stateName string State name
---@return boolean active
function Element:hasState(stateName)
    return rawget(self, "_states")[stateName] == true
end

--- Toggles a named state.
---@param stateName string State name
---@return self
function Element:toggleState(stateName)
    return self:setState(stateName, not self:hasState(stateName))
end

--- Returns active state names sorted alphabetically.
---@return string[] states
function Element:getStates()
    local result = {}
    for stateName, active in pairs(rawget(self, "_states")) do
        if active then result[#result + 1] = stateName end
    end
    table.sort(result)
    return result
end

--- Defines per-element property overrides for a state.
---@param stateName string The state the style applies to
---@param props table<string, any> Property overrides while the state is active
---@param priority? number Optional state priority override
---@return self
---@usage btn:setStateStyle("hover", { background = colors.blue })
function Element:setStateStyle(stateName, props, priority)
    if type(props) ~= "table" then
        error("Basalt: state style must be a table", 2)
    end
    local c = rawget(self, "_class")
    local style = {}
    for propName, value in pairs(props) do
        local prop = c.__props[propName]
        if not prop then
            error("Basalt: unknown state style property '" .. tostring(propName) .. "'", 2)
        end
        if not prop.styleable then
            error("Basalt: property '" .. propName .. "' cannot be state-styled", 2)
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

--- Overrides the resolution priority of a named state.
---@param stateName string State name
---@param priority number Higher priorities win
---@return self
function Element:setStatePriority(stateName, priority)
    if type(priority) ~= "number" then
        error("Basalt: state priority must be a number", 2)
    end
    rawget(self, "_statePriorities")[stateName] = priority
    rawset(self, "_activeStates", nil)
    self:markLayoutDirty()
    return self
end

--- Applies properties and onX callback entries from a table.
---@param props table<string, any> Property/callback map
---@return self
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

--- Returns an authored property without resolving state/functions/signals.
---@param propName string Property name
---@return any value
function Element:raw(propName)
    return rawget(self, "_p")[propName]
end

--- Registers an event handler; fn(self, ...) runs on every fire.
---@generic T : Element
---@param self T
---@param eventName string The event name (e.g. "click", "change")
---@param fn ElementEventHandler<T> The handler
---@return T self
function Element:on(eventName, fn)
    local handlers = rawget(self, "_handlers")
    local hs = handlers[eventName]
    if not hs then
        hs = {}
        handlers[eventName] = hs
    end
    hs[#hs + 1] = fn
    return self
end

--- Removes one registered event handler.
---@generic T : Element
---@param self T
---@param eventName string Event name
---@param fn ElementEventHandler<T> Previously registered handler
---@return T self
function Element:off(eventName, fn)
    local hs = rawget(self, "_handlers")[eventName]
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

--- Binds a property to a State/Computed value with optional two-way mapping.
---@param propName string Property name
---@param source Signal|Computed State or computed value
---@param options? ElementBindingOptions|fun(value: any, element: Element): any Binding options or fromState transform
---@return self
function Element:bind(propName, source, options)
    local c = rawget(self, "_class")
    if not c.__props[propName] then
        error("Basalt: cannot bind unknown property '" .. tostring(propName) .. "'", 2)
    end
    if not state.is(source) then
        error("Basalt: bind expects a state or computed value", 2)
    end

    if type(options) == "function" then
        options = { fromState = options }
    else
        options = options or {}
    end
    if type(options) ~= "table" then
        error("Basalt: bind options must be a function or table", 2)
    end

    self:unbind(propName)

    local boundValue = source
    if options.fromState then
        local transform = options.fromState
        if type(transform) ~= "function" then
            error("Basalt: fromState must be a function", 2)
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
            error("Basalt: toState must be a function", 2)
        end
        local writableSource = source
        ---@cast writableSource Signal
        binding.event = eventName
        binding.handler = function(_, value, ...)
            if toState then value = toState(value, self, ...) end
            writableSource:set(value)
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

--- Removes a property binding.
---@param propName string Property name
---@param keepCurrent? boolean false restores the class/default value
---@return self
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

--- Fires an event synchronously on all registered handlers.
---@param eventName string Event name
---@param ... any Event arguments
---@return boolean handled True when handlers existed
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
---@return self
function Element:markDirty()
    return self:markLayoutDirty()
end

--- Marks only the retained render tree dirty. Scrolling and paint-only state
--- changes use this path so cached layout remains valid.
---@return self
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
---@param propName? string Changed property, if known
---@return self
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

--- Invalidates layout and marks the retained render tree dirty.
---@return self
function Element:markLayoutDirty()
    self:invalidateLayout()
    return self:markRenderDirty()
end

--- Tests parent-local coordinates against this element's bounds.
---@param px number Parent-local x
---@param py number Parent-local y
---@return boolean inside
function Element:contains(px, py)
    local x, y = self.x, self.y
    return px >= x and py >= y and px < x + self.width and py < y + self.height
end

--- Returns the root element of this UI tree.
---@return Element root
function Element:getRoot()
    local n = self
    while rawget(n, "parent") do
        n = rawget(n, "parent")
    end
    return n
end

--- Returns terminal-local coordinates after ancestor scroll offsets.
---@return number x
---@return number y
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
---@param _availableWidth? number Space offered by the parent
---@param _availableHeight? number Space offered by the parent
---@return number width
---@return number height
function Element:measure(_availableWidth, _availableHeight)
    local w, h = layout.spec(self, "width"), layout.spec(self, "height")
    return type(w) == "number" and w or 1, type(h) == "number" and h or 1
end

--- Gives this element keyboard focus.
---@return self
function Element:focus()
    if self.disabled then return self end
    local root = self:getRoot()
    if root.setFocused then root:setFocused(self) end
    return self
end

--- Requests a cursor using element-local coordinates.
---@param x number Local x
---@param y number Local y
---@param blink boolean Cursor blink state
---@param color? number Cursor color
---@return self
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

--- Removes this element from its parent.
---@return self
function Element:destroy()
    local p = rawget(self, "parent")
    if p then p:removeChild(self) end
    return self
end

--- Draws the element into the buffer (local coordinates, pre-clipped).
---@param buf Render Render buffer
function Element:render(buf)
    local bg = self.background
    if bg then
        buf:fill(1, 1, self.width, self.height, " ", self.foreground, bg)
    end
end

--- Handles a positional mouse event in local coordinates.
--- Returns the consuming element, or nil to let it pass through.
---@param event string Mouse event name
---@param btn number Mouse button or scroll direction
---@param x number Local x coordinate
---@param y number Local y coordinate
---@return Element|nil consumer
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
---@param event string Keyboard event name
---@param a any Key code or text
---@param b? any Secondary event value
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

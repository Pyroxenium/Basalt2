-- Container: an element that owns and renders child elements.

local require = ...
local class = require("core/class")
local Element = require("core/element")
local state = require("core/state")
local layout = require("core/layout")
local scroll = require("core/scroll")

---@alias ContainerScrollbarMode "auto"|"always"|"hidden"

---@class ContainerScrollbarGeometry
---@field showX boolean Whether the horizontal scrollbar is visible
---@field showY boolean Whether the vertical scrollbar is visible
---@field horizontalLength number Horizontal scrollbar track length
---@field verticalLength number Vertical scrollbar track length
---@field horizontalThumbSize number Horizontal thumb size
---@field horizontalThumbPos number Horizontal thumb offset
---@field verticalThumbSize number Vertical thumb size
---@field verticalThumbPos number Vertical thumb offset
---@field maxX number Maximum horizontal scroll offset
---@field maxY number Maximum vertical scroll offset

---@class ContainerScrollInfo : ContainerScrollbarGeometry
---@field x number Current horizontal scroll offset
---@field y number Current vertical scroll offset
---@field contentWidth number Laid-out content width
---@field contentHeight number Laid-out content height

---@class ContainerScrollDrag
---@field axis "x"|"y" Dragged scrollbar axis
---@field grab number Offset within the scrollbar thumb

---@class Container : Element
---@field public scrollable boolean Whether content scrolling is enabled
---@field public scrollbar ContainerScrollbarMode Scrollbar visibility mode
---@field public scrollXEnabled boolean Whether horizontal scrolling is enabled
---@field public scrollYEnabled boolean Whether vertical scrolling is enabled
---@field public scrollStep number Cells scrolled per mouse-wheel tick
---@field public scrollbarColor number Scrollbar track color
---@field public scrollbarThumbColor number Scrollbar thumb color
---@field public layoutChildren? fun(self: Container) Optional custom child layout
---@field private _children Element[] Live direct-child array
---@field private _visibleChildren Element[] Cached visible children
---@field private _addIndex integer Monotonic child insertion index
---@field private _sortDirty boolean Whether children need z-order sorting
---@field private _layoutDirty boolean Whether child layout must be recomputed
---@field private _viewportDirty boolean Whether the visible-child cache is stale
---@field private _scrollX number Current horizontal scroll offset
---@field private _scrollY number Current vertical scroll offset
---@field private _contentWidth number Cached content width
---@field private _contentHeight number Cached content height
---@field private _showScrollX? boolean Whether the horizontal scrollbar is visible
---@field private _showScrollY? boolean Whether the vertical scrollbar is visible
---@field private _scrollDrag? ContainerScrollDrag Active scrollbar drag
local Container = class.create("Container", Element)

--- Enables content scrolling for this container
class.property(Container, "scrollable", false, {
    onChange = function(self, enabled)
        if not enabled then scroll.disable(self) end
    end,
})
--- "auto", "always" or "hidden"
class.property(Container, "scrollbar", "auto")
--- Allow horizontal scrolling
class.property(Container, "scrollXEnabled", true)
--- Allow vertical scrolling
class.property(Container, "scrollYEnabled", true)
--- Cells scrolled per mouse wheel tick
class.property(Container, "scrollStep", 3)
--- Scrollbar track color
class.property(Container, "scrollbarColor", colors.gray)
--- Scrollbar thumb color
class.property(Container, "scrollbarThumbColor", colors.lightGray)
--- Fired when the scroll offset changes, with (x, y)
class.event(Container, "scrollChange")

--- Initializes per-instance state and input handlers.
function Container:setup()
    Element.setup(self)
    rawset(self, "_children", {})
    rawset(self, "_addIndex", 0)
    rawset(self, "_sortDirty", false)
    rawset(self, "_layoutDirty", true)
    rawset(self, "_viewportDirty", true)
    rawset(self, "_visibleChildren", {})
    scroll.setup(self)
end

--- Returns the current horizontal and vertical scroll offsets.
---@return number x
---@return number y
function Container:getScroll()
    return rawget(self, "_scrollX") or 0, rawget(self, "_scrollY") or 0
end

--- Returns cached content bounds after the latest layout pass.
---@return number width
---@return number height
function Container:getContentSize()
    return rawget(self, "_contentWidth") or 0,
        rawget(self, "_contentHeight") or 0
end

--- Returns scrollbar visibility, ranges, offsets and content size.
---@return ContainerScrollInfo info
function Container:getScrollInfo()
    local info = scroll.geometry(self)
    info.x, info.y = self:getScroll()
    info.contentWidth, info.contentHeight = self:getContentSize()
    ---@cast info ContainerScrollInfo
    return info
end

--- Scrolls to absolute content offsets.
---@param x? number Horizontal offset, default 0
---@param y? number Vertical offset, default 0
---@return self
function Container:scrollTo(x, y)
    scroll.set(self, x or 0, y or 0)
    return self
end

--- Scrolls relative to the current offsets.
---@param dx? number Horizontal delta, default 0
---@param dy? number Vertical delta, default 0
---@return self
function Container:scrollBy(dx, dy)
    local x, y = self:getScroll()
    scroll.set(self, x + (dx or 0), y + (dy or 0))
    return self
end

local function descendantBox(container, el)
    local x, y = el.x, el.y
    local p = rawget(el, "parent")
    while p and p ~= container do
        x = x + p.x - 1 - (rawget(p, "_scrollX") or 0)
        y = y + p.y - 1 - (rawget(p, "_scrollY") or 0)
        p = rawget(p, "parent")
    end
    if p ~= container then
        error("Basalt scroll: element is not a descendant of this container", 3)
    end
    return x, y, el.width, el.height
end

--- Aligns a descendant's top-left corner with the viewport.
---@param el Element Descendant element
---@return self
function Container:scrollToElement(el)
    local x, y = descendantBox(self, el)
    return self:scrollTo(x - 1, y - 1)
end

--- Applies the smallest scroll needed to reveal a descendant.
---@param el Element Descendant element
---@return self
function Container:ensureVisible(el)
    local x, y, w, h = descendantBox(self, el)
    local sx, sy = self:getScroll()
    if x < sx + 1 then sx = x - 1 end
    if y < sy + 1 then sy = y - 1 end
    if x + w - 1 > sx + self.width then sx = x + w - 1 - self.width end
    if y + h - 1 > sy + self.height then sy = y + h - 1 - self.height end
    return self:scrollTo(sx, sy)
end

--- Attaches an existing element as the final child.
---@generic T : Element
---@param child T Element to attach
---@return T child
function Container:addChild(child)
    local oldParent = rawget(child, "parent")
    if oldParent then oldParent:removeChild(child) end

    rawset(child, "parent", self)
    self._addIndex = self._addIndex + 1
    rawset(child, "_order", self._addIndex)

    local ch = self._children
    ch[#ch + 1] = child
    self._sortDirty = true
    self:markLayoutDirty()
    return child
end

--- Detaches a direct child and releases its interaction state.
---@param child Element Child to remove
---@return boolean removed
function Container:removeChild(child)
    local ch = self._children
    for i = 1, #ch do
        if ch[i] == child then
            local root = self:getRoot()
            if root._releaseSubtree then root:_releaseSubtree(child) end
            table.remove(ch, i)
            rawset(child, "parent", nil)
            self:markLayoutDirty()
            return true
        end
    end
    return false
end

--- Recursively destroys every descendant before detaching this container.
--- This is important for stateful children such as Program: merely removing
--- their parent frame would otherwise leave their scheduled coroutines alive.
---@return self
function Container:destroy()
    local children = rawget(self, "_children")
    while children and #children > 0 do
        local child = children[#children]
        if child.destroy then child:destroy() end
        -- Custom elements may override destroy without detaching themselves.
        -- Always make forward progress while keeping ordinary destroy hooks.
        if children[#children] == child then self:removeChild(child) end
    end
    return Element.destroy(self)
end

--- Returns the live direct-child array.
---@return Element[] children
function Container:getChildren()
    return self._children
end

--- Finds a descendant element by its name property (depth-first).
---@param childName string Element name
---@return Element|nil element
function Container:find(childName)
    local ch = self._children
    for i = 1, #ch do
        if ch[i].name == childName then return ch[i] end
    end
    for i = 1, #ch do
        local c = ch[i]
        if c.find then
            local found = c:find(childName)
            if found then return found end
        end
    end
    return nil
end

local function zLess(a, b)
    local az, bz = a.z, b.z
    if az == bz then return a._order < b._order end
    return az < bz
end

--- Children sorted by z (stable: insertion order breaks ties), cached.
---@return Element[] children
function Container:_sorted()
    if self._sortDirty then
        table.sort(self._children, zLess)
        self._sortDirty = false
        self._viewportDirty = true
    end
    return self._children
end

local function intersectsViewport(child, scrollX, scrollY, width, height)
    -- Flex/free layout boxes already contain resolved numeric geometry. Using
    -- them directly avoids four property/metatable resolutions per offscreen
    -- child during a large viewport scan.
    local box = rawget(child, "_layoutBox")
    local x = box and box.x or child.x
    local y = box and box.y or child.y
    local w = box and box.width or child.width
    local h = box and box.height or child.height
    if w <= 0 or h <= 0 then return false end
    return x <= scrollX + width and y <= scrollY + height
        and x + w - 1 > scrollX and y + h - 1 > scrollY
end

--- Sorted children intersecting the current viewport. The cache is shared by
--- rendering and hit-testing and is invalidated by layout, z or scroll changes.
---@return Element[] children
function Container:_visibleSorted()
    local cached = rawget(self, "_visibleChildren")
    if not rawget(self, "_viewportDirty") and cached then return cached end
    cached = {}
    local scrollX, scrollY = self:getScroll()
    local children = self:_sorted()
    for i = 1, #children do
        local child = children[i]
        if child.visible and intersectsViewport(child, scrollX, scrollY,
            self.width, self.height) then
            cached[#cached + 1] = child
        end
    end
    rawset(self, "_visibleChildren", cached)
    rawset(self, "_viewportDirty", false)
    return cached
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function Container:render(buf)
    Element.render(self, buf)
    local children = self._children
    if rawget(self, "_layoutDirty") then
        for i = 1, #children do
            local c = children[i]
            state.clearWatcher(c)
            local z = c:raw("z")
            if state.is(z) or type(z) == "function" then
                -- Re-sort after dynamic z values have been resolved.
                self._sortDirty = true
            end
        end
        self:fire("layout", self.width, self.height)
        if self.layoutChildren then
            self:layoutChildren()
        else
            layout.resolveFreeChildren(self)
        end
        scroll.update(self)
        rawset(self, "_layoutDirty", false)
        rawset(self, "_viewportDirty", true)
    end
    local scrollX, scrollY = self:getScroll()
    local ch = self:_visibleSorted()
    for i = 1, #ch do
        local c = ch[i]
        if c.visible then
            buf:push(c.x - scrollX, c.y - scrollY, c.width, c.height)
            c:render(buf)
            buf:pop()
        end
    end
    scroll.draw(self, buf)
end

--- Routes a mouse event to children (topmost first), falling back to self.
---@param event string Mouse event name
---@param btn number Mouse button or scroll direction
---@param x number Local x coordinate
---@param y number Local y coordinate
---@return Element|nil consumer The consuming element, or nil
function Container:handleMouse(event, btn, x, y)
    if event == "mouse_click" and scroll.pointerDown(self, x, y) then
        return self
    end
    local scrollX, scrollY = self:getScroll()
    local contentX, contentY = x + scrollX, y + scrollY
    local ch = self:_visibleSorted()
    for i = #ch, 1, -1 do
        local c = ch[i]
        if c.visible and c:contains(contentX, contentY) then
            local hit = c:handleMouse(event, btn,
                contentX - c.x + 1, contentY - c.y + 1)
            if hit then return hit end
        end
    end
    if event == "mouse_scroll" and scroll.wheel(self, btn) then return self end
    return Element.handleMouse(self, event, btn, x, y)
end

--- Returns the deepest visible element at a point, regardless of handlers.
---@param x number Local x coordinate
---@param y number Local y coordinate
---@return Element element
function Container:findAt(x, y)
    if scroll.isBarPoint(self, x, y) then return self end
    local scrollX, scrollY = self:getScroll()
    local contentX, contentY = x + scrollX, y + scrollY
    local ch = self:_visibleSorted()
    for i = #ch, 1, -1 do
        local c = ch[i]
        if c.visible and c:contains(contentX, contentY) then
            local lx, ly = contentX - c.x + 1, contentY - c.y + 1
            if c.findAt then
                local hit = c:findAt(lx, ly)
                if hit then return hit end
            end
            return c
        end
    end
    return self
end

--- Registers an element class: creates Container:add<Name>(props).
---@generic T : Element
---@param elementName string Public element name
---@param elementClass { new: fun(props?: table): T } Element class
function Container.register(elementName, elementClass)
    Container["add" .. elementName] = function(self, props)
        local el = elementClass.new(props)
        self:addChild(el)
        return el
    end
end

return Container

local elementManager = require("elementManager")
local VisualElement = require("elements/VisualElement")
local Container = elementManager.getElement("Container")
local tHex = require("libraries/colorHex")
---@configDescription A SideNav element that provides sidebar navigation with multiple content areas.
---@configDefault false

--- The SideNav is a container that provides sidebar navigation functionality
--- @run [[
--- local basalt = require("basalt")
--- local main = basalt.getMainFrame()
--- 
--- -- Create a simple SideNav
--- local sideNav = main:addSideNav({
---     x = 1,
---     y = 1,
---     sidebarWidth = 12,
---     width = 48
--- })
--- 
--- -- Tab 1: Home
--- local homeTab = sideNav:newTab("Home")
--- 
--- homeTab:addLabel({
---     x = 2,
---     y = 2,
---     text = "Welcome!",
---     foreground = colors.yellow
--- })
--- 
--- homeTab:addLabel({
---     x = 2,
---     y = 4,
---     text = "This is a simple",
---     foreground = colors.white
--- })
--- 
--- homeTab:addLabel({
---     x = 2,
---     y = 5,
---     text = "SideNav example.",
---     foreground = colors.white
--- })
--- 
--- -- Tab 2: Counter
--- local counterTab = sideNav:newTab("Counter")
--- 
--- local counterLabel = counterTab:addLabel({
---     x = 2,
---     y = 2,
---     text = "Count: 0",
---     foreground = colors.lime
--- })
--- 
--- local count = 0
--- counterTab:addButton({
---     x = 2,
---     y = 4,
---     width = 12,
---     height = 3,
---     text = "Click Me",
---     background = colors.blue
--- })
--- :setBackgroundState("clicked", colors.lightBlue)
--- :onClick(function()
---     count = count + 1
---     counterLabel:setText("Count: " .. count)
--- end)
--- 
--- -- Tab 3: Info
--- local infoTab = sideNav:newTab("Info")
--- 
--- infoTab:addLabel({
---     x = 2,
---     y = 2,
---     text = "SideNav Features:",
---     foreground = colors.orange
--- })
--- 
--- infoTab:addLabel({
---     x = 2,
---     y = 4,
---     text = "- Multiple tabs",
---     foreground = colors.gray
--- })
--- 
--- infoTab:addLabel({
---     x = 2,
---     y = 5,
---     text = "- Easy navigation",
---     foreground = colors.gray
--- })
--- 
--- infoTab:addLabel({
---     x = 2,
---     y = 6,
---     text = "- Content per tab",
---     foreground = colors.gray
--- })
--- 
--- basalt.run()
--- ]]
---@class SideNav : Container
local SideNav = setmetatable({}, Container)
SideNav.__index = SideNav

---@property activeTab number nil The currently active navigation item ID
SideNav.defineProperty(SideNav, "activeTab", {default = nil, type = "number", allowNil = true, canTriggerRender = true, setter = function(self, value)
    return value
end})
---@property sidebarWidth number 12 Width of the sidebar navigation area
SideNav.defineProperty(SideNav, "sidebarWidth", {default = 12, type = "number", canTriggerRender = true})
---@property tabs table {} List of navigation item definitions
SideNav.defineProperty(SideNav, "tabs", {default = {}, type = "table"})

---@property sidebarBackground color gray Background color for the sidebar area
SideNav.defineProperty(SideNav, "sidebarBackground", {default = colors.gray, type = "color", canTriggerRender = true})
---@property activeTabBackground color white Background color for the active navigation item
SideNav.defineProperty(SideNav, "activeTabBackground", {default = colors.white, type = "color", canTriggerRender = true})
---@property activeTabTextColor color black Foreground color for the active navigation item text
SideNav.defineProperty(SideNav, "activeTabTextColor", {default = colors.black, type = "color", canTriggerRender = true})
---@property sidebarScrollOffset number 0 Current scroll offset for navigation items in scrollable mode
SideNav.defineProperty(SideNav, "sidebarScrollOffset", {default = 0, type = "number", canTriggerRender = true})
---@property sidebarPosition string left Position of the sidebar ("left" or "right")
SideNav.defineProperty(SideNav, "sidebarPosition", {default = "left", type = "string", canTriggerRender = true})

SideNav.defineEvent(SideNav, "mouse_click")
SideNav.defineEvent(SideNav, "mouse_up")
SideNav.defineEvent(SideNav, "mouse_scroll")

--- @shortDescription Creates a new SideNav instance
--- @return SideNav self The created instance
--- @private
function SideNav.new()
    local self = setmetatable({}, SideNav):__init()
    self.class = SideNav
    self.set("width", 30)
    self.set("height", 15)
    self.set("z", 10)
    return self
end

--- @shortDescription Initializes the SideNav instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @protected
function SideNav:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "SideNav")
end

--- returns a proxy for adding elements to the navigation item
--- @shortDescription Creates a new navigation item handler proxy
--- @param title string The title of the navigation item
--- @return table tabHandler The navigation item handler proxy for adding elements
function SideNav:newTab(title)
    local tabs = self.getResolved("tabs") or {}
    local tabId = #tabs + 1

    table.insert(tabs, {
        id = tabId,
        title = tostring(title or ("Item " .. tabId))
    })

    self.set("tabs", tabs)

    if not self.getResolved("activeTab") then
        self.set("activeTab", tabId)
    end
    self:updateTabVisibility()

    local sideNav = self
    local proxy = {}
    setmetatable(proxy, {
        __index = function(_, key)
            if type(key) == "string" and key:sub(1,3) == "add" and type(sideNav[key]) == "function" then
                return function(_, ...)
                    local el = sideNav[key](sideNav, ...)
                    if el then
                        el._tabId = tabId
                        sideNav.set("childrenSorted", false)
                        sideNav.set("childrenEventsSorted", false)
                        sideNav:updateRender()
                    end
                    return el
                end
            end
            local v = sideNav[key]
            if type(v) == "function" then
                return function(_, ...)
                    return v(sideNav, ...)
                end
            end
            return v
        end
    })

    return proxy
end
SideNav.addTab = SideNav.newTab

--- @shortDescription Sets an element to belong to a specific navigation item
--- @param element table The element to assign to a navigation item
--- @param tabId number The ID of the navigation item to assign the element to
--- @return SideNav self For method chaining
function SideNav:setTab(element, tabId)
    element._tabId = tabId
    self:updateTabVisibility()
    return self
end

--- @shortDescription Adds an element to the SideNav and assigns it to the active navigation item
--- @param elementType string The type of element to add
--- @param tabId number Optional navigation item ID, defaults to active item
--- @return table element The created element
function SideNav:addElement(elementType, tabId)
    local element = Container.addElement(self, elementType)
    local targetTab = tabId or self.getResolved("activeTab")
    if targetTab then
        element._tabId = targetTab
        self:updateTabVisibility()
    end
    return element
end

--- @shortDescription Overrides Container's addChild to assign new elements to item 1 by default
--- @param child table The child element to add
--- @return Container self For method chaining
--- @protected
function SideNav:addChild(child)
    Container.addChild(self, child)
    if not child._tabId then
        local tabs = self.getResolved("tabs") or {}
        if #tabs > 0 then
            child._tabId = 1
            self:updateTabVisibility()
        end
    end
    return self
end

--- @shortDescription Updates visibility of navigation item containers
--- @private
function SideNav:updateTabVisibility()
    self.set("childrenSorted", false)
    self.set("childrenEventsSorted", false)
end

--- @shortDescription Sets the active navigation item
--- @param tabId number The ID of the navigation item to activate
function SideNav:setActiveTab(tabId)
    local oldTab = self.getResolved("activeTab")
    if oldTab == tabId then return self end
    self.set("activeTab", tabId)
    self:updateTabVisibility()
    self:dispatchEvent("tabChanged", tabId, oldTab)
    return self
end

--- @shortDescription Checks if a child should be visible (overrides Container)
--- @param child table The child element to check
--- @return boolean Whether the child should be visible
--- @protected
function SideNav:isChildVisible(child)
    if not Container.isChildVisible(self, child) then
        return false
    end
    if child._tabId then
        return child._tabId == self.getResolved("activeTab")
    end
    return true
end

--- @shortDescription Gets the content area X offset (right of sidebar)
--- @return number xOffset The X offset for content
--- @protected
function SideNav:getContentXOffset()
    local metrics = self:_getSidebarMetrics()
    return metrics.sidebarWidth
end

function SideNav:_getSidebarMetrics()
    local tabs = self.getResolved("tabs") or {}
    local height = self.getResolved("height") or 1
    local sidebarWidth = self.getResolved("sidebarWidth") or 12
    local scrollOffset = self.getResolved("sidebarScrollOffset") or 0
    local sidebarPos = self.getResolved("sidebarPosition") or "left"

    local positions = {}
    local actualY = 1
    local totalHeight = #tabs

    for i, tab in ipairs(tabs) do
        local itemHeight = 1

        local visualY = actualY - scrollOffset
        local startClip = 0
        local endClip = 0

        if visualY < 1 then
            startClip = 1 - visualY
        end

        if visualY + itemHeight - 1 > height then
            endClip = (visualY + itemHeight - 1) - height
        end

        if visualY + itemHeight > 1 and visualY <= height then
            local displayY = math.max(1, visualY)
            local displayHeight = itemHeight - startClip - endClip

            table.insert(positions, {
                id = tab.id, 
                title = tab.title, 
                y1 = displayY,
                y2 = displayY + displayHeight - 1,
                height = itemHeight,
                displayHeight = displayHeight,
                actualY = actualY,
                startClip = startClip,
                endClip = endClip
            })
        end

        actualY = actualY + itemHeight
    end

    return {
        sidebarWidth = sidebarWidth,
        sidebarPosition = sidebarPos,
        positions = positions,
        totalHeight = totalHeight,
        scrollOffset = scrollOffset,
        maxScroll = math.max(0, totalHeight - height)
    }
end

--- @shortDescription Handles mouse click events for navigation item switching
--- @param button number The button that was clicked
--- @param x number The x position of the click (global)
--- @param y number The y position of the click (global)
--- @return boolean Whether the event was handled
--- @protected
function SideNav:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then
        return false
    end

    local baseRelX, baseRelY = VisualElement.getRelativePosition(self, x, y)
    local metrics = self:_getSidebarMetrics()
    local width = self.getResolved("width") or 1

    local inSidebar = false
    if metrics.sidebarPosition == "right" then
        inSidebar = baseRelX > (width - metrics.sidebarWidth)
    else
        inSidebar = baseRelX <= metrics.sidebarWidth
    end

    if inSidebar then
        if #metrics.positions == 0 then return true end
        for _, pos in ipairs(metrics.positions) do
            if baseRelY >= pos.y1 and baseRelY <= pos.y2 then
                self:setActiveTab(pos.id)
                self.set("focusedChild", nil)
                return true
            end
        end
        return true
    end
    return Container.mouse_click(self, button, x, y)
end

function SideNav:getRelativePosition(x, y)
    local metrics = self:_getSidebarMetrics()
    local width = self.getResolved("width") or 1

    if x == nil or y == nil then
        return VisualElement.getRelativePosition(self)
    else
        local rx, ry = VisualElement.getRelativePosition(self, x, y)
        if metrics.sidebarPosition == "right" then
            return rx, ry
        else
            return rx - metrics.sidebarWidth, ry
        end
    end
end

function SideNav:multiBlit(x, y, width, height, text, fg, bg)
    local metrics = self:_getSidebarMetrics()
    if metrics.sidebarPosition == "right" then
        return Container.multiBlit(self, x, y, width, height, text, fg, bg)
    else
        return Container.multiBlit(self, (x or 1) + metrics.sidebarWidth, y, width, height, text, fg, bg)
    end
end

function SideNav:textFg(x, y, text, fg)
    local metrics = self:_getSidebarMetrics()
    if metrics.sidebarPosition == "right" then
        return Container.textFg(self, x, y, text, fg)
    else
        return Container.textFg(self, (x or 1) + metrics.sidebarWidth, y, text, fg)
    end
end

function SideNav:textBg(x, y, text, bg)
    local metrics = self:_getSidebarMetrics()
    if metrics.sidebarPosition == "right" then
        return Container.textBg(self, x, y, text, bg)
    else
        return Container.textBg(self, (x or 1) + metrics.sidebarWidth, y, text, bg)
    end
end

function SideNav:drawText(x, y, text)
    local metrics = self:_getSidebarMetrics()
    if metrics.sidebarPosition == "right" then
        return Container.drawText(self, x, y, text)
    else
        return Container.drawText(self, (x or 1) + metrics.sidebarWidth, y, text)
    end
end

function SideNav:drawFg(x, y, fg)
    local metrics = self:_getSidebarMetrics()
    if metrics.sidebarPosition == "right" then
        return Container.drawFg(self, x, y, fg)
    else
        return Container.drawFg(self, (x or 1) + metrics.sidebarWidth, y, fg)
    end
end

function SideNav:drawBg(x, y, bg)
    local metrics = self:_getSidebarMetrics()
    if metrics.sidebarPosition == "right" then
        return Container.drawBg(self, x, y, bg)
    else
        return Container.drawBg(self, (x or 1) + metrics.sidebarWidth, y, bg)
    end
end

function SideNav:blit(x, y, text, fg, bg)
    local metrics = self:_getSidebarMetrics()
    if metrics.sidebarPosition == "right" then
        return Container.blit(self, x, y, text, fg, bg)
    else
        return Container.blit(self, (x or 1) + metrics.sidebarWidth, y, text, fg, bg)
    end
end

function SideNav:mouse_up(button, x, y)
    if not VisualElement.mouse_up(self, button, x, y) then
        return false
    end
    local baseRelX, baseRelY = VisualElement.getRelativePosition(self, x, y)
    local metrics = self:_getSidebarMetrics()
    local width = self.getResolved("width") or 1

    local inSidebar = false
    if metrics.sidebarPosition == "right" then
        inSidebar = baseRelX > (width - metrics.sidebarWidth)
    else
        inSidebar = baseRelX <= metrics.sidebarWidth
    end

    if inSidebar then
        return true
    end
    return Container.mouse_up(self, button, x, y)
end

function SideNav:mouse_release(button, x, y)
    VisualElement.mouse_release(self, button, x, y)
    local baseRelX, baseRelY = VisualElement.getRelativePosition(self, x, y)
    local metrics = self:_getSidebarMetrics()
    local width = self.getResolved("width") or 1

    local inSidebar = false
    if metrics.sidebarPosition == "right" then
        inSidebar = baseRelX > (width - metrics.sidebarWidth)
    else
        inSidebar = baseRelX <= metrics.sidebarWidth
    end

    if inSidebar then
        return
    end
    return Container.mouse_release(self, button, x, y)
end

function SideNav:mouse_move(_, x, y)
    if VisualElement.mouse_move(self, _, x, y) then
        local baseRelX, baseRelY = VisualElement.getRelativePosition(self, x, y)
        local metrics = self:_getSidebarMetrics()
        local width = self.getResolved("width") or 1

        local inSidebar = false
        if metrics.sidebarPosition == "right" then
            inSidebar = baseRelX > (width - metrics.sidebarWidth)
        else
            inSidebar = baseRelX <= metrics.sidebarWidth
        end

        if inSidebar then
            return true
        end
        local args = {self:getRelativePosition(x, y)}
        local success, child = self:callChildrenEvent(true, "mouse_move", table.unpack(args))
        if success then
            return true
        end
    end
    return false
end

function SideNav:mouse_drag(button, x, y)
    if VisualElement.mouse_drag(self, button, x, y) then
        local baseRelX, baseRelY = VisualElement.getRelativePosition(self, x, y)
        local metrics = self:_getSidebarMetrics()
        local width = self.getResolved("width") or 1

        local inSidebar = false
        if metrics.sidebarPosition == "right" then
            inSidebar = baseRelX > (width - metrics.sidebarWidth)
        else
            inSidebar = baseRelX <= metrics.sidebarWidth
        end

        if inSidebar then
            return true
        end
        return Container.mouse_drag(self, button, x, y)
    end
    return false
end

---Scrolls the sidebar up or down
--- @shortDescription Scrolls the sidebar up or down
--- @param direction number -1 to scroll up, 1 to scroll down
--- @return SideNav self For method chaining
function SideNav:scrollSidebar(direction)
    local metrics = self:_getSidebarMetrics()
    local currentOffset = self.getResolved("sidebarScrollOffset") or 0
    local maxScroll = metrics.maxScroll or 0

    local newOffset = currentOffset + (direction * 2)
    newOffset = math.max(0, math.min(maxScroll, newOffset))

    self.set("sidebarScrollOffset", newOffset)
    return self
end

function SideNav:mouse_scroll(direction, x, y)
    if VisualElement.mouse_scroll(self, direction, x, y) then
        local baseRelX, baseRelY = VisualElement.getRelativePosition(self, x, y)
        local metrics = self:_getSidebarMetrics()
        local width = self.getResolved("width") or 1

        local inSidebar = false
        if metrics.sidebarPosition == "right" then
            inSidebar = baseRelX > (width - metrics.sidebarWidth)
        else
            inSidebar = baseRelX <= metrics.sidebarWidth
        end

        if inSidebar then
            self:scrollSidebar(direction)
            return true
        end

        return Container.mouse_scroll(self, direction, x, y)
    end
    return false
end

--- @shortDescription Sets the cursor position; accounts for sidebar offset when delegating to parent
function SideNav:setCursor(x, y, blink, color)
    local metrics = self:_getSidebarMetrics()
    if self.parent then
        local xPos, yPos = self:calculatePosition()
        local targetX, targetY

        if metrics.sidebarPosition == "right" then
            targetX = x + xPos - 1
            targetY = y + yPos - 1
        else
            targetX = x + xPos - 1 + metrics.sidebarWidth
            targetY = y + yPos - 1
        end

        if(targetX < 1) or (targetX > self.parent.get("width")) or
           (targetY < 1) or (targetY > self.parent.get("height")) then
            return self.parent:setCursor(targetX, targetY, false)
        end
        return self.parent:setCursor(targetX, targetY, blink, color)
    end
    return self
end

--- @shortDescription Renders the SideNav (sidebar + children)
--- @protected
function SideNav:render()
    VisualElement.render(self)
    local height = self.getResolved("height")
    local foreground = self.getResolved("foreground")
    local sidebarBackground = self.getResolved("sidebarBackground")
    local metrics = self:_getSidebarMetrics()
    local sidebarW = metrics.sidebarWidth or 12

    for y = 1, height do
        VisualElement.multiBlit(self, 1, y, sidebarW, 1, " ", tHex[foreground], tHex[sidebarBackground])
    end

    local activeTab = self.getResolved("activeTab")

    for _, pos in ipairs(metrics.positions) do
        local bgColor = (pos.id == activeTab) and self.getResolved("activeTabBackground") or sidebarBackground
        local fgColor = (pos.id == activeTab) and self.getResolved("activeTabTextColor") or foreground

        local itemHeight = pos.displayHeight or (pos.y2 - pos.y1 + 1)
        for dy = 0, itemHeight - 1 do
            VisualElement.multiBlit(self, 1, pos.y1 + dy, sidebarW, 1, " ", tHex[foreground], tHex[bgColor])
        end

        local displayTitle = pos.title
        if #displayTitle > sidebarW - 2 then
            displayTitle = displayTitle:sub(1, sidebarW - 2)
        end

        VisualElement.textFg(self, 2, pos.y1, displayTitle, fgColor)
    end

    if not self.getResolved("childrenSorted") then
        self:sortChildren()
    end
    if not self.getResolved("childrenEventsSorted") then
        for eventName in pairs(self._values.childrenEvents or {}) do
            self:sortChildrenEvents(eventName)
        end
    end

    for _, child in ipairs(self.getResolved("visibleChildren") or {}) do
        if child == self then error("CIRCULAR REFERENCE DETECTED!") return end
        child:render()
        child:postRender()
    end
end

--- @protected
function SideNav:sortChildrenEvents(eventName)
    local childrenEvents = self._values.childrenEvents and self._values.childrenEvents[eventName]
    if childrenEvents then
        local visibleChildrenEvents = {}
        for _, child in ipairs(childrenEvents) do
            if self:isChildVisible(child) then
                table.insert(visibleChildrenEvents, child)
            end
        end

        for i = 2, #visibleChildrenEvents do
            local current = visibleChildrenEvents[i]
            local currentZ = current.get("z")
            local j = i - 1
            while j > 0 do
                local compare = visibleChildrenEvents[j].get("z")
                if compare > currentZ then
                    visibleChildrenEvents[j + 1] = visibleChildrenEvents[j]
                    j = j - 1
                else
                    break
                end
            end
            visibleChildrenEvents[j + 1] = current
        end

        self._values.visibleChildrenEvents = self._values.visibleChildrenEvents or {}
        self._values.visibleChildrenEvents[eventName] = visibleChildrenEvents
    end
    self.set("childrenEventsSorted", true)
    return self
end

return SideNav
local elementManager = require("elementManager")
local VisualElement = require("elements/VisualElement")
local Container = elementManager.getElement("Container")
local tHex = require("libraries/colorHex")
local log = require("log")
---@configDescription A TabControl element that provides tabbed interface with multiple content areas.

--- The TabControl is a container that provides tabbed interface functionality
--- @run [[
--- local basalt = require("basalt")

--- local main = basalt.getMainFrame()
--- 
--- -- Create a simple TabControl
--- local tabControl = main:addTabControl({
---     x = 2,
---     y = 2,
---     width = 46,
---     height = 15,
--- })
--- 
--- -- Tab 1: Home
--- local homeTab = tabControl:newTab("Home")
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
---     text = "This is a TabControl",
---     foreground = colors.white
--- })
--- 
--- homeTab:addLabel({
---     x = 2,
---     y = 5,
---     text = "example with tabs.",
---     foreground = colors.white
--- })
--- 
--- -- Tab 2: Counter
--- local counterTab = tabControl:newTab("Counter")
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
--- local infoTab = tabControl:newTab("Info")
--- 
--- infoTab:addLabel({
---     x = 2,
---     y = 2,
---     text = "TabControl Features:",
---     foreground = colors.orange
--- })
--- 
--- infoTab:addLabel({
---     x = 2,
---     y = 4,
---     text = "- Horizontal tabs",
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
---@class TabControl : Container
local TabControl = setmetatable({}, Container)
TabControl.__index = TabControl

---@property activeTab number nil The currently active tab ID
TabControl.defineProperty(TabControl, "activeTab", {default = nil, type = "number", allowNil = true, canTriggerRender = true, setter = function(self, value)
    return value
end})
---@property tabHeight number 1 Height of the tab header area
TabControl.defineProperty(TabControl, "tabHeight", {default = 1, type = "number", canTriggerRender = true})
---@property tabs table {} List of tab definitions
TabControl.defineProperty(TabControl, "tabs", {default = {}, type = "table"})

---@property headerBackground color gray Background color for the tab header area
TabControl.defineProperty(TabControl, "headerBackground", {default = colors.gray, type = "color", canTriggerRender = true})
---@property activeTabBackground color white Background color for the active tab
TabControl.defineProperty(TabControl, "activeTabBackground", {default = colors.white, type = "color", canTriggerRender = true})
---@property activeTabTextColor color black Foreground color for the active tab text
TabControl.defineProperty(TabControl, "activeTabTextColor", {default = colors.black, type = "color", canTriggerRender = true})
---@property scrollableTab boolean false Enables scroll mode for tabs if they exceed width
TabControl.defineProperty(TabControl, "scrollableTab", {default = false, type = "boolean", canTriggerRender = true})
---@property tabScrollOffset number 0 Current scroll offset for tabs in scrollable mode
TabControl.defineProperty(TabControl, "tabScrollOffset", {default = 0, type = "number", canTriggerRender = true})

TabControl.defineEvent(TabControl, "mouse_click")
TabControl.defineEvent(TabControl, "mouse_up")
TabControl.defineEvent(TabControl, "mouse_scroll")

--- @shortDescription Creates a new TabControl instance
--- @return TabControl self The created instance
--- @private
function TabControl.new()
    local self = setmetatable({}, TabControl):__init()
    self.class = TabControl
    self.set("width", 20)
    self.set("height", 10)
    self.set("z", 10)
    return self
end

--- @shortDescription Initializes the TabControl instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @protected
function TabControl:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "TabControl")
end

--- returns a proxy for adding elements to the tab
--- @shortDescription Creates a new tab handler proxy
--- @param title string The title of the tab
--- @return table tabHandler The tab handler proxy for adding elements to the new tab
function TabControl:newTab(title)
    local tabs = self.get("tabs") or {}
    local tabId = #tabs + 1

    table.insert(tabs, {
        id = tabId,
        title = tostring(title or ("Tab " .. tabId))
    })

    self.set("tabs", tabs)

    if not self.get("activeTab") then
        self.set("activeTab", tabId)
    end
    self:updateTabVisibility()

    local tabControl = self
    local proxy = {}
    setmetatable(proxy, {
        __index = function(_, key)
            if type(key) == "string" and key:sub(1,3) == "add" and type(tabControl[key]) == "function" then
                return function(_, ...)
                    local el = tabControl[key](tabControl, ...)
                    if el then
                        el._tabId = tabId
                        tabControl.set("childrenSorted", false)
                        tabControl.set("childrenEventsSorted", false)
                        tabControl:updateRender()
                    end
                    return el
                end
            end
            local v = tabControl[key]
            if type(v) == "function" then
                return function(_, ...)
                    return v(tabControl, ...)
                end
            end
            return v
        end
    })

    return proxy
end
TabControl.addTab = TabControl.newTab

--- @shortDescription Sets an element to belong to a specific tab
--- @param element table The element to assign to a tab
--- @param tabId number The ID of the tab to assign the element to
--- @return TabControl self For method chaining
function TabControl:setTab(element, tabId)
    element._tabId = tabId
    self:updateTabVisibility()
    return self
end

--- @shortDescription Adds an element to the TabControl and assigns it to the active tab
--- @param elementType string The type of element to add
--- @param tabId number Optional tab ID, defaults to active tab
--- @return table element The created element
function TabControl:addElement(elementType, tabId)
    local element = Container.addElement(self, elementType)
    local targetTab = tabId or self.get("activeTab")
    if targetTab then
        element._tabId = targetTab
    self:updateTabVisibility()
    end
    return element
end

--- @shortDescription Overrides Container's addChild to assign new elements to tab 1 by default
--- @param child table The child element to add
--- @return Container self For method chaining
--- @protected
function TabControl:addChild(child)
    Container.addChild(self, child)
    if not child._tabId then
        local tabs = self.get("tabs") or {}
        if #tabs > 0 then
            child._tabId = 1
            self:updateTabVisibility()
        end
    end
    return self
end

--- @shortDescription Updates visibility of tab containers
--- @private
function TabControl:updateTabVisibility()
    self.set("childrenSorted", false)
    self.set("childrenEventsSorted", false)
end

--- @shortDescription Sets the active tab
--- @param tabId number The ID of the tab to activate
function TabControl:setActiveTab(tabId)
    local oldTab = self.get("activeTab")
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
function TabControl:isChildVisible(child)
    if not Container.isChildVisible(self, child) then
        return false
    end
    if child._tabId then
        return child._tabId == self.get("activeTab")
    end
    return true
end

--- @shortDescription Gets the content area Y offset (below tab headers)
--- @return number yOffset The Y offset for content
--- @protected
function TabControl:getContentYOffset()
    local metrics = self:_getHeaderMetrics()
    return metrics.headerHeight
end

function TabControl:_getHeaderMetrics()
    local tabs = self.get("tabs") or {}
    local width = self.get("width") or 1
    local minTabH = self.get("tabHeight") or 1
    local scrollable = self.get("scrollableTab")

    local positions = {}

    if scrollable then
        local scrollOffset = self.get("tabScrollOffset") or 0
        local actualX = 1
        local totalWidth = 0

        for i, tab in ipairs(tabs) do
            local tabWidth = #tab.title + 2
            if tabWidth > width then
                tabWidth = width
            end

            local visualX = actualX - scrollOffset
            local startClip = 0
            local endClip = 0

            if visualX < 1 then
                startClip = 1 - visualX
            end

            if visualX + tabWidth - 1 > width then
                endClip = (visualX + tabWidth - 1) - width
            end

            if visualX + tabWidth > 1 and visualX <= width then
                local displayX = math.max(1, visualX)
                local displayWidth = tabWidth - startClip - endClip

                table.insert(positions, {
                    id = tab.id, 
                    title = tab.title, 
                    line = 1, 
                    x1 = displayX,
                    x2 = displayX + displayWidth - 1,
                    width = tabWidth,
                    displayWidth = displayWidth,
                    actualX = actualX,
                    startClip = startClip,
                    endClip = endClip
                })
            end

            actualX = actualX + tabWidth
        end

        totalWidth = actualX - 1

        return {
            headerHeight = 1, 
            lines = 1, 
            positions = positions,
            totalWidth = totalWidth,
            scrollOffset = scrollOffset,
            maxScroll = math.max(0, totalWidth - width)
        }
    else
        local line = 1
        local cursorX = 1

        for i, tab in ipairs(tabs) do
            local tabWidth = #tab.title + 2
            if tabWidth > width then
                tabWidth = width
            end
            if cursorX + tabWidth - 1 > width then
                line = line + 1
                cursorX = 1
            end
            table.insert(positions, {
                id = tab.id, 
                title = tab.title, 
                line = line, 
                x1 = cursorX, 
                x2 = cursorX + tabWidth - 1,
                width = tabWidth
            })
            cursorX = cursorX + tabWidth
        end

        local computedLines = line
        local headerHeight = math.max(minTabH, computedLines)
        return {headerHeight = headerHeight, lines = computedLines, positions = positions}
    end
end


--- @shortDescription Handles mouse click events for tab switching
--- @param button number The button that was clicked
--- @param x number The x position of the click (global)
--- @param y number The y position of the click (global)
--- @return boolean Whether the event was handled
--- @protected
function TabControl:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then
        return false
    end

    local baseRelX, baseRelY = VisualElement.getRelativePosition(self, x, y)
    local metrics = self:_getHeaderMetrics()
    if baseRelY <= metrics.headerHeight then
        if #metrics.positions == 0 then return true end
        for _, pos in ipairs(metrics.positions) do
            if pos.line == baseRelY and baseRelX >= pos.x1 and baseRelX <= pos.x2 then
                self:setActiveTab(pos.id)
                self.set("focusedChild", nil)
                return true
            end
        end
        return true
    end
    return Container.mouse_click(self, button, x, y)
end

function TabControl:getRelativePosition(x, y)
    local headerH = self:_getHeaderMetrics().headerHeight
    if x == nil or y == nil then
    return VisualElement.getRelativePosition(self)
    else
        local rx, ry = VisualElement.getRelativePosition(self, x, y)
        return rx, ry - headerH
    end
end

function TabControl:multiBlit(x, y, width, height, text, fg, bg)
    local headerH = self:_getHeaderMetrics().headerHeight
    return Container.multiBlit(self, x, (y or 1) + headerH, width, height, text, fg, bg)
end

function TabControl:textFg(x, y, text, fg)
    local headerH = self:_getHeaderMetrics().headerHeight
    return Container.textFg(self, x, (y or 1) + headerH, text, fg)
end

function TabControl:textBg(x, y, text, bg)
    local headerH = self:_getHeaderMetrics().headerHeight
    return Container.textBg(self, x, (y or 1) + headerH, text, bg)
end

function TabControl:drawText(x, y, text)
    local headerH = self:_getHeaderMetrics().headerHeight
    return Container.drawText(self, x, (y or 1) + headerH, text)
end

function TabControl:drawFg(x, y, fg)
    local headerH = self:_getHeaderMetrics().headerHeight
    return Container.drawFg(self, x, (y or 1) + headerH, fg)
end

function TabControl:drawBg(x, y, bg)
    local headerH = self:_getHeaderMetrics().headerHeight
    return Container.drawBg(self, x, (y or 1) + headerH, bg)
end

function TabControl:blit(x, y, text, fg, bg)
    local headerH = self:_getHeaderMetrics().headerHeight
    return Container.blit(self, x, (y or 1) + headerH, text, fg, bg)
end

function TabControl:mouse_up(button, x, y)
    if not VisualElement.mouse_up(self, button, x, y) then
        return false
    end
    local baseRelX, baseRelY = VisualElement.getRelativePosition(self, x, y)
    local headerH = self:_getHeaderMetrics().headerHeight
    if baseRelY <= headerH then
        return true
    end
    return Container.mouse_up(self, button, x, y)
end

function TabControl:mouse_release(button, x, y)
    VisualElement.mouse_release(self, button, x, y)
    local baseRelX, baseRelY = VisualElement.getRelativePosition(self, x, y)
    local headerH = self:_getHeaderMetrics().headerHeight
    if baseRelY <= headerH then
        return
    end
    return Container.mouse_release(self, button, x, y)
end

function TabControl:mouse_move(_, x, y)
    if VisualElement.mouse_move(self, _, x, y) then
        local baseRelX, baseRelY = VisualElement.getRelativePosition(self, x, y)
    local headerH = self:_getHeaderMetrics().headerHeight
    if baseRelY <= headerH then
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

function TabControl:mouse_drag(button, x, y)
    if VisualElement.mouse_drag(self, button, x, y) then
        local baseRelX, baseRelY = VisualElement.getRelativePosition(self, x, y)
    local headerH = self:_getHeaderMetrics().headerHeight
    if baseRelY <= headerH then
            return true
        end
        return Container.mouse_drag(self, button, x, y)
    end
    return false
end

---Scrolls the tab header left or right if scrollableTab is enabled
--- @shortDescription Scrolls the tab header left or right if scrollableTab is enabled
--- @param direction number -1 to scroll left, 1 to scroll right
--- @return TabControl self For method chaining
function TabControl:scrollTabs(direction)
    if not self.get("scrollableTab") then return self end

    local metrics = self:_getHeaderMetrics()
    local currentOffset = self.get("tabScrollOffset") or 0
    local maxScroll = metrics.maxScroll or 0

    local newOffset = currentOffset + (direction * 5)
    newOffset = math.max(0, math.min(maxScroll, newOffset))

    self.set("tabScrollOffset", newOffset)
    return self
end

function TabControl:mouse_scroll(direction, x, y)
    if VisualElement.mouse_scroll(self, direction, x, y) then
        local headerH = self:_getHeaderMetrics().headerHeight

        if self.get("scrollableTab") and y == self.get("y") then
            self:scrollTabs(direction)
            return true
        end

        return Container.mouse_scroll(self, direction, x, y)
    end
    return false
end


--- @shortDescription Sets the cursor position; accounts for tab header offset when delegating to parent
function TabControl:setCursor(x, y, blink, color)
    local tabH = self:_getHeaderMetrics().headerHeight
    if self.parent then
        local xPos, yPos = self:calculatePosition()
        local targetX = x + xPos - 1
        local targetY = y + yPos - 1 + tabH

        if(targetX < 1) or (targetX > self.parent.get("width")) or
           (targetY < 1) or (targetY > self.parent.get("height")) then
            return self.parent:setCursor(targetX, targetY, false)
        end
        return self.parent:setCursor(targetX, targetY, blink, color)
    end
    return self
end

--- @shortDescription Renders the TabControl (header + children)
--- @protected
function TabControl:render()
    VisualElement.render(self)
    local width = self.get("width")
    local metrics = self:_getHeaderMetrics()
    local headerH = metrics.headerHeight or 1

    VisualElement.multiBlit(self, 1, 1, width, headerH, " ", tHex[self.get("foreground")], tHex[self.get("headerBackground")])
    local activeTab = self.get("activeTab")

    for _, pos in ipairs(metrics.positions) do
        local bgColor = (pos.id == activeTab) and self.get("activeTabBackground") or self.get("headerBackground")
        local fgColor = (pos.id == activeTab) and self.get("activeTabTextColor") or self.get("foreground")

        VisualElement.multiBlit(self, pos.x1, pos.line, pos.displayWidth or (pos.x2 - pos.x1 + 1), 1, " ", tHex[self.get("foreground")], tHex[bgColor])

        local displayTitle = pos.title
        local textStartInTitle = 1 + (pos.startClip or 0)
        local textLength = #pos.title - (pos.startClip or 0) - (pos.endClip or 0)

        if textLength > 0 then
            displayTitle = pos.title:sub(textStartInTitle, textStartInTitle + textLength - 1)
            local textX = pos.x1
            if (pos.startClip or 0) == 0 then
                textX = textX + 1
            end
            VisualElement.textFg(self, textX, pos.line, displayTitle, fgColor)
        end
    end

    if not self.get("childrenSorted") then
        self:sortChildren()
    end
    if not self.get("childrenEventsSorted") then
        for eventName in pairs(self._values.childrenEvents or {}) do
            self:sortChildrenEvents(eventName)
        end
    end

    for _, child in ipairs(self.get("visibleChildren") or {}) do
        if child == self then error("CIRCULAR REFERENCE DETECTED!") return end
        child:render()
        child:postRender()
    end
end

--- @protected
function TabControl:sortChildrenEvents(eventName)
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

return TabControl
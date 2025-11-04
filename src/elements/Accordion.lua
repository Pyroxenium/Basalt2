local elementManager = require("elementManager")
local VisualElement = require("elements/VisualElement")
local Container = elementManager.getElement("Container")
local tHex = require("libraries/colorHex")
---@configDescription An Accordion element that provides collapsible panels with headers.
---@configDefault false

--- The Accordion is a container that provides collapsible panel functionality
--- @run [[
--- local basalt = require("basalt")
--- 
--- local main = basalt.getMainFrame()
--- 
--- -- Create an Accordion
--- local accordion = main:addAccordion({
---     x = 2,
---     y = 2,
---     width = 30,
---     height = 15,
---     allowMultiple = true, -- Only one panel open at a time
---     headerBackground = colors.gray,
---     headerTextColor = colors.white,
---     expandedHeaderBackground = colors.lightBlue,
---     expandedHeaderTextColor = colors.white,
--- })
--- 
--- -- Panel 1: Info
--- local infoPanel = accordion:newPanel("Information", true) -- starts expanded
--- infoPanel:addLabel({
---     x = 2,
---     y = 1,
---     text = "This is an accordion",
---     foreground = colors.yellow
--- })
--- infoPanel:addLabel({
---     x = 2,
---     y = 2,
---     text = "with collapsible panels.",
---     foreground = colors.white
--- })
--- 
--- -- Panel 2: Settings
--- local settingsPanel = accordion:newPanel("Settings", false)
--- settingsPanel:addLabel({
---     x = 2,
---     y = 1,
---     text = "Volume:",
---     foreground = colors.white
--- })
--- local volumeSlider = settingsPanel:addSlider({
---     x = 10,
---     y = 1,
---     width = 15,
---     value = 50
--- })
--- settingsPanel:addLabel({
---     x = 2,
---     y = 3,
---     text = "Auto-save:",
---     foreground = colors.white
--- })
--- settingsPanel:addSwitch({
---     x = 13,
---     y = 3,
--- })
--- 
--- -- Panel 3: Actions
--- local actionsPanel = accordion:newPanel("Actions", false)
--- local statusLabel = actionsPanel:addLabel({
---     x = 2,
---     y = 4,
---     text = "Ready",
---     foreground = colors.lime
--- })
--- 
--- actionsPanel:addButton({
---     x = 2,
---     y = 1,
---     width = 10,
---     height = 1,
---     text = "Save",
---     background = colors.green,
---     foreground = colors.white,
--- })
--- 
--- actionsPanel:addButton({
---     x = 14,
---     y = 1,
---     width = 10,
---     height = 1,
---     text = "Cancel",
---     background = colors.red,
---     foreground = colors.white,
--- })
--- 
--- -- Panel 4: About
--- local aboutPanel = accordion:newPanel("About", false)
--- aboutPanel:addLabel({
---     x = 2,
---     y = 1,
---     text = "Basalt Accordion v1.0",
---     foreground = colors.white
--- })
--- aboutPanel:addLabel({
---     x = 2,
---     y = 2,
---     text = "A collapsible panel",
---     foreground = colors.gray
--- })
--- aboutPanel:addLabel({
---     x = 2,
---     y = 3,
---     text = "component for UI.",
---     foreground = colors.gray
--- })
--- 
--- -- Instructions
--- main:addLabel({
---     x = 2,
---     y = 18,
---     text = "Click panel headers to expand/collapse",
---     foreground = colors.lightGray
--- })
--- 
--- basalt.run()
--- ]]
---@class Accordion : Container
local Accordion = setmetatable({}, Container)
Accordion.__index = Accordion

---@property panels table {} List of panel definitions
Accordion.defineProperty(Accordion, "panels", {default = {}, type = "table"})
---@property panelHeaderHeight number 1 Height of each panel header
Accordion.defineProperty(Accordion, "panelHeaderHeight", {default = 1, type = "number", canTriggerRender = true})
---@property allowMultiple boolean false Allow multiple panels to be open at once
Accordion.defineProperty(Accordion, "allowMultiple", {default = false, type = "boolean"})

---@property headerBackground color gray Background color for panel headers
Accordion.defineProperty(Accordion, "headerBackground", {default = colors.gray, type = "color", canTriggerRender = true})
---@property headerTextColor color white Text color for panel headers
Accordion.defineProperty(Accordion, "headerTextColor", {default = colors.white, type = "color", canTriggerRender = true})
---@property expandedHeaderBackground color lightGray Background color for expanded panel headers
Accordion.defineProperty(Accordion, "expandedHeaderBackground", {default = colors.lightGray, type = "color", canTriggerRender = true})
---@property expandedHeaderTextColor color black Text color for expanded panel headers
Accordion.defineProperty(Accordion, "expandedHeaderTextColor", {default = colors.black, type = "color", canTriggerRender = true})

Accordion.defineEvent(Accordion, "mouse_click")
Accordion.defineEvent(Accordion, "mouse_up")

--- @shortDescription Creates a new Accordion instance
--- @return Accordion self The created instance
--- @private
function Accordion.new()
    local self = setmetatable({}, Accordion):__init()
    self.class = Accordion
    self.set("width", 20)
    self.set("height", 10)
    self.set("z", 10)
    return self
end

--- @shortDescription Initializes the Accordion instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @protected
function Accordion:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "Accordion")
end

--- Creates a new panel and returns the panel's container
--- @shortDescription Creates a new accordion panel
--- @param title string The title of the panel
--- @param expanded boolean Whether the panel starts expanded (default: false)
--- @return table panelContainer The container for this panel
function Accordion:newPanel(title, expanded)
    local panels = self.get("panels") or {}
    local panelId = #panels + 1

    local panelContainer = self:addContainer()
    panelContainer.set("x", 1)
    panelContainer.set("y", 1)
    panelContainer.set("width", self.get("width"))
    panelContainer.set("height", self.get("height"))
    panelContainer.set("visible", expanded or false)
    panelContainer.set("ignoreOffset", true)

    table.insert(panels, {
        id = panelId,
        title = tostring(title or ("Panel " .. panelId)),
        expanded = expanded or false,
        container = panelContainer
    })

    self.set("panels", panels)
    self:updatePanelLayout()

    return panelContainer
end
Accordion.addPanel = Accordion.newPanel

--- @shortDescription Updates the layout of all panels (positions and visibility)
--- @private
function Accordion:updatePanelLayout()
    local panels = self.get("panels") or {}
    local headerHeight = self.get("panelHeaderHeight") or 1
    local currentY = 1
    local width = self.get("width")
    local accordionHeight = self.get("height")

    for _, panel in ipairs(panels) do
        local contentY = currentY + headerHeight

        panel.container.set("x", 1)
        panel.container.set("y", contentY)
        panel.container.set("width", width)
        panel.container.set("visible", panel.expanded)
        panel.container.set("ignoreOffset", false)

        currentY = currentY + headerHeight
        if panel.expanded then
            local maxY = 0
            for _, child in ipairs(panel.container._values.children or {}) do
                if not child._destroyed then
                    local childY = child.get("y")
                    local childH = child.get("height")
                    local childBottom = childY + childH - 1
                    if childBottom > maxY then
                        maxY = childBottom
                    end
                end
            end
            local contentHeight = math.max(1, maxY)
            panel.container.set("height", contentHeight)
            currentY = currentY + contentHeight
        end
    end

    local totalHeight = currentY - 1
    local maxOffset = math.max(0, totalHeight - accordionHeight)
    local currentOffset = self.get("offsetY")

    if currentOffset > maxOffset then
        self.set("offsetY", maxOffset)
    end

    self:updateRender()
end

--- @shortDescription Toggles a panel's expanded state
--- @param panelId number The ID of the panel to toggle
--- @return Accordion self For method chaining
function Accordion:togglePanel(panelId)
    local panels = self.get("panels") or {}
    local allowMultiple = self.get("allowMultiple")

    for i, panel in ipairs(panels) do
        if panel.id == panelId then
            panel.expanded = not panel.expanded

            if not allowMultiple and panel.expanded then
                for j, otherPanel in ipairs(panels) do
                    if j ~= i then
                        otherPanel.expanded = false
                    end
                end
            end

            self:updatePanelLayout()
            self:dispatchEvent("panelToggled", panelId, panel.expanded)
            break
        end
    end

    return self
end

--- @shortDescription Expands a specific panel
--- @param panelId number The ID of the panel to expand
--- @return Accordion self For method chaining
function Accordion:expandPanel(panelId)
    local panels = self.get("panels") or {}
    local allowMultiple = self.get("allowMultiple")

    for i, panel in ipairs(panels) do
        if panel.id == panelId then
            if not panel.expanded then
                panel.expanded = true

                if not allowMultiple then
                    for j, otherPanel in ipairs(panels) do
                        if j ~= i then
                            otherPanel.expanded = false
                        end
                    end
                end

                self:updatePanelLayout()
                self:dispatchEvent("panelToggled", panelId, true)
            end
            break
        end
    end

    return self
end

--- @shortDescription Collapses a specific panel
--- @param panelId number The ID of the panel to collapse
--- @return Accordion self For method chaining
function Accordion:collapsePanel(panelId)
    local panels = self.get("panels") or {}

    for _, panel in ipairs(panels) do
        if panel.id == panelId then
            if panel.expanded then
                panel.expanded = false
                self:updatePanelLayout()
                self:dispatchEvent("panelToggled", panelId, false)
            end
            break
        end
    end

    return self
end

--- @shortDescription Gets a panel container by ID
--- @param panelId number The ID of the panel
--- @return table? container The panel's container or nil
function Accordion:getPanel(panelId)
    local panels = self.get("panels") or {}
    for _, panel in ipairs(panels) do
        if panel.id == panelId then
            return panel.container
        end
    end
    return nil
end

--- @shortDescription Calculates panel header positions for rendering
--- @return table metrics Panel layout information
--- @private
function Accordion:_getPanelMetrics()
    local panels = self.get("panels") or {}
    local headerHeight = self.get("panelHeaderHeight") or 1

    local positions = {}
    local currentY = 1

    for _, panel in ipairs(panels) do
        table.insert(positions, {
            id = panel.id,
            title = panel.title,
            expanded = panel.expanded,
            headerY = currentY,
            headerHeight = headerHeight
        })

        currentY = currentY + headerHeight
        if panel.expanded then
            currentY = currentY + panel.container.get("height")
        end
    end

    return {
        positions = positions,
        totalHeight = currentY - 1
    }
end

--- @shortDescription Handles mouse click events for panel toggling
--- @param button number The button that was clicked
--- @param x number The x position of the click (global)
--- @param y number The y position of the click (global)
--- @return boolean Whether the event was handled
--- @protected
function Accordion:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then
        return false
    end

    local relX, relY = VisualElement.getRelativePosition(self, x, y)
    local offsetY = self.get("offsetY")
    local adjustedY = relY + offsetY
    local metrics = self:_getPanelMetrics()

    for _, panelInfo in ipairs(metrics.positions) do
        local headerEndY = panelInfo.headerY + panelInfo.headerHeight - 1
        if adjustedY >= panelInfo.headerY and adjustedY <= headerEndY then
            self:togglePanel(panelInfo.id)
            self.set("focusedChild", nil)
            return true
        end
    end

    return Container.mouse_click(self, button, x, y)
end

function Accordion:mouse_scroll(direction, x, y)
    if VisualElement.mouse_scroll(self, direction, x, y) then
        local metrics = self:_getPanelMetrics()
        local accordionHeight = self.get("height")
        local totalHeight = metrics.totalHeight
        local maxOffset = math.max(0, totalHeight - accordionHeight)

        if maxOffset > 0 then
            local currentOffset = self.get("offsetY")
            local newOffset = currentOffset + direction
            newOffset = math.max(0, math.min(maxOffset, newOffset))
            self.set("offsetY", newOffset)
            return true
        end

        return Container.mouse_scroll(self, direction, x, y)
    end
    return false
end

--- @shortDescription Renders the Accordion (headers + panel containers)
--- @protected
function Accordion:render()
    VisualElement.render(self)

    local width = self.get("width")
    local offsetY = self.get("offsetY")
    local metrics = self:_getPanelMetrics()

    for _, panelInfo in ipairs(metrics.positions) do
        local bgColor = panelInfo.expanded and self.get("expandedHeaderBackground") or self.get("headerBackground")
        local fgColor = panelInfo.expanded and self.get("expandedHeaderTextColor") or self.get("headerTextColor")

        local headerY = panelInfo.headerY - offsetY

        if headerY >= 1 and headerY <= self.get("height") then
            VisualElement.multiBlit(
                self, 
                1, 
                headerY, 
                width, 
                panelInfo.headerHeight, 
                " ", 
                tHex[fgColor], 
                tHex[bgColor]
            )

            local indicator = panelInfo.expanded and "v" or ">"
            local headerText = indicator .. " " .. panelInfo.title
            VisualElement.textFg(self, 1, headerY, headerText, fgColor)
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
        if child == self then 
            error("CIRCULAR REFERENCE DETECTED!")
            return 
        end
        child:render()
        child:postRender()
    end
end

return Accordion
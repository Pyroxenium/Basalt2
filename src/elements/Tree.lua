local VisualElement = require("elements/VisualElement")
local sub = string.sub
local tHex = require("libraries/colorHex")
---@cofnigDescription The tree element provides a hierarchical view of nodes that can be expanded and collapsed, with support for selection and scrolling.

local function flattenTree(nodes, expandedNodes, level, result)
    result = result or {}
    level = level or 0

    for _, node in ipairs(nodes) do
        table.insert(result, {node = node, level = level})
        if expandedNodes[node] and node.children then
            flattenTree(node.children, expandedNodes, level + 1, result)
        end
    end
    return result
end

--- This is the tree class. It provides a hierarchical view of nodes that can be expanded and collapsed,
--- with support for selection and scrolling.
---@class Tree : VisualElement
local Tree = setmetatable({}, VisualElement)
Tree.__index = Tree

---@property nodes table {} The tree structure containing node objects with {text, children} properties
Tree.defineProperty(Tree, "nodes", {default = {}, type = "table", canTriggerRender = true, setter = function(self, value)
    if #value > 0 then
        self.get("expandedNodes")[value[1]] = true
    end
    return value
end})
---@property selectedNode table? nil Currently selected node
Tree.defineProperty(Tree, "selectedNode", {default = nil, type = "table", canTriggerRender = true})
---@property expandedNodes table {} Table of nodes that are currently expanded
Tree.defineProperty(Tree, "expandedNodes", {default = {}, type = "table", canTriggerRender = true})
---@property offset number 0 Current vertical scroll position
Tree.defineProperty(Tree, "offset", {
    default = 0,
    type = "number",
    canTriggerRender = true,
    setter = function(self, value)
        return math.max(0, value)
    end
})
---@property horizontalOffset number 0 Current horizontal scroll position
Tree.defineProperty(Tree, "horizontalOffset", {
    default = 0,
    type = "number",
    canTriggerRender = true,
    setter = function(self, value)
        return math.max(0, value)
    end
})
---@property selectedForegroundColor color white foreground color of selected node
Tree.defineProperty(Tree, "selectedForegroundColor", {default = colors.white, type = "color"})
---@property selectedBackgroundColor color lightBlue background color of selected node
Tree.defineProperty(Tree, "selectedBackgroundColor", {default = colors.lightBlue, type = "color"})

---@property showScrollBar boolean true Whether to show the scrollbar when nodes exceed height
Tree.defineProperty(Tree, "showScrollBar", {default = true, type = "boolean", canTriggerRender = true})

---@property scrollBarSymbol string " " Symbol used for the scrollbar handle
Tree.defineProperty(Tree, "scrollBarSymbol", {default = " ", type = "string", canTriggerRender = true})

---@property scrollBarBackground string "\127" Symbol used for the scrollbar background
Tree.defineProperty(Tree, "scrollBarBackground", {default = "\127", type = "string", canTriggerRender = true})

---@property scrollBarColor color lightGray Color of the scrollbar handle
Tree.defineProperty(Tree, "scrollBarColor", {default = colors.lightGray, type = "color", canTriggerRender = true})

---@property scrollBarBackgroundColor color gray Background color of the scrollbar
Tree.defineProperty(Tree, "scrollBarBackgroundColor", {default = colors.gray, type = "color", canTriggerRender = true})

Tree.defineEvent(Tree, "mouse_click")
Tree.defineEvent(Tree, "mouse_drag")
Tree.defineEvent(Tree, "mouse_up")
Tree.defineEvent(Tree, "mouse_scroll")

--- Creates a new Tree instance
--- @shortDescription Creates a new Tree instance
--- @return Tree self The newly created Tree instance
--- @private
function Tree.new()
    local self = setmetatable({}, Tree):__init()
    self.class = Tree
    self.set("width", 30)
    self.set("height", 10)
    self.set("z", 5)
    return self
end

--- Initializes the Tree instance
--- @shortDescription Initializes the Tree instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Tree self The initialized instance
--- @protected
function Tree:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Tree")
    return self
end

--- Expands a node
--- @shortDescription Expands a node to show its children
--- @param node table The node to expand
--- @return Tree self The Tree instance
function Tree:expandNode(node)
    self.get("expandedNodes")[node] = true
    self:updateRender()
    return self
end

--- Collapses a node
--- @shortDescription Collapses a node to hide its children
--- @param node table The node to collapse
--- @return Tree self The Tree instance
function Tree:collapseNode(node)
    self.get("expandedNodes")[node] = nil
    self:updateRender()
    return self
end

--- Toggles a node's expanded state
--- @shortDescription Toggles between expanded and collapsed state
--- @param node table The node to toggle
--- @return Tree self The Tree instance
function Tree:toggleNode(node)
    if self.get("expandedNodes")[node] then
        self:collapseNode(node)
    else
        self:expandNode(node)
    end
    return self
end

--- Handles mouse click events
--- @shortDescription Handles mouse click events for node selection and expansion
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function Tree:mouse_click(button, x, y)
    if VisualElement.mouse_click(self, button, x, y) then
        local relX, relY = self:getRelativePosition(x, y)
        local width = self.get("width")
        local height = self.get("height")
        local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
        local showScrollBar = self.get("showScrollBar")
        local maxContentWidth, _ = self:getNodeSize()
        local needsHorizontalScrollBar = showScrollBar and maxContentWidth > width
        local contentHeight = needsHorizontalScrollBar and height - 1 or height
        local needsVerticalScrollBar = showScrollBar and #flatNodes > contentHeight

        if needsVerticalScrollBar and relX == width and (not needsHorizontalScrollBar or relY < height) then
            local scrollHeight = needsHorizontalScrollBar and height - 1 or height
            local handleSize = math.max(1, math.floor((contentHeight / #flatNodes) * scrollHeight))
            local maxOffset = #flatNodes - contentHeight

            local currentPercent = maxOffset > 0 and (self.get("offset") / maxOffset * 100) or 0
            local handlePos = math.floor((currentPercent / 100) * (scrollHeight - handleSize)) + 1

            if relY >= handlePos and relY < handlePos + handleSize then
                self._scrollBarDragging = true
                self._scrollBarDragOffset = relY - handlePos
            else
                local newPercent = ((relY - 1) / (scrollHeight - handleSize)) * 100
                local newOffset = math.floor((newPercent / 100) * maxOffset + 0.5)
                self.set("offset", math.max(0, math.min(maxOffset, newOffset)))
            end
            return true
        end

        if needsHorizontalScrollBar and relY == height and (not needsVerticalScrollBar or relX < width) then
            local contentWidth = needsVerticalScrollBar and width - 1 or width
            local handleSize = math.max(1, math.floor((contentWidth / maxContentWidth) * contentWidth))
            local maxOffset = maxContentWidth - contentWidth

            local currentPercent = maxOffset > 0 and (self.get("horizontalOffset") / maxOffset * 100) or 0
            local handlePos = math.floor((currentPercent / 100) * (contentWidth - handleSize)) + 1

            if relX >= handlePos and relX < handlePos + handleSize then
                self._hScrollBarDragging = true
                self._hScrollBarDragOffset = relX - handlePos
            else
                local newPercent = ((relX - 1) / (contentWidth - handleSize)) * 100
                local newOffset = math.floor((newPercent / 100) * maxOffset + 0.5)
                self.set("horizontalOffset", math.max(0, math.min(maxOffset, newOffset)))
            end
            return true
        end

        local visibleIndex = relY + self.get("offset")

        if flatNodes[visibleIndex] then
            local nodeInfo = flatNodes[visibleIndex]
            local node = nodeInfo.node

            if relX <= nodeInfo.level * 2 + 2 then
                self:toggleNode(node)
            end

            self.set("selectedNode", node)
            self:fireEvent("node_select", node)
        end
        return true
    end
    return false
end

--- Registers a callback for when a node is selected
--- @shortDescription Registers a callback for when a node is selected
--- @param callback function The callback function
--- @return Tree self The Tree instance
function Tree:onSelect(callback)
    self:registerCallback("node_select", callback)
    return self
end

--- @shortDescription Handles mouse drag events for scrollbar
--- @param button number The mouse button being dragged
--- @param x number The x-coordinate of the drag
--- @param y number The y-coordinate of the drag
--- @return boolean Whether the event was handled
--- @protected
function Tree:mouse_drag(button, x, y)
    if self._scrollBarDragging then
        local _, relY = self:getRelativePosition(x, y)
        local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
        local height = self.get("height")
        local maxContentWidth, _ = self:getNodeSize()
        local needsHorizontalScrollBar = self.get("showScrollBar") and maxContentWidth > self.get("width")
        local contentHeight = needsHorizontalScrollBar and height - 1 or height
        local scrollHeight = contentHeight
        local handleSize = math.max(1, math.floor((contentHeight / #flatNodes) * scrollHeight))
        local maxOffset = #flatNodes - contentHeight

        relY = math.max(1, math.min(scrollHeight, relY))

        local newPos = relY - (self._scrollBarDragOffset or 0)
        local newPercent = ((newPos - 1) / (scrollHeight - handleSize)) * 100
        local newOffset = math.floor((newPercent / 100) * maxOffset + 0.5)

        self.set("offset", math.max(0, math.min(maxOffset, newOffset)))
        return true
    end

    if self._hScrollBarDragging then
        local relX, _ = self:getRelativePosition(x, y)
        local width = self.get("width")
        local maxContentWidth, _ = self:getNodeSize()
        local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
        local height = self.get("height")
        local needsHorizontalScrollBar = self.get("showScrollBar") and maxContentWidth > width
        local contentHeight = needsHorizontalScrollBar and height - 1 or height
        local needsVerticalScrollBar = self.get("showScrollBar") and #flatNodes > contentHeight
        local contentWidth = needsVerticalScrollBar and width - 1 or width
        local handleSize = math.max(1, math.floor((contentWidth / maxContentWidth) * contentWidth))
        local maxOffset = maxContentWidth - contentWidth

        relX = math.max(1, math.min(contentWidth, relX))

        local newPos = relX - (self._hScrollBarDragOffset or 0)
        local newPercent = ((newPos - 1) / (contentWidth - handleSize)) * 100
        local newOffset = math.floor((newPercent / 100) * maxOffset + 0.5)

        self.set("horizontalOffset", math.max(0, math.min(maxOffset, newOffset)))
        return true
    end

    return VisualElement.mouse_drag and VisualElement.mouse_drag(self, button, x, y) or false
end

--- @shortDescription Handles mouse up events to stop scrollbar dragging
--- @param button number The mouse button that was released
--- @param x number The x-coordinate of the release
--- @param y number The y-coordinate of the release
--- @return boolean Whether the event was handled
--- @protected
function Tree:mouse_up(button, x, y)
    if self._scrollBarDragging then
        self._scrollBarDragging = false
        self._scrollBarDragOffset = nil
        return true
    end

    if self._hScrollBarDragging then
        self._hScrollBarDragging = false
        self._hScrollBarDragOffset = nil
        return true
    end

    return VisualElement.mouse_up and VisualElement.mouse_up(self, button, x, y) or false
end

--- @shortDescription Handles mouse scroll events for vertical scrolling
--- @param direction number The scroll direction (1 for up, -1 for down)
--- @param x number The x position of the scroll
--- @param y number The y position of the scroll
--- @return boolean handled Whether the event was handled
--- @protected
function Tree:mouse_scroll(direction, x, y)
    if VisualElement.mouse_scroll(self, direction, x, y) then
        local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
        local height = self.get("height")
        local width = self.get("width")
        local showScrollBar = self.get("showScrollBar")
        local maxContentWidth, _ = self:getNodeSize()
        local needsHorizontalScrollBar = showScrollBar and maxContentWidth > width
        local contentHeight = needsHorizontalScrollBar and height - 1 or height
        local maxScroll = math.max(0, #flatNodes - contentHeight)
        local newScroll = math.min(maxScroll, math.max(0, self.get("offset") + direction))

        self.set("offset", newScroll)
        return true
    end
    return false
end

--- Gets the size of the tree
--- @shortDescription Gets the size of the tree
--- @return number width The width of the tree
--- @return number height The height of the tree
function Tree:getNodeSize()
    local width, height = 0, 0
    local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
    local expandedNodes = self.get("expandedNodes")

    for _, nodeInfo in ipairs(flatNodes) do
        local node = nodeInfo.node
        local level = nodeInfo.level
        local indent = string.rep("  ", level)

        local symbol = " "
        if node.children and #node.children > 0 then
            symbol = expandedNodes[node] and "\31" or "\16"
        end

        local fullText = indent .. symbol .. " " .. (node.text or "Node")
        width = math.max(width, #fullText)
    end
    height = #flatNodes
    return width, height
end

--- @shortDescription Renders the tree with nodes, selection and scrolling
--- @protected
function Tree:render()
    VisualElement.render(self)

    local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
    local height = self.get("height")
    local width = self.get("width")
    local selectedNode = self.get("selectedNode")
    local expandedNodes = self.get("expandedNodes")
    local offset = self.get("offset")
    local horizontalOffset = self.get("horizontalOffset")
    local showScrollBar = self.get("showScrollBar")
    local maxContentWidth, _ = self:getNodeSize()
    local needsHorizontalScrollBar = showScrollBar and maxContentWidth > width
    local contentHeight = needsHorizontalScrollBar and height - 1 or height
    local needsVerticalScrollBar = showScrollBar and #flatNodes > contentHeight
    local contentWidth = needsVerticalScrollBar and width - 1 or width

    for y = 1, contentHeight do
        local nodeInfo = flatNodes[y + offset]
        if nodeInfo then
            local node = nodeInfo.node
            local level = nodeInfo.level
            local indent = string.rep("  ", level)

            local symbol = " "
            if node.children and #node.children > 0 then
                symbol = expandedNodes[node] and "\31" or "\16"
            end

            local isSelected = node == selectedNode
            local _bg = isSelected and self.get("selectedBackgroundColor") or (node.background or node.bg or self.get("background"))
            local _fg = isSelected and self.get("selectedForegroundColor") or (node.foreground or node.fg or self.get("foreground"))

            local fullText = indent .. symbol .. " " .. (node.text or "Node")
            local text = sub(fullText, horizontalOffset + 1, horizontalOffset + contentWidth)
            local paddedText = text .. string.rep(" ", contentWidth - #text)

            local bg = tHex[_bg]:rep(#paddedText) or tHex[colors.black]:rep(#paddedText)
            local fg = tHex[_fg]:rep(#paddedText) or tHex[colors.white]:rep(#paddedText)

            self:blit(1, y, paddedText, fg, bg)
        else
            self:blit(1, y, string.rep(" ", contentWidth), tHex[self.get("foreground")]:rep(contentWidth), tHex[self.get("background")]:rep(contentWidth))
        end
    end

    local scrollBarSymbol = self.getResolved("scrollBarSymbol")
    local scrollBarBg = self.getResolved("scrollBarBackground")
    local scrollBarColor = self.getResolved("scrollBarColor")
    local scrollBarBgColor = self.getResolved("scrollBarBackgroundColor")
    local foreground = self.getResolved("foreground")

    if needsVerticalScrollBar then
        local scrollHeight = needsHorizontalScrollBar and height - 1 or height
        local handleSize = math.max(1, math.floor((contentHeight / #flatNodes) * scrollHeight))
        local maxOffset = #flatNodes - contentHeight

        local currentPercent = maxOffset > 0 and (offset / maxOffset * 100) or 0
        local handlePos = math.floor((currentPercent / 100) * (scrollHeight - handleSize)) + 1

        for i = 1, scrollHeight do
            self:blit(width, i, scrollBarBg, tHex[foreground], tHex[scrollBarBgColor])
        end

        for i = handlePos, math.min(scrollHeight, handlePos + handleSize - 1) do
            self:blit(width, i, scrollBarSymbol, tHex[scrollBarColor], tHex[scrollBarBgColor])
        end
    end

    if needsHorizontalScrollBar then
        local scrollWidth = needsVerticalScrollBar and width - 1 or width
        local handleSize = math.max(1, math.floor((scrollWidth / maxContentWidth) * scrollWidth))
        local maxOffset = maxContentWidth - contentWidth

        local currentPercent = maxOffset > 0 and (horizontalOffset / maxOffset * 100) or 0
        local handlePos = math.floor((currentPercent / 100) * (scrollWidth - handleSize)) + 1

        for i = 1, scrollWidth do
            self:blit(i, height, scrollBarBg, tHex[foreground], tHex[scrollBarBgColor])
        end

        for i = handlePos, math.min(scrollWidth, handlePos + handleSize - 1) do
            self:blit(i, height, scrollBarSymbol, tHex[scrollBarColor], tHex[scrollBarBgColor])
        end
    end

    if needsVerticalScrollBar and needsHorizontalScrollBar then
        self:blit(width, height, " ", tHex[foreground], tHex[self.get("background")])
    end
end

return Tree
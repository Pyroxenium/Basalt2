local VisualElement = require("elements/VisualElement")
local sub = string.sub
---@cofnigDescription The tree element provides a hierarchical view of nodes that can be expanded and collapsed, with support for selection and scrolling.

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
---@property scrollOffset number 0 Current vertical scroll position
Tree.defineProperty(Tree, "scrollOffset", {default = 0, type = "number", canTriggerRender = true})
---@property horizontalOffset number 0 Current horizontal scroll position
Tree.defineProperty(Tree, "horizontalOffset", {default = 0, type = "number", canTriggerRender = true})
---@property nodeColor color white Color of unselected nodes
Tree.defineProperty(Tree, "nodeColor", {default = colors.white, type = "color"})
---@property selectedColor color lightBlue Background color of selected node
Tree.defineProperty(Tree, "selectedColor", {default = colors.lightBlue, type = "color"})

Tree.defineEvent(Tree, "mouse_click")
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
        local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
        local visibleIndex = relY + self.get("scrollOffset")

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

--- @shortDescription Handles mouse scroll events for vertical scrolling
--- @param direction number The scroll direction (1 for up, -1 for down)
--- @param x number The x position of the scroll
--- @param y number The y position of the scroll
--- @return boolean handled Whether the event was handled
--- @protected
function Tree:mouse_scroll(direction, x, y)
    if VisualElement.mouse_scroll(self, direction, x, y) then
        local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
        local maxScroll = math.max(0, #flatNodes - self.get("height"))
        local newScroll = math.min(maxScroll, math.max(0, self.get("scrollOffset") + direction))

        self.set("scrollOffset", newScroll)
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
    for _, nodeInfo in ipairs(flatNodes) do
        width = math.max(width, nodeInfo.level + #nodeInfo.node.text)
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
    local selectedNode = self.get("selectedNode")
    local expandedNodes = self.get("expandedNodes")
    local scrollOffset = self.get("scrollOffset")
    local horizontalOffset = self.get("horizontalOffset")

    for y = 1, height do
        local nodeInfo = flatNodes[y + scrollOffset]
        if nodeInfo then
            local node = nodeInfo.node
            local level = nodeInfo.level
            local indent = string.rep("  ", level)

            local symbol = " "
            if node.children and #node.children > 0 then
                symbol = expandedNodes[node] and "\31" or "\16"
            end

            local bg = node == selectedNode and self.get("selectedColor") or self.get("background")
            local fullText = indent .. symbol .." " .. (node.text or "Node")
            local text = sub(fullText, horizontalOffset + 1, horizontalOffset + self.get("width"))

            self:textFg(1, y, text .. string.rep(" ", self.get("width") - #text), self.get("foreground"))
        else
            self:textFg(1, y, string.rep(" ", self.get("width")), self.get("foreground"), self.get("background"))
        end
    end
end

return Tree

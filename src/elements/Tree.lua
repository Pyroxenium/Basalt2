local VisualElement = require("elements/VisualElement")
local sub = string.sub

--- This is the tree class. It provides a hierarchical view of nodes that can be expanded and collapsed,
--- with support for selection and scrolling.
---@class Tree : VisualElement
local Tree = setmetatable({}, VisualElement)
Tree.__index = Tree

---@property nodes table {} The tree structure containing node objects with {text, children} properties
Tree.defineProperty(Tree, "nodes", {default = {}, type = "table", canTriggerRender = true})
---@property selectedNode table? nil Currently selected node
Tree.defineProperty(Tree, "selectedNode", {default = nil, type = "table", canTriggerRender = true})
---@property expandedNodes table {} Table of nodes that are currently expanded
Tree.defineProperty(Tree, "expandedNodes", {default = {}, type = "table", canTriggerRender = true})
---@property scrollOffset number 0 Current vertical scroll position
Tree.defineProperty(Tree, "scrollOffset", {default = 0, type = "number", canTriggerRender = true})
---@property horizontalOffset number 0 Current horizontal scroll position
Tree.defineProperty(Tree, "horizontalOffset", {default = 0, type = "number", canTriggerRender = true})
---@property nodeColor color white Color of unselected nodes
Tree.defineProperty(Tree, "nodeColor", {default = colors.white, type = "number"})
---@property selectedColor color lightBlue Background color of selected node
Tree.defineProperty(Tree, "selectedColor", {default = colors.lightBlue, type = "number"})

Tree.listenTo(Tree, "mouse_click")
Tree.listenTo(Tree, "mouse_scroll")

--- Creates a new Tree instance
--- @shortDescription Creates a new Tree instance
--- @return Tree self The newly created Tree instance
--- @usage local tree = Tree.new()
function Tree.new()
    local self = setmetatable({}, Tree):__init()
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
function Tree:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Tree")
    return self
end

--- Sets the tree nodes
--- @shortDescription Sets the tree nodes and expands the root node
--- @param nodes table[] Array of node objects
--- @return Tree self The Tree instance
--- @usage tree:setNodes({{text="Root", children={{text="Child"}}}})
function Tree:setNodes(nodes)
    self.set("nodes", nodes)
    if #nodes > 0 then
        self.get("expandedNodes")[nodes[1]] = true
    end
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
end

--- Registers a callback for when a node is selected
--- @shortDescription Registers a callback for when a node is selected
--- @param callback function The callback function
--- @return Tree self The Tree instance
function Tree:onSelect(callback)
    self:registerCallback("node_select", callback)
    return self
end

---@private
function Tree:mouse_scroll(direction, x, y)
    if VisualElement.mouse_scroll(self, direction, x, y) then
        local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
        local maxScroll = math.max(0, #flatNodes - self.get("height"))
        local newScroll = math.min(maxScroll, math.max(0, self.get("scrollOffset") + direction))

        self.set("scrollOffset", newScroll)
        return true
    end
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

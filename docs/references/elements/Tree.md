local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")

---@class Tree : VisualElement
local Tree = setmetatable({}, VisualElement)
Tree.__index = Tree

Tree.defineProperty(Tree, "nodes", {default = {}, type = "table", canTriggerRender = true})
Tree.defineProperty(Tree, "selectedNode", {default = nil, type = "table", canTriggerRender = true})
Tree.defineProperty(Tree, "expandedNodes", {default = {}, type = "table", canTriggerRender = true})
Tree.defineProperty(Tree, "scrollOffset", {default = 0, type = "number", canTriggerRender = true})
Tree.defineProperty(Tree, "nodeColor", {default = colors.white, type = "number"})
Tree.defineProperty(Tree, "selectedColor", {default = colors.lightBlue, type = "number"})

Tree.listenTo(Tree, "mouse_click")
Tree.listenTo(Tree, "mouse_scroll")

function Tree.new()
    local self = setmetatable({}, Tree):__init()
    self.set("width", 30)
    self.set("height", 10)
    self.set("z", 5)
    return self
end

function Tree:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Tree")
    return self
end

function Tree:setNodes(nodes)
    self.set("nodes", nodes)
    if #nodes > 0 then
        self.get("expandedNodes")[nodes[1]] = true
    end
    return self
end

function Tree:expandNode(node)
    self.get("expandedNodes")[node] = true
    self:updateRender()
    return self
end

function Tree:collapseNode(node)
    self.get("expandedNodes")[node] = nil
    self:updateRender()
    return self
end

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
    if not VisualElement.mouse_click(self, button, x, y) then return false end

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

function Tree:onSelect(callback)
    self:registerCallback("node_select", callback)
    return self
end

function Tree:mouse_scroll(direction)
    local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
    local maxScroll = math.max(0, #flatNodes - self.get("height"))
    local newScroll = math.min(maxScroll, math.max(0, self.get("scrollOffset") + direction))
    
    self.set("scrollOffset", newScroll)
    return true
end

function Tree:render()
    VisualElement.render(self)
    
    local flatNodes = flattenTree(self.get("nodes"), self.get("expandedNodes"))
    local height = self.get("height")
    local selectedNode = self.get("selectedNode")
    local expandedNodes = self.get("expandedNodes")
    local scrollOffset = self.get("scrollOffset")

    for y = 1, height do
        local nodeInfo = flatNodes[y + scrollOffset]
        if nodeInfo then
            local node = nodeInfo.node
            local level = nodeInfo.level
            local indent = string.rep("  ", level)
            
            -- Expand/Collapse Symbol
            local symbol = " "
            if node.children and #node.children > 0 then
                symbol = expandedNodes[node] and "\31" or "\16"
            end

            local bg = node == selectedNode and self.get("selectedColor") or self.get("background")
            local text = indent .. symbol .." " .. (node.text or "Node")
            
            self:blit(1, y, text .. string.rep(" ", self.get("width") - #text),
                string.rep(tHex[self.get("nodeColor")], self.get("width")),
                string.rep(tHex[bg], self.get("width")))
        else
            -- Leere Zeile
            self:blit(1, y, string.rep(" ", self.get("width")),
                string.rep(tHex[self.get("foreground")], self.get("width")),
                string.rep(tHex[self.get("background")], self.get("width")))
        end
    end
end

return Tree

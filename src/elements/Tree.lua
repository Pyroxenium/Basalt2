-- Tree: hierarchical nodes with expand/collapse and selection.
--
-- Nodes are plain tables: { text = "...", children = { ... }, expanded = bool }
-- (the expanded flag is stored in the node itself). Fires "select"(node) and
-- "toggle"(node, expanded).

local require = ...
local class = require("core/class")
local Element = require("core/element")
local itemview = require("core/itemview")

local Tree = class.create("Tree", Element)

class.property(Tree, "nodes", false, {      -- fresh table per instance (setup)
    onChange = function(self, nodes)
        if type(nodes) ~= "table" then
            error("Basalt Tree: nodes must be a table", 3)
        end
        local old = self.selected
        self.offset = 0
        self.horizontalOffset = 0
        self.selected = false
        if old then self:fire("change", false, old) end
        if nodes[1] and nodes[1].children and nodes[1].expanded == nil then
            nodes[1].expanded = true -- Basalt2 expands the first root initially
        end
    end,
})
class.property(Tree, "selected", false, {  -- the selected node table
    state = "selected",
    stateWhen = function(v) return v ~= false and v ~= nil end,
    styleable = false,
})
class.property(Tree, "offset", 0)
class.property(Tree, "horizontalOffset", 0)
class.property(Tree, "background", colors.black)
class.property(Tree, "selectionBackground", colors.blue)
class.property(Tree, "selectionForeground", colors.white)
class.property(Tree, "width", 16)
class.property(Tree, "height", 8)
class.property(Tree, "scrollbar", "auto")
class.property(Tree, "scrollbarColor", colors.gray)
class.property(Tree, "scrollbarThumbColor", colors.lightGray)
class.property(Tree, "scrollBarSymbol", " ")
class.property(Tree, "scrollBarBackground", "\127")

class.event(Tree, "select")
class.event(Tree, "change")
class.event(Tree, "toggle")

--- Flattens the visible part of the tree into { node, depth, parent } rows.
local function flatten(self)
    local out = {}
    local function walk(nodes, depth, parent)
        for i = 1, #nodes do
            local node = nodes[i]
            out[#out + 1] = { node = node, depth = depth, parent = parent }
            if node.children and node.expanded then
                walk(node.children, depth + 1, node)
            end
        end
    end
    walk(self.nodes, 0, nil)
    return out
end

local function flatIndexOf(flat, node)
    for i = 1, #flat do
        if flat[i].node == node then return i end
    end
    return nil
end

local function geometry(self, flat)
    return itemview.geometry(#flat, self.height, self.offset, self.scrollbar)
end

function Tree:toggle(node, expanded)
    if not node or not node.children then return self end
    if expanded == nil then expanded = not node.expanded end
    node.expanded = expanded and true or false
    local flat = flatten(self)
    self.offset = itemview.clampOffset(self.offset, #flat, self.height)
    self:fire("toggle", node, node.expanded)
    self:markDirty()
    return self
end

function Tree:select(node, emit)
    local old = self.selected
    if node == false or node == nil then
        self.selected = false
        if old then self:fire("change", false, old) end
        return self
    end
    self.selected = node
    local flat = flatten(self)
    local index = flatIndexOf(flat, node)
    if index then
        self.offset = itemview.ensureVisible(self.offset, index,
            #flat, self.height)
    end
    if old ~= node then self:fire("change", node, old or false) end
    if emit ~= false then self:fire("select", node) end
    return self
end

function Tree:expandNode(node)
    return self:toggle(node, true)
end

function Tree:collapseNode(node)
    return self:toggle(node, false)
end

function Tree:toggleNode(node)
    return self:toggle(node)
end

function Tree:setSelectedNode(node)
    return self:select(node, false)
end

function Tree:getSelectedNode()
    return self.selected or nil
end

function Tree:getExpandedNodes()
    local result = {}
    local function walk(nodes)
        for _, node in ipairs(nodes) do
            if node.expanded then result[node] = true end
            if node.children then walk(node.children) end
        end
    end
    walk(self.nodes)
    return result
end

function Tree:setExpandedNodes(expanded)
    if type(expanded) ~= "table" then
        error("Basalt Tree: expandedNodes must be a table", 2)
    end
    local function walk(nodes)
        for _, node in ipairs(nodes) do
            if node.children then
                node.expanded = expanded[node] == true
                walk(node.children)
            end
        end
    end
    walk(self.nodes)
    self.offset = itemview.clampOffset(self.offset, #flatten(self), self.height)
    self:markDirty()
    return self
end

function Tree:getNodeSize()
    local flat = flatten(self)
    local width = 1
    for _, entry in ipairs(flat) do
        width = math.max(width,
            entry.depth + 2 + #tostring(entry.node.text or "Node"))
    end
    return width, #flat
end

function Tree:setHorizontalOffset(offset)
    local width = self:getNodeSize()
    rawget(self, "_p").horizontalOffset = math.max(0,
        math.min(math.floor(offset or 0), math.max(0, width - self.width)))
    self:markDirty()
    return self
end

function Tree:setSelectedForegroundColor(color)
    self.selectionForeground = color
    return self
end
function Tree:getSelectedForegroundColor() return self.selectionForeground end
function Tree:setSelectedBackgroundColor(color)
    self.selectionBackground = color
    return self
end
function Tree:getSelectedBackgroundColor() return self.selectionBackground end
function Tree:setSelectionColor(foreground, background)
    self.selectionForeground, self.selectionBackground = foreground, background
    return self
end
function Tree:getSelectionColor()
    return self.selectionForeground, self.selectionBackground
end
function Tree:setShowScrollBar(show)
    self.scrollbar = show and "auto" or "hidden"
    return self
end
function Tree:getShowScrollBar() return self.scrollbar ~= "hidden" end
function Tree:setScrollBarColor(color)
    self.scrollbarThumbColor = color
    return self
end
function Tree:getScrollBarColor() return self.scrollbarThumbColor end
function Tree:setScrollBarBackgroundColor(color)
    self.scrollbarColor = color
    return self
end
function Tree:getScrollBarBackgroundColor() return self.scrollbarColor end

function Tree:expandAll()
    local function walk(nodes)
        for i = 1, #nodes do
            if nodes[i].children then
                nodes[i].expanded = true
                walk(nodes[i].children)
            end
        end
    end
    walk(self.nodes)
    self:markDirty()
    return self
end

function Tree:collapseAll()
    local function walk(nodes)
        for i = 1, #nodes do
            if nodes[i].children then
                nodes[i].expanded = false
                walk(nodes[i].children)
            end
        end
    end
    walk(self.nodes)
    self:markDirty()
    return self
end

function Tree:setup()
    Element.setup(self)
    rawget(self, "_p").nodes = {}

    self:on("click", function(s, _, x, y)
        local flat = flatten(s)
        local g = geometry(s, flat)
        if g.show and x == s.width then
            local target, grab = itemview.pointerDown(y, g)
            s.offset = target
            if grab ~= nil then rawset(s, "_itemScrollDrag", grab) end
            return
        end
        local entry = flat[g.offset + y]
        if not entry then return end
        -- the "+ "/"- " marker cell toggles, everything else selects
        if entry.node.children and x >= entry.depth + 1 and x <= entry.depth + 2 then
            s:toggle(entry.node)
        else
            s:select(entry.node)
        end
    end)
    self:on("drag", function(s, _, _, y)
        local grab = rawget(s, "_itemScrollDrag")
        if grab ~= nil then
            s.offset = itemview.drag(y, grab, geometry(s, flatten(s)))
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_itemScrollDrag", nil)
    end)
end

function Tree:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" then
        if self.disabled then return nil end
        local flat = flatten(self)
        local old = self.offset
        self.offset = itemview.clampOffset(old + btn, #flat, self.height)
        local userHandled = self:fire("scroll", btn, x, y)
        if self.offset ~= old or userHandled then return self end
        return nil
    end
    return Element.handleMouse(self, event, btn, x, y)
end

function Tree:handleKey(event, a, b)
    if event == "key" then
        local flat = flatten(self)
        if #flat > 0 then
            local index = flatIndexOf(flat, self.selected) or 0
            if a == keys.up then
                self:select(flat[math.max(1, index > 0 and index - 1 or 1)].node, false)
            elseif a == keys.down then
                self:select(flat[index > 0
                    and math.min(#flat, index + 1) or 1].node, false)
            elseif a == keys.right and index > 0 then
                local node = flat[index].node
                if node.children and not node.expanded then
                    self:toggle(node, true)
                elseif node.children and node.expanded and node.children[1] then
                    self:select(node.children[1], false)
                end
            elseif a == keys.left and index > 0 then
                local entry = flat[index]
                if entry.node.children and entry.node.expanded then
                    self:toggle(entry.node, false)
                elseif entry.parent then
                    self:select(entry.parent, false)
                end
            elseif a == keys.enter and index > 0 then
                self:fire("select", flat[index].node)
            end
        end
    end
    Element.handleKey(self, event, a, b)
end

function Tree:measure()
    local flat = flatten(self)
    local w = 1
    for i = 1, #flat do
        w = math.max(w, flat[i].depth + 3 + #tostring(flat[i].node.text))
    end
    return w, math.max(1, #flat)
end

function Tree:render(buf)
    Element.render(self, buf)
    local flat = flatten(self)
    local g = geometry(self, flat)
    rawget(self, "_p").offset = g.offset
    local tw = math.max(0, self.width - (g.show and 1 or 0))
    local sel = self.selected

    for row = 1, self.height do
        local entry = flat[g.offset + row]
        if not entry then break end
        local node = entry.node
        local marker = node.children and (node.expanded and "- " or "+ ") or "  "
        local line = string.rep(" ", entry.depth) .. marker .. tostring(node.text)
        line = line:sub(self.horizontalOffset + 1,
            self.horizontalOffset + tw)
        if node == sel then
            buf:fill(1, row, tw, 1, " ",
                self.selectionForeground, self.selectionBackground)
            buf:blit(1, row, line:sub(1, tw),
                self.selectionForeground, self.selectionBackground)
        else
            buf:blit(1, row, line:sub(1, tw), self.foreground, nil)
        end
    end
    itemview.draw(buf, self.width, 1, g, self.foreground,
        self.scrollbarColor, self.scrollbarThumbColor)
end

return Tree

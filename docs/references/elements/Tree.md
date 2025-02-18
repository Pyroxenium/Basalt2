# Tree : VisualElement
This is the tree class. It provides a hierarchical view of nodes that can be expanded and collapsed,
with support for selection and scrolling.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|nodes|table|{}|The tree structure containing node objects with {text, children} properties
|selectedNode|table?|nil|Currently selected node
|expandedNodes|table|{}|Table of nodes that are currently expanded
|scrollOffset|number|0|Current scroll position
|nodeColor|color|white|Color of unselected nodes
|selectedColor|color|lightBlue|Background color of selected node

## Functions

|Method|Returns|Description|
|---|---|---|
|[Tree.new](#Tree.new)|Tree|Creates a new Tree instance
|[Tree:collapseNode](#Tree:collapseNode)|Tree|Collapses a node to hide its children
|[Tree:expandNode](#Tree:expandNode)|Tree|Expands a node to show its children
|[Tree:init](#Tree:init)|Tree|Initializes the Tree instance
|[Tree:mouse_click](#Tree:mouse_click)|-|
|[Tree:mouse_scroll](#Tree:mouse_scroll)|-|
|[Tree:onSelect](#Tree:onSelect)|-|
|[Tree:render](#Tree:render)|-|
|[Tree:setNodes](#Tree:setNodes)|Tree|Sets the tree nodes and expands the root node
|[Tree:toggleNode](#Tree:toggleNode)|Tree|Toggles between expanded and collapsed state

## Tree.new()
Creates a new Tree instance

### Returns
* `Tree` `self` The newly created Tree instance

### Usage
 ```lua
local tree = Tree.new()
```

## Tree:collapseNode(node)
Collapses a node

### Parameters
* `node` `table` The node to collapse

### Returns
* `Tree` `self` The Tree instance

## Tree:expandNode(node)
Expands a node

### Parameters
* `node` `table` The node to expand

### Returns
* `Tree` `self` The Tree instance

## Tree:init(props, basalt)
Initializes the Tree instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Tree` `self` The initialized instance

## Tree:mouse_click()

## Tree:mouse_scroll()

## Tree:onSelect()

## Tree:render()

## Tree:setNodes(nodes)
Sets the tree nodes

### Parameters
* `nodes` `table[]` Array of node objects

### Returns
* `Tree` `self` The Tree instance

### Usage
 ```lua
tree:setNodes({{text="Root", children={{text="Child"}}}})
```

## Tree:toggleNode(node)
Toggles a node's expanded state

### Parameters
* `node` `table` The node to toggle

### Returns
* `Tree` `self` The Tree instance



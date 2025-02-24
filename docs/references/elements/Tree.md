# Tree : VisualElement
This is the tree class. It provides a hierarchical view of nodes that can be expanded and collapsed,
with support for selection and scrolling.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|nodes|table|{}|The tree structure containing node objects with {text, children} properties
|selectedNode|table?|nil|Currently selected node
|expandedNodes|table|{}|Table of nodes that are currently expanded
|scrollOffset|number|0|Current vertical scroll position
|horizontalOffset|number|0|Current horizontal scroll position
|nodeColor|color|white|Color of unselected nodes
|selectedColor|color|lightBlue|Background color of selected node

## Functions

|Method|Returns|Description|
|---|---|---|
|[Tree:collapseNode](#Tree:collapseNode)|Tree|Collapses a node to hide its children
|[Tree:expandNode](#Tree:expandNode)|Tree|Expands a node to show its children
|[Tree:getNodeSize](#Tree:getNodeSize)|number|Gets the size of the tree
|[Tree:onSelect](#Tree:onSelect)|Tree|Registers a callback for when a node is selected
|[Tree:toggleNode](#Tree:toggleNode)|Tree|Toggles between expanded and collapsed state


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|[Tree:init](#Tree:init)|Tree|Initializes the Tree instance
|[Tree:mouse_click](#Tree:mouse_click)|boolean|Handles mouse click events for node selection and expansion
|[Tree:mouse_scroll](#Tree:mouse_scroll)|boolean|Handles mouse scroll events for vertical scrolling
|[Tree:render](#Tree:render)|-|Renders the tree with nodes, selection and scrolling

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

## Tree:getNodeSize()
Gets the size of the tree

### Returns
* `number` `width` The width of the tree
* `number` `height` The height of the tree

## Tree:onSelect(callback)
Registers a callback for when a node is selected

### Parameters
* `callback` `function` The callback function

### Returns
* `Tree` `self` The Tree instance

## Tree:toggleNode(node)
Toggles a node's expanded state

### Parameters
* `node` `table` The node to toggle

### Returns
* `Tree` `self` The Tree instance



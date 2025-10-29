# Tree
_This is the tree class. It provides a hierarchical view of nodes that can be expanded and collapsed,_
_with support for selection and scrolling._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|nodes|table|{}|The tree structure containing node objects with {text, children} properties|
|expandedNodes|table|{}|Table of nodes that are currently expanded|
|offset|number|0|Current vertical scroll position|
|horizontalOffset|number|0|Current horizontal scroll position|
|selectedForegroundColor|color|white|foreground color of selected node|
|selectedBackgroundColor|color|lightBlue|background color of selected node|
|showScrollBar|boolean|true|Whether to show the scrollbar when nodes exceed height|
|scrollBarSymbol|string|"|" Symbol used for the scrollbar handle|
|scrollBarBackground|string|"\127"|Symbol used for the scrollbar background|
|scrollBarColor|color|lightGray|Color of the scrollbar handle|
|scrollBarBackgroundColor|color|gray|Background color of the scrollbar|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Tree:expandNode](#tree-expandnode-node)|Tree|Expands a node to show its children|
|[Tree:collapseNode](#tree-collapsenode-node)|Tree|Collapses a node to hide its children|
|[Tree:toggleNode](#tree-togglenode-node)|Tree|Toggles between expanded and collapsed state|
|[Tree:onSelect](#tree-onselect-callback)|Tree|Registers a callback for when a node is selected|
|[Tree:getNodeSize](#tree-getnodesize)|number, number|Gets the size of the tree|

## Tree:expandNode(node)

Expands a node

### Parameters
* `node` `table` The node to expand

### Returns
* `Tree` `self` The Tree instance

## Tree:collapseNode(node)

Collapses a node

### Parameters
* `node` `table` The node to collapse

### Returns
* `Tree` `self` The Tree instance

## Tree:toggleNode(node)

Toggles a node's expanded state

### Parameters
* `node` `table` The node to toggle

### Returns
* `Tree` `self` The Tree instance

## Tree:onSelect(callback)

Registers a callback for when a node is selected

### Parameters
* `callback` `function` The callback function

### Returns
* `Tree` `self` The Tree instance

## Tree:getNodeSize()

Gets the size of the tree

### Returns
* `number` `width` The width of the tree
* `number` `height` The height of the tree

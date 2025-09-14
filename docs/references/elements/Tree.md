# Tree
_This is the tree class. It provides a hierarchical view of nodes that can be expanded and collapsed,_
_with support for selection and scrolling._

Extends: `VisualElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|nodes|table|{}|The tree structure containing node objects with {text, children} properties|
|expandedNodes|table|{}|Table of nodes that are currently expanded|
|scrollOffset|number|0|Current vertical scroll position|
|horizontalOffset|number|0|Current horizontal scroll position|
|nodeColor|color|white|Color of unselected nodes|
|selectedColor|color|lightBlue|Background color of selected node|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Tree.new](#tree-new)|Tree|Creates a new Tree instance|
|[Tree:init](#tree-init-props-basalt)|Tree|Initializes the Tree instance|
|[Tree:expandNode](#tree-expandnode-node)|Tree|Expands a node to show its children|
|[Tree:collapseNode](#tree-collapsenode-node)|Tree|Collapses a node to hide its children|
|[Tree:toggleNode](#tree-togglenode-node)|Tree|Toggles between expanded and collapsed state|
|[Tree:mouse_click](#tree-mouse-click-button-x-y)|boolean|Handles mouse click events for node selection and expansion|
|[Tree:onSelect](#tree-onselect-callback)|Tree|Registers a callback for when a node is selected|
|[Tree:mouse_scroll](#tree-mouse-scroll-direction-x-y)|boolean|Handles mouse scroll events for vertical scrolling|
|[Tree:getNodeSize](#tree-getnodesize)|number, number|Gets the size of the tree|
|[Tree:render](#tree-render)|-|Renders the tree with nodes, selection and scrolling|

## Tree.new()

Creates a new Tree instance

### Returns
* `Tree` `self` The newly created Tree instance

## Tree:init(props, basalt)

Initializes the Tree instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Tree` `self` The initialized instance

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

## Tree:mouse_click(button, x, y)

Handles mouse click events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Tree:onSelect(callback)

Registers a callback for when a node is selected

### Parameters
* `callback` `function` The callback function

### Returns
* `Tree` `self` The Tree instance

## Tree:mouse_scroll(direction, x, y)
### Parameters
* `direction` `number` The scroll direction (1 for up, -1 for down)
* `x` `number` The x position of the scroll
* `y` `number` The y position of the scroll

### Returns
* `boolean` `handled` Whether the event was handled

## Tree:getNodeSize()

Gets the size of the tree

### Returns
* `number` `width` The width of the tree
* `number` `height` The height of the tree

## Tree:render()
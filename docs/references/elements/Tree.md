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
|[Tree.new](#Tree.new)|Tree|Creates a new Tree instance
|[Tree:collapseNode](#Tree:collapseNode)|Tree|Collapses a node to hide its children
|[Tree:expandNode](#Tree:expandNode)|Tree|Expands a node to show its children
|[Tree:getNodeSize](#Tree:getNodeSize)|number|Gets the size of the tree
|[Tree:init](#Tree:init)|Tree|Initializes the Tree instance
|[Tree:mouse_click](#Tree:mouse_click)|boolean|Handles mouse click events for node selection and expansion
|[Tree:mouse_scroll](#Tree:mouse_scroll)|boolean|Handles mouse scroll events for vertical scrolling
|[Tree:onSelect](#Tree:onSelect)|Tree|Registers a callback for when a node is selected
|[Tree:render](#Tree:render)|-|Renders the tree with nodes, selection and scrolling
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

## Tree:getNodeSize()
Gets the size of the tree

### Returns
* `number` `width` The width of the tree
* `number` `height` The height of the tree

## Tree:init(props, basalt)
Initializes the Tree instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `Tree` `self` The initialized instance

## Tree:mouse_click(button, x, y)
Handles mouse click events

### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click
* `y` `number` The y position of the click

### Returns
* `boolean` `handled` Whether the event was handled

## Tree:mouse_scroll(direction, x, y)
Handles mouse scroll events

### Parameters
* `direction` `number` The scroll direction (1 for up, -1 for down)
* `x` `number` The x position of the scroll
* `y` `number` The y position of the scroll

### Returns
* `boolean` `handled` Whether the event was handled

## Tree:onSelect(callback)
Registers a callback for when a node is selected

### Parameters
* `callback` `function` The callback function

### Returns
* `Tree` `self` The Tree instance

## Tree:render()
Renders the tree

## Tree:toggleNode(node)
Toggles a node's expanded state

### Parameters
* `node` `table` The node to toggle

### Returns
* `Tree` `self` The Tree instance



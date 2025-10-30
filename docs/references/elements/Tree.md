# Tree
_This is the tree class. It provides a hierarchical view of nodes that can be expanded and collapsed, with support for selection and scrolling._
_run [[_
_local basaltg = require("basalt")_
_local main = basalt.getMainFrame()_

_local fileTree = main:addTree()_
_:setPosition(2, 2)_
_:setSize(15, 15)_
_:setBackground(colors.black)_
_:setForeground(colors.white)_
_:setSelectedBackgroundColor(colors.blue)_
_:setSelectedForegroundColor(colors.white)_
_:setScrollBarColor(colors.lightGray)_
_:setScrollBarBackgroundColor(colors.gray)_

_-- Build a file system-like tree structure_
_local treeData = {_
_{_
_text = "Root",_
_children = {_
_{_
_text = "Documents",_
_children = {_
_{text = "report.txt"},_
_{text = "notes.txt"},_
_{text = "todo.txt"}_
_}_
_},_
_{_
_text = "Pictures",_
_children = {_
_{text = "vacation.png"},_
_{text = "family.jpg"},_
_{_
_text = "Archive",_
_children = {_
_{text = "old_photo1.jpg"},_
_{text = "old_photo2.jpg"},_
_{text = "old_photo3.jpg"}_
_}_
_}_
_}_
_},_
_{_
_text = "Music",_
_children = {_
_{text = "song1.mp3"},_
_{text = "song2.mp3"},_
_{text = "song3.mp3"},_
_{text = "song4.mp3"}_
_}_
_},_
_{_
_text = "Videos",_
_children = {_
_{text = "movie1.mp4"},_
_{text = "movie2.mp4"}_
_}_
_},_
_{_
_text = "Projects",_
_children = {_
_{_
_text = "ProjectA",_
_children = {_
_{text = "src"},_
_{text = "tests"},_
_{text = "README.md"}_
_}_
_},_
_{_
_text = "ProjectB",_
_children = {_
_{text = "main.lua"},_
_{text = "config.lua"}_
_}_
_}_
_}_
_}_
_}_
_}_
_}_

_fileTree:setNodes(treeData)_
_local textLabel = main:addLabel()_
_:setPosition(2, 18)_
_:setForeground(colors.yellow)_
_:setText("Selected: None")_

_-- Handle node selection_
_fileTree:onSelect(function(self, node)_
_textLabel_
_:setText("Selected: " .. node.text)_
_:setPosition(2, 18)_
_:setForeground(colors.yellow)_
_end)_

_-- Info label_
_main:addLabel()_
_:setText("Click nodes to expand/collapse | Scroll to navigate")_
_:setPosition(2, 1)_
_:setForeground(colors.lightGray)_

_basalt.run()_
_]]_

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

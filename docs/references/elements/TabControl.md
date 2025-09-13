# TabControl
_The TabControl is a container that provides tabbed interface functionality_

Extends: `Container`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|activeTab|number|The|currently active tab ID|
|tabHeight|number|Height|of the tab header area|
|tabs|table|List|of tab definitions|
|headerBackground|color|Background|color for the tab header area|
|activeTabBackground|color|Background|color for the active tab|
|activeTabTextColor|color|Foreground|color for the active tab text|

## Functions

|Method|Returns|Description|
|---|---|---|
|[TabControl.new](#tabcontrol-new)|TabControl|Creates a new TabControl instance|
|[TabControl:init](#tabcontrol-init-props-basalt)|-|Initializes the TabControl instance|
|[TabControl:newTab](#tabcontrol-newtab-title)|table|Creates a new tab handler proxy|
|[TabControl:setTab](#tabcontrol-settab-element-tabid)|TabControl|Sets an element to belong to a specific tab|
|[TabControl:addElement](#tabcontrol-addelement-elementtype-tabid)|table|Adds an element to the TabControl and assigns it to the active tab|
|[TabControl:addChild](#tabcontrol-addchild-child)|Container|Overrides Container's addChild to assign new elements to tab 1 by default|
|[TabControl:updateTabVisibility](#tabcontrol-updatetabvisibility)|-|Updates visibility of tab containers|
|[TabControl:setActiveTab](#tabcontrol-setactivetab-tabid)|-|Sets the active tab|
|[TabControl:isChildVisible](#tabcontrol-ischildvisible-child)|boolean|Checks if a child should be visible (overrides Container)|
|[TabControl:getContentYOffset](#tabcontrol-getcontentyoffset)|number|Gets the content area Y offset (below tab headers)|
|[TabControl:mouse_click](#tabcontrol-mouse-click-button-x-y)|boolean|Handles mouse click events for tab switching|
|[TabControl:setCursor](#tabcontrol-setcursor)|-|Sets the cursor position; accounts for tab header offset when delegating to parent|
|[TabControl:render](#tabcontrol-render)|-|Renders the TabControl (header + children)|
|[TabControl:sortChildrenEvents](#tabcontrol-sortchildrenevents)|-||

## TabControl.new()
### Returns
* `TabControl` `self` The created instance

## TabControl:init(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

## TabControl:newTab(title)

returns a proxy for adding elements to the tab

### Parameters
* `title` `string` The title of the tab

### Returns
* `table` `tabHandler` The tab handler proxy for adding elements to the new tab

## TabControl:setTab(element, tabId)
### Parameters
* `element` `table` The element to assign to a tab
* `tabId` `number` The ID of the tab to assign the element to

### Returns
* `TabControl` `self` For method chaining

## TabControl:addElement(elementType, tabId)
### Parameters
* `elementType` `string` The type of element to add
* `tabId` `number` Optional tab ID, defaults to active tab

### Returns
* `table` `element` The created element

## TabControl:addChild(child)
### Parameters
* `child` `table` The child element to add

### Returns
* `Container` `self` For method chaining

## TabControl:updateTabVisibility()
## TabControl:setActiveTab(tabId)
### Parameters
* `tabId` `number` The ID of the tab to activate

## TabControl:isChildVisible(child)
### Parameters
* `child` `table` The child element to check

### Returns
* `boolean` `Whether` the child should be visible

## TabControl:getContentYOffset()
### Returns
* `number` `yOffset` The Y offset for content

## TabControl:mouse_click(button, x, y)
### Parameters
* `button` `number` The button that was clicked
* `x` `number` The x position of the click (global)
* `y` `number` The y position of the click (global)

### Returns
* `boolean` `Whether` the event was handled

## TabControl:setCursor()
## TabControl:render()
## TabControl:sortChildrenEvents()
# SideNav
_The SideNav is a container that provides sidebar navigation functionality_

Extends: `Container`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|activeTab|number|nil|The currently active navigation item ID|
|sidebarWidth|number|12|Width of the sidebar navigation area|
|tabs|table|{}|List of navigation item definitions|
|sidebarBackground|color|gray|Background color for the sidebar area|
|activeTabBackground|color|white|Background color for the active navigation item|
|activeTabTextColor|color|black|Foreground color for the active navigation item text|
|sidebarScrollOffset|number|0|Current scroll offset for navigation items in scrollable mode|
|sidebarPosition|string|left|Position of the sidebar ("left" or "right")|

## Functions

|Method|Returns|Description|
|---|---|---|
|[SideNav:newTab](#sidenav-newtab-title)|table|Creates a new navigation item handler proxy|
|[SideNav:setTab](#sidenav-settab-element-tabid)|SideNav|Sets an element to belong to a specific navigation item|
|[SideNav:addElement](#sidenav-addelement-elementtype-tabid)|table|Adds an element to the SideNav and assigns it to the active navigation item|
|[SideNav:setActiveTab](#sidenav-setactivetab-tabid)|-|Sets the active navigation item|
|[SideNav:scrollSidebar](#sidenav-scrollsidebar-direction)|SideNav|Scrolls the sidebar up or down|
|[SideNav:setCursor](#sidenav-setcursor)|-|Sets the cursor position; accounts for sidebar offset when delegating to parent|

## SideNav:newTab(title)

returns a proxy for adding elements to the navigation item

### Parameters
* `title` `string` The title of the navigation item

### Returns
* `table` `tabHandler` The navigation item handler proxy for adding elements

## SideNav:setTab(element, tabId)
### Parameters
* `element` `table` The element to assign to a navigation item
* `tabId` `number` The ID of the navigation item to assign the element to

### Returns
* `SideNav` `self` For method chaining

## SideNav:addElement(elementType, tabId)
### Parameters
* `elementType` `string` The type of element to add
* `tabId` `number` Optional navigation item ID, defaults to active item

### Returns
* `table` `element` The created element

## SideNav:setActiveTab(tabId)
### Parameters
* `tabId` `number` The ID of the navigation item to activate

## SideNav:scrollSidebar(direction)

Scrolls the sidebar up or down

### Parameters
* `direction` `number` -1 to scroll up, 1 to scroll down

### Returns
* `SideNav` `self` For method chaining

## SideNav:setCursor()
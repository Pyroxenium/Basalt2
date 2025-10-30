# SideNav
_The SideNav is a container that provides sidebar navigation functionality_

Extends: `Container`

## Examples (Executable)
```lua run
local basalt = require("basalt")
local main = basalt.getMainFrame()

-- Create a simple SideNav
local sideNav = main:addSideNav({
x = 1,
y = 1,
sidebarWidth = 12,
width = 48
})

-- Tab 1: Home
local homeTab = sideNav:newTab("Home")

homeTab:addLabel({
x = 2,
y = 2,
text = "Welcome!",
foreground = colors.yellow
})

homeTab:addLabel({
x = 2,
y = 4,
text = "This is a simple",
foreground = colors.white
})

homeTab:addLabel({
x = 2,
y = 5,
text = "SideNav example.",
foreground = colors.white
})

-- Tab 2: Counter
local counterTab = sideNav:newTab("Counter")

local counterLabel = counterTab:addLabel({
x = 2,
y = 2,
text = "Count: 0",
foreground = colors.lime
})

local count = 0
counterTab:addButton({
x = 2,
y = 4,
width = 12,
height = 3,
text = "Click Me",
background = colors.blue
})
:setBackgroundState("clicked", colors.lightBlue)
:onClick(function()
count = count + 1
counterLabel:setText("Count: " .. count)
end)

-- Tab 3: Info
local infoTab = sideNav:newTab("Info")

infoTab:addLabel({
x = 2,
y = 2,
text = "SideNav Features:",
foreground = colors.orange
})

infoTab:addLabel({
x = 2,
y = 4,
text = "- Multiple tabs",
foreground = colors.gray
})

infoTab:addLabel({
x = 2,
y = 5,
text = "- Easy navigation",
foreground = colors.gray
})

infoTab:addLabel({
x = 2,
y = 6,
text = "- Content per tab",
foreground = colors.gray
})

basalt.run()
```

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
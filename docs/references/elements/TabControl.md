# TabControl
_The TabControl is a container that provides tabbed interface functionality_

Extends: `Container`

## Examples (Executable)
```lua run
local basalt = require("basalt")

local main = basalt.getMainFrame()

-- Create a simple TabControl
local tabControl = main:addTabControl({
x = 2,
y = 2,
width = 46,
height = 15,
})

-- Tab 1: Home
local homeTab = tabControl:newTab("Home")

homeTab:addLabel({
x = 2,
y = 2,
text = "Welcome!",
foreground = colors.yellow
})

homeTab:addLabel({
x = 2,
y = 4,
text = "This is a TabControl",
foreground = colors.white
})

homeTab:addLabel({
x = 2,
y = 5,
text = "example with tabs.",
foreground = colors.white
})

-- Tab 2: Counter
local counterTab = tabControl:newTab("Counter")

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
local infoTab = tabControl:newTab("Info")

infoTab:addLabel({
x = 2,
y = 2,
text = "TabControl Features:",
foreground = colors.orange
})

infoTab:addLabel({
x = 2,
y = 4,
text = "- Horizontal tabs",
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
|activeTab|number|nil|The currently active tab ID|
|tabHeight|number|1|Height of the tab header area|
|tabs|table|{}|List of tab definitions|
|headerBackground|color|gray|Background color for the tab header area|
|activeTabBackground|color|white|Background color for the active tab|
|activeTabTextColor|color|black|Foreground color for the active tab text|
|scrollableTab|boolean|false|Enables scroll mode for tabs if they exceed width|
|tabScrollOffset|number|0|Current scroll offset for tabs in scrollable mode|

## Functions

|Method|Returns|Description|
|---|---|---|
|[TabControl:newTab](#tabcontrol-newtab-title)|table|Creates a new tab handler proxy|
|[TabControl:setTab](#tabcontrol-settab-element-tabid)|TabControl|Sets an element to belong to a specific tab|
|[TabControl:addElement](#tabcontrol-addelement-elementtype-tabid)|table|Adds an element to the TabControl and assigns it to the active tab|
|[TabControl:setActiveTab](#tabcontrol-setactivetab-tabid)|-|Sets the active tab|
|[TabControl:scrollTabs](#tabcontrol-scrolltabs-direction)|TabControl|Scrolls the tab header left or right if scrollableTab is enabled|
|[TabControl:setCursor](#tabcontrol-setcursor)|-|Sets the cursor position; accounts for tab header offset when delegating to parent|

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

## TabControl:setActiveTab(tabId)
### Parameters
* `tabId` `number` The ID of the tab to activate

## TabControl:scrollTabs(direction)

Scrolls the tab header left or right if scrollableTab is enabled

### Parameters
* `direction` `number` -1 to scroll left, 1 to scroll right

### Returns
* `TabControl` `self` For method chaining

## TabControl:setCursor()
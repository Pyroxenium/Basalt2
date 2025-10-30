# TabControl
_local main = basalt.getMainFrame()_

_-- Create a simple TabControl_
_local tabControl = main:addTabControl({_
_x = 2,_
_y = 2,_
_width = 46,_
_height = 15,_
_})_

_-- Tab 1: Home_
_local homeTab = tabControl:newTab("Home")_

_homeTab:addLabel({_
_x = 2,_
_y = 2,_
_text = "Welcome!",_
_foreground = colors.yellow_
_})_

_homeTab:addLabel({_
_x = 2,_
_y = 4,_
_text = "This is a TabControl",_
_foreground = colors.white_
_})_

_homeTab:addLabel({_
_x = 2,_
_y = 5,_
_text = "example with tabs.",_
_foreground = colors.white_
_})_

_-- Tab 2: Counter_
_local counterTab = tabControl:newTab("Counter")_

_local counterLabel = counterTab:addLabel({_
_x = 2,_
_y = 2,_
_text = "Count: 0",_
_foreground = colors.lime_
_})_

_local count = 0_
_counterTab:addButton({_
_x = 2,_
_y = 4,_
_width = 12,_
_height = 3,_
_text = "Click Me",_
_background = colors.blue_
_})_
_:setBackgroundState("clicked", colors.lightBlue)_
_:onClick(function()_
_count = count + 1_
_counterLabel:setText("Count: " .. count)_
_end)_

_-- Tab 3: Info_
_local infoTab = tabControl:newTab("Info")_

_infoTab:addLabel({_
_x = 2,_
_y = 2,_
_text = "TabControl Features:",_
_foreground = colors.orange_
_})_

_infoTab:addLabel({_
_x = 2,_
_y = 4,_
_text = "- Horizontal tabs",_
_foreground = colors.gray_
_})_

_infoTab:addLabel({_
_x = 2,_
_y = 5,_
_text = "- Easy navigation",_
_foreground = colors.gray_
_})_

_infoTab:addLabel({_
_x = 2,_
_y = 6,_
_text = "- Content per tab",_
_foreground = colors.gray_
_})_

_basalt.run()_
_]]_

Extends: `Container`

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
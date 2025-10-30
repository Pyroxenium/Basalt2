# Accordion
_The Accordion is a container that provides collapsible panel functionality_

Extends: `Container`

## Examples (Executable)
```lua run
local basalt = require("basalt")

local main = basalt.getMainFrame()

-- Create an Accordion
local accordion = main:addAccordion({
x = 2,
y = 2,
width = 30,
height = 15,
allowMultiple = true, -- Only one panel open at a time
headerBackground = colors.gray,
headerTextColor = colors.white,
expandedHeaderBackground = colors.lightBlue,
expandedHeaderTextColor = colors.white,
})

-- Panel 1: Info
local infoPanel = accordion:newPanel("Information", true) -- starts expanded
infoPanel:addLabel({
x = 2,
y = 1,
text = "This is an accordion",
foreground = colors.yellow
})
infoPanel:addLabel({
x = 2,
y = 2,
text = "with collapsible panels.",
foreground = colors.white
})

-- Panel 2: Settings
local settingsPanel = accordion:newPanel("Settings", false)
settingsPanel:addLabel({
x = 2,
y = 1,
text = "Volume:",
foreground = colors.white
})
local volumeSlider = settingsPanel:addSlider({
x = 10,
y = 1,
width = 15,
value = 50
})
settingsPanel:addLabel({
x = 2,
y = 3,
text = "Auto-save:",
foreground = colors.white
})
settingsPanel:addSwitch({
x = 13,
y = 3,
})

-- Panel 3: Actions
local actionsPanel = accordion:newPanel("Actions", false)
local statusLabel = actionsPanel:addLabel({
x = 2,
y = 4,
text = "Ready",
foreground = colors.lime
})

actionsPanel:addButton({
x = 2,
y = 1,
width = 10,
height = 1,
text = "Save",
background = colors.green,
foreground = colors.white,
})

actionsPanel:addButton({
x = 14,
y = 1,
width = 10,
height = 1,
text = "Cancel",
background = colors.red,
foreground = colors.white,
})

-- Panel 4: About
local aboutPanel = accordion:newPanel("About", false)
aboutPanel:addLabel({
x = 2,
y = 1,
text = "Basalt Accordion v1.0",
foreground = colors.white
})
aboutPanel:addLabel({
x = 2,
y = 2,
text = "A collapsible panel",
foreground = colors.gray
})
aboutPanel:addLabel({
x = 2,
y = 3,
text = "component for UI.",
foreground = colors.gray
})

-- Instructions
main:addLabel({
x = 2,
y = 18,
text = "Click panel headers to expand/collapse",
foreground = colors.lightGray
})

basalt.run()
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|panels|table|{}|List of panel definitions|
|panelHeaderHeight|number|1|Height of each panel header|
|allowMultiple|boolean|false|Allow multiple panels to be open at once|
|headerBackground|color|gray|Background color for panel headers|
|headerTextColor|color|white|Text color for panel headers|
|expandedHeaderBackground|color|lightGray|Background color for expanded panel headers|
|expandedHeaderTextColor|color|black|Text color for expanded panel headers|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Accordion:newPanel](#accordion-newpanel-title-expanded)|table|Creates a new accordion panel|
|[Accordion:togglePanel](#accordion-togglepanel-panelid)|Accordion|Toggles a panel's expanded state|
|[Accordion:expandPanel](#accordion-expandpanel-panelid)|Accordion|Expands a specific panel|
|[Accordion:collapsePanel](#accordion-collapsepanel-panelid)|Accordion|Collapses a specific panel|
|[Accordion:getPanel](#accordion-getpanel-panelid)|container|Gets a panel container by ID|

## Accordion:newPanel(title, expanded)

Creates a new panel and returns the panel's container

### Parameters
* `title` `string` The title of the panel
* `expanded` `boolean` Whether the panel starts expanded (default: false)

### Returns
* `table` `panelContainer` The container for this panel

## Accordion:togglePanel(panelId)
### Parameters
* `panelId` `number` The ID of the panel to toggle

### Returns
* `Accordion` `self` For method chaining

## Accordion:expandPanel(panelId)
### Parameters
* `panelId` `number` The ID of the panel to expand

### Returns
* `Accordion` `self` For method chaining

## Accordion:collapsePanel(panelId)
### Parameters
* `panelId` `number` The ID of the panel to collapse

### Returns
* `Accordion` `self` For method chaining

## Accordion:getPanel(panelId)
### Parameters
* `panelId` `number` The ID of the panel

### Returns
* `container` `The` panel's container or nil

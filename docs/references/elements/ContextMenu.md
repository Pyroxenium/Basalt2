# ContextMenu
_The ContextMenu displays a list of clickable items with optional submenus_

Extends: `Container`

## Examples (Executable)
```lua run
local basalt = require("basalt")

local main = basalt.getMainFrame()

-- Create a label that shows the selected action
local statusLabel = main:addLabel({
x = 2,
y = 2,
text = "Right-click anywhere!",
foreground = colors.yellow
})

-- Create a ContextMenu
local contextMenu = main:addContextMenu({
x = 10,
y = 5,
background = colors.black,
foreground = colors.white,
})

contextMenu:setItems({
{
label = "Copy",
onClick = function()
statusLabel:setText("Action: Copy")
end
},
{
label = "Paste",
onClick = function()
statusLabel:setText("Action: Paste")
end
},
{
label = "Delete",
background = colors.red,
foreground = colors.white,
onClick = function()
statusLabel:setText("Action: Delete")
end
},
{label = "---", disabled = true},
{
label = "More Options",
submenu = {
{
label = "Option 1",
onClick = function()
statusLabel:setText("Action: Option 1")
end
},
{
label = "Option 2",
onClick = function()
statusLabel:setText("Action: Option 2")
end
},
{label = "---", disabled = true},
{
label = "Nested",
submenu = {
{
label = "Deep 1",
onClick = function()
statusLabel:setText("Action: Deep 1")
end
}
}
}
}
},
{label = "---", disabled = true},
{
label = "Exit",
onClick = function()
statusLabel:setText("Action: Exit")
end
}
})

-- Open menu on right-click anywhere
main:onClick(function(self, button, x, y)
if button == 2 then
contextMenu.set("x", x)
contextMenu.set("y", y)
contextMenu:open()
basalt.LOGGER.info("Context menu opened at (" .. x .. ", " .. y .. ")")
end
end)

basalt.run()
```

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|items|table|{}|List of menu items|
|isOpen|boolean|false|Whether the menu is currently open|
|openSubmenu|table|nil|Currently open submenu data|
|itemHeight|number|1|Height of each menu item|

## Functions

|Method|Returns|Description|
|---|---|---|
|[ContextMenu:setItems](#contextmenu-setitems-items)|ContextMenu|Sets the menu items from a table|
|[ContextMenu:open](#contextmenu-open)|ContextMenu|Opens the context menu|
|[ContextMenu:close](#contextmenu-close)|ContextMenu|Closes the context menu|
|[ContextMenu:closeAll](#contextmenu-closeall)|ContextMenu|Closes the root menu and all child menus|

## ContextMenu:setItems(items)

Sets the menu items

### Parameters
* `items` `table` Array of item definitions

### Returns
* `ContextMenu` `self` For method chaining

## ContextMenu:open()

Opens the menu

### Returns
* `ContextMenu` `self` For method chaining

## ContextMenu:close()

Closes the menu and any submenus

### Returns
* `ContextMenu` `self` For method chaining

## ContextMenu:closeAll()

Closes the entire menu chain (parent and all submenus)

### Returns
* `ContextMenu` `self` For method chaining

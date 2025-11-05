local elementManager = require("elementManager")
local VisualElement = require("elements/VisualElement")
local Container = elementManager.getElement("Container")
local tHex = require("libraries/colorHex")
---@configDescription A ContextMenu element that displays a menu with items and submenus.
---@configDefault false

--- The ContextMenu displays a list of clickable items with optional submenus
--- @run [[
--- local basalt = require("basalt")
--- 
--- local main = basalt.getMainFrame()
--- 
--- -- Create a label that shows the selected action
--- local statusLabel = main:addLabel({
---     x = 2,
---     y = 2,
---     text = "Right-click anywhere!",
---     foreground = colors.yellow
--- })
--- 
--- -- Create a ContextMenu
--- local contextMenu = main:addContextMenu({
---     x = 10,
---     y = 5,
---     background = colors.black,
---     foreground = colors.white,
--- })
--- 
--- contextMenu:setItems({
---     {
---         label = "Copy",
---         onClick = function()
---             statusLabel:setText("Action: Copy")
---         end
---     },
---     {
---         label = "Paste",
---         onClick = function()
---             statusLabel:setText("Action: Paste")
---         end
---     },
---     {
---         label = "Delete",
---         background = colors.red,
---         foreground = colors.white,
---         onClick = function()
---             statusLabel:setText("Action: Delete")
---         end
---     },
---     {label = "---", disabled = true},
---     {
---         label = "More Options",
---         submenu = {
---             {
---                 label = "Option 1",
---                 onClick = function()
---                     statusLabel:setText("Action: Option 1")
---                 end
---             },
---             {
---                 label = "Option 2",
---                 onClick = function()
---                     statusLabel:setText("Action: Option 2")
---                 end
---             },
---             {label = "---", disabled = true},
---             {
---                 label = "Nested",
---                 submenu = {
---                     {
---                         label = "Deep 1",
---                         onClick = function()
---                             statusLabel:setText("Action: Deep 1")
---                         end
---                     }
---                 }
---             }
---         }
---     },
---     {label = "---", disabled = true},
---     {
---         label = "Exit",
---         onClick = function()
---             statusLabel:setText("Action: Exit")
---         end
---     }
--- })
--- 
--- -- Open menu on right-click anywhere
--- main:onClick(function(self, button, x, y)
---     if button == 2 then
---         contextMenu.set("x", x)
---         contextMenu.set("y", y)
---         contextMenu:open()
---         basalt.LOGGER.info("Context menu opened at (" .. x .. ", " .. y .. ")")
---     end
--- end)
--- 
--- basalt.run()
--- ]]
---@class ContextMenu : Container
local ContextMenu = setmetatable({}, Container)
ContextMenu.__index = ContextMenu

---@property items table {} List of menu items
ContextMenu.defineProperty(ContextMenu, "items", {default = {}, type = "table", canTriggerRender = true})
---@property isOpen boolean false Whether the menu is currently open
ContextMenu.defineProperty(ContextMenu, "isOpen", {default = false, type = "boolean", canTriggerRender = true})
---@property openSubmenu table nil Currently open submenu data
ContextMenu.defineProperty(ContextMenu, "openSubmenu", {default = nil, type = "table", allowNil = true})
---@property itemHeight number 1 Height of each menu item
ContextMenu.defineProperty(ContextMenu, "itemHeight", {default = 1, type = "number", canTriggerRender = true})

ContextMenu.defineEvent(ContextMenu, "mouse_click")

--- @shortDescription Creates a new ContextMenu instance
--- @return ContextMenu self The created instance
--- @private
function ContextMenu.new()
    local self = setmetatable({}, ContextMenu):__init()
    self.class = ContextMenu
    self.set("width", 10)
    self.set("height", 10)
    self.set("visible", false)
    return self
end

--- @shortDescription Initializes the ContextMenu instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @protected
function ContextMenu:init(props, basalt)
    Container.init(self, props, basalt)
    self.set("type", "ContextMenu")
end

--- Sets the menu items
--- @shortDescription Sets the menu items from a table
--- @param items table Array of item definitions
--- @return ContextMenu self For method chaining
function ContextMenu:setItems(items)
    self.set("items", items or {})
    self:calculateSize()
    return self
end

--- @shortDescription Calculates menu size based on items
--- @private
function ContextMenu:calculateSize()
    local items = self.getResolved("items")
    local itemHeight = self.getResolved("itemHeight")

    if #items == 0 then
        self.set("width", 10)
        self.set("height", 2)
        return
    end

    local maxWidth = 8
    for _, item in ipairs(items) do
        if item.label then
            local labelLen = #item.label
            local itemWidth = labelLen + 3
            if item.submenu then
                itemWidth = itemWidth + 1  -- " >" 
            end
            if itemWidth > maxWidth then
                maxWidth = itemWidth
            end
        end
    end

    local height = #items * itemHeight

    self.set("width", maxWidth)
    self.set("height", height)
end

--- Opens the menu
--- @shortDescription Opens the context menu
--- @return ContextMenu self For method chaining
function ContextMenu:open()
    self.set("isOpen", true)
    self.set("visible", true)
    self:updateRender()
    self:dispatchEvent("opened")
    return self
end

--- Closes the menu and any submenus
--- @shortDescription Closes the context menu
--- @return ContextMenu self For method chaining
function ContextMenu:close()
    self.set("isOpen", false)
    self.set("visible", false)

    local openSubmenu = self.getResolved("openSubmenu")
    if openSubmenu and openSubmenu.menu then
        openSubmenu.menu:close()
    end
    self.set("openSubmenu", nil)

    self:updateRender()
    self:dispatchEvent("closed")
    return self
end

--- Closes the entire menu chain (parent and all submenus)
--- @shortDescription Closes the root menu and all child menus
--- @return ContextMenu self For method chaining
function ContextMenu:closeAll()
    local root = self
    while root.parentMenu do
        root = root.parentMenu
    end

    root:close()
    return self
end

--- @shortDescription Gets item at Y position
--- @param y number Relative Y position
--- @return number? index Item index or nil
--- @return table? item Item data or nil
--- @private
function ContextMenu:getItemAt(y)
    local items = self.getResolved("items")
    local itemHeight = self.getResolved("itemHeight")

    local index = math.floor((y - 1) / itemHeight) + 1

    if index >= 1 and index <= #items then
        return index, items[index]
    end

    return nil, nil
end

--- @shortDescription Creates a submenu
--- @private
function ContextMenu:createSubmenu(submenuItems, parentItem)
    local submenu = self.parent:addContextMenu()
    submenu:setItems(submenuItems)

    submenu.set("background", self.getResolved("background"))
    submenu.set("foreground", self.getResolved("foreground"))

    submenu.parentMenu = self

    local parentX = self.getResolved("x")
    local parentY = self.getResolved("y")
    local parentWidth = self.getResolved("width")
    local itemHeight = self.getResolved("itemHeight")
    local itemIndex = parentItem._index or 1

    submenu.set("x", parentX + parentWidth)
    submenu.set("y", parentY + (itemIndex - 1) * itemHeight)
    submenu.set("z", self.getResolved("z") + 1)

    return submenu
end

--- @shortDescription Handles mouse click events
--- @protected
function ContextMenu:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then
        self:close()
        return false
    end

    local relX, relY = VisualElement.getRelativePosition(self, x, y)
    local index, item = self:getItemAt(relY)

    if item then
        if item.disabled then
            return true
        end

        if item.submenu then
            local openSubmenu = self.getResolved("openSubmenu")
            if openSubmenu and openSubmenu.index == index then
                openSubmenu.menu:close()
                self.set("openSubmenu", nil)
            else
                if openSubmenu and openSubmenu.menu then
                    openSubmenu.menu:close()
                end

                item._index = index
                local submenu = self:createSubmenu(item.submenu, item)
                submenu:open()

                self.set("openSubmenu", {
                    index = index,
                    menu = submenu
                })
            end
            return true
        end

        if item.onClick then
            item.onClick(item)
        end

        self:closeAll()
        return true
    end
    return true
end

--- @shortDescription Renders the ContextMenu
--- @protected
function ContextMenu:render()
    local items = self.getResolved("items")
    local width = self.getResolved("width")
    local height = self.getResolved("height")
    local itemHeight = self.getResolved("itemHeight")
    local menuBg = self.getResolved("background")
    local menuFg = self.getResolved("foreground")

    for i, item in ipairs(items) do
        local y = (i - 1) * itemHeight + 1
        local itemBg = item.background or menuBg
        local itemFg = item.foreground or menuFg
        local bgHex = tHex[itemBg]
        local fgHex = tHex[itemFg]

        local spaces = string.rep(" ", width)
        local bgColors = string.rep(bgHex, width)
        local fgColors = string.rep(fgHex, width)
        self:blit(1, y, spaces, fgColors, bgColors)

        local label = item.label or ""
        if #label > width - 3 then
            label = label:sub(1, width - 3)
        end

        self:textFg(2, y, label, itemFg)
        if item.submenu then
            self:textFg(width - 1, y, ">", itemFg)
        end
    end

    if not self.getResolved("childrenSorted") then
        self:sortChildren()
    end
    if not self.getResolved("childrenEventsSorted") then
        for eventName in pairs(self._values.childrenEvents or {}) do
            self:sortChildrenEvents(eventName)
        end
    end

    for _, child in ipairs(self.getResolved("visibleChildren") or {}) do
        if child == self then 
            error("CIRCULAR REFERENCE DETECTED!")
            return 
        end
        child:render()
        child:postRender()
    end
end

return ContextMenu
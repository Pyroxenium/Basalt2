local VisualElement = require("elements/VisualElement")
local List = require("elements/List")
local tHex = require("libraries/colorHex")
---@configDescription A horizontal menu bar with selectable items.

--- This is the menu class. It provides a horizontal menu bar with selectable items. Menu items are displayed in a single row and can have custom colors and callbacks.
---@class Menu : List
local Menu = setmetatable({}, List)
Menu.__index = Menu

---@property separatorColor color gray The color used for separator items in the menu
Menu.defineProperty(Menu, "separatorColor", {default = colors.gray, type = "color"})

---@property spacing number 0 The number of spaces between menu items
Menu.defineProperty(Menu, "spacing", {default = 1, type = "number", canTriggerRender = true})

---@property openDropdown table nil Currently open dropdown data {index, items, x, y, width, height}
Menu.defineProperty(Menu, "openDropdown", {default = nil, type = "table", allowNil = true, canTriggerRender = true})

---@property dropdownBackground color black Background color for dropdown menus
Menu.defineProperty(Menu, "dropdownBackground", {default = colors.black, type = "color", canTriggerRender = true})

---@property dropdownForeground color white Foreground color for dropdown menus
Menu.defineProperty(Menu, "dropdownForeground", {default = colors.white, type = "color", canTriggerRender = true})

---@property horizontalOffset number 0 Current horizontal scroll offset
Menu.defineProperty(Menu, "horizontalOffset", {
    default = 0,
    type = "number",
    canTriggerRender = true,
    setter = function(self, value)
        local maxOffset = math.max(0, self:getTotalWidth() - self.getResolved("width"))
        return math.min(maxOffset, math.max(0, value))
    end
})

---@property maxWidth number nil Maximum width before scrolling is enabled (nil = auto-size to items)
Menu.defineProperty(Menu, "maxWidth", {default = nil, type = "number", canTriggerRender = true})

---@tableType ItemTable
---@tableField text string The display text for the item
---@tableField callback function Function called when selected
---@tableField fg color Normal text color
---@tableField bg color Normal background color
---@tableField selectedFg color Text color when selected
---@tableField selectedBg color Background when selected
---@tableField dropdown table Array of dropdown items

local entrySchema = {
    text = { type = "string", default = "Entry" },
    bg = { type = "number", default = nil },
    fg = { type = "number", default = nil },
    selectedBg = { type = "number", default = nil },
    selectedFg = { type = "number", default = nil },
    callback = { type = "function", default = nil },
    dropdown = { type = "table", default = nil },
}

--- Creates a new Menu instance
--- @shortDescription Creates a new Menu instance
--- @return Menu self The newly created Menu instance
--- @private
function Menu.new()
    local self = setmetatable({}, Menu):__init()
    self.class = Menu
    self.set("width", 30)
    self.set("height", 1)
    self.set("z", 8)
    return self
end

--- @shortDescription Initializes the Menu instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Menu self The initialized instance
--- @protected
function Menu:init(props, basalt)
    List.init(self, props, basalt)
    self._entrySchema = entrySchema
    self.set("type", "Menu")

    self:observe("items", function()
        local maxWidth = self.getResolved("maxWidth")
        if maxWidth then
            self.set("width", math.min(maxWidth, self:getTotalWidth()), true)
        else
            self.set("width", self:getTotalWidth(), true)
        end
    end)

    return self
end

--- Calculates the total width of all menu items with spacing
--- @shortDescription Calculates total width of menu items
--- @return number totalWidth The total width of all items
function Menu:getTotalWidth()
    local items = self.getResolved("items")
    local spacing = self.getResolved("spacing")
    local totalWidth = 0

    for i, item in ipairs(items) do
        if type(item) == "table" then
            totalWidth = totalWidth + #item.text
        else
            totalWidth = totalWidth + #tostring(item) + 2
        end

        if i < #items then
            totalWidth = totalWidth + spacing
        end
    end

    return totalWidth
end

--- @shortDescription Renders the menu horizontally with proper spacing and colors
--- @protected
function Menu:render()
    VisualElement.render(self)
    local viewportWidth = self.getResolved("width")
    local spacing = self.getResolved("spacing")
    local offset = self.getResolved("horizontalOffset")
    local items = self.getResolved("items")

    local itemPositions = {}
    local currentX = 1

    for i, item in ipairs(items) do
        if type(item) == "string" then
            item = {text = " "..item.." "}
            items[i] = item
        end

        itemPositions[i] = {
            startX = currentX,
            endX = currentX + #item.text - 1,
            text = item.text,
            item = item
        }

        currentX = currentX + #item.text

        if i < #items and spacing > 0 then
            currentX = currentX + spacing
        end
    end

    for i, pos in ipairs(itemPositions) do
        local item = pos.item
        local itemStartInViewport = pos.startX - offset
        local itemEndInViewport = pos.endX - offset

        if itemStartInViewport > viewportWidth then
            break
        end

        if itemEndInViewport >= 1 then
            local visibleStart = math.max(1, itemStartInViewport)
            local visibleEnd = math.min(viewportWidth, itemEndInViewport)
            local textStartIdx = math.max(1, 1 - itemStartInViewport + 1)
            local textEndIdx = math.min(#pos.text, #pos.text - (itemEndInViewport - viewportWidth))
            local visibleText = pos.text:sub(textStartIdx, textEndIdx)

            if #visibleText > 0 then
                local isSelected = item.selected
                local fg = item.selectable == false and self.getResolved("separatorColor") or
                    (isSelected and (item.selectedForeground or self.getResolved("selectedForeground")) or
                    (item.foreground or self.getResolved("foreground")))

                local bg = isSelected and
                    (item.selectedBackground or self.getResolved("selectedBackground")) or
                    (item.background or self.getResolved("background"))

                self:blit(visibleStart, 1, visibleText,
                    string.rep(tHex[fg], #visibleText),
                    string.rep(tHex[bg], #visibleText))
            end

            if i < #items and spacing > 0 then
                local spacingStart = pos.endX + 1 - offset
                local spacingEnd = spacingStart + spacing - 1

                if spacingEnd >= 1 and spacingStart <= viewportWidth then
                    local visibleSpacingStart = math.max(1, spacingStart)
                    local visibleSpacingEnd = math.min(viewportWidth, spacingEnd)
                    local spacingWidth = visibleSpacingEnd - visibleSpacingStart + 1

                    if spacingWidth > 0 then
                        local spacingText = string.rep(" ", spacingWidth)
                        self:blit(visibleSpacingStart, 1, spacingText,
                            string.rep(tHex[self.getResolved("foreground")], spacingWidth),
                            string.rep(tHex[self.getResolved("background")], spacingWidth))
                    end
                end
            end
        end
    end

    local openDropdown = self.getResolved("openDropdown")
    if openDropdown then
        self:renderDropdown(openDropdown)
    end
end

--- Renders the dropdown menu
--- @shortDescription Renders dropdown overlay
--- @param dropdown table Dropdown data
--- @protected
function Menu:renderDropdown(dropdown)
    local dropdownBg = self.getResolved("dropdownBackground")
    local dropdownFg = self.getResolved("dropdownForeground")

    for i, item in ipairs(dropdown.items) do
        local y = dropdown.y + i - 1
        local label = item.text or item.label or ""

        local isSeparator = label == "---"

        local bgHex = tHex[item.background or dropdownBg]
        local fgHex = tHex[item.foreground or dropdownFg]
        local spaces = string.rep(" ", dropdown.width)

        self:blit(dropdown.x, y, spaces,
            string.rep(fgHex, dropdown.width),
            string.rep(bgHex, dropdown.width))

        if isSeparator then
            local separator = string.rep("-", dropdown.width)
            self:blit(dropdown.x, y, separator,
                string.rep(tHex[colors.gray], dropdown.width),
                string.rep(bgHex, dropdown.width))
        else
            if #label > dropdown.width - 2 then
                label = label:sub(1, dropdown.width - 2)
            end
            self:textFg(dropdown.x + 1, y, label, item.foreground or dropdownFg)
        end
    end
end

--- @shortDescription Handles mouse click events and item selection
--- @protected
function Menu:mouse_click(button, x, y)
    local openDropdown = self.getResolved("openDropdown")
    if openDropdown then
        local relX, relY = self:getRelativePosition(x, y)

        if self:isInsideDropdown(relX, relY, openDropdown) then
            return self:handleDropdownClick(relX, relY, openDropdown)
        else
            self:hideDropdown()
        end
    end

    if not VisualElement.mouse_click(self, button, x, y) then
        return false
    end

    if(self.getResolved("selectable") == false) then return false end
    local relX = select(1, self:getRelativePosition(x, y))
    local offset = self.getResolved("horizontalOffset")
    local spacing = self.getResolved("spacing")
    local items = self.getResolved("items")

    local virtualX = relX + offset
    local currentX = 1

    for i, item in ipairs(items) do
        local itemWidth = #item.text

        if virtualX >= currentX and virtualX < currentX + itemWidth then
            if item.selectable ~= false then
                if type(item) == "string" then
                    item = {text = item}
                    items[i] = item
                end

                if item.dropdown and #item.dropdown > 0 then
                    self:showDropdown(i, item, currentX - offset)
                    return true
                end

                if not self.getResolved("multiSelection") then
                    for _, otherItem in ipairs(items) do
                        if type(otherItem) == "table" then
                            otherItem.selected = false
                        end
                    end
                end

                item.selected = not item.selected

                if item.callback then
                    item.callback(self)
                end
                self:fireEvent("select", i, item)
            end
            return true
        end
        currentX = currentX + itemWidth

        if i < #items and spacing > 0 then
            currentX = currentX + spacing
        end
    end
    return false
end

--- @shortDescription Handles mouse scroll events for horizontal scrolling
--- @protected
function Menu:mouse_scroll(direction, x, y)
    if VisualElement.mouse_scroll(self, direction, x, y) then
        local offset = self.getResolved("horizontalOffset")
        local maxOffset = math.max(0, self:getTotalWidth() - self.getResolved("width"))

        offset = math.min(maxOffset, math.max(0, offset + (direction * 3)))
        self.set("horizontalOffset", offset)
        return true
    end
    return false
end

--- Shows a dropdown menu for a specific item
--- @shortDescription Shows dropdown menu
--- @param index number The item index
--- @param item table The menu item
--- @param itemX number The X position of the item
function Menu:showDropdown(index, item, itemX)
    local dropdown = item.dropdown
    if not dropdown or #dropdown == 0 then return end

    local maxWidth = 8
    for _, dropItem in ipairs(dropdown) do
        local label = dropItem.text or dropItem.label or ""
        if #label + 2 > maxWidth then
            maxWidth = #label + 2
        end
    end

    local height = #dropdown
    local menuHeight = self.getResolved("height")

    self.set("openDropdown", {
        index = index,
        items = dropdown,
        x = itemX,
        y = menuHeight + 1,
        width = maxWidth,
        height = height
    })

    self:updateRender()
end

--- Closes the currently open dropdown
--- @shortDescription Closes dropdown menu
function Menu:hideDropdown()
    self.set("openDropdown", nil)
    self:updateRender()
end

--- Checks if a position is inside the dropdown
--- @shortDescription Checks if position is in dropdown
--- @param relX number Relative X position
--- @param relY number Relative Y position
--- @param dropdown table Dropdown data
--- @return boolean inside Whether position is inside dropdown
function Menu:isInsideDropdown(relX, relY, dropdown)
    return relX >= dropdown.x and 
           relX < dropdown.x + dropdown.width and
           relY >= dropdown.y and
           relY < dropdown.y + dropdown.height
end

--- Handles click inside dropdown
--- @shortDescription Handles dropdown click
--- @param relX number Relative X position
--- @param relY number Relative Y position
--- @param dropdown table Dropdown data
--- @return boolean handled Whether click was handled
function Menu:handleDropdownClick(relX, relY, dropdown)
    local itemIndex = relY - dropdown.y + 1

    if itemIndex >= 1 and itemIndex <= #dropdown.items then
        local item = dropdown.items[itemIndex]

        if item.text == "---" or item.label == "---" or item.disabled then
            return true
        end

        if item.callback then
            item.callback(self, item)
        elseif item.onClick then
            item.onClick(self, item)
        end

        self:hideDropdown()
        return true
    end
    return false
end

return Menu
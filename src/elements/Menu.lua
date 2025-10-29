local VisualElement = require("elements/VisualElement")
local List = require("elements/List")
local tHex = require("libraries/colorHex")
---@configDescription A horizontal menu bar with selectable items.

--- This is the menu class. It provides a horizontal menu bar with selectable items. Menu items are displayed in a single row and can have custom colors and callbacks.
---@class Menu : List
local Menu = setmetatable({}, List)
Menu.__index = Menu

---@tableType ItemTable
---@tableField text string The display text for the item
---@tableField callback function Function called when selected
---@tableField fg color Normal text color
---@tableField bg color Normal background color
---@tableField selectedFg color Text color when selected
---@tableField selectedBg color Background when selected

---@property separatorColor color gray The color used for separator items in the menu
Menu.defineProperty(Menu, "separatorColor", {default = colors.gray, type = "color"})

---@property spacing number 0 The number of spaces between menu items
Menu.defineProperty(Menu, "spacing", {default = 1, type = "number", canTriggerRender = true})

---@property horizontalOffset number 0 Current horizontal scroll offset
Menu.defineProperty(Menu, "horizontalOffset", {
    default = 0,
    type = "number",
    canTriggerRender = true,
    setter = function(self, value)
        local maxOffset = math.max(0, self:getTotalWidth() - self.get("width"))
        return math.min(maxOffset, math.max(0, value))
    end
})

---@property maxWidth number nil Maximum width before scrolling is enabled (nil = auto-size to items)
Menu.defineProperty(Menu, "maxWidth", {default = nil, type = "number", canTriggerRender = true})

--- Creates a new Menu instance
--- @shortDescription Creates a new Menu instance
--- @return Menu self The newly created Menu instance
--- @private
function Menu.new()
    local self = setmetatable({}, Menu):__init()
    self.class = Menu
    self.set("width", 30)
    self.set("height", 1)
    self.set("background", colors.gray)
    return self
end

--- @shortDescription Initializes the Menu instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Menu self The initialized instance
--- @protected
function Menu:init(props, basalt)
    List.init(self, props, basalt)
    self.set("type", "Menu")

    self:observe("items", function()
        local maxWidth = self.get("maxWidth")
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
    local items = self.get("items")
    local spacing = self.get("spacing")
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
    local viewportWidth = self.get("width")
    local spacing = self.get("spacing")
    local offset = self.get("horizontalOffset")
    local items = self.get("items")

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
                local fg = item.selectable == false and self.get("separatorColor") or
                    (isSelected and (item.selectedForeground or self.get("selectedForeground")) or
                    (item.foreground or self.get("foreground")))

                local bg = isSelected and
                    (item.selectedBackground or self.get("selectedBackground")) or
                    (item.background or self.get("background"))

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
                            string.rep(tHex[self.get("foreground")], spacingWidth),
                            string.rep(tHex[self.get("background")], spacingWidth))
                    end
                end
            end
        end
    end
end

--- @shortDescription Handles mouse click events and item selection
--- @protected
function Menu:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end
    if(self.get("selectable") == false) then return false end
    local relX = select(1, self:getRelativePosition(x, y))
    local offset = self.get("horizontalOffset")
    local spacing = self.get("spacing")
    local items = self.get("items")

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

                if not self.get("multiSelection") then
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
        local offset = self.get("horizontalOffset")
        local maxOffset = math.max(0, self:getTotalWidth() - self.get("width"))

        offset = math.min(maxOffset, math.max(0, offset + (direction * 3)))
        self.set("horizontalOffset", offset)
        return true
    end
    return false
end

return Menu

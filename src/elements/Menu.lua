local VisualElement = require("elements/VisualElement")
local List = require("elements/List")
local tHex = require("libraries/colorHex")
---@configDescription A horizontal menu bar with selectable items.

--- This is the menu class. It provides a horizontal menu bar with selectable items.
--- Menu items are displayed in a single row and can have custom colors and callbacks.
---@class Menu : List
local Menu = setmetatable({}, List)
Menu.__index = Menu

---@property separatorColor color gray The color used for separator items in the menu
Menu.defineProperty(Menu, "separatorColor", {default = colors.gray, type = "color"})

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
    return self
end

--- Sets the menu items
--- @shortDescription Sets the menu items and calculates total width
--- @param items table[] List of items with {text, separator, callback, foreground, background} properties
--- @return Menu self The Menu instance
--- @usage menu:setItems({{text="File"}, {separator=true}, {text="Edit"}})
function Menu:setItems(items)
    local listItems = {}
    local totalWidth = 0
    for _, item in ipairs(items) do
        if item.separator then
            table.insert(listItems, {text = item.text or "|", selectable = false})
            totalWidth = totalWidth + 1
        else
            local text = " " .. item.text .. " "
            item.text = text
            table.insert(listItems, item)
            totalWidth = totalWidth + #text
        end
    end
    self.set("width", totalWidth)
    return List.setItems(self, listItems)
end

--- @shortDescription Renders the menu horizontally with proper spacing and colors
--- @protected
function Menu:render()
    VisualElement.render(self)
    local currentX = 1

    for i, item in ipairs(self.get("items")) do
        if type(item) == "string" then
            item = {text = " "..item.." "}
            self.get("items")[i] = item
        end

        local isSelected = item.selected
        local fg = item.selectable == false and self.get("separatorColor") or
            (isSelected and (item.selectedForeground or self.get("selectedForeground")) or
            (item.foreground or self.get("foreground")))

        local bg = isSelected and
            (item.selectedBackground or self.get("selectedBackground")) or
            (item.background or self.get("background"))

        self:blit(currentX, 1, item.text,
            string.rep(tHex[fg], #item.text),
            string.rep(tHex[bg], #item.text))

        currentX = currentX + #item.text
    end
end

--- @shortDescription Handles mouse click events and item selection
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean Whether the event was handled
--- @protected
function Menu:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end
    if(self.get("selectable") == false) then return false end
    local relX = select(1, self:getRelativePosition(x, y))
    local currentX = 1

    for i, item in ipairs(self.get("items")) do
        if relX >= currentX and relX < currentX + #item.text then
            if item.selectable ~= false then
                if type(item) == "string" then
                    item = {text = item}
                    self.get("items")[i] = item
                end

                if not self.get("multiSelection") then
                    for _, otherItem in ipairs(self.get("items")) do
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
        currentX = currentX + #item.text
    end
    return false
end

return Menu

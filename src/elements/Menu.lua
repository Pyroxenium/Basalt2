local VisualElement = require("elements/VisualElement")
local List = require("elements/List")
local tHex = require("libraries/colorHex")

---@class Menu : List
local Menu = setmetatable({}, List)
Menu.__index = Menu

Menu.defineProperty(Menu, "separatorColor", {default = colors.gray, type = "number"})

function Menu.new(props, basalt)
    local self = setmetatable({}, Menu):__init()
    self.set("width", 30)
    self.set("height", 1)
    self.set("background", colors.gray)
    self:init(props, basalt)
    return self
end

function Menu:init(props, basalt)
    List.init(self, props, basalt)
    self.set("type", "Menu")
    return self
end

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

function Menu:render()
    VisualElement.render(self)
    local currentX = 1

    for i, item in ipairs(self.get("items")) do
        local isSelected = i == self.get("selectedIndex")

        local fg = item.selectable == false and self.get("separatorColor") or
            (isSelected and (item.selectedForeground or self.get("foreground")) or
            (item.foreground or self.get("foreground")))

        local bg = isSelected and
            (item.selectedBackground or self.get("selectedColor")) or
            (item.background or self.get("background"))

        self:blit(currentX, 1, item.text,
            string.rep(tHex[fg], #item.text),
            string.rep(tHex[bg], #item.text))

        currentX = currentX + #item.text
    end
end

function Menu:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end
    if(self.get("selectable") == false) then return false end
    local relX = select(1, self:getRelativePosition(x, y))
    local currentX = 1

    for i, item in ipairs(self.get("items")) do
        if relX >= currentX and relX < currentX + #item.text then
            if item.selectable ~= false then
                self.set("selectedIndex", i)
                if type(item) == "table" then
                    if item.callback then
                        item.callback(self)
                    end
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

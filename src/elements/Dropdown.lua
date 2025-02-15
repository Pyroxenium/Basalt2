local VisualElement = require("elements/VisualElement")
local List = require("elements/List")
local tHex = require("libraries/colorHex")

---@class Dropdown : List
local Dropdown = setmetatable({}, List)
Dropdown.__index = Dropdown

Dropdown.defineProperty(Dropdown, "isOpen", {default = false, type = "boolean", canTriggerRender = true})
Dropdown.defineProperty(Dropdown, "dropdownHeight", {default = 5, type = "number"})
Dropdown.defineProperty(Dropdown, "selectedText", {default = "", type = "string"})
Dropdown.defineProperty(Dropdown, "dropSymbol", {default = "\31", type = "string"})  -- ▼ Symbol

function Dropdown.new(props, basalt)
    local self = setmetatable({}, Dropdown):__init()
    self.set("width", 16)
    self.set("height", 1)  -- Dropdown ist initial nur 1 Zeile hoch
    self.set("z", 8)
    self:init(props, basalt)
    return self
end

function Dropdown:init(props, basalt)
    List.init(self, props, basalt)
    self.set("type", "Dropdown")
end

function Dropdown:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end
    
    local relX, relY = self:getRelativePosition(x, y)
    
    if relY == 1 then  -- Klick auf Header
        self.set("isOpen", not self.get("isOpen"))
        if not self.get("isOpen") then
            self.set("height", 1)
        else
            self.set("height", 1 + math.min(self.get("dropdownHeight"), #self.get("items")))
        end
        return true
    elseif self.get("isOpen") and relY > 1 then
        -- Offset für die Liste korrigieren (relY - 1 wegen Header)
        local index = relY - 1 + self.get("offset")
        local items = self.get("items")

        if index <= #items then
            local item = items[index]
            if type(item) == "table" and item.separator then
                return false
            end
            
            self.set("selectedIndex", index)
            self.set("isOpen", false)
            self.set("height", 1)

            if type(item) == "table" and item.callback then
                item.callback(self)
            end

            self:fireEvent("select", index, item)
            return true
        end
    end
    return false
end

function Dropdown:render()
    VisualElement.render(self)
    
    -- Header rendern
    local text = self.get("selectedText")
    if #text == 0 and self.get("selectedIndex") > 0 then
        local item = self.get("items")[self.get("selectedIndex")]
        text = type(item) == "table" and item.text or tostring(item)
    end
    
    self:blit(1, 1, text .. string.rep(" ", self.get("width") - #text - 1) .. (self.get("isOpen") and "\31" or "\17"),
        string.rep(tHex[self.get("foreground")], self.get("width")),
        string.rep(tHex[self.get("background")], self.get("width")))

    -- Items nur rendern wenn offen
    if self.get("isOpen") then
        local items = self.get("items")
        local offset = self.get("offset")
        local selected = self.get("selectedIndex")
        local width = self.get("width")

        -- Liste ab Zeile 2 rendern (unterhalb des Headers)
        for i = 2, self.get("height") do
            local itemIndex = i - 1 + offset  -- -1 wegen Header
            local item = items[itemIndex]

            if item then
                if type(item) == "table" and item.separator then
                    local separatorChar = (item.text or "-"):sub(1,1)
                    local separatorText = string.rep(separatorChar, width)
                    local fg = item.foreground or self.get("foreground")
                    local bg = item.background or self.get("background")

                    self:textBg(1, i, string.rep(" ", width), bg)
                    self:textFg(1, i, separatorText, fg)
                else
                    local itemText = type(item) == "table" and item.text or tostring(item)
                    local isSelected = itemIndex == selected
                    
                    local bg = isSelected and 
                        (item.selectedBackground or self.get("selectedColor")) or
                        (item.background or self.get("background"))

                    local fg = isSelected and 
                        (item.selectedForeground or colors.white) or 
                        (item.foreground or self.get("foreground"))

                    self:textBg(1, i, string.rep(" ", width), bg)
                    self:textFg(1, i, itemText, fg)
                end
            end
        end
    end
end

return Dropdown

local VisualElement = require("elements/VisualElement")
local List = require("elements/List")
local tHex = require("libraries/colorHex")

---@configDescription A dropdown menu that shows a list of selectable items
---@configDefault false

--- This is the dropdown class. It is a visual element that can show a list of selectable items in a dropdown menu.
---@class Dropdown : List

local Dropdown = setmetatable({}, List)
Dropdown.__index = Dropdown

---@property isOpen boolean false Whether the dropdown menu is currently open
Dropdown.defineProperty(Dropdown, "isOpen", {default = false, type = "boolean", canTriggerRender = true})
---@property dropdownHeight number 5 Maximum height of the dropdown menu when open
Dropdown.defineProperty(Dropdown, "dropdownHeight", {default = 5, type = "number"})
---@property selectedText string "" The text to show when no item is selected
Dropdown.defineProperty(Dropdown, "selectedText", {default = "", type = "string"})
---@property dropSymbol string "\31" The symbol to show for dropdown indication
Dropdown.defineProperty(Dropdown, "dropSymbol", {default = "\31", type = "string"})

--- Creates a new Dropdown instance
--- @shortDescription Creates a new Dropdown instance
--- @return Dropdown self The newly created Dropdown instance
--- @usage local dropdown = Dropdown.new()
function Dropdown.new()
    local self = setmetatable({}, Dropdown):__init()
    self.set("width", 16)
    self.set("height", 1)
    self.set("z", 8)
    return self
end

--- Initializes the Dropdown instance
--- @shortDescription Initializes the Dropdown instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Dropdown self The initialized instance
function Dropdown:init(props, basalt)
    List.init(self, props, basalt)
    self.set("type", "Dropdown")
    return self
end

--- Handles mouse click events
--- @shortDescription Handles mouse click events
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
function Dropdown:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end

    local relX, relY = self:getRelativePosition(x, y)

    if relY == 1 then
        self.set("isOpen", not self.get("isOpen"))
        if not self.get("isOpen") then
            self.set("height", 1)
        else
            self.set("height", 1 + math.min(self.get("dropdownHeight"), #self.get("items")))
        end
        return true
    elseif self.get("isOpen") and relY > 1 then
        -- Nutze List's mouse_click für Item-Selektion
        List.mouse_click(self, button, x, y)
        -- Nach Selektion Dropdown schließen
        self.set("isOpen", false)
        self.set("height", 1)
        return true
    end
    return false
end

--- Renders the Dropdown
--- @shortDescription Renders the Dropdown
function Dropdown:render()
    VisualElement.render(self)

    -- Header rendern
    local text = self.get("selectedText")
    if #text == 0 then
        -- Suche nach selektiertem Item
        local selectedItems = self:getSelectedItems()
        if #selectedItems > 0 then
            local selectedItem = selectedItems[1].item
            text = selectedItem.text or ""
        end
    end

    -- Header mit Dropdown Symbol
    self:blit(1, 1, text .. string.rep(" ", self.get("width") - #text - 1) .. (self.get("isOpen") and "\31" or "\17"),
        string.rep(tHex[self.get("foreground")], self.get("width")),
        string.rep(tHex[self.get("background")], self.get("width")))

    -- Liste rendern wenn offen
    if self.get("isOpen") then
        -- Offset um 1 verschieben wegen Header
        local oldOffset = self.get("offset")
        self.set("offset", oldOffset + 1)
        -- Liste ab Zeile 2 rendern
        List.render(self)
        -- Offset zurücksetzen
        self.set("offset", oldOffset)
    end
end

return Dropdown

local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")

---@class Table : VisualElement
local Table = setmetatable({}, VisualElement)
Table.__index = Table

Table.defineProperty(Table, "columns", {default = {}, type = "table"})
Table.defineProperty(Table, "data", {default = {}, type = "table", canTriggerRender = true})
Table.defineProperty(Table, "selectedRow", {default = nil, type = "number", canTriggerRender = true})
Table.defineProperty(Table, "headerColor", {default = colors.blue, type = "number"})
Table.defineProperty(Table, "selectedColor", {default = colors.lightBlue, type = "number"})
Table.defineProperty(Table, "gridColor", {default = colors.gray, type = "number"})
Table.defineProperty(Table, "sortColumn", {default = nil, type = "number"})
Table.defineProperty(Table, "sortDirection", {default = "asc", type = "string"})
Table.defineProperty(Table, "scrollOffset", {default = 0, type = "number", canTriggerRender = true})

Table.listenTo(Table, "mouse_click")
Table.listenTo(Table, "mouse_scroll")

function Table.new(props, basalt)
    local self = setmetatable({}, Table):__init()
    self.set("width", 30)
    self.set("height", 10)
    self.set("z", 5)
    self:init(props, basalt)
    return self
end

function Table:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Table")
    return self
end

function Table:setColumns(columns)
    -- Columns Format: {{name="ID", width=4}, {name="Name", width=10}}
    self.set("columns", columns)
    return self
end

function Table:setData(data)
    -- Data Format: {{"1", "Item One"}, {"2", "Item Two"}}
    self.set("data", data)
    return self
end

function Table:sortData(columnIndex)
    local data = self.get("data")
    local direction = self.get("sortDirection")
    
    table.sort(data, function(a, b)
        if direction == "asc" then
            return a[columnIndex] < b[columnIndex]
        else
            return a[columnIndex] > b[columnIndex]
        end
    end)
    
    self.set("data", data)
    return self
end

function Table:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end

    local relX, relY = self:getRelativePosition(x, y)

    -- Header-Click für Sorting
    if relY == 1 then
        local currentX = 1
        for i, col in ipairs(self.get("columns")) do
            if relX >= currentX and relX < currentX + col.width then
                if self.get("sortColumn") == i then
                    self.set("sortDirection", self.get("sortDirection") == "asc" and "desc" or "asc")
                else
                    self.set("sortColumn", i)
                    self.set("sortDirection", "asc")
                end
                self:sortData(i)
                break
            end
            currentX = currentX + col.width
        end
    end

    -- Row-Selection (berücksichtigt Scroll-Offset)
    if relY > 1 then
        local rowIndex = relY - 2 + self.get("scrollOffset")
        if rowIndex >= 0 and rowIndex < #self.get("data") then
            self.set("selectedRow", rowIndex + 1)
        end
    end

    return true
end

function Table:mouse_scroll(direction, x, y)
    local data = self.get("data")
    local height = self.get("height")
    local visibleRows = height - 2
    local maxScroll = math.max(0, #data - visibleRows + 1)  -- +1 korrigiert den Scroll-Bereich
    local newOffset = math.min(maxScroll, math.max(0, self.get("scrollOffset") + direction))

    self.set("scrollOffset", newOffset)
    return true
end

function Table:render()
    VisualElement.render(self)

    local columns = self.get("columns")
    local data = self.get("data")
    local selected = self.get("selectedRow")
    local sortCol = self.get("sortColumn")
    local scrollOffset = self.get("scrollOffset")
    local height = self.get("height")

    local currentX = 1
    for i, col in ipairs(columns) do
        local text = col.name
        if i == sortCol then
            text = text .. (self.get("sortDirection") == "asc" and "\30" or "\31")
        end
        self:textFg(currentX, 1, text:sub(1, col.width), self.get("headerColor"))
        currentX = currentX + col.width
    end

    -- Angepasste Berechnung der sichtbaren Zeilen
    local visibleRows = height - 2  -- Verfügbare Zeilen (minus Header)
    for y = 2, height do
        local rowIndex = y - 2 + scrollOffset
        local rowData = data[rowIndex + 1]

        -- Zeile nur rendern wenn es auch Daten dafür gibt
        if rowData and (rowIndex + 1) <= #data then  -- Korrigierte Bedingung
            currentX = 1
            local bg = (rowIndex + 1) == selected and self.get("selectedColor") or self.get("background")

            for i, col in ipairs(columns) do
                local cellText = rowData[i] or ""
                local paddedText = cellText .. string.rep(" ", col.width - #cellText)
                self:blit(currentX, y, paddedText,
                    string.rep(tHex[self.get("foreground")], col.width),
                    string.rep(tHex[bg], col.width))
                currentX = currentX + col.width
            end
        else
            -- Leere Zeile füllen
            self:blit(1, y, string.rep(" ", self.get("width")),
                string.rep(tHex[self.get("foreground")], self.get("width")),
                string.rep(tHex[self.get("background")], self.get("width")))
        end
    end

    -- Scrollbar Berechnung überarbeitet
    if #data > height - 2 then
        local scrollbarHeight = height - 2
        local thumbSize = math.max(1, math.floor(scrollbarHeight * (height - 2) / #data))
        
        -- Thumb Position korrigiert
        local maxScroll = #data - (height - 2) + 1  -- +1 für korrekte End-Position
        local scrollPercent = scrollOffset / maxScroll
        local thumbPos = 2 + math.floor(scrollPercent * (scrollbarHeight - thumbSize))
        
        if scrollOffset >= maxScroll then
            thumbPos = height - thumbSize  -- Exakt am Ende
        end

        -- Scrollbar Background
        for y = 2, height do
            self:blit(self.get("width"), y, "\127", tHex[colors.gray], tHex[colors.gray])
        end

        -- Thumb zeichnen
        for y = thumbPos, math.min(height, thumbPos + thumbSize - 1) do
            self:blit(self.get("width"), y, "\127", tHex[colors.white], tHex[colors.white])
        end
    end
end

return Table
local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")

--- This is the table class. It provides a sortable data grid with customizable columns,
--- row selection, and scrolling capabilities.
---@class Table : VisualElement
local Table = setmetatable({}, VisualElement)
Table.__index = Table

---@property columns table {} List of column definitions with {name, width} properties
Table.defineProperty(Table, "columns", {default = {}, type = "table"})
---@property data table {} The table data as array of row arrays
Table.defineProperty(Table, "data", {default = {}, type = "table", canTriggerRender = true})
---@property selectedRow number? nil Currently selected row index
Table.defineProperty(Table, "selectedRow", {default = nil, type = "number", canTriggerRender = true})
---@property headerColor color blue Color of the column headers
Table.defineProperty(Table, "headerColor", {default = colors.blue, type = "number"})
---@property selectedColor color lightBlue Background color of selected row
Table.defineProperty(Table, "selectedColor", {default = colors.lightBlue, type = "number"})
---@property gridColor color gray Color of grid lines
Table.defineProperty(Table, "gridColor", {default = colors.gray, type = "number"})
---@property sortColumn number? nil Currently sorted column index
Table.defineProperty(Table, "sortColumn", {default = nil, type = "number"})
---@property sortDirection string "asc" Sort direction ("asc" or "desc")
Table.defineProperty(Table, "sortDirection", {default = "asc", type = "string"})
---@property scrollOffset number 0 Current scroll position
Table.defineProperty(Table, "scrollOffset", {default = 0, type = "number", canTriggerRender = true})

Table.defineEvent(Table, "mouse_click")
Table.defineEvent(Table, "mouse_scroll")

--- Creates a new Table instance
--- @shortDescription Creates a new Table instance
--- @return Table self The newly created Table instance
--- @usage local table = Table.new()
function Table.new()
    local self = setmetatable({}, Table):__init()
    self.set("width", 30)
    self.set("height", 10)
    self.set("z", 5)
    return self
end

--- Initializes the Table instance
--- @shortDescription Initializes the Table instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Table self The initialized instance
function Table:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Table")
    return self
end

--- Sets the table columns
--- @shortDescription Sets the table columns configuration
--- @param columns table[] Array of column definitions {name="Name", width=10}
--- @return Table self The Table instance
--- @usage table:setColumns({{name="ID", width=4}, {name="Name", width=10}})
function Table:setColumns(columns)
    -- Columns Format: {{name="ID", width=4}, {name="Name", width=10}}
    self.set("columns", columns)
    return self
end

--- Sets the table data
--- @shortDescription Sets the table data
--- @param data table[] Array of row data arrays
--- @return Table self The Table instance
--- @usage table:setData({{"1", "Item One"}, {"2", "Item Two"}})
function Table:setData(data)
    -- Data Format: {{"1", "Item One"}, {"2", "Item Two"}}
    self.set("data", data)
    return self
end

--- Sorts the table data by column
--- @shortDescription Sorts the table data by the specified column
--- @param columnIndex number The index of the column to sort by
--- @return Table self The Table instance
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

--- Handles mouse click events
--- @shortDescription Handles header clicks for sorting and row selection
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
function Table:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end

    local relX, relY = self:getRelativePosition(x, y)

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

    if relY > 1 then
        local rowIndex = relY - 2 + self.get("scrollOffset")
        if rowIndex >= 0 and rowIndex < #self.get("data") then
            self.set("selectedRow", rowIndex + 1)
        end
    end

    return true
end

--- Handles mouse scroll events
--- @shortDescription Handles scrolling through the table data
--- @param direction number The scroll direction (-1 up, 1 down)
--- @param x number The x position of the scroll
--- @param y number The y position of the scroll
--- @return boolean handled Whether the event was handled
function Table:mouse_scroll(direction, x, y)
    local data = self.get("data")
    local height = self.get("height")
    local visibleRows = height - 2
    local maxScroll = math.max(0, #data - visibleRows + 1)
    local newOffset = math.min(maxScroll, math.max(0, self.get("scrollOffset") + direction))

    self.set("scrollOffset", newOffset)
    return true
end

--- Renders the table
--- @shortDescription Renders the table with headers, data and scrollbar
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

    local visibleRows = height - 2
    for y = 2, height do
        local rowIndex = y - 2 + scrollOffset
        local rowData = data[rowIndex + 1]

        if rowData and (rowIndex + 1) <= #data then
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
            self:blit(1, y, string.rep(" ", self.get("width")),
                string.rep(tHex[self.get("foreground")], self.get("width")),
                string.rep(tHex[self.get("background")], self.get("width")))
        end
    end

    if #data > height - 2 then
        local scrollbarHeight = height - 2
        local thumbSize = math.max(1, math.floor(scrollbarHeight * (height - 2) / #data))

        local maxScroll = #data - (height - 2) + 1
        local scrollPercent = scrollOffset / maxScroll
        local thumbPos = 2 + math.floor(scrollPercent * (scrollbarHeight - thumbSize))

        if scrollOffset >= maxScroll then
            thumbPos = height - thumbSize
        end

        for y = 2, height do
            self:blit(self.get("width"), y, "\127", tHex[colors.gray], tHex[colors.gray])
        end

        for y = thumbPos, math.min(height, thumbPos + thumbSize - 1) do
            self:blit(self.get("width"), y, "\127", tHex[colors.white], tHex[colors.white])
        end
    end
end

return Table
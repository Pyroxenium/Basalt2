local VisualElement = require("elements/VisualElement")
local tHex = require("libraries/colorHex")

--- This is the table class. It provides a sortable data grid with customizable columns,
--- row selection, and scrolling capabilities.
--- @usage local people = container:addTable():setWidth(40)
--- @usage people:setColumns({{name="Name",width=12}, {name="Age",width=10}, {name="Country",width=15}})
--- @usage people:setData({{"Alice", 30, "USA"}, {"Bob", 25, "UK"}})
---@class Table : VisualElement
local Table = setmetatable({}, VisualElement)
Table.__index = Table

---@property columns table {} List of column definitions with {name, width} properties
Table.defineProperty(Table, "columns", {default = {}, type = "table", canTriggerRender = true, setter=function(self, value)
    local t = {}
    for i, col in ipairs(value) do
        if type(col) == "string" then
            t[i] = {name = col, width = #col+1}
        elseif type(col) == "table" then
            t[i] = {
                name = col.name or "",
                width = col.width,  -- Can be number, "auto", or percentage like "30%"
                minWidth = col.minWidth or 3,
                maxWidth = col.maxWidth or nil
            }
        end
    end
    return t
end})
---@property data table {} The table data as array of row arrays
Table.defineProperty(Table, "data", {default = {}, type = "table", canTriggerRender = true, setter=function(self, value)
    self.set("scrollOffset", 0)
    self.set("selectedRow", nil)
    self.set("sortColumn", nil)
    self.set("sortDirection", "asc")
    return value
end})
---@property selectedRow number? nil Currently selected row index
Table.defineProperty(Table, "selectedRow", {default = nil, type = "number", canTriggerRender = true})
---@property headerColor color blue Color of the column headers
Table.defineProperty(Table, "headerColor", {default = colors.blue, type = "color"})
---@property selectedColor color lightBlue Background color of selected row
Table.defineProperty(Table, "selectedColor", {default = colors.lightBlue, type = "color"})
---@property gridColor color gray Color of grid lines
Table.defineProperty(Table, "gridColor", {default = colors.gray, type = "color"})
---@property sortColumn number? nil Currently sorted column index
Table.defineProperty(Table, "sortColumn", {default = nil, type = "number", canTriggerRender = true})
---@property sortDirection string "asc" Sort direction ("asc" or "desc")
Table.defineProperty(Table, "sortDirection", {default = "asc", type = "string", canTriggerRender = true})
---@property scrollOffset number 0 Current scroll position
Table.defineProperty(Table, "scrollOffset", {default = 0, type = "number", canTriggerRender = true})
---@property customSortFunction table {} Custom sort functions for columns
Table.defineProperty(Table, "customSortFunction", {default = {}, type = "table"})

Table.defineEvent(Table, "mouse_click")
Table.defineEvent(Table, "mouse_scroll")

--- Creates a new Table instance
--- @shortDescription Creates a new Table instance
--- @return Table self The newly created Table instance
--- @private
function Table.new()
    local self = setmetatable({}, Table):__init()
    self.class = Table
    self.set("width", 30)
    self.set("height", 10)
    self.set("z", 5)
    return self
end

--- @shortDescription Initializes the Table instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Table self The initialized instance
--- @protected
function Table:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Table")
    return self
end

--- Adds a new column to the table
--- @shortDescription Adds a new column to the table
--- @param name string The name of the column
--- @param width number The width of the column
--- @return Table self The Table instance
function Table:addColumn(name, width)
    local columns = self.get("columns")
    table.insert(columns, {name = name, width = width})
    self.set("columns", columns)
    return self
end

--- Adds a new row of data to the table
--- @shortDescription Adds a new row of data to the table
--- @param ... any The data for the new row
--- @return Table self The Table instance
function Table:addData(...)
    local data = self.get("data")
    table.insert(data, {...})
    self.set("data", data)
    return self
end

--- Sets a custom sort function for a specific column
--- @shortDescription Sets a custom sort function for a column
--- @param columnIndex number The index of the column
--- @param sortFn function Function that takes (rowA, rowB) and returns comparison result
--- @return Table self The Table instance
function Table:setColumnSortFunction(columnIndex, sortFn)
    local customSorts = self.get("customSortFunction")
    customSorts[columnIndex] = sortFn
    self.set("customSortFunction", customSorts)
    return self
end

--- Adds data with both display and sort values
--- @shortDescription Adds formatted data with raw sort values
--- @param displayData table The formatted data for display
--- @param sortData table The raw data for sorting (optional)
--- @return Table self The Table instance
function Table:setFormattedData(displayData, sortData)
    local enrichedData = {}

    for i, row in ipairs(displayData) do
        local enrichedRow = {}
        for j, cell in ipairs(row) do
            enrichedRow[j] = cell
        end

        if sortData and sortData[i] then
            enrichedRow._sortValues = sortData[i]
        end

        table.insert(enrichedData, enrichedRow)
    end

    self.set("data", enrichedData)
    return self
end

--- Set data with automatic formatting
--- @shortDescription Sets table data with optional column formatters
--- @param rawData table The raw data array
--- @param formatters table Optional formatter functions for columns {[2] = function(value) return value end}
--- @return Table self The Table instance
function Table:setData(rawData, formatters)
    if not formatters then
        self.set("data", rawData)
        return self
    end

    local formattedData = {}
    for i, row in ipairs(rawData) do
        local formattedRow = {}
        for j, cell in ipairs(row) do
            if formatters[j] then
                formattedRow[j] = formatters[j](cell)
            else
                formattedRow[j] = cell
            end
        end
        table.insert(formattedData, formattedRow)
    end

    return self:setFormattedData(formattedData, rawData)
end

--- @shortDescription Calculates column widths for rendering
--- @param columns table The column definitions
--- @param totalWidth number The total available width
--- @return table The columns with calculated visibleWidth
--- @private
function Table:calculateColumnWidths(columns, totalWidth)
    local calculatedColumns = {}
    local remainingWidth = totalWidth
    local autoColumns = {}
    local fixedWidth = 0

    for i, col in ipairs(columns) do
        calculatedColumns[i] = {
            name = col.name,
            width = col.width,
            minWidth = col.minWidth or 3,
            maxWidth = col.maxWidth
        }
        if type(col.width) == "number" then
            calculatedColumns[i].visibleWidth = math.max(col.width, calculatedColumns[i].minWidth)
            if calculatedColumns[i].maxWidth then
                calculatedColumns[i].visibleWidth = math.min(calculatedColumns[i].visibleWidth, calculatedColumns[i].maxWidth)
            end
            remainingWidth = remainingWidth - calculatedColumns[i].visibleWidth
            fixedWidth = fixedWidth + calculatedColumns[i].visibleWidth
        elseif type(col.width) == "string" and col.width:match("%%$") then
            local percent = tonumber(col.width:match("(%d+)%%"))
            if percent then
                calculatedColumns[i].visibleWidth = math.floor(totalWidth * percent / 100)
                calculatedColumns[i].visibleWidth = math.max(calculatedColumns[i].visibleWidth, calculatedColumns[i].minWidth)
                if calculatedColumns[i].maxWidth then
                    calculatedColumns[i].visibleWidth = math.min(calculatedColumns[i].visibleWidth, calculatedColumns[i].maxWidth)
                end
                remainingWidth = remainingWidth - calculatedColumns[i].visibleWidth
                fixedWidth = fixedWidth + calculatedColumns[i].visibleWidth
            else
                table.insert(autoColumns, i)
            end
        else
            table.insert(autoColumns, i)
        end
    end

    if #autoColumns > 0 and remainingWidth > 0 then
        local autoWidth = math.floor(remainingWidth / #autoColumns)
        for _, colIndex in ipairs(autoColumns) do
            calculatedColumns[colIndex].visibleWidth = math.max(autoWidth, calculatedColumns[colIndex].minWidth)
            if calculatedColumns[colIndex].maxWidth then
                calculatedColumns[colIndex].visibleWidth = math.min(calculatedColumns[colIndex].visibleWidth, calculatedColumns[colIndex].maxWidth)
            end
        end
    end

    local totalCalculated = 0
    for i, col in ipairs(calculatedColumns) do
        totalCalculated = totalCalculated + (col.visibleWidth or 0)
    end

    if totalCalculated > totalWidth then
        local scale = totalWidth / totalCalculated
        for i, col in ipairs(calculatedColumns) do
            if col.visibleWidth then
                col.visibleWidth = math.max(1, math.floor(col.visibleWidth * scale))
            end
        end
    end

    return calculatedColumns
end

--- Sorts the table data by column
--- @shortDescription Sorts the table data by the specified column
--- @param columnIndex number The index of the column to sort by
--- @param fn function? Optional custom sorting function
--- @return Table self The Table instance
function Table:sortData(columnIndex, fn)
    local data = self.get("data")
    local direction = self.get("sortDirection")
    local customSorts = self.get("customSortFunction")

    local sortFn = fn or customSorts[columnIndex]

    if sortFn then
        table.sort(data, function(a, b)
            return sortFn(a, b, direction)
        end)
    else
        table.sort(data, function(a, b)
            if not a or not b then return false end

            local valueA, valueB

            if a._sortValues and a._sortValues[columnIndex] then
                valueA = a._sortValues[columnIndex]
            else
                valueA = a[columnIndex]
            end

            if b._sortValues and b._sortValues[columnIndex] then
                valueB = b._sortValues[columnIndex]
            else
                valueB = b[columnIndex]
            end

            if type(valueA) == "number" and type(valueB) == "number" then
                if direction == "asc" then
                    return valueA < valueB
                else
                    return valueA > valueB
                end
            else
                local strA = tostring(valueA or "")
                local strB = tostring(valueB or "")
                if direction == "asc" then
                    return strA < strB
                else
                    return strA > strB
                end
            end
        end)
    end
    return self
end

--- @shortDescription Handles header clicks for sorting and row selection
--- @param button number The button that was clicked
--- @param x number The x position of the click
--- @param y number The y position of the click
--- @return boolean handled Whether the event was handled
--- @protected
function Table:mouse_click(button, x, y)
    if not VisualElement.mouse_click(self, button, x, y) then return false end

    local relX, relY = self:getRelativePosition(x, y)

    if relY == 1 then
        local columns = self.get("columns")
        local width = self.get("width")
        local calculatedColumns = self:calculateColumnWidths(columns, width)

        local currentX = 1
        for i, col in ipairs(calculatedColumns) do
            local colWidth = col.visibleWidth or col.width or 10
            if relX >= currentX and relX < currentX + colWidth then
                if self.get("sortColumn") == i then
                    self.set("sortDirection", self.get("sortDirection") == "asc" and "desc" or "asc")
                else
                    self.set("sortColumn", i)
                    self.set("sortDirection", "asc")
                end
                self:sortData(i)
                break
            end
            currentX = currentX + colWidth
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

--- @shortDescription Handles scrolling through the table data
--- @param direction number The scroll direction (-1 up, 1 down)
--- @param x number The x position of the scroll
--- @param y number The y position of the scroll
--- @return boolean handled Whether the event was handled
--- @protected
function Table:mouse_scroll(direction, x, y)
    if(VisualElement.mouse_scroll(self, direction, x, y))then
        local data = self.get("data")
        local height = self.get("height")
        local visibleRows = height - 2
        local maxScroll = math.max(0, #data - visibleRows - 1)
        local newOffset = math.min(maxScroll, math.max(0, self.get("scrollOffset") + direction))

        self.set("scrollOffset", newOffset)
        return true
    end
    return false
end

--- @shortDescription Renders the table with headers, data and scrollbar
--- @protected
function Table:render()
    VisualElement.render(self)
    local columns = self.get("columns")
    local data = self.get("data")
    local selected = self.get("selectedRow")
    local sortCol = self.get("sortColumn")
    local scrollOffset = self.get("scrollOffset")
    local height = self.get("height")
    local width = self.get("width")

    local calculatedColumns = self:calculateColumnWidths(columns, width)

    local totalWidth = 0
    local lastVisibleColumn = #calculatedColumns
    for i, col in ipairs(calculatedColumns) do
        if totalWidth + col.visibleWidth > width then
            lastVisibleColumn = i - 1
            break
        end
        totalWidth = totalWidth + col.visibleWidth
    end

    local currentX = 1
    for i, col in ipairs(calculatedColumns) do
        if i > lastVisibleColumn then break end
        local text = col.name
        if i == sortCol then
            text = text .. (self.get("sortDirection") == "asc" and "\30" or "\31")
        end
        self:textFg(currentX, 1, text:sub(1, col.visibleWidth), self.get("headerColor"))
        currentX = currentX + col.visibleWidth
    end

    for y = 2, height do
        local rowIndex = y - 2 + scrollOffset
        local rowData = data[rowIndex + 1]

        if rowData and (rowIndex + 1) <= #data then
            currentX = 1
            local bg = (rowIndex + 1) == selected and self.get("selectedColor") or self.get("background")

            for i, col in ipairs(calculatedColumns) do
                if i > lastVisibleColumn then break end
                local cellText = tostring(rowData[i] or "")
                local paddedText = cellText .. string.rep(" ", col.visibleWidth - #cellText)
                if i < lastVisibleColumn then
                    paddedText = string.sub(paddedText, 1, col.visibleWidth - 1) .. " "
                end
                local finalText = string.sub(paddedText, 1, col.visibleWidth)
                local finalForeground = string.rep(tHex[self.get("foreground")], col.visibleWidth)
                local finalBackground = string.rep(tHex[bg], col.visibleWidth)

                self:blit(currentX, y, finalText, finalForeground, finalBackground)
                currentX = currentX + col.visibleWidth
            end
        else
            self:blit(1, y, string.rep(" ", self.get("width")),
                string.rep(tHex[self.get("foreground")], self.get("width")),
                string.rep(tHex[self.get("background")], self.get("width")))
        end
    end
end

return Table
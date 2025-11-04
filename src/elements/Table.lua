local Collection = require("elements/Collection")
local tHex = require("libraries/colorHex")
---@configDescription The Table is a sortable data grid with customizable columns, row selection, and scrolling capabilities.
---@configDefault false

--- This is the table class. It provides a sortable data grid with customizable columns, row selection, and scrolling capabilities. Built on Collection for consistent item management.
--- @usage [[
--- local peopleTable = main:addTable()
---     :setPosition(1, 2)
---     :setSize(49, 10)
---     :setColumns({
---         {name = "Name", width = 15},
---         {name = "Age", width = 8},
---         {name = "Country", width = 12},
---         {name = "Score", width = 10}
---     })
---     :setBackground(colors.black)
---     :setForeground(colors.white)
--- 
--- peopleTable:addRow("Alice", 30, "USA", 95)
--- peopleTable:addRow("Bob", 25, "UK", 87)
--- peopleTable:addRow("Charlie", 35, "Germany", 92)
--- peopleTable:addRow("Diana", 28, "France", 88)
--- peopleTable:addRow("Eve", 32, "Spain", 90)
--- peopleTable:addRow("Frank", 27, "Italy", 85)
--- peopleTable:addRow("Grace", 29, "Canada", 93)
--- peopleTable:addRow("Heidi", 31, "Australia", 89)
--- peopleTable:addRow("Ivan", 26, "Russia", 91)
--- peopleTable:addRow("Judy", 33, "Brazil", 86)
--- peopleTable:addRow("Karl", 34, "Sweden", 84)
--- peopleTable:addRow("Laura", 24, "Norway", 82)
--- peopleTable:addRow("Mallory", 36, "Netherlands", 83)
--- peopleTable:addRow("Niaj", 23, "Switzerland", 81)
--- peopleTable:addRow("Olivia", 38, "Denmark", 80)
--- ]]
---@class Table : Collection
local Table = setmetatable({}, Collection)
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
---@property headerColor color blue Color of the column headers
Table.defineProperty(Table, "headerColor", {default = colors.blue, type = "color"})
---@property gridColor color gray Color of grid lines
Table.defineProperty(Table, "gridColor", {default = colors.gray, type = "color"})
---@property sortColumn number? nil Currently sorted column index
Table.defineProperty(Table, "sortColumn", {default = nil, type = "number", canTriggerRender = true})
---@property sortDirection string "asc" Sort direction ("asc" or "desc")
Table.defineProperty(Table, "sortDirection", {default = "asc", type = "string", canTriggerRender = true})
---@property customSortFunction table {} Custom sort functions for columns
Table.defineProperty(Table, "customSortFunction", {default = {}, type = "table"})
---@property offset number 0 Scroll offset for vertical scrolling
Table.defineProperty(Table, "offset", {
    default = 0,
    type = "number",
    canTriggerRender = true,
    setter = function(self, value)
        local maxOffset = math.max(0, #self.getResolved("items") - (self.getResolved("height") - 1))
        return math.min(maxOffset, math.max(0, value))
    end
})

---@property showScrollBar boolean true Whether to show the scrollbar when items exceed height
Table.defineProperty(Table, "showScrollBar", {default = true, type = "boolean", canTriggerRender = true})

---@property scrollBarSymbol string " " Symbol used for the scrollbar handle
Table.defineProperty(Table, "scrollBarSymbol", {default = " ", type = "string", canTriggerRender = true})

---@property scrollBarBackground string "\127" Symbol used for the scrollbar background
Table.defineProperty(Table, "scrollBarBackground", {default = "\127", type = "string", canTriggerRender = true})

---@property scrollBarColor color lightGray Color of the scrollbar handle
Table.defineProperty(Table, "scrollBarColor", {default = colors.lightGray, type = "color", canTriggerRender = true})

---@property scrollBarBackgroundColor color gray Background color of the scrollbar
Table.defineProperty(Table, "scrollBarBackgroundColor", {default = colors.gray, type = "color", canTriggerRender = true})

---@event onRowSelect {rowIndex number, row table} Fired when a row is selected
Table.defineEvent(Table, "mouse_click")
Table.defineEvent(Table, "mouse_drag")
Table.defineEvent(Table, "mouse_up")
Table.defineEvent(Table, "mouse_scroll")

local entrySchema = {
    cells = { type = "table", default = {} },
    _sortValues = { type = "table", default = {} },
    selected = { type = "boolean", default = false },
    text = { type = "string", default = "" }
}

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
    Collection.init(self, props, basalt)
    self._entrySchema = entrySchema
    self.set("type", "Table")

    self:observe("sortColumn", function()
        if self.getResolved("sortColumn") then
            self:sortByColumn(self.getResolved("sortColumn"))
        end
    end)

    return self
end

--- Adds a new row to the table
--- @shortDescription Adds a new row with cell values
--- @param ... any The cell values for the new row
--- @return Table self The Table instance
--- @usage table:addRow("Alice", 30, "USA")
function Table:addRow(...)
    local cells = {...}
    Collection.addItem(self, {
        cells = cells,
        _sortValues = cells, -- Store original values for sorting
        text = table.concat(cells, " ") -- For compatibility if needed
    })
    return self
end

--- Removes a row by index
--- @shortDescription Removes a row at the specified index
--- @param rowIndex number The index of the row to remove
--- @return Table self The Table instance
function Table:removeRow(rowIndex)
    local items = self.getResolved("items")
    if items[rowIndex] then
        table.remove(items, rowIndex)
        self.set("items", items)
    end
    return self
end

--- Gets a row by index
--- @shortDescription Gets the row data at the specified index
--- @param rowIndex number The index of the row
--- @return table? row The row data or nil
function Table:getRow(rowIndex)
    local items = self.getResolved("items")
    return items[rowIndex]
end

--- Updates a specific cell value
--- @shortDescription Updates a cell value at row and column
--- @param rowIndex number The row index
--- @param colIndex number The column index
--- @param value any The new value
--- @return Table self The Table instance
function Table:updateCell(rowIndex, colIndex, value)
    local items = self.getResolved("items")
    if items[rowIndex] and items[rowIndex].cells then
        items[rowIndex].cells[colIndex] = value
        self.set("items", items)
    end
    return self
end

--- Gets the currently selected row
--- @shortDescription Gets the currently selected row data
--- @return table? row The selected row or nil
function Table:getSelectedRow()
    local items = self.getResolved("items")
    for _, item in ipairs(items) do
        local isSelected = item._data and item._data.selected or item.selected
        if isSelected then
            return item
        end
    end
    return nil
end

--- Clears all table data
--- @shortDescription Removes all rows from the table
--- @return Table self The Table instance
function Table:clearData()
    self.set("items", {})
    return self
end

--- Adds a new column to the table
--- @shortDescription Adds a new column to the table
--- @param name string The name of the column
--- @param width number|string The width of the column (number, "auto", or "30%")
--- @return Table self The Table instance
function Table:addColumn(name, width)
    local columns = self.getResolved("columns")
    table.insert(columns, {name = name, width = width})
    self.set("columns", columns)
    return self
end

--- Sets a custom sort function for a specific column
--- @shortDescription Sets a custom sort function for a column
--- @param columnIndex number The index of the column
--- @param sortFn function Function that takes (rowA, rowB) and returns comparison result
--- @return Table self The Table instance
function Table:setColumnSortFunction(columnIndex, sortFn)
    local customSorts = self.getResolved("customSortFunction")
    customSorts[columnIndex] = sortFn
    self.set("customSortFunction", customSorts)
    return self
end

--- Set data with automatic formatting
--- @shortDescription Sets table data with optional column formatters
--- @param rawData table The raw data array (array of row arrays)
--- @param formatters table? Optional formatter functions for columns {[2] = function(value) return value end}
--- @return Table self The Table instance
--- @usage table:setData({{...}}, {[1] = tostring, [2] = function(age) return age.."y" end})
function Table:setData(rawData, formatters)
    self:clearData()

    for _, row in ipairs(rawData) do
        local cells = {}
        local sortValues = {}

        for j, cellValue in ipairs(row) do
            sortValues[j] = cellValue

            if formatters and formatters[j] then
                cells[j] = formatters[j](cellValue)
            else
                cells[j] = cellValue
            end
        end

        Collection.addItem(self, {
            cells = cells,
            _sortValues = sortValues,
            text = table.concat(cells, " ")
        })
    end

    return self
end

--- Gets all table data
--- @shortDescription Gets all rows as array of cell arrays
--- @return table data Array of row cell arrays
function Table:getData()
    local items = self.getResolved("items")
    local data = {}

    for _, item in ipairs(items) do
        local cells = item._data and item._data.cells or item.cells
        if cells then
            table.insert(data, cells)
        end
    end

    return data
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
function Table:sortByColumn(columnIndex, fn)
    local items = self.getResolved("items")
    local direction = self.getResolved("sortDirection")
    local customSorts = self.getResolved("customSortFunction")

    local sortFn = fn or customSorts[columnIndex]

    if sortFn then
        table.sort(items, function(a, b)
            return sortFn(a, b, direction)
        end)
    else
        table.sort(items, function(a, b)
            local aCells = a._data and a._data.cells or a.cells
            local bCells = b._data and b._data.cells or b.cells
            local aSortValues = a._data and a._data._sortValues or a._sortValues
            local bSortValues = b._data and b._data._sortValues or b._sortValues

            if not a or not b or not aCells or not bCells then return false end

            local valueA, valueB

            if aSortValues and aSortValues[columnIndex] then
                valueA = aSortValues[columnIndex]
            else
                valueA = aCells[columnIndex]
            end

            if bSortValues and bSortValues[columnIndex] then
                valueB = bSortValues[columnIndex]
            else
                valueB = bCells[columnIndex]
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

    self.set("items", items)
    return self
end

--- Registers callback for row selection
--- @shortDescription Registers a callback when a row is selected
--- @param callback function The callback function(rowIndex, row)
--- @return Table self The Table instance
function Table:onRowSelect(callback)
    self:registerCallback("rowSelect", callback)
    return self
end

--- @shortDescription Handles header clicks for sorting and row selection
--- @protected
function Table:mouse_click(button, x, y)
    if not Collection.mouse_click(self, button, x, y) then return false end

    local relX, relY = self:getRelativePosition(x, y)
    local width = self.getResolved("width")
    local height = self.getResolved("height")
    local items = self.getResolved("items")
    local showScrollBar = self.getResolved("showScrollBar")
    local visibleRows = height - 1

    if showScrollBar and #items > visibleRows and relX == width and relY > 1 then
        local scrollBarHeight = height - 1
        local maxOffset = #items - visibleRows
        local handleSize = math.max(1, math.floor((visibleRows / #items) * scrollBarHeight))

        local currentPercent = maxOffset > 0 and (self.getResolved("offset") / maxOffset * 100) or 0
        local handlePos = math.floor((currentPercent / 100) * (scrollBarHeight - handleSize)) + 1

        local scrollBarRelY = relY - 1

        if scrollBarRelY >= handlePos and scrollBarRelY < handlePos + handleSize then
            self._scrollBarDragging = true
            self._scrollBarDragOffset = scrollBarRelY - handlePos
        else
            local newPercent = ((scrollBarRelY - 1) / (scrollBarHeight - handleSize)) * 100
            local newOffset = math.floor((newPercent / 100) * maxOffset + 0.5)
            self.set("offset", math.max(0, math.min(maxOffset, newOffset)))
        end
        return true
    end

    if relY == 1 then
        local columns = self.getResolved("columns")
        local calculatedColumns = self:calculateColumnWidths(columns, width)

        local currentX = 1
        for i, col in ipairs(calculatedColumns) do
            local colWidth = col.visibleWidth or col.width or 10
            if relX >= currentX and relX < currentX + colWidth then
                if self.getResolved("sortColumn") == i then
                    self.set("sortDirection", self.getResolved("sortDirection") == "asc" and "desc" or "asc")
                else
                    self.set("sortColumn", i)
                    self.set("sortDirection", "asc")
                end
                self:sortByColumn(i)
                self:updateRender()
                return true
            end
            currentX = currentX + colWidth
        end
        return true
    end

    if relY > 1 then
        local rowIndex = relY - 2 + self.getResolved("offset")

        if rowIndex >= 0 and rowIndex < #items then
            local actualIndex = rowIndex + 1

            for _, item in ipairs(items) do
                if item._data then
                    item._data.selected = false
                else
                    item.selected = false
                end
            end

            if items[actualIndex] then
                if items[actualIndex]._data then
                    items[actualIndex]._data.selected = true
                else
                    items[actualIndex].selected = true
                end
                self:fireEvent("rowSelect", actualIndex, items[actualIndex])
                self:updateRender()
            end
        end
        return true
    end

    return true
end

--- @shortDescription Handles mouse drag events for scrollbar
--- @protected
function Table:mouse_drag(button, x, y)
    if self._scrollBarDragging then
        local _, relY = self:getRelativePosition(x, y)
        local items = self.getResolved("items")
        local height = self.getResolved("height")
        local visibleRows = height - 1
        local scrollBarHeight = height - 1
        local handleSize = math.max(1, math.floor((visibleRows / #items) * scrollBarHeight))
        local maxOffset = #items - visibleRows

        local scrollBarRelY = relY - 1
        scrollBarRelY = math.max(1, math.min(scrollBarHeight, scrollBarRelY))

        local newPos = scrollBarRelY - (self._scrollBarDragOffset or 0)
        local newPercent = ((newPos - 1) / (scrollBarHeight - handleSize)) * 100
        local newOffset = math.floor((newPercent / 100) * maxOffset + 0.5)

        self.set("offset", math.max(0, math.min(maxOffset, newOffset)))
        return true
    end
    return Collection.mouse_drag and Collection.mouse_drag(self, button, x, y) or false
end

--- @shortDescription Handles mouse up events to stop scrollbar dragging
--- @protected
function Table:mouse_up(button, x, y)
    if self._scrollBarDragging then
        self._scrollBarDragging = false
        self._scrollBarDragOffset = nil
        return true
    end
    return Collection.mouse_up and Collection.mouse_up(self, button, x, y) or false
end

--- @shortDescription Handles scrolling through the table data
--- @protected
function Table:mouse_scroll(direction, x, y)
    if Collection.mouse_scroll(self, direction, x, y) then
        local items = self.getResolved("items")
        local height = self.getResolved("height")
        local visibleRows = height - 1  -- Subtract header
        local maxOffset = math.max(0, #items - visibleRows)
        local newOffset = math.min(maxOffset, math.max(0, self.getResolved("offset") + direction))

        self.set("offset", newOffset)
        self:updateRender()
        return true
    end
    return false
end

--- @shortDescription Renders the table with headers, data and scrollbar
--- @protected
function Table:render()
    Collection.render(self)
    local columns = self.getResolved("columns")
    local items = self.getResolved("items")
    local sortCol = self.getResolved("sortColumn")
    local offset = self.getResolved("offset")
    local height = self.getResolved("height")
    local width = self.getResolved("width")
    local showScrollBar = self.getResolved("showScrollBar")
    local background = self.getResolved("background")
    local foreground = self.getResolved("foreground")
    local visibleRows = height - 1

    local needsScrollBar = showScrollBar and #items > visibleRows
    local contentWidth = needsScrollBar and width - 1 or width

    local calculatedColumns = self:calculateColumnWidths(columns, contentWidth)

    local totalWidth = 0
    local lastVisibleColumn = #calculatedColumns
    for i, col in ipairs(calculatedColumns) do
        if totalWidth + col.visibleWidth > contentWidth then
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
            text = text .. (self.getResolved("sortDirection") == "asc" and "\30" or "\31")
        end
        self:textFg(currentX, 1, text:sub(1, col.visibleWidth), self.getResolved("headerColor"))
        currentX = currentX + col.visibleWidth
    end

    if currentX <= contentWidth then
        self:textBg(currentX, 1, string.rep(" ", contentWidth - currentX + 1), background)
    end

    for y = 2, height do
        local rowIndex = y - 2 + offset
        local item = items[rowIndex + 1]

        if item then
            local cells = item._data and item._data.cells or item.cells
            local isSelected = item._data and item._data.selected or item.selected

            if cells then
                currentX = 1
                local bg = isSelected and self.getResolved("selectedBackground") or background

                for i, col in ipairs(calculatedColumns) do
                    if i > lastVisibleColumn then break end
                    local cellText = tostring(cells[i] or "")
                    local paddedText = cellText .. string.rep(" ", col.visibleWidth - #cellText)
                    if i < lastVisibleColumn then
                        paddedText = string.sub(paddedText, 1, col.visibleWidth - 1) .. " "
                    end
                    local finalText = string.sub(paddedText, 1, col.visibleWidth)
                    local finalForeground = string.rep(tHex[foreground], col.visibleWidth)
                    local finalBackground = string.rep(tHex[bg], col.visibleWidth)

                    self:blit(currentX, y, finalText, finalForeground, finalBackground)
                    currentX = currentX + col.visibleWidth
                end

                if currentX <= contentWidth then
                    self:textBg(currentX, y, string.rep(" ", contentWidth - currentX + 1), bg)
                end
            end
        else
            self:blit(1, y, string.rep(" ", contentWidth),
                string.rep(tHex[foreground], contentWidth),
                string.rep(tHex[background], contentWidth))
        end
    end

    if needsScrollBar then
        local scrollBarHeight = height - 1
        local handleSize = math.max(1, math.floor((visibleRows / #items) * scrollBarHeight))
        local maxOffset = #items - visibleRows

        local currentPercent = maxOffset > 0 and (offset / maxOffset * 100) or 0
        local handlePos = math.floor((currentPercent / 100) * (scrollBarHeight - handleSize)) + 1

        local scrollBarSymbol = self.getResolved("scrollBarSymbol")
        local scrollBarBg = self.getResolved("scrollBarBackground")
        local scrollBarColor = self.getResolved("scrollBarColor")
        local scrollBarBgColor = self.getResolved("scrollBarBackgroundColor")

        for i = 2, height do
            self:blit(width, i, scrollBarBg, tHex[foreground], tHex[scrollBarBgColor])
        end

        for i = handlePos, math.min(scrollBarHeight, handlePos + handleSize - 1) do
            self:blit(width, i + 1, scrollBarSymbol, tHex[scrollBarColor], tHex[scrollBarBgColor])
        end
    end
end

return Table
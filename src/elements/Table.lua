-- Table: column headers + data rows, click-to-sort, row selection.
--
-- columns = { { title = "Name", width = 8 }, { title = "Qty" } }
--   (columns without width share the remaining space)
-- data = { { "Wheat", 12 }, { "Iron", 3 } }
--
-- Sorting never mutates `data`: a view order maps display rows to data
-- indices. `selected` is always a DATA index. Fires "select"(dataIndex, row)
-- and "sort"(columnIndex, ascending).

local require = ...
local class = require("core/class")
local Element = require("core/element")
local itemview = require("core/itemview")

---@alias TableSortDirection "asc"|"desc"
---@alias TableRow any[]
---@alias TableValueComparator fun(a: any, b: any, ascending: boolean, rowA: TableRow, rowB: TableRow): boolean
---@alias TableRowComparator fun(rowA: TableRow, rowB: TableRow, direction: TableSortDirection): boolean
---@alias TableFormatter fun(value: any): any

---@class TableColumn
---@field title? string Header title
---@field name? string Column name
---@field width? number|string Fixed or percentage width
---@field minWidth? number Minimum width
---@field maxWidth? number Maximum width

---@class TableColumnLayout
---@field x number Local x coordinate
---@field width number Visible width

---@class TableCalculatedColumn
---@field name? string Column name
---@field width? number|string Requested width
---@field visibleWidth number Resolved width

---@class Table : Element
---@field public columns TableColumn[] Normalized column definitions
---@field public data TableRow[] Stable source rows
---@field public selected integer|false Selected data-row index
---@field public offset number Row viewport offset
---@field public sortable boolean Whether header clicks sort
---@field public sortColumn integer|false Active sort column
---@field public sortDirection TableSortDirection Active sort direction
---@field public headerBackground number Header background color
---@field public gridColor number Grid color
---@field public selectionBackground number Selected-row background
---@field public selectionForeground number Selected-row foreground
---@field public scrollbar ItemViewScrollbarMode Scrollbar mode
---@field public scrollbarColor number Scrollbar track color
---@field public scrollbarThumbColor number Scrollbar thumb color
---@field public scrollBarSymbol string Basalt2-compatible thumb symbol
---@field public scrollBarBackground string Basalt2-compatible track symbol
---@field private _viewOrder? integer[] Display-row to data-row mapping
---@field private _sortCol? integer Internal active sort column
---@field private _sortAsc? boolean Internal sort direction
---@field private _columnSorters table<integer, TableValueComparator> Custom comparators
---@field private _sortValues table<TableRow, TableRow> Display rows to original sort values
---@field private _itemScrollDrag? integer Active scrollbar grab offset
local Table = class.create("Table", Element)

---@param self Table
local function invalidateView(self)
    rawset(self, "_viewOrder", nil)
end

---@param columns (string|TableColumn)[]
---@return TableColumn[] columns
local function normalizeColumns(columns)
    if type(columns) ~= "table" then
        error("Basalt Table: columns must be a table", 3)
    end
    local result = {}
    for i, column in ipairs(columns) do
        if type(column) == "string" then
            result[i] = { title = column, name = column, width = #column + 1 }
        elseif type(column) == "table" then
            local title = column.title or column.name or ""
            result[i] = {
                title = title,
                name = column.name or title,
                width = column.width,
                minWidth = column.minWidth or 1,
                maxWidth = column.maxWidth,
            }
        else
            error("Basalt Table: column " .. i .. " must be a string or table", 3)
        end
    end
    return result
end

--- Column definitions: { { title, width?, minWidth?, maxWidth? }, ... }
class.property(Table, "columns", false, {
    onChange = function(self, value)
        rawget(self, "_p").columns = normalizeColumns(value)
        invalidateView(self)
    end,
})
--- Row data: list of cell-value lists; never mutated by sorting
class.property(Table, "data", false, { onChange = invalidateView })
--- Selected DATA row index, or false
class.property(Table, "selected", false, {
    state = "selected",
    stateWhen = function(v) return v ~= false and v ~= nil end,
    styleable = false,
})
--- Scroll offset of the row viewport
class.property(Table, "offset", 0)
--- Header clicks sort the view
class.property(Table, "sortable", true)
--- Currently sorted column index, or false
class.property(Table, "sortColumn", false, { styleable = false })
--- "asc" or "desc"
class.property(Table, "sortDirection", "asc", { styleable = false })
--- Background color (false = transparent)
class.property(Table, "background", colors.black)
--- Header row background
class.property(Table, "headerBackground", colors.gray)
--- Color of the column gap / grid lines
class.property(Table, "gridColor", colors.gray)
--- Background of selected entries
class.property(Table, "selectionBackground", colors.blue)
--- Text color of selected entries
class.property(Table, "selectionForeground", colors.white)
--- Width in terminal cells
class.property(Table, "width", 26)
--- Height in terminal cells
class.property(Table, "height", 8)
--- "auto", "always" or "hidden"
class.property(Table, "scrollbar", "auto")
--- Scrollbar track color
class.property(Table, "scrollbarColor", colors.gray)
--- Scrollbar thumb color
class.property(Table, "scrollbarThumbColor", colors.lightGray)
--- Basalt2 compat: scrollbar thumb symbol
class.property(Table, "scrollBarSymbol", " ")
--- Basalt2 compat: scrollbar track symbol
class.property(Table, "scrollBarBackground", "\127")

--- Fired on item selection with (index, item)
class.event(Table, "select")
--- Fired on row selection, with (dataIndex, row) - Basalt2 compat
class.event(Table, "rowSelect")
--- Fired when the value changes
class.event(Table, "change")
--- Fired after sorting, with (columnIndex, ascending)
class.event(Table, "sort")

---@param self Table
---@return integer rows
local function rowArea(self)
    return math.max(0, self.height - 1)
end

---@param self Table
---@return ItemViewGeometry geometry
local function geometry(self)
    return itemview.geometry(#self.data, rowArea(self), self.offset,
        self.scrollbar)
end

--- Display order as a list of data indices (identity unless sorted).
---@param self Table
---@return integer[] order
local function viewOrder(self)
    local data = self.data
    local view = rawget(self, "_viewOrder")
    if view and #view == #data then return view end

    view = {}
    for i = 1, #data do view[i] = i end
    local col = rawget(self, "_sortCol")
    if col then
        local ascending = rawget(self, "_sortAsc")
        local custom = rawget(self, "_columnSorters")[col]
        table.sort(view, function(a, b)
            local sortValues = rawget(self, "_sortValues")
            local va = sortValues[data[a]] and sortValues[data[a]][col] or data[a][col]
            local vb = sortValues[data[b]] and sortValues[data[b]][col] or data[b][col]
            if custom then return custom(va, vb, ascending, data[a], data[b]) end
            if type(va) == "number" and type(vb) == "number" then
                if ascending then return va < vb end
                return va > vb
            end
            va, vb = tostring(va), tostring(vb)
            if ascending then return va < vb end
            return va > vb
        end)
    end
    rawset(self, "_viewOrder", view)
    return view
end

--- Returns { x, width } per column for the given usable width.
---@param self Table
---@param usable number
---@return TableColumnLayout[] columns
local function columnLayout(self, usable)
    local cols = self.columns
    local gaps = math.max(0, #cols - 1)
    local available = math.max(0, usable - gaps)
    local fixed, flex = 0, {}
    local widths = {}
    for i = 1, #cols do
        local spec = cols[i].width
        local width
        if type(spec) == "number" then
            width = spec
        elseif type(spec) == "string" then
            local percent = tonumber(spec:match("^(%-?[%d%.]+)%%$"))
            if percent then width = math.floor(available * percent / 100) end
        end
        if width then
            width = math.max(cols[i].minWidth or 1, math.floor(width))
            if cols[i].maxWidth then width = math.min(width, cols[i].maxWidth) end
            widths[i], fixed = width, fixed + width
        else
            flex[#flex + 1] = i
        end
    end
    local rest = math.max(0, available - fixed)
    for n, index in ipairs(flex) do
        local width = math.floor(rest / math.max(1, #flex - n + 1))
        width = math.max(cols[index].minWidth or 1, width)
        if cols[index].maxWidth then width = math.min(width, cols[index].maxWidth) end
        widths[index], rest = width, math.max(0, rest - width)
    end

    local out = {}
    local x = 1
    for i = 1, #cols do
        local w = math.max(0, math.min(widths[i] or 0, usable - x + 1))
        out[i] = { x = x, width = w }
        x = x + w + 1
    end
    return out
end

--- Sorts the display order by a column; repeating flips the direction.
--- The data table itself is never mutated.
---@param columnIndex integer The column to sort by
---@param ascending? boolean Explicit direction, nil = toggle
---@return self
function Table:sortBy(columnIndex, ascending)
    if self.columns[columnIndex] == nil then return self end
    if ascending == nil then
        ascending = rawget(self, "_sortCol") ~= columnIndex
            or not rawget(self, "_sortAsc")
    end
    rawset(self, "_sortCol", columnIndex)
    rawset(self, "_sortAsc", ascending and true or false)
    rawget(self, "_p").sortColumn = columnIndex
    rawget(self, "_p").sortDirection = ascending and "asc" or "desc"
    invalidateView(self)
    self:fire("sort", columnIndex, ascending)
    self:markDirty()
    return self
end

--- Selects a row by its DATA index and scrolls it into view.
---@param dataIndex integer|false The data row index, or false to clear
---@param emit? boolean false suppresses the select event
---@return self
function Table:select(dataIndex, emit)
    local oldIndex = self.selected
    local oldRow = oldIndex and self.data[oldIndex] or nil
    if dataIndex == false or dataIndex == nil then
        self.selected = false
        if oldIndex then self:fire("change", false, nil, oldIndex, oldRow) end
        return self
    end
    if self.data[dataIndex] == nil then return self end
    self.selected = dataIndex
    local view = viewOrder(self)
    for viewIndex = 1, #view do
        if view[viewIndex] == dataIndex then
            self.offset = itemview.ensureVisible(self.offset, viewIndex,
                #view, rowArea(self))
            break
        end
    end
    if oldIndex ~= dataIndex then
        self:fire("change", dataIndex, self.data[dataIndex], oldIndex or false, oldRow)
    end
    if emit ~= false then
        self:fire("select", dataIndex, self.data[dataIndex])
        self:fire("rowSelect", dataIndex, self.data[dataIndex])
    end
    return self
end

--- Appends a row: either one table or the cell values as arguments.
---@usage tbl:addRow("Wheat", 12)  -- or tbl:addRow({ "Wheat", 12 })
---@param ... any Cell values, or one TableRow
---@return self
function Table:addRow(...)
    local count = select("#", ...)
    local row = count == 1 and type((...)) == "table" and (...) or { ... }
    local data = self.data
    data[#data + 1] = row
    rawget(self, "_sortValues")[row] = row
    invalidateView(self)
    self:markDirty()
    return self
end

--- Removes a data row; the selection index is kept consistent.
---@param dataIndex integer The data row index
---@return self
function Table:removeRow(dataIndex)
    local data = self.data
    if data[dataIndex] == nil then return self end
    local oldIndex = self.selected
    local oldRow = oldIndex and data[oldIndex] or nil
    local removed = table.remove(data, dataIndex)
    rawget(self, "_sortValues")[removed] = nil
    if self.selected == dataIndex then
        self.selected = false
        self:fire("change", false, nil, oldIndex, oldRow)
    elseif self.selected and self.selected > dataIndex then
        self.selected = self.selected - 1
        self:fire("change", self.selected, self.data[self.selected],
            oldIndex, oldRow)
    end
    invalidateView(self)
    self:markDirty()
    return self
end

--- Returns one row by stable data index.
---@param dataIndex integer Data index
---@return TableRow|nil row
function Table:getRow(dataIndex)
    return self.data[dataIndex]
end

--- Changes one cell; a sorted view re-sorts automatically.
---@param dataIndex integer The data row index
---@param columnIndex integer The column index
---@param value any The new cell value
---@return self
function Table:updateCell(dataIndex, columnIndex, value)
    local row = self.data[dataIndex]
    if row == nil then return self end
    row[columnIndex] = value
    local sortValues = rawget(self, "_sortValues")
    if sortValues[row] then sortValues[row][columnIndex] = value end
    invalidateView(self) -- sort order may depend on this column
    self:markDirty()
    return self
end

--- Registers a value comparator receiving valueA, valueB and ascending.
---@param columnIndex integer Column index
---@param fn? TableValueComparator Value comparator
---@return self
function Table:setColumnSort(columnIndex, fn)
    local sorters = rawget(self, "_columnSorters")
    sorters[columnIndex] = fn
    invalidateView(self)
    self:markDirty()
    return self
end

--- Registers a Basalt2-style row comparator for one column.
---@param columnIndex integer Column index
---@param fn? TableRowComparator Comparator receiving rowA, rowB and direction
---@return self
function Table:setColumnSortFunction(columnIndex, fn)
    if fn == nil then return self:setColumnSort(columnIndex, nil) end
    return self:setColumnSort(columnIndex, function(_, _, ascending, rowA, rowB)
        return fn(rowA, rowB, ascending and "asc" or "desc")
    end)
end

--- Sorts the table view without mutating the underlying data order.
---@param columnIndex integer Column index
---@param fn? TableRowComparator Optional Basalt2-style row comparator
---@return self
function Table:sortByColumn(columnIndex, fn)
    if fn then self:setColumnSortFunction(columnIndex, fn) end
    return self:sortBy(columnIndex, self.sortDirection ~= "desc")
end

--- Selects the active sort column, or clears sorting with false/nil.
---@param columnIndex? integer|false Column index
---@return self
function Table:setSortColumn(columnIndex)
    if columnIndex == false or columnIndex == nil then
        rawset(self, "_sortCol", nil)
        rawget(self, "_p").sortColumn = false
        invalidateView(self)
        self:markDirty()
        return self
    end
    return self:sortBy(columnIndex, self.sortDirection ~= "desc")
end

--- Sets the active sort direction.
---@param direction TableSortDirection Direction
---@return self
function Table:setSortDirection(direction)
    if direction ~= "asc" and direction ~= "desc" then
        error("Basalt Table: sortDirection must be 'asc' or 'desc'", 2)
    end
    rawget(self, "_p").sortDirection = direction
    if self.sortColumn then self:sortBy(self.sortColumn, direction == "asc") end
    return self
end

--- Returns the selected row using its stable data index.
---@return TableRow|nil row
function Table:getSelectedRow()
    return self.selected and self.data[self.selected] or nil
end

--- Removes all rows and clears selection/scroll state.
---@return self
function Table:clearData()
    return self:clear()
end

--- Appends a named column definition.
---@param name string Header label
---@param width? number|string Fixed, percent or "auto" width
---@return self
function Table:addColumn(name, width)
    local columns = {}
    for i, column in ipairs(self.columns) do columns[i] = column end
    columns[#columns + 1] = { name = name, title = name, width = width }
    self.columns = columns
    return self
end

--- Replaces all rows and optionally formats individual columns for display.
---@param rawData TableRow[] Source rows
---@param formatters? table<integer, TableFormatter> Column formatter map
---@return self
function Table:setData(rawData, formatters)
    if type(rawData) ~= "table" then
        error("Basalt Table: data must be a table", 2)
    end
    self:clear()
    local data, sortValues = {}, rawget(self, "_sortValues")
    for i, source in ipairs(rawData) do
        local row, original = {}, {}
        for column, value in ipairs(source) do
            original[column] = value
            row[column] = formatters and formatters[column]
                and formatters[column](value) or value
        end
        data[i], sortValues[row] = row, original
    end
    rawget(self, "_p").data = data
    invalidateView(self)
    self:markDirty()
    return self
end

--- Resolves fixed, percent and automatic column widths.
---@param columns (string|TableColumn)[] Column definitions
---@param totalWidth number Available width
---@return TableCalculatedColumn[] columns Definitions containing visibleWidth
function Table:calculateColumnWidths(columns, totalWidth)
    local original = self.columns
    rawget(self, "_p").columns = normalizeColumns(columns)
    local layout = columnLayout(self, totalWidth)
    rawget(self, "_p").columns = original
    local result = {}
    for i, column in ipairs(columns) do
        result[i] = {
            name = type(column) == "table" and (column.name or column.title) or column,
            width = type(column) == "table" and column.width or nil,
            visibleWidth = layout[i].width,
        }
    end
    return result
end

--- Sets the table header background color.
---@param color number Color value
---@return self
function Table:setHeaderColor(color)
    self.headerBackground = color
    return self
end

--- Returns the table header background color.
---@return number color
function Table:getHeaderColor() return self.headerBackground end
--- Sets selected-row foreground color.
---@param color number Color value
---@return self
function Table:setSelectedForeground(color) self.selectionForeground = color return self end
--- Returns selected-row foreground color.
---@return number color
function Table:getSelectedForeground() return self.selectionForeground end
--- Sets selected-row background color.
---@param color number Color value
---@return self
function Table:setSelectedBackground(color) self.selectionBackground = color return self end
--- Returns selected-row background color.
---@return number color
function Table:getSelectedBackground() return self.selectionBackground end
--- Sets selected-row foreground and background colors.
---@param foreground number Foreground color
---@param background number Background color
---@return self
function Table:setSelectionColor(foreground, background)
    self.selectionForeground, self.selectionBackground = foreground, background
    return self
end
--- Returns selected-row foreground and background colors.
---@return number foreground
---@return number background
function Table:getSelectionColor()
    return self.selectionForeground, self.selectionBackground
end

--- Enables or hides the table scrollbar.
---@param show boolean Whether the bar may be shown
---@return self
function Table:setShowScrollBar(show)
    self.scrollbar = show and "auto" or "hidden"
    return self
end
--- Returns whether the table scrollbar is enabled.
---@return boolean enabled
function Table:getShowScrollBar() return self.scrollbar ~= "hidden" end
--- Sets the scrollbar thumb color.
---@param color number Color value
---@return self
function Table:setScrollBarColor(color)
    self.scrollbarThumbColor = color
    return self
end
--- Returns the scrollbar thumb color.
---@return number color
function Table:getScrollBarColor() return self.scrollbarThumbColor end
--- Sets the scrollbar track color.
---@param color number Color value
---@return self
function Table:setScrollBarBackgroundColor(color)
    self.scrollbarColor = color
    return self
end
--- Returns the scrollbar track color.
---@return number color
function Table:getScrollBarBackgroundColor() return self.scrollbarColor end

--- Clears all rows, selection, sorting view and scroll state.
---@return self
function Table:clear()
    local oldIndex = self.selected
    local oldRow = oldIndex and self.data[oldIndex] or nil
    rawget(self, "_p").data = {}
    rawset(self, "_sortValues", setmetatable({}, { __mode = "k" }))
    self.selected = false
    self.offset = 0
    invalidateView(self)
    self:markDirty()
    if oldIndex then self:fire("change", false, nil, oldIndex, oldRow) end
    return self
end

--- Initializes per-instance state and input handlers.
function Table:setup()
    Element.setup(self)
    local p = rawget(self, "_p")
    p.columns = {}
    p.data = {}
    rawset(self, "_columnSorters", {})
    rawset(self, "_sortValues", setmetatable({}, { __mode = "k" }))

    self:on("click", function(s, _, x, y)
        local g = geometry(s)
        if y == 1 then
            if not s.sortable then return end
            local usable = s.width - (g.show and 1 or 0)
            for i, col in ipairs(columnLayout(s, usable)) do
                if x >= col.x and x < col.x + col.width then
                    s:sortBy(i)
                    return
                end
            end
            return
        end
        if g.show and x == s.width then
            local target, grab = itemview.pointerDown(y - 1, g)
            s.offset = target
            if grab ~= nil then rawset(s, "_itemScrollDrag", grab) end
            return
        end
        local dataIndex = viewOrder(s)[g.offset + y - 1]
        if dataIndex then
            s:select(dataIndex)
        end
    end)
    self:on("drag", function(s, _, _, y)
        local grab = rawget(s, "_itemScrollDrag")
        if grab ~= nil then
            s.offset = itemview.drag(y - 1, grab, geometry(s))
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_itemScrollDrag", nil)
    end)
end

--- Routes mouse input in local coordinates (wheel scrolling etc.).
---@param event string The mouse event name
---@param btn number Button or scroll direction
---@param x number Local x coordinate
---@param y number Local y coordinate
---@return Element|nil consumer The consuming element, or nil to pass through
function Table:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" then
        if self.disabled then return nil end
        local old = self.offset
        self.offset = itemview.clampOffset(old + btn, #self.data, rowArea(self))
        local userHandled = self:fire("scroll", btn, x, y)
        if self.offset ~= old or userHandled then return self end
        return nil
    end
    return Element.handleMouse(self, event, btn, x, y)
end

--- Handles keyboard input while focused.
---@param event string The key event name (key, key_up, char, paste)
---@param a any Key code or typed text
---@param b? any Secondary key-event value
function Table:handleKey(event, a, b)
    if event == "key" and #self.data > 0 then
        local view = viewOrder(self)
        local current = 0
        for viewIndex = 1, #view do
            if view[viewIndex] == self.selected then
                current = viewIndex
                break
            end
        end
        if a == keys.up then
            self:select(view[math.max(1, current > 0 and current - 1 or 1)], false)
        elseif a == keys.down then
            self:select(view[current > 0
                and math.min(#view, current + 1) or 1], false)
        elseif a == keys.home then
            self:select(view[1], false)
        elseif a == keys["end"] then
            self:select(view[#view], false)
        elseif a == keys.enter and current > 0 then
            self:fire("select", self.selected, self.data[self.selected])
            self:fire("rowSelect", self.selected, self.data[self.selected])
        end
    end
    Element.handleKey(self, event, a, b)
end

--- Intrinsic size for basalt.auto().
---@return number width The measured width
---@return number height The measured height
function Table:measure()
    local w = 0
    for i = 1, #self.columns do
        w = w + (self.columns[i].width or 8) + 1
    end
    return math.max(1, w - 1), math.max(2, #self.data + 1)
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
function Table:render(buf)
    Element.render(self, buf)
    local w = self.width
    local g = geometry(self)
    rawget(self, "_p").offset = g.offset
    local usable = w - (g.show and 1 or 0)
    local cols = columnLayout(self, usable)
    local sortCol, sortAsc = rawget(self, "_sortCol"), rawget(self, "_sortAsc")

    -- header
    buf:fill(1, 1, w, 1, " ", self.foreground, self.headerBackground)
    for i, col in ipairs(cols) do
        local title = tostring(self.columns[i].title or self.columns[i].name or "")
        if i == sortCol then
            title = title:sub(1, math.max(0, col.width - 1))
                .. (sortAsc and "\30" or "\31")
        end
        buf:blit(col.x, 1, title:sub(1, col.width),
            self.foreground, self.headerBackground)
    end

    -- rows
    local data, view, sel = self.data, viewOrder(self), self.selected
    for row = 1, rowArea(self) do
        local dataIndex = view[g.offset + row]
        if not dataIndex then break end
        local rowData = data[dataIndex]
        local isSel = dataIndex == sel
        local fg = isSel and self.selectionForeground or self.foreground
        local bg = isSel and self.selectionBackground or nil
        if isSel then
            buf:fill(1, row + 1, usable, 1, " ", fg, bg)
        end
        for i, col in ipairs(cols) do
            local cell = rowData[i]
            if cell ~= nil then
                buf:blit(col.x, row + 1,
                    tostring(cell):sub(1, col.width), fg, bg)
            end
        end
    end
    itemview.draw(buf, w, 2, g, self.foreground,
        self.scrollbarColor, self.scrollbarThumbColor)
end

return Table

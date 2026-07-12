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

local Table = class.create("Table", Element)

local function invalidateView(self)
    rawset(self, "_viewOrder", nil)
end

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

class.property(Table, "columns", false, {
    onChange = function(self, value)
        rawget(self, "_p").columns = normalizeColumns(value)
        invalidateView(self)
    end,
})
class.property(Table, "data", false, { onChange = invalidateView })
class.property(Table, "selected", false, {
    state = "selected",
    stateWhen = function(v) return v ~= false and v ~= nil end,
    styleable = false,
})
class.property(Table, "offset", 0)
class.property(Table, "sortable", true)
class.property(Table, "sortColumn", false, { styleable = false })
class.property(Table, "sortDirection", "asc", { styleable = false })
class.property(Table, "background", colors.black)
class.property(Table, "headerBackground", colors.gray)
class.property(Table, "gridColor", colors.gray)
class.property(Table, "selectionBackground", colors.blue)
class.property(Table, "selectionForeground", colors.white)
class.property(Table, "width", 26)
class.property(Table, "height", 8)
class.property(Table, "scrollbar", "auto")
class.property(Table, "scrollbarColor", colors.gray)
class.property(Table, "scrollbarThumbColor", colors.lightGray)
class.property(Table, "scrollBarSymbol", " ")
class.property(Table, "scrollBarBackground", "\127")

class.event(Table, "select")
class.event(Table, "rowSelect")
class.event(Table, "change")
class.event(Table, "sort")

local function rowArea(self)
    return math.max(0, self.height - 1)
end

local function geometry(self)
    return itemview.geometry(#self.data, rowArea(self), self.offset,
        self.scrollbar)
end

--- Display order as a list of data indices (identity unless sorted).
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

function Table:getRow(dataIndex)
    return self.data[dataIndex]
end

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

--- Sets a custom comparator for one column: fn(a, b, ascending) -> boolean.
function Table:setColumnSort(columnIndex, fn)
    local sorters = rawget(self, "_columnSorters")
    sorters[columnIndex] = fn
    invalidateView(self)
    self:markDirty()
    return self
end

function Table:setColumnSortFunction(columnIndex, fn)
    if fn == nil then return self:setColumnSort(columnIndex, nil) end
    return self:setColumnSort(columnIndex, function(_, _, ascending, rowA, rowB)
        return fn(rowA, rowB, ascending and "asc" or "desc")
    end)
end

function Table:sortByColumn(columnIndex, fn)
    if fn then self:setColumnSortFunction(columnIndex, fn) end
    return self:sortBy(columnIndex, self.sortDirection ~= "desc")
end

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

function Table:setSortDirection(direction)
    if direction ~= "asc" and direction ~= "desc" then
        error("Basalt Table: sortDirection must be 'asc' or 'desc'", 2)
    end
    rawget(self, "_p").sortDirection = direction
    if self.sortColumn then self:sortBy(self.sortColumn, direction == "asc") end
    return self
end

function Table:getSelectedRow()
    return self.selected and self.data[self.selected] or nil
end

function Table:clearData()
    return self:clear()
end

function Table:addColumn(name, width)
    local columns = {}
    for i, column in ipairs(self.columns) do columns[i] = column end
    columns[#columns + 1] = { name = name, title = name, width = width }
    self.columns = columns
    return self
end

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

function Table:setHeaderColor(color)
    self.headerBackground = color
    return self
end

function Table:getHeaderColor() return self.headerBackground end
function Table:setSelectedForeground(color) self.selectionForeground = color return self end
function Table:getSelectedForeground() return self.selectionForeground end
function Table:setSelectedBackground(color) self.selectionBackground = color return self end
function Table:getSelectedBackground() return self.selectionBackground end
function Table:setSelectionColor(foreground, background)
    self.selectionForeground, self.selectionBackground = foreground, background
    return self
end
function Table:getSelectionColor()
    return self.selectionForeground, self.selectionBackground
end

function Table:setShowScrollBar(show)
    self.scrollbar = show and "auto" or "hidden"
    return self
end
function Table:getShowScrollBar() return self.scrollbar ~= "hidden" end
function Table:setScrollBarColor(color)
    self.scrollbarThumbColor = color
    return self
end
function Table:getScrollBarColor() return self.scrollbarThumbColor end
function Table:setScrollBarBackgroundColor(color)
    self.scrollbarColor = color
    return self
end
function Table:getScrollBarBackgroundColor() return self.scrollbarColor end

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

function Table:measure()
    local w = 0
    for i = 1, #self.columns do
        w = w + (self.columns[i].width or 8) + 1
    end
    return math.max(1, w - 1), math.max(2, #self.data + 1)
end

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

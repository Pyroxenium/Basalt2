local require = ...
local class = require("core/class")
local CollectionEntry = require("core/collectionentry")

--- Data accepted by collection-like elements when creating an entry.
---@class CollectionItem
---@field text? string Display text
---@field label? string Fallback display text when text is omitted
---@field value? any Item value and final fallback display text
---@field callback? fun(collection: CollectionMixin, item: CollectionEntry|CollectionItem) Called when the item is activated
---@field selectable? boolean Whether the entry can be selected
---@field disabled? boolean Whether the entry is disabled
---@field separator? boolean Whether the entry is rendered as a separator
---@field selected? boolean Whether the entry should initially be selected
---@field fg? number Foreground color
---@field bg? number Background color
---@field selectedFg? number Foreground color while selected
---@field selectedBg? number Background color while selected
---@field iconChar? string|number Optional single-cell icon
---@field iconX? number Horizontal icon position
---@field iconForeground? number Icon foreground color
---@field iconBackground? number Icon background color
---@field selectedIconForeground? number Icon foreground color while selected
---@field selectedIconBackground? number Icon background color while selected
---@field items? (CollectionItem|string)[] Submenu items
---@field dropdown? (CollectionItem|string)[] Alias for submenu items

--- CollectionMixin provides shared properties and methods for collection-like elements.
---@class CollectionMixin : Element
---@field items CollectionEntry[] List of collection entries
---@field selectable boolean Whether items can be selected
---@field multiSelection boolean Whether multiple items can be selected
---@field selected integer|false The first selected index, or false if none
---@field selectionBackground number Selection background color
---@field selectionForeground number Selection foreground color
---@field _collectionSelection table<CollectionEntry, boolean> Internal selection map
---@field _collectionChangeEvent string|nil Name of the change event to fire
---@field _p table Properties table (items, selectable, multiSelection, selected, selectionBackground, selectionForeground)
---@field _class table Class table with shared properties and methods
---@field setOffset? fun(self: CollectionMixin, offset: number): CollectionMixin Optional generated offset setter
local methods = {}

local collection = { methods = methods }

local function indexOf(self, value)
    if type(value) == "number" then
        local index = math.floor(value)
        return self.items[index] and index or nil
    end
    for i, entry in ipairs(self.items) do
        if entry == value then return i end
    end
end

local function eligible(entry)
    return entry and entry.selectable ~= false and entry.disabled ~= true
        and entry.separator ~= true
end

local function selectedSnapshot(self)
    local index = self:getSelectedIndex()
    return index, index and self.items[index] or nil
end

local function syncSelected(self)
    local index = self:getSelectedIndex() or false
    rawget(self, "_p").selected = index
    self:setState("selected", index ~= false)
end

local function fireChange(self, oldIndex, oldItem)
    syncSelected(self)
    local index, item = selectedSnapshot(self)
    local eventName = rawget(self, "_collectionChangeEvent")
    if eventName then self:fire(eventName, index or false, item, oldIndex or false, oldItem) end
    self:markDirty()
end

local function normalize(self, item)
    if CollectionEntry.is(item) then
        if rawget(item, "_parent") == self then return item end
        item = item:getData()
    end
    return CollectionEntry.new(self, item)
end

local function replaceItems(self, values, oldItems)
    if type(values) ~= "table" then
        error("Basalt Collection: items must be a table", 3)
    end
    local oldIndex, oldItem
    local selected = rawget(self, "_collectionSelection")
    if type(oldItems) == "table" then
        for i, entry in ipairs(oldItems) do
            if selected[entry] then oldIndex, oldItem = i, entry break end
        end
    end
    if type(oldItems) == "table" then
        for _, entry in ipairs(oldItems) do
            if CollectionEntry.is(entry) then rawset(entry, "_parent", nil) end
        end
    end
    local items = {}
    local newSelection = {}
    for i, item in ipairs(values) do
        local wantsSelection = type(item) == "table" and not CollectionEntry.is(item)
            and item.selected == true
        items[i] = normalize(self, item)
        local data = items[i]:getData()
        data.selected = nil
        if wantsSelection and (self.multiSelection or next(newSelection) == nil) then
            newSelection[items[i]] = true
        end
    end
    rawget(self, "_p").items = items
    rawset(self, "_collectionSelection", newSelection)
    if oldItem or next(newSelection) then
        fireChange(self, oldIndex, oldItem)
    else
        syncSelected(self)
        self:markDirty()
    end
    if self.setOffset and self.offset ~= nil then self:setOffset(self.offset) end
end

local function ensureProperty(c, name, default, options)
    if c.__props[name] == nil then class.property(c, name, default, options) end
end

--- Installs the shared collection properties, events and methods on a class.
---@param c table Target element class
---@param options? { changeEvent?: string|false } Mixin options
function collection.install(c, options)
    options = options or {}
    ensureProperty(c, "items", false, {
        onChange = function(self, value, old)
            if rawget(self, "_collectionSelection") then replaceItems(self, value, old) end
        end,
    })
    ensureProperty(c, "selectable", true)
    ensureProperty(c, "multiSelection", false, {
        onChange = function(self, enabled)
            if enabled or not rawget(self, "_collectionSelection") then return end
            local first = self:getSelectedItem()
            local selected = rawget(self, "_collectionSelection")
            for entry in pairs(selected) do selected[entry] = entry == first or nil end
            syncSelected(self)
        end,
    })
    ensureProperty(c, "selected", false, {
        styleable = false,
        onChange = function(self, value)
            if not rawget(self, "_collectionSelection") then return end
            if value == false or value == nil then
                self:clearItemSelection()
            else
                self:selectItem(value)
            end
        end,
    })
    ensureProperty(c, "selectionBackground", colors.blue)
    ensureProperty(c, "selectionForeground", colors.white)

--- Fired on item selection with (index, item)
    class.event(c, "select")
    local changeEvent
    if options.changeEvent ~= false then
        changeEvent = options.changeEvent or "change"
    end
    if changeEvent then class.event(c, changeEvent) end

    c.setSelectedBackground = function(self, value)
        self.selectionBackground = value
        return self
    end
    c.getSelectedBackground = function(self) return self.selectionBackground end
    c.setSelectedForeground = function(self, value)
        self.selectionForeground = value
        return self
    end
    c.getSelectedForeground = function(self) return self.selectionForeground end
    c.setSelectionColor = function(self, foreground, background)
        self.selectionForeground = foreground
        self.selectionBackground = background
        return self
    end
    c.getSelectionColor = function(self)
        return self.selectionForeground, self.selectionBackground
    end

    c._collectionChangeEventName = changeEvent
    for name, method in pairs(collection.methods) do c[name] = method end
end

--- Initializes per-instance state and input handlers.
---@param self CollectionMixin Collection-like element
function collection.setup(self)
    rawset(self, "_collectionSelection", {})
    rawset(self, "_collectionChangeEvent", self._class._collectionChangeEventName)
    local initial = rawget(self, "_p").items
    local items = {}
    if type(initial) == "table" then
        for i, item in ipairs(initial) do items[i] = normalize(self, item) end
    end
    rawget(self, "_p").items = items
    syncSelected(self)
end

--- Resolves an item value or index to its current index.
---@param value integer|CollectionEntry Item index or entry
---@return integer|nil index The index, or nil if not found
function methods:indexOfItem(value)
    return indexOf(self, value)
end

--- Returns one normalized entry by index.
---@param index integer Item index
---@return CollectionEntry|nil entry
function methods:getItem(index)
    return self.items[index]
end

--- Returns the number of collection entries.
---@return integer count
function methods:getItemCount()
    return #self.items
end

--- Appends an item (string, table with text/fg/bg/callback, or entry).
---@param item CollectionItem|string|CollectionEntry The item to add
---@return CollectionEntry entry The normalized collection entry
function methods:addItem(item)
    local wantsSelection = type(item) == "table" and not CollectionEntry.is(item)
        and item.selected == true
    local entry = normalize(self, item)
    entry:getData().selected = nil
    self.items[#self.items + 1] = entry
    if wantsSelection then self:selectItem(entry) end
    self:markDirty()
    return entry
end

--- Inserts an item at a position (clamped to the valid range).
---@param index number Target position
---@param item CollectionItem|string|CollectionEntry The item to insert
---@return CollectionEntry entry The normalized collection entry
function methods:insertItem(index, item)
    index = math.max(1, math.min(#self.items + 1, math.floor(index)))
    local entry = normalize(self, item)
    local wantsSelection = entry:getData().selected == true
    entry:getData().selected = nil
    table.insert(self.items, index, entry)
    if wantsSelection then self:selectItem(entry) end
    syncSelected(self)
    self:markDirty()
    return entry
end

--- Removes an item by value or index; selection is kept consistent.
---@param value integer|CollectionEntry Item index or entry
---@return self
function methods:removeItem(value)
    local index = indexOf(self, value)
    if not index then return self end
    local oldIndex, oldItem = selectedSnapshot(self)
    local entry = table.remove(self.items, index)
    local selected = rawget(self, "_collectionSelection")
    local changed = selected[entry] == true
    selected[entry] = nil
    rawset(entry, "_parent", nil)
    if changed then fireChange(self, oldIndex, oldItem) else syncSelected(self) end
    self:markDirty()
    return self
end

--- Removes all entries and clears selection.
---@return self
function methods:clear()
    local oldIndex, oldItem = selectedSnapshot(self)
    for _, entry in ipairs(self.items) do rawset(entry, "_parent", nil) end
    rawget(self, "_p").items = {}
    rawset(self, "_collectionSelection", {})
    if oldItem then fireChange(self, oldIndex, oldItem) else syncSelected(self) end
    self:markDirty()
    return self
end

--- Alias for clear().
---@return self
function methods:clearItems()
    return self:clear()
end

--- Tests whether an entry or index is selected.
---@param value integer|CollectionEntry Item index or entry
---@return boolean selected
function methods:isItemSelected(value)
    local index = indexOf(self, value)
    return index ~= nil
        and rawget(self, "_collectionSelection")[self.items[index]] == true
end

--- Basalt 2 compatibility alias for isItemSelected().
---@param value integer|CollectionEntry Item index or entry
---@return boolean selected
function methods:isSelected(value)
    return self:isItemSelected(value)
end

--- Returns all selected entries in display order.
---@return CollectionEntry[] entries List of selected collection entries
function methods:getSelectedItems()
    local result = {}
    local selected = rawget(self, "_collectionSelection")
    for _, entry in ipairs(self.items) do
        if selected[entry] then result[#result + 1] = entry end
    end
    return result
end

--- Returns the first selected entry.
---@return CollectionEntry|nil entry
function methods:getSelectedItem()
    local selected = rawget(self, "_collectionSelection")
    for _, entry in ipairs(self.items) do
        if selected[entry] then return entry end
    end
end

--- Returns the first selected entry's current index.
---@return integer|nil index
function methods:getSelectedIndex()
    local selected = rawget(self, "_collectionSelection")
    for i, entry in ipairs(self.items) do
        if selected[entry] then return i end
    end
end

--- Returns all selected indices in ascending order.
---@return integer[] indices
function methods:getSelection()
    local result = {}
    local selected = rawget(self, "_collectionSelection")
    for i, entry in ipairs(self.items) do
        if selected[entry] then result[#result + 1] = i end
    end
    return result
end

--- Selects an item (adds to the selection when multiSelection is on).
---@param value integer|CollectionEntry Item index or entry
---@param emit? boolean false suppresses the change event
---@return self
function methods:selectItem(value, emit)
    if not self.selectable then return self end
    local index = indexOf(self, value)
    local entry = index and self.items[index]
    if not eligible(entry) then return self end
    local selected = rawget(self, "_collectionSelection")
    local oldIndex, oldItem = selectedSnapshot(self)
    local changed = not selected[entry]
    if not self.multiSelection then
        for current in pairs(selected) do
            if current ~= entry then selected[current], changed = nil, true end
        end
    end
    selected[entry] = true
    if changed then
        if emit == false then syncSelected(self) else fireChange(self, oldIndex, oldItem) end
    end
    return self
end

--- Removes an entry from selection.
---@param value integer|CollectionEntry Item index or entry
---@param emit? boolean false suppresses the change event
---@return self
function methods:unselectItem(value, emit)
    local index = indexOf(self, value)
    local entry = index and self.items[index]
    local selected = rawget(self, "_collectionSelection")
    if not entry or not selected[entry] then return self end
    local oldIndex, oldItem = selectedSnapshot(self)
    selected[entry] = nil
    if emit == false then syncSelected(self) else fireChange(self, oldIndex, oldItem) end
    return self
end

--- Toggles an item's selection state.
---@param value integer|CollectionEntry Item index or entry
---@param emit? boolean false suppresses the change event
---@return self
function methods:toggleItem(value, emit)
    if self:isItemSelected(value) then
        return self:unselectItem(value, emit)
    end
    return self:selectItem(value, emit)
end

--- Clears all selected entries.
---@param emit? boolean false suppresses the change event
---@return self
function methods:clearItemSelection(emit)
    local oldIndex, oldItem = selectedSnapshot(self)
    if not oldItem then return self end
    rawset(self, "_collectionSelection", {})
    if emit == false then syncSelected(self) else fireChange(self, oldIndex, oldItem) end
    return self
end

--- Alias for clearItemSelection().
---@param emit? boolean false suppresses the change event
---@return self
function methods:clearSelection(emit)
    return self:clearItemSelection(emit)
end

--- Selects the next selectable entry after the current selection.
---@param emit? boolean false suppresses the change event
---@return self
function methods:selectNext(emit)
    local start = self:getSelectedIndex() or 0
    for index = start + 1, #self.items do
        if eligible(self.items[index]) then return self:selectItem(index, emit) end
    end
    return self
end

--- Selects the previous selectable entry before the current selection.
---@param emit? boolean false suppresses the change event
---@return self
function methods:selectPrevious(emit)
    local start = self:getSelectedIndex() or (#self.items + 1)
    for index = start - 1, 1, -1 do
        if eligible(self.items[index]) then return self:selectItem(index, emit) end
    end
    return self
end

--- Scrolls a collection view to its first item when supported.
---@return self
function methods:scrollToTop()
    if self.setOffset then self:setOffset(0) end
    return self
end

--- Scrolls a collection view to its final item when supported.
---@return self
function methods:scrollToBottom()
    if self.setOffset then self:setOffset(math.huge) end
    return self
end

--- Selects an item AND fires its callback plus the select event
--- (what a mouse click or the enter key does).
---@param value integer|CollectionEntry Item index or entry
---@param emit? boolean false suppresses callback and select event
---@param toggle? boolean true toggles instead of selecting
---@return self
function methods:activateItem(value, emit, toggle)
    local index = indexOf(self, value)
    local entry = index and self.items[index]
    if not self.selectable or not eligible(entry) then return self end
    if toggle then self:toggleItem(entry) else self:selectItem(entry) end
    index = indexOf(self, entry)
    if emit ~= false then
        if type(entry.callback) == "function" then entry.callback(self, entry) end
        self:fire("select", index, entry)
    end
    return self
end

--- Selects and optionally activates an entry.
---@param value integer|CollectionEntry Item index or entry
---@param emit? boolean false suppresses callback/select event
---@return self
function methods:select(value, emit)
    return self:activateItem(value, emit, self.multiSelection)
end

---@param entry CollectionEntry Entry to move
---@param delta number Relative position change
---@return self
function methods:_moveCollectionEntry(entry, delta)
    local index = indexOf(self, entry)
    if index then self:_moveCollectionEntryTo(entry, index + delta) end
    return self
end

---@param entry CollectionEntry Entry to move
---@param target number Target index
---@return self
function methods:_moveCollectionEntryTo(entry, target)
    local index = indexOf(self, entry)
    if not index then return self end
    target = math.max(1, math.min(#self.items, math.floor(target)))
    if target ~= index then
        table.remove(self.items, index)
        table.insert(self.items, target, entry)
        syncSelected(self)
        self:markDirty()
    end
    return self
end

---@param a CollectionEntry First entry
---@param b CollectionEntry Second entry
---@return self
function methods:_swapCollectionEntries(a, b)
    local ai, bi = indexOf(self, a), indexOf(self, b)
    if ai and bi and ai ~= bi then
        self.items[ai], self.items[bi] = self.items[bi], self.items[ai]
        syncSelected(self)
        self:markDirty()
    end
    return self
end

return collection

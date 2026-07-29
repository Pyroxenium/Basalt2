--- A stable wrapper for a collection item that forwards reads/writes to the owning collection.
---@class CollectionEntry : CollectionItem
---@field selected boolean Whether the entry is currently selected
---@field _parent CollectionMixin|nil Owning collection-like element, or nil after removal
---@field _data CollectionItem Mutable item data
local methods = {}

local CollectionEntry = {}

CollectionEntry.__index = function(entry, key)
    local method = methods[key]
    if method then return method end
    if key == "selected" then
        local parent = rawget(entry, "_parent")
        return parent and parent:isItemSelected(entry) or false
    end
    local data = rawget(entry, "_data")
    if data and data[key] ~= nil then return data[key] end
    local parent = rawget(entry, "_parent")
    local parentMethod = parent and parent[key]
    if type(parentMethod) == "function" then
        return function(_, ...)
            return parentMethod(parent, ...)
        end
    end
end

CollectionEntry.__newindex = function(entry, key, value)
    if type(key) == "string" and key:sub(1, 1) == "_" then
        rawset(entry, key, value)
        return
    end
    if key == "selected" then
        local parent = rawget(entry, "_parent")
        if parent then
            if value then parent:selectItem(entry) else parent:unselectItem(entry) end
        end
        return
    end
    local data = rawget(entry, "_data")
    if data[key] ~= value then
        data[key] = value
        local parent = rawget(entry, "_parent")
        if parent then parent:markDirty() end
    end
end

CollectionEntry.__tostring = function(entry)
    local data = rawget(entry, "_data")
    if data.text ~= nil then return tostring(data.text) end
    if data.label ~= nil then return tostring(data.label) end
    if data.value ~= nil then return tostring(data.value) end
    return "Entry"
end

--- Creates the stable entry wrapper used by collection-like elements.
---@param parent CollectionMixin Owning collection-like element
---@param item CollectionItem|string Initial item data or display text
---@return CollectionEntry entry
function CollectionEntry.new(parent, item)
    local data
    if type(item) == "table" then
        data = item
    else
        data = { text = tostring(item), value = item }
    end
    if data.text == nil and data.label == nil and data.value == nil then
        data.text = "Entry"
    end
    return setmetatable({ _parent = parent, _data = data }, CollectionEntry)
end

--- Tests whether a value is a collection entry wrapper.
---@param value any Candidate value
---@return boolean isEntry
function CollectionEntry.is(value)
    return getmetatable(value) == CollectionEntry
end

--- Returns the mutable data table backing this entry.
---@return CollectionItem data
function methods:getData()
    return rawget(self, "_data")
end

--- Returns the collection that currently owns this entry.
---@return CollectionMixin|nil parent
function methods:getParent()
    return rawget(self, "_parent")
end

--- Changes the display text and invalidates the owning collection.
---@param text string New display text
---@return self
function methods:setText(text)
    self.text = text
    return self
end

--- Returns the entry's display text.
---@return string|nil text
function methods:getText()
    return self.text
end

--- Resolves the entry's current index after moves/removals.
---@return integer|nil index
function methods:getIndex()
    local parent = rawget(self, "_parent")
    return parent and parent:indexOfItem(self) or nil
end

--- Moves the entry towards the beginning of the collection.
---@param amount? integer Number of positions, default 1
---@return self
function methods:moveUp(amount)
    local parent = rawget(self, "_parent")
    if parent then parent:_moveCollectionEntry(self, -(amount or 1)) end
    return self
end

--- Moves the entry towards the end of the collection.
---@param amount? integer Number of positions, default 1
---@return self
function methods:moveDown(amount)
    local parent = rawget(self, "_parent")
    if parent then parent:_moveCollectionEntry(self, amount or 1) end
    return self
end

--- Moves the entry to index 1.
---@return self
function methods:moveToTop()
    local parent = rawget(self, "_parent")
    if parent then parent:_moveCollectionEntryTo(self, 1) end
    return self
end

--- Moves the entry to the final index.
---@return self
function methods:moveToBottom()
    local parent = rawget(self, "_parent")
    if parent then parent:_moveCollectionEntryTo(self, #parent.items) end
    return self
end

--- Swaps two entries belonging to the same collection.
---@param other CollectionEntry Entry to exchange positions with
---@return self
function methods:swapWith(other)
    local parent = rawget(self, "_parent")
    if parent and rawget(other, "_parent") == parent then
        parent:_swapCollectionEntries(self, other)
    end
    return self
end

--- Removes this entry from its collection.
---@return boolean removed False when the entry no longer has a parent
function methods:remove()
    local parent = rawget(self, "_parent")
    if not parent then return false end
    parent:removeItem(self)
    return true
end

--- Selects this entry through its owning collection.
---@return self
function methods:select()
    local parent = rawget(self, "_parent")
    if parent then parent:selectItem(self) end
    return self
end

--- Removes this entry from the current selection.
---@return self
function methods:unselect()
    local parent = rawget(self, "_parent")
    if parent then parent:unselectItem(self) end
    return self
end

--- Returns whether this entry is currently selected.
---@return boolean selected
function methods:isSelected()
    local parent = rawget(self, "_parent")
    return parent and parent:isItemSelected(self) or false
end

return CollectionEntry

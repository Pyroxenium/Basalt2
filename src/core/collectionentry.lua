-- CollectionEntry: mutable item wrapper shared by Collection-like elements.
-- Item fields remain directly accessible (entry.text, entry.callback, ...),
-- while all mutations notify the owning element.

local CollectionEntry = {}

local methods = {}

CollectionEntry.__index = function(entry, key)
    local method = methods[key]
    if method then return method end
    if key == "selected" then
        local parent = rawget(entry, "_parent")
        return parent and parent:isItemSelected(entry) or false
    end
    local data = rawget(entry, "_data")
    if data and data[key] ~= nil then return data[key] end
    -- Keeps fluent code useful even though addItem() returns the new entry:
    -- list:addItem("A"):addItem("B") forwards the second call to the list.
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

function CollectionEntry.is(value)
    return getmetatable(value) == CollectionEntry
end

function methods:getData()
    return rawget(self, "_data")
end

function methods:getParent()
    return rawget(self, "_parent")
end

function methods:setText(text)
    self.text = text
    return self
end

function methods:getText()
    return self.text
end

function methods:getIndex()
    local parent = rawget(self, "_parent")
    return parent and parent:indexOfItem(self) or nil
end

function methods:moveUp(amount)
    local parent = rawget(self, "_parent")
    if parent then parent:_moveCollectionEntry(self, -(amount or 1)) end
    return self
end

function methods:moveDown(amount)
    local parent = rawget(self, "_parent")
    if parent then parent:_moveCollectionEntry(self, amount or 1) end
    return self
end

function methods:moveToTop()
    local parent = rawget(self, "_parent")
    if parent then parent:_moveCollectionEntryTo(self, 1) end
    return self
end

function methods:moveToBottom()
    local parent = rawget(self, "_parent")
    if parent then parent:_moveCollectionEntryTo(self, #parent.items) end
    return self
end

function methods:swapWith(other)
    local parent = rawget(self, "_parent")
    if parent and rawget(other, "_parent") == parent then
        parent:_swapCollectionEntries(self, other)
    end
    return self
end

function methods:remove()
    local parent = rawget(self, "_parent")
    if not parent then return false end
    parent:removeItem(self)
    return true
end

function methods:select()
    local parent = rawget(self, "_parent")
    if parent then parent:selectItem(self) end
    return self
end

function methods:unselect()
    local parent = rawget(self, "_parent")
    if parent then parent:unselectItem(self) end
    return self
end

function methods:isSelected()
    local parent = rawget(self, "_parent")
    return parent and parent:isItemSelected(self) or false
end

return CollectionEntry

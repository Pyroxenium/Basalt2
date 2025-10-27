local CollectionEntry = {}
CollectionEntry.__index = function(entry, key)
    local self_method = rawget(CollectionEntry, key)
    if self_method then
        return self_method
    end

    if entry._data[key] ~= nil then
        return entry._data[key]
    end
    local parent_method = entry._parent[key]
    if parent_method then
        return parent_method
    end

    return nil
end

function CollectionEntry.new(parent, data)
    local instance = {
        _parent = parent,
        _data = data
    }
    return setmetatable(instance, CollectionEntry)
end

function CollectionEntry:_findIndex()
    for i, entry in ipairs(self._parent:getItems()) do
        if entry == self then
            return i
        end
    end
    return nil
end

function CollectionEntry:setText(text)
    self._data.text = text
    self._parent:updateRender()
    return self
end

function CollectionEntry:getText()
    return self._data.text
end

function CollectionEntry:moveUp(amount)
    local items = self._parent:getItems()
    local currentIndex = self:_findIndex()
    if not currentIndex then return self end

    amount = amount or 1
    local newIndex = math.max(1, currentIndex - amount)

    if currentIndex ~= newIndex then
        table.remove(items, currentIndex)
        table.insert(items, newIndex, self)
        self._parent:updateRender()
    end
    return self
end

function CollectionEntry:moveDown(amount)
    local items = self._parent:getItems()
    local currentIndex = self:_findIndex()
    if not currentIndex then return self end

    amount = amount or 1
    local newIndex = math.min(#items, currentIndex + amount)

    if currentIndex ~= newIndex then
        table.remove(items, currentIndex)
        table.insert(items, newIndex, self)
        self._parent:updateRender()
    end
    return self
end

function CollectionEntry:moveToTop()
    local items = self._parent:getItems()
    local currentIndex = self:_findIndex()
    if not currentIndex or currentIndex == 1 then return self end

    table.remove(items, currentIndex)
    table.insert(items, 1, self)
    self._parent:updateRender()
    return self
end

function CollectionEntry:moveToBottom()
    local items = self._parent:getItems()
    local currentIndex = self:_findIndex()
    if not currentIndex or currentIndex == #items then return self end

    table.remove(items, currentIndex)
    table.insert(items, self)
    self._parent:updateRender()
    return self
end

function CollectionEntry:getIndex()
    return self:_findIndex()
end

function CollectionEntry:swapWith(otherEntry)
    local items = self._parent:getItems()
    local indexA = self:getIndex()
    local indexB = otherEntry:getIndex()

    if indexA and indexB and indexA ~= indexB then
        items[indexA], items[indexB] = items[indexB], items[indexA]
        self._parent:updateRender()
    end
    return self
end

function CollectionEntry:remove()
    if self._parent and self._parent.removeItem then
        self._parent:removeItem(self)
        return true
    end
    return false
end

function CollectionEntry:select()
    if self._parent and self._parent.selectItem then
        self._parent:selectItem(self)
    end
    return self
end

function CollectionEntry:unselect()
    if self._parent and self._parent.unselectItem then
        self._parent:unselectItem(self)
    end
end

function CollectionEntry:isSelected()
    if self._parent and self._parent.getSelectedItem then
        return self._parent:getSelectedItem() == self
    end
    return false
end

return CollectionEntry
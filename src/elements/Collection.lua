local VisualElement = require("elements/VisualElement")
local CollectionEntry = require("libraries/collectionentry")
---@configDescription A collection of items

--- This is the Collection class. It provides a collection of items
---@class Collection : VisualElement
local Collection = setmetatable({}, VisualElement)
Collection.__index = Collection

Collection.defineProperty(Collection, "items", {default={}, type = "table", canTriggerRender = true})
---@property selectable boolean true Whether items can be selected
Collection.defineProperty(Collection, "selectable", {default = true, type = "boolean"})
---@property multiSelection boolean false Whether multiple items can be selected at once
Collection.defineProperty(Collection, "multiSelection", {default = false, type = "boolean"})
---@property selectedBackground color blue Background color for selected items
Collection.defineProperty(Collection, "selectedBackground", {default = colors.blue, type = "color", canTriggerRender = true})
---@property selectedForeground color white Text color for selected items
Collection.defineProperty(Collection, "selectedForeground", {default = colors.white, type = "color", canTriggerRender = true})

---@event onSelect {index number, item table} Fired when an item is selected

--- Creates a new Collection instance
--- @shortDescription Creates a new Collection instance
--- @return Collection self The newly created Collection instance
--- @private
function Collection.new()
    local self = setmetatable({}, Collection):__init()
    self.class = Collection
    return self
end

--- @shortDescription Initializes the Collection instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Collection self The initialized instance
--- @protected
function Collection:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self._entrySchema = {}
    self.set("type", "Collection")
    return self
end

--- Adds an item to the Collection
--- @shortDescription Adds an item to the Collection
--- @param text string|table The item to add (string or item table)
--- @return Collection self The Collection instance
--- @usage Collection:addItem("New Item")
--- @usage Collection:addItem({text="Item", callback=function() end})
function Collection:addItem(itemData)
    if type(itemData) == "string" then
        itemData = {text = itemData}
    end
    if itemData.selected == nil then
        itemData.selected = false
    end
    local entry = CollectionEntry.new(self, itemData, self._entrySchema)

    table.insert(self.get("items"), entry)
    self:updateRender()
    return entry
end

--- Removes an item from the Collection
--- @shortDescription Removes an item from the Collection
--- @param index number The index of the item to remove
--- @return Collection self The Collection instance
--- @usage Collection:removeItem(1)
function Collection:removeItem(index)
    local items = self.get("items")
    if type(index) == "number" then
        table.remove(items, index)
    else
        for k,v in pairs(items)do
            if v == index then
                table.remove(items, k)
                break
            end
        end
    end
    self:updateRender()
    return self
end

--- Clears all items from the Collection
--- @shortDescription Clears all items from the Collection
--- @return Collection self The Collection instance
--- @usage Collection:clear()
function Collection:clear()
    self.set("items", {})
    self:updateRender()
    return self
end

-- Gets the currently selected items
--- @shortDescription Gets the currently selected items
--- @return table selected Collection of selected items
--- @usage local selected = Collection:getSelectedItems()
function Collection:getSelectedItems()
    local selected = {}
    for i, item in ipairs(self.get("items")) do
        if type(item) == "table" and item.selected then
            local selectedItem = item
            selectedItem.index = i
            table.insert(selected, selectedItem)
        end
    end
    return selected
end

--- Gets first selected item
--- @shortDescription Gets first selected item
--- @return table? selected The first item
function Collection:getSelectedItem()
    local items = self.get("items")
    for i, item in ipairs(items) do
        if type(item) == "table" and item.selected then
            return item
        end
    end
    return nil
end

function Collection:selectItem(index)
    local items = self.get("items")
    if type(index) == "number" then
        if items[index] and type(items[index]) == "table" then
            items[index].selected = true
        end
    else
        for k,v in pairs(items)do
            if v == index then
                if type(v) == "table" then
                    v.selected = true
                end
                break
            end
        end
    end
    self:updateRender()
    return self
end

function Collection:unselectItem(index)
    local items = self.get("items")
    if type(index) == "number" then
        if items[index] and type(items[index]) == "table" then
            items[index].selected = false
        end
    else
        for k,v in pairs(items)do
            if v == index then
                if type(items[k]) == "table" then
                    items[k].selected = false
                end
                break
            end
        end
    end
    self:updateRender()
    return self
end

function Collection:clearItemSelection()
    local items = self.get("items")
    for i, item in ipairs(items) do
        item.selected = false
    end
    self:updateRender()
    return self
end

--- Gets the index of the first selected item
--- @shortDescription Gets the index of the first selected item
--- @return number? index The index of the first selected item, or nil if none selected
--- @usage local index = Collection:getSelectedIndex()
function Collection:getSelectedIndex()
    local items = self.get("items")
    for i, item in ipairs(items) do
        if type(item) == "table" and item.selected then
            return i
        end
    end
    return nil
end

--- Selects the next item in the collection
--- @shortDescription Selects the next item
--- @return Collection self The Collection instance
function Collection:selectNext()
    local items = self.get("items")
    local currentIndex = self:getSelectedIndex()

    if not currentIndex then
        if #items > 0 then
            self:selectItem(1)
        end
    elseif currentIndex < #items then
        if not self.get("multiSelection") then
            self:clearItemSelection()
        end
        self:selectItem(currentIndex + 1)
    end

    self:updateRender()
    return self
end

--- Selects the previous item in the collection
--- @shortDescription Selects the previous item
--- @return Collection self The Collection instance
function Collection:selectPrevious()
    local items = self.get("items")
    local currentIndex = self:getSelectedIndex()

    if not currentIndex then
        if #items > 0 then
            self:selectItem(#items)
        end
    elseif currentIndex > 1 then
        if not self.get("multiSelection") then
            self:clearItemSelection()
        end
        self:selectItem(currentIndex - 1)
    end

    self:updateRender()
    return self
end

--- Registers a callback for the select event
--- @shortDescription Registers a callback for the select event
--- @param callback function The callback function to register
--- @return Collection self The Collection instance
--- @usage Collection:onSelect(function(index, item) print("Selected item:", index, item) end)
function Collection:onSelect(callback)
    self:registerCallback("select", callback)
    return self
end

return Collection
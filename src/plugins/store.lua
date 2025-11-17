local PropertySystem = require("propertySystem")
local errorManager = require("errorManager")

---@class BaseFrame : Container
local BaseFrame = {}

function BaseFrame.setup(element)
    element.defineProperty(element, "stores", {default = {}, type = "table"})
    element.defineProperty(element, "storeObserver", {default = {}, type = "table"})
end

--- Initializes a new store for this element
--- @shortDescription Initializes a new store
--- @param self BaseFrame The element to initialize store for
--- @param name string The name of the store
--- @param default any The default value of the store
--- @param persist? boolean Whether to persist the store to disk
--- @param path? string Custom file path for persistence
--- @return BaseFrame self The element instance
function BaseFrame:initializeStore(name, default, persist, path)
    local stores = self.get("stores")

    if stores[name] then
        errorManager.error("Store '" .. name .. "' already exists")
        return self
    end

    local file = path or "stores/" .. self.get("name") .. ".store"
    local persistedData = {}

    if persist and fs.exists(file) then
        local f = fs.open(file, "r")
        persistedData = textutils.unserialize(f.readAll()) or {}
        f.close()
    end

    stores[name] = {
        value = persist and persistedData[name] or default,
        persist = persist,
    }

    return self
end


--- This is the store plugin. It provides a store management system for UI elements with support for
--- persistent stores, computed stores, and store sharing between elements.
---@class BaseElement
local BaseElement = {}

--- Sets the value of a store
--- @shortDescription Sets a store value
--- @param self BaseElement The element to set store for
--- @param name string The name of the store
--- @param value any The new value for the store
--- @return BaseElement self The element instance
function BaseElement:setStore(name, value)
    local main = self:getBaseFrame()
    local stores = main.get("stores")
    local observers = main.get("storeObserver")
    if not stores[name] then
        errorManager.error("Store '"..name.."' not initialized")
    end

    if stores[name].persist then
        local file = "stores/" .. main.get("name") .. ".store"
        local persistedData = {}

        if fs.exists(file) then
            local f = fs.open(file, "r")
            persistedData = textutils.unserialize(f.readAll()) or {}
            f.close()
        end

        persistedData[name] = value

        local dir = fs.getDir(file)
        if not fs.exists(dir) then
            fs.makeDir(dir)
        end

        local f = fs.open(file, "w")
        f.write(textutils.serialize(persistedData))
        f.close()
    end

    stores[name].value = value

    -- Trigger observers
    if observers[name] then
        for _, callback in ipairs(observers[name]) do
            callback(name, value)
        end
    end

    -- Recompute all computed stores
    for storeName, store in pairs(stores) do
        if store.computed then
            store.value = store.computeFn(self)
            if observers[storeName] then
                for _, callback in ipairs(observers[storeName]) do
                    callback(storeName, store.value)
                end
            end
        end
    end

    return self
end

--- Gets the value of a store
--- @shortDescription Gets a store value
--- @param self BaseElement The element to get store from
--- @param name string The name of the store
--- @return any value The current store value
function BaseElement:getStore(name)
    local main = self:getBaseFrame()
    local stores = main.get("stores")

    if not stores[name] then
        errorManager.error("Store '"..name.."' not initialized")
    end

    if stores[name].computed then
        return stores[name].computeFn(self)
    end
    return stores[name].value
end

--- Registers a callback for store changes
--- @shortDescription Watches for store changes
--- @param self BaseElement The element to watch
--- @param storeName string The store to watch
--- @param callback function Called with (element, newValue, oldValue)
--- @return BaseElement self The element instance
function BaseElement:onStoreChange(storeName, callback)
    local main = self:getBaseFrame()
    local store = main.get("stores")[storeName]
    if not store then
        errorManager.error("Cannot observe store '" .. storeName .. "': Store not initialized")
        return self
    end
    local observers = main.get("storeObserver")
    if not observers[storeName] then
        observers[storeName] = {}
    end
    table.insert(observers[storeName], callback)
    return self
end

--- Removes a store change observer
--- @shortDescription Removes a store change observer
--- @param self BaseElement The element to remove observer from
--- @param storeName string The store to remove observer from
--- @param callback function The callback function to remove
--- @return BaseElement self The element instance
function BaseElement:removeStoreChange(storeName, callback)
    local main = self:getBaseFrame()
    local observers = main.get("storeObserver")

    if observers[storeName] then
        for i, observer in ipairs(observers[storeName]) do
            if observer == callback then
                table.remove(observers[storeName], i)
                break
            end
        end
    end
    return self
end

function BaseElement:computed(name, func)
    local main = self:getBaseFrame()
    local stores = main.get("stores")

    if stores[name] then
        errorManager.error("Computed store '" .. name .. "' already exists")
        return self
    end

    stores[name] = {
        computeFn = func,
        value = func(self),
        computed = true,
    }

    return self
end

--- Binds a property to a store
--- @param self BaseElement The element to bind
--- @param propertyName string The property to bind
--- @param storeName string The store to bind to (optional, uses propertyName if not provided)
--- @return BaseElement self The element instance
function BaseElement:bind(propertyName, storeName)
    storeName = storeName or propertyName
    local main = self:getBaseFrame()
    local internalCall = false

    if self.get(propertyName) ~= nil then
        self.set(propertyName, main:getStore(storeName))
    end

    self:onChange(propertyName, function(self, value)
        if internalCall then return end
        internalCall = true
        self:setStore(storeName, value)
        internalCall = false
    end)

    self:onStoreChange(storeName, function(name, value)
        if internalCall then return end
        internalCall = true
        if self.get(propertyName) ~= nil then
            self.set(propertyName, value)
        end
        internalCall = false
    end)

    return self
end

return {
    BaseElement = BaseElement,
    BaseFrame = BaseFrame
}

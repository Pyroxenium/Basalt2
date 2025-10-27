local args = table.pack(...)
local dir = fs.getDir(args[2] or "basalt")
local subDir = args[1]
if(dir==nil)then
    error("Unable to find directory "..args[2].." please report this bug to our discord.")
end

local log = require("log")
local defaultPath = package.path
local format = "path;/path/?.lua;/path/?/init.lua;"
local main = format:gsub("path", dir)

--- This class manages elements and plugins. It loads elements and plugins from the elements and plugins directories
--- and then applies the plugins to the elements. It also provides a way to get elements and APIs.
--- @class ElementManager
local ElementManager = {}
ElementManager._elements = {}
ElementManager._plugins = {}
ElementManager._APIs = {}
ElementManager._config = {
    autoLoadMissing = false,
    allowRemoteLoading = false,
    allowDiskLoading = true,
    remoteSources = {},
    diskMounts = {},
    useGlobalCache = false,
    globalCacheName = "_BASALT_ELEMENT_CACHE"
}

local elementsDirectory = fs.combine(dir, "elements")
local pluginsDirectory = fs.combine(dir, "plugins")

log.info("Loading elements from "..elementsDirectory)
if fs.exists(elementsDirectory) then
    for _, file in ipairs(fs.list(elementsDirectory)) do
        local name = file:match("(.+).lua")
        if name then
            log.debug("Found element: "..name)
            ElementManager._elements[name] = {
                class = nil,
                plugins = {},
                loaded = false,
                source = "local",
                path = nil
            }
        end
    end
end

log.info("Loading plugins from "..pluginsDirectory)
if fs.exists(pluginsDirectory) then
    for _, file in ipairs(fs.list(pluginsDirectory)) do
        local name = file:match("(.+).lua")
        if name then
            log.debug("Found plugin: "..name)
            local plugin = require(fs.combine("plugins", name))
            if type(plugin) == "table" then
                for k,v in pairs(plugin) do
                    if(k ~= "API")then
                        if(ElementManager._plugins[k]==nil)then
                            ElementManager._plugins[k] = {}
                        end
                        table.insert(ElementManager._plugins[k], v)
                    else
                        ElementManager._APIs[name] = v
                    end
                end
            end
        end
    end
end

if(minified)then
    if(minified_elementDirectory==nil)then
        error("Unable to find minified_elementDirectory please report this bug to our discord.")
    end
    for name,v in pairs(minified_elementDirectory)do
        ElementManager._elements[name:gsub(".lua", "")] = {
            class = nil,
            plugins = {},
            loaded = false,
            source = "local",
            path = nil
        }
    end
    if(minified_pluginDirectory==nil)then
        error("Unable to find minified_pluginDirectory please report this bug to our discord.")
    end
    for name,_ in pairs(minified_pluginDirectory)do
        local plugName = name:gsub(".lua", "")
        local plugin = require(fs.combine("plugins", plugName))
        if type(plugin) == "table" then
            for k,v in pairs(plugin) do
                if(k ~= "API")then
                    if(ElementManager._plugins[k]==nil)then
                        ElementManager._plugins[k] = {}
                    end
                    table.insert(ElementManager._plugins[k], v)
                else
                    ElementManager._APIs[plugName] = v
                end
            end
        end
    end
end

local function saveToGlobalCache(name, element)
    if not ElementManager._config.useGlobalCache then return end

    if not _G[ElementManager._config.globalCacheName] then
        _G[ElementManager._config.globalCacheName] = {}
    end

    _G[ElementManager._config.globalCacheName][name] = element
    log.debug("Cached element in _G: "..name)
end

local function loadFromGlobalCache(name)
    if not ElementManager._config.useGlobalCache then return nil end

    if _G[ElementManager._config.globalCacheName] and 
       _G[ElementManager._config.globalCacheName][name] then
        log.debug("Loaded element from _G cache: "..name)
        return _G[ElementManager._config.globalCacheName][name]
    end

    return nil
end

--- Configures the ElementManager
--- @param config table Configuration options
function ElementManager.configure(config)
    for k, v in pairs(config) do
        if ElementManager._config[k] ~= nil then
            ElementManager._config[k] = v
        end
    end
end

--- Registers a disk mount point for loading elements
--- @param mountPath string The path to the disk mount
function ElementManager.registerDiskMount(mountPath)
    if not fs.exists(mountPath) then
        error("Disk mount path does not exist: "..mountPath)
    end
    table.insert(ElementManager._config.diskMounts, mountPath)
    log.info("Registered disk mount: "..mountPath)

    local elementsPath = fs.combine(mountPath, "elements")
    if fs.exists(elementsPath) then
        for _, file in ipairs(fs.list(elementsPath)) do
            local name = file:match("(.+).lua")
            if name then
                if not ElementManager._elements[name] then
                    log.debug("Found element on disk: "..name)
                    ElementManager._elements[name] = {
                        class = nil,
                        plugins = {},
                        loaded = false,
                        source = "disk",
                        path = fs.combine(elementsPath, file)
                    }
                end
            end
        end
    end
end

--- Registers a remote source for an element
--- @param elementName string The name of the element
--- @param url string The URL to load the element from
function ElementManager.registerRemoteSource(elementName, url)
    if not ElementManager._config.allowRemoteLoading then
        error("Remote loading is disabled. Enable with ElementManager.configure({allowRemoteLoading = true})")
    end
    ElementManager._config.remoteSources[elementName] = url

    if not ElementManager._elements[elementName] then
        ElementManager._elements[elementName] = {
            class = nil,
            plugins = {},
            loaded = false,
            source = "remote",
            path = url
        }
    else
        ElementManager._elements[elementName].source = "remote"
        ElementManager._elements[elementName].path = url
    end

    log.info("Registered remote source for "..elementName..": "..url)
end

local function loadFromRemote(url)
    if not http then
        error("HTTP API is not available. Enable it in your CC:Tweaked config.")
    end

    log.info("Loading element from remote: "..url)

    local response = http.get(url)
    if not response then
        error("Failed to download from: "..url)
    end

    local content = response.readAll()
    response.close()

    if not content or content == "" then
        error("Empty response from: "..url)
    end

    local func, err = load(content, url, "t", _ENV)
    if not func then
        error("Failed to load element from "..url..": "..tostring(err))
    end

    local element = func()
    return element
end

local function loadFromDisk(path)
    if not fs.exists(path) then
        error("Element file does not exist: "..path)
    end

    log.info("Loading element from disk: "..path)

    local func, err = loadfile(path)
    if not func then
        error("Failed to load element from "..path..": "..tostring(err))
    end

    local element = func()
    return element
end

--- Tries to load an element from any available source
--- @param name string The element name
--- @return boolean success Whether the element was loaded
function ElementManager.tryAutoLoad(name)
    -- Try disk mounts first
    if ElementManager._config.allowDiskLoading then
        for _, mountPath in ipairs(ElementManager._config.diskMounts) do
            local elementsPath = fs.combine(mountPath, "elements")
            local filePath = fs.combine(elementsPath, name..".lua")

            if fs.exists(filePath) then
                ElementManager._elements[name] = {
                    class = nil,
                    plugins = {},
                    loaded = false,
                    source = "disk",
                    path = filePath
                }
                ElementManager.loadElement(name)
                return true
            end
        end
    end

    if ElementManager._config.allowRemoteLoading and ElementManager._config.remoteSources[name] then
        ElementManager.loadElement(name)
        return true
    end

    return false
end

--- Loads an element by name. This will load the element and apply any plugins to it.
--- @param name string The name of the element to load
--- @usage ElementManager.loadElement("Button")
function ElementManager.loadElement(name)
    if not ElementManager._elements[name] then
        -- Try to auto-load if enabled
        if ElementManager._config.autoLoadMissing then
            local success = ElementManager.tryAutoLoad(name)
            if not success then
                error("Element '"..name.."' not found and could not be auto-loaded")
            end
        else
            error("Element '"..name.."' not found")
        end
    end

    if not ElementManager._elements[name].loaded then
        local source = ElementManager._elements[name].source or "local"
        local element
        local loadedFromCache = false

        element = loadFromGlobalCache(name)
        if element then
            loadedFromCache = true
            log.info("Loaded element from _G cache: "..name)
        elseif source == "local" then
            package.path = main.."rom/?"
            element = require(fs.combine("elements", name))
            package.path = defaultPath
        elseif source == "disk" then
            if not ElementManager._config.allowDiskLoading then
                error("Disk loading is disabled for element: "..name)
            end
            element = loadFromDisk(ElementManager._elements[name].path)
            saveToGlobalCache(name, element)
        elseif source == "remote" then
            if not ElementManager._config.allowRemoteLoading then
                error("Remote loading is disabled for element: "..name)
            end
            element = loadFromRemote(ElementManager._elements[name].path)
            saveToGlobalCache(name, element)
        else
            error("Unknown source type: "..source)
        end

        ElementManager._elements[name] = {
            class = element,
            plugins = element.plugins,
            loaded = true,
            source = loadedFromCache and "cache" or source,
            path = ElementManager._elements[name].path
        }

        if not loadedFromCache then
            log.debug("Loaded element: "..name.." from "..source)
        end

        if(ElementManager._plugins[name]~=nil)then
            for _, plugin in pairs(ElementManager._plugins[name]) do
                if(plugin.setup)then
                    plugin.setup(element)
                end

                if(plugin.hooks)then
                    for methodName, hooks in pairs(plugin.hooks) do
                        local original = element[methodName]
                        if(type(original)~="function")then
                            error("Element "..name.." does not have a method "..methodName)
                        end
                        if(type(hooks)=="function")then
                            element[methodName] = function(self, ...)
                                local result = original(self, ...)
                                local hookResult = hooks(self, ...)
                                return hookResult == nil and result or hookResult
                            end
                        elseif(type(hooks)=="table")then
                            element[methodName] = function(self, ...)
                                if hooks.pre then hooks.pre(self, ...) end
                                local result = original(self, ...)
                                if hooks.post then hooks.post(self, ...) end
                                return result
                            end
                        end
                    end
                end

                for funcName, func in pairs(plugin) do
                    if funcName ~= "setup" and funcName ~= "hooks" then
                        element[funcName] = func
                    end
                end
            end
        end
    end
end

--- Gets an element by name. If the element is not loaded, it will try to load it first.
--- @param name string The name of the element to get
--- @return table Element The element class
function ElementManager.getElement(name)
    if not ElementManager._elements[name] then
        if ElementManager._config.autoLoadMissing then
            local success = ElementManager.tryAutoLoad(name)
            if not success then
                error("Element '"..name.."' not found")
            end
        else
            error("Element '"..name.."' not found")
        end
    end

    if not ElementManager._elements[name].loaded then
        ElementManager.loadElement(name)
    end
    return ElementManager._elements[name].class
end

--- Gets a list of all elements
--- @return table ElementList A list of all elements
function ElementManager.getElementList()
    return ElementManager._elements
end

--- Gets an Plugin API by name
--- @param name string The name of the API to get
--- @return table API The API
function ElementManager.getAPI(name)
    return ElementManager._APIs[name]
end

--- Checks if an element exists (is registered)
--- @param name string The element name
--- @return boolean exists Whether the element exists
function ElementManager.hasElement(name)
    return ElementManager._elements[name] ~= nil
end

--- Checks if an element is loaded
--- @param name string The element name
--- @return boolean loaded Whether the element is loaded
function ElementManager.isElementLoaded(name)
    return ElementManager._elements[name] and ElementManager._elements[name].loaded or false
end

--- Clears the global cache (_G)
--- @usage ElementManager.clearGlobalCache()
function ElementManager.clearGlobalCache()
    if _G[ElementManager._config.globalCacheName] then
        _G[ElementManager._config.globalCacheName] = nil
        log.info("Cleared global element cache")
    end
end

--- Gets cache statistics
--- @return table stats Cache statistics with size and element names
function ElementManager.getCacheStats()
    if not _G[ElementManager._config.globalCacheName] then
        return {size = 0, elements = {}}
    end

    local elements = {}
    for name, _ in pairs(_G[ElementManager._config.globalCacheName]) do
        table.insert(elements, name)
    end

    return {
        size = #elements,
        elements = elements
    }
end

--- Preloads elements into the global cache
--- @param elementNames table List of element names to preload
function ElementManager.preloadElements(elementNames)
    for _, name in ipairs(elementNames) do
        if ElementManager._elements[name] and not ElementManager._elements[name].loaded then
            ElementManager.loadElement(name)
        end
    end
end

return ElementManager
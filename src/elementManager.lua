local args = table.pack(...)
local dir = fs.getDir(args[2] or "basalt")
if(dir==nil)then
    error("Unable to find directory "..args[2].." please report this bug to our discord.")
end

local log = require("log")

local ElementManager = {}
ElementManager._elements = {}
ElementManager._plugins = {}
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
                loaded = false
            }
        end
    end
end

function ElementManager.extendMethod(element, methodName, newMethod, originalMethod)
    if not originalMethod then
        element[methodName] = newMethod
        return
    end
    element[methodName] = function(self, ...)
        if newMethod.before then
            newMethod.before(self, ...)
        end

        local results
        if newMethod.override then
            results = {newMethod.override(self, originalMethod, ...)}
        else
            results = {originalMethod(self, ...)}
        end

        if newMethod.after then
            newMethod.after(self, ...)
        end

        return table.unpack(results)
    end
end

function ElementManager.loadPlugin(name)
    local plugin = require("plugins/"..name)

    -- Apply plugin to each targeted element
    for elementName, pluginData in pairs(plugin) do
        local element = ElementManager._elements[elementName]
        if element then
            -- Register properties
            if pluginData.properties then
                element.class.initialize(elementName.."Plugin")
                for propName, config in pairs(pluginData.properties) do
                    element.class.registerProperty(propName, config)
                end
            end

            -- Register/extend methods
            if pluginData.methods then
                for methodName, methodData in pairs(pluginData.methods) do
                    ElementManager.extendMethod(
                        element.class,
                        methodName,
                        methodData,
                        element.class[methodName]
                    )
                end
            end
        end
    end
end

function ElementManager.loadElement(name)
    if not ElementManager._elements[name].loaded then
        local element = require("elements/"..name)
        ElementManager._elements[name] = {
            class = element,
            plugins = element.plugins,
            loaded = true
        }
        log.debug("Loaded element: "..name)

        -- Load element's required plugins
        if element.requires then
            for pluginName, _ in pairs(element.requires) do
                --ElementManager.loadPlugin(pluginName)
            end
        end
    end
end

function ElementManager.registerPlugin(name, plugin)
    if not plugin.provides then
        error("Plugin must specify what it provides")
    end
    ElementManager._plugins[name] = plugin
end

function ElementManager.getElement(name)
    if not ElementManager._elements[name].loaded then
        ElementManager.loadElement(name)
    end
    return ElementManager._elements[name].class
end

function ElementManager.getElementList()
    return ElementManager._elements
end

function ElementManager.generateId()
    return string.format('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
    math.random(0, 0xffff), math.random(0, 0xffff), math.random(0, 0xffff),
    math.random(0, 0x0fff) + 0x4000, math.random(0, 0x3fff) + 0x8000,
    math.random(0, 0xffff), math.random(0, 0xffff), math.random(0, 0xffff))
end

return ElementManager
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

log.info("Loading plugins from "..pluginsDirectory)
if fs.exists(pluginsDirectory) then
    for _, file in ipairs(fs.list(pluginsDirectory)) do
        local name = file:match("(.+).lua")
        if name then
            log.debug("Found plugin: "..name)
            local plugin = require(fs.combine("plugins", name))
            if type(plugin) == "table" then
                for k,v in pairs(plugin) do
                    if(ElementManager._plugins[k]==nil)then
                        ElementManager._plugins[k] = {}
                    end
                    table.insert(ElementManager._plugins[k], v)
                end
            end
        end
    end
end

function ElementManager.loadElement(name)
    if not ElementManager._elements[name].loaded then
        package.path = main.."rom/?"
        local element = require(fs.combine("elements", name))
        package.path = defaultPath
        ElementManager._elements[name] = {
            class = element,
            plugins = element.plugins,
            loaded = true
        }
        log.debug("Loaded element: "..name)

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
                                original(self, ...)
                                return hooks(self, ...)
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
                        element[funcName] = function(self, ...)
                            return func(self, ...)
                        end
                    end
                end
            end
        end
    end
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

return ElementManager
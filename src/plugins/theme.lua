local errorManager = require("errorManager")
local defaultTheme = {
    default = {
        background = colors.lightGray,
        foreground = colors.black,
    },
    BaseFrame = {
        background = colors.white,
        foreground = colors.black,

        Frame = {
            background = colors.black,
            names = {
                basaltDebugLogClose = {
                    background = colors.blue,
                    foreground = colors.white
                }
            },
        },
        Button = {
            background = "{self.clicked and colors.black or colors.cyan}",
            foreground = "{self.clicked and colors.cyan or colors.black}",
        },

        names = {
            basaltDebugLog = {
                background = colors.red,
                foreground = colors.white
            },
            test = {
                background = "{self.clicked and colors.black or colors.green}",
                foreground = "{self.clicked and colors.green or colors.black}"
            }
        },
    }
}

local themes = {
    default = defaultTheme
}

---@title title

local currentTheme = "default"

--- This is the theme plugin. It provides a theming system that allows for consistent styling across elements
--- with support for inheritance, named styles, and dynamic theme switching.
---@class BaseElement
local BaseElement = {
    hooks = {
        postInit = {
            pre = function(self)
                if self._postInitialized then
                    return self
                end
                self:applyTheme()
            end
        }
    }
}

---@private
function BaseElement.____getElementPath(self, types)
    if types then
        table.insert(types, 1, self._values.type)
    else
        types = {self._values.type}
    end
    local parent = self.parent
    if parent then
        return parent.____getElementPath(parent, types)
    else
        return types
    end
end

local function lookUpTemplate(theme, path)
    local current = theme

    for i = 1, #path do
        local found = false
        local types = path[i]

        for _, elementType in ipairs(types) do
            if current[elementType] then
                current = current[elementType]
                found = true
                break
            end
        end

        if not found then
            return nil
        end
    end

    return current
end

local function getDefaultProperties(theme, elementType)
    local result = {}
    if theme.default then
        for k,v in pairs(theme.default) do
            if type(v) ~= "table" then
                result[k] = v
            end
        end

        if theme.default[elementType] then
            for k,v in pairs(theme.default[elementType]) do
                if type(v) ~= "table" then
                    result[k] = v
                end
            end
        end
    end
    return result
end

local function applyNamedStyles(result, theme, elementType, elementName, themeTable)
    if theme.default and theme.default.names and theme.default.names[elementName] then
        for k,v in pairs(theme.default.names[elementName]) do
            if type(v) ~= "table" then result[k] = v end
        end
    end

    if theme.default and theme.default[elementType] and theme.default[elementType].names 
       and theme.default[elementType].names[elementName] then
        for k,v in pairs(theme.default[elementType].names[elementName]) do
            if type(v) ~= "table" then result[k] = v end
        end
    end

    if themeTable and themeTable.names and themeTable.names[elementName] then
        for k,v in pairs(themeTable.names[elementName]) do
            if type(v) ~= "table" then result[k] = v end
        end
    end
end

local function collectThemeProps(theme, path, elementType, elementName)
    local result = {}
    local themeTable = lookUpTemplate(theme, path)
    if themeTable then
        for k,v in pairs(themeTable) do
            if type(v) ~= "table" then
                result[k] = v
            end
        end
    end

    if next(result) == nil then
        result = getDefaultProperties(theme, elementType)
    end

    applyNamedStyles(result, theme, elementType, elementName, themeTable)

    return result
end

--- Applies the current theme to this element
--- @shortDescription Applies theme styles to the element
--- @param self BaseElement The element to apply theme to
--- @param applyToChildren boolean? Whether to apply theme to child elements (default: true)
--- @return BaseElement self The element instance
function BaseElement:applyTheme(applyToChildren)
    local styles = self:getTheme()
    if(styles ~= nil) then
        for prop, value in pairs(styles) do
            local config = self._properties[prop]
            if(config)then
                if((config.type)=="color")then
                    if(type(value)=="string")then
                        if(colors[value])then
                            value = colors[value]
                        end
                    end
                end
                self.set(prop, value)
            end
        end
    end
    if(applyToChildren~=false)then
        if(self:isType("Container"))then
            local children = self.get("children")
            for _, child in ipairs(children) do
                if(child and child.applyTheme)then
                    child:applyTheme()
                end
            end
        end
    end
    return self
end

--- Gets the theme properties for this element
--- @shortDescription Gets theme properties for the element
--- @param self BaseElement The element to get theme for
--- @return table styles The theme properties
function BaseElement:getTheme()
    local path = self:____getElementPath()
    local elementType = self.get("type")
    local elementName = self.get("name")

    return collectThemeProps(themes[currentTheme], path, elementType, elementName)
end

--- The Theme API provides methods for managing themes globally
---@class ThemeAPI
local ThemeAPI = {}

--- Sets the current theme
--- @shortDescription Sets a new theme
--- @param newTheme table The theme configuration to set
function ThemeAPI.setTheme(newTheme)
    themes.default = newTheme
end

--- Gets the current theme configuration
--- @shortDescription Gets the current theme
--- @return table theme The current theme configuration
function ThemeAPI.getTheme()
    return themes.default
end

--- Loads a theme from a JSON file
--- @shortDescription Loads theme from JSON file
--- @param path string Path to the theme JSON file
function ThemeAPI.loadTheme(path)
    local file = fs.open(path, "r")
    if file then
        local content = file.readAll()
        file.close()
        themes.default = textutils.unserializeJSON(content)
        if not themes.default then
            errorManager.error("Failed to load theme from " .. path)
        end
    else
        errorManager.error("Could not open theme file: " .. path)
    end
end

return {
    BaseElement = BaseElement,
    API = ThemeAPI
}

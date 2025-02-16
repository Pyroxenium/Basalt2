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

local currentTheme = "default"

local BaseElement = {
    hooks = {
        postInit = {
            pre = function(self)
            self:applyTheme()
        end}
    }
}

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

 function BaseElement:applyTheme()
    local styles = self:getTheme()
    if(styles ~= nil) then
        for prop, value in pairs(styles) do
            self.set(prop, value)
        end
    end
end

function BaseElement:getTheme()
    local path = self:____getElementPath()
    local elementType = self.get("type")
    local elementName = self.get("name")

    return collectThemeProps(themes[currentTheme], path, elementType, elementName)
end

local themeAPI = {
    setTheme = function(newTheme)
        defaultTheme = newTheme
    end,

    getTheme = function()
        return defaultTheme
    end,

    loadTheme = function(path)
        local file = fs.open(path, "r")
        if file then
            local content = file.readAll()
            file.close()
            defaultTheme = textutils.unserializeJSON(content)
        end
    end
}

local Theme = {
    BaseElement = BaseElement,
    API = themeAPI
}

return Theme

local defaultTheme = {
    default = {
        background = colors.lightGray,
        foreground = colors.black,
    },
    BaseFrame = {
        background = colors.white,
        foreground = colors.black,

        Frame = {
            background = colors.gray,

            Button = {
                background = "{self.clicked and colors.black or colors.blue}",
                foreground = "{self.clicked and colors.blue or colors.white}"
            }
        },

        Button = {
            background = "{self.clicked and colors.black or colors.cyan}",
            foreground = "{self.clicked and colors.cyan or colors.black}"
        },

        Input = {
            background = "{self.focused and colors.cyan or colors.lightGray}",
            foreground = colors.black,
            placeholderColor = colors.gray
        },

        List = {
            background = colors.cyan,
            foreground = colors.black,
            selectedColor = colors.blue
        }
    }
}

local themes = {
    default = defaultTheme
}

local currentTheme = "default"

local function resolveThemeValue(value, theme)
    if type(value) == "string" and theme.colors[value] then
        return theme.colors[value]
    end
    return value
end

local function getThemeForElement(element)
    local path = {}
    local current = element

    while current do
        table.insert(path, 1, current.get("type"))
        current = current.parent
    end

    local result = {}
    local current = defaultTheme

    for _, elementType in ipairs(path) do
        if current[elementType] then
            for k,v in pairs(current[elementType]) do
                result[k] = v
            end
            current = current[elementType]
        end
    end

    return result
end

local function applyTheme(element, props)

    local theme = getThemeForElement(element)

    if props then
        for k,v in pairs(props) do
            theme[k] = v
        end
    end

    for k,v in pairs(theme) do
        if element:getPropertyConfig(k) then
            element.set(k, v)
        end
    end
end

local BaseElement = {
    hooks = {
        init = function(self)
            self.defineProperty(self, "theme", {
                default = currentTheme,
                type = "string",
                setter = function(self, value)
                    self:applyTheme(value)
                    return value
                end
            })
        end
    }
}

function BaseElement:applyTheme(themeName)
    local theme = themes[themeName] or themes.default
    local elementType = self.get("type")

    if theme.elementStyles[elementType] then
        local styles = theme.elementStyles[elementType]
        for prop, value in pairs(styles) do
            if self:getPropertyConfig(prop) then
                self.set(prop, resolveThemeValue(value, theme))
            end
        end
    end
end

local BaseFrame = {
    hooks = {
        init = function(self)
            applyTheme(self)
        end
    }
}

local Container = {
    hooks = {
        init = function(self)
            for k, _ in pairs(self.basalt.getElementManager().getElementList()) do
                local capitalizedName = k:sub(1,1):upper() .. k:sub(2)
                if capitalizedName ~= "BaseFrame" then  
                    local methodName = "add"..capitalizedName
                    local original = self[methodName]
                    if original then
                        self[methodName] = function(self, name, props)
                            if type(name) == "table" then
                                props = name
                                name = nil
                            end
                            local element = original(self, name)
                            applyTheme(element, props)
                            return element
                        end
                    end
                end
            end
        end
    }
}

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
    setup = function(basalt)
        basalt.setTheme(defaultTheme)
    end,

    BaseElement = BaseElement,
    BaseFrame = BaseFrame,
    Container = Container,
    API = themeAPI
}

return Theme

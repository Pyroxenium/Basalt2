-- Has to be reworked

local Theme = {}

local defaultTheme = {
    colors = {
        primary = colors.blue,
        secondary = colors.cyan,
        background = colors.black,
        text = colors.white,
        borders = colors.gray,
        error = colors.red,
        success = colors.green,
    },
    elementStyles = {
        Button = {
            background = "background",
            foreground = "text",
            activeBackground = "primary",
            activeForeground = "text",
        },
        Input = {
            background = "background",
            foreground = "text",
            focusBackground = "primary",
            focusForeground = "text",
        },
        Frame = {
            background = "background",
            foreground = "text"
        }
    }
}

local themes = {
    default = defaultTheme
}

local currentTheme = "default"

function Theme.registerTheme(name, theme)
    themes[name] = theme
end

local function resolveThemeValue(value, theme)
    if type(value) == "string" and theme.colors[value] then
        return theme.colors[value]
    end
    return value
end

local BaseElement = {
    hooks = {
        init = function(self)
            -- Theme Properties für das Element registrieren
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

local Container = {
    hooks = {      
        addChild = function(self, child)
            if self.get("themeInherit") then
                child.set("theme", self.get("theme"))
            end
        end
    }
}

function Container.setup(element)
    element.defineProperty(element, "themeInherit", {default = true, type = "boolean"})
end

return {
    BaseElement = BaseElement,
    Container = Container,
}

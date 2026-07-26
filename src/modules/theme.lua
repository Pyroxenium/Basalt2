-- Theme module: restyle elements without touching them individually.
--
--   local theme = basalt.use("theme")
--   theme.set({ Button = { background = basalt.rgb("#89b4fa") } })
--   theme.apply(frame, { Label = { foreground = colors.yellow } })
--
-- theme.set() changes CLASS defaults: every element that never set the
-- property explicitly follows immediately (including existing ones).
-- theme.apply() assigns per element (explicit override) on a subtree.
-- A `states` table defines property overrides while named states are active.
--
-- Values may be plain values or functions (dynamic values). Reactive
-- "{...}" strings only work in apply(), not in set() — defaults are shared
-- between elements, use a function instead.

local require = ...
local palette = require("core/palette")

local theme = {}

local function validateStateStyle(cls, typeName, stateName, style)
    if type(style) ~= "table" then
        error("Basalt theme: state '" .. stateName .. "' for "
            .. typeName .. " must be a table", 3)
    end
    for propName, value in pairs(style) do
        local prop = cls.__props[propName]
        if not prop then
            error("Basalt theme: unknown property '" .. propName
                .. "' for " .. typeName .. " state " .. stateName, 3)
        end
        if not prop.styleable then
            error("Basalt theme: property '" .. propName
                .. "' cannot be state-styled", 3)
        end
        if type(value) == "string" and value:sub(1, 1) == "{" then
            error("Basalt theme: reactive strings are not allowed in set() "
                .. "state styles; use a function instead", 3)
        end
    end
end

--- Known element classes; extend this table to theme custom elements.
theme.classes = {
    Element = require("core/element"),
    Container = require("core/container"),
    BaseFrame = require("core/baseframe"),
    Label = require("elements/Label"),
    Button = require("elements/Button"),
    Frame = require("elements/Frame"),
    Input = require("elements/Input"),
    Checkbox = require("elements/Checkbox"),
    Switch = require("elements/Switch"),
    ProgressBar = require("elements/ProgressBar"),
    Slider = require("elements/Slider"),
    Collection = require("elements/Collection"),
    List = require("elements/List"),
    Dropdown = require("elements/Dropdown"),
    Flex = require("elements/Flex"),
    Row = require("elements/Row"),
    Column = require("elements/Column"),
    TextBox = require("elements/TextBox"),
    Menu = require("elements/Menu"),
    TabControl = require("elements/TabControl"),
    Tree = require("elements/Tree"),
    Table = require("elements/Table"),
    Program = require("elements/Program"),
    ComboBox = require("elements/ComboBox"),
    ContextMenu = require("elements/ContextMenu"),
    Dialog = require("elements/Dialog"),
    Toast = require("elements/Toast"),
}

--- Changes class-level defaults for the given element types.
---@param themeTable table Map of type name -> { property = value, states = {...} }
---@usage theme.set({ Button = { background = colors.blue } })
function theme.set(themeTable)
    for typeName, props in pairs(themeTable) do
        local cls = theme.classes[typeName]
        if not cls then
            error("Basalt theme: unknown element type '" .. typeName .. "'", 2)
        end
        for k, v in pairs(props) do
            if k == "states" then
                if type(v) ~= "table" then
                    error("Basalt theme: states for " .. typeName
                        .. " must be a table", 2)
                end
                for stateName, style in pairs(v) do
                    validateStateStyle(cls, typeName, stateName, style)
                    cls.__stateStyles[stateName] = style
                end
            elseif cls.__props[k] == nil then
                error("Basalt theme: unknown property '" .. k
                    .. "' for " .. typeName, 2)
            elseif type(v) == "string" and v:sub(1, 1) == "{" then
                error("Basalt theme: reactive strings are not allowed in "
                    .. "set() (defaults are shared); use a function instead", 2)
            else
                cls.__defaults[k] = v
            end
        end
    end
end

----------------------------------------------------------------------------
-- presets
----------------------------------------------------------------------------

-- "Vulkangestein & Lava": Basalt's signature look. Dark, slightly blue
-- volcanic stone with a warm lava accent.
local c = {
    bg = palette.rgb("#14161B"),
    surface = palette.rgb("#22262E"),
    raised = palette.rgb("#2E333D"),
    border = palette.rgb("#3D434F"),
    text = palette.rgb("#E8E6E1"),
    muted = palette.rgb("#9AA0AB"),
    lava = palette.rgb("#E8703A"),
    ember = palette.rgb("#F49058"),
    selection = palette.rgb("#3E5F82"),
    success = palette.rgb("#8FBB56"),
    warning = palette.rgb("#E5B95C"),
    danger = palette.rgb("#D9534F"),
    info = palette.rgb("#5E9BD6"),
}

theme.presets = {
    basalt = {
        colors = c,
        styles = {
            Element = { foreground = c.text },
            BaseFrame = { background = c.bg },
            Frame = { background = c.surface },
            Button = {
                background = c.raised,
                states = { hover = { background = c.border } },
            },
            Input = {
                background = c.raised,
                foreground = c.text,
                placeholderColor = c.muted,
            },
            Switch = {
                onColor = c.success,
                offColor = c.border,
                knobColor = c.text,
            },
            ProgressBar = { background = c.border, barColor = c.lava },
            Slider = { barColor = c.border, knobColor = c.lava },
            List = {
                background = c.surface,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                emptyTextColor = c.muted,
                scrollbarColor = c.raised,
                scrollbarThumbColor = c.border,
            },
            Dropdown = {
                background = c.raised,
                dropBackground = c.surface,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                scrollbarColor = c.raised,
                scrollbarThumbColor = c.border,
            },
            ComboBox = {
                background = c.raised,
                foreground = c.text,
                placeholderColor = c.muted,
                dropBackground = c.surface,
                dropForeground = c.text,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                scrollbarColor = c.raised,
                scrollbarThumbColor = c.border,
            },
            Menu = {
                background = c.surface,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                separatorColor = c.muted,
                dropBackground = c.raised,
            },
            TabControl = {
                background = c.bg,
                headerBackground = c.surface,
                activeBackground = c.lava,
                activeForeground = c.bg,
            },
            Tree = {
                background = c.surface,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                scrollbarColor = c.raised,
                scrollbarThumbColor = c.border,
            },
            Table = {
                background = c.surface,
                headerBackground = c.raised,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                scrollbarColor = c.raised,
                scrollbarThumbColor = c.border,
            },
            TextBox = {
                background = c.surface,
                selectionBackground = c.selection,
                selectionForeground = c.text,
                scrollbarColor = c.raised,
                scrollbarThumbColor = c.border,
            },
            ContextMenu = {
                background = c.raised,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                separatorColor = c.muted,
            },
            Dialog = {
                boxBackground = c.surface,
                boxForeground = c.text,
                titleBackground = c.lava,
                titleForeground = c.bg,
            },
            Program = { background = c.bg },
        },
    },
}

--- Applies a preset (by name or as a table from theme.load) via theme.set.
---@param presetOrName string|table Preset name or loaded preset table
---@return table colors The preset's color tokens
---@usage local pal = theme.applyPreset("basalt")
function theme.applyPreset(presetOrName)
    local preset = type(presetOrName) == "table"
        and presetOrName or theme.presets[presetOrName]
    if not preset then
        error("Basalt theme: unknown preset '"
            .. tostring(presetOrName) .. "'", 2)
    end
    theme.set(preset.styles)
    return preset.colors
end

----------------------------------------------------------------------------
-- theme files (JSON)
----------------------------------------------------------------------------

--- Resolves a theme file value into a real color:
---   "#RRGGBB" / "#RGB" / "#AARRGGBB"  -> basalt.rgb(...)
---   "$token"                          -> entry from the file's colors table
---   "red", "lightGray", ...           -> colors.* constant
--- Anything else (numbers, booleans, plain strings) passes through.
local function resolveColor(value, tokens)
    if type(value) ~= "string" then return value end
    if value:sub(1, 1) == "$" then
        local token = tokens[value:sub(2)]
        if token == nil then
            error("Basalt theme: unknown color token '" .. value .. "'", 0)
        end
        return token
    end
    if value:sub(1, 1) == "#" then
        return palette.rgb(value)
    end
    if type(colors[value]) == "number" then
        return colors[value]
    end
    return value
end

--- Loads a theme file and registers it as a preset. Returns (name, preset);
--- pass the name straight into applyPreset:
---   theme.applyPreset(theme.load("themes/obsidian.json"))
--- .json files are parsed as JSON, everything else with textutils.unserialize.
---@param path string Path to the theme file
---@return string name The registered preset name
---@return table preset The resolved preset ({ colors, styles })
function theme.load(path)
    local handle = fs.open(path, "r")
    if not handle then
        error("Basalt theme: cannot open " .. tostring(path), 2)
    end
    local content = handle.readAll()
    handle.close()

    local data
    if path:match("%.json$") then
        local parse = textutils.unserialiseJSON or textutils.unserializeJSON
        data = parse(content)
    else
        data = textutils.unserialize(content)
    end
    if type(data) ~= "table" then
        error("Basalt theme: " .. path .. " is not a valid theme file", 2)
    end

    -- resolve the colors table first (plain values, then $references)
    local tokens = {}
    local rawColors = data.colors or {}
    for key, value in pairs(rawColors) do
        if not (type(value) == "string" and value:sub(1, 1) == "$") then
            tokens[key] = resolveColor(value, tokens)
        end
    end
    for key, value in pairs(rawColors) do
        if type(value) == "string" and value:sub(1, 1) == "$" then
            tokens[key] = resolveColor(value, tokens)
        end
    end

    local styles = {}
    for typeName, props in pairs(data.styles or {}) do
        local resolved = {}
        for key, value in pairs(props) do
            if key == "states" then
                local states = {}
                for stateName, style in pairs(value) do
                    local stateStyle = {}
                    for propName, propValue in pairs(style) do
                        stateStyle[propName] = resolveColor(propValue, tokens)
                    end
                    states[stateName] = stateStyle
                end
                resolved.states = states
            else
                resolved[key] = resolveColor(value, tokens)
            end
        end
        styles[typeName] = resolved
    end

    local name = data.name or fs.getName(path):gsub("%.%w+$", "")
    local preset = { colors = tokens, styles = styles }
    theme.presets[name] = preset
    return name, preset
end

--- Applies properties to every matching element in a subtree (by type name).
---@param root Element Root element
---@param themeTable table Map of class names to properties/state styles
function theme.apply(root, themeTable)
    local props = themeTable[root.__name]
    if props then
        for k, v in pairs(props) do
            if k == "states" then
                for stateName, style in pairs(v) do
                    root:setStateStyle(stateName, style)
                end
            else
                root[k] = v
            end
        end
    end
    if root.getChildren then
        local ch = root:getChildren()
        for i = 1, #ch do
            theme.apply(ch[i], themeTable)
        end
    end
end

return theme

local basalt = http.get("https://raw.githubusercontent.com/Pyroxenium/Basalt2/master/release/basalt.lua")


local REPO_URL = "https://raw.githubusercontent.com/Pyroxenium/Basalt2/master/src"

-- Basis-Komponenten die immer installiert werden müssen
local REQUIRED_FILES = {
    "init.lua",
    "render.lua",
    "elementManager.lua",
    "propertySystem.lua",
    "elements/BaseElement.lua",
    "elements/VisualElement.lua",
    "elements/Container.lua",
    "elements/BaseFrame.lua"
}

-- Optionale Komponenten
local OPTIONAL_ELEMENTS = {
    "Button",
    "Input",
    "Label",
    "List",
    "Menu",
    "Table",
    "Tree",
    "Dropdown"
}

local OPTIONAL_PLUGINS = {
    "animation",
    "theme",
    "xml",
    "state"
}

local main = basalt.createFrame()
    :setBackground(colors.lightGray)

-- Header
main:addLabel()
    :setText("Basalt2 Installer")
    :setPosition(2,2)
    :setForeground(colors.black)

-- Element Selection
local elementList = main:addList()
    :setPosition(2,4)
    :setSize(20,8)
    :setBackground(colors.white)
    :setForeground(colors.black)

for _, element in ipairs(OPTIONAL_ELEMENTS) do
    elementList:addItem({
        text = element,
        selected = true
    })
end

-- Plugin Selection
local pluginList = main:addList()
    :setPosition(24,4)
    :setSize(20,8)
    :setBackground(colors.white)
    :setForeground(colors.black)

for _, plugin in ipairs(OPTIONAL_PLUGINS) do
    pluginList:addItem({
        text = plugin,
        selected = true
    })
end

-- Labels
main:addLabel()
    :setText("Elements:")
    :setPosition(2,3)
    :setForeground(colors.black)

main:addLabel()
    :setText("Plugins:")
    :setPosition(24,3)
    :setForeground(colors.black)

-- Install Button
main:addButton()
    :setText("Install")
    :setPosition(2,13)
    :setSize(42,1)
    :onClick(function()
        -- Installation Logic hier
        local selectedElements = {}
        local selectedPlugins = {}
        
        -- Sammle ausgewählte Items
        -- Download Files
        -- Erstelle Ordnerstruktur
    end)

basalt.autoUpdate()

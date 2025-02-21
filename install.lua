local basalt = require("src")
local configPath = "https://raw.githubusercontent.com/Pyroxenium/Basalt2/refs/heads/main/config.lua"

local coloring = {foreground=colors.black, background=colors.white}
local currentScreen = 1
local screens = {}
local main = basalt.getMainFrame():setBackground(colors.black)
local config

local function getConfig()
    if not config then
        local request = http.get(configPath)
        if request then
            local content = request.readAll()
            config = load(content)()
            request.close()
        else
            error("Failed to fetch config")
        end
    end
    return config
end

local function getChildrenHeight(container)
    local height = 0
    for _, child in ipairs(container:getChildren()) do
        local newHeight = child.get("y") + child.get("height")
        if newHeight > height then
            height = newHeight
        end
    end
    return height
end

local function createScreen(index)
    local screen = main:addFrame(coloring)
        :onMouseScroll(function(self, direction)
            local height = getChildrenHeight(self)
            local scrollOffset = self:getOffsetY()
            local maxScroll = height - self:getHeight()
            scrollOffset = math.max(0, math.min(maxScroll, scrollOffset + direction))
            self:setOffsetY(scrollOffset)
        end)
        :setSize("{parent.width - 2}", "{parent.height - 4}")
        if(index==1)then
            screen:setPosition(2, 2)
        else
            screen:setPosition("{parent.width * "..(index-1).." + 2}", 2)
        end
    screens[index] = screen
    return screen
end

local function switchScreen(direction)
    local newScreen = currentScreen + direction
    if screens[newScreen] then
        --main:setOffsetX((newScreen - 1) * main:getWidth())
        main:animate():moveOffset((newScreen - 1) * main:getWidth(), 0, 0.5):start()
        currentScreen = newScreen
    end
end

main:addButton()
    :setBackground("{self.clicked and colors.black or colors.white}")
    :setForeground("{self.clicked and colors.white or colors.black}")
    :setSize(8, 1)
    :setText("Next")
    :setPosition("{parent.width - 9}", "{parent.height - 1}")
    :setIgnoreOffset(true)
    :onMouseClick(function() switchScreen(1) end)

main:addButton()
    :setBackground("{self.clicked and colors.black or colors.white}")
    :setForeground("{self.clicked and colors.white or colors.black}")
    :setSize(8, 1)
    :setText("Back")
    :setPosition(2, "{parent.height - 1}")
    :setIgnoreOffset(true)
    :onMouseClick(function() switchScreen(-1) end)

-- Screen 1: Welcome
local welcomeScreen = createScreen(1)
welcomeScreen:addLabel(coloring)
    :setText("Welcome to Basalt!")
    :setPosition(2, 2)

welcomeScreen:addLabel(coloring)
    :setWidth("{parent.width - 2}")
    :setAutoSize(false)
    :setText([[Basalt is an open-source project created with passion for the ComputerCraft community. It provides you with all the tools you need to create beautiful and interactive user interfaces.

The project is actively maintained and continuously improving thanks to our amazing community. Whether you're a beginner or an experienced developer, you'll find Basalt easy to use yet powerful enough for complex applications.

Have ideas or want to get involved? Join our friendly community on Discord or GitHub - we'd love to hear from you and welcome contributions of any kind!

Let's start creating something awesome together!]])
    :setPosition(2, 4)

-- Screen 2: Installation
local installScreen = createScreen(2)
installScreen:addLabel(coloring)
    :setText("Choose Your Installation")
    :setPosition(2, 2)

    installScreen:addLabel(coloring)
    :setText("Select Version:")
    :setPosition(2, 4)

local versionDropdown = installScreen:addDropdown()
    :setPosition("{parent.width - self.width - 1}", 4)
    :setSize(15, 1)
    :setBackground(colors.black)
    :setForeground(colors.white)
    :addItem("Release")
    :addItem("Dev")
    :addItem("Custom")

local versionDesc = installScreen:addLabel("versionDesc")
    :setWidth("{parent.width - 2}")
    :setAutoSize(false)
    :setText("The Release version is the most stable and tested version of Basalt. It is recommended for production use.")
    :setPosition(2, 7)
    :setSize("{parent.width - 4}", 3)
    :setBackground(colors.lightGray)

versionDropdown:onSelect(function(self, index, value)
    if(value == "Release") then
        versionDesc:setText("The Release version is the most stable and tested version of Basalt. It is recommended for production use.")
    elseif(value == "Custom") then
        versionDesc:setText("The Custom version allows you to specify which elements or plugins you want to install.")
    else
        versionDesc:setText("The Dev version is the latest development version of Basalt. It may contain new features and improvements, but it may also have bugs and issues.")
    end
end)

instalScreen:addLabel(coloring)
    :setText("Path:")
    :setPosition(2, "{versionDesc.y + versionDesc.height + 1}")

installScreen:addLabel(coloring)
    :setText("Additional Components:")
    :setPosition(2, "{versionDesc.y + versionDesc.height + 1}")

local luaLSCheckbox = installScreen:addCheckbox()
    :setPosition(2, 12)
    :setText("[ ] LLS definitions")
    :setCheckedText("[x] LLS definitions")
    :setBackground(colors.white)
    :setForeground(colors.black)

-- Screen 3: Elements
local elementsScreen = createScreen(3)
elementsScreen:addLabel(coloring)
    :setText("Elements: (white = selected)")
    :setPosition(2, 2)

local elementsList = elementsScreen:addList("elementsList")
    :setMultiSelection(true)
    :setSelectedBackground(colors.lightGray)
    :setForeground(colors.gray)
    :setPosition(2, 4)
    :setSize("{parent.width - 30}", 8)

local elementDesc = elementsScreen:addLabel("elementDesc")
    :setAutoSize(false)
    :setWidth("{parent.width - (elementsList.x + elementsList.width) - 2}")
    :setText("Select an element to see its description.")
    :setPosition("{elementsList.x + elementsList.width + 1}", 4)
    :setSize(28, 8)
    :setBackground(colors.lightGray)

local eleScreenDesc = elementsScreen:addLabel()
    :setAutoSize(false)
    :setWidth("{parent.width - 2}")
    :setText("This screen allows you to select which elements you want to install. You can select multiple elements.")
    :setPosition(2, "{math.max(elementsList.y + elementsList.height, elementDesc.y + elementDesc.height) + 1}")
    :setBackground(colors.lightGray)

local function addElements()
    elementsList:clear()
    for k,v in pairs(getConfig().categories.elements.files)do
        elementsList:addItem({selected=true, text=v.name, callback=function() elementDesc:setText(v.description) end})
    end
end
addElements()

-- Screen 4 Plugins
local pluginScreen = createScreen(4)
pluginScreen:addLabel(coloring)
    :setText("Plugins: (white = selected)")
    :setPosition(2, 2)

local pluginList = pluginScreen:addList("pluginList")
    :setMultiSelection(true)
    :setSelectedBackground(colors.lightGray)
    :setForeground(colors.gray)
    :setPosition(2, 4)
    :setSize("{parent.width - 30}", 8)

local pluginDesc = pluginScreen:addLabel("pluginDesc")
    :setAutoSize(false)
    :setWidth("{parent.width - (pluginList.x + pluginList.width) - 2}")
    :setText("Select a plugin to see its description.")
    :setPosition("{pluginList.x + pluginList.width + 1}", 4)
    :setSize(28, 8)
    :setBackground(colors.lightGray)

local pluScreenDesc = pluginScreen:addLabel()
    :setAutoSize(false)
    :setWidth("{parent.width - 2}")
    :setText("This screen allows you to select which plugins you want to install. You can select multiple plugins.")
    :setPosition(2, "{math.max(pluginList.y + pluginList.height, pluginDesc.y + pluginDesc.height) + 1}")
    :setBackground(colors.lightGray)

local function addPlugins()
    pluginList:clear()
    for k,v in pairs(getConfig().categories.plugins.files)do
        pluginList:addItem({selected = true, text= v.name, callback=function() pluginDesc:setText(v.description) end})
    end
end
addPlugins()

-- Screen 5 Installation Progress
local progressScreen = createScreen(5)
local progressBar = progressScreen:addProgressBar()
    :setPosition(2, "{parent.height - 2}")
    :setSize("{parent.width - 12}", 2)

local log = progressScreen:addList("log")
    :setPosition(2, 2)
    :setSize("{parent.width - 2}", "{parent.height - 6}")
    :addItem("Starting installation...")

local function install()
    local function logMessage(message)
        log:addItem(message)
    end

    local function downloadFile(url, path)
        logMessage("Downloading " .. url .. "...")
        local request = http.get(url)
        if request then
            local file = fs.open(path, "w")
            file.write(request.readAll())
            file.close()
            request.close()
            logMessage("Downloaded " .. url .. " to " .. path)
        else
            error("Failed to download " .. url)
        end
    end

    local function installElement(name, url)
        logMessage("Installing element: " .. name)
        --downloadFile(url, "/path/to/install/" .. name)
    end

    local function installPlugin(name, url)
        logMessage("Installing plugin: " .. name)
        --downloadFile(url, "/path/to/install/" .. name)
    end

    for _, element in ipairs(elementsList:getSelectedItems()) do
        local item = element.item
        basalt.LOGGER.debug(item.text)
        installElement(item.text, getConfig().categories.elements.files[item.text].url)
    end

    for _, plugin in ipairs(pluginList:getSelectedItems()) do
        local item = plugin.item
        installPlugin(item.text, getConfig().categories.plugins.files[item.text].url)
    end

    progressBar:setProgress(100)
    logMessage("Installation complete!")
end

local installButton = progressScreen:addButton()
    :setText("Install")
    :setPosition("{parent.width - 9}", "{parent.height - 1}")
    :setSize(9, 1)
    :onMouseClick(install)

basalt.run()
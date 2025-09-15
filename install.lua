local basalt
local releasePath = "https://raw.githubusercontent.com/Pyroxenium/Basalt2/refs/heads/main/release/basalt.lua"
local devPath = "https://raw.githubusercontent.com/Pyroxenium/Basalt2/refs/heads/main/src/"
local configPath = "https://raw.githubusercontent.com/Pyroxenium/Basalt2/refs/heads/main/config.lua"
local luaLSPath = "https://raw.githubusercontent.com/Pyroxenium/Basalt2/refs/heads/main/BasaltLS.lua"
local args = {...}

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

if(args[1] == "-h")or(args[1] == "--help")then
    print("Usage: install.lua [options]")
    print("Options:")
    print("  -h, --help        Show this help message")
    print("  -r, --release     Install the release version")
    print("  -d, --dev         Install the dev version")
    return
end

if(args[1] == "-r")or(args[1] == "--release")then
    print("Installing release version...")
    local request = http.get(releasePath)
    if not request then
        error("Failed to download Basalt")
    end
    local file = fs.open(args[2] or "basalt.lua", "w")
    file.write(request.readAll())
    file.close()
    request.close()
    print("Basalt installed successfully!")
    return
end

local function get(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

if(args[1] == "-d")or(args[1] == "--dev")then
    print("Installing dev version...")
    local config = getConfig()
    if not config then
        error("Failed to fetch config")
    end
    local function downloadFile(url, path, name, size, currentFile, totalFiles)
        print("Downloading " .. name..(size > 0 and " (" .. size/1000 .. " kb)" or "") .. " (" .. currentFile .. "/" .. totalFiles .. ")")
        local request = http.get(url)
        if request then
            local file = fs.open(path, "w")
            file.write(request.readAll())
            file.close()
            request.close()
        else
            error("Failed to download " .. name)
        end
    end
    local totalFiles = 0
    for _, category in pairs(config.categories) do
        totalFiles = totalFiles + get(category.files)
    end
    local currentFile = 0
    for categoryName, category in pairs(config.categories) do
        for fileName, fileInfo in pairs(category.files) do
            downloadFile(devPath .. fileInfo.path, fs.combine(args[2] or "basalt", fileInfo.path), fileName, fileInfo.size or 0, currentFile + 1, totalFiles)
            currentFile = currentFile + 1
        end
    end
    print("Dev installation complete!")
    return
end


local basaltRequest = http.get(releasePath)
if not basaltRequest then
    error("Failed to download Basalt")
end
basalt = load(basaltRequest.readAll(), "basalt", "bt", _ENV)()


local coloring = {foreground=colors.black, background=colors.white}
local currentScreen = 1
local screens = {}
local main = basalt.getMainFrame():setBackground(colors.black)
local skipConfig = true

local function getChildrenHeight(container)
    local height = 0
    for _, child in ipairs(container:getChildren()) do
        if(child.get("visible"))then
            local newHeight = child.get("y") + child.get("height")
            if newHeight > height then
                height = newHeight
            end
        end
    end
    return height
end

local function getScreenPosition(index)
    if index <= 2 then 
        return (main:getWidth() * (index - 1)) + 2
    end

    if index == 5 then
        if skipConfig then
            return (main:getWidth() * 2) + 2
        end
        return (main:getWidth() * 4) + 2
    end

    if index == 3 or index == 4 then
        if skipConfig then
            return main:getWidth() * 10
        else
            return (main:getWidth() * (index - 1)) + 2
        end
    end
end

local function createScreen(index)
    local screen = main:addFrame(coloring)
        :onScroll(function(self, direction)
            local height = getChildrenHeight(self)
            local scrollOffset = self:getOffsetY()
            local maxScroll = height - self:getHeight()
            scrollOffset = math.max(0, math.min(maxScroll, scrollOffset + direction))
            self:setOffsetY(scrollOffset)
        end)
        :setSize("{parent.width - 2}", "{parent.height - 4}")

    screen:setPosition(function()
        return getScreenPosition(index)
    end, 2)

    screens[index] = screen
    return screen
end

local backButton
local nextButton

local function switchScreen(direction)
    local newScreen = currentScreen + direction

    if screens[newScreen] then
        if(skipConfig)then
            if(newScreen==4)then
                return
            end
        end
        main:animate():moveOffset((newScreen - 1) * main:getWidth(), 0, 0.5):start()
        currentScreen = newScreen
    end
    basalt.schedule(function()
        sleep(0.1)
        backButton:setVisible(true)
        nextButton:setVisible(true)
        if(newScreen==1)then
            backButton:setVisible(false)
            nextButton:setVisible(true)
        end
        if(newScreen==5)then
            nextButton:setVisible(false)
            backButton:setVisible(true)
        end
        if(skipConfig)then
            if(newScreen==3)then
                nextButton:setVisible(false)
                backButton:setVisible(true)
            end
        end
    end)

end

nextButton = main:addButton()
    :setBackground("{self.clicked and colors.black or colors.white}")
    :setForeground("{self.clicked and colors.white or colors.black}")
    :setSize(8, 1)
    :setText("Next")
    :setPosition("{parent.width - 9}", "{parent.height - 1}")
    :setIgnoreOffset(true)
    :onClick(function() switchScreen(1) end)

backButton = main:addButton()
    :setBackground("{self.clicked and colors.black or colors.white}")
    :setForeground("{self.clicked and colors.white or colors.black}")
    :setSize(8, 1)
    :setText("Back")
    :setPosition(2, "{parent.height - 1}")
    :setIgnoreOffset(true)
    :onClick(function() switchScreen(-1) end)
    :setVisible(false)

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

local versionDropdown = installScreen:addDropDown()
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

installScreen:addLabel(coloring)
    :setText("Path:")
    :setPosition(2, "{versionDesc.y + versionDesc.height + 1}")

local additionalComponents = installScreen:addLabel(coloring)
    :setText("Additional Components:")
    :setPosition(2, "{versionDesc.y + versionDesc.height + 3}")
    :setVisible(false)

local luaLSCheckbox = installScreen:addCheckBox(coloring)
    :setText("[ ] LLS definitions")
    :setCheckedText("[x] LLS definitions")
    :setPosition(2, "{versionDesc.y + versionDesc.height + 4}")
    :setVisible(false)

local luaMinifyCheckbox = installScreen:addCheckBox(coloring)
    :setText("[ ] Minify Project")
    :setCheckedText("[x] Minify Project")
    :setPosition(2, "{versionDesc.y + versionDesc.height + 5}")
    :setVisible(false)

local singleFileProject = installScreen:addCheckBox(coloring)
    :setText("[ ] Single File Project")
    :setCheckedText("[x] Single File Project")
    :setPosition(2, "{versionDesc.y + versionDesc.height + 6}")
    :setVisible(false)

local installPathInput = installScreen:addInput()
    :setPosition(8, "{versionDesc.y + versionDesc.height + 1}")
    :setPlaceholder("basalt")
    :setSize(12, 1)
    :setBackground(colors.black)
    :setForeground(colors.white)

versionDropdown:onSelect(function(self, index, item)
    if(item.text == "Release") then
        versionDesc:setText("The Release version is the most stable and tested version of Basalt. It is recommended for production use.")
        additionalComponents:setVisible(false)
        luaLSCheckbox:setVisible(false)
        luaMinifyCheckbox:setVisible(false)
        singleFileProject:setVisible(false)
    elseif(item.text == "Custom") then
        versionDesc:setText("The Custom version allows you to specify which elements or plugins you want to install.")
        additionalComponents:setVisible(true)
        luaLSCheckbox:setVisible(true)
        luaMinifyCheckbox:setVisible(true)
        singleFileProject:setVisible(true)
    else
        versionDesc:setText("The Dev version is the latest development version of Basalt. It may contain new features and improvements, but it may also have bugs and issues.")
        additionalComponents:setVisible(false)
        luaLSCheckbox:setVisible(false)
        luaMinifyCheckbox:setVisible(false)
        singleFileProject:setVisible(false)
    end

    skipConfig = (item.text ~= "Custom")

    for i, screen in pairs(screens) do
        screen:setPosition(getScreenPosition(i), 2)
    end
end)

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
        elementsList:addItem({selected=v.default, text=k, item=v, callback=function()
            if(v.description)and(v.description~="")then
                elementDesc:setText(v.description)
            else
                elementDesc:setText("No description available.")
            end
        end})
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
        pluginList:addItem({selected = v.default, text=k, item=v, callback=function()
            if(v.description)and(v.description~="")then
                elementDesc:setText(v.description)
            else
                elementDesc:setText("No description available.")
            end
        end})

    end
end
addPlugins()

-- Screen 5 Installation Progress
local progressScreen = createScreen(5)
local installButton
local currentlyInstalling = false
local progressBar = progressScreen:addProgressBar()
    :setPosition(2, "{parent.height - 2}")
    :setSize("{parent.width - 12}", 2)

local log = progressScreen:addList("log")
    :setPosition(2, 2)
    :setSize("{parent.width - 2}", "{parent.height - 6}")
    :addItem("Starting installation...")

local function logMessage(log, message)
    log:addItem(message)
    log:scrollToBottom()
end

local function updateProgress(progressBar, current, total)
    progressBar:setProgress(math.ceil((current / total) * 100))
end

local function installRelease(installPath, log, progressBar)
    logMessage(log, "Installing Release version...")

    local request = http.get(releasePath)
    if not request then
        logMessage(log, "Failed to download release version, aborting installation.")
        return
    end

    local file = fs.open(installPath, "w")
    file.write(request.readAll())
    file.close()
    request.close()

    progressBar:setProgress(100)
    logMessage(log, "Release installation complete!")
end

local function installDev(installPath, log, progressBar)
    logMessage(log, "Installing Dev version...")

    local config = getConfig()
    if not config then
        logMessage(log, "Failed to fetch config")
        return
    end

    local function downloadFile(url, path, name, size)
        logMessage(log, "Downloading " .. name..(size > 0 and " (" .. size/1000 .. " kb)" or ""))
        local request = http.get(url)
        if request then
            local file = fs.open(path, "w")
            file.write(request.readAll())
            file.close()
            request.close()
        else
            error("Failed to download " .. name)
        end
    end

    local totalFiles = 0
    for _, category in pairs(config.categories) do
        totalFiles = totalFiles + #category.files
    end
    local currentFile = 0

    for categoryName, category in pairs(config.categories) do
        for fileName, fileInfo in pairs(category.files) do
            downloadFile(devPath .. fileInfo.path, fs.combine(installPath, fileInfo.path), fileName, fileInfo.size or 0)
            currentFile = currentFile + 1
            updateProgress(progressBar, currentFile, totalFiles)
        end
    end

    logMessage(log, "Dev installation complete!")
end

local function tableGet(t)
    local count = 0
    for _ in pairs(t) do count = count + 1 end
    return count
end

local function installCustom(installPath, log, progressBar, selectedElements, selectedPlugins, includeLuaLS, minify, singleFile)
    logMessage(log, "Installing Custom version...")

    local config = getConfig()
    if not config then
        error("Failed to fetch config")
    end
    local min
    local project = {}

    local function downloadFile(url, name, size)
        logMessage(log, "Downloading " .. name..(size > 0 and " (" .. size/1000 .. " kb)" or ""))
        local request = http.get(url)
        if request then
            local content = request.readAll()
            request.close()
            return content
        else
            error("Failed to download " .. name)
        end
    end

    if(minify)then
        local request = http.get("https://raw.githubusercontent.com/Pyroxenium/Basalt2/refs/heads/main/tools/minify.lua")
        if request then
            min = load(request.readAll())()
            request.close()
        else
            logMessage(log, "Failed to download minify.lua")
            return
        end
    end

    local totalFiles = #selectedElements + #selectedPlugins
    for _, category in pairs({"core", "libraries"}) do
        totalFiles = totalFiles + tableGet(config.categories[category].files)
    end
    local currentFile = 0

    for fileName, fileInfo in pairs(config.categories.core.files) do
        if fileName ~= "LuaLS" or includeLuaLS then
            project[fileInfo.path] = downloadFile(devPath .. fileInfo.path, fileName, fileInfo.size or 0)
            currentFile = currentFile + 1
            updateProgress(progressBar, currentFile, totalFiles)
        end
    end

    for fileName, fileInfo in pairs(config.categories.libraries.files) do
        project[fileInfo.path] = downloadFile(devPath .. fileInfo.path, fileName, fileInfo.size or 0)
        currentFile = currentFile + 1
        updateProgress(progressBar, currentFile, totalFiles)
    end

    for _, element in ipairs(selectedElements) do
        local fileInfo = config.categories.elements.files[element.text]
        basalt.LOGGER.debug(element.text)
        project[fileInfo.path] = downloadFile(devPath .. fileInfo.path, element.text, fileInfo.size or 0)
        currentFile = currentFile + 1
        updateProgress(progressBar, currentFile, totalFiles)
    end

    for _, plugin in ipairs(selectedPlugins) do
        local fileInfo = config.categories.plugins.files[plugin.text]
        project[fileInfo.path] = downloadFile(devPath .. fileInfo.path, plugin.text, fileInfo.size or 0)
        currentFile = currentFile + 1
        updateProgress(progressBar, currentFile, totalFiles)
    end

    if minify then
        logMessage(log, "Minifying project...")
        for path, content in pairs(project) do
            local success, minifiedContent = min(content)
            if(success)then
                project[path] = minifiedContent
            else
                logMessage(log, "Failed to minify " .. path)
                return
            end
        end
    end

    if(singleFile)then
        installPath = installPath:gsub(".lua", "")..".lua"
        local output = {
            'local minified = true\n',
            'local minified_elementDirectory = {}\n',
            'local minified_pluginDirectory = {}\n',
            'local project = {}\n',
            'local loadedProject = {}\n',
            'local baseRequire = require\n',
            'require = function(path) if(project[path..".lua"])then if(loadedProject[path]==nil)then loadedProject[path] = project[path..".lua"]() end return loadedProject[path] end baseRequire(path) end\n'
        }

        for filePath, content in pairs(project) do
            local elementName = filePath:match("^elements/(.+)%.lua$")
            if elementName then
                table.insert(output, string.format(
                    'minified_elementDirectory["%s"] = {}\n',
                    elementName
                ))
            end

            local pluginName = filePath:match("^plugins/(.+)%.lua$")
            if pluginName then
                table.insert(output, string.format(
                    'minified_pluginDirectory["%s"] = {}\n',
                    pluginName
                ))
            end
        end

        for filePath, content in pairs(project) do
            table.insert(output, string.format(
                'project["%s"] = function(...) %s end\n',
                filePath, content
            ))
        end
        table.insert(output, 'return project["main.lua"]()')
        local out = fs.open(installPath, "w")
        if(out)then
            out.write(table.concat(output))
            out.close()
            if(includeLuaLS)then
                local luaLS = downloadFile(luaLSPath, "LuaLS", 0)
                local luaLSDir = fs.getDir(installPath)
                local file = fs.open("BasaltLS.lua", "w")
                file.write(luaLS)
                file.close()
            end
        else
            logMessage(log, "Failed to write to " .. installPath)
            return
        end
    else
        for filePath, content in pairs(project) do
            local out = fs.open(fs.combine(installPath, filePath), "w")
            if(out)then
                out.write(content)
                out.close()
            else
                logMessage(log, "Failed to write to " .. fs.combine(installPath, filePath))
                return
            end
        end
        if(includeLuaLS)then
            local luaLS = downloadFile(luaLSPath, "LuaLS", 0)
            local file = fs.open("BasaltLS.lua", "w")
            file.write(luaLS)
            file.close()
        end
    end

    logMessage(log, "Custom installation complete!")
end

local function installBasalt()
    currentlyInstalling = true
    installButton:setVisible(false)
    local selection = versionDropdown:getSelectedItems()[1]
    if(selection==nil)then
        selection = "Release"
    else
        selection = selection.text
    end
    local path = installPathInput:getText()
    if(path=="")then
        path = "basalt"
    else
        path = path:gsub(".lua", "")
    end
    if(selection == "Release")then
        installRelease(path..".lua", log, progressBar)
    elseif(selection == "Dev")then
        installDev(path, log, progressBar)
    else
        installCustom(path, log, progressBar, elementsList:getSelectedItems(), pluginList:getSelectedItems(), luaLSCheckbox:getChecked(), luaMinifyCheckbox:getChecked(), singleFileProject:getChecked())
    end
    currentlyInstalling = false
    installButton:setVisible(true)
end

installButton = progressScreen:addButton()
    :setBackground("{self.clicked and colors.lightGray or colors.black}")
    :setForeground("{self.clicked and colors.black or colors.lightGray}")
    :setText("Install")
    :setPosition("{parent.width - 9}", "{parent.height - 3}")
    :setSize(9, 1)
    :onClick(function(self)
        if(currentlyInstalling)then
            return
        end
        basalt.schedule(installBasalt)
    end)

local closeButton = progressScreen:addButton()
    :setBackground("{self.clicked and colors.lightGray or colors.black}")
    :setForeground("{self.clicked and colors.black or colors.lightGray}")
    :setText("Close")
    :setPosition("{parent.width - 9}", "{parent.height - 1}")
    :setSize(9, 1)
    :onClick(function(self)
        basalt.stop()
    end)

basalt.run()
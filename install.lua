-- BASALT INSTALLER
local githubPath = "https://raw.githubusercontent.com/Pyroxenium/Basalt/basalt2/"
local minifyURL = "https://raw.githubusercontent.com/Pyroxenium/basalt-docs/main/minify.lua"
local bundleURL = "https://raw.githubusercontent.com/Pyroxenium/basalt-docs/main/bundle.lua"

local installer = {}
local args = {...}
local config
local loggingList
local noLogging = false
local packager

function installer.getConfig(key)
    if(config~=nil)then
        return config[key]
    end
    local file = http.get("https://raw.githubusercontent.com/Pyroxenium/basalt-docs/main/config.json")
    if(file == nil) then
        error("Failed to download the Basalt config file")
    end
    config = textutils.unserializeJSON(file.readAll())
    return config[key]
end

function installer.getPackager()
    if(packager~=nil)then
        return packager
    end
    packager = load(http.get(packagerURL).readAll())()
    return packager
end

local function log(msg)
    --require("basalt").log(msg)
    if not(noLogging)then
        if(loggingList~=nil)then
            loggingList:addItem(msg)
        else
            print(msg)
        end
    end
end

local function downloadFile(path, url, desc)
    local file = http.get(url)   
    if(file == nil) then
        log("Failed to download: "..(desc or url))
    else
        local f = fs.open(path, "w")
        f.write(file.readAll())
        f.close()
        log("Successfully downloaded: "..(desc or url))
    end
end


local minScript
local function minify(folder)
    if(minScript==nil)then
        minScript = load(http.get(minifyURL).readAll())()
    end
    local files = fs.list(folder)
    for _,file in pairs(files)do
        if(not fs.isDir(fs.combine(folder, file)))then
            if(file:sub(-4)==".lua")then
                local f = fs.open(fs.combine(folder, file), "r")
                local data = f.readAll()
                f.close()
                local success, minified = minScript(data)
                if(success)then
                    f = fs.open(fs.combine(folder, file), "w")
                    f.write(minified:gsub("\t", " "):gsub("\n", " "))
                    f.close()
                    log("Successfully minified: "..file)
                else
                    log("Failed to minify: "..file)
                end
            end
        else
            minify(fs.combine(folder, file))
        end
    end
end

function installer.minifyProject(path)
    log("Minifying project...")
    minify(path)
    log("Minifying complete!")
end

function installer.bundleProject(path)
    log("Bundling project...")
    local bundle = load(http.get(bundleURL).readAll())()
    bundle(path, "main", "basalt.lua", false)
    log("Bundling complete!")
end

function installer.createDirectories()
    local path = installer.getConfig("defaultSettings").path.default
    log("Basalt path will be: "..path)
    log("Creating Basalt directories")
    fs.delete(path)
    fs.makeDir(path)
    fs.makeDir(fs.combine(path, "extensions"))
    fs.makeDir(fs.combine(path, "elements"))
    fs.makeDir(fs.combine(path, "libraries"))
end

function installer.createSettings()
    log("Storing Basalt settings")
    for k,v in pairs(installer.getConfig("defaultSettings"))do
        settings.define(k, v)
    end
end

function installer.downloadCoreFiles(packaged)
    local path = installer.getConfig("defaultSettings").path.default
    log("---Core files:---")
    for k,_ in pairs(installer.getConfig("versions"))do
        if(k~="elements" and k~="extensions" and k~="libraries")then
            if(packaged)then
                downloadFileMinified(fs.combine(path, k..".lua"), githubPath.."Basalt/"..k..".lua", k)
            else
                downloadFile(fs.combine(path, k..".lua"), githubPath.."Basalt/"..k..".lua", k)
            end
        end
    end
end

function installer.downloadElementFiles(packaged, elements)
    local path = installer.getConfig("defaultSettings").path.default
    log("---Element files:---")
    for _,v in pairs(elements)do
        if(packaged)then
            downloadFileMinified(fs.combine(path, "elements", v..".lua"), githubPath.."Basalt/elements/"..v..".lua", v)
        else
            downloadFile(fs.combine(path, "elements", v..".lua"), githubPath.."Basalt/elements/"..v..".lua", v)
        end
    end
end

function installer.downloadExtensionFiles(packaged, extensions)
    local path = installer.getConfig("defaultSettings").path.default
    log("---Extension files:---")
    for _,v in pairs(extensions)do
        if(packaged)then
            downloadFileMinified(fs.combine(path, "extensions", v..".lua"), githubPath.."Basalt/extensions/"..v..".lua", v)
        else
            downloadFile(fs.combine(path, "extensions", v..".lua"), githubPath.."Basalt/extensions/"..v..".lua", v)
        end
    end
end

function installer.downloadLibraryFiles(packaged)
    local path = installer.getConfig("defaultSettings").path.default
    log("---Library files:---")
    local libraries = installer.getConfig("versions").libraries
    for k,v in pairs(libraries)do
        if(packaged)then
            downloadFileMinified(fs.combine(path, "libraries", k..".lua"), githubPath.."Basalt/libraries/"..k..".lua", k)
        else
            downloadFile(fs.combine(path, "libraries", k..".lua"), githubPath.."Basalt/libraries/"..k..".lua", k)
        end
    end
end

function installer.install(elements, extensions)
    log("Downloading Basalt...")
    installer.createDirectories()
    installer.createSettings()
    installer.downloadCoreFiles()
    installer.downloadElementFiles(false, elements)
    installer.downloadExtensionFiles(false, extensions)
    installer.downloadLibraryFiles()
    log("Download complete!")
end

local function Button(frame, x, y, w, h, bg, fg, text, onClick, clickedBg, clickedFg)
    local button = frame:addButton():setPosition(x, y):setSize(w, h):setText(text):setBackground("{self.clicked ? "..(clickedBg or "black").." : "..(bg or "black").."}"):setForeground("{self.clicked ? "..(clickedFg or "white").." : "..(fg or "white").."}"):onClickUp(onClick)
    return button
end

local function Label(frame, x, y, text, bg, fg)
    local label = frame:addLabel():setPosition(x, y):setText(text):setBackground(bg or frame:getBackground()):setForeground(fg or frame:getForeground())
    return label
end

local function List(frame, x, y, w, h, bg, fg, items, onChange, selBg, selFg)
    local list = frame:addList():setPosition(x, y):setSize(w, h):setBackground(bg):setForeground(fg):setItems(items):onChange(onChange):setSelectionBackground(selBg or fg):setSelectionForeground(selFg or bg)
    return list
end

local function ScrollFrame(frame, x, y, w, h, bg, fg)
    local frame = frame:addScrollableFrame():setPosition(x, y):setSize(w, h):setBackground(bg):setForeground(fg)
    return frame
end

local function Input(frame, x, y, w, h, bg, fg, text, defaultText)
    local input = frame:addInput():setPosition(x, y):setSize(w, h):setValue(text):setBackground(bg):setForeground(fg):setPlaceholderBackground(bg)
    if(defaultText~=nil)then
        input:setPlaceholderText(defaultText)
    end
    return input
end

local function Checkbox(frame, x, y, bg, fg, checked)
    local checkbox = frame:addCheckbox():setPosition(x, y):setChecked(checked):setBackground(bg):setForeground(fg)
    return checkbox
end

local function checkForDefault(file, typ)
    for k,v in pairs(installer.getConfig("default")[typ])do
        if(file==v)then
            return true
        end
    end
    return false
end

local hintFrames = {}
local hintLabels = {}
local function drawHint(frame, text)
    if(hintFrames[frame]==nil)then
        hintFrames[frame] = frame:addScrollableFrame():setPosition(5, 6):setSize("{parent.w - 8}", "{parent.h - 12}"):setVisible(false):setBackground(colors.white):setForeground(colors.black):setBorder(true):setBorderColor(colors.black)
        hintFrames[frame]:onClick(function(self)
            self:setVisible(false)
        end)
        hintLabels[frame] = hintFrames[frame]:addLabel():setPosition(1, 1):setSize("{parent.w}", "{parent.h}"):setWrap(true):setBackground(colors.white):setForeground(colors.black)
    end
    hintFrames[frame]:setYOffset(0)
    hintLabels[frame]:setText(text)
    hintFrames[frame]:setVisible(true)
end

function installer.gui()
    local basalt
    if(fs.exists("basalt.lua"))then
        basalt = require("Basalt")
    else
        basalt = load(http.get("https://raw.githubusercontent.com/Pyroxenium/basalt-docs/main/getBasalt.lua").readAll(), nil, "t", _ENV)()
    end
    basalt.requiredElement("button", "list", "frame", "input", "label", "scrollableFrame", "checkbox")
    basalt.requiredExtension("dynamicValues", "templates", "animations", "borders")
    local main = basalt.getMainFrame():setBackground(colors.black):setForeground(colors.white)
    local installDescFrame = basalt.addFrame():setBackground(colors.black):setForeground(colors.white)
    local settingsFrame = basalt.addFrame():setBackground(colors.black):setForeground(colors.white)
    local installFrame1 = basalt.addFrame():setBackground(colors.black):setForeground(colors.white)
    local installFrame2 = basalt.addFrame():setBackground(colors.black):setForeground(colors.white)
    local loggingFrame = basalt.addFrame():setBackground(colors.black):setForeground(colors.white)
    local doneBtn, backBtn

    local elements = installer.getConfig("versions").elements
    local extensions = installer.getConfig("versions").extensions

    -- Install Description Frame ---------------------------------------

    local textFrame = ScrollFrame(installDescFrame, 3, 3, "{parent.w - 4}", "{parent.h - 6}", colors.white, colors.white):setBorder(true):setBorderColor(colors.gray)
    textFrame:addLabel():setWrap(true):setSize("{parent.w}", "{parent.h}"):setBackground(colors.white):setForeground(colors.black)
    :setText([[
Installation

We will install the latest version of basalt on your computer. Please make sure that in case you have a modified version of basalt, you back it up before installing the new version.

You can choose the files you want to install. Don't worry you can add files later on as well.

Press "Next" to continue.
]])

    Button(installDescFrame, 2, "{parent.h - self.h + 1}", 10, 1, colors.white, colors.black, "Back", function()
        basalt.switchFrame(main)
    end)

    Button(installDescFrame, "{parent.w - self.w}", "{parent.h - self.h + 1}", 10, 1, colors.white, colors.black, "Next", function()
        basalt.switchFrame(settingsFrame)
    end)

    -- Settings Frame ---------------------------------------------------
    local settings = ScrollFrame(settingsFrame, 3, 3, "{parent.w - 4}", "{parent.h - 6}", colors.white, colors.black):setBorder(true):setBorderColor(colors.gray)

    Label(settings, 2, 2, "Settings: (click for information)"):onClick(function(self, button)
        drawHint(settingsFrame, "These are the settings for Basalt. These settings will be stored with CC:Tweaked's settings API. You can change these settings later on as well.")
    end)

    Label(settings, 2, 4, "Path:"):onClick(function(self, button)
        drawHint(settingsFrame, "The path where Basalt will be installed. Default is 'basalt'.")
    end)

    Label(settings, 2, 6, "Cache:"):onClick(function(self, button)
        drawHint(settingsFrame, "Caches the Basalt API globally. Restarting your program won't download data from Github, which aren't stored on your computer. Only affects basalt.required(file) files.")
    end)

    Label(settings, 2, 8, "Auto Update:"):onClick(function(self, button)
        drawHint(settingsFrame, "This will automatically update basalt whenever you start your program (and load basalt into your program). Doesn't work with the bundled installation.")
    end)

    Label(settings, 2, 10, "Minify"):onClick(function(self, button)
        drawHint(settingsFrame, "This will minify all the files to reduce the file size. But it will make the files harder to read. Also unexpected errors will be harder to understand.")
    end)

    Label(settings, 2, 12, "Bundle"):onClick(function(self, button)
        drawHint(settingsFrame, "This will bundle all the files into one file. Making it easier to use Basalt on your computer. The bundled version is meant to be used for production. If you're developing a program, you should not use the bundled version.")
    end)

    Label(settings, 2, 14, "Annotations"):onClick(function(self, button)
        drawHint(settingsFrame, "This will download the annotations file. It will make the developement with basalt easier, as you can see the documentation of the functions in your editor. Doesn't work with the bundled installation.")
    end)

    local path = Input(settings, 15, 4, "{parent.w - 21}", 1, "{self.focused ? black : lightGray}", "{self.focused ? white : black}", installer.getConfig("defaultSettings").path.default)

    local cache = Checkbox(settings, "{parent.w - 7}", 6, colors.lightGray, colors.black, false)

    local autoUpdate = Checkbox(settings, "{parent.w - 7}", 8, colors.lightGray, colors.black, false):setEnabled(false)

    local minify = Checkbox(settings, "{parent.w - 7}", 10, colors.lightGray, colors.black, false)

    local bundle = Checkbox(settings, "{parent.w - 7}", 12, colors.lightGray, colors.black, false)

    local annotations = Checkbox(settings, "{parent.w - 7}", 14, colors.lightGray, colors.black, false)

    Button(settingsFrame, 2, "{parent.h - self.h + 1}", 10, 1, colors.white, colors.black, "Back", function()
        basalt.switchFrame(installDescFrame)
    end)

    Button(settingsFrame, "{parent.w - self.w}", "{parent.h - self.h + 1}", 10, 1, colors.white, colors.black, "Next", function()
        basalt.switchFrame(installFrame1)
        if(config~=nil)then
            config.defaultSettings.path.default = path:getValue()
            config.defaultSettings.cacheGlobally.default = cache:getChecked()
            config.defaultSettings.autoUpdate.default = autoUpdate:getChecked()
        end
    end)

    -- Install Frame ---------------------------------------------------
    Label(installFrame1, 2, 2, "Select the elements you want to install:"):onClick(function(self, button)
        drawHint(installFrame1, "Elements are the core files of Basalt. You can choose which elements you want to install. Don't worry, you can add elements later on as well. Right click on an element to get more information about it.")
    end)

    Button(installFrame1, 2, "{parent.h - self.h + 1}", 10, 1, colors.white, colors.black, "Back", function()
        basalt.switchFrame(settingsFrame)
    end)

    Button(installFrame1, "{parent.w - self.w}", "{parent.h - self.h + 1}", 10, 1, colors.white, colors.black, "Next", function()
        basalt.switchFrame(installFrame2)
    end)

    local eleList = List(installFrame1, 3, 5, "{parent.w - 4}", "{parent.h - 7}", colors.white, colors.lightGray, {}, function()
    end, colors.white, colors.black):setBorder(true):setBorderColor(colors.gray):setMultiSelection(true):onClick(function(self, btn, x, y)
        if(btn==2)then
            local item = self:getItems()[y + self:getScrollIndex()-1]
            if(item~=nil)then
                if(elements[item]~=nil)then
                    if(elements[item][3]~=nil)then
                        drawHint(installFrame1, elements[item][3])
                    end
                end
            end
        end
    end)

    for k,v in pairs(elements)do
        eleList:addItem(k)
        if(checkForDefault(k, "elements"))then
            eleList:selectItem(k)
        end
    end
    --------------------------------------------------------------------

    -- Install Frame 2 -------------------------------------------------
    Label(installFrame2, 2, 2, "Select the extensions you want to install:"):onClick(function(self, button)
        drawHint(installFrame2, "Extensions are additional features for Basalt. You can choose which extensions you want to install. Don't worry, you can add extensions later on as well. Right click on an extension to get more information about it.")
    end)

    Button(installFrame2, 2, "{parent.h - self.h + 1}", 10, 1, colors.white, colors.black, "Back", function()
        basalt.switchFrame(installFrame1)
    end)

    local extList = List(installFrame2, 3, 5, "{parent.w - 4}", "{parent.h - 7}", colors.white, colors.lightGray, {}, function()

    end, colors.white, colors.black):setBorder(true):setBorderColor(colors.gray):setMultiSelection(true):onClick(function(self, btn, x, y)
        if(btn==2)then
            local item = self:getItems()[y + self:getScrollIndex()-1]
            if(item~=nil)then
                if(extensions[item]~=nil)then
                    if(extensions[item][3]~=nil)then
                        drawHint(installFrame2, extensions[item][3])
                    end
                end
            end
        end
    end)


    for k,_ in pairs(extensions)do
        extList:addItem(k)
        if(checkForDefault(k, "extensions"))then
            extList:selectItem(k)
        end
    end

    Button(installFrame2, "{parent.w - self.w}", "{parent.h - self.h + 1}", 10, 1, colors.white, colors.black, "Install", function()
        loggingList:clear()
        basalt.switchFrame(loggingFrame)
        basalt.thread(function()
            installer.install(eleList:getSelectedItems(), extList:getSelectedItems())
            local projPath = path:getValue()
            if(minify:getChecked())then
                installer.minifyProject(projPath)
            end
            if(bundle:getChecked())then
                installer.bundleProject(projPath)
                fs.delete(projPath)
            end

            if(annotations:getChecked())and not(bundle:getChecked())then
                downloadFile(fs.combine(projPath, "annotations.lua"), "https://raw.githubusercontent.com/Pyroxenium/basalt-docs/main/bundle.lua", "Annotations")
            end

            backBtn:setVisible(false)
            doneBtn:setVisible(true)
        end)
    end)

    --------------------------------------------------------------------

    -- Logging Frame ---------------------------------------------------
    backBtn = Button(loggingFrame, 2, "{parent.h - self.h + 1}", 10, 1, colors.white, colors.black, "Back", function()
        basalt.switchFrame(installFrame2)
    end)

    doneBtn = Button(loggingFrame, "{parent.w - self.w}", "{parent.h - self.h + 1}", 10, 1, colors.white, colors.black, "Done", function()
        basalt.stop()
    end):setVisible(false)

    loggingList = List(loggingFrame, 3, 3, "{parent.w - 4}", "{parent.h - 6}", colors.white, colors.black, {}, function()

    end):setSelection(false):setBorder(true):setBorderColor(colors.gray):setAutoScroll(true)
    --------------------------------------------------------------------

    -- Main Frame ------------------------------------------------------    
    local introFrame = ScrollFrame(main, 3, 3, "{parent.w - 4}", "{parent.h - 6}", colors.white, colors.white):setBorder(true):setBorderColor(colors.gray)
    introFrame:addLabel():setWrap(true):setSize("{parent.w}", "{parent.h}"):setBackground(colors.white):setForeground(colors.black)
    :setText([[
Welcome to Basalt!

Thanks for using Basalt! Before we install the project, i'd like to say that Basalt is just a hobby project, made by one person. This means that there might be bugs, and the documentation might not be perfect. If you find any bugs, please report them on the Github page. If you have any questions, feel free to ask them on the Github page or in discord. You can also do a pull request if you want to contribute to the project.

Also, i'm working on the project in my free time, so updates might not be as frequent as you'd like. I'm doing my best to keep the project up to date and add new features, but it might take some time.
]])
    Button(main, "{parent.w - self.w}", "{parent.h}", 11, 1, "white", "black", "Install", function()
        basalt.switchFrame(installDescFrame)
    end)

    Button(main, 2, "{parent.h}", 6, 1, "white", "black", "Exit", function()
        basalt.stop()
    end)
    --------------------------------------------------------------------
    basalt.autoUpdate()
end

if(args[1]=="source")then
    installer.install()
    if(args[2]=="true")then
        installer.minifyProject(installer.getConfig("defaultSettings").path.default)
    end
elseif(args[1]=="bundled")then
    installer.install()
    if(args[2]=="true")then
        installer.minifyProject(installer.getConfig("defaultSettings").path.default)
    end
    installer.bundleProject(installer.getConfig("defaultSettings").path.default)
elseif(args[1]=="minify")then
    installer.minifyProject(args[2])
elseif(args[1]=="bundle")then
    installer.bundleProject(args[2] or "basalt")
else
    installer.gui()
end
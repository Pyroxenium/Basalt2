-- Basalt 2.5 showcase

local arguments = { ... }
local automatic, capture = false, false
for _, argument in ipairs(arguments) do
    if argument == "--auto" then automatic = true end
    if argument == "--capture" then capture = true end
end

local function loadLocalBasalt()
    local running = shell and shell.getRunningProgram()
        or "Basalt2.5/examples/showcase.lua"
    local project = fs.getDir(fs.getDir(running))
    local initPath = fs.combine(project, "src/init.lua")
    local chunk, loadError = loadfile(initPath, nil, _ENV)
    if not chunk then error(loadError, 0) end
    return chunk("basalt", initPath)
end

local basalt = loadLocalBasalt()
local theme = basalt.use("theme")
local palette = theme.applyPreset("basalt")
basalt.use("animation")
basalt.use("bigfont")
basalt.use("charts")

local main = basalt.getMainFrame()
local width, height = main:getSize()

local function captureFrame()
    if not capture or type(term.screenshot) ~= "function" then return end
    basalt.update()
    pcall(term.screenshot)
end

-- The layout is designed for CraftOS-PC's default 51x19 terminal.
if width < 51 or height < 19 then
    error("The Basalt showcase requires a terminal of at least 51x19", 0)
end

local function frame(parent, properties)
    return parent:addFrame(properties)
end

local function label(parent, properties)
    return parent:addLabel(properties)
end

local function fill(parent, x, y, w, h, color)
    return frame(parent, {
        x = x,
        y = y,
        width = w,
        height = h,
        background = color,
    })
end

local splash = fill(main, 1, 1, width, height, palette.bg)
local splashLogo = splash:addBigFont({
    x = 1,
    y = 4,
    text = "Basalt",
    fontSize = 2,
    foreground = palette.lava,
    background = palette.bg,
})
if splashLogo.width > width then splashLogo.fontSize = 1 end
splashLogo.x = math.floor((width - splashLogo.width) / 2) + 1
label(splash, {
    x = 7,
    y = 9,
    text = "A modern UI framework for CC:Tweaked",
    foreground = palette.text,
})
label(splash, {
    x = 14,
    y = 11,
    text = "Reactive. Flexible. Fast.",
    foreground = palette.muted,
})

local splashProgress = splash:addProgressBar({
    x = 9,
    y = 15,
    width = 34,
    height = 1,
    progress = 0,
    background = palette.border,
    barColor = palette.lava,
})
local startButton = splash:addButton({
    x = 18,
    y = 17,
    width = 16,
    height = 1,
    text = "Start showcase",
    foreground = palette.bg,
    background = palette.lava,
})

local app = fill(main, 1, 1, width, height, palette.bg)
app.visible = false

local header = fill(app, 1, 1, width, 3, palette.surface)
label(header, {
    x = 2,
    y = 2,
    text = "BASALT 2.5",
    foreground = palette.lava,
})
label(header, {
    x = width - 13,
    y = 2,
    text = "CC:TWEAKED UI",
    foreground = palette.muted,
})

local sidebar = fill(app, 1, 4, 13, height - 3, palette.surface)
label(sidebar, {
    x = 2,
    y = 2,
    text = "SHOWCASE",
    foreground = palette.muted,
})

local navigation = {}
local navigationLabels = {
    "Overview",
    "Components",
    "Charts",
    "Controls",
    "Developer",
}
for index, text in ipairs(navigationLabels) do
    local item = fill(sidebar, 1, 2 + index * 2, 13, 2, palette.surface)
    fill(item, 1, 1, 1, 2, palette.surface)
    label(item, {
        x = 3,
        y = 1,
        text = text,
        foreground = palette.muted,
    })
    navigation[index] = item
end
label(sidebar, {
    x = 2,
    y = height - 4,
    text = "docs / 2.5",
    foreground = palette.muted,
})

local content = fill(app, 14, 4, width - 13, height - 3, palette.bg)
local pages = {}

local function makePage()
    local page = fill(content, 1, 1, content.width, content.height, palette.bg)
    page.visible = false
    pages[#pages + 1] = page
    return page
end

local function showPage(index)
    for pageIndex, page in ipairs(pages) do
        page.visible = pageIndex == index
    end
    for itemIndex, item in ipairs(navigation) do
        local active = itemIndex == index
        item.background = active and palette.raised or palette.surface
        item:getChildren()[1].background = active and palette.lava
        item:getChildren()[2].foreground =
            active and palette.text or palette.muted
    end
end

-- Page 1: a polished application rather than an isolated widget gallery.
local overview = makePage()
label(overview, {
    x = 2,
    y = 2,
    text = "Live dashboard",
    foreground = palette.text,
})
label(overview, {
    x = 2,
    y = 3,
    text = "A full app in a few lines of Lua.",
    foreground = palette.muted,
})

local function metricCard(x, title, value, accent)
    local card = fill(overview, x, 5, 11, 5, palette.surface)
    label(card, {
        x = 2,
        y = 2,
        text = title,
        foreground = palette.muted,
    })
    local valueLabel = label(card, {
        x = 2,
        y = 4,
        text = value,
        foreground = accent,
    })
    return valueLabel
end

local powerValue = metricCard(2, "POWER", "12.8 kRF", palette.lava)
local jobsValue = metricCard(14, "JOBS", "24 active", palette.info)
local uptimeValue = metricCard(26, "UPTIME", "99.9%", palette.success)

label(overview, {
    x = 2,
    y = 11,
    text = "Factory output",
    foreground = palette.muted,
})
local outputProgress = overview:addProgressBar({
    x = 2,
    y = 12,
    width = 34,
    height = 1,
    progress = 18,
    showPercentage = true,
    background = palette.border,
    barColor = palette.lava,
})
local autoLabel = label(overview, {
    x = 2,
    y = 14,
    text = "Automation",
    foreground = palette.text,
})
local autoSwitch = overview:addSwitch({
    x = 14,
    y = 14,
    width = 5,
    checked = false,
})
local dashboardStatus = label(overview, {
    x = 22,
    y = 14,
    text = "Warming up...",
    foreground = palette.warning,
})

-- Page 2: dense enough to show breadth, but still looks like a real app.
local components = makePage()
label(components, {
    x = 2,
    y = 2,
    text = "Rich components",
    foreground = palette.text,
})
label(components, {
    x = 2,
    y = 3,
    text = "Mouse, keyboard and reactive updates included.",
    foreground = palette.muted,
})

local componentList = components:addList({
    x = 2,
    y = 5,
    width = 13,
    height = 8,
    items = {
        "Dashboard",
        "Inventory",
        "Machines",
        "Network",
        "Settings",
    },
    background = palette.surface,
})
componentList:selectItem(1, false)

local componentTable = components:addTable({
    x = 16,
    y = 5,
    width = 20,
    height = 8,
    columns = {
        { title = "Machine", width = 12 },
        { title = "Load" },
    },
    data = {
        { "Crusher", "72%" },
        { "Smelter", "48%" },
        { "Reactor", "91%" },
        { "Storage", "36%" },
    },
    background = palette.surface,
    gridColor = palette.border,
})

local componentCheck = components:addCheckbox({
    x = 2,
    y = 14,
    text = "Auto craft",
    checked = false,
})
label(components, {
    x = 17,
    y = 14,
    text = "Priority",
    foreground = palette.muted,
})
local componentSlider = components:addSlider({
    x = 26,
    y = 14,
    width = 10,
    min = 0,
    max = 100,
    value = 20,
})

-- Page 3: charts use the same component model as every other element.
local chartsPage = makePage()
label(chartsPage, {
    x = 2,
    y = 2,
    text = "Live data visualization",
    foreground = palette.text,
})
label(chartsPage, {
    x = 2,
    y = 3,
    text = "Smooth subpixel graphs and bar charts.",
    foreground = palette.muted,
})

local graphCard = fill(chartsPage, 2, 5, 22, 9, palette.surface)
label(graphCard, {
    x = 2,
    y = 1,
    text = "SYSTEM LOAD",
    foreground = palette.muted,
})
local liveGraph = graphCard:addPixelGraph({
    x = 2,
    y = 2,
    width = 19,
    height = 6,
    minValue = 0,
    maxValue = 100,
    background = palette.surface,
})
liveGraph:addSeries("cpu", { color = palette.lava })
liveGraph:addSeries("network", { color = palette.info })

local barsCard = fill(chartsPage, 25, 5, 11, 9, palette.surface)
label(barsCard, {
    x = 2,
    y = 1,
    text = "OUTPUT",
    foreground = palette.muted,
})
local outputBars = barsCard:addBarChart({
    x = 2,
    y = 2,
    width = 8,
    height = 6,
    data = { 24, 58, 36, 81 },
    minValue = 0,
    maxValue = 100,
    barColor = palette.success,
    background = palette.surface,
})

fill(chartsPage, 2, 15, 1, 1, palette.lava)
label(chartsPage, {
    x = 4,
    y = 15,
    text = "CPU",
    foreground = palette.muted,
})
fill(chartsPage, 10, 15, 1, 1, palette.info)
label(chartsPage, {
    x = 12,
    y = 15,
    text = "NETWORK",
    foreground = palette.muted,
})
local chartStatus = label(chartsPage, {
    x = 25,
    y = 15,
    text = "LIVE",
    foreground = palette.success,
})

local cpuSeed = {
    28, 34, 31, 46, 52, 49, 61, 57, 72, 68, 75, 63,
    58, 66, 71, 79, 74, 82, 69, 64, 73, 77, 70, 76,
}
local networkSeed = {
    18, 22, 35, 27, 41, 38, 44, 33, 29, 48, 52, 46,
    55, 43, 37, 50, 59, 54, 62, 57, 49, 53, 65, 60,
}
for index = 1, #cpuSeed do
    liveGraph:addPoint("cpu", cpuSeed[index])
    liveGraph:addPoint("network", networkSeed[index])
end

-- Page 4: navigation, forms, trees, editors, dialogs and notifications.
local controls = makePage()
label(controls, {
    x = 2,
    y = 2,
    text = "Navigation and controls",
    foreground = palette.text,
})
label(controls, {
    x = 2,
    y = 3,
    text = "Forms, tabs, trees, editors and more.",
    foreground = palette.muted,
})

local controlTabs = controls:addTabControl({
    x = 2,
    y = 5,
    width = 34,
    height = 10,
    background = palette.surface,
})

local formTab = controlTabs:addTab("Form")
label(formTab, {
    x = 2,
    y = 2,
    text = "Project",
    foreground = palette.muted,
})
local projectInput = formTab:addInput({
    x = 11,
    y = 2,
    width = 18,
    placeholder = "Project name",
})
label(formTab, {
    x = 2,
    y = 4,
    text = "Theme",
    foreground = palette.muted,
})
local themeDropdown = formTab:addDropdown({
    x = 11,
    y = 4,
    width = 18,
    text = "Choose...",
    dropHeight = 3,
    items = { "Basalt", "Obsidian", "Ember" },
})
formTab:addButton({
    x = 11,
    y = 7,
    width = 12,
    height = 1,
    text = "Create app",
    foreground = palette.bg,
    background = palette.lava,
})

local treeTab = controlTabs:addTab("Tree")
local treeNodes = {
    {
        text = "src",
        expanded = true,
        children = {
            {
                text = "elements",
                children = {
                    { text = "Button.lua" },
                    { text = "Table.lua" },
                },
            },
            { text = "modules" },
            { text = "main.lua" },
        },
    },
    { text = "themes" },
    { text = "README.md" },
}
local projectTree = treeTab:addTree({
    x = 2,
    y = 2,
    width = 29,
    height = 7,
    nodes = treeNodes,
    background = palette.surface,
})

local textTab = controlTabs:addTab("Editor")
local codeEditor = textTab:addTextBox({
    x = 2,
    y = 2,
    width = 29,
    height = 7,
    text = table.concat({
        "local basalt = require(\"basalt\")",
        "",
        "local app = basalt.getMainFrame()",
        "app:addButton({ text = \"Launch\" })",
        "",
        "basalt.run()",
    }, "\n"),
    background = palette.surface,
})

local controlToast = controls:addToast({
    duration = 0,
    maxWidth = 20,
    toastColors = {
        default = { bg = palette.raised, fg = palette.text },
        success = { bg = palette.success, fg = palette.bg },
        info = { bg = palette.info, fg = palette.bg },
    },
})
local controlDialog = controls:addDialog({
    titleBackground = palette.lava,
    titleForeground = palette.bg,
    boxBackground = palette.raised,
    boxForeground = palette.text,
    boxWidth = 26,
})

-- Page 5: communicate why 2.5 is pleasant to develop with.
local developer = makePage()
label(developer, {
    x = 2,
    y = 2,
    text = "Built for developers",
    foreground = palette.text,
})
label(developer, {
    x = 2,
    y = 3,
    text = "Modern tools, still just Lua.",
    foreground = palette.muted,
})

local codeCard = fill(developer, 2, 5, 21, 9, palette.surface)
local codeLines = {
    label(codeCard, {
        x = 2, y = 2, text = "local count =",
        foreground = palette.info,
    }),
    label(codeCard, {
        x = 4, y = 4, text = "basalt.state(0)",
        foreground = palette.lava,
    }),
    label(codeCard, {
        x = 2, y = 6, text = "label.text = count",
        foreground = palette.success,
    }),
    label(codeCard, {
        x = 2, y = 8, text = "-- updates automatically",
        foreground = palette.muted,
    }),
}
for _, codeLine in ipairs(codeLines) do codeLine.visible = false end

local featureCards = {}
local featureData = {
    { "Reactive state", palette.lava },
    { "LuaLS types", palette.info },
    { "XML layouts", palette.success },
    { "Themes", palette.warning },
}
for index, feature in ipairs(featureData) do
    local card = fill(developer, 39, 4 + index * 3, 13, 2, palette.raised)
    fill(card, 1, 1, 1, 2, feature[2])
    label(card, {
        x = 3,
        y = 1,
        text = feature[1],
        foreground = palette.text,
    })
    featureCards[index] = card
end

local finale = fill(main, 1, 1, width, height, palette.bg)
finale.visible = false
local finaleLogo = finale:addBigFont({
    x = 1,
    y = 4,
    text = "Basalt",
    fontSize = 2,
    foreground = palette.lava,
    background = palette.bg,
})
if finaleLogo.width > width then finaleLogo.fontSize = 1 end
finaleLogo.x = math.floor((width - finaleLogo.width) / 2) + 1
label(finale, {
    x = 18,
    y = 9,
    text = "Version 2.5",
    foreground = palette.text,
})
label(finale, {
    x = 12,
    y = 12,
    text = "Build something brilliant.",
    foreground = palette.muted,
})
local docsBadge = fill(finale, 12, 15, 28, 2, palette.raised)
label(docsBadge, {
    x = 3,
    y = 1,
    text = "basalt.madefor.cc/2.5",
    foreground = palette.lava,
})

local running = false
local function runShowcase()
    if running then return end
    running = true
    startButton.disabled = true
    startButton.text = "Loading..."

    splashProgress:animate({ progress = 100 }, 1.5, "easeOut")
    sleep(1.8)

    splash.visible = false
    app.visible = true
    showPage(1)
    captureFrame()

    outputProgress:animate({ progress = 86 }, 2.2, "easeInOut")
    sleep(0.6)
    powerValue.text = "18.4 kRF"
    jobsValue.text = "31 active"
    sleep(0.6)
    autoSwitch.checked = true
    dashboardStatus.text = "Running"
    dashboardStatus.foreground = palette.success
    uptimeValue.text = "100.0%"
    sleep(1.8)

    showPage(2)
    captureFrame()
    sleep(0.5)
    componentList:selectItem(2, false)
    componentTable:select(3, false)
    componentSlider:animate({ value = 72 }, 1.2, "easeOut")
    sleep(0.7)
    componentList:selectItem(3, false)
    componentCheck.checked = true
    sleep(0.6)
    componentTable:sortBy(1, true)
    componentList:selectItem(4, false)
    sleep(1.2)

    showPage(3)
    captureFrame()
    chartStatus.text = "STREAMING"
    for step = 1, 26 do
        local cpu = 57
            + math.floor(math.sin(step * 0.62) * 19)
            + math.floor(math.sin(step * 0.17) * 7)
        local network = 48
            + math.floor(math.sin(step * 0.43 + 1.2) * 17)
            + math.floor(math.sin(step * 0.13) * 9)
        liveGraph:addPoint("cpu", cpu)
        liveGraph:addPoint("network", network)
        if step % 4 == 0 then
            outputBars.data = {
                30 + step,
                48 + (step * 3) % 43,
                38 + (step * 5) % 51,
                62 + (step * 2) % 35,
            }
        end
        sleep(0.16)
    end
    chartStatus.text = "UPDATED"
    chartStatus.foreground = palette.info
    sleep(0.9)

    showPage(4)
    captureFrame()
    local projectName = "Basalt OS"
    for index = 1, #projectName do
        projectInput.text = projectName:sub(1, index)
        sleep(0.14)
    end
    themeDropdown.open = true
    sleep(0.8)
    themeDropdown:select(1, false)
    controlToast:info("Form validated", 0)
    sleep(0.8)
    controlToast:hide()

    controlTabs:setActiveTab(2, false)
    sleep(0.7)
    projectTree:select(treeNodes[1].children[1], false)
    sleep(0.7)
    projectTree:expandNode(treeNodes[1].children[1])
    projectTree:select(treeNodes[1].children[1].children[1], false)
    sleep(1.0)

    controlTabs:setActiveTab(3, false)
    sleep(0.8)
    codeEditor:selectAll()
    sleep(0.8)
    controlDialog:alert("Ready", "Your Basalt app is ready to launch.")
    sleep(1.2)
    controlDialog:close(true)
    controlToast:success("Project created!", 0)
    sleep(1.0)
    controlToast:hide()

    showPage(5)
    captureFrame()
    for index, codeLine in ipairs(codeLines) do
        codeLine.visible = true
        featureCards[index]:animate({ x = 24 }, 0.4, "easeOut")
        sleep(0.55)
    end
    sleep(1.4)

    app.visible = false
    finale.visible = true
    captureFrame()

    if automatic then
        sleep(0.8)
        basalt.stop()
    end
end

startButton:onClick(function()
    basalt.schedule(runShowcase)
end)

if automatic then
    basalt.schedule(function()
        sleep(0.2)
        runShowcase()
    end)
end

basalt.run()

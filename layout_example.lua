local basalt = require("init")
basalt.use("responsive")

local frame = basalt.createFrame()
frame.background = basalt.rgb("#1e1e2e")

local page = frame:addColumn({
    x = 1, y = 1,
    width = basalt.fill(),
    height = basalt.fill(),
    padding = 1,
    gap = 1,
})

page:addLabel({
    text = "Responsive Basalt3 Layout",
    width = basalt.auto(),
    foreground = basalt.rgb("#89b4fa"),
})

local form = page:addRow({
    width = basalt.fill(),
    height = basalt.auto(),
    gap = 1,
    align = "center",
})

form:setResponsive({
    {
        name = "compact",
        maxWidth = 30,
        props = { direction = "column", align = "stretch" },
    },
    {
        name = "wide",
        minWidth = 31,
        props = { direction = "row", align = "center" },
    },
})

form:addLabel({ text = "Name:", width = basalt.auto() })
local input = form:addInput({ width = basalt.fill(), placeholder = "Your name" })
form:addButton({ text = "Save", width = basalt.auto() })
    :setStateStyle("hover", { background = basalt.rgb("#6c7086") })
    :onClick(function()
        page:addLabel({
            text = "Saved: " .. input.text,
            width = basalt.auto(),
            foreground = colors.lime,
        })
    end)

page:addProgressBar({
    width = basalt.percent(0.5),
    progress = 65,
    barColor = basalt.rgb("#a6e3a1"),
})

page:addButton({
    text = "Exit",
    width = basalt.auto(),
    alignSelf = "end",
    background = basalt.rgb("#f38ba8"),
}):onClick(function() basalt.stop() end)

basalt.run()

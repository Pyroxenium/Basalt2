local basalt = require("init")

local frame = basalt.createFrame()
frame:setBackground(basalt.rgb("FF1A833D"))

frame:addLabel({ x = 2, y = 2, text = "Basalt3 Demo", foreground = basalt.rgb("FFA269E4") })

local count = 0
local counter = frame:addLabel({ x = 2, y = 10, text = "Clicks: 0" })
counter:setStateStyle("hover", { foreground = basalt.rgb("FF82F3ED") })

local btn = frame:addButton({ x = 2, y = 6, text = "Click me" })
    :setBackground(basalt.rgb("FF1A1A8A"))
    :onClick(function()
        count = count + 1
        counter.text = "Clicks: " .. count
    end)

btn:setStateStyle("hover", {
    background = basalt.rgb("FF2727CA"),
})

frame:addButton({
    x = 14, y = 6, text = "Exit",
    background = basalt.rgb("FF810F2F"),
    foreground = basalt.rgb("FF2E2E3B"),
}):onClick(function()
    basalt.stop()
end):setStateStyle("hover", {
    background = basalt.rgb("FFB4161B"),
})

basalt.run()

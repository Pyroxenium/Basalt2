local basalt = require("init")

local frame = basalt.createFrame()
frame.background = basalt.rgb("#1e1e2e")

local accent = basalt.rgb("#89b4fa")
local surface = basalt.rgb("#313244")
local hover = basalt.rgb("#45475a")
local text = basalt.rgb("#cdd6f4")

local header = frame:addRow({
    x = 2, y = 2,
    width = basalt.fill(),
    height = basalt.auto(),
    gap = 1,
    align = "center",
})

header:addLabel({
    text = "Scrollable Container",
    width = basalt.fill(),
    foreground = accent,
})

local content = frame:addColumn({
    x = 2, y = 5,
    width = basalt.fill(),
    height = function(self)
        return self.parent.height - 4
    end,
    gap = 0,
    background = surface,
    scrollable = true,
    scrollbar = "auto",
    scrollXEnabled = false,
    scrollYEnabled = true,
    scrollStep = 2,
    scrollbarColor = basalt.rgb("#585b70"),
    scrollbarThumbColor = accent,
})

local status = frame:addLabel({
    x = 2, y = 4,
    width = basalt.fill(),
    text = "Mouse wheel or drag the scrollbar",
    foreground = text,
})

local toggle = header:addButton({
    text = "Scroll: ON",
    width = basalt.auto(),
    height = 1,
    background = surface,
    foreground = text,
})

toggle:setStateStyle("hover", { background = hover })
toggle:onClick(function(self)
    content.scrollable = not content.scrollable
    self.text = content.scrollable and "Scroll: ON" or "Scroll: OFF"
    status.text = content.scrollable
        and "Scrolling enabled"
        or "Scrolling disabled (offset reset)"
end)

header:addButton({
    text = "Exit",
    width = basalt.auto(),
    height = 1,
    background = basalt.rgb("#f38ba8"),
    foreground = basalt.rgb("#11111b"),
}):onClick(function()
    basalt.stop()
end)

for i = 1, 5000 do
    local itemNumber = i
    content:addButton({
        text = ("Item %02d"):format(i),
        width = basalt.fill(),
        height = 1,
        background = i % 2 == 0 and surface or basalt.rgb("#3b3d52"),
        foreground = text,
    })
        :setStateStyle("hover", { background = hover })
        :onClick(function(_, _, x, y)
            status.text = "Selected Item " .. itemNumber
                .. " (local " .. x .. "," .. y .. ")"
            content:ensureVisible(content:getChildren()[itemNumber])
        end)
end

basalt.run()

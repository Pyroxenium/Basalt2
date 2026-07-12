local basalt = require("init")

local frame = basalt.createFrame()
frame:setBackground(basalt.rgb("#1e1e2e"))

local accent = basalt.rgb("#89b4fa")
frame:addLabel({ x = 2, y = 1, text = "Basalt3 Gallery", foreground = accent })

-- checkbox + switch
frame:addCheckbox({ x = 2, y = 3, text = "Checkbox" })
frame:addLabel({ x = 2, y = 5, text = "Switch:" })
frame:addSwitch({ x = 10, y = 5 })

-- slider drives the progress bar via a reactive expression
frame:addLabel({ x = 2, y = 7, text = "Slider + ProgressBar:" })
frame:addSlider({ x = 2, y = 8, width = 12, name = "sl", value = 30 })
frame:addProgressBar({
    x = 2, y = 9, width = 12,
    progress = "{sl.value}",
    barColor = accent,
})

-- input
frame:addInput({ x = 2, y = 11, width = 12, placeholder = "Type here..." })

-- list with selection label
local list = frame:addList({ x = 16, y = 3, width = 12, height = 5 })
for _, v in ipairs({ "Apfel", "Birne", "Kirsche", "Traube", "Zitrone", "Mango" }) do
    list:addItem(v)
end
local picked = frame:addLabel({ x = 16, y = 9, text = "-" })
list:onSelect(function(_, _, item) picked.text = "> " .. item end)

-- dropdown
local dd = frame:addDropdown({ x = 16, y = 11, width = 12, text = "Sprache..." })
dd:addItem("Deutsch"):addItem("English"):addItem("Espanol")

-- animated button
local anim = basalt.use("animation")
local btn = frame:addButton({
    x = 31, y = 3, width = 14, height = 3, text = "Animate!",
    background = accent, foreground = basalt.rgb("#11111b"),
})
btn:onClick(function(self)
    local target = self.y == 3 and 8 or 3
    self:animate({ y = target }, 0.4, "easeInOut")
end)

frame:addButton({
    x = 31, y = 15, width = 14, height = 3, text = "Exit",
    background = basalt.rgb("#f38ba8"), foreground = basalt.rgb("#11111b"),
}):onClick(function() basalt.stop() end)

-- debug overlay: press F12 and click around
basalt.use("debug")
basalt.debug("Gallery started - F12 toggles this overlay")

basalt.run()

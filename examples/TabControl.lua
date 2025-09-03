local basalt = require("basalt")

local frame = basalt.getMainFrame()

local tabs = frame:addTabControl({x = 2,
y = 2,
width = 35,
height = 12,
headerBackground = colors.black,
foreground = colors.lightGray
})


-- create three tabs; addTab now returns a proxy for adding elements into the new tab
local overview = tabs:newTab("Overview")
local editor = tabs:newTab("Editor")
local settings = tabs:newTab("Settings")

-- Overview tab: add a label and a button
overview:addLabel({x = 2, y = 2, width = 46}):setText("Welcome to the demo")
overview:addButton({x = 2, y = 4, width = 12, height = 3}):setText("Click me")
:setBackground("{self.clicked and colors.green or colors.black}")
:setForeground("{self.clicked and colors.black or colors.lightGray}")

-- Editor tab: textbox with some sample text
editor:addTextBox({x = 2, y = 2, width = 12, height = 8, background=colors.black, foreground=colors.white}):setText("Type here...\nLine 2\nLine 3")

-- Settings tab: show some inputs
settings:addLabel({x = 2, y = 2, width = 20}):setText("Settings")
settings:addLabel({x = 2, y = 4, width = 20}):setText("Username:")
settings:addLabel({x = 2, y = 6, width = 20}):setText("Password:")
settings:addInput({x = 12, y = 4, width = 20, background=colors.black, foreground=colors.white})
settings:addInput({x = 12, y = 6, width = 20, background=colors.black, foreground=colors.white})

basalt.run()
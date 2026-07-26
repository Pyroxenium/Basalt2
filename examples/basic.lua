-- Basalt starter example
--
-- Install Basalt as basalt.lua next to this program, then run the file.
-- Use this as a starting point and change the layout, colors and events.

local basalt = require("basalt")

-- The built-in theme is optional, but gives every element a consistent look.
local palette = basalt.use("theme").applyPreset("basalt")

local main = basalt.getMainFrame()
local width, height = main:getSize()

local panelWidth = math.min(42, width - 4)
local panelHeight = math.min(13, height - 2)
local panel = main:addFrame({
    x = math.floor((width - panelWidth) / 2) + 1,
    y = math.floor((height - panelHeight) / 2) + 1,
    width = panelWidth,
    height = panelHeight,
    background = palette.surface,
})

panel:addLabel({
    x = 2,
    y = 2,
    text = "My first Basalt app",
    foreground = palette.lava,
})

panel:addLabel({
    x = 2,
    y = 4,
    width = panelWidth - 4,
    height = 2,
    text = "Enter your name and press the button.",
    foreground = palette.muted,
})

panel:addLabel({
    x = 2,
    y = 7,
    text = "Name:",
})

local nameInput = panel:addInput({
    x = 9,
    y = 7,
    width = panelWidth - 11,
    placeholder = "Steve",
})

local status = panel:addLabel({
    x = 2,
    y = 9,
    width = panelWidth - 4,
    text = "Waiting for input...",
    foreground = palette.muted,
})

local function greet()
    local name = nameInput.text:match("^%s*(.-)%s*$")
    if name == "" then
        status.text = "Please enter your name."
        status.foreground = palette.warning
        return
    end

    -- Properties can be changed directly. Basalt redraws the UI for us.
    status.text = "Hello, " .. name .. "!"
    status.foreground = palette.success
end

panel:addButton({
    x = 2,
    y = 11,
    width = 12,
    height = 1,
    text = "Say hello",
    foreground = palette.bg,
    background = palette.lava,
}):onClick(greet)

panel:addButton({
    x = panelWidth - 9,
    y = 11,
    width = 8,
    height = 1,
    text = "Exit",
}):onClick(function()
    basalt.stop()
end)

-- Pressing Enter in the input performs the same action as the button.
nameInput:onEnter(greet)
nameInput:focus()

-- Start Basalt's event loop. This call blocks until basalt.stop() is called.
basalt.run()

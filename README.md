# Basalt 2.5

A modern, lightweight UI framework for CC: Tweaked — a rewrite
of Basalt2.

## Usage

```lua
local basalt = require("Basalt")

local frame = basalt.createFrame()
frame:setBackground(basalt.rgb("#1e1e2e")) -- any RGB color!

-- plain properties and chaining are both supported
local label = frame:addLabel({ x = 2, y = 2, text = "Hello" })
label.text = "Hello World"

frame:addButton({ x = 2, y = 4, text = "Click me" })
    :onClick(function(self)
        self.text = "Thanks!"
    end)

basalt.run()
```

More information soon...
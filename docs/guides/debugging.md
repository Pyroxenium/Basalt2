# Debugging

Basalt provides a built-in logging system to help you track and debug your applications.

## Logging System

### Enabling Logging

```lua
local basalt = require("basalt")

-- Enable logging
basalt.LOGGER.setEnabled(true)

-- Optional: Log to file
basalt.LOGGER.setLogToFile(true)  -- Creates basalt.log
```

### Log Levels

```lua
basalt.LOGGER.debug("Detailed debugging information")
basalt.LOGGER.info("General information")
basalt.LOGGER.warn("Warning message")
basalt.LOGGER.error("Error message")
```

### Example

```lua
local basalt = require("basalt")
basalt.LOGGER.setEnabled(true)
basalt.LOGGER.setLogToFile(true)

local main = basalt.getMainFrame()

local button = main:addButton()
    :setText("Click Me")
    :setPosition(2, 2)
    :onClick(function(self)
        basalt.LOGGER.debug("Button clicked")
        
        local data = loadData()
        basalt.LOGGER.info("Loaded " .. #data .. " items")
        
        local success = processData(data)
        if not success then
            basalt.LOGGER.error("Failed to process data")
        end
    end)

basalt.run()
```

## Debug Console

If you have the debug plugin, you can open a visual console that displays log messages in real-time:

```lua
local basalt = require("basalt")
basalt.LOGGER.setEnabled(true)

local main = basalt.getMainFrame()

-- Open debug console
main:openConsole()

basalt.LOGGER.info("Console is now open!")
basalt.run()
```

The console shows all log messages with color-coded levels and is scrollable.

### Debug Element Issues

```lua
local element = frame:addButton()
    :setText("Test")
    :setPosition(10, 5)

local x, y = element:getPosition()
local w, h = element:getSize()
basalt.LOGGER.debug("Element at " .. x .. ", " .. y .. " size " .. w .. "x" .. h)
basalt.LOGGER.debug("Visible: " .. tostring(element:getVisible()))
```

### Error Handling

```lua
local function safeOperation()
    local success, result = pcall(function()
        return riskyFunction()
    end)
    
    if not success then
        basalt.LOGGER.error("Operation failed: " .. tostring(result))
        return nil
    end
    
    basalt.LOGGER.info("Operation successful")
    return result
end
```

### Component-Based Logging

```lua
local function createLogger(component)
    return {
        debug = function(msg) basalt.LOGGER.debug("[" .. component .. "] " .. msg) end,
        info = function(msg) basalt.LOGGER.info("[" .. component .. "] " .. msg) end,
        warn = function(msg) basalt.LOGGER.warn("[" .. component .. "] " .. msg) end,
        error = function(msg) basalt.LOGGER.error("[" .. component .. "] " .. msg) end,
    }
end

local dbLogger = createLogger("Database")
local uiLogger = createLogger("UI")

dbLogger.info("Connection established")
uiLogger.debug("Button created")
```
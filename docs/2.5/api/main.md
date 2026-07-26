# main

## Methods

### basalt.use(moduleName)

Loads an optional module from modules/ (e.g. "debug", "animation",
"theme", "xml") and returns its API. Modules extend Basalt from the
outside; the core has no knowledge of them.

- **moduleName** (`string`) The module name

- **returns** **api** (`table`) The module's API table

```lua
local theme = basalt.use("theme")
```

### basalt.createFrame(t, monitorName)

Creates a root frame bound to a terminal (default: current term).
For monitors, pass the wrapped peripheral; touch events are routed
automatically. monitorName only needs to be given if auto-detection fails.

- **t** (`table|nil`) The terminal to bind to (default: current term)
- **monitorName** (`string|nil`) The name of the monitor peripheral (optional)

### basalt.getMainFrame()

Returns (or lazily creates) the main frame.
Returns the first frame created by basalt.createFrame().

- **returns** **frame** (`BaseFrame|nil`) 

### basalt.schedule(fn)

Runs a function in a coroutine driven by the event loop; blocking calls
like sleep() are allowed inside.

- **fn** (`function`) The function to run

- **returns** **co** (`thread`) The coroutine handle

```lua
basalt.schedule(function() sleep(1) label.text = "later" end)
```

### basalt.update(event, ...)

Feeds a single event through Basalt manually (alternative to run()).

- **event** (`string`) The event name (e.g. "mouse_click", "key", "term_resize")
- **...** (`any`) Additional event arguments

### basalt.stop()

Stops the event loop.
Stops the active basalt.run() event loop after the current event.

### basalt.run()

Starts the event loop; returns when basalt.stop() is called or on error
(after showing the error screen).
Runs the blocking event loop until stop() or terminate.

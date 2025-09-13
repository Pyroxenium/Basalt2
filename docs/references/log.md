# Log
_Logger module for Basalt. Logs messages to the console and optionally to a file._

## Functions

|Method|Returns|Description|
|---|---|---|
|[Log.setLogToFile](#log-setlogtofile)|-|Sets if the logger should log to a file|
|[Log.setEnabled](#log-setenabled)|-|Sets if the logger should log|
|[Log.debug](#log-debug)|-|Sends a debug message|
|[Log.info](#log-info)|-|Sends an info message|
|[Log.warn](#log-warn)|-|Sends a warning message|
|[Log.error](#log-error)|-|Sends an error message|

## Log.setLogToFile()

Sets if the logger should log to a file.

## Log.setEnabled()

Sets if the logger should log

## Log.debug()

Sends a debug message to the logger.

### Usage
```lua
Log.debug("This is a debug message")
```

## Log.info()

Sends an info message to the logger.

### Usage
```lua
Log.info("This is an info message")
```

## Log.warn()

Sends a warning message to the logger.

### Usage
```lua
Log.warn("This is a warning message")
```

## Log.error()

Sends an error message to the logger.

### Usage
```lua
Log.error("This is an error message")
```

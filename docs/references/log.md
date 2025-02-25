# Log
Logger module for Basalt. Logs messages to the console and optionally to a file.

## Fields

|Field|Type|Description|
|---|---|---|
|_logs|`table`|The complete log history|
|_enabled|`boolean`|If the logger is enabled|
|_logToFile|`boolean`|If the logger should log to a file|
|_logFile|`string`|The file to log to|
|LEVEL|`table`|The log levels|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Log.debug](#Log.debug)|-|Sends a debug message
|[Log.error](#Log.error)|-|Sends an error message
|[Log.info](#Log.info)|-|Sends an info message
|[Log.setEnabled](#Log.setEnabled)|-|Sets if the logger should log
|[Log.setLogToFile](#Log.setLogToFile)|-|Sets if the logger should log to a file
|[Log.warn](#Log.warn)|-|Sends a warning message


## Log.debug(...)
Sends a debug message to the logger.

### Parameters
* `...` *(vararg)* `string` The message to log

### Usage
 ```lua
Log.debug("This is a debug message")
```

## Log.error(...)
Sends an error message to the logger.

### Parameters
* `...` *(vararg)* `string` The message to log

### Usage
 ```lua
Log.error("This is an error message")
```

## Log.info(...)
Sends an info message to the logger.

### Parameters
* `...` *(vararg)* `string` The message to log

### Usage
 ```lua
Log.info("This is an info message")
```

## Log.setEnabled()
Sets if the logger should log

## Log.setLogToFile()
Sets if the logger should log to a file.

## Log.warn(...)
Sends a warning message to the logger.

### Parameters
* `...` *(vararg)* `string` The message to log

### Usage
 ```lua
Log.warn("This is a warning message")
```



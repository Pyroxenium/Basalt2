# ErrorHandler
This is Basalt's error handler. All the errors are handled by this module.

## Fields

|Field|Type|Description|
|---|---|---|
|tracebackEnabled|`boolean`|If the error handler should print a stack trace|
|header|`string`|The header of the error message|

## Functions

|Method|Returns|Description|
|---|---|---|
|[errorHandler.error](#errorhandler-error)|-|


## errorHandler.error(errMsg)
Handles an error

### Parameters
* `errMsg` `string` The error message

### Usage
 ```lua
errorHandler.error("An error occurred")
```



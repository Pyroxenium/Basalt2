# BaseElement
_No Description_

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement.debug](#baseelement-debug-self-level)|-|Enables debugging for this element|
|[BaseElement.dumpDebug](#baseelement-dumpdebug-self)|-|Dumps debug information|

## BaseElement.debug(self, level)

Enables debugging for this element

### Parameters
* `self` `BaseElement` The element to debug
* `level` `number` The debug level

## BaseElement.dumpDebug(self)

Dumps debug information for this element

### Parameters
* `self` `BaseElement` The element to dump debug info for

# BaseFrame

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseFrame.openConsole](#baseframe-openconsole-self)|-|Shows the debug log frame|
|[BaseFrame.closeConsole](#baseframe-closeconsole-self)|-|Hides the debug log frame|
|[BaseFrame.toggleConsole](#baseframe-toggleconsole-self)|-|Toggles the debug log frame|

## BaseFrame.openConsole(self)

Shows the debug log frame

### Parameters
* `self` `BaseFrame` The frame to show debug log in

## BaseFrame.closeConsole(self)

Hides the debug log frame

### Parameters
* `self` `BaseFrame` The frame to hide debug log for

## BaseFrame.toggleConsole(self)

Toggles the debug log frame

### Parameters
* `self` `BaseFrame` The frame to toggle debug log for

# Container

## Functions

|Method|Returns|Description|
|---|---|---|
|[Container.debugChildren](#container-debugchildren-self-level)|-|Debug container and children|

## Container.debugChildren(self, level)

Enables debugging for this container and all its children

### Parameters
* `self` `Container` The container to debug
* `level` `number` The debug level

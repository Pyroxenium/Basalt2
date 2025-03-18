# BaseElement : PropertySystem
The base class for all UI elements in Basalt. This class provides basic properties and event handling functionality.

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|type|string|BaseElement|The type identifier of the element
|id|string|BaseElement|The unique identifier for the element
|name|string|BaseElement|The name of the element
|eventCallbacks|table|BaseElement|The event callbacks for the element

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement.defineEvent](#baseelement-defineevent)|-|Registers a new event listener for the element (on class level)
|[BaseElement.registerEventCallback](#baseelement-registereventcallback)|-|Registers a new event callback for the element (on class level)
|[BaseElement:destroy](#baseelement-destroy)|-|Destroys the element and cleans up all references
|[BaseElement:fireEvent](#baseelement-fireevent)|table|Triggers an event and calls all registered callbacks
|[BaseElement:getBaseFrame](#baseelement-getbaseframe)|BaseFrame|Returns the base frame of the element
|[BaseElement:isType](#baseelement-istype)|boolean|Checks if the element is a specific type
|[BaseElement:listenEvent](#baseelement-listenevent)|table|Enables or disables event listening for a specific event
|[BaseElement:onChange](#baseelement-onchange)|table|Observes a property and calls a callback when it changes
|[BaseElement:registerCallback](#baseelement-registercallback)|table|Registers a callback function
|[BaseElement:updateRender](#baseelement-updaterender)|table|Requests a render update for this element


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|BaseElement:dispatchEvent|boolean?|Handles all events
|BaseElement:handleEvent|boolean?|The default event handler for all events
|BaseElement:init|table|Initializes the BaseElement instance
|BaseElement:postInit|table|Post initialization

## BaseElement.defineEvent(class, eventName, requiredEvent?)
Registers a new event listener for the element (on class level)

### Parameters
* `class` `table` The class to register
* `eventName` `string` The name of the event to register
* `requiredEvent` *(optional)* `string` The name of the required event (optional)

## BaseElement.registerEventCallback(class, callbackName, ...)
Registers a new event callback for the element (on class level)

### Parameters
* `class` `table` The class to register
* `callbackName` `string` The name of the callback to register
* `...` `string` The names of the events to register the callback for

## BaseElement:destroy()
Destroys the element and cleans up all references

## BaseElement:fireEvent(event, ...)
Triggers an event and calls all registered callbacks

### Parameters
* `event` `string` The event to fire
* `...` `any` Additional arguments to pass to the callbacks

### Returns
* `table` `self` The BaseElement instance

## BaseElement:getBaseFrame()
Returns the base frame of the element

### Returns
* `BaseFrame` `BaseFrame` The base frame of the element

## BaseElement:isType(type)
Checks if the element is a specific type

### Parameters
* `type` `string` The type to check for

### Returns
* `boolean` `isType` Whether the element is of the specified type

## BaseElement:listenEvent(eventName, enable?)
Enables or disables event listening for a specific event

### Parameters
* `eventName` `string` The name of the event to listen for
* `enable` *(optional)* `boolean` Whether to enable or disable the event (default: true)

### Returns
* `table` `self` The BaseElement instance

## BaseElement:onChange(property, callback)
Observes a property and calls a callback when it changes

### Parameters
* `property` `string` The property to observe
* `callback` `function` The callback to call when the property changes

### Returns
* `table` `self` The BaseElement instance

## BaseElement:registerCallback(event, callback)
Registers a callback function for an event

### Parameters
* `event` `string` The event to register the callback for
* `callback` `function` The callback function to register

### Returns
* `table` `self` The BaseElement instance

## BaseElement:updateRender()
Requests a render update for this element

### Returns
* `table` `self` The BaseElement instance



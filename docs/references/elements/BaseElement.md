# BaseElement
_The fundamental base class for all UI elements in Basalt. It implements core functionality like event handling, property management, lifecycle hooks, and the observer pattern. Every UI component inherits from this class to ensure consistent behavior and interface._

Extends: `PropertySystem`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|type|string|BaseElement|A hierarchical identifier of the element's type chain|
|id|string|BaseElement|Auto-generated unique identifier for element lookup|
|name|string|BaseElement|User-defined name for the element|
|eventCallbacks|table|BaseElement|Collection of registered event handler functions|
|enabled|boolean|BaseElement|Controls event processing for this element|

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement.defineEvent](#baseelement-defineevent-class-eventname-requiredevent)|-|Registers a new event listener for the element (on class level)|
|[BaseElement.registerEventCallback](#baseelement-registereventcallback-class-callbackname-string)|-|Registers a new event callback method with auto-registration|
|[BaseElement:isType](#baseelement-istype-type)|boolean|Tests if element is of or inherits given type|
|[BaseElement:listenEvent](#baseelement-listenevent-eventname-enable)|table|Enables/disables event handling for this element|
|[BaseElement:registerCallback](#baseelement-registercallback-event-callback)|table|Registers a function to handle specific events|
|[BaseElement:fireEvent](#baseelement-fireevent-event-any)|table|Triggers event callbacks with provided arguments|
|[BaseElement:onChange](#baseelement-onchange-property-callback)|table|Watches property changes with callback notification|
|[BaseElement:getBaseFrame](#baseelement-getbaseframe)|BaseFrame|Retrieves the root frame of this element's tree|
|[BaseElement:destroy](#baseelement-destroy)|-|Removes element and performs cleanup|
|[BaseElement:updateRender](#baseelement-updaterender)|table|Requests UI update for this element|

## BaseElement.defineEvent(class, eventName, requiredEvent?)

Registers a class-level event listener with optional dependency

### Parameters
* `class` `table` The class to register
* `eventName` `string` The name of the event to register
* `requiredEvent` *(optional)* `string` The name of the required event (optional)

## BaseElement.registerEventCallback(class, callbackName, string)

Defines a class-level event callback method with automatic event registration

### Parameters
* `class` `table` The class to register
* `callbackName` `string` The name of the callback to register
* `string` `The` names of the events to register the callback for

## BaseElement:isType(type)

Checks if the element matches or inherits from the specified type

### Parameters
* `type` `string` The type to check for

### Returns
* `boolean` `isType` Whether the element is of the specified type

## BaseElement:listenEvent(eventName, enable?)

Configures event listening behavior with automatic parent notification

### Parameters
* `eventName` `string` The name of the event to listen for
* `enable` *(optional)* `boolean` Whether to enable or disable the event (default: true)

### Returns
* `table` `self` The BaseElement instance

## BaseElement:registerCallback(event, callback)

Adds an event handler function with automatic event registration

### Parameters
* `event` `string` The event to register the callback for
* `callback` `function` The callback function to register

### Returns
* `table` `self` The BaseElement instance

## BaseElement:fireEvent(event, any)

Executes all registered callbacks for the specified event

### Parameters
* `event` `string` The event to fire
* `any` `Additional` arguments to pass to the callbacks

### Returns
* `table` `self` The BaseElement instance

## BaseElement:onChange(property, callback)

Sets up a property change observer with immediate callback registration

### Parameters
* `property` `string` The property to observe
* `callback` `function` The callback to call when the property changes

### Returns
* `table` `self` The BaseElement instance

## BaseElement:getBaseFrame()

Traverses parent chain to locate the root frame element

### Returns
* `BaseFrame` `BaseFrame` The base frame of the element

## BaseElement:destroy()

Removes the element from UI tree and cleans up resources

## BaseElement:updateRender()

Propagates render request up the element tree

### Returns
* `table` `self` The BaseElement instance

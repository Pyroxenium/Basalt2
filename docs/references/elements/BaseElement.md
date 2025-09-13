# BaseElement
_The base class for all UI elements in Basalt. This class provides basic properties and event handling functionality._

Extends: `PropertySystem`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|type|string|BaseElement|The type identifier of the element|
|id|string|BaseElement|The unique identifier for the element|
|name|string|BaseElement|The name of the element|
|eventCallbacks|table|BaseElement|The event callbacks for the element|
|enabled|boolean|BaseElement|Whether the element is enabled or not|

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement.defineEvent](#baseelement-defineevent-class-eventname-requiredevent)|-|Registers a new event listener for the element (on class level)|
|[BaseElement.registerEventCallback](#baseelement-registereventcallback-class-callbackname-string)|-|Registers a new event callback for the element (on class level)|
|[BaseElement.new](#baseelement-new)|table|Creates a new BaseElement instance|
|[BaseElement:BaseElement](#baseelement-baseelement-props-basalt)|table|Initializes the BaseElement instance|
|[BaseElement:BaseElement](#baseelement-baseelement)|table|Post initialization|
|[BaseElement:BaseElement](#baseelement-baseelement-type)|boolean|Checks if the element is a specific type|
|[BaseElement:BaseElement](#baseelement-baseelement-eventname-enable)|table|Enables or disables event listening for a specific event|
|[BaseElement:BaseElement](#baseelement-baseelement-event-callback)|table|Registers a callback function|
|[BaseElement:BaseElement](#baseelement-baseelement-event-any)|table|Triggers an event and calls all registered callbacks|
|[BaseElement:BaseElement](#baseelement-baseelement-event)|handled|Handles all events|
|[BaseElement:BaseElement](#baseelement-baseelement-event)|handled|The default event handler for all events|
|[BaseElement:BaseElement](#baseelement-baseelement-property-callback)|table|Observes a property and calls a callback when it changes|
|[BaseElement:BaseElement](#baseelement-baseelement)|BaseFrame|Returns the base frame of the element|
|[BaseElement:BaseElement](#baseelement-baseelement)|-|Destroys the element and cleans up all references|
|[BaseElement:BaseElement](#baseelement-baseelement)|table|Requests a render update for this element|

## BaseElement.defineEvent(class, eventName, requiredEvent?)

Registers a new event listener for the element (on class level)

### Parameters
* `class` `table` The class to register
* `eventName` `string` The name of the event to register
* `requiredEvent` *(optional)* `string` The name of the required event (optional)

## BaseElement.registerEventCallback(class, callbackName, string)

Registers a new event callback for the element (on class level)

### Parameters
* `class` `table` The class to register
* `callbackName` `string` The name of the callback to register
* `string` `The` names of the events to register the callback for

## BaseElement.new()
### Returns
* `table` `The` newly created BaseElement instance

## BaseElement:BaseElement(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `table` `self` The initialized instance

## BaseElement:BaseElement()
### Returns
* `table` `self` The BaseElement instance

## BaseElement:BaseElement(type)

Checks if the element is a specific type

### Parameters
* `type` `string` The type to check for

### Returns
* `boolean` `isType` Whether the element is of the specified type

## BaseElement:BaseElement(eventName, enable?)

Enables or disables event listening for a specific event

### Parameters
* `eventName` `string` The name of the event to listen for
* `enable` *(optional)* `boolean` Whether to enable or disable the event (default: true)

### Returns
* `table` `self` The BaseElement instance

## BaseElement:BaseElement(event, callback)

Registers a callback function for an event

### Parameters
* `event` `string` The event to register the callback for
* `callback` `function` The callback function to register

### Returns
* `table` `self` The BaseElement instance

## BaseElement:BaseElement(event, any)

Triggers an event and calls all registered callbacks

### Parameters
* `event` `string` The event to fire
* `any` `Additional` arguments to pass to the callbacks

### Returns
* `table` `self` The BaseElement instance

## BaseElement:BaseElement(event)
### Parameters
* `event` `string` The event to handle

### Returns
* `handled` `Whether` the event was handled

## BaseElement:BaseElement(event)
### Parameters
* `event` `string` The event to handle

### Returns
* `handled` `Whether` the event was handled

## BaseElement:BaseElement(property, callback)

Observes a property and calls a callback when it changes

### Parameters
* `property` `string` The property to observe
* `callback` `function` The callback to call when the property changes

### Returns
* `table` `self` The BaseElement instance

## BaseElement:BaseElement()

Returns the base frame of the element

### Returns
* `BaseFrame` `BaseFrame` The base frame of the element

## BaseElement:BaseElement()

Destroys the element and cleans up all references

## BaseElement:BaseElement()

Requests a render update for this element

### Returns
* `table` `self` The BaseElement instance

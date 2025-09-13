# BaseFrame

Extends: `Container`

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseFrame:BaseFrame](#baseframe-baseframe-self-name-default-persist-path)|BaseFrame|Initializes a new state|

## BaseFrame:BaseFrame(self, name, default, persist?, path?)

Initializes a new state for this element

### Parameters
* `self` `BaseFrame` The element to initialize state for
* `name` `string` The name of the state
* `default` `any` The default value of the state
* `persist` *(optional)* `boolean` Whether to persist the state to disk
* `path` *(optional)* `string` Custom file path for persistence

### Returns
* `BaseFrame` `self` The element instance

# BaseElement
_This is the state plugin. It provides a state management system for UI elements with support for
persistent states, computed states, and state sharing between elements._

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement:BaseElement](#baseelement-baseelement-self-name-value)|BaseElement|Sets a state value|
|[BaseElement:BaseElement](#baseelement-baseelement-self-name)|any|Gets a state value|
|[BaseElement:BaseElement](#baseelement-baseelement-self-statename-callback)|BaseElement|Watches for state changes|
|[BaseElement:BaseElement](#baseelement-baseelement-self-statename-callback)|BaseElement|Removes a state change observer|
|[BaseElement:BaseElement](#baseelement-baseelement-self-propertyname-statename)|BaseElement|Binds a property to a state|

## BaseElement:BaseElement(self, name, value)

Sets the value of a state

### Parameters
* `self` `BaseElement` The element to set state for
* `name` `string` The name of the state
* `value` `any` The new value for the state

### Returns
* `BaseElement` `self` The element instance

## BaseElement:BaseElement(self, name)

Gets the value of a state

### Parameters
* `self` `BaseElement` The element to get state from
* `name` `string` The name of the state

### Returns
* `any` `value` The current state value

## BaseElement:BaseElement(self, stateName, callback)

Registers a callback for state changes

### Parameters
* `self` `BaseElement` The element to watch
* `stateName` `string` The state to watch
* `callback` `function` Called with (element, newValue, oldValue)

### Returns
* `BaseElement` `self` The element instance

## BaseElement:BaseElement(self, stateName, callback)

Removes a state change observer

### Parameters
* `self` `BaseElement` The element to remove observer from
* `stateName` `string` The state to remove observer from
* `callback` `function` The callback function to remove

### Returns
* `BaseElement` `self` The element instance

## BaseElement:BaseElement(self, propertyName, stateName)

Binds a property to a state

### Parameters
* `self` `BaseElement` The element to bind
* `propertyName` `string` The property to bind
* `stateName` `string` The state to bind to (optional, uses propertyName if not provided)

### Returns
* `BaseElement` `self` The element instance

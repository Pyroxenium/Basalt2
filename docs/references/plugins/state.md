# BaseElement
This is the state plugin. It provides a state management system for UI elements with support for
persistent states, computed states, and state sharing between elements.

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement:bind](#baseelement-bind)|BaseElement|
|[BaseElement:computed](#baseelement-computed)|-|
|[BaseElement:getState](#baseelement-getstate)|any|Gets a state value
|[BaseElement:onStateChange](#baseelement-onstatechange)|BaseElement|Watches for state changes
|[BaseElement:removeStateChange](#baseelement-removestatechange)|BaseElement|Removes a state change observer
|[BaseElement:setState](#baseelement-setstate)|BaseElement|Sets a state value


## BaseElement:bind(self, propertyName, stateName)
Binds a property to a state

### Parameters
* `self` `BaseElement` The element to bind
* `propertyName` `string` The property to bind
* `stateName` `string` The state to bind to (optional, uses propertyName if not provided)

### Returns
* `BaseElement` `self` The element instance

## BaseElement:computed()

## BaseElement:getState(self, name)
Gets the value of a state

### Parameters
* `self` `BaseElement` The element to get state from
* `name` `string` The name of the state

### Returns
* `any` `value` The current state value

## BaseElement:onStateChange(self, stateName, callback)
Registers a callback for state changes

### Parameters
* `self` `BaseElement` The element to watch
* `stateName` `string` The state to watch
* `callback` `function` Called with (element, newValue, oldValue)

### Returns
* `BaseElement` `self` The element instance

## BaseElement:removeStateChange(self, stateName, callback)
Removes a state change observer

### Parameters
* `self` `BaseElement` The element to remove observer from
* `stateName` `string` The state to remove observer from
* `callback` `function` The callback function to remove

### Returns
* `BaseElement` `self` The element instance

## BaseElement:setState(self, name, value)
Sets the value of a state

### Parameters
* `self` `BaseElement` The element to set state for
* `name` `string` The name of the state
* `value` `any` The new value for the state

### Returns
* `BaseElement` `self` The element instance


---
<br>

# BaseFrame : Container

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseFrame.setup](#baseframe-setup)|-|
|[BaseFrame:initializeState](#baseframe-initializestate)|BaseFrame|Initializes a new state


## BaseFrame.setup()

## BaseFrame:initializeState(self, name, default, persist?, path?)
Initializes a new state for this element

### Parameters
* `self` `BaseFrame` The element to initialize state for
* `name` `string` The name of the state
* `default` `any` The default value of the state
* `persist` *(optional)* `boolean` Whether to persist the state to disk
* `path` *(optional)* `string` Custom file path for persistence

### Returns
* `BaseFrame` `self` The element instance



# BaseElement
This is the state plugin. It provides a state management system for UI elements with support for
persistent states, computed states, and state sharing between elements.

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement:computed](#baseelement-computed)|BaseElement|Creates a computed state
|[BaseElement:getState](#baseelement-getstate)|any|Gets a state value
|[BaseElement:initializeState](#baseelement-initializestate)|BaseElement|Initializes a new state
|[BaseElement:onStateChange](#baseelement-onstatechange)|BaseElement|Watches for state changes
|[BaseElement:setState](#baseelement-setstate)|BaseElement|Sets a state value
|[BaseElement:shareState](#baseelement-sharestate)|BaseElement|Shares state between elements


## BaseElement:computed(self, key, computeFn)
Creates a computed state that derives its value from other states

### Parameters
* `self` `BaseElement` The element to create computed state for
* `key` `string` The name of the computed state
* `computeFn` `function` Function that computes the state value

### Returns
* `BaseElement` `self` The element instance

## BaseElement:getState(self, name)
Gets the value of a state

### Parameters
* `self` `BaseElement` The element to get state from
* `name` `string` The name of the state

### Returns
* `any` `value` The current state value

## BaseElement:initializeState(self, name, default, canTriggerRender?, persist?, path?)
Initializes a new state for this element

### Parameters
* `self` `BaseElement` The element to initialize state for
* `name` `string` The name of the state
* `default` `any` The default value of the state
* `canTriggerRender` *(optional)* `boolean` Whether state changes trigger a render
* `persist` *(optional)* `boolean` Whether to persist the state to disk
* `path` *(optional)* `string` Custom file path for persistence

### Returns
* `BaseElement` `self` The element instance

## BaseElement:onStateChange(self, stateName, callback)
Registers a callback for state changes

### Parameters
* `self` `BaseElement` The element to watch
* `stateName` `string` The state to watch
* `callback` `function` Called with (element, newValue, oldValue)

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

## BaseElement:shareState(self, stateKey...)
Shares a state with other elements, keeping them in sync

### Parameters
* `self` `BaseElement` The source element
* `stateKey` `string` The state to share
* `...` *(vararg)* `BaseElement` The target elements to share with

### Returns
* `BaseElement` `self` The source element



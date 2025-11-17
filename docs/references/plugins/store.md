# BaseFrame

Extends: `Container`

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseFrame:initializeStore](#baseframe-initializestore-self-name-default-persist-path)|BaseFrame|Initializes a new store|

## BaseFrame:initializeStore(self, name, default, persist?, path?)

Initializes a new store for this element

### Parameters
* `self` `BaseFrame` The element to initialize store for
* `name` `string` The name of the store
* `default` `any` The default value of the store
* `persist` *(optional)* `boolean` Whether to persist the store to disk
* `path` *(optional)* `string` Custom file path for persistence

### Returns
* `BaseFrame` `self` The element instance

# BaseElement
_This is the store plugin. It provides a store management system for UI elements with support for_
_persistent stores, computed stores, and store sharing between elements._

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement:setStore](#baseelement-setstore-self-name-value)|BaseElement|Sets a store value|
|[BaseElement:getStore](#baseelement-getstore-self-name)|any|Gets a store value|
|[BaseElement:onStoreChange](#baseelement-onstorechange-self-storename-callback)|BaseElement|Watches for store changes|
|[BaseElement:removeStoreChange](#baseelement-removestorechange-self-storename-callback)|BaseElement|Removes a store change observer|
|[BaseElement:bind](#baseelement-bind-self-propertyname-storename)|BaseElement|Binds a property to a store|

## BaseElement:setStore(self, name, value)

Sets the value of a store

### Parameters
* `self` `BaseElement` The element to set store for
* `name` `string` The name of the store
* `value` `any` The new value for the store

### Returns
* `BaseElement` `self` The element instance

## BaseElement:getStore(self, name)

Gets the value of a store

### Parameters
* `self` `BaseElement` The element to get store from
* `name` `string` The name of the store

### Returns
* `any` `value` The current store value

## BaseElement:onStoreChange(self, storeName, callback)

Registers a callback for store changes

### Parameters
* `self` `BaseElement` The element to watch
* `storeName` `string` The store to watch
* `callback` `function` Called with (element, newValue, oldValue)

### Returns
* `BaseElement` `self` The element instance

## BaseElement:removeStoreChange(self, storeName, callback)

Removes a store change observer

### Parameters
* `self` `BaseElement` The element to remove observer from
* `storeName` `string` The store to remove observer from
* `callback` `function` The callback function to remove

### Returns
* `BaseElement` `self` The element instance

## BaseElement:bind(self, propertyName, storeName)

Binds a property to a store

### Parameters
* `self` `BaseElement` The element to bind
* `propertyName` `string` The property to bind
* `storeName` `string` The store to bind to (optional, uses propertyName if not provided)

### Returns
* `BaseElement` `self` The element instance

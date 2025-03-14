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
|[BaseElement.defineEvent](#BaseElement.defineEvent)|-|
|[BaseElement.registerEventCallback](#BaseElement.registerEventCallback)|-|
|[BaseElement:destroy](#BaseElement:destroy)|-|Destroys the element and cleans up all references
|[BaseElement:fireEvent](#BaseElement:fireEvent)|table|Triggers an event and calls all registered callbacks
|[BaseElement:getBaseFrame](#BaseElement:getBaseFrame)|table|Returns the base frame of the element
|[BaseElement:isType](#BaseElement:isType)|boolean|Checks if the element is a specific type
|[BaseElement:listenEvent](#BaseElement:listenEvent)|table|Enables or disables event listening for a specific event
|[BaseElement:onChange](#BaseElement:onChange)|table|Observes a property and calls a callback when it changes
|[BaseElement:registerCallback](#BaseElement:registerCallback)|table|Registers a callback function
|[BaseElement:updateRender](#BaseElement:updateRender)|-|Requests a render update for this element


## Protected Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement:dispatchEvent](#BaseElement:dispatchEvent)|boolean?|Handles all events
|[BaseElement:handleEvent](#BaseElement:handleEvent)|boolean?|The default event handler for all events
|[BaseElement:init](#BaseElement:init)|table|Initializes the BaseElement instance
|[BaseElement:postInit](#BaseElement:postInit)|table|Post initialization

## BaseElement.defineEvent()
Registers a new event listener for the element (on class level)

## BaseElement.registerEventCallback()
Registers a new event callback for the element (on class level)

## BaseElement:destroy()
Destroys the element and cleans up all references

### Usage
 ```lua
element:destroy()
```

## BaseElement:fireEvent(event, ...)
Triggers an event and calls all registered callbacks

### Parameters
* `event` `string` The event to fire
* `...` `any` Additional arguments to pass to the callbacks

### Returns
* `table` `self` The BaseElement instance

### Usage
 ```lua
element:fireEvent("mouse_click", 1, 2)
```

## BaseElement:getBaseFrame()
Returns the base frame of the element

### Returns
* `table` `BaseFrame` The base frame of the element

## BaseElement:isType(type)
Checks if the element is a specific type

### Parameters
* `type` `string` The type to check for

### Returns
* `boolean` `Whether` the element is of the specified type

## BaseElement:listenEvent(eventName, enable?)
Enables or disables event listening for a specific event

### Parameters
* `eventName` `string` The name of the event to listen for
* `enable` *(optional)* `boolean` Whether to enable or disable the event (default: true)

### Returns
* `table` `self` The BaseElement instance

### Usage
 ```lua
element:listenEvent("mouse_click", true)
```

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

### Usage
 ```lua
element:registerCallback("mouse_click", function(self, ...) end)
```

## BaseElement:updateRender()
Requests a render update for this element

### Usage
 ```lua
element:updateRender()
```



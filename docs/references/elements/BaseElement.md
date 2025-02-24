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
|[BaseElement.new](#BaseElement.new)|table|Creates a new BaseElement instance
|[BaseElement.registerEventCallback](#BaseElement.registerEventCallback)|-|
|[BaseElement:destroy](#BaseElement:destroy)|-|Destroys the element and cleans up all references
|[BaseElement:dispatchEvent](#BaseElement:dispatchEvent)|boolean?|Handles all events
|[BaseElement:fireEvent](#BaseElement:fireEvent)|table|Triggers an event and calls all registered callbacks
|[BaseElement:getBaseFrame](#BaseElement:getBaseFrame)|table|Returns the base frame of the element
|[BaseElement:handleEvent](#BaseElement:handleEvent)|boolean?|The default event handler for all events
|[BaseElement:init](#BaseElement:init)|table|Initializes the BaseElement instance
|[BaseElement:isType](#BaseElement:isType)|boolean|Checks if the element is a specific type
|[BaseElement:listenEvent](#BaseElement:listenEvent)|table|Enables or disables event listening for a specific event
|[BaseElement:postInit](#BaseElement:postInit)|table|Post initialization
|[BaseElement:registerCallback](#BaseElement:registerCallback)|table|Registers a callback function
|[BaseElement:updateRender](#BaseElement:updateRender)|-|Requests a render update for this element


## BaseElement.defineEvent()

## BaseElement.new(props, basalt)
Creates a new BaseElement instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `table` `The` newly created BaseElement instance

### Usage
 ```lua
local element = BaseElement.new()
```

## BaseElement.registerEventCallback()

## BaseElement:destroy()
Destroys the element and cleans up all references

### Usage
 ```lua
element:destroy()
```

## BaseElement:dispatchEvent(event...)
Handles all events

### Parameters
* `event` `string` The event to handle
* `...` *(vararg)* `any` The arguments for the event

### Returns
* `boolean?` `handled` Whether the event was handled

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

## BaseElement:handleEvent(event...)
The default event handler for all events

### Parameters
* `event` `string` The event to handle
* `...` *(vararg)* `any` The arguments for the event

### Returns
* `boolean?` `handled` Whether the event was handled

## BaseElement:init(props, basalt)
Initializes the BaseElement instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `table` `self` The initialized instance

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

## BaseElement:postInit()
Post initialization

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



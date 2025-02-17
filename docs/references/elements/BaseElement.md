# BaseElement : PropertySystem
The base class for all UI elements in Basalt

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|type|string|BaseElement|The type identifier of the element
|id|string|BaseElement|The unique identifier for the element
|name|string|BaseElement|The name of the element
|eventCallbacks|table|{}|Table containing all registered event callbacks

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement.listenTo](#BaseElement.listenTo)|-|
|[BaseElement.new](#BaseElement.new)|table|
|[BaseElement:destroy](#BaseElement:destroy)|-|
|[BaseElement:dispatchEvent](#BaseElement:dispatchEvent)|boolean?|
|[BaseElement:fireEvent](#BaseElement:fireEvent)|table|
|[BaseElement:getBaseFrame](#BaseElement:getBaseFrame)|table|
|[BaseElement:handleEvent](#BaseElement:handleEvent)|boolean?|
|[BaseElement:init](#BaseElement:init)|table|
|[BaseElement:isType](#BaseElement:isType)|boolean|
|[BaseElement:listenEvent](#BaseElement:listenEvent)|table|
|[BaseElement:postInit](#BaseElement:postInit)|table|
|[BaseElement:registerCallback](#BaseElement:registerCallback)|table|
|[BaseElement:updateRender](#BaseElement:updateRender)|-|

## BaseElement.listenTo(class, eventName)
Registers an event that this class can listen to

### Parameters
* `class` `table` The class to add the event to
* `eventName` `string` The name of the event to register

### Usage
 ```lua
BaseElement.listenTo(MyClass, "mouse_click")
```

## BaseElement.new(props, basalt)
Creates a new BaseElement instance

### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

### Returns
* `table` `The` newly created BaseElement instance

### Usage
 ```lua
local element = BaseElement.new("myId", basalt)
```

## BaseElement:destroy()
Destroys the element and cleans up all references

### Usage
 ```lua
element:destroy()
```

## BaseElement:dispatchEvent(event)
Handles all events
@vararg any The arguments for the event

### Parameters
* `event` `string` The event to handle

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

## BaseElement:handleEvent(event)
The default event handler for all events
@vararg any The arguments for the event

### Parameters
* `event` `string` The event to handle

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


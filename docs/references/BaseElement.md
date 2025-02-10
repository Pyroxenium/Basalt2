# BaseElement : PropertySystem
The base class for all UI elements in Basalt

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|type|string|BaseElement|The type identifier of the element
|eventCallbacks|table|{}|Table containing all registered event callbacks

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement.listenTo](#BaseElement.listenTo)|-|
|[BaseElement.new](#BaseElement.new)|table|
|[BaseElement:fireEvent](#BaseElement:fireEvent)|table|
|[BaseElement:init](#BaseElement:init)|table|
|[BaseElement:listenEvent](#BaseElement:listenEvent)|table|
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

## BaseElement.new(id, basalt)
Creates a new BaseElement instance

### Parameters
* `id` `string` The unique identifier for this element
* `basalt` `table` The basalt instance

### Returns
* `table` `The` newly created BaseElement instance

### Usage
 ```lua
local element = BaseElement.new("myId", basalt)
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

## BaseElement:init(id, basalt)
Initializes the BaseElement instance

### Parameters
* `id` `string` The unique identifier for this element
* `basalt` `table` The basalt instance

### Returns
* `table` `self` The initialized instance

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


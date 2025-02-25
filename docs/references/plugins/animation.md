# Animation
This is the animation plugin. It provides a animation system for visual elements
with support for sequences, easing functions, and multiple animation types.

## Functions

|Method|Returns|Description|
|---|---|---|
|[Animation.new](#Animation.new)|Animation|Creates a new animation
|[Animation.registerAnimation](#Animation.registerAnimation)|-|Registers a custom animation type
|[Animation.registerEasing](#Animation.registerEasing)|-|Adds a custom easing function
|[Animation:addAnimation](#Animation:addAnimation)|-|Adds a new animation to the sequence
|[Animation:event](#Animation:event)|-|The event handler for the animation
|[Animation:onComplete](#Animation:onComplete)|Animation|Registers a callback for the complete event
|[Animation:onStart](#Animation:onStart)|-|Registers a callback for the start event
|[Animation:onUpdate](#Animation:onUpdate)|Animation|Registers a callback for the update event
|[Animation:sequence](#Animation:sequence)|Animation|Creates a new sequence
|[Animation:start](#Animation:start)|Animation|Starts the animation


## Animation.new(element)
Creates a new Animation

### Parameters
* `element` `VisualElement` The element to animate

### Returns
* `Animation` `The` new animation

## Animation.registerAnimation(name, handlers)
Registers a new animation type

### Parameters
* `name` `string` The name of the animation
* `handlers` `table` Table containing start, update and complete handlers

### Usage
 ```lua
Animation.registerAnimation("fade", {start=function(anim) end, update=function(anim,progress) end})
```

## Animation.registerEasing(name, func)
Registers a new easing function

### Parameters
* `name` `string` The name of the easing function
* `func` `function` The easing function (takes progress 0-1, returns modified progress)

## Animation:addAnimation(type, args, duration, easing)
Adds a new animation to the sequence

### Parameters
* `type` `string` The type of animation
* `args` `table` The animation arguments
* `duration` `number` The duration in seconds
* `easing` `string` The easing function name

## Animation:event(event, timerId)
The event handler for the animation (listens to timer events)

### Parameters
* `event` `string` The event type
* `timerId` `number` The timer ID

## Animation:onComplete(callback)
Registers a callback for the complete event

### Parameters
* `callback` `function` The callback function to register

### Returns
* `Animation` `self` The animation instance

## Animation:onStart(callback)
Registers a callback for the start event

### Parameters
* `callback` `function` The callback function to register

## Animation:onUpdate(callback)
Registers a callback for the update event

### Parameters
* `callback` `function` The callback function to register

### Returns
* `Animation` `self` The animation instance

## Animation:sequence()
Creates a new sequence

### Returns
* `Animation` `self` The animation instance

## Animation:start()
Starts the animation

### Returns
* `Animation` `self` The animation instance



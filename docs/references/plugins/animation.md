# AnimationInstance
_This is the AnimationInstance class. It represents a single animation instance_

## Functions

|Method|Returns|Description|
|---|---|---|
|[AnimationInstance.new](#animationinstance-new-element-animtype-args-duration-easing)|AnimationInstance|Creates a new animation instance|
|[AnimationInstance:start](#animationinstance-start)|AnimationInstance|Starts the animation|
|[AnimationInstance:update](#animationinstance-update-elapsed)|boolean|Updates the animation|
|[AnimationInstance:complete](#animationinstance-complete)|-|Called when the animation is completed|

## AnimationInstance.new(element, animType, args, duration, easing)

Creates a new AnimationInstance

### Parameters
* `element` `VisualElement` The element to animate
* `animType` `string` The type of animation
* `args` `table` The animation arguments
* `duration` `number` Duration in seconds
* `easing` `string` The easing function name

### Returns
* `AnimationInstance` `The` new animation instance

## AnimationInstance:start()

Starts the animation

### Returns
* `AnimationInstance` `self` The animation instance

## AnimationInstance:update(elapsed)

Updates the animation

### Parameters
* `elapsed` `number` The elapsed time in seconds

### Returns
* `boolean` `Whether` the animation is finished

## AnimationInstance:complete()

Gets called when the animation is completed

# Animation
_This is the animation plugin. It provides a animation system for visual elements
with support for sequences, easing functions, and multiple animation types._

## Functions

|Method|Returns|Description|
|---|---|---|
|[Animation.registerAnimation](#animation-registeranimation-name-handlers)|-|Registers a custom animation type|
|[Animation.registerEasing](#animation-registereasing-name-func)|-|Adds a custom easing function|
|[Animation.new](#animation-new-element)|Animation|Creates a new animation|
|[Animation:sequence](#animation-sequence)|Animation|Creates a new sequence|
|[Animation:onStart](#animation-onstart-callback)|-|Registers a callback for the start event|
|[Animation:onUpdate](#animation-onupdate-callback)|Animation|Registers a callback for the update event|
|[Animation:onComplete](#animation-oncomplete-callback)|Animation|Registers a callback for the complete event|
|[Animation:addAnimation](#animation-addanimation-type-args-duration-easing)|-|Adds a new animation to the sequence|
|[Animation:start](#animation-start)|Animation|Starts the animation|
|[Animation:event](#animation-event-event-timerid)|-|The event handler for the animation|
|[Animation:stop](#animation-stop)|-|Stops the animation|

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

## Animation.new(element)

Creates a new Animation

### Parameters
* `element` `VisualElement` The element to animate

### Returns
* `Animation` `The` new animation

## Animation:sequence()

Creates a new sequence

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

## Animation:onComplete(callback)

Registers a callback for the complete event

### Parameters
* `callback` `function` The callback function to register

### Returns
* `Animation` `self` The animation instance

## Animation:addAnimation(type, args, duration, easing)

Adds a new animation to the sequence

### Parameters
* `type` `string` The type of animation
* `args` `table` The animation arguments
* `duration` `number` The duration in seconds
* `easing` `string` The easing function name

## Animation:start()

Starts the animation

### Returns
* `Animation` `self` The animation instance

## Animation:event(event, timerId)

The event handler for the animation (listens to timer events)

### Parameters
* `event` `string` The event type
* `timerId` `number` The timer ID

## Animation:stop()

Stops the animation immediately: cancels timers, completes running anim instances and clears the element property

# VisualElement
_Adds additional methods for VisualElement when adding animation plugin_

## Functions

|Method|Returns|Description|
|---|---|---|
|[VisualElement.hooks](#visualelement-hooks)|-||
|[VisualElement.setup](#visualelement-setup)|-||
|[VisualElement.stopAnimation](#visualelement-stopanimation)|-|Convenience to stop animations from the element|
|[VisualElement:animate](#visualelement-animate)|Animation|Creates a new animation|

## VisualElement.hooks()
## VisualElement.setup()
## VisualElement.stopAnimation()

Convenience to stop animations from the element

## VisualElement:animate()

Creates a new Animation Object

### Returns
* `Animation` `animation` The new animation

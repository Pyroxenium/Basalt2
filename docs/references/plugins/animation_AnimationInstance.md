# AnimationInstance
This is the AnimationInstance class. It represents a single animation instance

## Fields

|Field|Type|Description|
|---|---|---|
|element|`VisualElement`|The element being animated|
|type|`string`|The type of animation|
|args|`table`|The animation arguments|
|duration|`number`|The duration in seconds|
|startTime|`number`|The animation start time|
|isPaused|`boolean`|Whether the animation is paused|
|handlers|`table`|The animation handlers|
|easing|`string`|The easing function name|

## Functions

|Method|Returns|Description|
|---|---|---|
|[AnimationInstance.new](#AnimationInstance.new)|AnimationInstance|Creates a new animation instance
|[AnimationInstance:complete](#AnimationInstance:complete)|-|Called when the animation is completed
|[AnimationInstance:start](#AnimationInstance:start)|AnimationInstance|Starts the animation
|[AnimationInstance:update](#AnimationInstance:update)|boolean|Updates the animation


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

## AnimationInstance:complete()
Gets called when the animation is completed

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



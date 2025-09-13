# Timer
_The Timer is a non-visual element that can be used to perform actions at specific intervals._

Extends: `BaseElement`

## Properties

|Property|Type|Default|Description|
|---|---|---|---|
|interval|number|1|The interval in seconds at which the timer will trigger its action.|
|action|function|function|The action to be performed when the timer triggers.|
|running|boolean|false|Indicates whether the timer is currently running or not.|
|amount|number|-1|The amount of time the timer should run.|

## Functions

|Method|Returns|Description|
|---|---|---|
|[Timer.new](#timer-new)|table|Creates a new Timer instance|
|[Timer:Timer](#timer-timer-props-basalt)|-|Initializes the Timer instance|
|[Timer:Timer](#timer-timer-self)|Timer|Starts the timer|
|[Timer:Timer](#timer-timer-self)|Timer|Stops the timer|
|[Timer:Timer](#timer-timer)|-|Dispatches events to the Timer instance|

## Timer.new()
### Returns
* `table` `self` The created instance

## Timer:Timer(props, basalt)
### Parameters
* `props` `table` The properties to initialize the element with
* `basalt` `table` The basalt instance

## Timer:Timer(self)

Starts the timer with the specified interval.

### Parameters
* `self` `Timer` The Timer instance to start

### Returns
* `Timer` `self` The Timer instance

## Timer:Timer(self)

Stops the timer if it is currently running.

### Parameters
* `self` `Timer` The Timer instance to stop

### Returns
* `Timer` `self` The Timer instance

## Timer:Timer()
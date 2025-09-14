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
|[Timer:start](#timer-start-self)|Timer|Starts the timer|
|[Timer:stop](#timer-stop-self)|Timer|Stops the timer|

## Timer:start(self)

Starts the timer with the specified interval.

### Parameters
* `self` `Timer` The Timer instance to start

### Returns
* `Timer` `self` The Timer instance

## Timer:stop(self)

Stops the timer if it is currently running.

### Parameters
* `self` `Timer` The Timer instance to stop

### Returns
* `Timer` `self` The Timer instance

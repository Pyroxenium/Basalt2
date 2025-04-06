# BaseElement

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement:benchmark](#baseelement-benchmark)|BaseElement|Enables performance measurement for a method
|[BaseElement:endProfile](#baseelement-endprofile)|BaseElement|Ends timing a method call and records statistics
|[BaseElement:getBenchmarkStats](#baseelement-getbenchmarkstats)|table?|Retrieves benchmark statistics for a method
|[BaseElement:logBenchmark](#baseelement-logbenchmark)|BaseElement|Logs benchmark statistics for a method
|[BaseElement:startProfile](#baseelement-startprofile)|BaseElement|Starts timing a method call
|[BaseElement:stopBenchmark](#baseelement-stopbenchmark)|BaseElement|Disables performance measurement for a method


## BaseElement:benchmark(methodName)
Enables benchmarking for a method

### Parameters
* `methodName` `string` The name of the method to benchmark

### Returns
* `BaseElement` `self` The element instance

### Usage
 ```lua
element:benchmark("render")
```

## BaseElement:endProfile(methodName)
Ends profiling a method

### Parameters
* `methodName` `string` The name of the method to stop profiling

### Returns
* `BaseElement` `self` The element instance

## BaseElement:getBenchmarkStats(methodName)
Gets benchmark statistics for a method

### Parameters
* `methodName` `string` The name of the method to get statistics for

### Returns
* `table?` `stats` The benchmark statistics or nil

## BaseElement:logBenchmark(methodName)
Logs benchmark statistics for a method

### Parameters
* `methodName` `string` The name of the method to log

### Returns
* `BaseElement` `self` The element instance

## BaseElement:startProfile(methodName)
Starts profiling a method

### Parameters
* `methodName` `string` The name of the method to profile

### Returns
* `BaseElement` `self` The element instance

## BaseElement:stopBenchmark(methodName)
Stops benchmarking for a method

### Parameters
* `methodName` `string` The name of the method to stop benchmarking

### Returns
* `BaseElement` `self` The element instance



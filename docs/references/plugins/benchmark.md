# BaseElement

## Functions

|Method|Returns|Description|
|---|---|---|
|[BaseElement:startProfile](#baseelement-startprofile-methodname)|BaseElement|Starts timing a method call|
|[BaseElement:endProfile](#baseelement-endprofile-methodname)|BaseElement|Ends timing a method call and records statistics|
|[BaseElement:benchmark](#baseelement-benchmark-methodname)|BaseElement|Enables performance measurement for a method|
|[BaseElement:logBenchmark](#baseelement-logbenchmark-methodname)|BaseElement|Logs benchmark statistics for a method|
|[BaseElement:stopBenchmark](#baseelement-stopbenchmark-methodname)|BaseElement|Disables performance measurement for a method|
|[BaseElement:getBenchmarkStats](#baseelement-getbenchmarkstats-methodname)|stats|Retrieves benchmark statistics for a method|

## BaseElement:startProfile(methodName)

Starts profiling a method

### Parameters
* `methodName` `string` The name of the method to profile

### Returns
* `BaseElement` `self` The element instance

## BaseElement:endProfile(methodName)

Ends profiling a method

### Parameters
* `methodName` `string` The name of the method to stop profiling

### Returns
* `BaseElement` `self` The element instance

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

## BaseElement:logBenchmark(methodName)

Logs benchmark statistics for a method

### Parameters
* `methodName` `string` The name of the method to log

### Returns
* `BaseElement` `self` The element instance

## BaseElement:stopBenchmark(methodName)

Stops benchmarking for a method

### Parameters
* `methodName` `string` The name of the method to stop benchmarking

### Returns
* `BaseElement` `self` The element instance

## BaseElement:getBenchmarkStats(methodName)

Gets benchmark statistics for a method

### Parameters
* `methodName` `string` The name of the method to get statistics for

### Returns
* `stats` `The` benchmark statistics or nil

# Container

Extends: `VisualElement`

## Functions

|Method|Returns|Description|
|---|---|---|
|[Container:benchmarkContainer](#container-benchmarkcontainer-methodname)|Container|Recursively enables benchmarking|
|[Container:logContainerBenchmarks](#container-logcontainerbenchmarks-methodname)|Container|Recursively logs benchmark statistics|
|[Container:stopContainerBenchmark](#container-stopcontainerbenchmark-methodname)|Container|Recursively stops benchmarking|

## Container:benchmarkContainer(methodName)

Enables benchmarking for a container and all its children

### Parameters
* `methodName` `string` The method to benchmark

### Returns
* `Container` `self` The container instance

### Usage
```lua
container:benchmarkContainer("render")
```

## Container:logContainerBenchmarks(methodName)

Logs benchmark statistics for a container and all its children

### Parameters
* `methodName` `string` The method to log

### Returns
* `Container` `self` The container instance

## Container:stopContainerBenchmark(methodName)

Stops benchmarking for a container and all its children

### Parameters
* `methodName` `string` The method to stop benchmarking

### Returns
* `Container` `self` The container instance

# Benchmark
_This is the benchmark plugin. It provides performance measurement tools for elements and methods,
with support for hierarchical profiling and detailed statistics. The plugin is meant to be used for very big projects
where performance is critical. It allows you to measure the time taken by specific methods and log the results._

## Functions

|Method|Returns|Description|
|---|---|---|
|[Benchmark.start](#benchmark-start-name-options)|-|Starts timing a custom operation|
|[Benchmark.stop](#benchmark-stop-name)|-|Stops timing and logs results|
|[Benchmark.getStats](#benchmark-getstats-name)|stats|Retrieves benchmark statistics|
|[Benchmark.clear](#benchmark-clear-name)|-|Removes a benchmark's data|
|[Benchmark.clearAll](#benchmark-clearall)|-|Removes all custom benchmark data|

## Benchmark.start(name, options?)

Starts a custom benchmark

### Parameters
* `name` `string` The name of the benchmark
* `options` *(optional)* `table` Optional configuration 

## Benchmark.stop(name)

Stops a custom benchmark

### Parameters
* `name` `string` The name of the benchmark to stop

## Benchmark.getStats(name)

Gets statistics for a benchmark

### Parameters
* `name` `string` The name of the benchmark

### Returns
* `stats` `The` benchmark statistics or nil

## Benchmark.clear(name)

Clears a specific benchmark

### Parameters
* `name` `string` The name of the benchmark to clear

## Benchmark.clearAll()

Clears all custom benchmarks

# Container : VisualElement

## Functions

|Method|Returns|Description|
|---|---|---|
|[Container:benchmarkContainer](#Container:benchmarkContainer)|Container|Recursively enables benchmarking
|[Container:logContainerBenchmarks](#Container:logContainerBenchmarks)|Container|Recursively logs benchmark statistics
|[Container:stopContainerBenchmark](#Container:stopContainerBenchmark)|Container|Recursively stops benchmarking


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



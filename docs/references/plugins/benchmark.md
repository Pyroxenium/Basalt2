# BenchmarkAPI
Benchmark API methods

## Functions

|Method|Returns|Description|
|---|---|---|
|[API.clear](#api-clear)|-|Removes a benchmark's data
|[API.clearAll](#api-clearall)|-|Removes all custom benchmark data
|[API.getStats](#api-getstats)|table?|Retrieves benchmark statistics
|[API.start](#api-start)|-|Starts timing a custom operation
|[API.stop](#api-stop)|-|Stops timing and logs results


## API.clear(name)
Clears a specific benchmark

### Parameters
* `name` `string` The name of the benchmark to clear

## API.clearAll()
Clears all custom benchmarks

## API.getStats(name)
Gets statistics for a benchmark

### Parameters
* `name` `string` The name of the benchmark

### Returns
* `table?` `stats` The benchmark statistics or nil

## API.start(name, options?)
Starts a custom benchmark

### Parameters
* `name` `string` The name of the benchmark
* `options` *(optional)* `table` Optional configuration 

## API.stop(name)
Stops a custom benchmark

### Parameters
* `name` `string` The name of the benchmark to stop



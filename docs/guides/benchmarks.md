# Benchmarking in Basalt

Basalt provides built-in benchmarking tools to help you analyze and optimize your application's performance.

## Basic Usage

```lua
local main = basalt.getMainFrame()

-- Start benchmarking a container
main:benchmarkContainer("render")  -- Start tracking render performance

-- Log benchmark results
main:logContainerBenchmarks("render")  -- Print results to console
```

## Available Benchmark Methods

```lua
-- Track specific container methods
container:benchmarkContainer(methodName)  -- Start tracking
container:logContainerBenchmarks(methodName)  -- Show results

-- Common methods to benchmark:
- "render"      -- Track render performance
- "mouseClick"  -- Track click handling
- "mouseUp"     -- Track release handling
- "mouseDrag"   -- Track drag performance
```

## Practical Example

```lua
local basalt = require("basalt")
local main = basalt.getMainFrame()

-- Create a benchmark trigger button
main:addButton()
    :setText("Show Benchmarks")
    :setPosition(2, 2)
    :onMouseClick(function()
        main:logContainerBenchmarks("render")
    end)

-- Create some test elements
local program = main:addProgram()
    :execute("shell.lua")

local complexFrame = main:addFrame()
    :setPosition(30, 1)
    :addButton()
    :addLabel()
    :addList()

-- Start benchmarking
main:benchmarkContainer("render")

basalt.run()
```

## Understanding Results

The benchmark results show:
- Total execution time
- Number of calls
- Average execution time
- Performance impact

## Best Practices

1. **Targeted Benchmarking**
   - Benchmark specific methods you suspect are slow
   - Test with realistic data amounts
   - Compare different implementation approaches

2. **When to Benchmark**
   - During development for optimization
   - When experiencing performance issues
   - After making significant changes

3. **Common Areas to Watch**
   - Complex render logic
   - Heavy event handlers
   - Containers with many children
   - Programs and dynamic content

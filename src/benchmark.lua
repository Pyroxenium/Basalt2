-- Will temporary exist while developing, maybe i will create a benchmark plugin in future

local log = require("log")

local Benchmark = {}

function Benchmark.start(name)
    Benchmark[name] = {
        startTime = os.epoch("local"),
        updates = 0
    }
end

function Benchmark.update(name)
    if Benchmark[name] then
        Benchmark[name].updates = Benchmark[name].updates + 1
    end
end

function Benchmark.stop(name)
    if Benchmark[name] then
        local endTime = os.epoch("local")
        local duration = endTime - Benchmark[name].startTime
        local updates = Benchmark[name].updates
        
        log.debug(string.format("[Benchmark] %s: %dms, %d updates, avg: %.2fms per update",
            name, duration, updates, duration/updates))
        
        return duration, updates
    end
end

return Benchmark

local log = require("log")

local activeProfiles = setmetatable({}, {__mode = "k"})

local function createProfile()
    return {
        methods = {},
    }
end

local function wrapMethod(element, methodName)
    local originalMethod = element[methodName]

    if not activeProfiles[element] then
        activeProfiles[element] = createProfile()
    end
    if not activeProfiles[element].methods[methodName] then
        activeProfiles[element].methods[methodName] = {
            calls = 0,
            totalTime = 0,
            minTime = math.huge,
            maxTime = 0,
            lastTime = 0,
            startTime = 0,
            path = {},
            methodName = methodName,
            originalMethod = originalMethod
        }
    end

    element[methodName] = function(self, ...)
        self:startProfile(methodName)
        local result = originalMethod(self, ...)
        self:endProfile(methodName)
        return result
    end
end

local BaseElement = {}

function BaseElement:startProfile(methodName)
    local profile = activeProfiles[self]
    if not profile then 
        profile = createProfile()
        activeProfiles[self] = profile
    end

    if not profile.methods[methodName] then
        profile.methods[methodName] = {
            calls = 0,
            totalTime = 0,
            minTime = math.huge,
            maxTime = 0,
            lastTime = 0,
            startTime = 0,
            path = {},
            methodName = methodName
        }
    end

    local methodProfile = profile.methods[methodName]
    methodProfile.startTime = os.clock() * 1000
    methodProfile.path = {}

    local current = self
    while current do
        table.insert(methodProfile.path, 1, current.get("name") or current.get("id"))
        current = current.parent
    end
    return self
end

function BaseElement:endProfile(methodName)
    local profile = activeProfiles[self]
    if not profile or not profile.methods[methodName] then return self end

    local methodProfile = profile.methods[methodName]
    local endTime = os.clock() * 1000
    local duration = endTime - methodProfile.startTime

    methodProfile.calls = methodProfile.calls + 1
    methodProfile.totalTime = methodProfile.totalTime + duration
    methodProfile.minTime = math.min(methodProfile.minTime, duration)
    methodProfile.maxTime = math.max(methodProfile.maxTime, duration)
    methodProfile.lastTime = duration

    return self
end

function BaseElement:benchmark(methodName)
    if not self[methodName] then
        log.error("Method " .. methodName .. " does not exist")
        return self
    end

    activeProfiles[self] = createProfile()
    activeProfiles[self].methodName = methodName
    activeProfiles[self].isRunning = true

    wrapMethod(self, methodName)
    return self
end

function BaseElement:logBenchmark(methodName)
    local profile = activeProfiles[self]
    if not profile or not profile.methods[methodName] then return self end

    local stats = profile.methods[methodName]
    if stats then
        local averageTime = stats.calls > 0 and (stats.totalTime / stats.calls) or 0
        log.info(string.format(
            "Benchmark results for %s.%s: " ..
            "Path: %s " ..
            "Calls: %d " ..
            "Average time: %.2fms " ..
            "Min time: %.2fms " ..
            "Max time: %.2fms " ..
            "Last time: %.2fms " ..
            "Total time: %.2fms",
            table.concat(stats.path, "."),
            stats.methodName,
            table.concat(stats.path, "/"),
            stats.calls,
            averageTime,
            stats.minTime ~= math.huge and stats.minTime or 0,
            stats.maxTime,
            stats.lastTime,
            stats.totalTime
        ))
    end
    return self
end

function BaseElement:stopBenchmark(methodName)
    local profile = activeProfiles[self]
    if not profile or not profile.methods[methodName] then return self end

    local stats = profile.methods[methodName]
    if stats and stats.originalMethod then
        self[methodName] = stats.originalMethod
    end

    profile.methods[methodName] = nil
    if not next(profile.methods) then
        activeProfiles[self] = nil
    end
    return self
end

function BaseElement:getBenchmarkStats(methodName)
    local profile = activeProfiles[self]
    if not profile or not profile.methods[methodName] then return nil end

    local stats = profile.methods[methodName]
    return {
        averageTime = stats.totalTime / stats.calls,
        totalTime = stats.totalTime,
        calls = stats.calls,
        minTime = stats.minTime,
        maxTime = stats.maxTime,
        lastTime = stats.lastTime
    }
end

local Container = {}

function Container:benchmarkContainer(methodName)
    self:benchmark(methodName)

    for _, child in pairs(self.get("children")) do
        child:benchmark(methodName)

        if child:isType("Container") then
            child:benchmarkContainer(methodName)
        end
    end
    return self
end

function Container:logContainerBenchmarks(methodName, depth)
    depth = depth or 0
    local indent = string.rep("  ", depth)
    local childrenTotalTime = 0
    local childrenStats = {}

    for _, child in pairs(self.get("children")) do
        local profile = activeProfiles[child]
        if profile and profile.methods[methodName] then
            local stats = profile.methods[methodName]
            childrenTotalTime = childrenTotalTime + stats.totalTime
            table.insert(childrenStats, {
                element = child,
                type = child.get("type"),
                calls = stats.calls,
                totalTime = stats.totalTime,
                avgTime = stats.totalTime / stats.calls
            })
        end
    end

    local profile = activeProfiles[self]
    if profile and profile.methods[methodName] then
        local stats = profile.methods[methodName]
        local selfTime = stats.totalTime - childrenTotalTime
        local avgSelfTime = selfTime / stats.calls

        log.info(string.format(
            "%sBenchmark %s (%s): " ..
            "%.2fms/call (Self: %.2fms/call) " ..
            "[Total: %dms, Calls: %d]",
            indent,
            self.get("type"),
            methodName,
            stats.totalTime / stats.calls,
            avgSelfTime,
            stats.totalTime,
            stats.calls
        ))

        if #childrenStats > 0 then
            for _, childStat in ipairs(childrenStats) do
                if childStat.element:isType("Container") then
                    childStat.element:logContainerBenchmarks(methodName, depth + 1)
                else
                    log.info(string.format("%s> %s: %.2fms/call [Total: %dms, Calls: %d]",
                        indent .. " ",
                        childStat.type,
                        childStat.avgTime,
                        childStat.totalTime,
                        childStat.calls
                    ))
                end
            end
        end
    end
    
    return self
end

function Container:stopContainerBenchmark(methodName)
    for _, child in pairs(self.get("children")) do
        if child:isType("Container") then
            child:stopContainerBenchmark(methodName)
        else
            child:stopBenchmark(methodName)
        end
    end

    self:stopBenchmark(methodName)
    return self
end

local API = {
    start = function(name, options)
        options = options or {}
        local profile = createProfile()
        profile.name = name
        profile.startTime = os.clock() * 1000
        profile.custom = true
        activeProfiles[name] = profile
    end,

    stop = function(name)
        local profile = activeProfiles[name]
        if not profile or not profile.custom then return end

        local endTime = os.clock() * 1000
        local duration = endTime - profile.startTime

        profile.calls = profile.calls + 1
        profile.totalTime = profile.totalTime + duration
        profile.minTime = math.min(profile.minTime, duration)
        profile.maxTime = math.max(profile.maxTime, duration)
        profile.lastTime = duration

        log.info(string.format(
            "Custom Benchmark '%s': " ..
            "Calls: %d " ..
            "Average time: %.2fms " ..
            "Min time: %.2fms " ..
            "Max time: %.2fms " ..
            "Last time: %.2fms " ..
            "Total time: %.2fms",
            name,
            profile.calls,
            profile.totalTime / profile.calls,
            profile.minTime,
            profile.maxTime,
            profile.lastTime,
            profile.totalTime
        ))
    end,

    getStats = function(name)
        local profile = activeProfiles[name]
        if not profile then return nil end

        return {
            averageTime = profile.totalTime / profile.calls,
            totalTime = profile.totalTime,
            calls = profile.calls,
            minTime = profile.minTime,
            maxTime = profile.maxTime,
            lastTime = profile.lastTime
        }
    end,

    clear = function(name)
        activeProfiles[name] = nil
    end,

    clearAll = function()
        for k,v in pairs(activeProfiles) do
            if v.custom then
                activeProfiles[k] = nil
            end
        end
    end
}

return {
    BaseElement = BaseElement,
    Container = Container,
    API = API
}
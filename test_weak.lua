local cache = setmetatable({}, {__mode = "k"})

-- Funktion um den Cache-Status zu prüfen
local function printCache()
    local count = 0
    for k,v in pairs(cache) do
        count = count + 1
    end
    print("Cache entries: " .. count)
end

-- Test 1: Objekte im Cache speichern
local function test1()
    print("Test 1: Adding objects")
    local obj1 = {name = "obj1"}
    local obj2 = {name = "obj2"}
    
    cache[obj1] = "value1"
    cache[obj2] = "value2"
    printCache()  -- Sollte 2 ausgeben
end

-- Test 2: Referenzen löschen und GC ausführen
local function test2()
    print("\nTest 2: After garbage collection")
    collectgarbage()  -- Force GC
    printCache()  -- Sollte 0 ausgeben, da keine Referenzen mehr existieren
end

-- Test 3: Objekt mit starker Referenz
local function test3()
    print("\nTest 3: Strong reference")
    local strongRef = {name = "strong"}
    cache[strongRef] = "value3"
    printCache()  -- Sollte 1 ausgeben
    
    print("Keeping strong reference...")
    collectgarbage()
    printCache()  -- Sollte immer noch 1 ausgeben
    
    print("Removing strong reference...")
    strongRef = nil
    collectgarbage()
    printCache()  -- Sollte 0 ausgeben
end

test1()
test2()
test3()

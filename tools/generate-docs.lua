local function processFile(inputFile, outputFile)
    local f = io.open(inputFile, "r")
    local content = f:read("*all")
    f:close()


    local out = io.open(outputFile, "w")
    out:write(content)
    out:close()

    print("Generated docs for: " .. inputFile)
end

for file in io.popen('find "src" -type f -name "*.lua"'):lines() do
    if not file:match("LuaLS.lua$") then
        local outputFile = "build_docs/docs/references/" .. file:gsub("^src/", ""):gsub("%.lua$", ".md")
        processFile(file, outputFile)
    end
end

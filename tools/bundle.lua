-- Basalt bundler tool (not part of the framework itself).
--
-- Packs everything under src/ into one release file that behaves exactly
-- like require("Basalt"): every source file is embedded as a string and
-- compiled on first require with its own chunk name, so error tracebacks
-- still show "basalt/core/render.lua:123" instead of bundle offsets.
--
-- CLI usage (from the repository root):
--   bundle                      -> writes bundle/basalt.min.lua, minified
--   bundle myout.lua            -> custom output path
--   bundle --no-minify          -> writes bundle/basalt.lua, comments removed
--   bundle --compress           -> writes bundle/basalt.compressed.lua
--
-- Library usage (e.g. from the installer):
--   local bundler = assert(loadfile("Basalt/tools/bundle.lua"))("--lib")
--   local stats = bundler.build({ output = "basalt.min.lua", minify = true })

local args = { ... }

----------------------------------------------------------------------------
-- Lua-aware comment stripping (strings and long brackets stay untouched)
----------------------------------------------------------------------------

local function stripComments(code)
    local out = {}
    local i, n = 1, #code
    while i <= n do
        local j = code:find("[\"'%[%-]", i)
        if not j then
            out[#out + 1] = code:sub(i)
            break
        end
        if j > i then
            out[#out + 1] = code:sub(i, j - 1)
        end
        i = j
        local c = code:sub(i, i)
        if c == '"' or c == "'" then
            local k = i + 1
            while k <= n do
                local ch = code:sub(k, k)
                if ch == "\\" then
                    k = k + 2
                elseif ch == c then
                    break
                else
                    k = k + 1
                end
            end
            out[#out + 1] = code:sub(i, k)
            i = k + 1
        elseif c == "[" then
            local eqs = code:match("^%[(=*)%[", i)
            if eqs then
                local _, closeEnd = code:find("]" .. eqs .. "]",
                    i + 2 + #eqs, true)
                closeEnd = closeEnd or n
                out[#out + 1] = code:sub(i, closeEnd)
                i = closeEnd + 1
            else
                out[#out + 1] = c
                i = i + 1
            end
        else -- "-"
            if code:sub(i, i + 1) == "--" then
                local eqs = code:match("^%-%-%[(=*)%[", i)
                if eqs then -- block comment
                    local _, closeEnd = code:find("]" .. eqs .. "]",
                        i + 4 + #eqs, true)
                    i = (closeEnd or n) + 1
                else -- line comment: keep the newline
                    i = code:find("\n", i, true) or (n + 1)
                end
            else
                out[#out + 1] = c
                i = i + 1
            end
        end
    end
    local result = table.concat(out)
    result = result:gsub("[ \t]+\n", "\n"):gsub("\n\n+", "\n")
    return result
end

----------------------------------------------------------------------------
-- build
----------------------------------------------------------------------------

local function defaultRoot()
    local root = shell
        and fs.getDir(fs.getDir(shell.getRunningProgram()))
        or "basalt"
    if not fs.exists(fs.combine(root, "src/main.lua")) then
        root = "basalt" -- fallback when loaded outside the repository root
    end
    return root
end

local function collect(srcDir)
    local names = { "main" }
    for _, folder in ipairs({ "core", "elements", "modules" }) do
        local path = fs.combine(srcDir, folder)
        if fs.exists(path) then
            local entries = fs.list(path)
            table.sort(entries)
            for _, file in ipairs(entries) do
                local moduleName = file:match("^(.+)%.lua$")
                if moduleName then
                    names[#names + 1] = folder .. "/" .. moduleName
                end
            end
        end
    end
    return names
end

local function readSource(srcDir, moduleName)
    local handle = fs.open(fs.combine(srcDir, moduleName .. ".lua"), "r")
    if not handle then
        error("bundle: cannot read " .. moduleName .. ".lua from " .. srcDir, 0)
    end
    local content = handle.readAll()
    handle.close()
    return content
end

--- Picks a long-bracket level that cannot occur inside the content.
local function bracketFor(content)
    local level = 1
    while content:find("]" .. string.rep("=", level) .. "]", 1, true) do
        level = level + 1
    end
    return string.rep("=", level)
end

----------------------------------------------------------------------------
-- Bundle compression
----------------------------------------------------------------------------

-- A small LZSS-style compressor. Matches use three bytes:
-- two bytes distance and one byte length (4-259 bytes).
local function compressPayload(input)
    local output = {}
    local positions = {}
    local position, length = 1, #input
    local lastYield = 0

    local function remember(at)
        if at + 2 > length then return end
        local key = input:sub(at, at + 2)
        local list = positions[key]
        if not list then
            list = {}
            positions[key] = list
        end
        list[#list + 1] = at
        if #list > 32 then table.remove(list, 1) end
    end

    while position <= length do
        local controlIndex = #output + 1
        output[controlIndex] = "\0"
        local control = 0

        for bit = 0, 7 do
            if position > length then break end

            local bestDistance, bestLength
            if position + 3 <= length then
                local candidates = positions[input:sub(position, position + 2)]
                if candidates then
                    local maximum = math.min(259, length - position + 1)
                    for index = #candidates, 1, -1 do
                        local previous = candidates[index]
                        local distance = position - previous
                        if distance <= 65535 then
                            local matched = 3
                            while matched < maximum
                                and input:byte(previous + matched)
                                    == input:byte(position + matched) do
                                matched = matched + 1
                            end
                            if matched >= 4
                                and (not bestLength or matched > bestLength) then
                                bestDistance, bestLength = distance, matched
                                if matched == maximum then break end
                            end
                        end
                    end
                end
            end

            local consumed
            if bestLength then
                control = control + 2 ^ bit
                output[#output + 1] = string.char(
                    math.floor(bestDistance / 256),
                    bestDistance % 256,
                    bestLength - 4
                )
                consumed = bestLength
            else
                output[#output + 1] = input:sub(position, position)
                consumed = 1
            end

            for offset = 0, consumed - 1 do
                remember(position + offset)
            end
            position = position + consumed
        end

        output[controlIndex] = string.char(control)
        if position - lastYield >= 4096 and sleep then
            sleep(0)
            lastYield = position
        end
    end

    return table.concat(output)
end

-- ASCII85 keeps the generated Lua file text-only while adding only 25%
-- encoding overhead to the compressed binary payload.
local function encodePayload(input)
    local alphabet = {}
    for byte = 33, 117 do
        alphabet[#alphabet + 1] = string.char(byte)
    end
    alphabet = table.concat(alphabet)

    local output = {}
    for position = 1, #input, 4 do
        local a, b, c, d = input:byte(position, position + 3)
        local value = (a or 0) * 16777216
            + (b or 0) * 65536
            + (c or 0) * 256
            + (d or 0)
        local block = {}
        for index = 5, 1, -1 do
            local digit = value % 85
            block[index] = alphabet:sub(digit + 1, digit + 1)
            value = math.floor(value / 85)
        end
        output[#output + 1] = table.concat(block)
    end
    return table.concat(output)
end

--- Builds a single-file bundle.
--- options: root, output, minify (default true), compress (default false).
--- Returns stats: { output, files, bytesIn, bytesOut, version }.
local function build(options)
    options = options or {}
    local root = options.root or defaultRoot()
    local srcDir = fs.combine(root, "src")
    local compress = options.compress == true
    local minify = compress or options.minify ~= false
    local output = options.output or fs.combine(root,
        compress and "bundle/basalt.compressed.lua"
            or (minify and "bundle/basalt.min.lua" or "bundle/basalt.lua"))
    local minifySource
    if minify then
        local minifierPath = fs.combine(root, "tools/minify.lua")
        -- The legacy minifier declares several helpers globally. Keep each
        -- build isolated so consecutive bundle variants cannot affect one
        -- another inside the same CraftOS process.
        local minifierEnv = setmetatable({}, { __index = _ENV })
        local loader, loadError = loadfile(minifierPath, nil, minifierEnv)
        if not loader then
            error("bundler: cannot load minifier: "
                .. tostring(loadError), 0)
        end
        minifySource = loader()
        if type(minifySource) ~= "function" then
            error("bundler: invalid minifier API from " .. minifierPath, 0)
        end
    end

    local names = collect(srcDir)
    local version = readSource(srcDir, "main")
        :match('VERSION%s*=%s*"([^"]+)"') or "?"

    local processed = {}
    local bytesIn, bytesOut = 0, 0
    for _, moduleName in ipairs(names) do
        local content = readSource(srcDir, moduleName)
        bytesIn = bytesIn + #content
        if minify then
            local ok, result = minifySource(content)
            if not ok then
                error("bundler: cannot minify " .. moduleName .. ": "
                    .. tostring(result), 0)
            end
            content = result
        else
            content = stripComments(content)
        end
        bytesOut = bytesOut + #content
        processed[#processed + 1] = {
            name = moduleName,
            content = content,
        }
    end

    local out = {}
    local compressedBytes
    if compress then
        out[#out + 1] = 'print("Decompressing basalt...")'
        local payload, manifestNames, manifestSizes = {}, {}, {}
        for _, module in ipairs(processed) do
            payload[#payload + 1] = module.content
            manifestNames[#manifestNames + 1] = module.name
            manifestSizes[#manifestSizes + 1] = tostring(#module.content)
        end

        local compressed = compressPayload(table.concat(payload))
        local encoded = encodePayload(compressed)
        compressedBytes = #compressed
        local payloadBrackets = bracketFor(encoded)
        local names = table.concat(manifestNames, "\n")
        local namesBrackets = bracketFor(names)

        out[#out + 1] = [[local function decode85(source, length)
    local output = {}
    for position = 1, #source, 5 do
        local value = 0
        for offset = 0, 4 do
            value = value * 85 + source:byte(position + offset) - 33
        end
        output[#output + 1] = string.char(
            math.floor(value / 16777216) % 256,
            math.floor(value / 65536) % 256,
            math.floor(value / 256) % 256,
            value % 256
        )
    end
    return table.concat(output):sub(1, length)
end
local function decompress(source)
    local output = {}
    local position = 1
    while position <= #source do
        local control = source:byte(position)
        position = position + 1
        for _ = 1, 8 do
            if position > #source then break end
            if control % 2 == 1 then
                local distance = source:byte(position) * 256
                    + source:byte(position + 1)
                local length = source:byte(position + 2) + 4
                position = position + 3
                for _ = 1, length do
                    output[#output + 1] =
                        output[#output - distance + 1]
                end
            else
                output[#output + 1] = source:sub(position, position)
                position = position + 1
            end
            control = math.floor(control / 2)
        end
    end
    return table.concat(output)
end]]
        out[#out + 1] = ("local payload = decompress(decode85([%s[%s]%s], %d))")
            :format(payloadBrackets, encoded, payloadBrackets, #compressed)
        out[#out + 1] = "local sources = {}"
        out[#out + 1] = "local sizes = {"
            .. table.concat(manifestSizes, ",") .. "}"
        out[#out + 1] = ("local names = [%s[%s]%s]")
            :format(namesBrackets, names, namesBrackets)
        out[#out + 1] = [[local index, offset = 1, 1
for name in names:gmatch("[^\n]+") do
    local size = sizes[index]
    sources[name] = payload:sub(offset, offset + size - 1)
    index, offset = index + 1, offset + size
end]]
    else
        out[#out + 1] = "local sources = {}"
        for _, module in ipairs(processed) do
            local content = module.content
            if content:sub(-1) ~= "\n" then
                content = content .. "\n"
            end
            local eqs = bracketFor(content)
            out[#out + 1] = ("sources[%q] = [%s[\n%s]%s]")
                :format(module.name, eqs, content, eqs)
        end
    end

    out[#out + 1] = [[
local loaded = {}
local function loader(name)
    local cached = loaded[name]
    if cached ~= nil then return cached end
]]
    if compress then
        out[#out + 1] = '    print("Loading module: " .. name)'
    end
    out[#out + 1] = [[
    local source = sources[name]
        or error("Basalt: module not bundled: " .. tostring(name), 0)
    local chunk = assert(load(source, "@basalt/" .. name .. ".lua"))
    local result = chunk(loader, "basalt")
    loaded[name] = result == nil and true or result
    return loaded[name]
end
return loader("main")]]

    local generated = table.concat(out, "\n")
    local handle = fs.open(output, "w")
    if not handle then
        error("bundle: cannot write " .. output, 0)
    end
    handle.write(generated)
    handle.close()

    return {
        output = output,
        files = #names,
        bytesIn = bytesIn,
        bytesOut = #generated,
        processedBytes = bytesOut,
        compressedBytes = compressedBytes,
        version = version,
        minified = minify,
        compressed = compress,
        commentsRemoved = true,
    }
end

----------------------------------------------------------------------------
-- CLI / library entry
----------------------------------------------------------------------------

local api = {
    build = build,
    collect = collect,
    stripComments = stripComments,
    defaultRoot = defaultRoot,
}

local output = nil
local minify = true
local compress = false
for _, arg in ipairs(args) do
    if arg == "--lib" then
        return api -- library mode: hand the API to the caller (installer)
    elseif arg == "--no-minify" then
        minify = false
        compress = false
    elseif arg == "--compress" then
        minify = true
        compress = true
    elseif arg:sub(1, 2) ~= "--" then
        output = arg
    end
end

local stats = build({
    output = output,
    minify = minify,
    compress = compress,
})
print(("Basalt %s bundled: %d files -> %s"):format(
    stats.version, stats.files, stats.output))
print(("%d KB -> %d KB%s"):format(
    math.floor(stats.bytesIn / 1024 + 0.5),
    math.floor(stats.bytesOut / 1024 + 0.5),
    stats.compressed and " (minified + compressed)"
        or (stats.minified and " (minified)" or " (comments stripped)")))

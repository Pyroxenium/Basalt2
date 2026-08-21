-- Basalt bundler tool (not part of the framework itself).
--
-- Packs everything under src/ into one release file that behaves exactly
-- like require("Basalt"): every source file is embedded as a string and
-- compiled on first require with its own chunk name, so error tracebacks
-- still show "basalt/core/render.lua:123" instead of bundle offsets.
--
-- CLI usage (from the repository root):
--   bundle                      -> writes bundle/basalt.lua, comments removed
--   bundle myout.lua            -> custom output path
--
-- Library usage (e.g. from the installer):
--   local bundler = assert(loadfile("Basalt/tools/bundle.lua"))("--lib")
--   local stats = bundler.build({ output = "basalt.lua" })

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
    local names = { "main", "flimg" }
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

--- Builds a single-file bundle.
--- options: root, output.
--- Returns stats: { output, files, bytesIn, bytesOut, version }.
local function build(options)
    options = options or {}
    if options.minify == true or options.compress == true then
        error(
            "bundle: optimization is provided by Shale; "
                .. "build src/Shalefile.lua instead",
            0
        )
    end
    local root = options.root or defaultRoot()
    local srcDir = fs.combine(root, "src")
    local output = options.output
        or fs.combine(root, "bundle/basalt.lua")

    local names = collect(srcDir)
    local version = readSource(srcDir, "main")
        :match('VERSION%s*=%s*"([^"]+)"') or "?"

    local processed = {}
    local bytesIn, bytesOut = 0, 0
    for _, moduleName in ipairs(names) do
        local content = readSource(srcDir, moduleName)
        bytesIn = bytesIn + #content
        content = stripComments(content)
        bytesOut = bytesOut + #content
        processed[#processed + 1] = {
            name = moduleName,
            content = content,
        }
    end

    local out = { "local sources = {}" }
    for _, module in ipairs(processed) do
        local content = module.content
        if content:sub(-1) ~= "\n" then
            content = content .. "\n"
        end
        local eqs = bracketFor(content)
        out[#out + 1] = ("sources[%q] = [%s[\n%s]%s]")
            :format(module.name, eqs, content, eqs)
    end

    out[#out + 1] = [[
local loaded = {}
local function loader(name)
    local cached = loaded[name]
    if cached ~= nil then return cached end
]]
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
        version = version,
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
for _, arg in ipairs(args) do
    if arg == "--lib" then
        return api -- library mode: hand the API to the caller (installer)
    elseif arg == "--no-minify" then
        -- Retained as a no-op for compatibility with older build commands.
    elseif arg == "--compress" then
        error(
            "bundle: minification and compression were replaced by Shale "
                .. "(see src/Shalefile.lua)",
            0
        )
    elseif arg:sub(1, 2) ~= "--" then
        output = arg
    end
end

local stats = build({
    output = output,
})
print(("Basalt %s bundled: %d files -> %s"):format(
    stats.version, stats.files, stats.output))
print(("%d KB -> %d KB (comments stripped)"):format(
    math.floor(stats.bytesIn / 1024 + 0.5),
    math.floor(stats.bytesOut / 1024 + 0.5)))

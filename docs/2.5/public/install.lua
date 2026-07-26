-- Basalt 2.5 web installer.
--
-- GUI: installer
-- CLI: installer <source|bundled|minified|compressed> [target]
--      installer --url <repository-base-url> <variant> [target]
--      installer --help

local args = { ... }

local REPO_URL =
    "https://raw.githubusercontent.com/Pyroxenium/Basalt2/refs/heads/basalt2.5/"
local BUNDLE_PATHS = {
    bundled = "bundle/basalt.lua",
    minified = "bundle/basalt.min.lua",
    compressed = "bundle/basalt.compressed.lua",
}
local VARIANTS = { "source", "bundled", "minified", "compressed" }
local VARIANT_LOOKUP = {
    source = true,
    bundled = true,
    minified = true,
    compressed = true,
}
local DEFAULT_VARIANT = "minified"
local DEFAULT_TARGETS = {
    source = "basalt",
    bundled = "basalt.lua",
    minified = "basalt.lua",
    compressed = "basalt.lua",
}
local function withTrailingSlash(url)
    return url:sub(-1) == "/" and url or (url .. "/")
end

local function bundleUrl(variant, baseUrl)
    return withTrailingSlash(baseUrl or REPO_URL) .. BUNDLE_PATHS[variant]
end

local function ensureParent(path)
    local parent = fs.getDir(path)
    if parent ~= "" and not fs.exists(parent) then
        fs.makeDir(parent)
    end
end

local function removeIfPresent(path)
    if fs.exists(path) then fs.delete(path) end
end

local function requireHttp()
    if not http then
        error("installer: the HTTP API is disabled. Enable it in the "
            .. "CC:Tweaked configuration.", 0)
    end
end

local function fetch(url)
    requireHttp()
    local response, requestError = http.get(url)
    if not response then
        error("installer: download failed: " .. url
            .. " (" .. tostring(requestError) .. ")", 0)
    end

    if response.getResponseCode then
        local code, message = response.getResponseCode()
        if code < 200 or code >= 300 then
            response.close()
            error(("installer: HTTP %d %s: %s")
                :format(code, tostring(message or ""), url), 0)
        end
    end

    local content = response.readAll()
    response.close()
    return content
end

local function writeFile(path, content)
    ensureParent(path)
    local handle = fs.open(path, "w")
    if not handle then
        error("installer: cannot write " .. path, 0)
    end
    handle.write(content)
    handle.close()
end

local function writeAtomic(target, content)
    if fs.exists(target) then
        error("installer: target already exists: " .. target, 0)
    end

    local temporary = target .. ".part"
    removeIfPresent(temporary)
    local ok, writeError = pcall(writeFile, temporary, content)
    if not ok then
        removeIfPresent(temporary)
        error(writeError, 0)
    end

    ensureParent(target)
    fs.move(temporary, target)
end

local function parseManifest(content)
    local files = {}
    for path in (content .. "\n"):gmatch("(.-)\n") do
        path = path:gsub("\r", ""):gsub("%s+$", "")
        local relative = path:match("^src/(.+)$")
        if relative then files[#files + 1] = relative end
    end
    if #files == 0 then
        error("installer: the source manifest is empty", 0)
    end
    return files
end

local function installSource(baseUrl, target, progress)
    if fs.exists(target) then
        error("installer: target already exists: " .. target, 0)
    end

    baseUrl = withTrailingSlash(baseUrl or REPO_URL)
    local temporary = target .. ".part"
    removeIfPresent(temporary)
    ensureParent(target)
    fs.makeDir(temporary)

    local ok, result = pcall(function()
        progress(0, 1, "Downloading source manifest...")
        local files = parseManifest(fetch(baseUrl .. "manifest.txt"))

        for index, relative in ipairs(files) do
            progress(index, #files, relative)
            writeFile(fs.combine(temporary, relative),
                fetch(baseUrl .. "src/" .. relative))
        end
        return #files
    end)

    if not ok then
        removeIfPresent(temporary)
        error(result, 0)
    end

    local moved, moveError = pcall(fs.move, temporary, target)
    if not moved then
        removeIfPresent(temporary)
        error(moveError, 0)
    end
    return ("Installed %d source files -> %s/"):format(result, target)
end

local function installBundle(variant, baseUrl, target, progress)
    progress(0, 1, "Downloading " .. variant .. " bundle...")
    local content = fetch(bundleUrl(variant, baseUrl))
    writeAtomic(target, content)
    progress(1, 1, "Done")
    return ("Downloaded %s bundle -> %s (%d KB)")
        :format(variant, target, math.floor(#content / 1024 + 0.5))
end

local function installVariant(variant, target, progress, baseUrl)
    progress = progress or function() end
    if variant == "source" then
        return installSource(baseUrl, target, progress)
    end
    return installBundle(variant, baseUrl, target, progress)
end

local function loadBasalt(baseUrl)
    print("Downloading Basalt...")
    local source = fetch(bundleUrl("bundled", baseUrl))
    local chunk, loadError = load(source, "@basalt.lua", "t", _ENV)
    if not chunk then error("installer: " .. tostring(loadError), 0) end
    return chunk()
end

local function printHelp()
    print("Basalt 2.5 installer")
    print("")
    print("Usage:")
    print("  installer")
    print("  installer <variant> [target]")
    print("  installer --url <base-url> <variant> [target]")
    print("")
    print("Variants:")
    print("  source      Editable source folder")
    print("  bundled     Readable single file")
    print("  minified    Smaller single file (recommended)")
    print("  compressed  Smallest file, slower initial startup")
end

local function parseArguments()
    local variant, target, baseUrl
    local index = 1
    while index <= #args do
        local argument = args[index]
        if argument == "-h" or argument == "--help" then
            return nil, nil, nil, true
        elseif argument == "--url" then
            index = index + 1
            baseUrl = args[index]
            if not baseUrl or baseUrl == "" then
                error("installer: --url requires a base URL", 0)
            end
        elseif VARIANT_LOOKUP[argument] then
            if variant then
                error("installer: multiple variants specified", 0)
            end
            variant = argument
        elseif argument:sub(1, 1) == "-" then
            error("installer: unknown option " .. argument, 0)
        elseif not target then
            target = argument
        else
            error("installer: unexpected argument " .. argument, 0)
        end
        index = index + 1
    end

    if target and not variant then
        error("installer: specify a variant before the target", 0)
    end
    return variant, target, baseUrl, false
end

local function runGui(baseUrl)
    local basalt = loadBasalt(baseUrl)
    basalt.use("bigfont")

    local palette = basalt.use("theme").applyPreset("basalt")
    local background = palette.bg
    local accent = palette.lava
    local main = basalt.getMainFrame()
    local width, height = main:getSize()
    local contentWidth = math.max(20, width - 4)

    main:addBigFont({
        x = 2, y = 2, text = "Basalt",
        foreground = accent, background = background,
    })

    local variantList = main:addList({
        x = 2, y = 6, width = contentWidth, height = 4,
        items = {
            "Source",
            "Bundled",
            "Minified (recommended)",
            "Compressed",
        },
        background = background,
    })

    local descriptions = {
        "Editable folder containing the original source files.",
        "Readable single file without source comments.",
        "Smaller single file with immediate startup.",
        "Smallest download, but takes a few seconds to decompress.",
    }
    local description = main:addLabel({
        x = 2, y = 10, width = contentWidth, height = 2,
        text = descriptions[3],
        foreground = palette.muted,
    })

    main:addLabel({ x = 2, y = 13, text = "Target:" })
    local targetInput = main:addInput({
        x = 10, y = 13, width = math.max(12, width - 12),
        placeholder = DEFAULT_TARGETS[DEFAULT_VARIANT],
        background = background,
    })

    variantList:onSelect(function(_, index)
        description.text = descriptions[index]
        targetInput.placeholder = DEFAULT_TARGETS[VARIANTS[index]]
    end)
    variantList:select(3, false)

    local status = main:addLabel({
        x = 2, y = math.max(16, height - 3),
        width = contentWidth, height = 2,
        text = "Choose a variant and press Install.",
        foreground = palette.muted,
    })
    local progressBar = main:addProgressBar({
        x = 2, y = height - 1, width = contentWidth,
        barColor = accent,
    })

    local installing = false
    local installButton = main:addButton({
        x = 2, y = 15, width = 11, height = 1,
        text = "Install", background = accent,
        foreground = background,
    })

    installButton:onClick(function()
        if installing then return end
        installing = true
        installButton.text = "Working..."
        status.foreground = palette.text
        progressBar.progress = 0

        local selectedIndex = variantList.selected or 3
        local variant = VARIANTS[selectedIndex]
        local target = #targetInput.text > 0
            and targetInput.text or DEFAULT_TARGETS[variant]

        local ok, result = pcall(installVariant, variant, target,
            function(done, total, label)
                progressBar.progress =
                    math.floor(done / math.max(1, total) * 100)
                status.text = tostring(label or "")
                basalt.update()
            end, baseUrl)

        if ok then
            status.text = result
            status.foreground = palette.success
            progressBar.progress = 100
        else
            status.text = tostring(result)
            status.foreground = palette.danger
        end
        installButton.text = "Install"
        installing = false
    end)

    main:addButton({
        x = 15, y = 15, width = 8, height = 1, text = "Exit",
    }):onClick(function()
        basalt.stop()
    end)

    basalt.run()
end

local variant, target, baseUrl, help = parseArguments()
if help then
    return printHelp()
end
if not variant then
    return runGui(baseUrl)
end

target = target or DEFAULT_TARGETS[variant]
local summary = installVariant(variant, target, function(done, total, label)
    if label then
        print(("[%d/%d] %s"):format(done, total, label))
    end
end, baseUrl)
print(summary)
print(("Use it with: local basalt = require(%q)")
    :format(target:gsub("%.lua$", "")))

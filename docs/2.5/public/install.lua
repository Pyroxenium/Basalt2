-- Basalt installer (a tool, not part of the framework).
--
-- Without arguments it starts a GUI wizard: like Basalt2's installer it
-- bootstraps Basalt itself first (from the local repository, or by
-- downloading bundle/basalt.lua via http and load()ing it in-memory) and
-- renders the wizard with it.
--
-- Non-interactive:  installer <source|bundled|minified> [target]
--                   installer --make-manifest
--                   installer --url <base>   (remote repository base URL)
--
-- Variants:
--   source    editable folder with src/ and the loader shim (default: basalt)
--   bundled   single file, readable sources               (default: basalt.lua)
--   minified  single file, comments stripped              (default: basalt.lua)

local args = { ... }

-- Basalt ships as its own branch of the Basalt2 repository.
-- Adjust BRANCH if the published branch ends up with a different name.
local BRANCH = "basalt2.5"
local REPO_URL = "https://raw.githubusercontent.com/Pyroxenium/Basalt2/refs/heads/"
    .. BRANCH .. "/"
local BUNDLE_URL = REPO_URL .. "bundle/basalt.lua"

local TMP_DIR = "/.basalt3_installer_tmp"

----------------------------------------------------------------------------
-- repository discovery
----------------------------------------------------------------------------

local function repoRoot()
    local root = shell and fs.getDir(shell.getRunningProgram()) or "Basalt3"
    if not fs.exists(fs.combine(root, "src/main.lua")) then
        root = "Basalt3"
    end
    return root
end

local function isLocalRepo(root)
    return fs.exists(fs.combine(root, "src/main.lua"))
end

----------------------------------------------------------------------------
-- manifest
----------------------------------------------------------------------------

local function walk(dir, prefix, out)
    local entries = fs.list(dir)
    table.sort(entries)
    for _, entry in ipairs(entries) do
        local full = fs.combine(dir, entry)
        if fs.isDir(full) then
            walk(full, prefix .. entry .. "/", out)
        else
            out[#out + 1] = prefix .. entry
        end
    end
end

--- Everything a remote source install needs: shim, bundler and src/.
local function manifestFiles(root)
    local files = { "init.lua", "bundle.lua" }
    walk(fs.combine(root, "src"), "src/", files)
    return files
end

local function writeManifest(root)
    local files = manifestFiles(root)
    local handle = fs.open(fs.combine(root, "manifest.txt"), "w")
    handle.write(table.concat(files, "\n"))
    handle.close()
    return #files
end

----------------------------------------------------------------------------
-- download helpers
----------------------------------------------------------------------------

local function requireHttp()
    if not http then
        error("installer: the http API is disabled "
            .. "(enable it in the ComputerCraft config)", 0)
    end
end

local function fetch(url)
    local response, err = http.get(url)
    if not response then
        error("installer: download failed: " .. url
            .. " (" .. tostring(err) .. ")", 0)
    end
    local content = response.readAll()
    response.close()
    return content
end

--- Downloads manifest + files into TMP_DIR; returns it as install root.
local function downloadRepo(baseUrl, progress)
    requireHttp()
    if fs.exists(TMP_DIR) then fs.delete(TMP_DIR) end

    progress(0, 1, "Downloading manifest...")
    local manifest = fetch(baseUrl .. "manifest.txt")
    local files = {}
    for line in (manifest .. "\n"):gmatch("(.-)\n") do
        line = line:gsub("%s+$", "")
        if #line > 0 then files[#files + 1] = line end
    end

    for index, path in ipairs(files) do
        progress(index, #files, path)
        local handle = fs.open(fs.combine(TMP_DIR, path), "w")
        handle.write(fetch(baseUrl .. path))
        handle.close()
    end
    return TMP_DIR
end

----------------------------------------------------------------------------
-- install variants
----------------------------------------------------------------------------

local function copyFile(from, to)
    local input = fs.open(from, "r")
    local content = input.readAll()
    input.close()
    local outputHandle = fs.open(to, "w")
    outputHandle.write(content)
    outputHandle.close()
end

local function installSource(fromRoot, target, progress)
    if fs.exists(target) then
        error("installer: target already exists: " .. target, 0)
    end
    local files = { "init.lua" }
    walk(fs.combine(fromRoot, "src"), "src/", files)
    for index, path in ipairs(files) do
        progress(index, #files, path)
        copyFile(fs.combine(fromRoot, path), fs.combine(target, path))
    end
    return ("Installed %d files -> %s/"):format(#files, target)
end

local function installBundle(fromRoot, target, minify, progress)
    progress(0, 1, "Bundling src/ ...")
    local bundlerPath = fs.combine(fromRoot, "bundle.lua")
    local bundler = assert(loadfile(bundlerPath, nil, _ENV))("--lib")
    local stats = bundler.build({
        root = fromRoot, output = target, minify = minify,
    })
    progress(1, 1, "Done")
    return ("Basalt %s -> %s (%d KB)"):format(stats.version, target,
        math.floor(stats.bytesOut / 1024 + 0.5))
end

--- Installs a variant from the local repository or (via manifest/bundle
--- download) from the remote one. progress(done, total, label) is optional.
local function installVariant(variant, target, progress, urlOverride)
    progress = progress or function() end
    local root = repoRoot()
    local downloaded = false

    if not isLocalRepo(root) then
        if variant == "source" then
            local baseUrl = urlOverride or REPO_URL
            if not baseUrl then
                error("installer: no local src/ and no repository URL "
                    .. "configured (set REPO_URL or pass --url <base>)", 0)
            end
            root = downloadRepo(baseUrl, progress)
            downloaded = true
        else
            -- bundled/minified: grab the prebuilt release directly
            requireHttp()
            progress(0, 1, "Downloading bundle...")
            local handle = fs.open(target, "w")
            handle.write(fetch(BUNDLE_URL))
            handle.close()
            progress(1, 1, "Done")
            return "Downloaded bundle -> " .. target
        end
    end

    local summary
    if variant == "source" then
        summary = installSource(root, target, progress)
    else
        summary = installBundle(root, target, variant == "minified", progress)
    end

    if downloaded then
        fs.delete(TMP_DIR)
    end
    return summary
end

----------------------------------------------------------------------------
-- GUI wizard (bootstraps Basalt itself, Basalt2-installer style)
----------------------------------------------------------------------------

local function getBasalt(root)
    if isLocalRepo(root) then
        local initPath = fs.combine(root, "init.lua")
        return assert(loadfile(initPath, nil, _ENV))("basalt3", initPath)
    end
    requireHttp()
    print("Downloading Basalt bundle...")
    return assert(load(fetch(BUNDLE_URL), "@basalt3-bundle", nil, _ENV))()
end

local VARIANTS = { "source", "bundled", "minified" }
local DEFAULT_TARGETS = {
    source = "basalt",
    bundled = "basalt.lua",
    minified = "basalt.lua",
}

local function runGui(urlOverride)
    local bas = getBasalt(repoRoot())
    bas.use("bigfont")

    -- Basalt's signature look: volcanic stone + lava accent
    local pal = bas.use("theme").applyPreset("basalt")
    local dark = pal.bg
    local accent = pal.lava
    local main = bas.getMainFrame()

    main:addBigFont({
        x = 2, y = 2, text = "Basalt",
        foreground = accent, background = dark,
    })

    local variantList = main:addList({
        x = 2, y = 6, width = 36, height = 3,
        items = {
            "source   - editable src/ folder",
            "bundled  - single file",
            "minified - single file, stripped",
        },
        background = dark,
    })

    main:addLabel({ x = 2, y = 10, text = "Ziel:" })
    local targetInput = main:addInput({
        x = 8, y = 10, width = 28,
        placeholder = DEFAULT_TARGETS.minified,
    })
    variantList:onSelect(function(_, index)
        targetInput.placeholder = DEFAULT_TARGETS[VARIANTS[index]]
    end)
    variantList:select(3, false)

    local status = main:addLabel({
        x = 2, y = 14, width = 47, height = 1,
        text = "Variante waehlen, Ziel optional anpassen.",
        foreground = pal.muted,
    })
    local progressBar = main:addProgressBar({
        x = 2, y = 16, width = 47, barColor = accent,
    })

    main:addButton({
        x = 2, y = 12, width = 11, height = 1,
        text = "Install", background = accent,
        foreground = dark,
    }):onClick(function()
        local variant = VARIANTS[variantList.selected or 3]
        local target = #targetInput.text > 0
            and targetInput.text or DEFAULT_TARGETS[variant]
        status.foreground = pal.text
        progressBar.progress = 0

        local ok, result = pcall(installVariant, variant, target,
            function(done, total, label)
                progressBar.progress =
                    math.floor(done / math.max(1, total) * 100)
                status.text = tostring(label or "")
                bas.update() -- repaint while the handler is still running
            end, urlOverride)

        if ok then
            status.text = result
            status.foreground = pal.success
            progressBar.progress = 100
        else
            status.text = tostring(result)
            status.foreground = pal.danger
        end
    end)

    main:addButton({
        x = 15, y = 12, width = 8, height = 1, text = "Exit",
    }):onClick(function()
        bas.stop()
    end)

    bas.run()
end

----------------------------------------------------------------------------
-- entry point
----------------------------------------------------------------------------

local variant, target, urlOverride
do
    local i = 1
    while i <= #args do
        local arg = args[i]
        if arg == "--make-manifest" then
            local count = writeManifest(repoRoot())
            print(("manifest.txt written (%d files)"):format(count))
            return
        elseif arg == "--url" then
            i = i + 1
            urlOverride = args[i]
        elseif arg == "source" or arg == "bundled" or arg == "minified" then
            variant = arg
        elseif arg:sub(1, 2) ~= "--" then
            target = arg
        end
        i = i + 1
    end
end

if not variant then
    return runGui(urlOverride)
end

target = target or DEFAULT_TARGETS[variant]
local summary = installVariant(variant, target, function(done, total, label)
    if label then
        print(("[%d/%d] %s"):format(done, total, label))
    end
end, urlOverride)
print(summary)
print(("Use it with: local basalt = require(%q)")
    :format((target:gsub("%.lua$", ""))))

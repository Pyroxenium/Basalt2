local sources = {}
sources["main"] = [=[
local require = ...
if type(require) ~= "function" then
    local name, path = ...
    local initPath = fs.combine(fs.getDir(path or "basalt/main.lua"), "init.lua")
    return assert(loadfile(initPath, nil, _ENV))(name, initPath)
end
local errors = require("core/errors")
local palette = require("core/palette")
local state = require("core/state")
local layout = require("core/layout")
local Container = require("core/container")
local BaseFrame = require("core/baseframe")
Container.register("Label", require("elements/Label"))
Container.register("Canvas", require("elements/Canvas"))
Container.register("Button", require("elements/Button"))
Container.register("Frame", require("elements/Frame"))
Container.register("Input", require("elements/Input"))
Container.register("Checkbox", require("elements/Checkbox"))
Container.register("Switch", require("elements/Switch"))
Container.register("ProgressBar", require("elements/ProgressBar"))
Container.register("Slider", require("elements/Slider"))
Container.register("Collection", require("elements/Collection"))
Container.register("List", require("elements/List"))
Container.register("Dropdown", require("elements/Dropdown"))
Container.register("Flex", require("elements/Flex"))
Container.register("Row", require("elements/Row"))
Container.register("Column", require("elements/Column"))
Container.register("TextBox", require("elements/TextBox"))
Container.register("Menu", require("elements/Menu"))
Container.register("TabControl", require("elements/TabControl"))
Container.register("Tree", require("elements/Tree"))
Container.register("Table", require("elements/Table"))
Container.register("Program", require("elements/Program"))
Container.register("ComboBox", require("elements/ComboBox"))
Container.register("ContextMenu", require("elements/ContextMenu"))
Container.register("Dialog", require("elements/Dialog"))
Container.register("Toast", require("elements/Toast"))
local basalt = {}
basalt.VERSION = "2.5.0-dev"
basalt.traceback = true
basalt.errors = errors
basalt.rgb = palette.rgb
basalt.state = state.create
basalt.signal = state.create
basalt.computed = state.computed
basalt.isState = state.is
basalt.auto = layout.auto
basalt.fill = layout.fill
basalt.percent = layout.percent
function basalt.use(moduleName)
    return require("modules/" .. moduleName)
end
local frames = {}
local mainFrame = nil
local running = false
local schedules = {}
function basalt.createFrame(t, monitorName)
    t = t or term.current()
    local f = BaseFrame.new()
    f:setTerm(t)
    if monitorName == nil and t.setTextScale and peripheral then
        local ok, name = pcall(peripheral.getName, t)
        if ok then monitorName = name end
    end
    rawset(f, "monitor", monitorName)
    frames[#frames + 1] = f
    if not mainFrame then mainFrame = f end
    return f
end
function basalt.getMainFrame()
    return mainFrame or basalt.createFrame()
end
function basalt.schedule(fn)
    local co = coroutine.create(fn)
    local ok, filter = coroutine.resume(co)
    if not ok then
        error(errors.wrap(filter, debug.traceback(co)), 0)
    end
    schedules[#schedules + 1] = { co = co, filter = filter }
    return co
end
local function resumeSchedules(event, ...)
    for i = #schedules, 1, -1 do
        local s = schedules[i]
        if coroutine.status(s.co) == "suspended"
            and (s.filter == nil or s.filter == event) then
            local ok, filter = coroutine.resume(s.co, event, ...)
            if not ok then
                error(errors.wrap(filter, debug.traceback(s.co)), 0)
            end
            s.filter = filter
        end
        if coroutine.status(s.co) == "dead" then
            table.remove(schedules, i)
        end
    end
end
local MOUSE = {
    mouse_click = true,
    mouse_up = true,
    mouse_drag = true,
    mouse_scroll = true,
    mouse_move = true,
}
local KEY = { key = true, key_up = true, char = true, paste = true }
local function dispatch(event, a, b, c, ...)
    if event == "mouse_move" and type(a) == "string" then
        for i = 1, #frames do
            local f = frames[i]
            if rawget(f, "monitor") == a then
                f:handleEvent(event, b, c)
            end
        end
    elseif MOUSE[event] or KEY[event] then
        if mainFrame then mainFrame:handleEvent(event, a, b, c, ...) end
    elseif event == "monitor_touch" or event == "monitor_resize" then
        for i = 1, #frames do
            local f = frames[i]
            if rawget(f, "monitor") == a then
                if event == "monitor_touch" then
                    f:handleEvent("mouse_click", 1, b, c)
                    f:handleEvent("mouse_up", 1, b, c)
                else
                    f:handleEvent("term_resize")
                end
            end
        end
    else
        for i = 1, #frames do
            frames[i]:handleEvent(event, a, b, c, ...)
        end
    end
    resumeSchedules(event, a, b, c, ...)
end
local function draw()
    for i = 1, #frames do
        frames[i]:draw()
    end
end
function basalt.update(event, ...)
    if event then dispatch(event, ...) end
    draw()
end
function basalt.stop()
    running = false
end
local function cleanup()
    for i = 1, #frames do
        frames[i]:cleanup()
    end
end
function basalt.run()
    if running then error("Basalt is already running", 2) end
    running = true
    local ok, err = xpcall(function()
        draw()
        while running do
            local ev = table.pack(os.pullEventRaw())
            if ev[1] == "terminate" then
                running = false
            else
                dispatch(table.unpack(ev, 1, ev.n))
                draw()
            end
        end
    end, function(e)
        if type(e) == "table" and e.__basaltError then return e end
        return errors.wrap(e, debug.traceback(nil, 2))
    end)
    running = false
    cleanup()
    if not ok then
        errors.show(err.err, err.trace, basalt.traceback)
    end
end
return basalt
]=]
sources["flimg"] = [=[

local flimg = {
    VERSION = 1,
    MAGIC = "FLMG",
    MODE_PIXEL = "pixel",
    MODE_CELL = "cell",
    ENCODING_RAW = 0,
    ENCODING_RLE = 1,
}
local char, byte, sub, rep = string.char, string.byte, string.sub, string.rep
local floor, min, max = math.floor, math.min, math.max
local MODE_TO_BYTE = { pixel = 1, cell = 2 }
local BYTE_TO_MODE = { [1] = "pixel", [2] = "cell" }
local NATIVE_RGB = {
    [0] = 0xF0F0F0, 0xF2B233, 0xE57FD8, 0x99B2F2,
    0xDEDE6C, 0x7FCC19, 0xF2B2CC, 0x4C4C4C,
    0x999999, 0x4C99B2, 0xB266E5, 0x3366CC,
    0x7F664C, 0x57A64E, 0xCC4C4C, 0x111111,
}
flimg.NATIVE_RGB = NATIVE_RGB
local function fail(message, level)
    error("FLIMG: " .. message, (level or 1) + 1)
end
local function integer(value, name, low, high)
    if type(value) ~= "number" or value ~= floor(value)
        or value < low or value > high then
        fail(name .. " must be an integer from " .. low .. " to " .. high, 2)
    end
    return value
end
local function u8(value)
    return char(value)
end
local function u16(value)
    return char(value % 256, floor(value / 256) % 256)
end
local function i16(value)
    if value < 0 then value = value + 65536 end
    return u16(value)
end
local function u32(value)
    return char(
        value % 256,
        floor(value / 256) % 256,
        floor(value / 65536) % 256,
        floor(value / 16777216) % 256)
end
local Reader = {}
Reader.__index = Reader
function Reader.new(data)
    return setmetatable({ data = data, pos = 1, size = #data }, Reader)
end
function Reader:take(length, label)
    if length < 0 or self.pos + length - 1 > self.size then
        fail("truncated " .. (label or "data") .. " at byte " .. self.pos, 2)
    end
    local result = sub(self.data, self.pos, self.pos + length - 1)
    self.pos = self.pos + length
    return result
end
function Reader:u8(label)
    local value = byte(self.data, self.pos)
    if value == nil then fail("truncated " .. (label or "u8"), 2) end
    self.pos = self.pos + 1
    return value
end
function Reader:u16(label)
    local a, b = byte(self:take(2, label), 1, 2)
    return a + b * 256
end
function Reader:i16(label)
    local value = self:u16(label)
    return value >= 32768 and value - 65536 or value
end
function Reader:u32(label)
    local a, b, c, d = byte(self:take(4, label), 1, 4)
    return a + b * 256 + c * 65536 + d * 16777216
end
local function hasFlag(value, flag)
    return value % (flag * 2) >= flag
end
local function parseRGB(value, label)
    if type(value) == "string" then
        local hex = value:gsub("#", "")
        if hex:match("^%x%x%x$") then
            hex = hex:sub(1, 1):rep(2)
                .. hex:sub(2, 2):rep(2)
                .. hex:sub(3, 3):rep(2)
        elseif hex:match("^%x%x%x%x%x%x%x%x$") then
            hex = hex:sub(3)
        end
        if not hex:match("^%x%x%x%x%x%x$") then
            fail((label or "color") .. " must be #RGB, #RRGGBB, #AARRGGBB, or 0xRRGGBB", 2)
        end
        value = tonumber(hex, 16)
    end
    return integer(value, label or "color", 0, 0xFFFFFF)
end
local function validatePaletteBytes(row, startIndex, label, paletteCount)
    local i, length = startIndex or 1, #row
    while i + 7 <= length do
        local a, b, c, d, e, f, g, h = byte(row, i, i + 7)
        local invalid = a > paletteCount and a or b > paletteCount and b
            or c > paletteCount and c or d > paletteCount and d
            or e > paletteCount and e or f > paletteCount and f
            or g > paletteCount and g or h > paletteCount and h
        if invalid then fail(label .. " references missing palette index " .. invalid, 2) end
        i = i + 8
    end
    while i <= length do
        local value = byte(row, i)
        if value > paletteCount then fail(label .. " references missing palette index " .. value, 2) end
        i = i + 1
    end
end
local function normalizePixelRow(row, width, label, paletteCount)
    if type(row) == "string" then
        if #row ~= width then fail(label .. " has width " .. #row .. ", expected " .. width, 2) end
        validatePaletteBytes(row, 1, label, paletteCount)
        return row
    end
    if type(row) ~= "table" or #row ~= width then
        fail(label .. " must be a byte string or an array of width " .. width, 2)
    end
    local out = {}
    for x = 1, width do
        local value = integer(row[x], label .. " pixel " .. x, 0, 255)
        if value > paletteCount then
            fail(label .. " pixel " .. x .. " references missing palette index " .. value, 2)
        end
        out[x] = char(value)
    end
    return table.concat(out)
end
local function normalizeCellRow(row, width, label, paletteCount)
    if type(row) ~= "table" then fail(label .. " must be {text, foreground, background}", 2) end
    local text, fg, bg = row[1] or row.text, row[2] or row.fg, row[3] or row.bg
    if type(text) ~= "string" or type(fg) ~= "string" or type(bg) ~= "string"
        or #text ~= width or #fg ~= width or #bg ~= width then
        fail(label .. " planes must be byte strings of width " .. width, 2)
    end
    validatePaletteBytes(fg, 1, label .. " foreground", paletteCount)
    validatePaletteBytes(bg, 1, label .. " background", paletteCount)
    return { text, fg, bg }
end
local function blankRows(mode, width, height)
    local rows = {}
    if mode == "pixel" then
        local blank = rep("\0", width)
        for y = 1, height do rows[y] = blank end
    else
        local blank = rep("\0", width)
        for y = 1, height do rows[y] = { blank, blank, blank } end
    end
    return rows
end
local function cloneRows(mode, rows)
    local result = {}
    if mode == "pixel" then
        for y = 1, #rows do result[y] = rows[y] end
    else
        for y = 1, #rows do
            local row = rows[y]
            result[y] = { row[1], row[2], row[3] }
        end
    end
    return result
end
local function normalizeImage(source)
    if type(source) ~= "table" then fail("image must be a table", 2) end
    local mode = source.mode or "pixel"
    if not MODE_TO_BYTE[mode] then fail("mode must be 'pixel' or 'cell'", 2) end
    local width = integer(source.width, "width", 1, 65535)
    local height = integer(source.height, "height", 1, 65535)
    local palette = {}
    if type(source.palette) ~= "table" or #source.palette < 1 or #source.palette > 255 then
        fail("palette must contain 1 to 255 colors", 2)
    end
    for i = 1, #source.palette do palette[i] = parseRGB(source.palette[i], "palette color " .. i) end
    local sourceLayers = source.layers
    if type(sourceLayers) ~= "table" or #sourceLayers < 1 or #sourceLayers > 255 then
        fail("layers must contain 1 to 255 layer descriptors", 2)
    end
    local layers = {}
    for i = 1, #sourceLayers do
        local layer = sourceLayers[i]
        if type(layer) ~= "table" then fail("layer " .. i .. " must be a table", 2) end
        local name = layer.name or ("Layer " .. i)
        if type(name) ~= "string" or #name > 255 then fail("layer " .. i .. " name is too long", 2) end
        layers[i] = {
            name = name,
            x = integer(layer.x or 1, "layer " .. i .. " x", -32768, 32767),
            y = integer(layer.y or 1, "layer " .. i .. " y", -32768, 32767),
            width = integer(layer.width or width, "layer " .. i .. " width", 1, 65535),
            height = integer(layer.height or height, "layer " .. i .. " height", 1, 65535),
            z = integer(layer.z or i, "layer " .. i .. " z", -32768, 32767),
            visible = layer.visible ~= false,
        }
    end
    local sourceFrames = source.frames
    if type(sourceFrames) ~= "table" or #sourceFrames < 1 or #sourceFrames > 65535 then
        fail("frames must contain 1 to 65535 frames", 2)
    end
    local frames, previous = {}, {}
    for frameIndex = 1, #sourceFrames do
        local sourceFrame = sourceFrames[frameIndex]
        if type(sourceFrame) ~= "table" then fail("frame " .. frameIndex .. " must be a table", 2) end
        local sourceData = sourceFrame.layers or sourceFrame
        local frame = {
            duration = integer(sourceFrame.duration or source.defaultDuration or 100,
                "frame " .. frameIndex .. " duration", 1, 65535),
            layers = {},
        }
        for layerIndex = 1, #layers do
            local descriptor = layers[layerIndex]
            local layerData = sourceData[layerIndex]
            local rows
            if layerData == nil and previous[layerIndex] ~= nil then
                rows = cloneRows(mode, previous[layerIndex])
            elseif layerData == nil then
                rows = blankRows(mode, descriptor.width, descriptor.height)
            else
                rows = layerData.rows or layerData
                if type(rows) ~= "table" or #rows ~= descriptor.height then
                    fail("frame " .. frameIndex .. " layer " .. layerIndex
                        .. " must have " .. descriptor.height .. " rows", 2)
                end
                local normalized = {}
                for y = 1, descriptor.height do
                    local label = "frame " .. frameIndex .. " layer " .. layerIndex .. " row " .. y
                    normalized[y] = mode == "pixel"
                        and normalizePixelRow(rows[y], descriptor.width, label, #palette)
                        or normalizeCellRow(rows[y], descriptor.width, label, #palette)
                end
                rows = normalized
            end
            frame.layers[layerIndex] = { rows = rows }
            previous[layerIndex] = rows
        end
        frames[frameIndex] = frame
    end
    return {
        format = "FLIMG",
        version = 1,
        mode = mode,
        width = width,
        height = height,
        palette = palette,
        layers = layers,
        frames = frames,
        loop = source.loop ~= false,
        pingPong = source.pingPong == true,
        keyframeInterval = integer(source.keyframeInterval or 16,
            "keyframeInterval", 1, 255),
    }
end
function flimg.normalize(source)
    return normalizeImage(source)
end
function flimg.rleEncode(data)
    if type(data) ~= "string" then fail("rleEncode expects a string", 2) end
    local out, length, i = {}, #data, 1
    while i <= length do
        local value = byte(data, i)
        local run = 1
        while run < 128 and i + run <= length and byte(data, i + run) == value do
            run = run + 1
        end
        if run >= 3 then
            out[#out + 1] = char(257 - run, value)
            i = i + run
        else
            local start = i
            local literalLength = 0
            while i <= length and literalLength < 128 do
                value = byte(data, i)
                local nextRun = 1
                while nextRun < 128 and i + nextRun <= length
                    and byte(data, i + nextRun) == value do
                    nextRun = nextRun + 1
                end
                if nextRun >= 3 then break end
                local take = min(nextRun, 128 - literalLength)
                i = i + take
                literalLength = literalLength + take
                if take < nextRun then break end
            end
            out[#out + 1] = char(literalLength - 1)
            out[#out + 1] = sub(data, start, i - 1)
        end
    end
    return table.concat(out)
end
function flimg.rleDecode(data, expectedLength)
    if type(data) ~= "string" then fail("rleDecode expects a string", 2) end
    local reader, out, produced = Reader.new(data), {}, 0
    while reader.pos <= reader.size do
        local control = reader:u8("RLE control byte")
        if control <= 127 then
            local length = control + 1
            out[#out + 1] = reader:take(length, "RLE literal")
            produced = produced + length
        elseif control >= 129 then
            local length = 257 - control
            out[#out + 1] = rep(char(reader:u8("RLE repeated byte")), length)
            produced = produced + length
        end
        if expectedLength and produced > expectedLength then fail("RLE output exceeds expected length", 2) end
    end
    local result = table.concat(out)
    if expectedLength and #result ~= expectedLength then
        fail("RLE produced " .. #result .. " bytes, expected " .. expectedLength, 2)
    end
    return result
end
local function cellDifferent(a, b, x)
    return byte(a[1], x) ~= byte(b[1], x)
        or byte(a[2], x) ~= byte(b[2], x)
        or byte(a[3], x) ~= byte(b[3], x)
end
local function differenceBounds(mode, current, previous, width, height, full)
    if full then return 1, 1, width, height end
    local x1, y1, x2, y2 = width + 1, height + 1, 0, 0
    for y = 1, height do
        local a, b = current[y], previous[y]
        if a ~= b then
            for x = 1, width do
                local changed
                if mode == "pixel" then
                    changed = byte(a, x) ~= byte(b, x)
                else
                    changed = cellDifferent(a, b, x)
                end
                if changed then
                    if x < x1 then x1 = x end
                    if x > x2 then x2 = x end
                    if y < y1 then y1 = y end
                    if y > y2 then y2 = y end
                end
            end
        end
    end
    if x2 == 0 then return nil end
    return x1, y1, x2, y2
end
local function extractPatch(mode, rows, x1, y1, x2, y2)
    local out = {}
    if mode == "pixel" then
        for y = y1, y2 do out[#out + 1] = sub(rows[y], x1, x2) end
    else
        for plane = 1, 3 do
            for y = y1, y2 do out[#out + 1] = sub(rows[y][plane], x1, x2) end
        end
    end
    return table.concat(out)
end
local function encodePatch(layerIndex, x1, y1, x2, y2, raw)
    local compressed = flimg.rleEncode(raw)
    local encoding, payload = flimg.ENCODING_RAW, raw
    if #compressed < #raw then encoding, payload = flimg.ENCODING_RLE, compressed end
    return table.concat({
        u8(layerIndex), u16(x1 - 1), u16(y1 - 1),
        u16(x2 - x1 + 1), u16(y2 - y1 + 1), u8(encoding),
        u32(#raw), u32(#payload), payload,
    })
end
function flimg.encode(source, options)
    local image = normalizeImage(source)
    options = options or {}
    local interval = integer(options.keyframeInterval or image.keyframeInterval,
        "keyframeInterval", 1, 255)
    local framePayloads, frameEntries = {}, {}
    for frameIndex = 1, #image.frames do
        local keyframe = frameIndex == 1 or (frameIndex - 1) % interval == 0
        local patches = {}
        for layerIndex = 1, #image.layers do
            local descriptor = image.layers[layerIndex]
            local current = image.frames[frameIndex].layers[layerIndex].rows
            local previous = frameIndex > 1 and image.frames[frameIndex - 1].layers[layerIndex].rows
                or blankRows(image.mode, descriptor.width, descriptor.height)
            local x1, y1, x2, y2 = differenceBounds(image.mode, current, previous,
                descriptor.width, descriptor.height, keyframe)
            if x1 then
                local raw = extractPatch(image.mode, current, x1, y1, x2, y2)
                patches[#patches + 1] = encodePatch(layerIndex, x1, y1, x2, y2, raw)
            end
        end
        local payload = u8(#patches) .. table.concat(patches)
        framePayloads[frameIndex] = payload
        frameEntries[frameIndex] = {
            duration = image.frames[frameIndex].duration,
            keyframe = keyframe,
            length = #payload,
        }
    end
    local flags = (image.loop and 1 or 0) + (image.pingPong and 2 or 0)
    local header = {
        flimg.MAGIC, u8(flimg.VERSION), u8(MODE_TO_BYTE[image.mode]), u8(flags),
        u16(image.width), u16(image.height), u8(#image.palette),
        u8(#image.layers), u16(#image.frames), u8(interval), u8(0),
    }
    for i = 1, #image.palette do
        local rgb = image.palette[i]
        header[#header + 1] = char(floor(rgb / 65536), floor(rgb / 256) % 256, rgb % 256)
    end
    for i = 1, #image.layers do
        local layer = image.layers[i]
        header[#header + 1] = table.concat({
            u8(#layer.name), layer.name, i16(layer.x), i16(layer.y),
            u16(layer.width), u16(layer.height), i16(layer.z),
            u8(layer.visible and 1 or 0),
        })
    end
    local offset, directory = 0, {}
    for i = 1, #frameEntries do
        local entry = frameEntries[i]
        directory[i] = u16(entry.duration) .. u8(entry.keyframe and 1 or 0)
            .. u32(offset) .. u32(entry.length)
        offset = offset + entry.length
    end
    return table.concat(header) .. table.concat(directory) .. table.concat(framePayloads)
end
local function replaceSpan(source, startIndex, replacement)
    return sub(source, 1, startIndex - 1) .. replacement
        .. sub(source, startIndex + #replacement)
end
local function applyPatch(mode, rows, x, y, width, height, raw)
    local pos = 1
    if mode == "pixel" then
        for row = y, y + height - 1 do
            local span = sub(raw, pos, pos + width - 1)
            rows[row] = replaceSpan(rows[row], x, span)
            pos = pos + width
        end
    else
        local spans = { {}, {}, {} }
        for plane = 1, 3 do
            for row = y, y + height - 1 do
                spans[plane][row] = sub(raw, pos, pos + width - 1)
                pos = pos + width
            end
        end
        for row = y, y + height - 1 do
            local old = rows[row]
            rows[row] = {
                replaceSpan(old[1], x, spans[1][row]),
                replaceSpan(old[2], x, spans[2][row]),
                replaceSpan(old[3], x, spans[3][row]),
            }
        end
    end
end
function flimg.decode(data)
    if type(data) ~= "string" then fail("decode expects a binary string", 2) end
    local reader = Reader.new(data)
    if reader:take(4, "magic") ~= flimg.MAGIC then fail("invalid magic bytes", 2) end
    local version = reader:u8("version")
    if version ~= flimg.VERSION then fail("unsupported version " .. version, 2) end
    local modeByte = reader:u8("mode")
    local mode = BYTE_TO_MODE[modeByte]
    if not mode then fail("unsupported mode " .. modeByte, 2) end
    local flags = reader:u8("flags")
    local width, height = reader:u16("width"), reader:u16("height")
    if width == 0 or height == 0 then fail("canvas dimensions must be non-zero", 2) end
    local paletteCount, layerCount = reader:u8("palette count"), reader:u8("layer count")
    local frameCount = reader:u16("frame count")
    local interval = reader:u8("keyframe interval")
    reader:u8("reserved byte")
    if paletteCount == 0 or layerCount == 0 or frameCount == 0 then
        fail("palette, layer, and frame counts must be non-zero", 2)
    end
    if interval == 0 then fail("keyframe interval must be non-zero", 2) end
    local palette = {}
    for i = 1, paletteCount do
        local r, g, b = byte(reader:take(3, "palette"), 1, 3)
        palette[i] = r * 65536 + g * 256 + b
    end
    local layers = {}
    for i = 1, layerCount do
        local nameLength = reader:u8("layer name length")
        local layer = {
            name = reader:take(nameLength, "layer name"),
            x = reader:i16("layer x"), y = reader:i16("layer y"),
            width = reader:u16("layer width"), height = reader:u16("layer height"),
            z = reader:i16("layer z"),
            visible = hasFlag(reader:u8("layer flags"), 1),
        }
        if layer.width == 0 or layer.height == 0 then fail("layer dimensions must be non-zero", 2) end
        layers[i] = layer
    end
    local directory = {}
    for i = 1, frameCount do
        directory[i] = {
            duration = reader:u16("frame duration"),
            keyframe = hasFlag(reader:u8("frame flags"), 1),
            offset = reader:u32("frame offset"),
            length = reader:u32("frame length"),
        }
        if directory[i].duration == 0 then fail("frame duration must be non-zero", 2) end
    end
    local dataStart = reader.pos
    local frames, previous = {}, {}
    for i = 1, layerCount do
        previous[i] = blankRows(mode, layers[i].width, layers[i].height)
    end
    for frameIndex = 1, frameCount do
        local entry = directory[frameIndex]
        if entry.offset + entry.length > reader.size - dataStart + 1 then
            fail("frame " .. frameIndex .. " points outside the file", 2)
        end
        local frameReader = Reader.new(sub(data,
            dataStart + entry.offset, dataStart + entry.offset + entry.length - 1))
        local states = {}
        for layerIndex = 1, layerCount do
            states[layerIndex] = entry.keyframe
                and blankRows(mode, layers[layerIndex].width, layers[layerIndex].height)
                or cloneRows(mode, previous[layerIndex])
        end
        local patchCount = frameReader:u8("frame patch count")
        local seen = {}
        for patchIndex = 1, patchCount do
            local layerIndex = frameReader:u8("patch layer")
            local descriptor = layers[layerIndex]
            if not descriptor then fail("patch references missing layer " .. layerIndex, 2) end
            if seen[layerIndex] then fail("frame has multiple patches for layer " .. layerIndex, 2) end
            seen[layerIndex] = true
            local x, y = frameReader:u16("patch x") + 1, frameReader:u16("patch y") + 1
            local patchWidth, patchHeight = frameReader:u16("patch width"), frameReader:u16("patch height")
            local encoding = frameReader:u8("patch encoding")
            local rawLength, payloadLength = frameReader:u32("raw length"), frameReader:u32("payload length")
            if patchWidth == 0 or patchHeight == 0
                or x + patchWidth - 1 > descriptor.width
                or y + patchHeight - 1 > descriptor.height then
                fail("patch lies outside layer " .. layerIndex, 2)
            end
            local expected = patchWidth * patchHeight * (mode == "cell" and 3 or 1)
            if rawLength ~= expected then fail("patch raw length does not match its dimensions", 2) end
            local payload = frameReader:take(payloadLength, "patch payload")
            local raw
            if encoding == flimg.ENCODING_RAW then
                raw = payload
                if #raw ~= rawLength then fail("raw patch length mismatch", 2) end
            elseif encoding == flimg.ENCODING_RLE then
                raw = flimg.rleDecode(payload, rawLength)
            else
                fail("unsupported patch encoding " .. encoding, 2)
            end
            if mode == "pixel" then
                validatePaletteBytes(raw, 1, "pixel patch", paletteCount)
            else
                validatePaletteBytes(raw, patchWidth * patchHeight + 1,
                    "cell color patch", paletteCount)
            end
            applyPatch(mode, states[layerIndex], x, y, patchWidth, patchHeight, raw)
        end
        if frameReader.pos ~= frameReader.size + 1 then fail("unused bytes in frame " .. frameIndex, 2) end
        if entry.keyframe then
            for layerIndex = 1, layerCount do
                if not seen[layerIndex] then fail("keyframe omits layer " .. layerIndex, 2) end
            end
        end
        local frame = { duration = entry.duration, layers = {} }
        for layerIndex = 1, layerCount do
            frame.layers[layerIndex] = { rows = states[layerIndex] }
            previous[layerIndex] = states[layerIndex]
        end
        frames[frameIndex] = frame
    end
    return {
        format = "FLIMG", version = version, mode = mode,
        width = width, height = height, palette = palette,
        layers = layers, frames = frames,
        loop = hasFlag(flags, 1), pingPong = hasFlag(flags, 2),
        keyframeInterval = interval,
    }
end
local function readFile(path)
    if fs and fs.open then
        local handle = fs.open(path, "rb") or fs.open(path, "r")
        if not handle then fail("cannot open " .. tostring(path), 2) end
        local data = handle.readAll()
        handle.close()
        return data
    end
    local handle, err = io.open(path, "rb")
    if not handle then fail("cannot open " .. tostring(path) .. ": " .. tostring(err), 2) end
    local data = handle:read("*a")
    handle:close()
    return data
end
local function writeFile(path, data)
    if fs and fs.open then
        local handle = fs.open(path, "wb") or fs.open(path, "w")
        if not handle then fail("cannot write " .. tostring(path), 2) end
        handle.write(data)
        handle.close()
        return
    end
    local handle, err = io.open(path, "wb")
    if not handle then fail("cannot write " .. tostring(path) .. ": " .. tostring(err), 2) end
    handle:write(data)
    handle:close()
end
function flimg.load(path)
    return flimg.decode(readFile(path))
end
function flimg.save(path, image, options)
    local data = flimg.encode(image, options)
    writeFile(path, data)
    return #data
end
local function overlaySpan(target, source, targetX, sourceX, length)
    local out = {}
    for offset = 0, length - 1 do
        local value = byte(source, sourceX + offset)
        out[offset + 1] = value == 0
            and sub(target, targetX + offset, targetX + offset)
            or char(value)
    end
    return sub(target, 1, targetX - 1) .. table.concat(out)
        .. sub(target, targetX + length)
end
function flimg.compose(image, frameIndex)
    image = image.format == "FLIMG" and image or normalizeImage(image)
    local frame = image.frames[frameIndex or 1]
    if not frame then fail("frame " .. tostring(frameIndex) .. " does not exist", 2) end
    local rows = blankRows(image.mode, image.width, image.height)
    local order = {}
    for i = 1, #image.layers do order[i] = i end
    table.sort(order, function(a, b)
        local la, lb = image.layers[a], image.layers[b]
        return la.z == lb.z and a < b or la.z < lb.z
    end)
    for _, layerIndex in ipairs(order) do
        local layer = image.layers[layerIndex]
        if layer.visible then
            local source = frame.layers[layerIndex].rows
            local sourceX1 = max(1, 2 - layer.x)
            local sourceX2 = min(layer.width, image.width - layer.x + 1)
            for sy = 1, layer.height do
                local dy = layer.y + sy - 1
                if dy >= 1 and dy <= image.height and sourceX1 <= sourceX2 then
                    local targetX, length = layer.x + sourceX1 - 1, sourceX2 - sourceX1 + 1
                    if image.mode == "pixel" then
                        rows[dy] = overlaySpan(rows[dy], source[sy], targetX, sourceX1, length)
                    else
                        local target = rows[dy]
                        rows[dy] = {
                            overlaySpan(target[1], source[sy][1], targetX, sourceX1, length),
                            overlaySpan(target[2], source[sy][2], targetX, sourceX1, length),
                            overlaySpan(target[3], source[sy][3], targetX, sourceX1, length),
                        }
                    end
                end
            end
        end
    end
    return rows
end
local function addPaletteColor(palette, lookup, rgb)
    local known = lookup[rgb]
    if known then return known end
    if #palette >= 255 then fail("imported image uses more than 255 colors", 2) end
    palette[#palette + 1] = rgb
    lookup[rgb] = #palette
    return #palette
end
function flimg.fromBimg(bimg)
    if type(bimg) ~= "table" or type(bimg[1]) ~= "table" or type(bimg[1][1]) ~= "table" then
        fail("invalid BIMG table", 2)
    end
    local width, height = #bimg[1][1][1], #bimg[1]
    local palette, lookup = {}, {}
    local function fromBlit(value)
        local index = tonumber(value, 16)
        return index and addPaletteColor(palette, lookup, NATIVE_RGB[index]) or 0
    end
    local frames = {}
    for frameIndex = 1, #bimg do
        local sourceFrame, rows = bimg[frameIndex], {}
        if #sourceFrame ~= height then fail("BIMG frame dimensions differ", 2) end
        for y = 1, height do
            local line = sourceFrame[y]
            if type(line) ~= "table" or #line[1] ~= width or #line[2] ~= width or #line[3] ~= width then
                fail("invalid BIMG line", 2)
            end
            local fg, bg = {}, {}
            for x = 1, width do
                fg[x] = char(fromBlit(line[2]:sub(x, x)))
                bg[x] = char(fromBlit(line[3]:sub(x, x)))
            end
            rows[y] = { line[1], table.concat(fg), table.concat(bg) }
        end
        frames[frameIndex] = {
            duration = floor(((bimg.secondsPerFrame or 0.2) * 1000) + 0.5),
            layers = { { rows = rows } },
        }
    end
    return normalizeImage({
        mode = "cell", width = width, height = height,
        palette = palette, layers = { { name = "BIMG" } }, frames = frames,
        loop = true,
    })
end
local function rowCell(row, index)
    return type(row) == "string" and row:sub(index, index) or row[index]
end
local function nativeIndexOf(value)
    if type(value) ~= "number" or value < 1 or value > 32768 then return nil end
    local current = 1
    for index = 0, 15 do
        if value == current then return index end
        current = current * 2
    end
end
function flimg.fromSprite(sprite, options)
    options = options or {}
    if type(sprite) ~= "table" then fail("invalid sprite table", 2) end
    local width = integer(sprite.width, "sprite width", 1, 65535)
    local height = integer(sprite.height, "sprite height", 1, 65535)
    local frameCount = integer(sprite.frameCount or #sprite, "sprite frame count", 1, 65535)
    local palette, lookup = {}, {}
    local function colorIndex(value)
        if value == nil or value == false or value == " " or value == "" then return 0 end
        if options.resolveColor then value = options.resolveColor(value) end
        if type(value) == "string" and #value == 1 then
            local native = tonumber(value, 16)
            if native then return addPaletteColor(palette, lookup, NATIVE_RGB[native]) end
        end
        local native = nativeIndexOf(value)
        if native then return addPaletteColor(palette, lookup, NATIVE_RGB[native]) end
        return addPaletteColor(palette, lookup, parseRGB(value, "sprite color"))
    end
    local frames = {}
    for frameIndex = 1, frameCount do
        local frame = sprite[frameIndex]
        if type(frame) ~= "table" or not frame[1] or not frame[2] or not frame[3] then
            fail("sprite frame " .. frameIndex .. " must have character, foreground, and background layers", 2)
        end
        local rows = {}
        for y = 1, height do
            local charRow, fgRow, bgRow = frame[1][y], frame[2][y], frame[3][y]
            if type(charRow) ~= "table" and type(charRow) ~= "string" then
                fail("invalid sprite character row", 2)
            end
            local chars, foregrounds, backgrounds = {}, {}, {}
            for x = 1, width do
                local glyph = rowCell(charRow, x)
                if type(glyph) ~= "string" or #glyph ~= 1 then fail("invalid sprite character", 2) end
                chars[x] = glyph == " " and "\0" or glyph
                foregrounds[x] = char(colorIndex(rowCell(fgRow, x)))
                backgrounds[x] = char(colorIndex(rowCell(bgRow, x)))
            end
            rows[y] = { table.concat(chars), table.concat(foregrounds), table.concat(backgrounds) }
        end
        frames[frameIndex] = {
            duration = floor(((sprite.secondsPerFrame or options.secondsPerFrame or 0.1) * 1000) + 0.5),
            layers = { { rows = rows } },
        }
    end
    if #palette == 0 then palette[1] = NATIVE_RGB[15] end
    return normalizeImage({
        mode = "cell", width = width, height = height,
        palette = palette, layers = { { name = "Sprite" } }, frames = frames,
        loop = sprite.loop ~= false,
    })
end
return flimg
]=]
sources["core/baseframe"] = [=[

local require = ...
local class = require("core/class")
local Container = require("core/container")
local Render = require("core/render")
local state = require("core/state")
local BaseFrame = class.create("BaseFrame", Container)
class.property(BaseFrame, "background", colors.black)
function BaseFrame:setup()
    Container.setup(self)
    rawset(self, "_keysDown", {})
end
function BaseFrame:isKeyDown(keyCode)
    return rawget(self, "_keysDown")[keyCode] == true
end
function BaseFrame:setTerm(t)
    rawset(self, "term", t)
    rawset(self, "_render", Render.new(t))
    local w, h = t.getSize()
    self._p.width, self._p.height = w, h
    self:markDirty()
    return self
end
function BaseFrame:draw()
    if not rawget(self, "_dirty") then return end
    self._render:setCursor(1, 1, false)
    for _ = 1, 2 do
        rawset(self, "_dirty", false)
        state.clearWatcher(self)
        self:render(self._render)
        if not rawget(self, "_dirty") then break end
    end
    self._render:flush()
end
function BaseFrame:setFocused(el)
    local old = rawget(self, "_focused")
    if old == el then return end
    rawset(self, "_focused", el)
    local r = rawget(self, "_render")
    if r then r:setCursor(1, 1, false) end
    if old and old ~= self then old:fire("blur") end
    if el and el ~= self then el:fire("focus") end
    self:markDirty()
end
function BaseFrame:setCursor(x, y, blink, color)
    local r = rawget(self, "_render")
    if r then r:setCursor(x, y, blink, color) end
    return self
end
function BaseFrame:getFocused()
    return rawget(self, "_focused")
end
function BaseFrame:_updateHovered(x, y)
    local hit = self:findAt(x, y)
    local hovered = hit ~= self and hit or nil
    local old = rawget(self, "_hovered")
    if old == hovered then return end
    rawset(self, "_hovered", hovered)
    if old then
        old:setState("hover", false)
        old:fire("mouseLeave")
    end
    if hovered then
        hovered:setState("hover", true)
        hovered:fire("mouseEnter")
    end
end
local function isInside(el, ancestor)
    while el do
        if el == ancestor then return true end
        el = rawget(el, "parent")
    end
    return false
end
function BaseFrame:_releaseSubtree(el, keepHover)
    local focused = rawget(self, "_focused")
    if focused and isInside(focused, el) then self:setFocused(nil) end
    local clicked = rawget(self, "_clicked")
    if clicked and isInside(clicked, el) then
        clicked:setState("pressed", false)
        rawset(self, "_clicked", false)
    end
    local hovered = rawget(self, "_hovered")
    if not keepHover and hovered and isInside(hovered, el) then
        hovered:setState("hover", false)
        hovered:fire("mouseLeave")
        rawset(self, "_hovered", nil)
    end
end
function BaseFrame:handleEvent(event, a, b, c)
    if event == "key" then
        rawget(self, "_keysDown")[a] = true
    elseif event == "key_up" then
        rawget(self, "_keysDown")[a] = nil
    end
    if event == "mouse_click" then
        self:_updateHovered(b, c)
        rawset(self, "_clicked", self:handleMouse(event, a, b, c))
    elseif event == "mouse_move" then
        local x, y = a, b
        if c ~= nil then x, y = b, c end
        if type(x) == "number" and type(y) == "number" then
            self:_updateHovered(x, y)
        end
    elseif event == "mouse_up" or event == "mouse_drag" then
        self:_updateHovered(b, c)
        local el = rawget(self, "_clicked")
        if el then
            local ax, ay = el:getAbsolutePosition()
            if event == "mouse_up" then
                el:setState("pressed", false)
                el:fire("clickUp", a, b - ax + 1, c - ay + 1)
                rawset(self, "_clicked", false)
            else
                el:fire("drag", a, b - ax + 1, c - ay + 1)
            end
        end
    elseif event == "mouse_scroll" then
        self:handleMouse(event, a, b, c)
        self:_updateHovered(b, c)
    elseif event == "key" or event == "key_up" or event == "char"
        or event == "paste" then
        local f = rawget(self, "_focused")
        if f and f ~= self then f:handleKey(event, a, b) end
    elseif event == "term_resize" then
        local w, h = self.term.getSize()
        self._p.width, self._p.height = w, h
        self._render:resize(w, h)
        self:markDirty()
    end
end
function BaseFrame:cleanup()
    local r = rawget(self, "_render")
    if r then r.mapper:restore() end
    local t = rawget(self, "term")
    if t then
        t.setBackgroundColor(colors.black)
        t.setTextColor(colors.white)
        t.clear()
        t.setCursorPos(1, 1)
        t.setCursorBlink(false)
    end
end
return BaseFrame
]=]
sources["core/class"] = [=[

local require = ...
local reactive = require("core/reactive")
local state = require("core/state")
local layout = require("core/layout")
local class = {}
local unpack = table.unpack or unpack
local function syncMirroredState(t, prop, value)
    if prop.state and t.setState then
        local active = prop.stateWhen and prop.stateWhen(value, t) or not not value
        t:setState(prop.state, active)
    end
end
local function resolveSpecValue(t, prop, value)
    if state.is(value) then
        value = state.read(value, t)
    elseif type(value) == "function" and not prop.rawFunction then
        value = state.withWatcher(t, value, t)
    end
    syncMirroredState(t, prop, value)
    return value
end
local function capitalize(s)
    return s:sub(1, 1):upper() .. s:sub(2)
end
function class.create(name, parent)
    local c = {}
    c.__name = name
    c.__parent = parent
    c.__props = setmetatable({}, parent and { __index = parent.__props } or nil)
    c.__defaults = setmetatable({}, parent and { __index = parent.__defaults } or nil)
    c.__stateStyles = {}
    c.__pmeta = { __index = c.__defaults }
    if parent then setmetatable(c, { __index = parent }) end
    c.__getPropertySpec = function(t, k)
        local prop = c.__props[k]
        if not prop then return false end
        local resolver = c.__stateResolver
        if prop.styleable and resolver then
            local found, stateValue = resolver(t, k, c)
            if found then
                return true, resolveSpecValue(t, prop, stateValue), prop
            end
        end
        local value = rawget(t, "_p")[k]
        if value ~= nil then
            return true, resolveSpecValue(t, prop, value), prop
        end
        return false
    end
    c.__meta = {
        __index = function(t, k)
            local box = rawget(t, "_layoutBox")
            if box and box[k] ~= nil then return box[k] end
            local found, value = c.__getPropertySpec(t, k)
            if found then
                if layout.is(value) then
                    return layout.resolveToken(value, t, k)
                end
                return value
            end
            return c[k]
        end,
        __newindex = function(t, k, v)
            local prop = c.__props[k]
            if prop then
                if type(v) == "string" and not prop.rawString
                    and v:sub(1, 1) == "{" and v:sub(-1) == "}" then
                    v = reactive.compile(v, t)
                end
                local p = rawget(t, "_p")
                local old = p[k]
                if old ~= v then
                    p[k] = v
                    if (type(v) == "function" and not prop.rawFunction)
                        or state.is(v) then
                        if prop.visual then
                            if t.invalidateLayout then t:invalidateLayout(k) end
                            if t.markRenderDirty then
                                t:markRenderDirty()
                            else
                                t:markDirty()
                            end
                        end
                    else
                        if prop.onChange then prop.onChange(t, v, old) end
                        syncMirroredState(t, prop, v)
                        if prop.visual then
                            if t.invalidateLayout then t:invalidateLayout(k) end
                            if t.markRenderDirty then
                                t:markRenderDirty()
                            else
                                t:markDirty()
                            end
                        end
                    end
                end
            else
                rawset(t, k, v)
            end
        end,
        __tostring = function(t)
            return name
        end,
    }
    c.new = function(props)
        local self = setmetatable({
            _p = setmetatable({}, c.__pmeta),
            _handlers = {},
            _class = c,
        }, c.__meta)
        self:setup()
        if props then self:apply(props) end
        return self
    end
    return c
end
function class.property(c, propName, default, opts)
    opts = opts or {}
    c.__props[propName] = {
        visual = opts.visual ~= false,
        onChange = opts.onChange,
        rawFunction = opts.rawFunction,
        rawString = opts.rawString,
        state = opts.state,
        stateWhen = opts.stateWhen,
        styleable = opts.styleable ~= false,
    }
    c.__defaults[propName] = default
    local cap = capitalize(propName)
    c["set" .. cap] = function(self, v)
        self[propName] = v
        return self
    end
    c["get" .. cap] = function(self)
        return self[propName]
    end
end
function class.combinedProperty(c, combinedName, propertyNames)
    if type(combinedName) ~= "string" or combinedName == "" then
        error("Basalt class: combined property name must be a non-empty string", 2)
    end
    if type(propertyNames) ~= "table" or #propertyNames == 0 then
        error("Basalt class: combined property list must not be empty", 2)
    end
    local names = {}
    for i = 1, #propertyNames do
        local propName = propertyNames[i]
        if type(propName) ~= "string" or c.__props[propName] == nil then
            error("Basalt class: unknown property '" .. tostring(propName)
                .. "' in combined property " .. combinedName, 2)
        end
        names[i] = propName
    end
    local setterName = "set" .. combinedName
    local getterName = "get" .. combinedName
    local rawGetterName = "getRaw" .. combinedName
    c[setterName] = function(self, ...)
        local values = table.pack(...)
        if values.n ~= #names then
            error("Basalt: " .. setterName .. " expects " .. #names
                .. " values, got " .. values.n, 2)
        end
        for i = 1, #names do self[names[i]] = values[i] end
        return self
    end
    c[getterName] = function(self)
        local values = { n = #names }
        for i = 1, #names do values[i] = self[names[i]] end
        return unpack(values, 1, values.n)
    end
    c[rawGetterName] = function(self)
        local values = { n = #names }
        for i = 1, #names do values[i] = self:raw(names[i]) end
        return unpack(values, 1, values.n)
    end
end
function class.event(c, eventName)
    c["on" .. capitalize(eventName)] = function(self, fn)
        return self:on(eventName, fn)
    end
end
return class
]=]
sources["core/collection"] = [=[
local require = ...
local class = require("core/class")
local CollectionEntry = require("core/collectionentry")
local methods = {}
local collection = { methods = methods }
local function indexOf(self, value)
    if type(value) == "number" then
        local index = math.floor(value)
        return self.items[index] and index or nil
    end
    for i, entry in ipairs(self.items) do
        if entry == value then return i end
    end
end
local function eligible(entry)
    return entry and entry.selectable ~= false and entry.disabled ~= true
        and entry.separator ~= true
end
local function selectedSnapshot(self)
    local index = self:getSelectedIndex()
    return index, index and self.items[index] or nil
end
local function syncSelected(self)
    local index = self:getSelectedIndex() or false
    rawget(self, "_p").selected = index
    self:setState("selected", index ~= false)
end
local function fireChange(self, oldIndex, oldItem)
    syncSelected(self)
    local index, item = selectedSnapshot(self)
    local eventName = rawget(self, "_collectionChangeEvent")
    if eventName then self:fire(eventName, index or false, item, oldIndex or false, oldItem) end
    self:markDirty()
end
local function normalize(self, item)
    if CollectionEntry.is(item) then
        if rawget(item, "_parent") == self then return item end
        item = item:getData()
    end
    return CollectionEntry.new(self, item)
end
local function replaceItems(self, values, oldItems)
    if type(values) ~= "table" then
        error("Basalt Collection: items must be a table", 3)
    end
    local oldIndex, oldItem
    local selected = rawget(self, "_collectionSelection")
    if type(oldItems) == "table" then
        for i, entry in ipairs(oldItems) do
            if selected[entry] then oldIndex, oldItem = i, entry break end
        end
    end
    if type(oldItems) == "table" then
        for _, entry in ipairs(oldItems) do
            if CollectionEntry.is(entry) then rawset(entry, "_parent", nil) end
        end
    end
    local items = {}
    local newSelection = {}
    for i, item in ipairs(values) do
        local wantsSelection = type(item) == "table" and not CollectionEntry.is(item)
            and item.selected == true
        items[i] = normalize(self, item)
        local data = items[i]:getData()
        data.selected = nil
        if wantsSelection and (self.multiSelection or next(newSelection) == nil) then
            newSelection[items[i]] = true
        end
    end
    rawget(self, "_p").items = items
    rawset(self, "_collectionSelection", newSelection)
    if oldItem or next(newSelection) then
        fireChange(self, oldIndex, oldItem)
    else
        syncSelected(self)
        self:markDirty()
    end
    if self.setOffset and self.offset ~= nil then self:setOffset(self.offset) end
end
local function ensureProperty(c, name, default, options)
    if c.__props[name] == nil then class.property(c, name, default, options) end
end
function collection.install(c, options)
    options = options or {}
    ensureProperty(c, "items", false, {
        onChange = function(self, value, old)
            if rawget(self, "_collectionSelection") then replaceItems(self, value, old) end
        end,
    })
    ensureProperty(c, "selectable", true)
    ensureProperty(c, "multiSelection", false, {
        onChange = function(self, enabled)
            if enabled or not rawget(self, "_collectionSelection") then return end
            local first = self:getSelectedItem()
            local selected = rawget(self, "_collectionSelection")
            for entry in pairs(selected) do selected[entry] = entry == first or nil end
            syncSelected(self)
        end,
    })
    ensureProperty(c, "selected", false, {
        styleable = false,
        onChange = function(self, value)
            if not rawget(self, "_collectionSelection") then return end
            if value == false or value == nil then
                self:clearItemSelection()
            else
                self:selectItem(value)
            end
        end,
    })
    ensureProperty(c, "selectionBackground", colors.blue)
    ensureProperty(c, "selectionForeground", colors.white)
    class.event(c, "select")
    local changeEvent
    if options.changeEvent ~= false then
        changeEvent = options.changeEvent or "change"
    end
    if changeEvent then class.event(c, changeEvent) end
    c.setSelectedBackground = function(self, value)
        self.selectionBackground = value
        return self
    end
    c.getSelectedBackground = function(self) return self.selectionBackground end
    c.setSelectedForeground = function(self, value)
        self.selectionForeground = value
        return self
    end
    c.getSelectedForeground = function(self) return self.selectionForeground end
    c.setSelectionColor = function(self, foreground, background)
        self.selectionForeground = foreground
        self.selectionBackground = background
        return self
    end
    c.getSelectionColor = function(self)
        return self.selectionForeground, self.selectionBackground
    end
    c._collectionChangeEventName = changeEvent
    for name, method in pairs(collection.methods) do c[name] = method end
end
function collection.setup(self)
    rawset(self, "_collectionSelection", {})
    rawset(self, "_collectionChangeEvent", self._class._collectionChangeEventName)
    local initial = rawget(self, "_p").items
    local items = {}
    if type(initial) == "table" then
        for i, item in ipairs(initial) do items[i] = normalize(self, item) end
    end
    rawget(self, "_p").items = items
    syncSelected(self)
end
function methods:indexOfItem(value)
    return indexOf(self, value)
end
function methods:getItem(index)
    return self.items[index]
end
function methods:getItemCount()
    return #self.items
end
function methods:addItem(item)
    local wantsSelection = type(item) == "table" and not CollectionEntry.is(item)
        and item.selected == true
    local entry = normalize(self, item)
    entry:getData().selected = nil
    self.items[#self.items + 1] = entry
    if wantsSelection then self:selectItem(entry) end
    self:markDirty()
    return entry
end
function methods:insertItem(index, item)
    index = math.max(1, math.min(#self.items + 1, math.floor(index)))
    local entry = normalize(self, item)
    local wantsSelection = entry:getData().selected == true
    entry:getData().selected = nil
    table.insert(self.items, index, entry)
    if wantsSelection then self:selectItem(entry) end
    syncSelected(self)
    self:markDirty()
    return entry
end
function methods:removeItem(value)
    local index = indexOf(self, value)
    if not index then return self end
    local oldIndex, oldItem = selectedSnapshot(self)
    local entry = table.remove(self.items, index)
    local selected = rawget(self, "_collectionSelection")
    local changed = selected[entry] == true
    selected[entry] = nil
    rawset(entry, "_parent", nil)
    if changed then fireChange(self, oldIndex, oldItem) else syncSelected(self) end
    self:markDirty()
    return self
end
function methods:clear()
    local oldIndex, oldItem = selectedSnapshot(self)
    for _, entry in ipairs(self.items) do rawset(entry, "_parent", nil) end
    rawget(self, "_p").items = {}
    rawset(self, "_collectionSelection", {})
    if oldItem then fireChange(self, oldIndex, oldItem) else syncSelected(self) end
    self:markDirty()
    return self
end
function methods:clearItems()
    return self:clear()
end
function methods:isItemSelected(value)
    local index = indexOf(self, value)
    return index ~= nil
        and rawget(self, "_collectionSelection")[self.items[index]] == true
end
function methods:isSelected(value)
    return self:isItemSelected(value)
end
function methods:getSelectedItems()
    local result = {}
    local selected = rawget(self, "_collectionSelection")
    for _, entry in ipairs(self.items) do
        if selected[entry] then result[#result + 1] = entry end
    end
    return result
end
function methods:getSelectedItem()
    local selected = rawget(self, "_collectionSelection")
    for _, entry in ipairs(self.items) do
        if selected[entry] then return entry end
    end
end
function methods:getSelectedIndex()
    local selected = rawget(self, "_collectionSelection")
    for i, entry in ipairs(self.items) do
        if selected[entry] then return i end
    end
end
function methods:getSelection()
    local result = {}
    local selected = rawget(self, "_collectionSelection")
    for i, entry in ipairs(self.items) do
        if selected[entry] then result[#result + 1] = i end
    end
    return result
end
function methods:selectItem(value, emit)
    if not self.selectable then return self end
    local index = indexOf(self, value)
    local entry = index and self.items[index]
    if not eligible(entry) then return self end
    local selected = rawget(self, "_collectionSelection")
    local oldIndex, oldItem = selectedSnapshot(self)
    local changed = not selected[entry]
    if not self.multiSelection then
        for current in pairs(selected) do
            if current ~= entry then selected[current], changed = nil, true end
        end
    end
    selected[entry] = true
    if changed then
        if emit == false then syncSelected(self) else fireChange(self, oldIndex, oldItem) end
    end
    return self
end
function methods:unselectItem(value, emit)
    local index = indexOf(self, value)
    local entry = index and self.items[index]
    local selected = rawget(self, "_collectionSelection")
    if not entry or not selected[entry] then return self end
    local oldIndex, oldItem = selectedSnapshot(self)
    selected[entry] = nil
    if emit == false then syncSelected(self) else fireChange(self, oldIndex, oldItem) end
    return self
end
function methods:toggleItem(value, emit)
    if self:isItemSelected(value) then
        return self:unselectItem(value, emit)
    end
    return self:selectItem(value, emit)
end
function methods:clearItemSelection(emit)
    local oldIndex, oldItem = selectedSnapshot(self)
    if not oldItem then return self end
    rawset(self, "_collectionSelection", {})
    if emit == false then syncSelected(self) else fireChange(self, oldIndex, oldItem) end
    return self
end
function methods:clearSelection(emit)
    return self:clearItemSelection(emit)
end
function methods:selectNext(emit)
    local start = self:getSelectedIndex() or 0
    for index = start + 1, #self.items do
        if eligible(self.items[index]) then return self:selectItem(index, emit) end
    end
    return self
end
function methods:selectPrevious(emit)
    local start = self:getSelectedIndex() or (#self.items + 1)
    for index = start - 1, 1, -1 do
        if eligible(self.items[index]) then return self:selectItem(index, emit) end
    end
    return self
end
function methods:scrollToTop()
    if self.setOffset then self:setOffset(0) end
    return self
end
function methods:scrollToBottom()
    if self.setOffset then self:setOffset(math.huge) end
    return self
end
function methods:activateItem(value, emit, toggle)
    local index = indexOf(self, value)
    local entry = index and self.items[index]
    if not self.selectable or not eligible(entry) then return self end
    if toggle then self:toggleItem(entry) else self:selectItem(entry) end
    index = indexOf(self, entry)
    if emit ~= false then
        if type(entry.callback) == "function" then entry.callback(self, entry) end
        self:fire("select", index, entry)
    end
    return self
end
function methods:select(value, emit)
    return self:activateItem(value, emit, self.multiSelection)
end
function methods:_moveCollectionEntry(entry, delta)
    local index = indexOf(self, entry)
    if index then self:_moveCollectionEntryTo(entry, index + delta) end
    return self
end
function methods:_moveCollectionEntryTo(entry, target)
    local index = indexOf(self, entry)
    if not index then return self end
    target = math.max(1, math.min(#self.items, math.floor(target)))
    if target ~= index then
        table.remove(self.items, index)
        table.insert(self.items, target, entry)
        syncSelected(self)
        self:markDirty()
    end
    return self
end
function methods:_swapCollectionEntries(a, b)
    local ai, bi = indexOf(self, a), indexOf(self, b)
    if ai and bi and ai ~= bi then
        self.items[ai], self.items[bi] = self.items[bi], self.items[ai]
        syncSelected(self)
        self:markDirty()
    end
    return self
end
return collection
]=]
sources["core/collectionentry"] = [=[

local methods = {}
local CollectionEntry = {}
CollectionEntry.__index = function(entry, key)
    local method = methods[key]
    if method then return method end
    if key == "selected" then
        local parent = rawget(entry, "_parent")
        return parent and parent:isItemSelected(entry) or false
    end
    local data = rawget(entry, "_data")
    if data and data[key] ~= nil then return data[key] end
    local parent = rawget(entry, "_parent")
    local parentMethod = parent and parent[key]
    if type(parentMethod) == "function" then
        return function(_, ...)
            return parentMethod(parent, ...)
        end
    end
end
CollectionEntry.__newindex = function(entry, key, value)
    if type(key) == "string" and key:sub(1, 1) == "_" then
        rawset(entry, key, value)
        return
    end
    if key == "selected" then
        local parent = rawget(entry, "_parent")
        if parent then
            if value then parent:selectItem(entry) else parent:unselectItem(entry) end
        end
        return
    end
    local data = rawget(entry, "_data")
    if data[key] ~= value then
        data[key] = value
        local parent = rawget(entry, "_parent")
        if parent then parent:markDirty() end
    end
end
CollectionEntry.__tostring = function(entry)
    local data = rawget(entry, "_data")
    if data.text ~= nil then return tostring(data.text) end
    if data.label ~= nil then return tostring(data.label) end
    if data.value ~= nil then return tostring(data.value) end
    return "Entry"
end
function CollectionEntry.new(parent, item)
    local data
    if type(item) == "table" then
        data = item
    else
        data = { text = tostring(item), value = item }
    end
    if data.text == nil and data.label == nil and data.value == nil then
        data.text = "Entry"
    end
    return setmetatable({ _parent = parent, _data = data }, CollectionEntry)
end
function CollectionEntry.is(value)
    return getmetatable(value) == CollectionEntry
end
function methods:getData()
    return rawget(self, "_data")
end
function methods:getParent()
    return rawget(self, "_parent")
end
function methods:setText(text)
    self.text = text
    return self
end
function methods:getText()
    return self.text
end
function methods:getIndex()
    local parent = rawget(self, "_parent")
    return parent and parent:indexOfItem(self) or nil
end
function methods:moveUp(amount)
    local parent = rawget(self, "_parent")
    if parent then parent:_moveCollectionEntry(self, -(amount or 1)) end
    return self
end
function methods:moveDown(amount)
    local parent = rawget(self, "_parent")
    if parent then parent:_moveCollectionEntry(self, amount or 1) end
    return self
end
function methods:moveToTop()
    local parent = rawget(self, "_parent")
    if parent then parent:_moveCollectionEntryTo(self, 1) end
    return self
end
function methods:moveToBottom()
    local parent = rawget(self, "_parent")
    if parent then parent:_moveCollectionEntryTo(self, #parent.items) end
    return self
end
function methods:swapWith(other)
    local parent = rawget(self, "_parent")
    if parent and rawget(other, "_parent") == parent then
        parent:_swapCollectionEntries(self, other)
    end
    return self
end
function methods:remove()
    local parent = rawget(self, "_parent")
    if not parent then return false end
    parent:removeItem(self)
    return true
end
function methods:select()
    local parent = rawget(self, "_parent")
    if parent then parent:selectItem(self) end
    return self
end
function methods:unselect()
    local parent = rawget(self, "_parent")
    if parent then parent:unselectItem(self) end
    return self
end
function methods:isSelected()
    local parent = rawget(self, "_parent")
    return parent and parent:isItemSelected(self) or false
end
return CollectionEntry
]=]
sources["core/container"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local state = require("core/state")
local layout = require("core/layout")
local scroll = require("core/scroll")
local Container = class.create("Container", Element)
class.property(Container, "scrollable", false, {
    onChange = function(self, enabled)
        if not enabled then scroll.disable(self) end
    end,
})
class.property(Container, "scrollbar", "auto")
class.property(Container, "scrollXEnabled", true)
class.property(Container, "scrollYEnabled", true)
class.property(Container, "scrollStep", 3)
class.property(Container, "scrollbarColor", colors.gray)
class.property(Container, "scrollbarThumbColor", colors.lightGray)
class.event(Container, "scrollChange")
function Container:setup()
    Element.setup(self)
    rawset(self, "_children", {})
    rawset(self, "_addIndex", 0)
    rawset(self, "_sortDirty", false)
    rawset(self, "_layoutDirty", true)
    rawset(self, "_viewportDirty", true)
    rawset(self, "_visibleChildren", {})
    scroll.setup(self)
end
function Container:getScroll()
    return rawget(self, "_scrollX") or 0, rawget(self, "_scrollY") or 0
end
function Container:getContentSize()
    return rawget(self, "_contentWidth") or 0,
        rawget(self, "_contentHeight") or 0
end
function Container:getScrollInfo()
    local info = scroll.geometry(self)
    info.x, info.y = self:getScroll()
    info.contentWidth, info.contentHeight = self:getContentSize()
    return info
end
function Container:scrollTo(x, y)
    scroll.set(self, x or 0, y or 0)
    return self
end
function Container:scrollBy(dx, dy)
    local x, y = self:getScroll()
    scroll.set(self, x + (dx or 0), y + (dy or 0))
    return self
end
local function descendantBox(container, el)
    local x, y = el.x, el.y
    local p = rawget(el, "parent")
    while p and p ~= container do
        x = x + p.x - 1 - (rawget(p, "_scrollX") or 0)
        y = y + p.y - 1 - (rawget(p, "_scrollY") or 0)
        p = rawget(p, "parent")
    end
    if p ~= container then
        error("Basalt scroll: element is not a descendant of this container", 3)
    end
    return x, y, el.width, el.height
end
function Container:scrollToElement(el)
    local x, y = descendantBox(self, el)
    return self:scrollTo(x - 1, y - 1)
end
function Container:ensureVisible(el)
    local x, y, w, h = descendantBox(self, el)
    local sx, sy = self:getScroll()
    if x < sx + 1 then sx = x - 1 end
    if y < sy + 1 then sy = y - 1 end
    if x + w - 1 > sx + self.width then sx = x + w - 1 - self.width end
    if y + h - 1 > sy + self.height then sy = y + h - 1 - self.height end
    return self:scrollTo(sx, sy)
end
function Container:addChild(child)
    local oldParent = rawget(child, "parent")
    if oldParent then oldParent:removeChild(child) end
    rawset(child, "parent", self)
    self._addIndex = self._addIndex + 1
    rawset(child, "_order", self._addIndex)
    local ch = self._children
    ch[#ch + 1] = child
    self._sortDirty = true
    self:markLayoutDirty()
    return child
end
function Container:removeChild(child)
    local ch = self._children
    for i = 1, #ch do
        if ch[i] == child then
            local root = self:getRoot()
            if root._releaseSubtree then root:_releaseSubtree(child) end
            table.remove(ch, i)
            rawset(child, "parent", nil)
            self:markLayoutDirty()
            return true
        end
    end
    return false
end
function Container:destroy()
    local children = rawget(self, "_children")
    while children and #children > 0 do
        local child = children[#children]
        if child.destroy then child:destroy() end
        if children[#children] == child then self:removeChild(child) end
    end
    Element.destroy(self)
    return self
end
function Container:getChildren()
    return self._children
end
function Container:find(childName)
    local ch = self._children
    for i = 1, #ch do
        if ch[i].name == childName then return ch[i] end
    end
    for i = 1, #ch do
        local c = ch[i]
        if c.find then
            local found = c:find(childName)
            if found then return found end
        end
    end
    return nil
end
local function zLess(a, b)
    local az, bz = a.z, b.z
    if az == bz then return a._order < b._order end
    return az < bz
end
function Container:_sorted()
    if self._sortDirty then
        table.sort(self._children, zLess)
        self._sortDirty = false
        self._viewportDirty = true
    end
    return self._children
end
local function intersectsViewport(child, scrollX, scrollY, width, height)
    local box = rawget(child, "_layoutBox")
    local x = box and box.x or child.x
    local y = box and box.y or child.y
    local w = box and box.width or child.width
    local h = box and box.height or child.height
    if w <= 0 or h <= 0 then return false end
    return x <= scrollX + width and y <= scrollY + height
        and x + w - 1 > scrollX and y + h - 1 > scrollY
end
function Container:_visibleSorted()
    local cached = rawget(self, "_visibleChildren")
    if not rawget(self, "_viewportDirty") and cached then return cached end
    cached = {}
    local scrollX, scrollY = self:getScroll()
    local children = self:_sorted()
    for i = 1, #children do
        local child = children[i]
        if child.visible and intersectsViewport(child, scrollX, scrollY,
            self.width, self.height) then
            cached[#cached + 1] = child
        end
    end
    rawset(self, "_visibleChildren", cached)
    rawset(self, "_viewportDirty", false)
    return cached
end
function Container:render(buf)
    Element.render(self, buf)
    local children = self._children
    if rawget(self, "_layoutDirty") then
        for i = 1, #children do
            local c = children[i]
            state.clearWatcher(c)
            local z = c:raw("z")
            if state.is(z) or type(z) == "function" then
                self._sortDirty = true
            end
        end
        self:fire("layout", self.width, self.height)
        if self.layoutChildren then
            self:layoutChildren()
        else
            layout.resolveFreeChildren(self)
        end
        scroll.update(self)
        rawset(self, "_layoutDirty", false)
        rawset(self, "_viewportDirty", true)
    end
    local scrollX, scrollY = self:getScroll()
    local ch = self:_visibleSorted()
    for i = 1, #ch do
        local c = ch[i]
        if c.visible then
            buf:push(c.x - scrollX, c.y - scrollY, c.width, c.height)
            c:render(buf)
            buf:pop()
        end
    end
    scroll.draw(self, buf)
end
function Container:handleMouse(event, btn, x, y)
    if event == "mouse_click" and scroll.pointerDown(self, x, y) then
        return self
    end
    local scrollX, scrollY = self:getScroll()
    local contentX, contentY = x + scrollX, y + scrollY
    local ch = self:_visibleSorted()
    for i = #ch, 1, -1 do
        local c = ch[i]
        if c.visible and c:contains(contentX, contentY) then
            local hit = c:handleMouse(event, btn,
                contentX - c.x + 1, contentY - c.y + 1)
            if hit then return hit end
        end
    end
    if event == "mouse_scroll" and scroll.wheel(self, btn) then return self end
    return Element.handleMouse(self, event, btn, x, y)
end
function Container:findAt(x, y)
    if scroll.isBarPoint(self, x, y) then return self end
    local scrollX, scrollY = self:getScroll()
    local contentX, contentY = x + scrollX, y + scrollY
    local ch = self:_visibleSorted()
    for i = #ch, 1, -1 do
        local c = ch[i]
        if c.visible and c:contains(contentX, contentY) then
            local lx, ly = contentX - c.x + 1, contentY - c.y + 1
            if c.findAt then
                local hit = c:findAt(lx, ly)
                if hit then return hit end
            end
            return c
        end
    end
    return self
end
function Container.register(elementName, elementClass)
    Container["add" .. elementName] = function(self, props)
        local el = elementClass.new(props)
        self:addChild(el)
        return el
    end
end
return Container
]=]
sources["core/element"] = [=[

local require = ...
local class = require("core/class")
local state = require("core/state")
local layout = require("core/layout")
local Element = class.create("Element")
class.property(Element, "x", 1)
class.property(Element, "y", 1)
class.property(Element, "z", 0, {
    onChange = function(self)
        local p = rawget(self, "parent")
        if p then p._sortDirty = true end
    end,
})
class.property(Element, "width", 1)
class.property(Element, "height", 1)
class.property(Element, "minWidth", false)
class.property(Element, "maxWidth", false)
class.property(Element, "minHeight", false)
class.property(Element, "maxHeight", false)
class.property(Element, "position", "flow")
class.property(Element, "alignSelf", false)
class.property(Element, "shrink", false)
class.property(Element, "visible", true, {
    onChange = function(self, visible)
        if not visible then
            local root = self:getRoot()
            if root._releaseSubtree then root:_releaseSubtree(self) end
        end
    end,
})
class.property(Element, "background", false)
class.property(Element, "foreground", colors.white)
class.property(Element, "name", "", { visual = false })
class.property(Element, "disabled", false, {
    state = "disabled",
    styleable = false,
    onChange = function(self, disabled)
        if disabled then
            local root = self:getRoot()
            if root._releaseSubtree then root:_releaseSubtree(self, true) end
        end
    end,
})
class.combinedProperty(Element, "Position", { "x", "y" })
class.combinedProperty(Element, "Size", { "width", "height" })
class.combinedProperty(Element, "Bounds", { "x", "y", "width", "height" })
class.combinedProperty(Element, "Colors", { "foreground", "background" })
class.combinedProperty(Element, "MinSize", { "minWidth", "minHeight" })
class.combinedProperty(Element, "MaxSize", { "maxWidth", "maxHeight" })
class.event(Element, "click")
class.event(Element, "clickUp")
class.event(Element, "drag")
class.event(Element, "scroll")
class.event(Element, "focus")
class.event(Element, "blur")
class.event(Element, "key")
class.event(Element, "keyUp")
class.event(Element, "char")
class.event(Element, "paste")
class.event(Element, "stateChange")
class.event(Element, "mouseEnter")
class.event(Element, "mouseLeave")
class.event(Element, "layout")
local statePriorities = {
    hover = 10,
    focused = 20,
    checked = 30,
    selected = 30,
    pressed = 40,
    disabled = 100,
}
local paintOnlyProperties = {
    disabled = true,
    checked = true,
    selected = true,
    active = true,
    progress = true,
    value = true,
    offset = true,
    horizontalOffset = true,
    replaceChar = true,
    sortable = true,
    sortColumn = true,
    sortDirection = true,
}
local function propertyAffectsLayout(propName)
    if not propName then return true end
    if paintOnlyProperties[propName] then return false end
    local lower = propName:lower()
    if lower:find("color", 1, true)
        or lower:find("background", 1, true)
        or lower:find("foreground", 1, true)
        or lower:find("symbol", 1, true) then
        return false
    end
    return true
end
local function styleAffectsLayout(style)
    if not style then return false end
    for propName in pairs(style) do
        if propertyAffectsLayout(propName) then return true end
    end
    return false
end
local function stateStyleAffectsLayout(self, stateName)
    local localStyle = rawget(self, "_stateStyles")[stateName]
    if styleAffectsLayout(localStyle) then return true end
    local c = rawget(self, "_class")
    while c do
        local styles = rawget(c, "__stateStyles")
        if styles and styleAffectsLayout(styles[stateName]) then return true end
        c = rawget(c, "__parent")
    end
    return false
end
local function statePriority(self, stateName)
    local custom = rawget(self, "_statePriorities")
    return (custom and custom[stateName]) or statePriorities[stateName] or 50
end
local function activeStates(self)
    local cached = rawget(self, "_activeStates")
    if cached then return cached end
    local states, seq = rawget(self, "_states"), rawget(self, "_stateSequence")
    cached = {}
    for stateName, active in pairs(states) do
        if active then cached[#cached + 1] = stateName end
    end
    table.sort(cached, function(a, b)
        local ap, bp = statePriority(self, a), statePriority(self, b)
        if ap ~= bp then return ap > bp end
        return (seq[a] or 0) > (seq[b] or 0)
    end)
    rawset(self, "_activeStates", cached)
    return cached
end
local function classStateValue(c, stateName, propName)
    while c do
        local styles = rawget(c, "__stateStyles")
        local stateStyle = styles and styles[stateName]
        if stateStyle and stateStyle[propName] ~= nil then
            return true, stateStyle[propName]
        end
        c = rawget(c, "__parent")
    end
    return false
end
Element.__stateResolver = function(self, propName, c)
    local styles = rawget(self, "_stateStyles")
    local active = activeStates(self)
    for i = 1, #active do
        local stateName = active[i]
        local localStyle = styles[stateName]
        if localStyle and localStyle[propName] ~= nil then
            return true, localStyle[propName]
        end
        local found, value = classStateValue(c, stateName, propName)
        if found then return true, value end
    end
    return false
end
function Element:setup()
    rawset(self, "_states", {})
    rawset(self, "_stateStyles", {})
    rawset(self, "_statePriorities", {})
    rawset(self, "_stateSequence", {})
    rawset(self, "_stateSequenceN", 0)
    rawset(self, "_bindings", {})
    self:on("focus", function(s) s:setState("focused", true) end)
    self:on("blur", function(s) s:setState("focused", false) end)
end
function Element:setState(stateName, active)
    if type(stateName) ~= "string" or stateName == "" then
        error("Basalt: state name must be a non-empty string", 2)
    end
    active = active ~= false and active ~= nil
    local states = rawget(self, "_states")
    if states[stateName] == active then return self end
    states[stateName] = active
    if active then
        local n = rawget(self, "_stateSequenceN") + 1
        rawset(self, "_stateSequenceN", n)
        rawget(self, "_stateSequence")[stateName] = n
    end
    rawset(self, "_activeStates", nil)
    if stateStyleAffectsLayout(self, stateName) then
        self:markLayoutDirty()
    else
        self:markRenderDirty()
    end
    self:fire("stateChange", stateName, active)
    return self
end
function Element:hasState(stateName)
    return rawget(self, "_states")[stateName] == true
end
function Element:toggleState(stateName)
    return self:setState(stateName, not self:hasState(stateName))
end
function Element:getStates()
    local result = {}
    for stateName, active in pairs(rawget(self, "_states")) do
        if active then result[#result + 1] = stateName end
    end
    table.sort(result)
    return result
end
function Element:setStateStyle(stateName, props, priority)
    if type(props) ~= "table" then
        error("Basalt: state style must be a table", 2)
    end
    local c = rawget(self, "_class")
    local style = {}
    for propName, value in pairs(props) do
        local prop = c.__props[propName]
        if not prop then
            error("Basalt: unknown state style property '" .. tostring(propName) .. "'", 2)
        end
        if not prop.styleable then
            error("Basalt: property '" .. propName .. "' cannot be state-styled", 2)
        end
        style[propName] = value
    end
    rawget(self, "_stateStyles")[stateName] = style
    if priority ~= nil then self:setStatePriority(stateName, priority) end
    if self:hasState(stateName) and styleAffectsLayout(style) then
        self:markLayoutDirty()
    else
        self:markRenderDirty()
    end
    return self
end
function Element:setStatePriority(stateName, priority)
    if type(priority) ~= "number" then
        error("Basalt: state priority must be a number", 2)
    end
    rawget(self, "_statePriorities")[stateName] = priority
    rawset(self, "_activeStates", nil)
    self:markLayoutDirty()
    return self
end
function Element:apply(props)
    for k, v in pairs(props) do
        if type(v) == "function" and k:find("^on%u") and self[k] then
            self[k](self, v)
        else
            self[k] = v
        end
    end
    return self
end
function Element:raw(propName)
    return rawget(self, "_p")[propName]
end
function Element:on(eventName, fn)
    local handlers = rawget(self, "_handlers")
    local hs = handlers[eventName]
    if not hs then
        hs = {}
        handlers[eventName] = hs
    end
    hs[#hs + 1] = fn
    return self
end
function Element:off(eventName, fn)
    local hs = rawget(self, "_handlers")[eventName]
    if not hs then return self end
    for i = #hs, 1, -1 do
        if hs[i] == fn then
            table.remove(hs, i)
            break
        end
    end
    return self
end
local defaultBindingEvents = {
    text = "change",
    checked = "change",
    value = "change",
    selected = "select",
}
function Element:bind(propName, source, options)
    local c = rawget(self, "_class")
    if not c.__props[propName] then
        error("Basalt: cannot bind unknown property '" .. tostring(propName) .. "'", 2)
    end
    if not state.is(source) then
        error("Basalt: bind expects a state or computed value", 2)
    end
    if type(options) == "function" then
        options = { fromState = options }
    else
        options = options or {}
    end
    if type(options) ~= "table" then
        error("Basalt: bind options must be a function or table", 2)
    end
    self:unbind(propName)
    local boundValue = source
    if options.fromState then
        local transform = options.fromState
        if type(transform) ~= "function" then
            error("Basalt: fromState must be a function", 2)
        end
        local el = self
        boundValue = state.computed(function()
            return transform(source:get(), el)
        end)
    end
    local binding = { source = source, value = boundValue }
    local eventName = options.event or defaultBindingEvents[propName]
    local twoWay = options.twoWay ~= false and state.isWritable(source)
        and eventName ~= nil
    if twoWay then
        local toState = options.toState
        if toState ~= nil and type(toState) ~= "function" then
            error("Basalt: toState must be a function", 2)
        end
        local writableSource = source
        binding.event = eventName
        binding.handler = function(_, value, ...)
            if toState then value = toState(value, self, ...) end
            writableSource:set(value)
            self[propName] = boundValue
        end
        self:on(eventName, binding.handler)
    end
    rawget(self, "_bindings")[propName] = binding
    self[propName] = boundValue
    local _ = self[propName]
    return self
end
function Element:unbind(propName, keepCurrent)
    local bindings = rawget(self, "_bindings")
    local binding = bindings and bindings[propName]
    if not binding then return self end
    local current = self[propName]
    if binding.handler then self:off(binding.event, binding.handler) end
    bindings[propName] = nil
    if keepCurrent == false then
        rawget(self, "_p")[propName] = nil
        self:markDirty()
    else
        self[propName] = current
    end
    return self
end
function Element:fire(eventName, ...)
    local hs = self._handlers[eventName]
    if not hs then return false end
    for i = 1, #hs do
        hs[i](self, ...)
    end
    return true
end
function Element:markDirty()
    return self:markLayoutDirty()
end
function Element:markRenderDirty()
    local n = self
    local p = rawget(n, "parent")
    while p do
        n = p
        p = rawget(n, "parent")
    end
    rawset(n, "_dirty", true)
    return self
end
function Element:invalidateLayout(propName)
    if propName and not propertyAffectsLayout(propName) then return self end
    local n = self
    while n do
        if rawget(n, "_children") then
            rawset(n, "_layoutDirty", true)
            rawset(n, "_viewportDirty", true)
        end
        n = rawget(n, "parent")
    end
    return self
end
function Element:markLayoutDirty()
    self:invalidateLayout()
    return self:markRenderDirty()
end
function Element:contains(px, py)
    local x, y = self.x, self.y
    return px >= x and py >= y and px < x + self.width and py < y + self.height
end
function Element:getRoot()
    local n = self
    while rawget(n, "parent") do
        n = rawget(n, "parent")
    end
    return n
end
function Element:getAbsolutePosition()
    local x, y = self.x, self.y
    local p = rawget(self, "parent")
    while p do
        x = x + p.x - 1 - (rawget(p, "_scrollX") or 0)
        y = y + p.y - 1 - (rawget(p, "_scrollY") or 0)
        p = rawget(p, "parent")
    end
    return x, y
end
function Element:measure(_availableWidth, _availableHeight)
    local w, h = layout.spec(self, "width"), layout.spec(self, "height")
    return type(w) == "number" and w or 1, type(h) == "number" and h or 1
end
function Element:focus()
    if self.disabled then return self end
    local root = self:getRoot()
    if root.setFocused then root:setFocused(self) end
    return self
end
function Element:setCursor(x, y, blink, color)
    local root = self:getRoot()
    if root ~= self and root.setCursor and root.getFocused
        and root:getFocused() == self then
        local ax, ay = self:getAbsolutePosition()
        local cursorX, cursorY = ax + x - 1, ay + y - 1
        local visible = x >= 1 and y >= 1 and x <= self.width and y <= self.height
        local p = rawget(self, "parent")
        while visible and p do
            local px, py = p:getAbsolutePosition()
            if cursorX < px or cursorY < py
                or cursorX >= px + p.width or cursorY >= py + p.height then
                visible = false
            end
            p = rawget(p, "parent")
        end
        if visible then
            root:setCursor(cursorX, cursorY, blink, color)
        else
            root:setCursor(1, 1, false, color)
        end
    end
    return self
end
function Element:destroy()
    local p = rawget(self, "parent")
    if p then p:removeChild(self) end
    return self
end
function Element:render(buf)
    local bg = self.background
    if bg then
        buf:fill(1, 1, self.width, self.height, " ", self.foreground, bg)
    end
end
function Element:handleMouse(event, btn, x, y)
    if self.disabled then return nil end
    if event == "mouse_click" then
        if self.background or self._handlers.click then
            self:setState("pressed", true)
            self:focus()
            self:fire("click", btn, x, y)
            return self
        end
    elseif event == "mouse_scroll" then
        if self._handlers.scroll then
            self:fire("scroll", btn, x, y)
            return self
        end
    end
    return nil
end
function Element:handleKey(event, a, b)
    if self.disabled then return end
    if event == "key" then
        self:fire("key", a, b)
    elseif event == "key_up" then
        self:fire("keyUp", a)
    elseif event == "char" then
        self:fire("char", a)
    elseif event == "paste" then
        self:fire("paste", a)
    end
end
return Element
]=]
sources["core/errors"] = [=[

local require, basaltDir = ...
local errors = {}
local function trim(s)
    return s:match("^%s*(.-)%s*$")
end
local function isInternal(file)
    return file == "[C]"
        or file:sub(1, 1) == "("
        or file:find("^reactive{")
        or (basaltDir ~= "" and file:find(basaltDir, 1, true) == 1)
end
function errors.parse(err, trace)
    local msg = tostring(err)
    local file, line, rest = msg:match("^(.-):(%d+): (.*)$")
    local lines = {}
    if trace then
        for tl in trace:gmatch("[^\n]+") do
            tl = trim(tl)
            if tl ~= "" and tl ~= "stack traceback:"
                and not tl:find("in function 'xpcall'", 1, true) then
                lines[#lines + 1] = tl
            end
        end
    end
    local userFile, userLine
    for _, tl in ipairs(lines) do
        local f, l = tl:match("^(.-):(%d+):")
        if f and not isInternal(f) then
            userFile, userLine = f, tonumber(l)
            break
        end
    end
    return {
        message = rest or msg,
        file = file,
        line = line and tonumber(line),
        userFile = userFile,
        userLine = userLine,
        trace = lines,
    }
end
local function cprint(text, color)
    term.setTextColor(color)
    print(text)
end
local function readSourceLine(file, lineNo)
    if not fs.exists(file) or fs.isDir(file) then return nil end
    local h = fs.open(file, "r")
    if not h then return nil end
    local content, n = nil, 0
    repeat
        content = h.readLine()
        n = n + 1
    until n == lineNo or content == nil
    h.close()
    return content
end
function errors.show(err, trace, showTrace)
    local info = errors.parse(err, trace)
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1, 1)
    cprint("Basalt Error", colors.red)
    print()
    cprint(info.message, colors.white)
    print()
    local exFile = info.userFile or info.file
    local exLine = info.userLine or info.line
    if exFile and exLine then
        local src = readSourceLine(exFile, exLine)
        cprint("\26 " .. exFile .. ":" .. exLine, colors.cyan)
        if src then cprint("  " .. trim(src), colors.lightGray) end
        print()
    end
    if showTrace ~= false and #info.trace > 0 then
        cprint("Traceback:", colors.gray)
        for i = 1, math.min(#info.trace, 6) do
            local tl = info.trace[i]
            local f = tl:match("^(.-):%d+:")
            cprint("  " .. tl, (f and not isInternal(f))
                and colors.lightGray or colors.gray)
        end
        if #info.trace > 6 then
            cprint("  ... (" .. (#info.trace - 6) .. " more)", colors.gray)
        end
        print()
    end
    cprint("Press any key to exit", colors.orange)
        while true do
            local e = os.pullEventRaw()
        if e == "key" or e == "mouse_click"
            or e == "monitor_touch" or e == "terminate" then
            break
        end
    end
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
    term.setCursorPos(1, 1)
end
function errors.wrap(err, trace)
    return setmetatable({ __basaltError = true, err = err, trace = trace }, {
        __tostring = function(t) return tostring(t.err) end,
    })
end
return errors
]=]
sources["core/itemview"] = [=[

local itemview = {}
function itemview.maxOffset(count, rows)
    return math.max(0, count - math.max(0, rows))
end
function itemview.clampOffset(offset, count, rows)
    return math.max(0, math.min(math.floor(offset or 0),
        itemview.maxOffset(count, rows)))
end
function itemview.ensureVisible(offset, index, count, rows)
    offset = itemview.clampOffset(offset, count, rows)
    if not index or index < 1 then return offset end
    if index <= offset then offset = index - 1 end
    if index > offset + rows then offset = index - rows end
    return itemview.clampOffset(offset, count, rows)
end
function itemview.geometry(count, rows, offset, mode)
    if mode ~= "auto" and mode ~= "always" and mode ~= "hidden" then
        error("Basalt item scrollbar: expected 'auto', 'always' or 'hidden'", 3)
    end
    rows = math.max(0, math.floor(rows or 0))
    local maximum = itemview.maxOffset(count, rows)
    offset = itemview.clampOffset(offset, count, rows)
    local show = mode ~= "hidden" and rows > 0
        and (mode == "always" or maximum > 0)
    local thumbSize = rows
    local thumbPos = 0
    if show and rows > 0 then
        thumbSize = math.max(1, math.floor(rows * rows / math.max(count, rows)))
        thumbSize = math.min(rows, thumbSize)
        local travel = rows - thumbSize
        thumbPos = maximum > 0
            and math.floor(travel * offset / maximum + 0.5) or 0
    end
    return {
        show = show,
        rows = rows,
        maximum = maximum,
        offset = offset,
        thumbSize = thumbSize,
        thumbPos = thumbPos,
    }
end
function itemview.draw(buf, x, y, geometry, foreground, track, thumb)
    if not geometry.show or geometry.rows <= 0 then return end
    buf:fill(x, y, 1, geometry.rows, " ", foreground, track)
    buf:fill(x, y + geometry.thumbPos, 1, geometry.thumbSize,
        " ", foreground, thumb)
end
function itemview.pointerDown(coordinate, geometry)
    if not geometry.show then return nil, nil end
    local thumbStart = geometry.thumbPos + 1
    if coordinate >= thumbStart
        and coordinate < thumbStart + geometry.thumbSize then
        return geometry.offset, coordinate - thumbStart
    end
    local travel = math.max(1, geometry.rows - geometry.thumbSize)
    local target = math.floor((coordinate - 1 - geometry.thumbSize / 2)
        / travel * geometry.maximum + 0.5)
    return itemview.clampOffset(target,
        geometry.maximum + geometry.rows, geometry.rows), nil
end
function itemview.drag(coordinate, grab, geometry)
    local travel = math.max(1, geometry.rows - geometry.thumbSize)
    local pos = math.max(0, math.min(travel, coordinate - 1 - grab))
    local target = math.floor(pos / travel * geometry.maximum + 0.5)
    return itemview.clampOffset(target,
        geometry.maximum + geometry.rows, geometry.rows)
end
return itemview
]=]
sources["core/layout"] = [=[

local require = ...
local state = require("core/state")
local layout = {}
local Token = {}
Token.__index = Token
Token.__basaltLayoutValue = true
local function token(kind, value)
    return setmetatable({ kind = kind, value = value }, Token)
end
function layout.auto()
    return token("auto")
end
function layout.fill(weight)
    weight = weight or 1
    if type(weight) ~= "number" or weight <= 0 then
        error("Basalt layout: fill weight must be greater than zero", 2)
    end
    return token("fill", weight)
end
function layout.percent(amount)
    if type(amount) ~= "number" or amount < 0 then
        error("Basalt layout: percent must be a non-negative number", 2)
    end
    return token("percent", amount)
end
function layout.is(value)
    local mt = type(value) == "table" and getmetatable(value)
    return mt and mt.__basaltLayoutValue == true or false
end
function layout.spec(el, propName)
    local c = rawget(el, "_class")
    if c and c.__getPropertySpec then
        local found, value = c.__getPropertySpec(el, propName)
        if found then return value end
    end
    return el:raw(propName)
end
local function round(value)
    return math.floor(value + 0.5)
end
local function clamp(value, minimum, maximum)
    if minimum and value < minimum then value = minimum end
    if maximum and value > maximum then value = maximum end
    return math.max(0, round(value))
end
function layout.constrain(el, axis, value)
    local minName = axis == "width" and "minWidth" or "minHeight"
    local maxName = axis == "width" and "maxWidth" or "maxHeight"
    local minimum, maximum = el[minName], el[maxName]
    if minimum == false then minimum = nil end
    if maximum == false then maximum = nil end
    return clamp(value, minimum, maximum)
end
function layout.measure(el, availableWidth, availableHeight)
    if el.measure then return el:measure(availableWidth, availableHeight) end
    return 1, 1
end
function layout.resolveSize(el, axis, spec, availableWidth, availableHeight)
    local available = axis == "width" and availableWidth or availableHeight
    local measuredW, measuredH
    local value
    if layout.is(spec) then
        if spec.kind == "percent" then
            value = available * spec.value
        elseif spec.kind == "fill" then
            value = available
        else
            measuredW, measuredH = layout.measure(el, availableWidth, availableHeight)
            value = axis == "width" and measuredW or measuredH
        end
    else
        value = tonumber(spec) or 1
    end
    return layout.constrain(el, axis, value)
end
function layout.resolveToken(value, el, propName)
    local parent = rawget(el, "parent")
    local availableWidth = parent and parent.width or 1
    local availableHeight = parent and parent.height or 1
    if value.kind == "fill" and parent then
        if propName == "width" then
            availableWidth = math.max(0, availableWidth - (tonumber(layout.spec(el, "x")) or 1) + 1)
        elseif propName == "height" then
            availableHeight = math.max(0, availableHeight - (tonumber(layout.spec(el, "y")) or 1) + 1)
        end
    end
    return layout.resolveSize(el, propName, value, availableWidth, availableHeight)
end
function layout.resolveFreeChild(parent, child)
    local xSpec, ySpec = layout.spec(child, "x"), layout.spec(child, "y")
    local wSpec, hSpec = layout.spec(child, "width"), layout.spec(child, "height")
    local hasToken = layout.is(xSpec) or layout.is(ySpec)
        or layout.is(wSpec) or layout.is(hSpec)
    if not hasToken then
        local old = rawget(child, "_layoutBox")
        rawset(child, "_layoutBox", nil)
        if old and rawget(child, "_children") then
            rawset(child, "_layoutDirty", true)
            rawset(child, "_viewportDirty", true)
        end
        return
    end
    local pw, ph = parent.width, parent.height
    local x = tonumber(xSpec) or 1
    local y = tonumber(ySpec) or 1
    local aw, ah = math.max(0, pw - x + 1), math.max(0, ph - y + 1)
    local w = layout.resolveSize(child, "width", wSpec, aw, ah)
    local h = layout.resolveSize(child, "height", hSpec, aw, ah)
    local old = rawget(child, "_layoutBox")
    rawset(child, "_layoutBox", { x = round(x), y = round(y), width = w, height = h })
    if rawget(child, "_children") and (not old
        or old.width ~= w or old.height ~= h) then
        rawset(child, "_layoutDirty", true)
        rawset(child, "_viewportDirty", true)
    end
end
function layout.resolveFreeChildren(parent)
    local children = parent:getChildren()
    for i = 1, #children do layout.resolveFreeChild(parent, children[i]) end
end
function layout.setBox(el, x, y, width, height)
    local box = {
        x = round(x), y = round(y),
        width = math.max(0, round(width)),
        height = math.max(0, round(height)),
    }
    local old = rawget(el, "_layoutBox")
    rawset(el, "_layoutBox", box)
    if rawget(el, "_children") and (not old
        or old.width ~= box.width or old.height ~= box.height) then
        rawset(el, "_layoutDirty", true)
        rawset(el, "_viewportDirty", true)
    end
end
return layout
]=]
sources["core/palette"] = [=[

local palette = {}
local floor = math.floor
local char = string.char
local NATIVE_HEX = {
    [0] = 0xF0F0F0, 0xF2B233, 0xE57FD8, 0x99B2F2,
    0xDEDE6C, 0x7FCC19, 0xF2B2CC, 0x4C4C4C,
    0x999999, 0x4C99B2, 0xB266E5, 0x3366CC,
    0x7F664C, 0x57A64E, 0xCC4C4C, 0x111111,
}
local reg = {}
local regCount = 16
local charOf = {}
local dedupe = {}
local function hexToRGB(n)
    return floor(n / 65536) / 255, floor(n / 256) % 256 / 255, (n % 256) / 255
end
for i = 0, 15 do
    reg[i] = { hexToRGB(NATIVE_HEX[i]) }
    charOf[2 ^ i] = char(i)
    dedupe[NATIVE_HEX[i]] = 2 ^ i
end
palette.charOf = charOf
function palette.getRGB(value)
    local index
    if type(value) == "string" then
        index = value:byte()
    elseif charOf[value] then
        index = charOf[value]:byte()
    else
        index = value
    end
    local rgb = reg[index]
    if not rgb then error("Basalt: unknown registry color " .. tostring(value), 2) end
    return rgb[1], rgb[2], rgb[3]
end
local function clamp01(v)
    if v < 0 then return 0 end
    if v > 1 then return 1 end
    return v
end
local function parse(r, g, b)
    if type(r) == "string" then
        local hex = r:gsub("#", "")
        if hex:match("^%x%x%x$") then
            hex = hex:gsub("%x", "%0%0")
        elseif hex:match("^%x%x%x%x%x%x%x%x$") then
            hex = hex:sub(3)
        elseif not hex:match("^%x%x%x%x%x%x$") then
            error("Basalt: invalid color string '" .. r
                .. "' (expected #RGB, #RRGGBB or #AARRGGBB)", 3)
        end
        return hexToRGB(tonumber(hex, 16))
    end
    if g == nil then
        if r < 0 or r > 0xFFFFFF or r % 1 ~= 0 then
            error("Basalt: invalid color number "
                .. tostring(r) .. " (expected 0x000000-0xFFFFFF)", 3)
        end
        return hexToRGB(r)
    end
    if b == nil then
        error("Basalt: blue component is required when green is provided", 3)
    end
    if r > 1 or g > 1 or b > 1 then
        r, g, b = r / 255, g / 255, b / 255
    end
    return clamp01(r), clamp01(g), clamp01(b)
end
function palette.rgb(r, g, b)
    local rr, gg, bb = parse(r, g, b)
    local key = floor(rr * 255 + 0.5) * 65536 + floor(gg * 255 + 0.5) * 256 + floor(bb * 255 + 0.5)
    local known = dedupe[key]
    if known then return known end
    if regCount > 255 then
        local best, bestDistance = 0, math.huge
        for index = 0, 255 do
            local rgb = reg[index]
            local distance = (rr - rgb[1]) ^ 2 + (gg - rgb[2]) ^ 2 + (bb - rgb[3]) ^ 2
            if distance < bestDistance then best, bestDistance = index, distance end
        end
        local fallback = best < 16 and 2 ^ best or 0x10000 + best
        dedupe[key] = fallback
        return fallback
    end
    local idx = regCount
    regCount = regCount + 1
    reg[idx] = { rr, gg, bb }
    local handle = 0x10000 + idx
    charOf[handle] = char(idx)
    dedupe[key] = handle
    return handle
end
function palette.hasVirtual()
    return regCount > 16
end
local HEXC = {}
for i = 0, 15 do HEXC[i] = ("%x"):format(i) end
local identity = {}
for i = 0, 15 do identity[char(i)] = HEXC[i] end
palette.identityMap = identity
local HEX2BYTE = {}
for i = 0, 15 do
    HEX2BYTE[HEXC[i]] = char(i)
    HEX2BYTE[HEXC[i]:upper()] = char(i)
end
palette.hexToByte = HEX2BYTE
function palette.windowTranslation(win)
    local getPal = win.getPaletteColour or win.getPaletteColor
    if not getPal then return nil end
    local translate
    for i = 0, 15 do
        local ok, r, g, b = pcall(getPal, 2 ^ i)
        if ok and type(r) == "number" and type(g) == "number"
            and type(b) == "number" then
            local nr, ng, nb = palette.getRGB(i)
            if math.abs(r - nr) + math.abs(g - ng) + math.abs(b - nb) > 0.004 then
                if not translate then
                    translate = {}
                    for k, v in pairs(HEX2BYTE) do translate[k] = v end
                end
                local byte = charOf[palette.rgb(r, g, b)]
                translate[HEXC[i]] = byte
                translate[HEXC[i]:upper()] = byte
            end
        end
    end
    return translate
end
local Mapper = {}
Mapper.__index = Mapper
function palette.newMapper(t)
    return setmetatable({
        term = t,
        overridden = {},
        prevSlot = {},
        prevMap = {},
    }, Mapper)
end
local function dist(a, b)
    local dr, dg, db = a[1] - b[1], a[2] - b[2], a[3] - b[3]
    return dr * dr + dg * dg + db * db
end
function Mapper:build(used)
    local t = self.term
    local setPal = t.setPaletteColour or t.setPaletteColor
    local map = {}
    local occupant = {}
    for i = 0, 15 do
        map[char(i)] = HEXC[i]
        if used[i] then
            occupant[i] = i
            if setPal and self.overridden[i] then
                local n = reg[i]
                setPal(2 ^ i, n[1], n[2], n[3])
                self.overridden[i] = nil
            end
        end
    end
    local virt = {}
    for idx in pairs(used) do
        if idx > 15 then virt[#virt + 1] = idx end
    end
    if #virt > 0 then
        table.sort(virt)
        local leftovers = {}
        if setPal then
            local function assign(idx, slot)
                occupant[slot] = idx
                self.prevSlot[idx] = slot
                if self.overridden[slot] ~= idx then
                    local c = reg[idx]
                    setPal(2 ^ slot, c[1], c[2], c[3])
                    self.overridden[slot] = idx
                end
                map[char(idx)] = HEXC[slot]
            end
            local pending = {}
            for _, idx in ipairs(virt) do
                local s = self.prevSlot[idx]
                if s and occupant[s] == nil then
                    assign(idx, s)
                else
                    pending[#pending + 1] = idx
                end
            end
            local nextSlot = 0
            for _, idx in ipairs(pending) do
                local slot
                while nextSlot <= 15 do
                    if occupant[nextSlot] == nil then
                        slot = nextSlot
                        break
                    end
                    nextSlot = nextSlot + 1
                end
                if slot then
                    assign(idx, slot)
                else
                    leftovers[#leftovers + 1] = idx
                end
            end
        else
            leftovers = virt
        end
        for _, idx in ipairs(leftovers) do
            local c = reg[idx]
            local best, bestD = 15, math.huge
            for s = 0, 15 do
                local occ = occupant[s]
                local shown = occ and reg[occ] or (not setPal and reg[s] or nil)
                if shown then
                    local d = dist(c, shown)
                    if d < bestD then best, bestD = s, d end
                end
            end
            map[char(idx)] = HEXC[best]
        end
    end
    local changed = false
    local prev = self.prevMap
    for k, v in pairs(map) do
        if prev[k] ~= nil and prev[k] ~= v then
            changed = true
            break
        end
    end
    self.prevMap = map
    return map, changed
end
function Mapper:restore()
    local t = self.term
    local setPal = t.setPaletteColour or t.setPaletteColor
    if setPal then
        for slot in pairs(self.overridden) do
            local n = reg[slot]
            setPal(2 ^ slot, n[1], n[2], n[3])
        end
    end
    self.overridden, self.prevSlot, self.prevMap = {}, {}, {}
end
return palette
]=]
sources["core/reactive"] = [=[

local require = ...
local palette = require("core/palette")
local reactive = {}
local helpers = {
    colors = colors,
    math = math,
    rgb = palette.rgb,
    tostring = tostring,
    tonumber = tonumber,
    clamp = function(v, lo, hi) return math.min(math.max(v, lo), hi) end,
    round = function(v) return math.floor(v + 0.5) end,
    floor = math.floor,
    ceil = math.ceil,
    abs = math.abs,
    min = math.min,
    max = math.max,
}
function reactive.compile(str, element)
    local expr = str:sub(2, -2)
    local env = setmetatable({}, {
        __index = function(_, key)
            if key == "self" then return element end
            if key == "parent" then return rawget(element, "parent") end
            local h = helpers[key]
            if h ~= nil then return h end
            local root = element:getRoot()
            if root.find then return root:find(key) end
            return nil
        end,
    })
    local fn, err = load("return " .. expr, "reactive" .. str, "t", env)
    if not fn then
        error("Basalt: invalid reactive expression " .. str
            .. ": " .. tostring(err), 3)
    end
    return fn
end
return reactive
]=]
sources["core/render"] = [=[

local require = ...
local palette = require("core/palette")
local rep, sub = string.rep, string.sub
local floor = math.floor
local charOf = palette.charOf
local mosaicChars = {}
local mosaicCache = {}
for mask = 0, 31 do mosaicChars[mask] = string.char(128 + mask) end
local Render = {}
Render.__index = Render
function Render.new(t)
    local self = setmetatable({}, Render)
    self.term = t
    self.mapper = palette.newMapper(t)
    self:resize(t.getSize())
    return self
end
function Render:resize(w, h)
    self.width, self.height = w, h
    self.text, self.fg, self.bg = {}, {}, {}
    self.prevText, self.prevFg, self.prevBg = {}, {}, {}
    local blankT = rep(" ", w)
    local blankF = rep("\0", w)
    local blankB = rep(string.char(15), w)
    for y = 1, h do
        self.text[y], self.fg[y], self.bg[y] = blankT, blankF, blankB
    end
    self.dirty = true
    self.ox, self.oy = 0, 0
    self.cx1, self.cy1, self.cx2, self.cy2 = 1, 1, w, h
    self.stack, self.stackN = {}, 0
    return self
end
function Render:push(x, y, w, h)
    local n, s = self.stackN, self.stack
    s[n + 1], s[n + 2], s[n + 3] = self.ox, self.oy, self.cx1
    s[n + 4], s[n + 5], s[n + 6] = self.cy1, self.cx2, self.cy2
    self.stackN = n + 6
    local ox, oy = self.ox + x - 1, self.oy + y - 1
    self.ox, self.oy = ox, oy
    if ox + 1 > self.cx1 then self.cx1 = ox + 1 end
    if oy + 1 > self.cy1 then self.cy1 = oy + 1 end
    if ox + w < self.cx2 then self.cx2 = ox + w end
    if oy + h < self.cy2 then self.cy2 = oy + h end
    return self
end
function Render:pop()
    local n, s = self.stackN, self.stack
    self.ox, self.oy, self.cx1 = s[n - 5], s[n - 4], s[n - 3]
    self.cy1, self.cx2, self.cy2 = s[n - 2], s[n - 1], s[n]
    self.stackN = n - 6
    return self
end
local function splice(line, x, str)
    return sub(line, 1, x - 1) .. str .. sub(line, x + #str)
end
local function mergeTransparent(source, underneath, mask)
    local out = {}
    for i = 1, #source do
        local marker = mask and mask:byte(i) or source:byte(i)
        out[i] = marker == 0 and sub(underneath, i, i) or sub(source, i, i)
    end
    return table.concat(out)
end
local function nearestOf(value, a, b)
    local vr, vg, vb = palette.getRGB(value)
    local ar, ag, ab = palette.getRGB(a)
    local br, bg, bb = palette.getRGB(b)
    local da = (vr - ar) ^ 2 + (vg - ag) ^ 2 + (vb - ab) ^ 2
    local db = (vr - br) ^ 2 + (vg - bg) ^ 2 + (vb - bb) ^ 2
    return da <= db and 0 or 1
end
local function compileMosaic(c1, c2, c3, c4, c5, c6)
    local key = c1 .. c2 .. c3 .. c4 .. c5 .. c6
    local cached = mosaicCache[key]
    if cached then return cached[1], cached[2], cached[3] end
    local values, counts, order = { c1, c2, c3, c4, c5, c6 }, {}, {}
    for i = 1, 6 do
        local value = values[i]
        if counts[value] then counts[value] = counts[value] + 1
        else counts[value], order[#order + 1] = 1, value end
    end
    local a, b
    for _, value in ipairs(order) do
        if not a or counts[value] > counts[a] then b, a = a, value
        elseif not b or counts[value] > counts[b] then b = value end
    end
    if not b then
        cached = { " ", a, a }
        mosaicCache[key] = cached
        return cached[1], cached[2], cached[3]
    end
    local bits = {}
    for i = 1, 6 do
        bits[i] = values[i] == a and 0
            or (values[i] == b and 1 or nearestOf(values[i], a, b))
    end
    local pivot, mask = bits[6], 0
    if bits[1] ~= pivot then mask = mask + 1 end
    if bits[2] ~= pivot then mask = mask + 2 end
    if bits[3] ~= pivot then mask = mask + 4 end
    if bits[4] ~= pivot then mask = mask + 8 end
    if bits[5] ~= pivot then mask = mask + 16 end
    local fg, bg
    if pivot == 0 then fg, bg = b, a else fg, bg = a, b end
    cached = { mosaicChars[mask], fg, bg }
    mosaicCache[key] = cached
    return cached[1], cached[2], cached[3]
end
function Render:write(x, y, str, fgChar, bgChar)
    local ay = y + self.oy
    if ay < self.cy1 or ay > self.cy2 then return self end
    local ax = x + self.ox
    local s, e = ax, ax + #str - 1
    local x1, x2 = self.cx1, self.cx2
    if s < x1 then
        str = sub(str, x1 - s + 1)
        s = x1
    end
    if e > x2 then
        str = sub(str, 1, x2 - s + 1)
        e = x2
    end
    if s > e then return self end
    self.text[ay] = splice(self.text[ay], s, str)
    if fgChar then self.fg[ay] = splice(self.fg[ay], s, rep(fgChar, e - s + 1)) end
    if bgChar then self.bg[ay] = splice(self.bg[ay], s, rep(bgChar, e - s + 1)) end
    self.dirty = true
    return self
end
local function colorChar(color)
    if not color then return nil end
    local c = charOf[color]
    if not c then
        error("Basalt: unknown color value " .. tostring(color)
            .. " (use colors.* or basalt.rgb)", 3)
    end
    return c
end
function Render:blit(x, y, str, fg, bg)
    return self:write(x, y, str, colorChar(fg), colorChar(bg))
end
function Render:colorBlit(x, y, str, foregrounds, backgrounds)
    local fg, bg = {}, {}
    for i = 1, #str do
        fg[i] = colorChar(foregrounds[i])
        bg[i] = colorChar(backgrounds[i])
    end
    return self:rawBlit(x, y, str, table.concat(fg), table.concat(bg))
end
function Render:drawText(x, y, str)
    return self:write(x, y, str)
end
function Render:rawBlit(x, y, str, fgStr, bgStr)
    local ay = y + self.oy
    if ay < self.cy1 or ay > self.cy2 then return self end
    local ax = x + self.ox
    local s, e = ax, ax + #str - 1
    local x1, x2 = self.cx1, self.cx2
    local cutFront = s < x1 and (x1 - s) or 0
    local cutBack = e > x2 and (e - x2) or 0
    if cutFront > 0 or cutBack > 0 then
        s = s + cutFront
        e = e - cutBack
        if s > e then return self end
        str = sub(str, 1 + cutFront, #str - cutBack)
        if fgStr then fgStr = sub(fgStr, 1 + cutFront, #fgStr - cutBack) end
        if bgStr then bgStr = sub(bgStr, 1 + cutFront, #bgStr - cutBack) end
    end
    self.text[ay] = splice(self.text[ay], s, str)
    if fgStr then self.fg[ay] = splice(self.fg[ay], s, fgStr) end
    if bgStr then self.bg[ay] = splice(self.bg[ay], s, bgStr) end
    self.dirty = true
    return self
end
function Render:maskedBlit(x, y, str, fgStr, bgStr, textMask, fgMask, bgMask)
    local ay, ax = y + self.oy, x + self.ox
    if ay < self.cy1 or ay > self.cy2 then return self end
    local s, e = ax, ax + #str - 1
    local cutFront = s < self.cx1 and self.cx1 - s or 0
    local cutBack = e > self.cx2 and e - self.cx2 or 0
    if cutFront > 0 or cutBack > 0 then
        s, e = s + cutFront, e - cutBack
        if s > e then return self end
        str = sub(str, 1 + cutFront, #str - cutBack)
        fgStr = fgStr and sub(fgStr, 1 + cutFront, #fgStr - cutBack)
        bgStr = bgStr and sub(bgStr, 1 + cutFront, #bgStr - cutBack)
        textMask = textMask and sub(textMask, 1 + cutFront, #textMask - cutBack)
        fgMask = fgMask and sub(fgMask, 1 + cutFront, #fgMask - cutBack)
        bgMask = bgMask and sub(bgMask, 1 + cutFront, #bgMask - cutBack)
    end
    local oldText = sub(self.text[ay], s, e)
    self.text[ay] = splice(self.text[ay], s, mergeTransparent(str, oldText, textMask))
    if fgStr then
        local oldFg = sub(self.fg[ay], s, e)
        self.fg[ay] = splice(self.fg[ay], s, mergeTransparent(fgStr, oldFg, fgMask))
    end
    if bgStr then
        local oldBg = sub(self.bg[ay], s, e)
        self.bg[ay] = splice(self.bg[ay], s, mergeTransparent(bgStr, oldBg, bgMask))
    end
    self.dirty = true
    return self
end
function Render:drawPixels(x, y, pixelWidth, pixelHeight, rows, paletteBytes)
    local cellWidth, cellHeight = math.ceil(pixelWidth / 2), math.ceil(pixelHeight / 3)
    for cellY = 1, cellHeight do
        local text, fg, bg, mask, rowHasPixels = {}, {}, {}, {}, false
        for cellX = 1, cellWidth do
            local absoluteX, absoluteY = x + cellX - 1 + self.ox, y + cellY - 1 + self.oy
            local visible = absoluteX >= self.cx1 and absoluteX <= self.cx2
                and absoluteY >= self.cy1 and absoluteY <= self.cy2
            local values, any = {}, false
            if visible then
                local underneath, underBg = {}, sub(self.bg[absoluteY], absoluteX, absoluteX)
                local underCode = self.text[absoluteY]:byte(absoluteX)
                if underCode and underCode >= 128 and underCode <= 159 then
                    local underFg, underMask = sub(self.fg[absoluteY], absoluteX, absoluteX), underCode - 128
                    local weights = { 1, 2, 4, 8, 16 }
                    for slot = 1, 5 do
                        underneath[slot] = floor(underMask / weights[slot]) % 2 == 1 and underFg or underBg
                    end
                    underneath[6] = underBg
                else
                    for slot = 1, 6 do underneath[slot] = underBg end
                end
                for py = 1, 3 do
                    local sourceY = (cellY - 1) * 3 + py
                    for px = 1, 2 do
                        local sourceX = (cellX - 1) * 2 + px
                        local slot = (py - 1) * 2 + px
                        local index = sourceY <= pixelHeight and sourceX <= pixelWidth
                            and rows[sourceY]:byte(sourceX) or 0
                        if index ~= 0 then
                            values[slot], any = paletteBytes[index], true
                            if not values[slot] then error("Basalt: FLIMG palette index " .. index .. " is missing", 2) end
                        else values[slot] = underneath[slot] end
                    end
                end
            end
            if any then
                text[cellX], fg[cellX], bg[cellX] = compileMosaic(
                    values[1], values[2], values[3], values[4], values[5], values[6])
                mask[cellX], rowHasPixels = "\1", true
            else
                text[cellX], fg[cellX], bg[cellX] = "\0", "\0", "\0"
                mask[cellX] = "\0"
            end
        end
        if rowHasPixels then
            local visibleMask = table.concat(mask)
            self:maskedBlit(x, y + cellY - 1,
                table.concat(text), table.concat(fg), table.concat(bg),
                visibleMask, visibleMask, visibleMask)
        end
    end
    return self
end
local HEXBYTE = {}
for i = 0, 15 do
    HEXBYTE[("%x"):format(i)] = string.char(i)
    HEXBYTE[("%X"):format(i)] = string.char(i)
end
function Render:drawBlit(x, y, str, fgHex, bgHex)
    return self:rawBlit(x, y, str,
        fgHex and (fgHex:gsub(".", HEXBYTE)),
        bgHex and (bgHex:gsub(".", HEXBYTE)))
end
function Render:fill(x, y, w, h, ch, fg, bg)
    local row = rep(ch, w)
    local f, b = colorChar(fg), colorChar(bg)
    for dy = 0, h - 1 do
        self:write(x, y + dy, row, f, b)
    end
    return self
end
function Render:setCursor(x, y, blink, color)
    self.cursorX, self.cursorY, self.cursorBlink = x, y, blink
    self.cursorColor = color
    self.dirty = true
    return self
end
local function scanLine(line, used)
    for i = 1, #line do
        used[line:byte(i)] = true
    end
end
function Render:flush()
    if not self.dirty then return self end
    local t = self.term
    local map, force
    if palette.hasVirtual() then
        local used = {}
        for y = 1, self.height do
            scanLine(self.fg[y], used)
            scanLine(self.bg[y], used)
        end
        map, force = self.mapper:build(used)
    else
        map, force = palette.identityMap, false
    end
    local prevT, prevF, prevB = self.prevText, self.prevFg, self.prevBg
    for y = 1, self.height do
        local tx, f, b = self.text[y], self.fg[y], self.bg[y]
        if force or tx ~= prevT[y] or f ~= prevF[y] or b ~= prevB[y] then
            t.setCursorPos(1, y)
            t.blit(tx, (f:gsub(".", map)), (b:gsub(".", map)))
            prevT[y], prevF[y], prevB[y] = tx, f, b
        end
    end
    if self.cursorBlink then
        local ch = self.cursorColor and charOf[self.cursorColor]
        local hex = ch and map[ch]
        if hex then t.setTextColor(2 ^ tonumber(hex, 16)) end
        t.setCursorPos(self.cursorX, self.cursorY)
        t.setCursorBlink(true)
    else
        t.setCursorBlink(false)
    end
    self.dirty = false
    return self
end
return Render
]=]
sources["core/scroll"] = [=[

local scroll = {}
local function clamp(value, minimum, maximum)
    if value < minimum then return minimum end
    if value > maximum then return maximum end
    return value
end
local function offsets(self)
    return rawget(self, "_scrollX") or 0, rawget(self, "_scrollY") or 0
end
local function maxOffsets(self)
    return math.max(0, (rawget(self, "_contentWidth") or 0) - self.width),
        math.max(0, (rawget(self, "_contentHeight") or 0) - self.height)
end
local function barMode(self)
    local mode = self.scrollbar
    if mode ~= "auto" and mode ~= "always" and mode ~= "hidden" then
        error("Basalt scroll: scrollbar must be 'auto', 'always' or 'hidden'", 3)
    end
    return mode
end
function scroll.disable(self)
    rawset(self, "_scrollX", 0)
    rawset(self, "_scrollY", 0)
    rawset(self, "_showScrollX", false)
    rawset(self, "_showScrollY", false)
    rawset(self, "_scrollDrag", nil)
    rawset(self, "_viewportDirty", true)
end
function scroll.setup(self)
    rawset(self, "_scrollX", 0)
    rawset(self, "_scrollY", 0)
    rawset(self, "_contentWidth", 0)
    rawset(self, "_contentHeight", 0)
    self:on("drag", function(s, _, x, y)
        scroll.drag(s, x, y)
    end)
    self:on("clickUp", function(s)
        rawset(s, "_scrollDrag", nil)
    end)
end
function scroll.update(self)
    local children = self:getChildren()
    local contentWidth, contentHeight = 0, 0
    for i = 1, #children do
        local child = children[i]
        if child.visible then
            contentWidth = math.max(contentWidth, child.x + child.width - 1)
            contentHeight = math.max(contentHeight, child.y + child.height - 1)
        end
    end
    rawset(self, "_contentWidth", contentWidth)
    rawset(self, "_contentHeight", contentHeight)
    if not self.scrollable then
        scroll.disable(self)
        return
    end
    local mode = barMode(self)
    local overflowX = self.scrollXEnabled and contentWidth > self.width
    local overflowY = self.scrollYEnabled and contentHeight > self.height
    rawset(self, "_showScrollX", mode ~= "hidden"
        and self.scrollXEnabled and (mode == "always" or overflowX))
    rawset(self, "_showScrollY", mode ~= "hidden"
        and self.scrollYEnabled and (mode == "always" or overflowY))
    local maxX, maxY = maxOffsets(self)
    local x, y = offsets(self)
    rawset(self, "_scrollX", self.scrollXEnabled and clamp(x, 0, maxX) or 0)
    rawset(self, "_scrollY", self.scrollYEnabled and clamp(y, 0, maxY) or 0)
    rawset(self, "_viewportDirty", true)
end
local function thumb(trackLength, viewport, content, offset, maximum)
    if trackLength <= 0 then return 1, 0 end
    local size = math.max(1, math.floor(trackLength * viewport
        / math.max(content, viewport)))
    size = math.min(trackLength, size)
    local travel = trackLength - size
    local pos = maximum > 0 and math.floor(travel * offset / maximum + 0.5) or 0
    return size, pos
end
function scroll.geometry(self)
    local showX = rawget(self, "_showScrollX") == true
    local showY = rawget(self, "_showScrollY") == true
    local x, y = offsets(self)
    local maxX, maxY = maxOffsets(self)
    local horizontalLength = math.max(0, self.width - (showY and 1 or 0))
    local verticalLength = math.max(0, self.height - (showX and 1 or 0))
    local hSize, hPos = thumb(horizontalLength, self.width,
        rawget(self, "_contentWidth") or 0, x, maxX)
    local vSize, vPos = thumb(verticalLength, self.height,
        rawget(self, "_contentHeight") or 0, y, maxY)
    return {
        showX = showX, showY = showY,
        horizontalLength = horizontalLength,
        verticalLength = verticalLength,
        horizontalThumbSize = hSize,
        horizontalThumbPos = hPos,
        verticalThumbSize = vSize,
        verticalThumbPos = vPos,
        maxX = maxX, maxY = maxY,
    }
end
function scroll.draw(self, buf)
    if not self.scrollable then return end
    local g = scroll.geometry(self)
    local track, thumbColor = self.scrollbarColor, self.scrollbarThumbColor
    if g.showY and g.verticalLength > 0 then
        buf:fill(self.width, 1, 1, g.verticalLength, " ", self.foreground, track)
        buf:fill(self.width, g.verticalThumbPos + 1, 1, g.verticalThumbSize,
            " ", self.foreground, thumbColor)
    end
    if g.showX and g.horizontalLength > 0 then
        buf:fill(1, self.height, g.horizontalLength, 1, " ", self.foreground, track)
        buf:fill(g.horizontalThumbPos + 1, self.height,
            g.horizontalThumbSize, 1, " ", self.foreground, thumbColor)
    end
    if g.showX and g.showY then
        buf:fill(self.width, self.height, 1, 1, " ", self.foreground, track)
    end
end
function scroll.set(self, x, y, emit)
    if not self.scrollable then return false end
    local oldX, oldY = offsets(self)
    local maxX, maxY = maxOffsets(self)
    x = self.scrollXEnabled and clamp(math.floor(x or oldX), 0, maxX) or 0
    y = self.scrollYEnabled and clamp(math.floor(y or oldY), 0, maxY) or 0
    if x == oldX and y == oldY then return false end
    rawset(self, "_scrollX", x)
    rawset(self, "_scrollY", y)
    rawset(self, "_viewportDirty", true)
    self:markRenderDirty()
    if emit ~= false then self:fire("scrollChange", x, y) end
    return true
end
function scroll.wheel(self, direction)
    if not self.scrollable then return false end
    local x, y = offsets(self)
    local amount = direction * math.max(1, math.floor(self.scrollStep))
    if self.scrollYEnabled and (rawget(self, "_contentHeight") or 0) > self.height then
        return scroll.set(self, x, y + amount)
    elseif self.scrollXEnabled then
        return scroll.set(self, x + amount, y)
    end
    return false
end
function scroll.isBarPoint(self, x, y)
    if not self.scrollable then return false end
    local g = scroll.geometry(self)
    if g.showY and x == self.width and y <= g.verticalLength then return "y", g end
    if g.showX and y == self.height and x <= g.horizontalLength then return "x", g end
    if g.showX and g.showY and x == self.width and y == self.height then return "corner", g end
    return false, g
end
function scroll.pointerDown(self, x, y)
    local axis, g = scroll.isBarPoint(self, x, y)
    if axis == "corner" or not axis then return axis == "corner" end
    local isY = axis == "y"
    local coordinate = isY and y or x
    local thumbPos = isY and g.verticalThumbPos or g.horizontalThumbPos
    local thumbSize = isY and g.verticalThumbSize or g.horizontalThumbSize
    local trackLength = isY and g.verticalLength or g.horizontalLength
    local maximum = isY and g.maxY or g.maxX
    local thumbStart = thumbPos + 1
    if coordinate >= thumbStart and coordinate < thumbStart + thumbSize then
        rawset(self, "_scrollDrag", {
            axis = axis,
            grab = coordinate - thumbStart,
        })
    else
        local travel = math.max(1, trackLength - thumbSize)
        local target = math.floor((coordinate - 1 - thumbSize / 2)
            / travel * maximum + 0.5)
        local sx, sy = offsets(self)
        scroll.set(self, isY and sx or target, isY and target or sy)
    end
    return true
end
function scroll.drag(self, x, y)
    local dragState = rawget(self, "_scrollDrag")
    if not dragState then return false end
    local g = scroll.geometry(self)
    local isY = dragState.axis == "y"
    local coordinate = isY and y or x
    local size = isY and g.verticalThumbSize or g.horizontalThumbSize
    local length = isY and g.verticalLength or g.horizontalLength
    local maximum = isY and g.maxY or g.maxX
    local travel = math.max(1, length - size)
    local pos = clamp(coordinate - 1 - dragState.grab, 0, travel)
    local target = math.floor(pos / travel * maximum + 0.5)
    local sx, sy = offsets(self)
    return scroll.set(self, isY and sx or target, isY and target or sy)
end
return scroll
]=]
sources["core/state"] = [=[

local state = {}
local unpack = table.unpack or unpack
local currentWatcher = nil
local Signal = {}
Signal.__index = Signal
Signal.__basaltStateValue = true
local Computed = {}
Computed.__index = Computed
Computed.__basaltStateValue = true
local function registerWatcher(signal, watcher)
    watcher = watcher or currentWatcher
    if watcher and watcher.markDirty then
        signal._watchers[watcher] = true
        local dependencies = rawget(watcher, "_stateDependencies")
        if not dependencies then
            dependencies = setmetatable({}, { __mode = "k" })
            rawset(watcher, "_stateDependencies", dependencies)
        end
        dependencies[signal] = true
    end
end
function state.clearWatcher(watcher)
    local dependencies = rawget(watcher, "_stateDependencies")
    if not dependencies then return end
    for signal in pairs(dependencies) do
        signal._watchers[watcher] = nil
        dependencies[signal] = nil
    end
end
function state.withWatcher(watcher, fn, ...)
    local previous = currentWatcher
    currentWatcher = watcher or previous
    local result = table.pack(pcall(fn, ...))
    currentWatcher = previous
    if not result[1] then error(result[2], 0) end
    return unpack(result, 2, result.n)
end
function state.is(value)
    local mt = type(value) == "table" and getmetatable(value)
    return mt and mt.__basaltStateValue == true or false
end
function state.read(value, watcher)
    return value:get(watcher)
end
function state.isWritable(value)
    return getmetatable(value) == Signal
end
function Signal:get(watcher)
    registerWatcher(self, watcher)
    return self._value
end
function Signal:set(value)
    local old = self._value
    if old == value then return self end
    self._value = value
    for watcher in pairs(self._watchers) do
        if watcher.markLayoutDirty then
            watcher:markLayoutDirty()
        else
            watcher:markDirty()
        end
    end
    for listener in pairs(self._listeners) do
        listener(value, old)
    end
    return self
end
function Signal:update(fn)
    if type(fn) ~= "function" then
        error("Basalt state: update expects a function", 2)
    end
    return self:set(fn(self._value))
end
function Signal:touch()
    for watcher in pairs(self._watchers) do
        if watcher.markLayoutDirty then
            watcher:markLayoutDirty()
        else
            watcher:markDirty()
        end
    end
    for listener in pairs(self._listeners) do
        listener(self._value, self._value)
    end
    return self
end
function Signal:subscribe(fn, immediate)
    if type(fn) ~= "function" then
        error("Basalt state: subscribe expects a function", 2)
    end
    self._listeners[fn] = true
    if immediate then fn(self._value, nil) end
    local active = true
    return function()
        if active then
            self._listeners[fn] = nil
            active = false
        end
    end
end
function Signal:map(fn)
    if type(fn) ~= "function" then
        error("Basalt state: map expects a function", 2)
    end
    local source = self
    return state.computed(function()
        return fn(source:get())
    end)
end
function Signal:__tostring()
    return tostring(self._value)
end
function Computed:get(watcher)
    return state.withWatcher(watcher, self._compute)
end
function Computed:map(fn)
    if type(fn) ~= "function" then
        error("Basalt state: map expects a function", 2)
    end
    local source = self
    return state.computed(function()
        return fn(source:get())
    end)
end
function Computed:__tostring()
    return tostring(self:get())
end
function state.create(initialValue)
    return setmetatable({
        _value = initialValue,
        _watchers = setmetatable({}, { __mode = "k" }),
        _listeners = {},
    }, Signal)
end
function state.computed(fn)
    if type(fn) ~= "function" then
        error("Basalt computed: expected a function", 2)
    end
    return setmetatable({ _compute = fn }, Computed)
end
return state
]=]
sources["core/text"] = [=[

local textutil = {}
function textutil.wrap(str, width)
    width = math.max(1, width)
    local lines = {}
    for paragraph in (tostring(str) .. "\n"):gmatch("(.-)\n") do
        local line = ""
        for word in paragraph:gmatch("%S+") do
            if #line == 0 then
                line = word
            elseif #line + 1 + #word <= width then
                line = line .. " " .. word
            else
                lines[#lines + 1] = line
                line = word
            end
            while #line > width do
                lines[#lines + 1] = line:sub(1, width)
                line = line:sub(width + 1)
            end
        end
        lines[#lines + 1] = line
    end
    if #lines > 1 and lines[#lines] == "" then
        table.remove(lines)
    end
    if #lines == 0 then lines = { "" } end
    return lines
end
return textutil
]=]
sources["elements/Button"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local Button = class.create("Button", Element)
class.property(Button, "text", "Button")
class.property(Button, "width", 10)
class.property(Button, "height", 3)
class.property(Button, "background", colors.gray)
function Button:render(buf)
    local fg, bg = self.foreground, self.background
    if self:hasState("pressed") and bg then
        fg, bg = bg, fg
    end
    local w, h = self.width, self.height
    if bg then buf:fill(1, 1, w, h, " ", fg, bg) end
    local t = tostring(self.text)
    buf:blit(
        math.floor((w - #t) / 2) + 1,
        math.floor((h - 1) / 2) + 1,
        t, fg, bg or nil
    )
end
function Button:measure()
    return math.max(3, #tostring(self.text) + 2), 3
end
return Button
]=]
sources["elements/Canvas"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local Canvas = class.create("Canvas", Element)
class.property(Canvas, "draw", false, { rawFunction = true })
function Canvas:render(buf)
    Element.render(self, buf)
    local draw = self.draw
    if draw then draw(self, buf) end
end
return Canvas
]=]
sources["elements/Checkbox"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local Checkbox = class.create("Checkbox", Element)
class.property(Checkbox, "checked", false, {
    state = "checked",
    styleable = false,
})
class.property(Checkbox, "text", "")
class.property(Checkbox, "checkedSymbol", "x")
class.property(Checkbox, "uncheckedSymbol", " ")
class.property(Checkbox, "width", function(self)
    return #tostring(self.text) + 4
end)
class.event(Checkbox, "change")
function Checkbox:setup()
    Element.setup(self)
    self:on("click", function(s)
        s.checked = not s.checked
        s:fire("change", s.checked)
    end)
end
function Checkbox:render(buf)
    Element.render(self, buf)
    local symbol = self.checked and self.checkedSymbol or self.uncheckedSymbol
    buf:blit(1, 1, "[" .. tostring(symbol):sub(1, 1) .. "] "
        .. tostring(self.text), self.foreground, nil)
end
return Checkbox
]=]
sources["elements/Collection"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local collection = require("core/collection")
local Collection = class.create("Collection", Element)
collection.install(Collection)
function Collection:setup()
    Element.setup(self)
    collection.setup(self)
end
return Collection
]=]
sources["elements/Column"] = [=[
local require = ...
local class = require("core/class")
local layout = require("core/layout")
local Flex = require("elements/Flex")
local Column = class.create("Column", Flex)
class.property(Column, "direction", "column")
class.property(Column, "width", layout.fill())
class.property(Column, "height", layout.auto())
return Column
]=]
sources["elements/ComboBox"] = [=[

local require = ...
local class = require("core/class")
local Input = require("elements/Input")
local itemview = require("core/itemview")
local collection = require("core/collection")
local ComboBox = class.create("ComboBox", Input)
collection.install(ComboBox, { changeEvent = "selectionChange" })
class.property(ComboBox, "dropHeight", 6)
class.property(ComboBox, "autoComplete", false)
class.property(ComboBox, "offset", 0)
class.property(ComboBox, "dropBackground", colors.black)
class.property(ComboBox, "dropForeground", colors.white)
class.property(ComboBox, "scrollbar", "auto")
class.property(ComboBox, "scrollbarColor", colors.gray)
class.property(ComboBox, "scrollbarThumbColor", colors.lightGray)
class.property(ComboBox, "width", 14)
class.property(ComboBox, "height", function(self)
    if self.open then
        return 1 + math.min(#self:getDisplayItems(), self.dropHeight)
    end
    return 1
end)
class.property(ComboBox, "open", false, {
    onChange = function(self, isOpen)
        if isOpen then
            rawset(self, "_zBefore", self.z)
            self.z = 999
            rawset(self, "_highlighted", 1)
            self.offset = 0
        else
            self.z = rawget(self, "_zBefore") or self.z
        end
    end,
})
function ComboBox:getDisplayItems()
    local items = self.items
    local out = {}
    local needle = self.autoComplete and self.text:lower() or ""
    for i = 1, #items do
        local label = tostring(items[i])
        if #needle == 0 or label:lower():sub(1, #needle) == needle then
            out[#out + 1] = { index = i, text = label, item = items[i] }
        end
    end
    return out
end
local function visibleRows(self, display)
    return math.min(#display, math.max(0, self.dropHeight))
end
local function geometry(self, display)
    return itemview.geometry(#display, visibleRows(self, display),
        self.offset, self.scrollbar)
end
function ComboBox:selectDisplayed(displayIndex)
    local display = self:getDisplayItems()
    local entry = display[displayIndex]
    if not entry then return self end
    rawset(self, "_selecting", true)
    self.text = entry.text
    rawset(self, "_selecting", nil)
    self:_moveCursor(#entry.text + 1)
    self.open = false
    self:activateItem(entry.index)
    return self
end
function ComboBox:clear()
    collection.methods.clear(self)
    self.open = false
    self.offset = 0
    self:markDirty()
    return self
end
function ComboBox:setup()
    Input.setup(self)
    collection.setup(self)
    self:on("click", function(s, _, x, y)
        if y == 1 then
            if x == s.width then
                s.open = not s.open
            end
            return
        end
        local display = s:getDisplayItems()
            local g = geometry(s, display)
            if g.show and x == s.width then
                local target, grab = itemview.pointerDown(y - 1, g)
                if target ~= nil then s.offset = target end
                if grab ~= nil then rawset(s, "_itemScrollDrag", grab) end
                return
        end
        s:selectDisplayed(s.offset + y - 1)
    end)
    self:on("drag", function(s, _, _, y)
        local grab = rawget(s, "_itemScrollDrag")
        if grab ~= nil then
            s.offset = itemview.drag(y - 1, grab,
                geometry(s, s:getDisplayItems()))
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_itemScrollDrag", nil)
    end)
    self:on("change", function(s)
        if s.autoComplete and not rawget(s, "_selecting") then
            s.open = #s:getDisplayItems() > 0 and #s.text > 0
            rawset(s, "_highlighted", 1)
            s.offset = 0
        end
    end)
    self:on("blur", function(s)
        s.open = false
    end)
end
function ComboBox:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" and self.open then
        if self.disabled then return nil end
        local display = self:getDisplayItems()
        self.offset = itemview.clampOffset(self.offset + btn,
            #display, visibleRows(self, display))
        return self
    end
    return Input.handleMouse(self, event, btn, x, y)
end
function ComboBox:handleKey(event, a, b)
    if event == "key" then
        if self.open then
            local display = self:getDisplayItems()
            local highlighted = rawget(self, "_highlighted") or 1
            if a == keys.escape then
                self.open = false
                return
            elseif a == keys.enter then
                self:selectDisplayed(highlighted)
                return
            elseif a == keys.up or a == keys.down then
                local delta = a == keys.down and 1 or -1
                highlighted = math.max(1,
                    math.min(#display, highlighted + delta))
                rawset(self, "_highlighted", highlighted)
                self.offset = itemview.ensureVisible(self.offset, highlighted,
                    #display, visibleRows(self, display))
                self:markDirty()
                return
            end
        elseif a == keys.down and #self:getDisplayItems() > 0 then
            self.open = true
            return
        end
    end
    Input.handleKey(self, event, a, b)
end
function ComboBox:render(buf)
    Input.render(self, buf)
    local w = self.width
    buf:blit(w, 1, self.open and "\30" or "\31",
        self.foreground, self.background)
    if self.open then
        local display = self:getDisplayItems()
        local g = geometry(self, display)
        rawget(self, "_p").offset = g.offset
        local highlighted = rawget(self, "_highlighted")
        local textWidth = math.max(0, w - (g.show and 1 or 0))
        for row = 1, self.height - 1 do
            local entry = display[g.offset + row]
            if not entry then break end
            local isHl = (g.offset + row) == highlighted
            local fg = isHl and self.selectionForeground or self.dropForeground
            local bg = isHl and self.selectionBackground or self.dropBackground
            buf:fill(1, 1 + row, textWidth, 1, " ", fg, bg)
            buf:blit(1, 1 + row, entry.text:sub(1, textWidth), fg, bg)
        end
        itemview.draw(buf, w, 2, g, self.foreground,
            self.scrollbarColor, self.scrollbarThumbColor)
    end
end
return ComboBox
]=]
sources["elements/ContextMenu"] = [=[

local require = ...
local class = require("core/class")
local Collection = require("elements/Collection")
local ContextMenu = class.create("ContextMenu", Collection)
class.property(ContextMenu, "background", colors.black)
class.property(ContextMenu, "separatorColor", colors.gray)
class.property(ContextMenu, "visible", false)
class.property(ContextMenu, "width", function(self)
    local w = 4
    for _, item in ipairs(self.items) do
        if not (type(item) == "table" and item.separator) then
            w = math.max(w, #tostring(item) + 2)
        end
    end
    return w
end)
class.property(ContextMenu, "height", function(self)
    return math.max(1, #self.items)
end)
local function isSeparator(item)
    return type(item) == "table" and item.separator == true
end
function ContextMenu:setup()
    Collection.setup(self)
    self.z = 1000
    self:on("click", function(s, _, _, y)
        local item = s.items[y]
        if item ~= nil and not isSeparator(item) and not item.disabled then
            s:activateItem(y)
            s:close()
        end
    end)
    self:on("blur", function(s) s:close() end)
end
function ContextMenu:openAt(x, y)
    local parent = rawget(self, "parent")
    if parent then
        x = math.max(1, math.min(x, parent.width - self.width + 1))
        y = math.max(1, math.min(y, parent.height - self.height + 1))
    end
    self.x, self.y = x, y
    self.visible = true
    self:focus()
    return self
end
function ContextMenu:close()
    self.visible = false
    return self
end
function ContextMenu:handleKey(event, a, b)
    if event == "key" then
        if a == keys.escape then
            self:close()
        elseif a == keys.enter then
            local hovered = rawget(self, "_highlighted")
            local item = hovered and self.items[hovered]
            if item and not isSeparator(item) and not item.disabled then
                self:activateItem(hovered)
                self:close()
            end
        elseif a == keys.up or a == keys.down then
            local count = #self.items
            local cur = rawget(self, "_highlighted") or 0
            local dir = a == keys.down and 1 or -1
            for _ = 1, count do
                cur = cur + dir
                if cur < 1 then cur = count elseif cur > count then cur = 1 end
                if not isSeparator(self.items[cur]) and not self.items[cur].disabled then break end
            end
            rawset(self, "_highlighted", cur)
            self:markDirty()
        end
    end
    Collection.handleKey(self, event, a, b)
end
function ContextMenu:render(buf)
    local w = self.width
    local fg, bg = self.foreground, self.background
    local highlighted = rawget(self, "_highlighted")
    for row, item in ipairs(self.items) do
        if isSeparator(item) then
            buf:fill(1, row, w, 1, "\140", self.separatorColor, bg)
        elseif row == highlighted and not item.disabled then
            buf:fill(1, row, w, 1, " ",
                self.selectionForeground, self.selectionBackground)
            buf:blit(2, row, tostring(item):sub(1, w - 2),
                self.selectionForeground, self.selectionBackground)
        else
            local itemFg = item.fg or fg
            buf:fill(1, row, w, 1, " ", fg, bg)
            buf:blit(2, row, tostring(item):sub(1, w - 2), itemFg, bg)
        end
    end
end
return ContextMenu
]=]
sources["elements/Dialog"] = [=[

local require = ...
local class = require("core/class")
local Container = require("core/container")
local textutil = require("core/text")
local Dialog = class.create("Dialog", Container)
class.property(Dialog, "title", "")
class.property(Dialog, "titleBackground", colors.blue)
class.property(Dialog, "titleForeground", colors.white)
class.property(Dialog, "boxBackground", colors.lightGray)
class.property(Dialog, "boxForeground", colors.black)
class.property(Dialog, "boxWidth", 26)
class.property(Dialog, "visible", false)
class.property(Dialog, "background", false)
class.property(Dialog, "width", function(self)
    local parent = rawget(self, "parent")
    return parent and parent.width or 1
end)
class.property(Dialog, "height", function(self)
    local parent = rawget(self, "parent")
    return parent and parent.height or 1
end)
class.event(Dialog, "close")
function Dialog:setup()
    Container.setup(self)
    self.x, self.y = 1, 1
    self.z = 950
    self:on("click", function() end)
end
local function clearChildren(self)
    local children = self:getChildren()
    for i = #children, 1, -1 do
        self:removeChild(children[i])
    end
end
function Dialog:close(result)
    clearChildren(self)
    self.visible = false
    self:fire("close", result)
    return self
end
local function buildBox(self, title, message, extraRows)
    clearChildren(self)
    self.title = tostring(title or "")
    self.visible = true
    local boxWidth = math.min(self.boxWidth, math.max(10, self.width - 2))
    local lines = textutil.wrap(message or "", boxWidth - 2)
    local boxHeight = 1 + 1 + #lines + (extraRows or 0) + 2
    local box = self:addFrame({
        x = math.max(1, math.floor((self.width - boxWidth) / 2) + 1),
        y = math.max(1, math.floor((self.height - boxHeight) / 2) + 1),
        width = boxWidth,
        height = boxHeight,
        background = self.boxBackground,
        foreground = self.boxForeground,
    })
    box:addLabel({
        x = 1, y = 1, width = boxWidth, height = 1,
        text = self.title,
        background = self.titleBackground,
        foreground = self.titleForeground,
    })
    for i, line in ipairs(lines) do
        box:addLabel({
            x = 2, y = 2 + i, text = line,
            foreground = self.boxForeground,
        })
    end
    return box, 2 + #lines + 1
end
local function addButtons(self, box, buttons, contentY)
    local totalWidth = 0
    for _, buttonDef in ipairs(buttons) do
        totalWidth = totalWidth + #buttonDef[1] + 2 + 1
    end
    local x = math.max(2, math.floor((box.width - totalWidth + 1) / 2) + 1)
    for _, buttonDef in ipairs(buttons) do
        local label, onPress = buttonDef[1], buttonDef[2]
        box:addButton({
            x = x, y = contentY + 1,
            width = #label + 2, height = 1,
            text = label,
        }):onClick(function()
            onPress()
        end)
        x = x + #label + 3
    end
end
function Dialog:alert(title, message, callback)
    local box, contentY = buildBox(self, title, message, 0)
    addButtons(self, box, {
        { "OK", function()
            self:close(true)
            if callback then callback() end
        end },
    }, contentY)
    return self
end
function Dialog:confirm(title, message, callback)
    local box, contentY = buildBox(self, title, message, 0)
    addButtons(self, box, {
        { "Yes", function()
            self:close(true)
            if callback then callback(true) end
        end },
        { "No", function()
            self:close(false)
            if callback then callback(false) end
        end },
    }, contentY)
    return self
end
function Dialog:prompt(title, message, default, callback)
    local box, contentY = buildBox(self, title, message, 2)
    local input = box:addInput({
        x = 2, y = contentY + 1,
        width = box.width - 2,
        text = tostring(default or ""),
    })
    local function accept()
        local value = input.text
        self:close(value)
        if callback then callback(value) end
    end
    input:onEnter(accept)
    addButtons(self, box, {
        { "OK", accept },
        { "Cancel", function()
            self:close(nil)
            if callback then callback(nil) end
        end },
    }, contentY + 2)
    input:focus()
    return self
end
return Dialog
]=]
sources["elements/Dropdown"] = [=[

local require = ...
local class = require("core/class")
local Collection = require("elements/Collection")
local itemview = require("core/itemview")
local Dropdown = class.create("Dropdown", Collection)
class.property(Dropdown, "text", "Select...")
class.property(Dropdown, "dropHeight", 6)
class.property(Dropdown, "offset", 0)
class.property(Dropdown, "background", colors.gray)
class.property(Dropdown, "dropBackground", colors.black)
class.property(Dropdown, "width", 14)
class.property(Dropdown, "scrollbar", "auto")
class.property(Dropdown, "scrollbarColor", colors.gray)
class.property(Dropdown, "scrollbarThumbColor", colors.lightGray)
class.property(Dropdown, "height", function(self)
    if self.open then
        return 1 + math.min(#self.items, self.dropHeight)
    end
    return 1
end)
class.property(Dropdown, "open", false, {
    onChange = function(self, v)
        if v then
            rawset(self, "_zBefore", self.z)
            self.z = 999
            local highlighted = self.selected or (#self.items > 0 and 1 or nil)
            rawset(self, "_highlighted", highlighted)
            self.offset = itemview.ensureVisible(self.offset, highlighted,
                #self.items, math.min(#self.items, self.dropHeight))
        else
            self.z = rawget(self, "_zBefore") or self.z
            rawset(self, "_itemScrollDrag", nil)
        end
    end,
})
local function visibleRows(self)
    return math.min(#self.items, math.max(0, self.dropHeight))
end
function Dropdown:getScrollInfo()
    return itemview.geometry(#self.items, visibleRows(self),
        self.offset, self.scrollbar)
end
function Dropdown:setOffset(offset)
    self.offset = itemview.clampOffset(offset, #self.items, visibleRows(self))
    return self
end
function Dropdown:scrollToItem(index)
    self.offset = itemview.ensureVisible(self.offset, index,
        #self.items, visibleRows(self))
    return self
end
function Dropdown:select(index, emit)
    if not index or self.items[index] == nil then return self end
    Collection.select(self, index, emit)
    rawset(self, "_highlighted", index)
    self:scrollToItem(index)
    self.open = false
    return self
end
function Dropdown:setup()
    Collection.setup(self)
    self:on("click", function(s, _, x, y)
        if y == 1 then
            s.open = not s.open
        else
            local geometry = s:getScrollInfo()
            if geometry.show and x == s.width then
                local target, grab = itemview.pointerDown(y - 1, geometry)
                if target ~= nil then s:setOffset(target) end
                if grab ~= nil then rawset(s, "_itemScrollDrag", grab) end
                return
            end
            local idx = s.offset + y - 1
            if s.items[idx] ~= nil then
                s:select(idx)
            end
        end
    end)
    self:on("drag", function(s, _, _, y)
        local grab = rawget(s, "_itemScrollDrag")
        if grab ~= nil then
            s:setOffset(itemview.drag(y - 1, grab, s:getScrollInfo()))
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_itemScrollDrag", nil)
    end)
    self:on("blur", function(s)
        s.open = false
    end)
end
function Dropdown:clear()
    Collection.clear(self)
    self.open = false
    self.offset = 0
    rawset(self, "_highlighted", nil)
    self:markDirty()
    return self
end
function Dropdown:removeItem(index)
    Collection.removeItem(self, index)
    self:setOffset(self.offset)
    self:markDirty()
    return self
end
function Dropdown:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" and not self.open then return nil end
    if event == "mouse_scroll" then
        if self.disabled then return nil end
        local old = self.offset
        self:setOffset(old + btn)
        local userHandled = self:fire("scroll", btn, x, y)
        if self.offset ~= old or userHandled then return self end
        return nil
    end
    return Collection.handleMouse(self, event, btn, x, y)
end
function Dropdown:handleKey(event, a, b)
    if event == "key" then
        if not self.open then
            if a == keys.enter or a == keys.space
                or a == keys.down or a == keys.up then
                self.open = true
            end
        else
            local count = #self.items
            local highlighted = rawget(self, "_highlighted") or 0
            if a == keys.escape then
                self.open = false
            elseif a == keys.enter or a == keys.space then
                if highlighted > 0 then self:select(highlighted) end
            elseif count > 0 then
                if a == keys.up then
                    highlighted = math.max(1, highlighted > 0 and highlighted - 1 or 1)
                elseif a == keys.down then
                    highlighted = math.min(count, highlighted > 0 and highlighted + 1 or 1)
                elseif a == keys.home then
                    highlighted = 1
                elseif a == keys["end"] then
                    highlighted = count
                elseif a == keys.pageUp then
                    highlighted = math.max(1, highlighted - visibleRows(self))
                elseif a == keys.pageDown then
                    highlighted = math.min(count, highlighted + visibleRows(self))
                end
                rawset(self, "_highlighted", highlighted)
                self:scrollToItem(highlighted)
                self:markDirty()
            end
        end
    end
    Collection.handleKey(self, event, a, b)
end
function Dropdown:render(buf)
    local w = self.width
    local fg, bg = self.foreground, self.background
    local items, sel = self.items, self.selected
    local clampedOffset = itemview.clampOffset(self.offset,
        #items, visibleRows(self))
    rawget(self, "_p").offset = clampedOffset
    buf:fill(1, 1, w, 1, " ", fg, bg)
    local title = (sel and items[sel] ~= nil)
        and tostring(items[sel]) or tostring(self.text)
    buf:blit(1, 1, title:sub(1, w - 2), fg, bg)
    buf:blit(w, 1, self.open and "\30" or "\31", fg, bg)
    if self.open then
        local geometry = self:getScrollInfo()
        local highlighted = rawget(self, "_highlighted")
        local textWidth = math.max(0, w - (geometry.show and 1 or 0))
        for row = 1, self.height - 1 do
            local idx = clampedOffset + row
            local item = items[idx]
            local isSel = highlighted == idx or (not highlighted and sel == idx)
            local rfg = isSel and (item and item.selectedFg or self.selectionForeground)
                or (item and item.fg or fg)
            local rbg = isSel and (item and item.selectedBg or self.selectionBackground)
                or (item and item.bg or self.dropBackground)
            buf:fill(1, 1 + row, textWidth, 1, " ", rfg, rbg)
            buf:blit(1, 1 + row, tostring(item or ""):sub(1, textWidth), rfg, rbg)
        end
        itemview.draw(buf, w, 2, geometry, fg,
            self.scrollbarColor, self.scrollbarThumbColor)
    end
end
return Dropdown
]=]
sources["elements/Flex"] = [=[

local require = ...
local class = require("core/class")
local layout = require("core/layout")
local Container = require("core/container")
local Flex = class.create("Flex", Container)
class.property(Flex, "direction", "row")
class.property(Flex, "gap", 0)
class.property(Flex, "padding", 0)
class.property(Flex, "align", "start")
class.property(Flex, "justify", "start")
class.property(Flex, "overflow", "clip")
class.property(Flex, "background", false)
local function contentSize(self)
    local padding = math.max(0, math.floor(tonumber(self.padding) or 0))
    return padding,
        math.max(0, self.width - padding * 2),
        math.max(0, self.height - padding * 2)
end
local function desiredSize(child, axis, spec, availableWidth, availableHeight)
    if layout.is(spec) and (spec.kind == "auto" or spec.kind == "fill") then
        local mw, mh = layout.measure(child, availableWidth, availableHeight)
        return layout.constrain(child, axis, axis == "width" and mw or mh)
    end
    return layout.resolveSize(child, axis, spec, availableWidth, availableHeight)
end
function Flex:measure(availableWidth, availableHeight)
    availableWidth = availableWidth or 1
    availableHeight = availableHeight or 1
    local direction = self.direction
    local isRow = direction == "row"
    if not isRow and direction ~= "column" then
        error("Basalt layout: direction must be 'row' or 'column'", 2)
    end
    local padding = math.max(0, math.floor(tonumber(self.padding) or 0))
    local gap = math.max(0, math.floor(tonumber(self.gap) or 0))
    local main, cross, count = 0, 0, 0
    local children = self:getChildren()
    for i = 1, #children do
        local child = children[i]
        if child.visible and child.position ~= "absolute" then
            local wSpec = layout.spec(child, "width")
            local hSpec = layout.spec(child, "height")
            local w = desiredSize(child, "width", wSpec, availableWidth, availableHeight)
            local h = desiredSize(child, "height", hSpec, availableWidth, availableHeight)
            main = main + (isRow and w or h)
            cross = math.max(cross, isRow and h or w)
            count = count + 1
        end
    end
    if count > 1 then main = main + gap * (count - 1) end
    main, cross = main + padding * 2, cross + padding * 2
    return isRow and main or cross, isRow and cross or main
end
function Flex:layoutChildren()
    local direction = self.direction
    local isRow = direction == "row"
    if not isRow and direction ~= "column" then
        error("Basalt layout: direction must be 'row' or 'column'", 2)
    end
    local padding, contentWidth, contentHeight = contentSize(self)
    local contentMain = isRow and contentWidth or contentHeight
    local contentCross = isRow and contentHeight or contentWidth
    local gap = math.max(0, math.floor(tonumber(self.gap) or 0))
    local items = {}
    local fillWeight, fixed, lastFill = 0, 0, nil
    local children = self:getChildren()
    for i = 1, #children do
        local child = children[i]
        if child.position == "absolute" then
            layout.resolveFreeChild(self, child)
        elseif child.visible then
            local mainAxis = isRow and "width" or "height"
            local crossAxis = isRow and "height" or "width"
            local mainSpec = layout.spec(child, mainAxis)
            local crossSpec = layout.spec(child, crossAxis)
            local item = {
                child = child,
                mainSpec = mainSpec,
                crossSpec = crossSpec,
                fill = layout.is(mainSpec) and mainSpec.kind == "fill",
                weight = layout.is(mainSpec) and mainSpec.kind == "fill"
                    and mainSpec.value or 0,
            }
            local configuredShrink = child.shrink
            if configuredShrink == false then
                item.shrink = layout.is(mainSpec) and 1 or 0
            else
                item.shrink = math.max(0, tonumber(configuredShrink) or 0)
            end
            if item.fill then
                fillWeight = fillWeight + item.weight
                lastFill = #items + 1
            else
                item.main = desiredSize(child, mainAxis, mainSpec,
                    contentWidth, contentHeight)
                fixed = fixed + item.main
            end
            item.cross = layout.resolveSize(child, crossAxis, crossSpec,
                contentWidth, contentHeight)
            items[#items + 1] = item
        else
            rawset(child, "_layoutBox", nil)
        end
    end
    local gapTotal = gap * math.max(0, #items - 1)
    local distributable = math.max(0, contentMain - fixed - gapTotal)
    local distributed = 0
    for i = 1, #items do
        local item = items[i]
        if item.fill then
            local size
            if i == lastFill then
                size = distributable - distributed
            else
                size = math.floor(distributable * item.weight / fillWeight)
                distributed = distributed + size
            end
            local axis = isRow and "width" or "height"
            item.main = layout.constrain(item.child, axis, size)
        end
    end
    local used = gapTotal
    for i = 1, #items do used = used + items[i].main end
    local deficit = math.max(0, used - contentMain)
    while deficit > 0 do
        local totalWeight = 0
        for i = 1, #items do
            local item = items[i]
            local minName = isRow and "minWidth" or "minHeight"
            local minimum = item.child[minName]
            if minimum == false then minimum = 0 end
            item.minimum = math.max(0, tonumber(minimum) or 0)
            if item.shrink > 0 and item.main > item.minimum then
                totalWeight = totalWeight + item.shrink
            end
        end
        if totalWeight == 0 then break end
        local reduced = 0
        for i = 1, #items do
            local item = items[i]
            if item.shrink > 0 and item.main > item.minimum then
                local share = math.max(1,
                    math.floor(deficit * item.shrink / totalWeight))
                local amount = math.min(share, item.main - item.minimum,
                    deficit - reduced)
                item.main = item.main - amount
                reduced = reduced + amount
                if reduced >= deficit then break end
            end
        end
        if reduced == 0 then break end
        deficit = deficit - reduced
    end
    used = gapTotal
    for i = 1, #items do used = used + items[i].main end
    local free = math.max(0, contentMain - used)
    local justify, offset, actualGap = self.justify, 0, gap
    if self.overflow ~= "clip" then
        error("Basalt layout: only overflow='clip' is currently supported", 2)
    end
    if justify == "center" then
        offset = math.floor(free / 2)
    elseif justify == "end" then
        offset = free
    elseif justify == "spaceBetween" and #items > 1 then
        actualGap = gap + math.floor(free / (#items - 1))
    elseif justify ~= "start" then
        error("Basalt layout: invalid justify '" .. tostring(justify) .. "'", 2)
    end
    local cursor = padding + offset + 1
    for i = 1, #items do
        local item, child = items[i], items[i].child
        local align = child.alignSelf ~= false and child.alignSelf or self.align
        local cross = item.cross
        if align == "stretch" and layout.is(item.crossSpec)
            and item.crossSpec.kind == "auto" then
            cross = contentCross
        end
        local crossOffset = 0
        if align == "center" then
            crossOffset = math.floor((contentCross - cross) / 2)
        elseif align == "end" then
            crossOffset = contentCross - cross
        elseif align ~= "start" and align ~= "stretch" then
            error("Basalt layout: invalid align '" .. tostring(align) .. "'", 2)
        end
        crossOffset = math.max(0, crossOffset)
        if isRow then
            layout.setBox(child, cursor, padding + crossOffset + 1,
                item.main, cross)
        else
            layout.setBox(child, padding + crossOffset + 1, cursor,
                cross, item.main)
        end
        cursor = cursor + item.main + actualGap
    end
end
return Flex
]=]
sources["elements/Frame"] = [=[

local require = ...
local class = require("core/class")
local Container = require("core/container")
local Frame = class.create("Frame", Container)
class.property(Frame, "background", colors.gray)
class.property(Frame, "width", 20)
class.property(Frame, "height", 8)
class.property(Frame, "draggable", false)
class.property(Frame, "draggingMap", false, { visual = false })
local function inDragZone(self, x, y)
    local zones = self.draggingMap
    if not zones then
        zones = { { x = 1, y = 1, width = "full", height = 1 } }
    end
    for i = 1, #zones do
        local zone = zones[i]
        local zw = zone.width == "full" and self.width or (zone.width or 1)
        local zh = zone.height == "full" and self.height or (zone.height or 1)
        if x >= zone.x and x < zone.x + zw
            and y >= zone.y and y < zone.y + zh then
            return true
        end
    end
    return false
end
function Frame:setup()
    Container.setup(self)
    self:on("click", function(s, _, x, y)
        if s.draggable and inDragZone(s, x, y) then
            rawset(s, "_dragFrom", { x = x, y = y })
        end
    end)
    self:on("drag", function(s, _, x, y)
        local from = rawget(s, "_dragFrom")
        if from then
            s.x = s.x + x - from.x
            s.y = s.y + y - from.y
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_dragFrom", nil)
    end)
end
function Frame:toFront()
    local parent = rawget(self, "parent")
    if not parent then return self end
    local top = self.z
    for _, sibling in ipairs(parent:getChildren()) do
        if sibling.z > top then top = sibling.z end
    end
    if top >= self.z then self.z = top + 1 end
    return self
end
return Frame
]=]
sources["elements/Input"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local Input = class.create("Input", Element)
class.property(Input, "text", "", {
    rawString = true,
    onChange = function(self, v)
        local cur = rawget(self, "_cursor")
        if cur and cur > #v + 1 then
            rawset(self, "_cursor", #v + 1)
            rawset(self, "_scroll", math.max(0, #v + 1 - self.width))
        end
    end,
})
class.property(Input, "placeholder", "")
class.property(Input, "placeholderColor", colors.gray)
class.property(Input, "maxLength", false)
class.property(Input, "replaceChar", false)
class.property(Input, "pattern", false)
class.property(Input, "width", 12)
class.property(Input, "height", 1)
class.property(Input, "background", colors.lightGray)
class.property(Input, "foreground", colors.black)
class.event(Input, "change")
class.event(Input, "enter")
function Input:setup()
    Element.setup(self)
    rawset(self, "_cursor", 1)
    rawset(self, "_scroll", 0)
    self:on("click", function(s, _, x, y)
        if y ~= 1 then return end
        s:_moveCursor(s._scroll + x)
    end)
    self:on("focus", function(s) s:markDirty() end)
    self:on("blur", function(s) s:markDirty() end)
end
function Input:_moveCursor(pos)
    local n = #self.text
    if pos < 1 then pos = 1 end
    if pos > n + 1 then pos = n + 1 end
    rawset(self, "_cursor", pos)
    local w, scroll = self.width, self._scroll
    if pos - scroll > w then scroll = pos - w end
    if pos - scroll < 1 then scroll = pos - 1 end
    rawset(self, "_scroll", scroll)
    self:markDirty()
end
function Input:_insert(str)
    local pattern = self.pattern
    if pattern then
        str = str:gsub(".", function(ch)
            return ch:match(pattern) and ch or ""
        end)
        if #str == 0 then return end
    end
    local text = self.text
    local max = self.maxLength
    if max and #text + #str > max then return end
    local c = self._cursor
    self.text = text:sub(1, c - 1) .. str .. text:sub(c)
    self:_moveCursor(c + #str)
    self:fire("change", self.text)
end
function Input:handleKey(event, a, b)
    if event == "char" or event == "paste" then
        self:_insert(a)
    elseif event == "key" then
        local c = self._cursor
        local text = self.text
        if a == keys.backspace then
            if c > 1 then
                self.text = text:sub(1, c - 2) .. text:sub(c)
                self:_moveCursor(c - 1)
                self:fire("change", self.text)
            end
        elseif a == keys.delete then
            if c <= #text then
                self.text = text:sub(1, c - 1) .. text:sub(c + 1)
                self:fire("change", self.text)
            end
        elseif a == keys.left then
            self:_moveCursor(c - 1)
        elseif a == keys.right then
            self:_moveCursor(c + 1)
        elseif a == keys.home then
            self:_moveCursor(1)
        elseif a == keys["end"] then
            self:_moveCursor(#text + 1)
        elseif a == keys.enter then
            self:fire("enter", text)
        end
    end
    Element.handleKey(self, event, a, b)
end
function Input:render(buf)
    Element.render(self, buf)
    local root = self:getRoot()
    local focused = root.getFocused and root:getFocused() == self
    local text = self.text
    local w = self.width
    if #text == 0 and not focused then
        buf:blit(1, 1, self.placeholder:sub(1, w), self.placeholderColor, nil)
    else
        local visible = text:sub(self._scroll + 1, self._scroll + w)
        local rc = self.replaceChar
        if rc then visible = tostring(rc):sub(1, 1):rep(#visible) end
        buf:blit(1, 1, visible, self.foreground, nil)
    end
    if focused then
        self:setCursor(self._cursor - self._scroll, 1, true, self.foreground)
    end
end
function Input:measure()
    return math.max(1, #tostring(self.text), #tostring(self.placeholder)), 1
end
return Input
]=]
sources["elements/Label"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local textutil = require("core/text")
local Label = class.create("Label", Element)
local function reflow(self)
    local p = rawget(self, "_p")
    if rawget(self, "_autoSize") then
        if type(p.width) ~= "function" then
            p.width = math.max(#tostring(self.text), 1)
        end
        return
    end
    if rawget(self, "_autoHeight") and type(p.height) ~= "function"
        and type(p.width) ~= "function" then
        p.height = #textutil.wrap(self.text, self.width)
    end
end
class.property(Label, "text", "", {
    onChange = function(self) reflow(self) end,
})
class.property(Label, "width", 1, {
    onChange = function(self)
        rawset(self, "_autoSize", false)
        reflow(self)
    end,
})
class.property(Label, "height", 1, {
    onChange = function(self)
        rawset(self, "_autoHeight", false)
    end,
})
function Label:setup()
    Element.setup(self)
    rawset(self, "_autoSize", true)
    rawset(self, "_autoHeight", true)
end
function Label:render(buf)
    Element.render(self, buf)
    local str = tostring(self.text)
    if rawget(self, "_autoSize") or self.height == 1 then
        buf:blit(1, 1, str, self.foreground, nil)
    else
        local lines = textutil.wrap(str, self.width)
        for i = 1, math.min(#lines, self.height) do
            buf:blit(1, i, lines[i], self.foreground, nil)
        end
    end
end
function Label:measure()
    return math.max(1, #tostring(self.text)), 1
end
return Label
]=]
sources["elements/List"] = [=[

local require = ...
local class = require("core/class")
local Collection = require("elements/Collection")
local itemview = require("core/itemview")
local List = class.create("List", Collection)
class.property(List, "offset", 0)
class.property(List, "emptyText", "")
class.property(List, "emptyTextColor", colors.gray)
class.property(List, "background", colors.black)
class.property(List, "width", 16)
class.property(List, "height", 8)
class.property(List, "scrollbar", "auto")
class.property(List, "scrollbarColor", colors.gray)
class.property(List, "scrollbarThumbColor", colors.lightGray)
local function maxOffset(self)
    return itemview.maxOffset(#self.items, self.height)
end
function List:getScrollInfo()
    return itemview.geometry(#self.items, self.height, self.offset, self.scrollbar)
end
function List:setOffset(offset)
    self.offset = itemview.clampOffset(offset, #self.items, self.height)
    return self
end
function List:scrollToItem(index)
    self.offset = itemview.ensureVisible(self.offset, index,
        #self.items, self.height)
    return self
end
function List:selectItem(value, emit)
    Collection.selectItem(self, value, emit)
    local index = self:indexOfItem(value) or self:getSelectedIndex()
    if index then self:scrollToItem(index) end
    return self
end
function List:setup()
    Collection.setup(self)
    self:on("click", function(s, _, x, y)
        local geometry = s:getScrollInfo()
        if geometry.show and x == s.width then
            local target, grab = itemview.pointerDown(y, geometry)
            if target ~= nil then s:setOffset(target) end
            if grab ~= nil then rawset(s, "_itemScrollDrag", grab) end
            return
        end
        local idx = s.offset + y
        if s.items[idx] ~= nil then
            s:select(idx)
        end
    end)
    self:on("drag", function(s, _, _, y)
        local grab = rawget(s, "_itemScrollDrag")
        if grab ~= nil then
            s:setOffset(itemview.drag(y, grab, s:getScrollInfo()))
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_itemScrollDrag", nil)
    end)
end
function List:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" then
        if self.disabled then return nil end
        local old = self.offset
        self:setOffset(old + btn)
        local userHandled = self:fire("scroll", btn, x, y)
        if self.offset ~= old or userHandled then return self end
        return nil
    end
    return Collection.handleMouse(self, event, btn, x, y)
end
function List:removeItem(index)
    Collection.removeItem(self, index)
    if self.offset > maxOffset(self) then self.offset = maxOffset(self) end
    self:markDirty()
    return self
end
function List:handleKey(event, a, b)
    if event == "key" and #self.items > 0 then
        local selected = self.selected or 0
        if a == keys.up then
            self:selectItem(selected > 1 and selected - 1 or 1)
        elseif a == keys.down then
            self:selectItem(selected > 0 and math.min(#self.items, selected + 1) or 1)
        elseif a == keys.home then
            self:selectItem(1)
        elseif a == keys["end"] then
            self:selectItem(#self.items)
        elseif a == keys.pageUp then
            self:selectItem(math.max(1, (selected > 0 and selected or 1) - self.height))
        elseif a == keys.pageDown then
            self:selectItem(math.min(#self.items,
                (selected > 0 and selected or 1) + self.height))
        elseif a == keys.enter and selected > 0 then
            self:activateItem(selected)
        end
    end
    Collection.handleKey(self, event, a, b)
end
function List:clear()
    Collection.clear(self)
    self.offset = 0
    return self
end
function List:render(buf)
    Collection.render(self, buf)
    local items = self.items
    local w, h = self.width, self.height
    if #items == 0 and #tostring(self.emptyText) > 0 then
        local label = tostring(self.emptyText):sub(1, w)
        buf:blit(math.floor((w - #label) / 2) + 1,
            math.floor((h - 1) / 2) + 1, label, self.emptyTextColor, nil)
        return
    end
    local off = itemview.clampOffset(self.offset, #items, h)
    rawget(self, "_p").offset = off
    local geometry = self:getScrollInfo()
    local textWidth = math.max(0, w - (geometry.show and 1 or 0))
    local function drawIcon(item, row, selected, rowBackground)
        local icon = item.iconChar
        if type(icon) == "number" then icon = string.char(icon) end
        if type(icon) ~= "string" or #icon == 0 then return end
        local x = math.floor(tonumber(item.iconX) or 1)
        if x < 1 or x > textWidth then return end
        local foreground = selected and item.selectedIconForeground
            or item.iconForeground or rowBackground
        local background = selected and item.selectedIconBackground
            or item.iconBackground
        buf:blit(x, row, icon:sub(1, 1), foreground, background)
    end
    for row = 1, h do
        local idx = off + row
        local item = items[idx]
        if item == nil then break end
        local text = tostring(item)
        if item.separator then
            local symbol = text ~= "" and text:sub(1, 1) or "-"
            buf:blit(1, row, symbol:rep(textWidth),
                item.fg or self.foreground, item.bg)
        elseif self:isSelected(idx) then
            local foreground = item.selectedFg or self.selectionForeground
            local background = item.selectedBg or self.selectionBackground
            buf:fill(1, row, textWidth, 1, " ", foreground, background)
            buf:blit(1, row, text:sub(1, textWidth), foreground, background)
            drawIcon(item, row, true, background)
        else
            local foreground = item.fg or self.foreground
            local background = item.bg
            if background then
                buf:fill(1, row, textWidth, 1, " ", foreground, background)
            end
            buf:blit(1, row, text:sub(1, textWidth), foreground, background)
            drawIcon(item, row, false, background or self.background)
        end
    end
    itemview.draw(buf, w, 1, geometry, self.foreground,
        self.scrollbarColor, self.scrollbarThumbColor)
end
return List
]=]
sources["elements/Menu"] = [=[

local require = ...
local class = require("core/class")
local Collection = require("elements/Collection")
local Menu = class.create("Menu", Collection)
local function labelOf(item)
    if type(item) == "table" then
        if item.separator then return "\149" end
        return tostring(item.text)
    end
    return tostring(item)
end
local function isSeparator(item)
    return type(item) == "table" and item.separator == true
end
local function submenuItems(item)
    return type(item) == "table" and (item.items or item.dropdown) or nil
end
local function spans(self)
    local out = {}
    local x = 1
    for i, item in ipairs(self.items) do
        local label = isSeparator(item)
            and labelOf(item) or (" " .. labelOf(item) .. " ")
        out[i] = { x, x + #label - 1, label }
        x = x + #label + self.spacing
    end
    return out, math.max(1, x - self.spacing - 1)
end
local function submenuBox(self)
    local index = rawget(self, "_openIndex")
    if not index then return nil end
    local item = self.items[index]
    local children = submenuItems(item)
    if not children then return nil end
    local itemSpans = spans(self)
    local w = 1
    for _, sub in ipairs(children) do
        w = math.max(w, #tostring(sub) + 2)
    end
    local x = math.min(itemSpans[index][1], math.max(1, self.width - w + 1))
    return { x = x, width = w, items = children, parent = index }
end
class.property(Menu, "spacing", 1)
class.property(Menu, "background", colors.gray)
class.property(Menu, "separatorColor", colors.lightGray)
class.property(Menu, "dropBackground", colors.black)
class.property(Menu, "width", function(self)
    local _, total = spans(self)
    return total
end)
class.property(Menu, "height", function(self)
    local box = submenuBox(self)
    return box and (1 + #box.items) or 1
end)
local function closeSubmenu(self)
    if rawget(self, "_openIndex") then
        rawset(self, "_openIndex", nil)
        self.z = rawget(self, "_zBefore") or self.z
        self:markDirty()
    end
end
local function openSubmenu(self, index)
    rawset(self, "_zBefore", self.z)
    rawset(self, "_openIndex", index)
    self.z = 999
    self:markDirty()
end
function Menu:select(index, emit)
    local item = self.items[index]
    if item == nil or isSeparator(item) then return self end
    if submenuItems(item) then
        if rawget(self, "_openIndex") == index then
            closeSubmenu(self)
        else
            openSubmenu(self, index)
        end
        return self
    end
    closeSubmenu(self)
    Collection.select(self, index, emit)
    return self
end
function Menu:setup()
    Collection.setup(self)
    self:on("click", function(s, _, x, y)
        if y == 1 then
            for i, span in ipairs(spans(s)) do
                if x >= span[1] and x <= span[2] then
                    s:select(i)
                    return
                end
            end
            closeSubmenu(s)
        else
            local box = submenuBox(s)
            if box and x >= box.x and x < box.x + box.width
                and box.items[y - 1] ~= nil then
                local subIndex = y - 1
                local subItem = box.items[subIndex]
                closeSubmenu(s)
                if type(subItem) == "table" and type(subItem.callback) == "function" then
                    subItem.callback(s, subItem)
                end
                s:fire("select", subIndex, tostring(subItem), box.parent)
            else
                closeSubmenu(s)
            end
        end
    end)
    self:on("blur", function(s) closeSubmenu(s) end)
end
function Menu:handleKey(event, a, b)
    if event == "key" and #self.items > 0 then
        local selected = self.selected or 0
        if a == keys.left then
            self:select(math.max(1, selected > 0 and selected - 1 or 1), false)
        elseif a == keys.right then
            self:select(selected > 0
                and math.min(#self.items, selected + 1) or 1, false)
        elseif a == keys.escape then
            closeSubmenu(self)
        elseif a == keys.enter and selected > 0 then
            self:select(selected)
        end
    end
    Collection.handleKey(self, event, a, b)
end
function Menu:clear()
    Collection.clear(self)
    closeSubmenu(self)
    self:markDirty()
    return self
end
function Menu:measure()
    local _, total = spans(self)
    return total, 1
end
function Menu:render(buf)
    local fg, bg = self.foreground, self.background
    buf:fill(1, 1, self.width, 1, " ", fg, bg)
    local sel = self.selected
    local openIndex = rawget(self, "_openIndex")
    for i, span in ipairs(spans(self)) do
        local item = self.items[i]
        if isSeparator(item) then
            buf:blit(span[1], 1, span[3], self.separatorColor, bg)
        elseif i == sel or i == openIndex then
            buf:blit(span[1], 1, span[3],
                self.selectionForeground, self.selectionBackground)
        else
            buf:blit(span[1], 1, span[3], fg, bg)
        end
    end
    local box = submenuBox(self)
    if box then
        for row, sub in ipairs(box.items) do
            buf:fill(box.x, 1 + row, box.width, 1, " ", fg, self.dropBackground)
            buf:blit(box.x + 1, 1 + row,
                tostring(sub):sub(1, box.width - 2), fg, self.dropBackground)
        end
    end
end
return Menu
]=]
sources["elements/Program"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local errors = require("core/errors")
local palette = require("core/palette")
local Program = class.create("Program", Element)
local ROUTED = {
    mouse_click = true, mouse_up = true, mouse_drag = true,
    mouse_scroll = true, mouse_move = true,
    key = true, key_up = true, char = true, paste = true,
}
local resume
local function syncWindowSize(self, proc, notify)
    if not proc or not proc.window then return false end
    local width = math.max(1, math.floor(tonumber(self.width) or 1))
    local height = math.max(1, math.floor(tonumber(self.height) or 1))
    local current_width, current_height = proc.window.getSize()
    if current_width == width and current_height == height then return false end
    proc.window.reposition(1, 1, width, height)
    if notify and resume then resume(self, proc, "term_resize") end
    return true
end
local function onResize(self)
    local proc = rawget(self, "_proc")
    if proc then syncWindowSize(self, proc, true) end
end
class.property(Program, "path", "", { visual = false })
class.property(Program, "running", false, { visual = false, styleable = false })
class.property(Program, "env", false, { visual = false })
class.property(Program, "background", colors.black)
class.property(Program, "width", 30, { onChange = onResize })
class.property(Program, "height", 12, { onChange = onResize })
class.event(Program, "done")
class.event(Program, "error")
local function finish(self, proc, ok, result)
    if rawget(self, "_proc") == proc then
        rawset(self, "_proc", nil)
    end
    self.running = false
    self:fire("done", ok, result)
end
local function isTerminationError(result)
    local message = tostring(result or "")
    return message == "Terminated" or message:match(": Terminated$") ~= nil
end
local function afterResume(self, proc, ok, result, terminating)
    if not ok then
        if terminating and isTerminationError(result) then
            finish(self, proc, true, nil)
            return
        end
        local trace = debug.traceback(proc.co) or ""
        finish(self, proc, false, result)
        if rawget(self, "_handlers").error then
            self:fire("error", result, trace)
        else
            error(errors.wrap(result, trace), 0)
        end
        return
    end
    proc.filter = result
    if coroutine.status(proc.co) == "dead" then
        finish(self, proc, true, result)
    end
    self:markDirty()
end
resume = function(self, proc, event, ...)
    local co = proc.co
    if not co or coroutine.status(co) == "dead" then return end
    if event ~= "term_resize" then
        syncWindowSize(self, proc, true)
        if rawget(self, "_proc") ~= proc or coroutine.status(co) == "dead" then return end
    end
    if proc.filter ~= nil and event ~= proc.filter and event ~= "terminate" then
        return
    end
    proc.filter = nil
    local previous = term.redirect(proc.term)
    local ok, result = coroutine.resume(co, event, ...)
    proc.term = term.current()
    term.redirect(previous)
    afterResume(self, proc, ok, result, event == "terminate")
end
local function buildEnv(self, path, win)
    win.native = function() return win end
    win.current = term.current
    win.redirect = term.redirect
    local env = setmetatable({}, { __index = _ENV })
    env.term = win
    if shell then
        env.shell, env.multishell = shell, multishell
    end
    if fs.exists("rom/modules/main/cc/require.lua") then
        local make = dofile("rom/modules/main/cc/require.lua").make
        env.require, env.package = make(env, fs.getDir(path))
    end
    local extra = self.env
    if type(extra) == "table" then
        for k, v in pairs(extra) do env[k] = v end
    end
    return env
end
function Program:execute(path, ...)
    self:stop()
    local resolved
    if fs.exists(path) and not fs.isDir(path) then
        resolved = path
    elseif shell then
        resolved = shell.resolveProgram(path)
    end
    if not resolved then
        error("Basalt Program: program not found: " .. tostring(path), 2)
    end
    local root = self:getRoot()
    local parentTerm = rawget(root, "term")
    if not parentTerm then
        error("Basalt Program: element must be inside a frame before execute()", 2)
    end
    local file = fs.open(resolved, "r")
    local content = file.readAll()
    file.close()
    local win = window.create(parentTerm, 1, 1, self.width, self.height, false)
    local fn, err = load(content, "@/" .. resolved, nil, buildEnv(self, resolved, win))
    if not fn then
        error("Basalt Program: failed to load " .. resolved .. ": " .. tostring(err), 2)
    end
    local proc = {
        window = win,
        term = win,
        args = table.pack(...),
        filter = nil,
    }
    proc.co = coroutine.create(fn)
    rawset(self, "_proc", proc)
    self.path = resolved
    self.running = true
    local previous = term.redirect(win)
    local ok, result = coroutine.resume(proc.co,
        table.unpack(proc.args, 1, proc.args.n))
    proc.term = term.current()
    term.redirect(previous)
    afterResume(self, proc, ok, result)
    if rawget(self, "_proc") == proc then
        local basalt = require("main")
        basalt.schedule(function()
            while rawget(self, "_proc") == proc
                and coroutine.status(proc.co) ~= "dead" do
                local ev = table.pack(os.pullEventRaw())
                if not ROUTED[ev[1]] then
                    resume(self, proc, table.unpack(ev, 1, ev.n))
                end
            end
        end)
    end
    return self
end
function Program:stop()
    local proc = rawget(self, "_proc")
    if not proc then return self end
    rawset(self, "_proc", nil)
    if proc.co and coroutine.close and coroutine.status(proc.co) ~= "dead" then
        coroutine.close(proc.co)
    end
    self.running = false
    return self
end
function Program:terminate()
    local proc = rawget(self, "_proc")
    if not proc then return self end
    resume(self, proc, "terminate")
    if rawget(self, "_proc") == proc then self:stop() end
    return self
end
function Program:sendEvent(event, ...)
    local proc = rawget(self, "_proc")
    if proc then resume(self, proc, event, ...) end
    return self
end
function Program:setup()
    Element.setup(self)
    self:on("click", function(s, btn, x, y)
        local proc = rawget(s, "_proc")
        if proc then resume(s, proc, "mouse_click", btn, x, y) end
    end)
    self:on("clickUp", function(s, btn, x, y)
        local proc = rawget(s, "_proc")
        if proc then resume(s, proc, "mouse_up", btn, x, y) end
    end)
    self:on("drag", function(s, btn, x, y)
        local proc = rawget(s, "_proc")
        if proc then resume(s, proc, "mouse_drag", btn, x, y) end
    end)
    self:on("scroll", function(s, dir, x, y)
        local proc = rawget(s, "_proc")
        if proc then resume(s, proc, "mouse_scroll", dir, x, y) end
    end)
end
function Program:handleKey(event, a, b)
    local proc = rawget(self, "_proc")
    if proc then resume(self, proc, event, a, b) end
    Element.handleKey(self, event, a, b)
end
function Program:destroy()
    self:terminate()
    Element.destroy(self)
    return self
end
function Program:render(buf)
    Element.render(self, buf)
    local proc = rawget(self, "_proc")
    if not proc then return end
    syncWindowSize(self, proc, true)
    if rawget(self, "_proc") ~= proc then return end
    local win = proc.window
    local _, height = win.getSize()
    local translate = palette.windowTranslation(win)
    for y = 1, height do
        local text, fg, bg = win.getLine(y)
        if text then
            if translate then
                buf:rawBlit(1, y, text,
                    (fg:gsub(".", translate)), (bg:gsub(".", translate)))
            else
                buf:drawBlit(1, y, text, fg, bg)
            end
        end
    end
    local root = self:getRoot()
    if root.getFocused and root:getFocused() == self then
        local cx, cy = win.getCursorPos()
        self:setCursor(cx, cy, win.getCursorBlink(), win.getTextColor())
    end
end
return Program
]=]
sources["elements/ProgressBar"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local ProgressBar = class.create("ProgressBar", Element)
class.property(ProgressBar, "progress", 0, {
    onChange = function(self, v)
        local p = rawget(self, "_p")
        if v < 0 then p.progress = 0 elseif v > 100 then p.progress = 100 end
    end,
})
class.property(ProgressBar, "barColor", colors.lime)
class.property(ProgressBar, "background", colors.gray)
class.property(ProgressBar, "width", 16)
class.property(ProgressBar, "direction", "right")
class.property(ProgressBar, "showPercentage", false)
function ProgressBar:render(buf)
    Element.render(self, buf)
    local w, h = self.width, self.height
    local pr = math.min(100, math.max(0, self.progress))
    local dir = self.direction
    if dir == "up" or dir == "down" then
        local filled = math.floor(h * pr / 100 + 0.5)
        if filled > 0 then
            buf:fill(1, dir == "up" and (h - filled + 1) or 1, w, filled,
                " ", self.foreground, self.barColor)
        end
    else
        local filled = math.floor(w * pr / 100 + 0.5)
        if filled > 0 then
            buf:fill(dir == "left" and (w - filled + 1) or 1, 1, filled, h,
                " ", self.foreground, self.barColor)
        end
    end
    if self.showPercentage then
        local label = math.floor(pr + 0.5) .. "%"
        buf:drawText(math.floor((w - #label) / 2) + 1,
            math.floor((h - 1) / 2) + 1, label)
    end
end
return ProgressBar
]=]
sources["elements/Row"] = [=[
local require = ...
local class = require("core/class")
local layout = require("core/layout")
local Flex = require("elements/Flex")
local Row = class.create("Row", Flex)
class.property(Row, "direction", "row")
class.property(Row, "width", layout.fill())
class.property(Row, "height", layout.auto())
return Row
]=]
sources["elements/Slider"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local Slider = class.create("Slider", Element)
class.property(Slider, "min", 0)
class.property(Slider, "max", 100)
class.property(Slider, "step", 1)
class.property(Slider, "value", 0)
class.property(Slider, "horizontal", true)
class.property(Slider, "barColor", colors.gray)
class.property(Slider, "knobColor", colors.blue)
class.property(Slider, "width", 10)
class.event(Slider, "change")
local function trackLength(self)
    return self.horizontal and self.width or self.height
end
local function setFromPos(self, x, y)
    local len = trackLength(self)
    local pos = self.horizontal and x or y
    local lo, hi, step = self.min, self.max, self.step
    if hi <= lo or len < 2 then return end
    local ratio = (pos - 1) / (len - 1)
    if ratio < 0 then ratio = 0 elseif ratio > 1 then ratio = 1 end
    local v = lo + ratio * (hi - lo)
    v = lo + math.floor((v - lo) / step + 0.5) * step
    if v < lo then v = lo elseif v > hi then v = hi end
    if v ~= self.value then
        self.value = v
        self:fire("change", v)
    end
end
function Slider:setup()
    Element.setup(self)
    self:on("click", function(s, _, x, y) setFromPos(s, x, y) end)
    self:on("drag", function(s, _, x, y) setFromPos(s, x, y) end)
end
function Slider:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" then
        if self.disabled then return nil end
        local v = self.value + btn * self.step
        if v < self.min then v = self.min elseif v > self.max then v = self.max end
        if v ~= self.value then
            self.value = v
            self:fire("change", v)
        end
        return self
    end
    return Element.handleMouse(self, event, btn, x, y)
end
function Slider:render(buf)
    Element.render(self, buf)
    local len = trackLength(self)
    local lo, hi = self.min, self.max
    local knob = 1
    if hi > lo then
        knob = 1 + math.floor((self.value - lo) / (hi - lo) * (len - 1) + 0.5)
    end
    if self.horizontal then
        buf:blit(1, 1, string.rep("\140", len), self.barColor, nil)
        buf:fill(knob, 1, 1, 1, " ", self.foreground, self.knobColor)
    else
        for row = 1, len do
            buf:blit(1, row, "\149", self.barColor, nil)
        end
        buf:fill(1, knob, 1, 1, " ", self.foreground, self.knobColor)
    end
end
return Slider
]=]
sources["elements/Switch"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local Switch = class.create("Switch", Element)
class.property(Switch, "checked", false, {
    state = "checked",
    styleable = false,
})
class.property(Switch, "onColor", colors.green)
class.property(Switch, "offColor", colors.gray)
class.property(Switch, "knobColor", colors.white)
class.property(Switch, "width", 4)
class.event(Switch, "change")
function Switch:setup()
    Element.setup(self)
    self:on("click", function(s)
        s.checked = not s.checked
        s:fire("change", s.checked)
    end)
end
function Switch:render(buf)
    local w, h = self.width, self.height
    local on = self.checked
    buf:fill(1, 1, w, h, " ", self.foreground, on and self.onColor or self.offColor)
    local knobW = math.max(1, math.floor(w / 2))
    buf:fill(on and (w - knobW + 1) or 1, 1, knobW, h, " ",
        self.foreground, self.knobColor)
end
return Switch
]=]
sources["elements/TabControl"] = [=[

local require = ...
local class = require("core/class")
local Container = require("core/container")
local Frame = require("elements/Frame")
local TabControl = class.create("TabControl", Container)
class.property(TabControl, "active", 0, {
    onChange = function(self)
        local tabs = rawget(self, "_tabs")
        if not tabs then return end
        local active = self.active
        for i = 1, #tabs do
            tabs[i].frame.visible = (i == active)
        end
    end,
})
class.property(TabControl, "headerBackground", colors.gray)
class.property(TabControl, "activeBackground", colors.blue)
class.property(TabControl, "activeForeground", colors.white)
class.property(TabControl, "background", colors.black)
class.property(TabControl, "width", 24)
class.property(TabControl, "height", 10)
class.event(TabControl, "change")
local function spans(self)
    local out = {}
    local x = 1
    for i, tab in ipairs(rawget(self, "_tabs")) do
        local label = " " .. tab.title .. " "
        out[i] = { x, x + #label - 1, label }
        x = x + #label
    end
    return out
end
function TabControl:setup()
    Container.setup(self)
    rawset(self, "_tabs", {})
    self:on("click", function(s, _, x, y)
        if y ~= 1 then return end
        for i, span in ipairs(spans(s)) do
            if x >= span[1] and x <= span[2] then
                s:setActiveTab(i)
                return
            end
        end
    end)
end
function TabControl:addTab(title)
    local tab = Frame.new({
        x = 1, y = 2,
        width = function(s)
            local p = rawget(s, "parent")
            return p and p.width or 1
        end,
        height = function(s)
            local p = rawget(s, "parent")
            return p and math.max(1, p.height - 1) or 1
        end,
        background = false,
        visible = false,
    })
    self:addChild(tab)
    local tabs = rawget(self, "_tabs")
    tabs[#tabs + 1] = { title = tostring(title), frame = tab }
    if self.active == 0 then
        self.active = #tabs
    end
    self:markDirty()
    return tab
end
function TabControl:setActiveTab(index, emit)
    local tabs = rawget(self, "_tabs")
    if not tabs[index] or self.active == index then return self end
    self.active = index
    if emit ~= false then
        self:fire("change", index, tabs[index].title)
    end
    return self
end
function TabControl:getTab(index)
    local tab = rawget(self, "_tabs")[index]
    return tab and tab.frame or nil
end
function TabControl:getTabCount()
    return #rawget(self, "_tabs")
end
function TabControl:handleKey(event, a, b)
    if event == "key" then
        local count = #rawget(self, "_tabs")
        if count > 0 then
            if a == keys.left then
                self:setActiveTab(math.max(1, self.active - 1))
            elseif a == keys.right then
                self:setActiveTab(math.min(count, self.active + 1))
            end
        end
    end
    Container.handleKey(self, event, a, b)
end
function TabControl:render(buf)
    Container.render(self, buf)
    buf:fill(1, 1, self.width, 1, " ", self.foreground, self.headerBackground)
    local active = self.active
    for i, span in ipairs(spans(self)) do
        if i == active then
            buf:blit(span[1], 1, span[3],
                self.activeForeground, self.activeBackground)
        else
            buf:blit(span[1], 1, span[3],
                self.foreground, self.headerBackground)
        end
    end
end
return TabControl
]=]
sources["elements/Table"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local itemview = require("core/itemview")
local Table = class.create("Table", Element)
local function invalidateView(self)
    rawset(self, "_viewOrder", nil)
end
local function normalizeColumns(columns)
    if type(columns) ~= "table" then
        error("Basalt Table: columns must be a table", 3)
    end
    local result = {}
    for i, column in ipairs(columns) do
        if type(column) == "string" then
            result[i] = { title = column, name = column, width = #column + 1 }
        elseif type(column) == "table" then
            local title = column.title or column.name or ""
            result[i] = {
                title = title,
                name = column.name or title,
                width = column.width,
                minWidth = column.minWidth or 1,
                maxWidth = column.maxWidth,
            }
        else
            error("Basalt Table: column " .. i .. " must be a string or table", 3)
        end
    end
    return result
end
class.property(Table, "columns", false, {
    onChange = function(self, value)
        rawget(self, "_p").columns = normalizeColumns(value)
        invalidateView(self)
    end,
})
class.property(Table, "data", false, { onChange = invalidateView })
class.property(Table, "selected", false, {
    state = "selected",
    stateWhen = function(v) return v ~= false and v ~= nil end,
    styleable = false,
})
class.property(Table, "offset", 0)
class.property(Table, "sortable", true)
class.property(Table, "sortColumn", false, { styleable = false })
class.property(Table, "sortDirection", "asc", { styleable = false })
class.property(Table, "background", colors.black)
class.property(Table, "headerBackground", colors.gray)
class.property(Table, "gridColor", colors.gray)
class.property(Table, "selectionBackground", colors.blue)
class.property(Table, "selectionForeground", colors.white)
class.property(Table, "width", 26)
class.property(Table, "height", 8)
class.property(Table, "scrollbar", "auto")
class.property(Table, "scrollbarColor", colors.gray)
class.property(Table, "scrollbarThumbColor", colors.lightGray)
class.property(Table, "scrollBarSymbol", " ")
class.property(Table, "scrollBarBackground", "\127")
class.event(Table, "select")
class.event(Table, "rowSelect")
class.event(Table, "change")
class.event(Table, "sort")
local function rowArea(self)
    return math.max(0, self.height - 1)
end
local function geometry(self)
    return itemview.geometry(#self.data, rowArea(self), self.offset,
        self.scrollbar)
end
local function viewOrder(self)
    local data = self.data
    local view = rawget(self, "_viewOrder")
    if view and #view == #data then return view end
    view = {}
    for i = 1, #data do view[i] = i end
    local col = rawget(self, "_sortCol")
    if col then
        local ascending = rawget(self, "_sortAsc")
        local custom = rawget(self, "_columnSorters")[col]
        table.sort(view, function(a, b)
            local sortValues = rawget(self, "_sortValues")
            local va = sortValues[data[a]] and sortValues[data[a]][col] or data[a][col]
            local vb = sortValues[data[b]] and sortValues[data[b]][col] or data[b][col]
            if custom then return custom(va, vb, ascending, data[a], data[b]) end
            if type(va) == "number" and type(vb) == "number" then
                if ascending then return va < vb end
                return va > vb
            end
            va, vb = tostring(va), tostring(vb)
            if ascending then return va < vb end
            return va > vb
        end)
    end
    rawset(self, "_viewOrder", view)
    return view
end
local function columnLayout(self, usable)
    local cols = self.columns
    local gaps = math.max(0, #cols - 1)
    local available = math.max(0, usable - gaps)
    local fixed, flex = 0, {}
    local widths = {}
    for i = 1, #cols do
        local spec = cols[i].width
        local width
        if type(spec) == "number" then
            width = spec
        elseif type(spec) == "string" then
            local percent = tonumber(spec:match("^(%-?[%d%.]+)%%$"))
            if percent then width = math.floor(available * percent / 100) end
        end
        if width then
            width = math.max(cols[i].minWidth or 1, math.floor(width))
            if cols[i].maxWidth then width = math.min(width, cols[i].maxWidth) end
            widths[i], fixed = width, fixed + width
        else
            flex[#flex + 1] = i
        end
    end
    local rest = math.max(0, available - fixed)
    for n, index in ipairs(flex) do
        local width = math.floor(rest / math.max(1, #flex - n + 1))
        width = math.max(cols[index].minWidth or 1, width)
        if cols[index].maxWidth then width = math.min(width, cols[index].maxWidth) end
        widths[index], rest = width, math.max(0, rest - width)
    end
    local out = {}
    local x = 1
    for i = 1, #cols do
        local w = math.max(0, math.min(widths[i] or 0, usable - x + 1))
        out[i] = { x = x, width = w }
        x = x + w + 1
    end
    return out
end
function Table:sortBy(columnIndex, ascending)
    if self.columns[columnIndex] == nil then return self end
    if ascending == nil then
        ascending = rawget(self, "_sortCol") ~= columnIndex
            or not rawget(self, "_sortAsc")
    end
    rawset(self, "_sortCol", columnIndex)
    rawset(self, "_sortAsc", ascending and true or false)
    rawget(self, "_p").sortColumn = columnIndex
    rawget(self, "_p").sortDirection = ascending and "asc" or "desc"
    invalidateView(self)
    self:fire("sort", columnIndex, ascending)
    self:markDirty()
    return self
end
function Table:select(dataIndex, emit)
    local oldIndex = self.selected
    local oldRow = oldIndex and self.data[oldIndex] or nil
    if dataIndex == false or dataIndex == nil then
        self.selected = false
        if oldIndex then self:fire("change", false, nil, oldIndex, oldRow) end
        return self
    end
    if self.data[dataIndex] == nil then return self end
    self.selected = dataIndex
    local view = viewOrder(self)
    for viewIndex = 1, #view do
        if view[viewIndex] == dataIndex then
            self.offset = itemview.ensureVisible(self.offset, viewIndex,
                #view, rowArea(self))
            break
        end
    end
    if oldIndex ~= dataIndex then
        self:fire("change", dataIndex, self.data[dataIndex], oldIndex or false, oldRow)
    end
    if emit ~= false then
        self:fire("select", dataIndex, self.data[dataIndex])
        self:fire("rowSelect", dataIndex, self.data[dataIndex])
    end
    return self
end
function Table:addRow(...)
    local count = select("#", ...)
    local row = count == 1 and type((...)) == "table" and (...) or { ... }
    local data = self.data
    data[#data + 1] = row
    rawget(self, "_sortValues")[row] = row
    invalidateView(self)
    self:markDirty()
    return self
end
function Table:removeRow(dataIndex)
    local data = self.data
    if data[dataIndex] == nil then return self end
    local oldIndex = self.selected
    local oldRow = oldIndex and data[oldIndex] or nil
    local removed = table.remove(data, dataIndex)
    rawget(self, "_sortValues")[removed] = nil
    if self.selected == dataIndex then
        self.selected = false
        self:fire("change", false, nil, oldIndex, oldRow)
    elseif self.selected and self.selected > dataIndex then
        self.selected = self.selected - 1
        self:fire("change", self.selected, self.data[self.selected],
            oldIndex, oldRow)
    end
    invalidateView(self)
    self:markDirty()
    return self
end
function Table:getRow(dataIndex)
    return self.data[dataIndex]
end
function Table:updateCell(dataIndex, columnIndex, value)
    local row = self.data[dataIndex]
    if row == nil then return self end
    row[columnIndex] = value
    local sortValues = rawget(self, "_sortValues")
    if sortValues[row] then sortValues[row][columnIndex] = value end
    invalidateView(self)
    self:markDirty()
    return self
end
function Table:setColumnSort(columnIndex, fn)
    local sorters = rawget(self, "_columnSorters")
    sorters[columnIndex] = fn
    invalidateView(self)
    self:markDirty()
    return self
end
function Table:setColumnSortFunction(columnIndex, fn)
    if fn == nil then return self:setColumnSort(columnIndex, nil) end
    return self:setColumnSort(columnIndex, function(_, _, ascending, rowA, rowB)
        return fn(rowA, rowB, ascending and "asc" or "desc")
    end)
end
function Table:sortByColumn(columnIndex, fn)
    if fn then self:setColumnSortFunction(columnIndex, fn) end
    return self:sortBy(columnIndex, self.sortDirection ~= "desc")
end
function Table:setSortColumn(columnIndex)
    if columnIndex == false or columnIndex == nil then
        rawset(self, "_sortCol", nil)
        rawget(self, "_p").sortColumn = false
        invalidateView(self)
        self:markDirty()
        return self
    end
    return self:sortBy(columnIndex, self.sortDirection ~= "desc")
end
function Table:setSortDirection(direction)
    if direction ~= "asc" and direction ~= "desc" then
        error("Basalt Table: sortDirection must be 'asc' or 'desc'", 2)
    end
    rawget(self, "_p").sortDirection = direction
    if self.sortColumn then self:sortBy(self.sortColumn, direction == "asc") end
    return self
end
function Table:getSelectedRow()
    return self.selected and self.data[self.selected] or nil
end
function Table:clearData()
    return self:clear()
end
function Table:addColumn(name, width)
    local columns = {}
    for i, column in ipairs(self.columns) do columns[i] = column end
    columns[#columns + 1] = { name = name, title = name, width = width }
    self.columns = columns
    return self
end
function Table:setData(rawData, formatters)
    if type(rawData) ~= "table" then
        error("Basalt Table: data must be a table", 2)
    end
    self:clear()
    local data, sortValues = {}, rawget(self, "_sortValues")
    for i, source in ipairs(rawData) do
        local row, original = {}, {}
        for column, value in ipairs(source) do
            original[column] = value
            row[column] = formatters and formatters[column]
                and formatters[column](value) or value
        end
        data[i], sortValues[row] = row, original
    end
    rawget(self, "_p").data = data
    invalidateView(self)
    self:markDirty()
    return self
end
function Table:calculateColumnWidths(columns, totalWidth)
    local original = self.columns
    rawget(self, "_p").columns = normalizeColumns(columns)
    local layout = columnLayout(self, totalWidth)
    rawget(self, "_p").columns = original
    local result = {}
    for i, column in ipairs(columns) do
        result[i] = {
            name = type(column) == "table" and (column.name or column.title) or column,
            width = type(column) == "table" and column.width or nil,
            visibleWidth = layout[i].width,
        }
    end
    return result
end
function Table:setHeaderColor(color)
    self.headerBackground = color
    return self
end
function Table:getHeaderColor() return self.headerBackground end
function Table:setSelectedForeground(color) self.selectionForeground = color return self end
function Table:getSelectedForeground() return self.selectionForeground end
function Table:setSelectedBackground(color) self.selectionBackground = color return self end
function Table:getSelectedBackground() return self.selectionBackground end
function Table:setSelectionColor(foreground, background)
    self.selectionForeground, self.selectionBackground = foreground, background
    return self
end
function Table:getSelectionColor()
    return self.selectionForeground, self.selectionBackground
end
function Table:setShowScrollBar(show)
    self.scrollbar = show and "auto" or "hidden"
    return self
end
function Table:getShowScrollBar() return self.scrollbar ~= "hidden" end
function Table:setScrollBarColor(color)
    self.scrollbarThumbColor = color
    return self
end
function Table:getScrollBarColor() return self.scrollbarThumbColor end
function Table:setScrollBarBackgroundColor(color)
    self.scrollbarColor = color
    return self
end
function Table:getScrollBarBackgroundColor() return self.scrollbarColor end
function Table:clear()
    local oldIndex = self.selected
    local oldRow = oldIndex and self.data[oldIndex] or nil
    rawget(self, "_p").data = {}
    rawset(self, "_sortValues", setmetatable({}, { __mode = "k" }))
    self.selected = false
    self.offset = 0
    invalidateView(self)
    self:markDirty()
    if oldIndex then self:fire("change", false, nil, oldIndex, oldRow) end
    return self
end
function Table:setup()
    Element.setup(self)
    local p = rawget(self, "_p")
    p.columns = {}
    p.data = {}
    rawset(self, "_columnSorters", {})
    rawset(self, "_sortValues", setmetatable({}, { __mode = "k" }))
    self:on("click", function(s, _, x, y)
        local g = geometry(s)
        if y == 1 then
            if not s.sortable then return end
            local usable = s.width - (g.show and 1 or 0)
            for i, col in ipairs(columnLayout(s, usable)) do
                if x >= col.x and x < col.x + col.width then
                    s:sortBy(i)
                    return
                end
            end
            return
        end
        if g.show and x == s.width then
            local target, grab = itemview.pointerDown(y - 1, g)
            if target ~= nil then s.offset = target end
            if grab ~= nil then rawset(s, "_itemScrollDrag", grab) end
            return
        end
        local dataIndex = viewOrder(s)[g.offset + y - 1]
        if dataIndex then
            s:select(dataIndex)
        end
    end)
    self:on("drag", function(s, _, _, y)
        local grab = rawget(s, "_itemScrollDrag")
        if grab ~= nil then
            s.offset = itemview.drag(y - 1, grab, geometry(s))
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_itemScrollDrag", nil)
    end)
end
function Table:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" then
        if self.disabled then return nil end
        local old = self.offset
        self.offset = itemview.clampOffset(old + btn, #self.data, rowArea(self))
        local userHandled = self:fire("scroll", btn, x, y)
        if self.offset ~= old or userHandled then return self end
        return nil
    end
    return Element.handleMouse(self, event, btn, x, y)
end
function Table:handleKey(event, a, b)
    if event == "key" and #self.data > 0 then
        local view = viewOrder(self)
        local current = 0
        for viewIndex = 1, #view do
            if view[viewIndex] == self.selected then
                current = viewIndex
                break
            end
        end
        if a == keys.up then
            self:select(view[math.max(1, current > 0 and current - 1 or 1)], false)
        elseif a == keys.down then
            self:select(view[current > 0
                and math.min(#view, current + 1) or 1], false)
        elseif a == keys.home then
            self:select(view[1], false)
        elseif a == keys["end"] then
            self:select(view[#view], false)
        elseif a == keys.enter and current > 0 then
            self:fire("select", self.selected, self.data[self.selected])
            self:fire("rowSelect", self.selected, self.data[self.selected])
        end
    end
    Element.handleKey(self, event, a, b)
end
function Table:measure()
    local w = 0
    for i = 1, #self.columns do
        w = w + (self.columns[i].width or 8) + 1
    end
    return math.max(1, w - 1), math.max(2, #self.data + 1)
end
function Table:render(buf)
    Element.render(self, buf)
    local w = self.width
    local g = geometry(self)
    rawget(self, "_p").offset = g.offset
    local usable = w - (g.show and 1 or 0)
    local cols = columnLayout(self, usable)
    local sortCol, sortAsc = rawget(self, "_sortCol"), rawget(self, "_sortAsc")
    buf:fill(1, 1, w, 1, " ", self.foreground, self.headerBackground)
    for i, col in ipairs(cols) do
        local title = tostring(self.columns[i].title or self.columns[i].name or "")
        if i == sortCol then
            title = title:sub(1, math.max(0, col.width - 1))
                .. (sortAsc and "\30" or "\31")
        end
        buf:blit(col.x, 1, title:sub(1, col.width),
            self.foreground, self.headerBackground)
    end
    local data, view, sel = self.data, viewOrder(self), self.selected
    for row = 1, rowArea(self) do
        local dataIndex = view[g.offset + row]
        if not dataIndex then break end
        local rowData = data[dataIndex]
        local isSel = dataIndex == sel
        local fg = isSel and self.selectionForeground or self.foreground
        local bg = isSel and self.selectionBackground or nil
        if isSel then
            buf:fill(1, row + 1, usable, 1, " ", fg, bg)
        end
        for i, col in ipairs(cols) do
            local cell = rowData[i]
            if cell ~= nil then
                buf:blit(col.x, row + 1,
                    tostring(cell):sub(1, col.width), fg, bg)
            end
        end
    end
    itemview.draw(buf, w, 2, g, self.foreground,
        self.scrollbarColor, self.scrollbarThumbColor)
end
return Table
]=]
sources["elements/TextBox"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local itemview = require("core/itemview")
local TextBox = class.create("TextBox", Element)
local internalClipboard = ""
class.property(TextBox, "text", "", {
    rawString = true,
    onChange = function(self, v)
        if rawget(self, "_syncing") then return end
        local lines = {}
        for line in (v .. "\n"):gmatch("(.-)\n") do
            lines[#lines + 1] = line
        end
        if #lines == 0 then lines = { "" } end
        rawset(self, "_lines", lines)
        local curLine = math.min(rawget(self, "_curLine") or 1, #lines)
        rawset(self, "_curLine", curLine)
        rawset(self, "_curCol",
            math.min(rawget(self, "_curCol") or 1, #lines[curLine] + 1))
        rawset(self, "_selLine", nil)
        rawset(self, "_selCol", nil)
    end,
})
class.property(TextBox, "background", colors.black)
class.property(TextBox, "width", 20)
class.property(TextBox, "height", 8)
class.property(TextBox, "scrollbar", "auto")
class.property(TextBox, "scrollbarColor", colors.gray)
class.property(TextBox, "scrollbarThumbColor", colors.lightGray)
class.property(TextBox, "selectionBackground", colors.blue)
class.property(TextBox, "selectionForeground", colors.white)
class.event(TextBox, "change")
local function geometry(self)
    return itemview.geometry(#self._lines, self.height, self._viewY,
        self.scrollbar)
end
local function textWidth(self)
    return math.max(1, self.width - (geometry(self).show and 1 or 0))
end
local function ensureView(self)
    rawset(self, "_viewY", itemview.ensureVisible(self._viewY, self._curLine,
        #self._lines, self.height))
    local tw = textWidth(self)
    local vx, col = self._viewX, self._curCol
    if col - vx > tw then vx = col - tw end
    if col - vx < 1 then vx = col - 1 end
    rawset(self, "_viewX", vx)
end
local function syncText(self)
    rawset(self, "_syncing", true)
    self.text = table.concat(self._lines, "\n")
    rawset(self, "_syncing", false)
    ensureView(self)
    self:fire("change", self.text)
end
local function orderedSelection(self)
    local anchorLine, anchorCol = rawget(self, "_selLine"), rawget(self, "_selCol")
    if not anchorLine then return nil end
    local curLine, curCol = self._curLine, self._curCol
    if anchorLine == curLine and anchorCol == curCol then return nil end
    if curLine < anchorLine
        or (curLine == anchorLine and curCol < anchorCol) then
        return curLine, curCol, anchorLine, anchorCol
    end
    return anchorLine, anchorCol, curLine, curCol
end
local function clearSelection(self)
    if rawget(self, "_selLine") then
        rawset(self, "_selLine", nil)
        rawset(self, "_selCol", nil)
        self:markDirty()
    end
end
local function anchorSelection(self)
    if not rawget(self, "_selLine") then
        rawset(self, "_selLine", self._curLine)
        rawset(self, "_selCol", self._curCol)
    end
end
local function moveCursor(self, line, col)
    local lines = self._lines
    line = math.max(1, math.min(#lines, line))
    col = math.max(1, math.min(#lines[line] + 1, col))
    rawset(self, "_curLine", line)
    rawset(self, "_curCol", col)
    ensureView(self)
    self:markDirty()
end
function TextBox:getSelection()
    local l1, c1, l2, c2 = orderedSelection(self)
    if not l1 then return nil end
    local lines = self._lines
    if l1 == l2 then
        return lines[l1]:sub(c1, c2 - 1)
    end
    local out = { lines[l1]:sub(c1) }
    for i = l1 + 1, l2 - 1 do
        out[#out + 1] = lines[i]
    end
    out[#out + 1] = lines[l2]:sub(1, c2 - 1)
    return table.concat(out, "\n")
end
function TextBox:deleteSelection()
    local l1, c1, l2, c2 = orderedSelection(self)
    if not l1 then return false end
    local lines = self._lines
    lines[l1] = lines[l1]:sub(1, c1 - 1) .. lines[l2]:sub(c2)
    for i = l2, l1 + 1, -1 do
        table.remove(lines, i)
    end
    rawset(self, "_curLine", l1)
    rawset(self, "_curCol", c1)
    clearSelection(self)
    syncText(self)
    return true
end
function TextBox:selectAll()
    rawset(self, "_selLine", 1)
    rawset(self, "_selCol", 1)
    local lines = self._lines
    moveCursor(self, #lines, #lines[#lines] + 1)
    return self
end
function TextBox:copy()
    local selection = self:getSelection()
    if selection then internalClipboard = selection end
    return selection
end
function TextBox:cut()
    local selection = self:copy()
    if selection then self:deleteSelection() end
    return selection
end
function TextBox:getClipboard()
    return internalClipboard
end
local function insertText(self, str)
    self:deleteSelection()
    local lines = self._lines
    local line, col = self._curLine, self._curCol
    local current = lines[line]
    lines[line] = current:sub(1, col - 1) .. str .. current:sub(col)
    rawset(self, "_curCol", col + #str)
    syncText(self)
end
local function pointFromMouse(self, x, y)
    local g = geometry(self)
    local line = math.max(1, math.min(#self._lines, g.offset + y))
    local col = math.max(1,
        math.min(#self._lines[line] + 1, self._viewX + x))
    return line, col
end
function TextBox:setup()
    Element.setup(self)
    rawset(self, "_lines", { "" })
    rawset(self, "_curLine", 1)
    rawset(self, "_curCol", 1)
    rawset(self, "_viewX", 0)
    rawset(self, "_viewY", 0)
    self:on("click", function(s, _, x, y)
        local g = geometry(s)
        if g.show and x == s.width then
            local target, grab = itemview.pointerDown(y, g)
            rawset(s, "_viewY", target)
            if grab ~= nil then rawset(s, "_itemScrollDrag", grab) end
            s:markDirty()
            return
        end
        clearSelection(s)
        local line, col = pointFromMouse(s, x, y)
        rawset(s, "_mouseAnchor", { line = line, col = col })
        moveCursor(s, line, col)
    end)
    self:on("drag", function(s, _, x, y)
        local grab = rawget(s, "_itemScrollDrag")
        if grab ~= nil then
            rawset(s, "_viewY", itemview.drag(y, grab, geometry(s)))
            s:markDirty()
            return
        end
        local anchor = rawget(s, "_mouseAnchor")
        if anchor then
            rawset(s, "_selLine", anchor.line)
            rawset(s, "_selCol", anchor.col)
            moveCursor(s, pointFromMouse(s, x, y))
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_itemScrollDrag", nil)
        rawset(s, "_mouseAnchor", nil)
    end)
    self:on("blur", function(s)
        rawset(s, "_shift", false)
        rawset(s, "_ctrl", false)
    end)
end
function TextBox:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" then
        if self.disabled then return nil end
        local old = self._viewY
        rawset(self, "_viewY", itemview.clampOffset(old + btn,
            #self._lines, self.height))
        local userHandled = self:fire("scroll", btn, x, y)
        if self._viewY ~= old or userHandled then
            self:markDirty()
            return self
        end
        return nil
    end
    return Element.handleMouse(self, event, btn, x, y)
end
local movementKeys
local function initMovement()
    movementKeys = {
        [keys.left] = function(self, line, col)
            if col > 1 then return line, col - 1 end
            if line > 1 then return line - 1, #self._lines[line - 1] + 1 end
            return line, col
        end,
        [keys.right] = function(self, line, col, current)
            if col <= #current then return line, col + 1 end
            if line < #self._lines then return line + 1, 1 end
            return line, col
        end,
        [keys.up] = function(self, line, col) return line - 1, col end,
        [keys.down] = function(self, line, col) return line + 1, col end,
        [keys.home] = function(self, line) return line, 1 end,
        [keys["end"]] = function(self, line, _, current)
            return line, #current + 1
        end,
        [keys.pageUp] = function(self, line, col)
            return line - self.height, col
        end,
        [keys.pageDown] = function(self, line, col)
            return line + self.height, col
        end,
    }
end
function TextBox:handleKey(event, a, b)
    if event == "char" or event == "paste" then
        insertText(self, a)
    elseif event == "key_up" then
        if a == keys.leftShift or a == keys.rightShift then
            rawset(self, "_shift", false)
        elseif a == keys.leftCtrl or a == keys.rightCtrl then
            rawset(self, "_ctrl", false)
        end
    elseif event == "key" then
        if not movementKeys then initMovement() end
        local lines = self._lines
        local line, col = self._curLine, self._curCol
        local current = lines[line]
        local movement = movementKeys[a]
        if a == keys.leftShift or a == keys.rightShift then
            rawset(self, "_shift", true)
        elseif a == keys.leftCtrl or a == keys.rightCtrl then
            rawset(self, "_ctrl", true)
        elseif rawget(self, "_ctrl") and a == keys.a then
            self:selectAll()
        elseif rawget(self, "_ctrl") and a == keys.c then
            self:copy()
        elseif rawget(self, "_ctrl") and a == keys.x then
            self:cut()
        elseif movement then
            if rawget(self, "_shift") then
                anchorSelection(self)
            else
                clearSelection(self)
            end
            moveCursor(self, movement(self, line, col, current))
        elseif a == keys.escape then
            clearSelection(self)
        elseif a == keys.enter then
            if self:deleteSelection() then
                lines = self._lines
                line, col = self._curLine, self._curCol
                current = lines[line]
            end
            lines[line] = current:sub(1, col - 1)
            table.insert(lines, line + 1, current:sub(col))
            rawset(self, "_curLine", line + 1)
            rawset(self, "_curCol", 1)
            syncText(self)
        elseif a == keys.backspace then
            if self:deleteSelection() then
            elseif col > 1 then
                lines[line] = current:sub(1, col - 2) .. current:sub(col)
                rawset(self, "_curCol", col - 1)
                syncText(self)
            elseif line > 1 then
                local previous = lines[line - 1]
                rawset(self, "_curLine", line - 1)
                rawset(self, "_curCol", #previous + 1)
                lines[line - 1] = previous .. current
                table.remove(lines, line)
                syncText(self)
            end
        elseif a == keys.delete then
            if self:deleteSelection() then
            elseif col <= #current then
                lines[line] = current:sub(1, col - 1) .. current:sub(col + 1)
                syncText(self)
            elseif line < #lines then
                lines[line] = current .. lines[line + 1]
                table.remove(lines, line + 1)
                syncText(self)
            end
        end
    end
    Element.handleKey(self, event, a, b)
end
function TextBox:measure()
    local w = 1
    for _, line in ipairs(self._lines) do
        w = math.max(w, #line)
    end
    return w + 1, math.max(1, #self._lines)
end
function TextBox:render(buf)
    Element.render(self, buf)
    local lines = self._lines
    local g = geometry(self)
    rawset(self, "_viewY", g.offset)
    local tw = math.max(0, self.width - (g.show and 1 or 0))
    local vx = self._viewX
    for row = 1, self.height do
        local line = lines[g.offset + row]
        if not line then break end
        buf:blit(1, row, line:sub(vx + 1, vx + tw), self.foreground, nil)
    end
    local l1, c1, l2, c2 = orderedSelection(self)
    if l1 then
        for row = 1, self.height do
            local lineIndex = g.offset + row
            local line = lines[lineIndex]
            if line and lineIndex >= l1 and lineIndex <= l2 then
                local startCol = (lineIndex == l1) and c1 or 1
                local endCol = (lineIndex == l2) and (c2 - 1) or (#line + 1)
                local absStart = math.max(startCol, vx + 1)
                local absEnd = math.min(endCol, vx + tw)
                if absEnd >= absStart then
                    local segment = line:sub(absStart, absEnd)
                    segment = segment
                        .. string.rep(" ", (absEnd - absStart + 1) - #segment)
                    buf:blit(absStart - vx, row, segment,
                        self.selectionForeground, self.selectionBackground)
                end
            end
        end
    end
    itemview.draw(buf, self.width, 1, g, self.foreground,
        self.scrollbarColor, self.scrollbarThumbColor)
    local root = self:getRoot()
    if root.getFocused and root:getFocused() == self then
        self:setCursor(self._curCol - vx, self._curLine - g.offset,
            true, self.foreground)
    end
end
return TextBox
]=]
sources["elements/Toast"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local textutil = require("core/text")
local Toast = class.create("Toast", Element)
class.property(Toast, "message", "")
class.property(Toast, "duration", 3)
class.property(Toast, "maxWidth", 24)
class.property(Toast, "visible", false)
class.property(Toast, "toastColors", false)
class.property(Toast, "width", function(self)
    local w = 1
    for _, line in ipairs(rawget(self, "_lines") or { "" }) do
        w = math.max(w, #line)
    end
    return w + 2
end)
class.property(Toast, "height", function(self)
    return math.max(1, #(rawget(self, "_lines") or { "" }))
end)
class.property(Toast, "x", function(self)
    local parent = rawget(self, "parent")
    return parent and math.max(1, parent.width - self.width) or 1
end)
class.property(Toast, "y", 2)
class.event(Toast, "hide")
function Toast:setup()
    Element.setup(self)
    self.z = 900
    rawget(self, "_p").toastColors = {
        default = { bg = colors.gray, fg = colors.white },
        success = { bg = colors.green, fg = colors.white },
        error = { bg = colors.red, fg = colors.white },
        warning = { bg = colors.orange, fg = colors.black },
        info = { bg = colors.blue, fg = colors.white },
    }
    self:on("click", function(s) s:hide() end)
end
function Toast:show(message, toastType, duration)
    self.message = tostring(message)
    rawset(self, "_lines", textutil.wrap(self.message, self.maxWidth - 2))
    local palette = self.toastColors[toastType or "default"]
        or self.toastColors.default
    self.background = palette.bg
    self.foreground = palette.fg
    self.visible = true
    self:markDirty()
    duration = duration or self.duration
    local token = (rawget(self, "_showToken") or 0) + 1
    rawset(self, "_showToken", token)
    if duration and duration > 0 then
        local basalt = require("main")
        basalt.schedule(function()
            sleep(duration)
            if rawget(self, "_showToken") == token then
                self:hide()
            end
        end)
    end
    return self
end
function Toast:hide()
    if not self.visible then return self end
    self.visible = false
    self:fire("hide")
    return self
end
function Toast:success(message, duration)
    return self:show(message, "success", duration)
end
function Toast:error(message, duration)
    return self:show(message, "error", duration)
end
function Toast:warning(message, duration)
    return self:show(message, "warning", duration)
end
function Toast:info(message, duration)
    return self:show(message, "info", duration)
end
function Toast:render(buf)
    Element.render(self, buf)
    local lines = rawget(self, "_lines") or { "" }
    for i = 1, #lines do
        buf:blit(2, i, lines[i], self.foreground, self.background)
    end
end
return Toast
]=]
sources["elements/Tree"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local itemview = require("core/itemview")
local Tree = class.create("Tree", Element)
class.property(Tree, "nodes", false, {
    onChange = function(self, nodes)
        if type(nodes) ~= "table" then
            error("Basalt Tree: nodes must be a table", 3)
        end
        local old = self.selected
        self.offset = 0
        self.horizontalOffset = 0
        self.selected = false
        if old then self:fire("change", false, old) end
        if nodes[1] and nodes[1].children and nodes[1].expanded == nil then
            nodes[1].expanded = true
        end
    end,
})
class.property(Tree, "selected", false, {
    state = "selected",
    stateWhen = function(v) return v ~= false and v ~= nil end,
    styleable = false,
})
class.property(Tree, "offset", 0)
class.property(Tree, "horizontalOffset", 0)
class.property(Tree, "background", colors.black)
class.property(Tree, "selectionBackground", colors.blue)
class.property(Tree, "selectionForeground", colors.white)
class.property(Tree, "width", 16)
class.property(Tree, "height", 8)
class.property(Tree, "scrollbar", "auto")
class.property(Tree, "scrollbarColor", colors.gray)
class.property(Tree, "scrollbarThumbColor", colors.lightGray)
class.property(Tree, "scrollBarSymbol", " ")
class.property(Tree, "scrollBarBackground", "\127")
class.event(Tree, "select")
class.event(Tree, "change")
class.event(Tree, "toggle")
local function flatten(self)
    local out = {}
    local function walk(nodes, depth, parent)
        for i = 1, #nodes do
            local node = nodes[i]
            out[#out + 1] = { node = node, depth = depth, parent = parent }
            if node.children and node.expanded then
                walk(node.children, depth + 1, node)
            end
        end
    end
    walk(self.nodes, 0, nil)
    return out
end
local function flatIndexOf(flat, node)
    for i = 1, #flat do
        if flat[i].node == node then return i end
    end
    return nil
end
local function geometry(self, flat)
    return itemview.geometry(#flat, self.height, self.offset, self.scrollbar)
end
function Tree:toggle(node, expanded)
    if not node or not node.children then return self end
    if expanded == nil then expanded = not node.expanded end
    node.expanded = expanded and true or false
    local flat = flatten(self)
    self.offset = itemview.clampOffset(self.offset, #flat, self.height)
    self:fire("toggle", node, node.expanded)
    self:markDirty()
    return self
end
function Tree:select(node, emit)
    local old = self.selected
    if node == false or node == nil then
        self.selected = false
        if old then self:fire("change", false, old) end
        return self
    end
    self.selected = node
    local flat = flatten(self)
    local index = flatIndexOf(flat, node)
    if index then
        self.offset = itemview.ensureVisible(self.offset, index,
            #flat, self.height)
    end
    if old ~= node then self:fire("change", node, old or false) end
    if emit ~= false then self:fire("select", node) end
    return self
end
function Tree:expandNode(node)
    return self:toggle(node, true)
end
function Tree:collapseNode(node)
    return self:toggle(node, false)
end
function Tree:toggleNode(node)
    return self:toggle(node)
end
function Tree:setSelectedNode(node)
    return self:select(node, false)
end
function Tree:getSelectedNode()
    return self.selected or nil
end
function Tree:getExpandedNodes()
    local result = {}
    local function walk(nodes)
        for _, node in ipairs(nodes) do
            if node.expanded then result[node] = true end
            if node.children then walk(node.children) end
        end
    end
    walk(self.nodes)
    return result
end
function Tree:setExpandedNodes(expanded)
    if type(expanded) ~= "table" then
        error("Basalt Tree: expandedNodes must be a table", 2)
    end
    local function walk(nodes)
        for _, node in ipairs(nodes) do
            if node.children then
                node.expanded = expanded[node] == true
                walk(node.children)
            end
        end
    end
    walk(self.nodes)
    self.offset = itemview.clampOffset(self.offset, #flatten(self), self.height)
    self:markDirty()
    return self
end
function Tree:getNodeSize()
    local flat = flatten(self)
    local width = 1
    for _, entry in ipairs(flat) do
        width = math.max(width,
            entry.depth + 2 + #tostring(entry.node.text or "Node"))
    end
    return width, #flat
end
function Tree:setHorizontalOffset(offset)
    local width = self:getNodeSize()
    rawget(self, "_p").horizontalOffset = math.max(0,
        math.min(math.floor(offset or 0), math.max(0, width - self.width)))
    self:markDirty()
    return self
end
function Tree:setSelectedForegroundColor(color)
    self.selectionForeground = color
    return self
end
function Tree:getSelectedForegroundColor() return self.selectionForeground end
function Tree:setSelectedBackgroundColor(color)
    self.selectionBackground = color
    return self
end
function Tree:getSelectedBackgroundColor() return self.selectionBackground end
function Tree:setSelectionColor(foreground, background)
    self.selectionForeground, self.selectionBackground = foreground, background
    return self
end
function Tree:getSelectionColor()
    return self.selectionForeground, self.selectionBackground
end
function Tree:setShowScrollBar(show)
    self.scrollbar = show and "auto" or "hidden"
    return self
end
function Tree:getShowScrollBar() return self.scrollbar ~= "hidden" end
function Tree:setScrollBarColor(color)
    self.scrollbarThumbColor = color
    return self
end
function Tree:getScrollBarColor() return self.scrollbarThumbColor end
function Tree:setScrollBarBackgroundColor(color)
    self.scrollbarColor = color
    return self
end
function Tree:getScrollBarBackgroundColor() return self.scrollbarColor end
function Tree:expandAll()
    local function walk(nodes)
        for i = 1, #nodes do
            if nodes[i].children then
                nodes[i].expanded = true
                walk(nodes[i].children)
            end
        end
    end
    walk(self.nodes)
    self:markDirty()
    return self
end
function Tree:collapseAll()
    local function walk(nodes)
        for i = 1, #nodes do
            if nodes[i].children then
                nodes[i].expanded = false
                walk(nodes[i].children)
            end
        end
    end
    walk(self.nodes)
    self:markDirty()
    return self
end
function Tree:setup()
    Element.setup(self)
    rawget(self, "_p").nodes = {}
    self:on("click", function(s, _, x, y)
        local flat = flatten(s)
        local g = geometry(s, flat)
        if g.show and x == s.width then
            local target, grab = itemview.pointerDown(y, g)
            if target ~= nil then s.offset = target end
            if grab ~= nil then rawset(s, "_itemScrollDrag", grab) end
            return
        end
        local entry = flat[g.offset + y]
        if not entry then return end
        if entry.node.children and x >= entry.depth + 1 and x <= entry.depth + 2 then
            s:toggle(entry.node)
        else
            s:select(entry.node)
        end
    end)
    self:on("drag", function(s, _, _, y)
        local grab = rawget(s, "_itemScrollDrag")
        if grab ~= nil then
            s.offset = itemview.drag(y, grab, geometry(s, flatten(s)))
        end
    end)
    self:on("clickUp", function(s)
        rawset(s, "_itemScrollDrag", nil)
    end)
end
function Tree:handleMouse(event, btn, x, y)
    if event == "mouse_scroll" then
        if self.disabled then return nil end
        local flat = flatten(self)
        local old = self.offset
        self.offset = itemview.clampOffset(old + btn, #flat, self.height)
        local userHandled = self:fire("scroll", btn, x, y)
        if self.offset ~= old or userHandled then return self end
        return nil
    end
    return Element.handleMouse(self, event, btn, x, y)
end
function Tree:handleKey(event, a, b)
    if event == "key" then
        local flat = flatten(self)
        if #flat > 0 then
            local index = flatIndexOf(flat, self.selected) or 0
            if a == keys.up then
                self:select(flat[math.max(1, index > 0 and index - 1 or 1)].node, false)
            elseif a == keys.down then
                self:select(flat[index > 0
                    and math.min(#flat, index + 1) or 1].node, false)
            elseif a == keys.right and index > 0 then
                local node = flat[index].node
                if node.children and not node.expanded then
                    self:toggle(node, true)
                elseif node.children and node.expanded and node.children[1] then
                    self:select(node.children[1], false)
                end
            elseif a == keys.left and index > 0 then
                local entry = flat[index]
                if entry.node.children and entry.node.expanded then
                    self:toggle(entry.node, false)
                elseif entry.parent then
                    self:select(entry.parent, false)
                end
            elseif a == keys.enter and index > 0 then
                self:fire("select", flat[index].node)
            end
        end
    end
    Element.handleKey(self, event, a, b)
end
function Tree:measure()
    local flat = flatten(self)
    local w = 1
    for i = 1, #flat do
        w = math.max(w, flat[i].depth + 3 + #tostring(flat[i].node.text))
    end
    return w, math.max(1, #flat)
end
function Tree:render(buf)
    Element.render(self, buf)
    local flat = flatten(self)
    local g = geometry(self, flat)
    rawget(self, "_p").offset = g.offset
    local tw = math.max(0, self.width - (g.show and 1 or 0))
    local sel = self.selected
    for row = 1, self.height do
        local entry = flat[g.offset + row]
        if not entry then break end
        local node = entry.node
        local marker = node.children and (node.expanded and "- " or "+ ") or "  "
        local line = string.rep(" ", entry.depth) .. marker .. tostring(node.text)
        line = line:sub(self.horizontalOffset + 1,
            self.horizontalOffset + tw)
        if node == sel then
            buf:fill(1, row, tw, 1, " ",
                self.selectionForeground, self.selectionBackground)
            buf:blit(1, row, line:sub(1, tw),
                self.selectionForeground, self.selectionBackground)
        else
            buf:blit(1, row, line:sub(1, tw), self.foreground, nil)
        end
    end
    itemview.draw(buf, self.width, 1, g, self.foreground,
        self.scrollbarColor, self.scrollbarThumbColor)
end
return Tree
]=]
sources["modules/animation"] = [=[

local require = ...
local basalt = require("main")
local Element = require("core/element")
local animation = {}
local easings = {
    linear = function(t) return t end,
    easeIn = function(t) return t * t end,
    easeOut = function(t) return t * (2 - t) end,
    easeInOut = function(t)
        if t < 0.5 then return 2 * t * t end
        return -1 + (4 - 2 * t) * t
    end,
}
animation.easings = easings
local active = {}
local loopRunning = false
local function startLoop()
    if loopRunning then return end
    loopRunning = true
    basalt.schedule(function()
        while #active > 0 do
            sleep(0.05)
            local now = os.clock()
            for i = #active, 1, -1 do
                local a = active[i]
                local t = (now - a.start) / a.duration
                if t >= 1 then
                    for prop, target in pairs(a.to) do
                        a.el[prop] = target
                    end
                    table.remove(active, i)
                    if a.onDone then a.onDone(a.el) end
                else
                    local e = a.easing(t)
                    for prop, target in pairs(a.to) do
                        local from = a.from[prop]
                        a.el[prop] = math.floor(from + (target - from) * e + 0.5)
                    end
                end
            end
        end
        loopRunning = false
    end)
end
function animation.to(el, props, duration, easing, onDone)
    local a = {
        el = el,
        to = props,
        from = {},
        start = os.clock(),
        duration = duration or 0.3,
        easing = easings[easing or "easeInOut"]
            or error("Basalt animation: unknown easing '" .. tostring(easing) .. "'", 2),
        onDone = onDone,
    }
    for prop in pairs(props) do
        local v = el[prop]
        if type(v) ~= "number" then
            error("Basalt animation: property '" .. prop .. "' is not a number", 2)
        end
        a.from[prop] = v
    end
    active[#active + 1] = a
    startLoop()
    return {
        cancel = function()
            for i = 1, #active do
                if active[i] == a then
                    table.remove(active, i)
                    break
                end
            end
        end,
    }
end
function Element:animate(props, duration, easing, onDone)
    return animation.to(self, props, duration, easing, onDone)
end
return animation
]=]
sources["modules/bigfont"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local Container = require("core/container")
local palette = require("core/palette")
local tHex = palette.charOf
local rawFont = {{"\32\32\32\137\156\148\158\159\148\135\135\144\159\139\32\136\157\32\159\139\32\32\143\32\32\143\32\32\32\32\32\32\32\32\147\148\150\131\148\32\32\32\151\140\148\151\140\147", "\32\32\32\149\132\149\136\156\149\144\32\133\139\159\129\143\159\133\143\159\133\138\32\133\138\32\133\32\32\32\32\32\32\150\150\129\137\156\129\32\32\32\133\131\129\133\131\132", "\32\32\32\130\131\32\130\131\32\32\129\32\32\32\32\130\131\32\130\131\32\32\32\32\143\143\143\32\32\32\32\32\32\130\129\32\130\135\32\32\32\32\131\32\32\131\32\131", "\139\144\32\32\143\148\135\130\144\149\32\149\150\151\149\158\140\129\32\32\32\135\130\144\135\130\144\32\149\32\32\139\32\159\148\32\32\32\32\159\32\144\32\148\32\147\131\132", "\159\135\129\131\143\149\143\138\144\138\32\133\130\149\149\137\155\149\159\143\144\147\130\132\32\149\32\147\130\132\131\159\129\139\151\129\148\32\32\139\131\135\133\32\144\130\151\32", "\32\32\32\32\32\32\130\135\32\130\32\129\32\129\129\131\131\32\130\131\129\140\141\132\32\129\32\32\129\32\32\32\32\32\32\32\131\131\129\32\32\32\32\32\32\32\32\32", "\32\32\32\32\149\32\159\154\133\133\133\144\152\141\132\133\151\129\136\153\32\32\154\32\159\134\129\130\137\144\159\32\144\32\148\32\32\32\32\32\32\32\32\32\32\32\151\129", "\32\32\32\32\133\32\32\32\32\145\145\132\141\140\132\151\129\144\150\146\129\32\32\32\138\144\32\32\159\133\136\131\132\131\151\129\32\144\32\131\131\129\32\144\32\151\129\32", "\32\32\32\32\129\32\32\32\32\130\130\32\32\129\32\129\32\129\130\129\129\32\32\32\32\130\129\130\129\32\32\32\32\32\32\32\32\133\32\32\32\32\32\129\32\129\32\32", "\150\156\148\136\149\32\134\131\148\134\131\148\159\134\149\136\140\129\152\131\32\135\131\149\150\131\148\150\131\148\32\148\32\32\148\32\32\152\129\143\143\144\130\155\32\134\131\148", "\157\129\149\32\149\32\152\131\144\144\131\148\141\140\149\144\32\149\151\131\148\32\150\32\150\131\148\130\156\133\32\144\32\32\144\32\130\155\32\143\143\144\32\152\129\32\134\32", "\130\131\32\131\131\129\131\131\129\130\131\32\32\32\129\130\131\32\130\131\32\32\129\32\130\131\32\130\129\32\32\129\32\32\133\32\32\32\129\32\32\32\130\32\32\32\129\32", "\150\140\150\137\140\148\136\140\132\150\131\132\151\131\148\136\147\129\136\147\129\150\156\145\138\143\149\130\151\32\32\32\149\138\152\129\149\32\32\157\152\149\157\144\149\150\131\148", "\149\143\142\149\32\149\149\32\149\149\32\144\149\32\149\149\32\32\149\32\32\149\32\149\149\32\149\32\149\32\144\32\149\149\130\148\149\32\32\149\32\149\149\130\149\149\32\149", "\130\131\129\129\32\129\131\131\32\130\131\32\131\131\32\131\131\129\129\32\32\130\131\32\129\32\129\130\131\32\130\131\32\129\32\129\131\131\129\129\32\129\129\32\129\130\131\32", "\136\140\132\150\131\148\136\140\132\153\140\129\131\151\129\149\32\149\149\32\149\149\32\149\137\152\129\137\152\129\131\156\133\149\131\32\150\32\32\130\148\32\152\137\144\32\32\32", "\149\32\32\149\159\133\149\32\149\144\32\149\32\149\32\149\32\149\150\151\129\138\155\149\150\130\148\32\149\32\152\129\32\149\32\32\32\150\32\32\149\32\32\32\32\32\32\32", "\129\32\32\130\129\129\129\32\129\130\131\32\32\129\32\130\131\32\32\129\32\129\32\129\129\32\129\32\129\32\131\131\129\130\131\32\32\32\129\130\131\32\32\32\32\140\140\132", "\32\154\32\159\143\32\149\143\32\159\143\32\159\144\149\159\143\32\159\137\145\159\143\144\149\143\32\32\145\32\32\32\145\149\32\144\32\149\32\143\159\32\143\143\32\159\143\32", "\32\32\32\152\140\149\151\32\149\149\32\145\149\130\149\157\140\133\32\149\32\154\143\149\151\32\149\32\149\32\144\32\149\149\153\32\32\149\32\149\133\149\149\32\149\149\32\149", "\32\32\32\130\131\129\131\131\32\130\131\32\130\131\129\130\131\129\32\129\32\140\140\129\129\32\129\32\129\32\137\140\129\130\32\129\32\130\32\129\32\129\129\32\129\130\131\32", "\144\143\32\159\144\144\144\143\32\159\143\144\159\138\32\144\32\144\144\32\144\144\32\144\144\32\144\144\32\144\143\143\144\32\150\129\32\149\32\130\150\32\134\137\134\134\131\148", "\136\143\133\154\141\149\151\32\129\137\140\144\32\149\32\149\32\149\154\159\133\149\148\149\157\153\32\154\143\149\159\134\32\130\148\32\32\149\32\32\151\129\32\32\32\32\134\32", "\133\32\32\32\32\133\129\32\32\131\131\32\32\130\32\130\131\129\32\129\32\130\131\129\129\32\129\140\140\129\131\131\129\32\130\129\32\129\32\130\129\32\32\32\32\32\129\32", "\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32", "\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32", "\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32\32", "\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32\32\32\32\32\149\32\32\149\32\32\32\32", "\32\32\32\32\32\32\32\32\32\32\32\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\32\32\32\32\32\32\32\32\32\32\32", "\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32\32\149\32", "\32\32\32\32\145\32\159\139\32\151\131\132\155\143\132\134\135\145\32\149\32\158\140\129\130\130\32\152\147\155\157\134\32\32\144\144\32\32\32\32\32\32\152\131\155\131\131\129", "\32\32\32\32\149\32\149\32\145\148\131\32\149\32\149\140\157\132\32\148\32\137\155\149\32\32\32\149\154\149\137\142\32\153\153\32\131\131\149\131\131\129\149\135\145\32\32\32", "\32\32\32\32\129\32\130\135\32\131\131\129\134\131\132\32\129\32\32\129\32\131\131\32\32\32\32\130\131\129\32\32\32\32\129\129\32\32\32\32\32\32\130\131\129\32\32\32", "\150\150\32\32\148\32\134\32\32\132\32\32\134\32\32\144\32\144\150\151\149\32\32\32\32\32\32\145\32\32\152\140\144\144\144\32\133\151\129\133\151\129\132\151\129\32\145\32", "\130\129\32\131\151\129\141\32\32\142\32\32\32\32\32\149\32\149\130\149\149\32\143\32\32\32\32\142\132\32\154\143\133\157\153\132\151\150\148\151\158\132\151\150\148\144\130\148", "\32\32\32\140\140\132\32\32\32\32\32\32\32\32\32\151\131\32\32\129\129\32\32\32\32\134\32\32\32\32\32\32\32\129\129\32\129\32\129\129\130\129\129\32\129\130\131\32", "\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\150\151\129\150\131\132\140\143\144\143\141\145\137\140\148\141\141\144\157\142\32\159\140\32\151\134\32\157\141\32", "\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\157\140\149\151\151\32\154\143\132\157\140\32\157\140\32\157\140\32\157\140\32\32\149\32\32\149\32\32\149\32\32\149\32", "\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\32\129\129\131\129\32\134\32\131\131\129\131\131\129\131\131\129\131\131\129\130\131\32\130\131\32\130\131\32\130\131\32", "\151\131\148\152\137\145\155\140\144\152\142\145\153\140\132\153\137\32\154\142\144\155\159\132\150\156\148\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\136\32\151\140\132", "\151\32\149\151\155\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\152\137\144\157\129\149\149\32\149\149\32\149\149\32\149\149\32\149\130\150\32\32\157\129\149\32\149", "\131\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\129\32\130\131\32\133\131\32", "\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\159\142\32\159\159\144\152\140\144\156\143\32\159\141\129\153\140\132\157\141\32\130\145\32\32\147\32\136\153\32\130\146\32", "\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\152\140\149\149\157\134\154\143\132\157\140\133\157\140\133\157\140\133\157\140\133\32\149\32\32\149\32\32\149\32\32\149\32", "\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\131\129\130\130\131\32\134\32\130\131\129\130\131\129\130\131\129\130\131\129\32\129\32\32\129\32\32\129\32\32\129\32", "\159\134\144\137\137\32\156\143\32\159\141\129\153\140\132\153\137\32\157\141\32\32\132\32\159\143\32\147\32\144\144\130\145\136\137\32\146\130\144\144\130\145\130\138\32\146\130\144", "\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\149\32\149\131\147\129\138\134\149\149\32\149\149\32\149\149\32\149\149\32\149\154\143\149\32\157\129\154\143\149", "\130\131\32\129\32\129\130\131\32\130\131\32\130\131\32\130\131\32\130\131\32\32\32\32\130\131\32\130\131\129\130\131\129\130\131\129\130\131\129\140\140\129\130\131\32\140\140\129" }, {"000110000110110000110010101000000010000000100101", "000000110110000000000010101000000010000000100101", "000000000000000000000000000000000000000000000000", "100010110100000010000110110000010100000100000110", "000000110000000010110110000110000000000000110000", "000000000000000000000000000000000000000000000000", "000000110110000010000000100000100000000000000010", "000000000110110100010000000010000000000000000100", "000000000000000000000000000000000000000000000000", "010000000000100110000000000000000000000110010000", "000000000000000000000000000010000000010110000000", "000000000000000000000000000000000000000000000000", "011110110000000100100010110000000100000000000000", "000000000000000000000000000000000000000000000000", "000000000000000000000000000000000000000000000000", "110000110110000000000000000000010100100010000000", "000010000000000000110110000000000100010010000000", "000000000000000000000000000000000000000000000000", "010110010110100110110110010000000100000110110110", "000000000000000000000110000000000110000000000000", "000000000000000000000000000000000000000000000000", "010100010110110000000000000000110000000010000000", "110110000000000000110000110110100000000010000000", "000000000000000000000000000000000000000000000000", "000100011111000100011111000100011111000100011111", "000000000000100100100100011011011011111111111111", "000000000000000000000000000000000000000000000000", "000100011111000100011111000100011111000100011111", "000000000000100100100100011011011011111111111111", "100100100100100100100100100100100100100100100100", "000000110100110110000010000011110000000000011000", "000000000100000000000010000011000110000000001000", "000000000000000000000000000000000000000000000000", "010000100100000000000000000100000000010010110000", "000000000000000000000000000000110110110110110000", "000000000000000000000000000000000000000000000000", "110110110110110110000000110110110110110110110110", "000000000000000000000110000000000000000000000000", "000000000000000000000000000000000000000000000000", "000000000000110110000110010000000000000000010010", "000010000000000000000000000000000000000000000000", "000000000000000000000000000000000000000000000000", "110110110110110110110000110110110110000000000000", "000000000000000000000110000000000000000000000000", "000000000000000000000000000000000000000000000000", "110110110110110110110000110000000000000000010000", "000000000000000000000000100000000000000110000110", "000000000000000000000000000000000000000000000000" }}
local fonts = {}
local firstFont = {}
do
    local char = 0
    local height = #rawFont[1]
    local length = #rawFont[1][1]
    for i = 1, height, 3 do
        for j = 1, length, 3 do
            local thisChar = string.char(char)
            local temp = {}
            temp[1] = rawFont[1][i]:sub(j, j + 2)
            temp[2] = rawFont[1][i + 1]:sub(j, j + 2)
            temp[3] = rawFont[1][i + 2]:sub(j, j + 2)
            local temp2 = {}
            temp2[1] = rawFont[2][i]:sub(j, j + 2)
            temp2[2] = rawFont[2][i + 1]:sub(j, j + 2)
            temp2[3] = rawFont[2][i + 2]:sub(j, j + 2)
            firstFont[thisChar] = {temp, temp2}
            char = char + 1
        end
    end
    fonts[1] = firstFont
end
local function generateFontSize(size,yeld)
    local inverter = {["0"] = "1", ["1"] = "0"}
    if size<= #fonts then return true end
    for f = #fonts+1, size do
        local nextFont = {}
        local lastFont = fonts[f - 1]
        for char = 0, 255 do
            local thisChar = string.char(char)
            local temp = {}
            local temp2 = {}
            local templateChar = lastFont[thisChar][1]
            local templateBack = lastFont[thisChar][2]
            for i = 1, #templateChar do
                local line1, line2, line3, back1, back2, back3 = {}, {}, {}, {}, {}, {}
                for j = 1, #templateChar[1] do
                    local currentChar = firstFont[templateChar[i]:sub(j, j)][1]
                    table.insert(line1, currentChar[1])
                    table.insert(line2, currentChar[2])
                    table.insert(line3, currentChar[3])
                    local currentBack = firstFont[templateChar[i]:sub(j, j)][2]
                    if templateBack[i]:sub(j, j) == "1" then
                        table.insert(back1, (currentBack[1]:gsub("[01]", inverter)))
                        table.insert(back2, (currentBack[2]:gsub("[01]", inverter)))
                        table.insert(back3, (currentBack[3]:gsub("[01]", inverter)))
                    else
                        table.insert(back1, currentBack[1])
                        table.insert(back2, currentBack[2])
                        table.insert(back3, currentBack[3])
                    end
                end
                table.insert(temp, table.concat(line1))
                table.insert(temp, table.concat(line2))
                table.insert(temp, table.concat(line3))
                table.insert(temp2, table.concat(back1))
                table.insert(temp2, table.concat(back2))
                table.insert(temp2, table.concat(back3))
            end
            nextFont[thisChar] = {temp, temp2}
                if yeld then yeld = "Font"..f.."Yeld"..char os.queueEvent(yeld) os.pullEvent(yeld) end
        end
        fonts[f] = nextFont
    end
    return true
end
local function makeText(nSize, sString, nFC, nBC, bBlit)
    if not type(sString) == "string" then error("Not a String",3) end
    local cFC = type(nFC) == "string" and nFC:sub(1, 1) or tHex[nFC] or error("Wrong Front Color",3)
    local cBC = type(nBC) == "string" and nBC:sub(1, 1) or tHex[nBC] or error("Wrong Back Color",3)
    if(fonts[nSize]==nil)then generateFontSize(3,false) end
    local font = fonts[nSize] or error("Wrong font size selected",3)
    if sString == "" then return {{""}, {""}, {""}} end
    local input = {}
    for i in sString:gmatch('.') do table.insert(input, i) end
    local tText = {}
    local height = #font[input[1]][1]
    for nLine = 1, height do
        local outLine = {}
        for i = 1, #input do
            outLine[i] = font[input[i]] and font[input[i]][1][nLine] or ""
        end
        tText[nLine] = table.concat(outLine)
    end
    local tFront = {}
    local tBack = {}
    local tFrontSub = {["0"] = cFC, ["1"] = cBC}
    local tBackSub = {["0"] = cBC, ["1"] = cFC}
    for nLine = 1, height do
        local front = {}
        local back = {}
        for i = 1, #input do
            local template = font[input[i]] and font[input[i]][2][nLine] or ""
            front[i] = template:gsub("[01]", bBlit and {["0"] = nFC:sub(i, i), ["1"] = nBC:sub(i, i)} or tFrontSub)
            back[i] = template:gsub("[01]", bBlit and {["0"] = nBC:sub(i, i), ["1"] = nFC:sub(i, i)} or tBackSub)
        end
        tFront[nLine] = table.concat(front)
        tBack[nLine] = table.concat(back)
    end
    return {tText, tFront, tBack}
end
local BigFont = class.create("BigFont", Element)
class.property(BigFont, "text", "BigFont")
class.property(BigFont, "fontSize", 1, {
    onChange = function(self, size)
        if size < 1 or size > 3 or size % 1 ~= 0 then
            error("Basalt bigfont: fontSize must be 1, 2 or 3", 3)
        end
    end,
})
class.property(BigFont, "width", function(self)
    local lines = self:getBigText()[1]
    return math.max(1, #(lines[1] or ""))
end)
class.property(BigFont, "height", function(self)
    return math.max(1, #self:getBigText()[1])
end)
function BigFont:getBigText()
    local fg = self.foreground
    local bg = self.background or colors.black
    local key = self.fontSize .. "\0" .. tostring(self.text)
        .. "\0" .. tostring(fg) .. "\0" .. tostring(bg)
    local cache = rawget(self, "_big")
    if cache and cache.key == key then return cache.data end
    generateFontSize(math.min(3, math.max(1, self.fontSize)), false)
    local data = makeText(self.fontSize, tostring(self.text), fg, bg)
    rawset(self, "_big", { key = key, data = data })
    return data
end
function BigFont:measure()
    local data = self:getBigText()
    return math.max(1, #(data[1][1] or "")), math.max(1, #data[1])
end
function BigFont:render(buf)
    local data = self:getBigText()
    for i = 1, #data[1] do
        buf:rawBlit(1, i, data[1][i], data[2][i], data[3][i])
    end
end
Container.register("BigFont", BigFont)
return { BigFont = BigFont }
]=]
sources["modules/charts"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local Container = require("core/container")
local palette = require("core/palette")
local charts = {}
local function clamp01(v)
    if v < 0 then return 0 end
    if v > 1 then return 1 end
    return v
end
local function ratioToRow(value, minV, maxV, height)
    local ratio = maxV > minV and clamp01((value - minV) / (maxV - minV)) or 0
    return height - math.floor(ratio * (height - 1) + 0.5)
end
local Graph = class.create("Graph", Element)
class.property(Graph, "minValue", 0)
class.property(Graph, "maxValue", 100)
class.property(Graph, "background", colors.black)
class.property(Graph, "width", 20)
class.property(Graph, "height", 8)
function Graph:setup()
    Element.setup(self)
    rawset(self, "_series", {})
end
function Graph:addSeries(name, opts)
    opts = opts or {}
    local series = rawget(self, "_series")
    series[#series + 1] = {
        name = name,
        symbol = (opts.symbol or " "):sub(1, 1),
        fg = opts.fg or colors.white,
        bg = opts.bg or colors.white,
        pointCount = opts.pointCount or self.width,
        visible = opts.visible ~= false,
        points = {},
    }
    self:markDirty()
    return self
end
function Graph:getSeries(name)
    for _, series in ipairs(rawget(self, "_series")) do
        if series.name == name then return series end
    end
    return nil
end
function Graph:removeSeries(name)
    local series = rawget(self, "_series")
    for i = 1, #series do
        if series[i].name == name then
            table.remove(series, i)
            break
        end
    end
    self:markDirty()
    return self
end
function Graph:setSeriesVisible(name, visible)
    local series = self:getSeries(name)
    if series then
        series.visible = visible ~= false
        self:markDirty()
    end
    return self
end
function Graph:addPoint(name, value)
    local series = self:getSeries(name)
    if not series then
        error("Basalt charts: unknown series '" .. tostring(name) .. "'", 2)
    end
    local points = series.points
    points[#points + 1] = value
    while #points > series.pointCount do
        table.remove(points, 1)
    end
    self:markDirty()
    return self
end
function Graph:clear(name)
    if name then
        local series = self:getSeries(name)
        if series then series.points = {} end
    else
        for _, series in ipairs(rawget(self, "_series")) do
            series.points = {}
        end
    end
    self:markDirty()
    return self
end
function Graph:render(buf)
    Element.render(self, buf)
    local w, h = self.width, self.height
    local minV, maxV = self.minValue, self.maxValue
    for _, series in ipairs(rawget(self, "_series")) do
        if series.visible then
            local points = series.points
            local count = math.max(series.pointCount, 2)
            for i = 1, #points do
                local col = 1 + math.floor((i - 1) / (count - 1) * (w - 1) + 0.5)
                local row = ratioToRow(points[i], minV, maxV, h)
                buf:blit(col, row, series.symbol, series.fg, series.bg)
            end
        end
    end
end
local BarChart = class.create("BarChart", Element)
class.property(BarChart, "data", false)
class.property(BarChart, "barColor", colors.lime)
class.property(BarChart, "minValue", 0)
class.property(BarChart, "maxValue", false)
class.property(BarChart, "background", colors.black)
class.property(BarChart, "width", 20)
class.property(BarChart, "height", 8)
function BarChart:setup()
    Element.setup(self)
    rawget(self, "_p").data = {}
end
function BarChart:render(buf)
    Element.render(self, buf)
    local data = self.data
    local count = #data
    if count == 0 then return end
    local w, h = self.width, self.height
    local maxV = self.maxValue
    if not maxV then
        maxV = -math.huge
        for i = 1, count do maxV = math.max(maxV, assert(data[i])) end
    end
    local minV = self.minValue
    local barWidth = math.max(1, math.floor((w - (count - 1)) / count))
    local x = 1
    for i = 1, count do
        if x > w then break end
        local top = ratioToRow(assert(data[i]), minV, maxV, h)
        buf:fill(x, top, math.min(barWidth, w - x + 1), h - top + 1,
            " ", self.foreground, self.barColor)
        x = x + barWidth + 1
    end
end
local LineChart = class.create("LineChart", Element)
class.property(LineChart, "data", false)
class.property(LineChart, "lineColor", colors.lime)
class.property(LineChart, "minValue", 0)
class.property(LineChart, "maxValue", 100)
class.property(LineChart, "background", colors.black)
class.property(LineChart, "width", 20)
class.property(LineChart, "height", 8)
function LineChart:setup()
    Element.setup(self)
    rawget(self, "_p").data = {}
end
function LineChart:render(buf)
    Element.render(self, buf)
    local data = self.data
    local count = #data
    if count == 0 then return end
    local w, h = self.width, self.height
    local minV, maxV = self.minValue, self.maxValue
    for col = 1, w do
        local t = count > 1 and ((col - 1) / (w - 1) * (count - 1) + 1) or 1
        local lower = math.floor(t)
        local upper = math.min(count, lower + 1)
        local lowerValue, upperValue = assert(data[lower]), assert(data[upper])
        local value = lowerValue + (upperValue - lowerValue) * (t - lower)
        local row = ratioToRow(value, minV, maxV, h)
        buf:fill(col, row, 1, 1, " ", self.foreground, self.lineColor)
    end
end
local function plotPixel(rows, pixelWidth, pixelHeight, x, y, index)
    if x < 1 or x > pixelWidth or y < 1 or y > pixelHeight then return end
    rows[y][x] = index
end
local function plotLine(rows, pixelWidth, pixelHeight, x0, y0, x1, y1, index)
    local dx, dy = math.abs(x1 - x0), -math.abs(y1 - y0)
    local sx = x0 < x1 and 1 or -1
    local sy = y0 < y1 and 1 or -1
    local err = dx + dy
    local x, y = x0, y0
    while true do
        plotPixel(rows, pixelWidth, pixelHeight, x, y, index)
        if x == x1 and y == y1 then break end
        local e2 = 2 * err
        if e2 >= dy then err, x = err + dy, x + sx end
        if e2 <= dx then err, y = err + dx, y + sy end
    end
end
local PixelGraph = class.create("PixelGraph", Element)
class.property(PixelGraph, "minValue", 0)
class.property(PixelGraph, "maxValue", 100)
class.property(PixelGraph, "background", colors.black)
class.property(PixelGraph, "width", 20)
class.property(PixelGraph, "height", 8)
function PixelGraph:setup()
    Element.setup(self)
    rawset(self, "_series", {})
end
function PixelGraph:addSeries(name, opts)
    opts = opts or {}
    local series = rawget(self, "_series")
    series[#series + 1] = {
        name = name,
        color = opts.color or colors.white,
        pointCount = opts.pointCount or self.width * 2,
        visible = opts.visible ~= false,
        points = {},
    }
    self:markDirty()
    return self
end
function PixelGraph:getSeries(name)
    for _, series in ipairs(rawget(self, "_series")) do
        if series.name == name then return series end
    end
    return nil
end
function PixelGraph:removeSeries(name)
    local series = rawget(self, "_series")
    for i = 1, #series do
        if series[i].name == name then
            table.remove(series, i)
            break
        end
    end
    self:markDirty()
    return self
end
function PixelGraph:setSeriesVisible(name, visible)
    local series = self:getSeries(name)
    if series then
        series.visible = visible ~= false
        self:markDirty()
    end
    return self
end
function PixelGraph:addPoint(name, value)
    local series = self:getSeries(name)
    if not series then
        error("Basalt charts: unknown series '" .. tostring(name) .. "'", 2)
    end
    local points = series.points
    points[#points + 1] = value
    while #points > series.pointCount do
        table.remove(points, 1)
    end
    self:markDirty()
    return self
end
function PixelGraph:clear(name)
    if name then
        local series = self:getSeries(name)
        if series then series.points = {} end
    else
        for _, series in ipairs(rawget(self, "_series")) do
            series.points = {}
        end
    end
    self:markDirty()
    return self
end
function PixelGraph:render(buf)
    Element.render(self, buf)
    local pixelWidth, pixelHeight = self.width * 2, self.height * 3
    local minV, maxV = self.minValue, self.maxValue
    local rows = {}
    for y = 1, pixelHeight do rows[y] = {} end
    local paletteBytes, indexOf, nextIndex, used = {}, {}, 1, false
    for _, series in ipairs(rawget(self, "_series")) do
        if series.visible and #series.points > 0 then
            local index = indexOf[series.color]
            if not index then
                index = nextIndex
                nextIndex = nextIndex + 1
                indexOf[series.color] = index
                paletteBytes[index] = palette.charOf[series.color]
            end
            local points = series.points
            local count = math.max(series.pointCount, 2)
            local prevCol, prevRow
            for i = 1, #points do
                local col = 1 + math.floor((i - 1) / (count - 1) * (pixelWidth - 1) + 0.5)
                local row = ratioToRow(points[i], minV, maxV, pixelHeight)
                if prevCol then
                    plotLine(rows, pixelWidth, pixelHeight, prevCol, prevRow, col, row, index)
                else
                    plotPixel(rows, pixelWidth, pixelHeight, col, row, index)
                end
                prevCol, prevRow = col, row
            end
            used = true
        end
    end
    if not used then return end
    local rowStrings = {}
    for y = 1, pixelHeight do
        local chars, row = {}, rows[y]
        for x = 1, pixelWidth do
            chars[x] = string.char(row[x] or 0)
        end
        rowStrings[y] = table.concat(chars)
    end
    buf:drawPixels(1, 1, pixelWidth, pixelHeight, rowStrings, paletteBytes)
end
Container.register("Graph", Graph)
Container.register("BarChart", BarChart)
Container.register("LineChart", LineChart)
Container.register("PixelGraph", PixelGraph)
charts.Graph = Graph
charts.BarChart = BarChart
charts.LineChart = LineChart
charts.PixelGraph = PixelGraph
return charts
]=]
sources["modules/debug"] = [=[

local require = ...
local basalt = require("main")
local dbg = {}
local HEIGHT = 8
local lines = {}
local MAX_LINES = 40
local overlay, header, rowLabels
local toggleKey = keys.f12
local function refresh()
    if not overlay or not overlay.visible then return end
    local rows = HEIGHT - 1
    local offset = math.max(0, #lines - rows)
    for i = 1, rows do
        rowLabels[i].text = lines[offset + i] or ""
    end
end
local function ensureOverlay()
    if overlay then return end
    local main = basalt.getMainFrame()
    overlay = main:addFrame({
        x = 1,
        y = "{parent.height - " .. (HEIGHT - 1) .. "}",
        width = "{parent.width}",
        height = HEIGHT,
        z = 1000,
        visible = false,
        background = colors.black,
        name = "basalt_debug_overlay",
    })
    header = overlay:addLabel({
        x = 2, y = 1,
        text = "Basalt Debug",
        foreground = colors.orange,
    })
    rowLabels = {}
    for i = 1, HEIGHT - 1 do
        rowLabels[i] = overlay:addLabel({
            x = 2, y = i + 1, text = "",
            foreground = colors.lime,
        })
    end
end
function dbg.log(...)
    local parts = {}
    for i = 1, select("#", ...) do
        parts[i] = tostring((select(i, ...)))
    end
    lines[#lines + 1] = table.concat(parts, " ")
    if #lines > MAX_LINES then
        table.remove(lines, 1)
    end
    refresh()
end
function dbg.show(state)
    ensureOverlay()
    if state == nil then state = not overlay.visible end
    overlay.visible = state
    refresh()
end
function dbg.setToggleKey(key)
    toggleKey = key
end
function dbg.getOverlay()
    ensureOverlay()
    return overlay
end
function dbg.clear()
    lines = {}
    refresh()
end
ensureOverlay()
basalt.schedule(function()
    while true do
        local _, key = os.pullEvent("key")
        if key == toggleKey then
            dbg.show()
        end
    end
end)
basalt.debug = dbg.log
return dbg
]=]
sources["modules/image"] = [=[

local require = ...
local class = require("core/class")
local Element = require("core/element")
local Container = require("core/container")
local palette = require("core/palette")
local flimg = require("flimg")
local image = {}
local function frameSize(frame)
    if frame and frame.format == "FLIMG" then
        if frame.mode == "pixel" then return math.ceil(frame.width / 2), math.ceil(frame.height / 3) end
        return frame.width, frame.height
    end
    if not frame or not frame[1] then return 0, 0 end
    return #frame[1][1], #frame
end
local function frameCount(source)
    return source and source.format == "FLIMG" and #source.frames or (source and #source or 0)
end
local function prepareFlimg(source)
    if source._basaltPalette then return source end
    local bytes = {}
    for i = 1, #source.palette do
        local handle = palette.rgb(source.palette[i])
        bytes[i] = palette.charOf[handle]
    end
    source._basaltPalette = bytes
    source._composedFrames = source._composedFrames or {}
    return source
end
local Image = class.create("Image", Element)
class.property(Image, "bimg", false, {
    onChange = function(self, bimg)
        rawget(self, "_p").currentFrame = 1
        rawset(self, "_frameDirection", 1)
        if self.autoSize and bimg and (bimg[1] or bimg.format == "FLIMG") then
            local w, h = frameSize(bimg.format == "FLIMG" and bimg or bimg[1])
            local p = rawget(self, "_p")
            p.width, p.height = math.max(1, w), math.max(1, h)
        end
    end,
})
class.property(Image, "currentFrame", 1)
class.property(Image, "autoSize", true)
class.property(Image, "width", 8)
class.property(Image, "height", 4)
function Image:getFrameCount()
    return frameCount(self.bimg)
end
local function advanceFrame(self)
    local count = self:getFrameCount()
    if count <= 0 then return false end
    local source, current = self.bimg, self.currentFrame
    if source.format == "FLIMG" and source.pingPong and count > 1 then
        local direction = rawget(self, "_frameDirection") or 1
        if direction > 0 and current >= count then
            direction = -1
        elseif direction < 0 and current <= 1 then
            if source.loop == false then return false end
            direction = 1
        end
        rawset(self, "_frameDirection", direction)
        self.currentFrame = current + direction
        return true
    end
    if current < count then self.currentFrame = current + 1
    elseif source.format == "FLIMG" and source.loop == false then return false
    else self.currentFrame = 1 end
    return true
end
function Image:nextFrame()
    advanceFrame(self)
    return self
end
function Image:play(fps)
    local bimg = self.bimg
    if not bimg or frameCount(bimg) < 2 then return self end
    local token = (rawget(self, "_playToken") or 0) + 1
    rawset(self, "_playToken", token)
    local basalt = require("main")
    basalt.schedule(function()
        while rawget(self, "_playToken") == token do
            local delay
            if fps then delay = 1 / fps
            elseif bimg.format == "FLIMG" then
                local frame = bimg.frames[self.currentFrame]
                delay = (frame and frame.duration or 200) / 1000
            else delay = bimg.secondsPerFrame or 0.2 end
            sleep(delay)
            if rawget(self, "_playToken") == token then
                if not advanceFrame(self) then
                    rawset(self, "_playToken", token + 1)
                    break
                end
            end
        end
    end)
    return self
end
function Image:stop()
    rawset(self, "_playToken", (rawget(self, "_playToken") or 0) + 1)
    return self
end
function Image:measure()
    local source = self.bimg
    local w, h = frameSize(source and source.format == "FLIMG" and source or source and source[1])
    return math.max(1, w), math.max(1, h)
end
function Image:render(buf)
    Element.render(self, buf)
    local bimg = self.bimg
    if not bimg then return end
    if bimg.format == "FLIMG" then
        prepareFlimg(bimg)
        local frameIndex = math.max(1, math.min(#bimg.frames, self.currentFrame))
        local rows = bimg._composedFrames[frameIndex]
        if not rows then
            rows = flimg.compose(bimg, frameIndex)
            bimg._composedFrames[frameIndex] = rows
        end
        if bimg.mode == "pixel" then
            buf:drawPixels(1, 1, bimg.width, bimg.height, rows, bimg._basaltPalette)
        else
            for y = 1, math.min(#rows, self.height) do
                local line = rows[y]
                local fg, bg = {}, {}
                for x = 1, #line[1] do
                    local fi, bi = line[2]:byte(x), line[3]:byte(x)
                    fg[x] = fi == 0 and "\0" or bimg._basaltPalette[fi]
                    bg[x] = bi == 0 and "\0" or bimg._basaltPalette[bi]
                end
                buf:maskedBlit(1, y, line[1], table.concat(fg), table.concat(bg),
                    line[1], line[2], line[3])
            end
        end
        return
    end
    local frame = bimg[math.max(1, math.min(#bimg, self.currentFrame))]
    if not frame then return end
    for y = 1, math.min(#frame, self.height) do
        local line = frame[y]
        buf:drawBlit(1, y, line[1], line[2], line[3])
    end
end
function image.load(path)
    local handle = fs.open(path, "rb") or fs.open(path, "r")
    if not handle then
        error("Basalt image: cannot open " .. tostring(path), 2)
    end
    local content = handle.readAll()
    handle.close()
    if content:sub(1, 4) == flimg.MAGIC then
        return prepareFlimg(flimg.decode(content))
    end
    local bimg = textutils.unserialize(content)
    if type(bimg) ~= "table" then
        error("Basalt image: " .. path .. " is not a valid bimg file", 2)
    end
    return bimg
end
function image.saveFlimg(path, source, options)
    return flimg.save(path, source, options)
end
Container.register("Image", Image)
image.Image = Image
image.flimg = flimg
return image
]=]
sources["modules/responsive"] = [=[

local require = ...
local Element = require("core/element")
local responsive = {}
local ResponsiveBuilder = {}
ResponsiveBuilder.__index = ResponsiveBuilder
local OPERATORS = { "<=", ">=", "==", "~=", "<", ">" }
local function trim(value)
    return value:match("^%s*(.-)%s*$")
end
local function readOperand(expression, element)
    local number = tonumber(expression)
    if number ~= nil then return number end
    local scope, property = expression:match("^([%a_][%w_]*)%.([%a_][%w_]*)$")
    if scope ~= "self" and scope ~= "parent" then
        error("Basalt responsive: unsupported operand '" .. expression .. "'", 3)
    end
    if property ~= "width" and property ~= "height" then
        error("Basalt responsive: only width and height can be read", 3)
    end
    local target = scope == "self" and element or rawget(element, "parent")
    return target and target[property] or nil
end
local function compare(left, operator, right)
    if left == nil or right == nil then return false end
    if operator == "<" then return left < right end
    if operator == ">" then return left > right end
    if operator == "<=" then return left <= right end
    if operator == ">=" then return left >= right end
    if operator == "==" then return left == right end
    return left ~= right
end
local function compileCondition(expression)
    if type(expression) == "function" then return expression end
    if type(expression) ~= "string" or trim(expression) == "" then
        error("Basalt responsive: condition must be a non-empty string or function", 3)
    end
    expression = trim(expression)
    local left, operator, right
    for i = 1, #OPERATORS do
        local candidate = OPERATORS[i]
        local start = expression:find(candidate, 1, true)
        if start then
            left = trim(expression:sub(1, start - 1))
            operator = candidate
            right = trim(expression:sub(start + #candidate))
            break
        end
    end
    if not operator or left == "" or right == "" then
        error("Basalt responsive: expected '<operand> <operator> <operand>'", 3)
    end
    local function validateOperand(operand)
        if tonumber(operand) ~= nil then return end
        local scope, property = operand:match("^([%a_][%w_]*)%.([%a_][%w_]*)$")
        if (scope ~= "self" and scope ~= "parent")
            or (property ~= "width" and property ~= "height") then
            error("Basalt responsive: unsupported operand '" .. operand .. "'", 4)
        end
    end
    validateOperand(left)
    validateOperand(right)
    return function(element)
        return compare(readOperand(left, element), operator,
            readOperand(right, element))
    end
end
local function matches(rule, element, width, height)
    if rule.minWidth and width < rule.minWidth then return false end
    if rule.maxWidth and width > rule.maxWidth then return false end
    if rule.minHeight and height < rule.minHeight then return false end
    if rule.maxHeight and height > rule.maxHeight then return false end
    if rule.when and not rule.when(element, width, height) then return false end
    return true
end
function responsive.apply(element, rules, options)
    if type(rules) ~= "table" then
        error("Basalt responsive: rules must be a table", 2)
    end
    if not element.getChildren then
        error("Basalt responsive: target must be a container", 2)
    end
    local old = rawget(element, "_responsiveController")
    if old then old:destroy() end
    local prepared, names = {}, {}
    for i = 1, #rules do
        local rule = rules[i]
        if type(rule) ~= "table" then
            error("Basalt responsive: rule " .. i .. " must be a table", 2)
        end
        if rule.when ~= nil and type(rule.when) ~= "function" then
            error("Basalt responsive: rule.when must be a function", 2)
        end
        if rule.props ~= nil and type(rule.props) ~= "table" then
            error("Basalt responsive: rule.props must be a table", 2)
        end
        if rule.name then
            if type(rule.name) ~= "string" or rule.name == "" then
                error("Basalt responsive: rule.name must be a non-empty string", 2)
            end
            if names[rule.name] then
                error("Basalt responsive: duplicate state name '" .. rule.name .. "'", 2)
            end
            names[rule.name] = true
        end
        local internalState = "__responsive_" .. i
        element:setStateStyle(internalState, rule.props or {}, -1000 + i)
        prepared[i] = {
            rule = rule,
            internalState = internalState,
            active = false,
        }
    end
    local controller = {
        element = element,
        rules = prepared,
        exclusive = options and options.exclusive == true,
    }
    function controller:refresh()
        local el = self.element
        local width, height = el.width, el.height
        local matched = false
        for i = 1, #self.rules do
            local entry = self.rules[i]
            local active = (not self.exclusive or not matched)
                and matches(entry.rule, el, width, height)
            if active then matched = true end
            entry.active = active
            el:setState(entry.internalState, active)
            if entry.rule.name then el:setState(entry.rule.name, active) end
        end
        return self
    end
    function controller:destroy()
        local el = self.element
        if not el then return end
        if self.handler then el:off("layout", self.handler) end
        for i = 1, #self.rules do
            local entry = self.rules[i]
            el:setState(entry.internalState, false)
            if entry.rule.name then el:setState(entry.rule.name, false) end
        end
        if rawget(el, "_responsiveController") == self then
            rawset(el, "_responsiveController", nil)
        end
        self.element = nil
    end
    controller.handler = function() controller:refresh() end
    element:on("layout", controller.handler)
    rawset(element, "_responsiveController", controller)
    controller:refresh()
    return controller
end
function ResponsiveBuilder:_sync()
    responsive.apply(self.element, self.rules, { exclusive = true })
    return self
end
function ResponsiveBuilder:when(condition)
    if self.finished then
        error("Basalt responsive: otherwise() must be the final rule", 2)
    end
    if self.pending then
        error("Basalt responsive: call apply() before the next when()", 2)
    end
    self.pending = { when = compileCondition(condition) }
    return self
end
function ResponsiveBuilder:apply(props)
    if not self.pending then
        error("Basalt responsive: apply() requires a preceding when()", 2)
    end
    if type(props) ~= "table" then
        error("Basalt responsive: apply() expects a property table", 2)
    end
    self.pending.props = props
    self.rules[#self.rules + 1] = self.pending
    self.pending = nil
    return self:_sync()
end
function ResponsiveBuilder:otherwise(props)
    if self.pending then
        error("Basalt responsive: call apply() before otherwise()", 2)
    end
    if self.finished then
        error("Basalt responsive: otherwise() can only be used once", 2)
    end
    if type(props) ~= "table" then
        error("Basalt responsive: otherwise() expects a property table", 2)
    end
    self.rules[#self.rules + 1] = { props = props }
    self.finished = true
    self:_sync()
    return self.element
end
function ResponsiveBuilder:done()
    if self.pending then
        error("Basalt responsive: call apply() before done()", 2)
    end
    self:_sync()
    return self.element
end
function responsive.builder(element)
    if not element.getChildren then
        error("Basalt responsive: target must be a container", 2)
    end
    return setmetatable({ element = element, rules = {} }, ResponsiveBuilder)
end
function responsive.get(element)
    return rawget(element, "_responsiveController")
end
function Element:setResponsive(rules)
    responsive.apply(self, rules)
    return self
end
function Element:responsive()
    return responsive.builder(self)
end
function Element:clearResponsive()
    local controller = rawget(self, "_responsiveController")
    if controller then controller:destroy() end
    return self
end
return responsive
]=]
sources["modules/theme"] = [=[

local require = ...
local palette = require("core/palette")
local theme = {}
local function validateStateStyle(cls, typeName, stateName, style)
    if type(style) ~= "table" then
        error("Basalt theme: state '" .. stateName .. "' for "
            .. typeName .. " must be a table", 3)
    end
    for propName, value in pairs(style) do
        local prop = cls.__props[propName]
        if not prop then
            error("Basalt theme: unknown property '" .. propName
                .. "' for " .. typeName .. " state " .. stateName, 3)
        end
        if not prop.styleable then
            error("Basalt theme: property '" .. propName
                .. "' cannot be state-styled", 3)
        end
        if type(value) == "string" and value:sub(1, 1) == "{" then
            error("Basalt theme: reactive strings are not allowed in set() "
                .. "state styles; use a function instead", 3)
        end
    end
end
theme.classes = {
    Element = require("core/element"),
    Container = require("core/container"),
    BaseFrame = require("core/baseframe"),
    Label = require("elements/Label"),
    Button = require("elements/Button"),
    Frame = require("elements/Frame"),
    Input = require("elements/Input"),
    Checkbox = require("elements/Checkbox"),
    Switch = require("elements/Switch"),
    ProgressBar = require("elements/ProgressBar"),
    Slider = require("elements/Slider"),
    Collection = require("elements/Collection"),
    List = require("elements/List"),
    Dropdown = require("elements/Dropdown"),
    Flex = require("elements/Flex"),
    Row = require("elements/Row"),
    Column = require("elements/Column"),
    TextBox = require("elements/TextBox"),
    Menu = require("elements/Menu"),
    TabControl = require("elements/TabControl"),
    Tree = require("elements/Tree"),
    Table = require("elements/Table"),
    Program = require("elements/Program"),
    ComboBox = require("elements/ComboBox"),
    ContextMenu = require("elements/ContextMenu"),
    Dialog = require("elements/Dialog"),
    Toast = require("elements/Toast"),
}
function theme.set(themeTable)
    for typeName, props in pairs(themeTable) do
        local cls = theme.classes[typeName]
        if not cls then
            error("Basalt theme: unknown element type '" .. typeName .. "'", 2)
        end
        for k, v in pairs(props) do
            if k == "states" then
                if type(v) ~= "table" then
                    error("Basalt theme: states for " .. typeName
                        .. " must be a table", 2)
                end
                for stateName, style in pairs(v) do
                    validateStateStyle(cls, typeName, stateName, style)
                    cls.__stateStyles[stateName] = style
                end
            elseif cls.__props[k] == nil then
                error("Basalt theme: unknown property '" .. k
                    .. "' for " .. typeName, 2)
            elseif type(v) == "string" and v:sub(1, 1) == "{" then
                error("Basalt theme: reactive strings are not allowed in "
                    .. "set() (defaults are shared); use a function instead", 2)
            else
                cls.__defaults[k] = v
            end
        end
    end
end
local c = {
    bg = palette.rgb("#14161B"),
    surface = palette.rgb("#22262E"),
    raised = palette.rgb("#2E333D"),
    border = palette.rgb("#3D434F"),
    text = palette.rgb("#E8E6E1"),
    muted = palette.rgb("#9AA0AB"),
    lava = palette.rgb("#E8703A"),
    ember = palette.rgb("#F49058"),
    selection = palette.rgb("#3E5F82"),
    success = palette.rgb("#8FBB56"),
    warning = palette.rgb("#E5B95C"),
    danger = palette.rgb("#D9534F"),
    info = palette.rgb("#5E9BD6"),
}
theme.presets = {
    basalt = {
        colors = c,
        styles = {
            Element = { foreground = c.text },
            BaseFrame = { background = c.bg },
            Frame = { background = c.surface },
            Button = {
                background = c.raised,
                states = { hover = { background = c.border } },
            },
            Input = {
                background = c.raised,
                foreground = c.text,
                placeholderColor = c.muted,
            },
            Switch = {
                onColor = c.success,
                offColor = c.border,
                knobColor = c.text,
            },
            ProgressBar = { background = c.border, barColor = c.lava },
            Slider = { barColor = c.border, knobColor = c.lava },
            List = {
                background = c.surface,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                emptyTextColor = c.muted,
                scrollbarColor = c.raised,
                scrollbarThumbColor = c.border,
            },
            Dropdown = {
                background = c.raised,
                dropBackground = c.surface,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                scrollbarColor = c.raised,
                scrollbarThumbColor = c.border,
            },
            ComboBox = {
                background = c.raised,
                foreground = c.text,
                placeholderColor = c.muted,
                dropBackground = c.surface,
                dropForeground = c.text,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                scrollbarColor = c.raised,
                scrollbarThumbColor = c.border,
            },
            Menu = {
                background = c.surface,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                separatorColor = c.muted,
                dropBackground = c.raised,
            },
            TabControl = {
                background = c.bg,
                headerBackground = c.surface,
                activeBackground = c.lava,
                activeForeground = c.bg,
            },
            Tree = {
                background = c.surface,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                scrollbarColor = c.raised,
                scrollbarThumbColor = c.border,
            },
            Table = {
                background = c.surface,
                headerBackground = c.raised,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                scrollbarColor = c.raised,
                scrollbarThumbColor = c.border,
            },
            TextBox = {
                background = c.surface,
                selectionBackground = c.selection,
                selectionForeground = c.text,
                scrollbarColor = c.raised,
                scrollbarThumbColor = c.border,
            },
            ContextMenu = {
                background = c.raised,
                selectionBackground = c.lava,
                selectionForeground = c.bg,
                separatorColor = c.muted,
            },
            Dialog = {
                boxBackground = c.surface,
                boxForeground = c.text,
                titleBackground = c.lava,
                titleForeground = c.bg,
            },
            Program = { background = c.bg },
        },
    },
}
function theme.applyPreset(presetOrName)
    local preset = type(presetOrName) == "table"
        and presetOrName or theme.presets[presetOrName]
    if not preset then
        error("Basalt theme: unknown preset '"
            .. tostring(presetOrName) .. "'", 2)
    end
    theme.set(preset.styles)
    return preset.colors
end
local function resolveColor(value, tokens)
    if type(value) ~= "string" then return value end
    if value:sub(1, 1) == "$" then
        local token = tokens[value:sub(2)]
        if token == nil then
            error("Basalt theme: unknown color token '" .. value .. "'", 0)
        end
        return token
    end
    if value:sub(1, 1) == "#" then
        return palette.rgb(value)
    end
    if type(colors[value]) == "number" then
        return colors[value]
    end
    return value
end
function theme.load(path)
    local handle = fs.open(path, "r")
    if not handle then
        error("Basalt theme: cannot open " .. tostring(path), 2)
    end
    local content = handle.readAll()
    handle.close()
    local data
    if path:match("%.json$") then
        local parse = textutils.unserialiseJSON or textutils.unserializeJSON
        data = parse(content)
    else
        data = textutils.unserialize(content)
    end
    if type(data) ~= "table" then
        error("Basalt theme: " .. path .. " is not a valid theme file", 2)
    end
    local tokens = {}
    local rawColors = data.colors or {}
    for key, value in pairs(rawColors) do
        if not (type(value) == "string" and value:sub(1, 1) == "$") then
            tokens[key] = resolveColor(value, tokens)
        end
    end
    for key, value in pairs(rawColors) do
        if type(value) == "string" and value:sub(1, 1) == "$" then
            tokens[key] = resolveColor(value, tokens)
        end
    end
    local styles = {}
    for typeName, props in pairs(data.styles or {}) do
        local resolved = {}
        for key, value in pairs(props) do
            if key == "states" then
                local states = {}
                for stateName, style in pairs(value) do
                    local stateStyle = {}
                    for propName, propValue in pairs(style) do
                        stateStyle[propName] = resolveColor(propValue, tokens)
                    end
                    states[stateName] = stateStyle
                end
                resolved.states = states
            else
                resolved[key] = resolveColor(value, tokens)
            end
        end
        styles[typeName] = resolved
    end
    local name = data.name or fs.getName(path):gsub("%.%w+$", "")
    local preset = { colors = tokens, styles = styles }
    theme.presets[name] = preset
    return name, preset
end
function theme.apply(root, themeTable)
    local props = themeTable[root.__name]
    if props then
        for k, v in pairs(props) do
            if k == "states" then
                for stateName, style in pairs(v) do
                    root:setStateStyle(stateName, style)
                end
            else
                root[k] = v
            end
        end
    end
    if root.getChildren then
        local ch = root:getChildren()
        for i = 1, #ch do
            theme.apply(ch[i], themeTable)
        end
    end
end
return theme
]=]
sources["modules/xml"] = [==[

local require = ...
local palette = require("core/palette")
local xml = {}
local function trim(s)
    return s:match("^%s*(.-)%s*$")
end
function xml.parse(src)
    local root = { tag = nil, children = {} }
    local stack = { root }
    local pos = 1
    while true do
        local lt = src:find("<", pos, true)
        if not lt then break end
        local text = trim(src:sub(pos, lt - 1))
        if #text > 0 then
            local top = stack[#stack]
            top.text = top.text and (top.text .. " " .. text) or text
        end
        if src:sub(lt + 1, lt + 3) == "!--" then
            local close = src:find("-->", lt + 4, true)
            if not close then error("Basalt XML: unclosed comment", 2) end
            pos = close + 3
        elseif src:sub(lt + 1, lt + 1) == "/" then
            local gt = src:find(">", lt, true)
            if not gt then error("Basalt XML: malformed closing tag", 2) end
            local tagName = trim(src:sub(lt + 2, gt - 1))
            local top = stack[#stack]
            if top.tag ~= tagName then
                error("Basalt XML: unexpected </" .. tagName .. ">"
                    .. (top.tag and (", open tag is <" .. top.tag .. ">") or ""), 2)
            end
            stack[#stack] = nil
            pos = gt + 1
        else
            local gt = src:find(">", lt, true)
            if not gt then error("Basalt XML: unclosed tag", 2) end
            local inner = src:sub(lt + 1, gt - 1)
            local selfClosing = inner:sub(-1) == "/"
            if selfClosing then inner = inner:sub(1, -2) end
            local tagName = inner:match("^([%w_]+)")
            if not tagName then error("Basalt XML: malformed tag near pos " .. lt, 2) end
            local node = { tag = tagName, attrs = {}, children = {} }
            for k, _, v in inner:gmatch([=[([%w_]+)%s*=%s*(["'])(.-)%2]=]) do
                node.attrs[k] = v
            end
            local top = stack[#stack]
            top.children[#top.children + 1] = node
            if not selfClosing then
                stack[#stack + 1] = node
            end
            pos = gt + 1
        end
    end
    if #stack ~= 1 then
        error("Basalt XML: unclosed <" .. stack[#stack].tag .. ">", 2)
    end
    return root.children
end
local function convert(v)
    local n = tonumber(v)
    if n then return n end
    if v == "true" then return true end
    if v == "false" then return false end
    if v:sub(1, 1) == "#" then return palette.rgb(v) end
    return v
end
local function build(parent, nodes, scope)
    local created = {}
    for _, node in ipairs(nodes) do
        local addName = "add" .. node.tag:sub(1, 1):upper() .. node.tag:sub(2)
        local add = parent[addName]
        if not add then
            error("Basalt XML: unknown element <" .. node.tag .. ">", 2)
        end
        local el = add(parent)
        for k, v in pairs(node.attrs) do
            if k:find("^on%u") then
                local fn = scope and scope[v]
                if type(fn) ~= "function" then
                    error("Basalt XML: scope has no handler '" .. v
                        .. "' for " .. k .. " on <" .. node.tag .. ">", 2)
                end
                el[k](el, fn)
            else
                el[k] = convert(v)
            end
        end
        if node.text and el.text ~= nil and node.attrs.text == nil then
            el.text = node.text
        end
        if #node.children > 0 then
            build(el, node.children, scope)
        end
        created[#created + 1] = el
    end
    return created
end
function xml.load(parent, src, scope)
    return build(parent, xml.parse(src), scope)
end
function xml.loadFile(parent, path, scope)
    local h = fs.open(path, "r")
    if not h then error("Basalt XML: cannot open " .. path, 2) end
    local src = h.readAll()
    h.close()
    return xml.load(parent, src, scope)
end
return xml
]==]
local loaded = {}
local function loader(name)
    local cached = loaded[name]
    if cached ~= nil then return cached end

    local source = sources[name]
        or error("Basalt: module not bundled: " .. tostring(name), 0)
    local chunk = assert(load(source, "@basalt/" .. name .. ".lua"))
    local result = chunk(loader, "basalt")
    loaded[name] = result == nil and true or result
    return loaded[name]
end
return loader("main")
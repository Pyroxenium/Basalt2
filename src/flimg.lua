-- FLIMG v1 binary image codec.
--
-- The on-disk format uses palette-indexed byte planes, independently encoded
-- frame patches, and periodic keyframes. It deliberately avoids textutils and
-- string.pack so the same module works on Lua 5.1/CraftOS-PC and CC:Tweaked.

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

--- Validates and canonicalizes an in-memory FLIMG image.
function flimg.normalize(source)
    return normalizeImage(source)
end

--- PackBits encoder. Repeated runs of at least three bytes are compressed.
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

--- Encodes an image into the FLIMG v1 binary representation.
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

--- Decodes a FLIMG v1 binary string into the canonical in-memory model.
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

--- Composes one canonical frame into canvas-sized palette-index rows.
-- For cell images each result row is {text, foreground, background}.
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

--- Converts a legacy BIMG table to a cell-mode FLIMG image.
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

--- Converts an Obsidian/OSF sprite table to a cell-mode FLIMG image.
-- Numeric power-of-two colors are interpreted as colors.* constants. Other
-- numeric values and #RRGGBB strings are stored as RGB colors.
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

-- Image module: registers the Image element (BIMG and FLIMG formats).
--
--   local image = basalt.use("image")
--   local img = frame:addImage({ x = 2, y = 2 })
--   img.bimg = image.load("logo.bimg")
--   img:play()          -- animate multi-frame images
--
-- A bimg is a list of frames; every frame is a list of {text, fgHex, bgHex}
-- blit triples. FLIMG stores RGB palette indices and either terminal cells or
-- unbaked 2x3 pixels. Both render through the retained Render buffer.

local require, basaltDir = ...
local class = require("core/class")
local Element = require("core/element")
local Container = require("core/container")
local palette = require("core/palette")

local codecPath = fs.combine(fs.getDir(basaltDir), "flimg.lua")
local codecChunk, codecError = loadfile(codecPath)
if not codecChunk then error("Basalt image: cannot load FLIMG codec: " .. tostring(codecError), 0) end
local flimg = codecChunk()

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

---@class Image : Element
local Image = class.create("Image", Element)

--- The bimg image table (list of blit-line frames)
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
--- 1-based frame index of multi-frame images
class.property(Image, "currentFrame", 1)
--- Resize the element to the image size on assignment
class.property(Image, "autoSize", true)
--- Width in terminal cells
class.property(Image, "width", 8)
--- Height in terminal cells
class.property(Image, "height", 4)

--- Returns the number of frames in the current bimg.
---@return integer count
function Image:getFrameCount()
    return frameCount(self.bimg)
end

--- Advances to the next frame, wrapping at the end.
---@return self
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

--- Plays multi-frame images through the scheduler. fps defaults to the
--- bimg's secondsPerFrame metadata (or 5 fps).
---@param fps number|nil Playback frames per second
---@return self
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

--- Stops scheduled image playback.
---@return self
function Image:stop()
    rawset(self, "_playToken", (rawget(self, "_playToken") or 0) + 1)
    return self
end

--- Intrinsic size for basalt.auto().
---@return number width The measured width
---@return number height The measured height
function Image:measure()
    local source = self.bimg
    local w, h = frameSize(source and source.format == "FLIMG" and source or source and source[1])
    return math.max(1, w), math.max(1, h)
end

--- Renders the element into the buffer.
---@param buf Render The render buffer (local coordinates, pre-clipped)
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

--- Loads a BIMG serialized table or FLIMG binary file.
---@param path string File path
---@return table bimg
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

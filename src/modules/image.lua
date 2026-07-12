-- Image module: registers the Image element (bimg format).
--
--   local image = basalt.use("image")
--   local img = frame:addImage({ x = 2, y = 2 })
--   img.bimg = image.load("logo.bimg")
--   img:play()          -- animate multi-frame images
--
-- A bimg is a list of frames; every frame is a list of {text, fgHex, bgHex}
-- blit triples. Rendering goes through Render:drawBlit.

local require = ...
local class = require("core/class")
local Element = require("core/element")
local Container = require("core/container")

local image = {}

local function frameSize(frame)
    if not frame or not frame[1] then return 0, 0 end
    return #frame[1][1], #frame
end

local Image = class.create("Image", Element)

class.property(Image, "bimg", false, {
    onChange = function(self, bimg)
        rawget(self, "_p").currentFrame = 1
        if self.autoSize and bimg and bimg[1] then
            local w, h = frameSize(bimg[1])
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
    local bimg = self.bimg
    return bimg and #bimg or 0
end

function Image:nextFrame()
    local count = self:getFrameCount()
    if count > 0 then
        self.currentFrame = self.currentFrame % count + 1
    end
    return self
end

--- Plays multi-frame images through the scheduler. fps defaults to the
--- bimg's secondsPerFrame metadata (or 5 fps).
function Image:play(fps)
    local bimg = self.bimg
    if not bimg or #bimg < 2 then return self end
    local delay = fps and (1 / fps) or bimg.secondsPerFrame or 0.2
    local token = (rawget(self, "_playToken") or 0) + 1
    rawset(self, "_playToken", token)

    local basalt = require("main")
    basalt.schedule(function()
        while rawget(self, "_playToken") == token do
            sleep(delay)
            if rawget(self, "_playToken") == token then
                self:nextFrame()
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
    local w, h = frameSize(self.bimg and self.bimg[1])
    return math.max(1, w), math.max(1, h)
end

function Image:render(buf)
    Element.render(self, buf)
    local bimg = self.bimg
    if not bimg then return end
    local frame = bimg[math.max(1, math.min(#bimg, self.currentFrame))]
    if not frame then return end
    for y = 1, math.min(#frame, self.height) do
        local line = frame[y]
        buf:drawBlit(1, y, line[1], line[2], line[3])
    end
end

--- Loads a bimg file (serialized table).
function image.load(path)
    local handle = fs.open(path, "r")
    if not handle then
        error("Basalt 2.5 image: cannot open " .. tostring(path), 2)
    end
    local content = handle.readAll()
    handle.close()
    local bimg = textutils.unserialize(content)
    if type(bimg) ~= "table" then
        error("Basalt 2.5 image: " .. path .. " is not a valid bimg file", 2)
    end
    return bimg
end

Container.register("Image", Image)
image.Image = Image

return image

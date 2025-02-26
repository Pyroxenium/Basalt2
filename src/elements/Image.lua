local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local tHex = require("libraries/colorHex")
---@configDescription An element that displays an image in bimg format
---@configDefault false

--- This is the Image element class which can be used to display bimg format images.
--- The bimg format is a universal ComputerCraft image format.
--- See: https://github.com/SkyTheCodeMaster/bimg
---@class Image : VisualElement
local Image = setmetatable({}, VisualElement)
Image.__index = Image

---@property bimg table {} The bimg image data
Image.defineProperty(Image, "bimg", {default = {{}}, type = "table", canTriggerRender = true})
---@property currentFrame number 1 Current animation frame
Image.defineProperty(Image, "currentFrame", {default = 1, type = "number", canTriggerRender = true})
---@property metadata table {} Image metadata (version, palette, etc)
Image.defineProperty(Image, "metadata", {default = {}, type = "table"})
---@property autoResize boolean false Whether to automatically resize the image when content exceeds bounds
Image.defineProperty(Image, "autoResize", {default = true, type = "boolean"})
---@property offsetX number 0 Horizontal offset for viewing larger images
Image.defineProperty(Image, "offsetX", {default = 0, type = "number", canTriggerRender = true})
---@property offsetY number 0 Vertical offset for viewing larger images
Image.defineProperty(Image, "offsetY", {default = 0, type = "number", canTriggerRender = true})

--- Creates a new Image instance
--- @shortDescription Creates a new Image instance
--- @return Image self The newly created Image instance
--- @private
function Image.new()
    local self = setmetatable({}, Image):__init()
    self.set("width", 12)
    self.set("height", 6)
    self.set("background", colors.black)
    self.set("z", 5)
    return self
end

--- @shortDescription Initializes the Image instance
--- @param props table The properties to initialize the element with
--- @param basalt table The basalt instance
--- @return Image self The initialized instance
--- @protected
function Image:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Image")
    return self
end

--- Loads a bimg format image
--- @shortDescription Loads a bimg format image
--- @param bimgData table The bimg image data
--- @return Image self The Image instance
function Image:loadBimg(bimgData)
    if type(bimgData) ~= "table" then return self end

    local frames = {}
    local metadata = {}

    for k, v in pairs(bimgData) do
        if type(k) == "number" then
            frames[k] = v
        else
            metadata[k] = v
        end
    end

    self.set("bimg", frames)
    self.set("metadata", metadata)

    if frames[1] and frames[1][1] then
        self.set("width", #frames[1][1][2])
        self.set("height", #frames[1])
    end

    return self
end

function Image:resizeImage(width, height)
    local frames = self.get("bimg")

    for frameIndex, frame in ipairs(frames) do
        local newFrame = {}
        for y = 1, height do
            local text = string.rep(" ", width)
            local fg = string.rep("f", width)
            local bg = string.rep("0", width)

            if frame[y] and frame[y][1] then
                local oldText = frame[y][1]
                local oldFg = frame[y][2]
                local oldBg = frame[y][3]

                text = (oldText .. string.rep(" ", width)):sub(1, width)
                fg = (oldFg .. string.rep("f", width)):sub(1, width)
                bg = (oldBg .. string.rep("0", width)):sub(1, width)
            end

            newFrame[y] = {text, fg, bg}
        end
        frames[frameIndex] = newFrame
    end

    self:updateRender()
    return self
end

function Image:getImageSize()
    local bimg = self.get("bimg")
    if not bimg[1] or not bimg[1][1] then return 0, 0 end
    return #bimg[1][1][1], #bimg[1]
end

--- Gets pixel information at position
--- @shortDescription Gets pixel information at position
--- @param x number X position
--- @param y number Y position
--- @return number? fg Foreground color
--- @return number? bg Background color
--- @return string? char Character at position
function Image:getPixelData(x, y)
    local frame = self.get("bimg")[self.get("currentFrame")]
    if not frame or not frame[y] then return end

    local text = frame[y][1]
    local fg = frame[y][2]
    local bg = frame[y][3]

    if not text or not fg or not bg then return end

    local fgColor = tonumber(fg:sub(x,x), 16)
    local bgColor = tonumber(bg:sub(x,x), 16)
    local char = text:sub(x,x)

    return fgColor, bgColor, char
end

local function ensureFrame(self, y)
    local frame = self.get("bimg")[self.get("currentFrame")]
    if not frame then
        frame = {}
        self.get("bimg")[self.get("currentFrame")] = frame
    end
    if not frame[y] then
        frame[y] = {"", "", ""}
    end
    return frame
end

function Image:setText(x, y, text)
    if type(text) ~= "string" or #text < 1 then return self end
    local frame = ensureFrame(self, y)
    
    local currentLine = frame[y][1]
    while #currentLine < x + #text - 1 do
        currentLine = currentLine .. " "
    end
    
    frame[y][1] = currentLine:sub(1, x-1) .. text .. currentLine:sub(x + #text)
    self:updateRender()
    return self
end

function Image:setFg(x, y, pattern)
    if type(pattern) ~= "string" or #pattern < 1 then return self end
    local frame = ensureFrame(self, y)
    
    local currentFg = frame[y][2]
    while #currentFg < x + #pattern - 1 do
        currentFg = currentFg .. "f"
    end
    
    frame[y][2] = currentFg:sub(1, x-1) .. pattern .. currentFg:sub(x + #pattern)
    self:updateRender()
    return self
end

function Image:setBg(x, y, pattern)
    if type(pattern) ~= "string" or #pattern < 1 then return self end
    local frame = ensureFrame(self, y)
    
    local currentBg = frame[y][3]
    while #currentBg < x + #pattern - 1 do
        currentBg = currentBg .. "0"
    end
    
    frame[y][3] = currentBg:sub(1, x-1) .. pattern .. currentBg:sub(x + #pattern)
    self:updateRender()
    return self
end

function Image:setPixel(x, y, char, fg, bg)
    if char then self:setText(x, y, char) end
    if fg then self:setFg(x, y, fg) end
    if bg then self:setBg(x, y, bg) end
    return self
end

function Image:setOffset(x, y)
    self.set("offsetX", x)
    self.set("offsetY", y)
    return self
end

function Image:getOffset()
    return self.get("offsetX"), self.get("offsetY")
end

--- Advances to the next frame in the animation
--- @shortDescription Advances to the next frame in the animation
--- @return Image self The Image instance
function Image:nextFrame()
    if not self.get("metadata").animation then return end

    local frames = self.get("bimg")
    local current = self.get("currentFrame")
    local next = current + 1
    if next > #frames then next = 1 end

    self.set("currentFrame", next)
    return self
end

--- @shortDescription Renders the Image
--- @protected
function Image:render()
    VisualElement.render(self)

    local frame = self.get("bimg")[self.get("currentFrame")]
    if not frame then return end

    local offsetX = self.get("offsetX")
    local offsetY = self.get("offsetY")
    local elementWidth = self.get("width")
    local elementHeight = self.get("height")

    for y = 1, elementHeight do
        local frameY = y + offsetY
        local line = frame[frameY]

        if line then
            local text = line[1]:sub(1 + offsetX, elementWidth + offsetX)
            local fg = line[2]:sub(1 + offsetX, elementWidth + offsetX)
            local bg = line[3]:sub(1 + offsetX, elementWidth + offsetX)

            if text and fg and bg then                
                self:blit(1 + offsetX, y, text, fg, bg)
            end
        end
    end
end

return Image

local elementManager = require("elementManager")
local VisualElement = elementManager.getElement("VisualElement")
local tHex = require("libraries/colorHex")
---@configDescription An element that displays an image in bimg format
---@configDefault false

--- This is the Image element class which can be used to display bimg formatted images.
--- Bimg is a universal ComputerCraft image format.
--- See: https://github.com/SkyTheCodeMaster/bimg
---@class Image : VisualElement
local Image = setmetatable({}, VisualElement)
Image.__index = Image

---@property bimg table {} The bimg image data
Image.defineProperty(Image, "bimg", {default = {{}}, type = "table", canTriggerRender = true})
---@property currentFrame number 1 Current animation frame
Image.defineProperty(Image, "currentFrame", {default = 1, type = "number", canTriggerRender = true})
---@property autoResize boolean false Whether to automatically resize the image when content exceeds bounds
Image.defineProperty(Image, "autoResize", {default = false, type = "boolean"})
---@property offsetX number 0 Horizontal offset for viewing larger images
Image.defineProperty(Image, "offsetX", {default = 0, type = "number", canTriggerRender = true})
---@property offsetY number 0 Vertical offset for viewing larger images
Image.defineProperty(Image, "offsetY", {default = 0, type = "number", canTriggerRender = true})

---@combinedProperty offset {offsetX offsetY} Combined property for offsetX and offsetY
Image.combineProperties(Image, "offset", "offsetX", "offsetY")

--- Creates a new Image instance
--- @shortDescription Creates a new Image instance
--- @return Image self The newly created Image instance
--- @private
function Image.new()
    local self = setmetatable({}, Image):__init()
    self.class = Image
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

--- Resizes the image to the specified width and height
--- @shortDescription Resizes the image to the specified width and height
--- @param width number The new width of the image
--- @param height number The new height of the image
--- @return Image self The Image instance
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

--- Gets the size of the image
--- @shortDescription Gets the size of the image
--- @return number width The width of the image
--- @return number height The height of the image
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

local function updateFrameSize(self, neededWidth, neededHeight)
    if not self.get("autoResize") then return end

    local frames = self.get("bimg")

    local maxWidth = neededWidth
    local maxHeight = neededHeight

    for _, frame in ipairs(frames) do
        for y, line in pairs(frame) do
            maxWidth = math.max(maxWidth, #line[1])
            maxHeight = math.max(maxHeight, y)
        end
    end

    for _, frame in ipairs(frames) do
        for y = 1, maxHeight do
            if not frame[y] then
                frame[y] = {"", "", ""}
            end

            local line = frame[y]
            while #line[1] < maxWidth do line[1] = line[1] .. " " end
            while #line[2] < maxWidth do line[2] = line[2] .. "f" end
            while #line[3] < maxWidth do line[3] = line[3] .. "0" end
        end
    end
end

--- Sets the text at the specified position
--- @shortDescription Sets the text at the specified position
--- @param x number The x position
--- @param y number The y position
--- @param text string The text to set
--- @return Image self The Image instance
function Image:setText(x, y, text)
    if type(text) ~= "string" or #text < 1 or x < 1 or y < 1 then return self end
    if not self.get("autoResize")then
        local imgWidth, imgHeight = self:getImageSize()
        if y > imgHeight then return self end
    end
    local frame = ensureFrame(self, y)

    if self.get("autoResize") then
        updateFrameSize(self, x + #text - 1, y)
    else
        local maxLen = #frame[y][1]
        if x > maxLen then return self end
        text = text:sub(1, maxLen - x + 1)
    end

    local currentLine = frame[y][1]
    frame[y][1] = currentLine:sub(1, x-1) .. text .. currentLine:sub(x + #text)

    self:updateRender()
    return self
end

--- Gets the text at the specified position
--- @shortDescription Gets the text at the specified position
--- @param x number The x position
--- @param y number The y position
--- @param length number The length of the text to get
--- @return string text The text at the specified position
function Image:getText(x, y, length)
    if not x or not y then return "" end
    local frame = self.get("bimg")[self.get("currentFrame")]
    if not frame or not frame[y] then return "" end

    local text = frame[y][1]
    if not text then return "" end

    if length then
        return text:sub(x, x + length - 1)
    else
        return text:sub(x, x)
    end
end

--- Sets the foreground color at the specified position
--- @shortDescription Sets the foreground color at the specified position
--- @param x number The x position
--- @param y number The y position
--- @param pattern string The foreground color pattern
--- @return Image self The Image instance
function Image:setFg(x, y, pattern)
    if type(pattern) ~= "string" or #pattern < 1 or x < 1 or y < 1 then return self end
    if not self.get("autoResize")then
        local imgWidth, imgHeight = self:getImageSize()
        if y > imgHeight then return self end
    end
    local frame = ensureFrame(self, y)

    if self.get("autoResize") then
        updateFrameSize(self, x + #pattern - 1, y)
    else
        local maxLen = #frame[y][2]
        if x > maxLen then return self end
        pattern = pattern:sub(1, maxLen - x + 1)
    end

    local currentFg = frame[y][2]
    frame[y][2] = currentFg:sub(1, x-1) .. pattern .. currentFg:sub(x + #pattern)

    self:updateRender()
    return self
end

--- Gets the foreground color at the specified position
--- @shortDescription Gets the foreground color at the specified position
--- @param x number The x position
--- @param y number The y position
--- @param length number The length of the foreground color pattern to get
--- @return string fg The foreground color pattern
function Image:getFg(x, y, length)
    if not x or not y then return "" end
    local frame = self.get("bimg")[self.get("currentFrame")]
    if not frame or not frame[y] then return "" end

    local fg = frame[y][2]
    if not fg then return "" end

    if length then
        return fg:sub(x, x + length - 1)
    else
        return fg:sub(x)
    end
end

--- Sets the background color at the specified position
--- @shortDescription Sets the background color at the specified position
--- @param x number The x position
--- @param y number The y position
--- @param pattern string The background color pattern
--- @return Image self The Image instance
function Image:setBg(x, y, pattern)
    if type(pattern) ~= "string" or #pattern < 1 or x < 1 or y < 1 then return self end
    if not self.get("autoResize")then
        local imgWidth, imgHeight = self:getImageSize()
        if y > imgHeight then return self end
    end
    local frame = ensureFrame(self, y)

    if self.get("autoResize") then
        updateFrameSize(self, x + #pattern - 1, y)
    else
        local maxLen = #frame[y][3]
        if x > maxLen then return self end
        pattern = pattern:sub(1, maxLen - x + 1)
    end

    local currentBg = frame[y][3]
    frame[y][3] = currentBg:sub(1, x-1) .. pattern .. currentBg:sub(x + #pattern)

    self:updateRender()
    return self
end

--- Gets the background color at the specified position
--- @shortDescription Gets the background color at the specified position
--- @param x number The x position
--- @param y number The y position
--- @param length number The length of the background color pattern to get
--- @return string bg The background color pattern
function Image:getBg(x, y, length)
    if not x or not y then return "" end
    local frame = self.get("bimg")[self.get("currentFrame")]
    if not frame or not frame[y] then return "" end

    local bg = frame[y][3]
    if not bg then return "" end

    if length then
        return bg:sub(x, x + length - 1)
    else
        return bg:sub(x)
    end
end

--- Sets the pixel at the specified position
--- @shortDescription Sets the pixel at the specified position
--- @param x number The x position
--- @param y number The y position
--- @param char string The character to set
--- @param fg string The foreground color pattern
--- @param bg string The background color pattern
--- @return Image self The Image instance
function Image:setPixel(x, y, char, fg, bg)
    if char then self:setText(x, y, char) end
    if fg then self:setFg(x, y, fg) end
    if bg then self:setBg(x, y, bg) end
    return self
end

--- Advances to the next frame in the animation
--- @shortDescription Advances to the next frame in the animation
--- @return Image self The Image instance
function Image:nextFrame()
    if not self.get("bimg").animation then return self end

    local frames = self.get("bimg")
    local current = self.get("currentFrame")
    local next = current + 1
    if next > #frames then next = 1 end

    self.set("currentFrame", next)
    return self
end

--- Adds a new frame to the image
--- @shortDescription Adds a new frame to the image
--- @return Image self The Image instance
function Image:addFrame()
    local frames = self.get("bimg")
    local width = frames.width or #frames[1][1][1]
    local height = frames.height or #frames[1]
    local frame = {}
    local text = string.rep(" ", width)
    local fg = string.rep("f", width)
    local bg = string.rep("0", width)
    for y = 1, height do
        frame[y] = {text, fg, bg}
    end
    table.insert(frames, frame)
    return self
end

--- Updates the specified frame with the provided data
--- @shortDescription Updates the specified frame with the provided data
--- @param frameIndex number The index of the frame to update
--- @param frame table The new frame data
--- @return Image self The Image instance
function Image:updateFrame(frameIndex, frame)
    local frames = self.get("bimg")
    frames[frameIndex] = frame
    self:updateRender()
    return self
end

--- Gets the specified frame
--- @shortDescription Gets the specified frame
--- @param frameIndex number The index of the frame to get
--- @return table frame The frame data
function Image:getFrame(frameIndex)
    local frames = self.get("bimg")
    return frames[frameIndex or self.get("currentFrame")]
end

--- Gets the metadata of the image
--- @shortDescription Gets the metadata of the image
--- @return table metadata The metadata of the image
function Image:getMetadata()
    local metadata = {}
    local bimg = self.get("bimg")
    for k,v in pairs(bimg)do
        if(type(v)=="string")then
            metadata[k] = v
        end
    end
    return metadata
end

--- Sets the metadata of the image
--- @shortDescription Sets the metadata of the image
--- @param key string The key of the metadata to set
--- @param value string The value of the metadata to set
--- @return Image self The Image instance
function Image:setMetadata(key, value)
    if(type(key)=="table")then
        for k,v in pairs(key)do
            self:setMetadata(k, v)
        end
        return self
    end
    local bimg = self.get("bimg")
    if(type(value)=="string")then
        bimg[key] = value
    end
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
            local text = line[1]
            local fg = line[2]
            local bg = line[3]

            if text and fg and bg then
                local remainingWidth = elementWidth - math.max(0, offsetX)
                if remainingWidth > 0 then
                    if offsetX < 0 then
                        local startPos = math.abs(offsetX) + 1
                        text = text:sub(startPos)
                        fg = fg:sub(startPos)
                        bg = bg:sub(startPos)
                    end

                    text = text:sub(1, remainingWidth)
                    fg = fg:sub(1, remainingWidth)
                    bg = bg:sub(1, remainingWidth)

                    self:blit(math.max(1, 1 + offsetX), y, text, fg, bg)
                end
            end
        end
    end
end

return Image
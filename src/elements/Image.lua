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
Image.defineProperty(Image, "bimg", {default = {}, type = "table", canTriggerRender = true})
---@property currentFrame number 1 Current animation frame
Image.defineProperty(Image, "currentFrame", {default = 1, type = "number", canTriggerRender = true})
---@property metadata table {} Image metadata (version, palette, etc)
Image.defineProperty(Image, "metadata", {default = {}, type = "table"})

function Image.new()
    local self = setmetatable({}, Image):__init()
    return self
end

function Image:init(props, basalt)
    VisualElement.init(self, props, basalt)
    self.set("type", "Image")
    return self
end

--- Loads a bimg format image
--- @param bimgData table The bimg image data
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

--- Gets pixel information at position
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

--- Sets character at position
--- @param x number X position
--- @param y number Y position
--- @param char string Single character to set
function Image:setChar(x, y, char)
    if type(char) ~= "string" or #char ~= 1 then return self end

    local frame = self.get("bimg")[self.get("currentFrame")]
    if not frame then
        frame = {{}, {}, {}}
        self.get("bimg")[self.get("currentFrame")] = frame
    end

    if not frame[y] then
        frame[y] = {"", "", ""}
    end

    local text = frame[y][1]
    while #text < x do
        text = text .. " "
    end

    frame[y][1] = text:sub(1, x-1) .. char .. text:sub(x+1)
    self:updateRender()
    return self
end

--- Sets foreground color at position
--- @param x number X position
--- @param y number Y position
--- @param color number Color value (0-15)
function Image:setFg(x, y, color)
    if type(color) ~= "number" then return self end
    
    local frame = self.get("bimg")[self.get("currentFrame")]
    if not frame then
        frame = {{}, {}, {}}
        self.get("bimg")[self.get("currentFrame")] = frame
    end
    
    if not frame[y] then
        frame[y] = {"", "", ""}
    end
    
    local fg = frame[y][2]
    while #fg < x do
        fg = fg .. "f"
    end
    
    frame[y][2] = fg:sub(1, x-1) .. tHex[color] .. fg:sub(x+1)
    self:updateRender()
    return self
end

--- Sets background color at position
--- @param x number X position
--- @param y number Y position
--- @param color number Color value (0-15)
function Image:setBg(x, y, color)
    if type(color) ~= "number" then return self end
    
    local frame = self.get("bimg")[self.get("currentFrame")]
    if not frame then
        frame = {{}, {}, {}}
        self.get("bimg")[self.get("currentFrame")] = frame
    end
    
    if not frame[y] then
        frame[y] = {"", "", ""}
    end
    
    local bg = frame[y][3]
    while #bg < x do
        bg = bg .. "f"
    end
    
    frame[y][3] = bg:sub(1, x-1) .. tHex[color] .. bg:sub(x+1)
    self:updateRender()
    return self
end

--- Sets all properties at position
--- @param x number X position
--- @param y number Y position
--- @param char string? Character to set (optional)
--- @param fg number? Foreground color (optional)
--- @param bg number? Background color (optional)
function Image:setPixel(x, y, char, fg, bg)
    if char then self:setChar(x, y, char) end
    if fg then self:setFg(x, y, fg) end
    if bg then self:setBg(x, y, bg) end
    return self
end

function Image:nextFrame()
    if not self.get("metadata").animation then return end

    local frames = self.get("bimg")
    local current = self.get("currentFrame")
    local next = current + 1
    if next > #frames then next = 1 end

    self.set("currentFrame", next)
    return self
end

function Image:render()
    VisualElement.render(self)

    local frame = self.get("bimg")[self.get("currentFrame")]
    if not frame then return end

    for y, line in ipairs(frame) do
        local text = line[1]
        local fg = line[2]
        local bg = line[3]

        if text and fg and bg then
            self:blit(1, y, text, fg, bg)
        end
    end
end

return Image

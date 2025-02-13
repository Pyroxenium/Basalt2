local floor, len = math.floor, string.len

local utils = {}

function utils.getCenteredPosition(text, totalWidth, totalHeight)
    local textLength = len(text)

    local x = floor((totalWidth - textLength+1) / 2 + 0.5)
    local y = floor(totalHeight / 2 + 0.5)

    return x, y
end

function utils.deepCopy(obj)
    if type(obj) ~= "table" then
        return obj
    end

    local copy = {}
    for k, v in pairs(obj) do
        copy[utils.deepCopy(k)] = utils.deepCopy(v)
    end

    return copy
end

function utils.uuid()
    return string.format('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
    math.random(0, 0xffff), math.random(0, 0xffff), math.random(0, 0xffff),
    math.random(0, 0x0fff) + 0x4000, math.random(0, 0x3fff) + 0x8000,
    math.random(0, 0xffff), math.random(0, 0xffff), math.random(0, 0xffff))
end

function utils.split(str, sep)
    local parts = {}
    local start = 1
    local len = len(str)
    local splitIndex = 1

    while true do
        local index = str:find(sep, start, true)
        if not index then
            parts[splitIndex] = str:sub(start, len)
            break
        end

        parts[splitIndex] = str:sub(start, index - 1)
        start = index + 1
        splitIndex = splitIndex + 1
    end

    return parts
end

return utils
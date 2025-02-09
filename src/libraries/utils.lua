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

return utils
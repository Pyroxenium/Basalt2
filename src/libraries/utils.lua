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

function utils.copy(obj)
    local new = {}
    for k,v in pairs(obj)do
        new[k] = v
    end
    return new
end

function utils.reverse(t)
    local reversed = {}
    for i = #t, 1, -1 do
        table.insert(reversed, t[i])
    end
    return reversed
end

function utils.uuid()
    return string.format('%04x%04x-%04x-%04x-%04x-%04x%04x%04x',
    math.random(0, 0xffff), math.random(0, 0xffff), math.random(0, 0xffff),
    math.random(0, 0x0fff) + 0x4000, math.random(0, 0x3fff) + 0x8000,
    math.random(0, 0xffff), math.random(0, 0xffff), math.random(0, 0xffff))
end

function utils.split(str, delimiter)
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

function utils.removeTags(input)
    return input:gsub("{[^}]+}", "")
end

function utils.wrapText(str, width)
    if str == nil then return {} end
    str = utils.removeTags(str)
    local lines = {}

    local paragraphs = utils.split(str, "\n\n")

    for i, paragraph in ipairs(paragraphs) do
        if #paragraph == 0 then
            table.insert(lines, "")
            if i < #paragraphs then
                table.insert(lines, "")
            end
        else
            local textLines = utils.split(paragraph, "\n")

            for _, line in ipairs(textLines) do
                local words = utils.split(line, " ")
                local currentLine = ""

                for _, word in ipairs(words) do
                    if #currentLine == 0 then
                        currentLine = word
                    elseif #currentLine + #word + 1 <= width then
                        currentLine = currentLine .. " " .. word
                    else
                        table.insert(lines, currentLine)
                        currentLine = word
                    end
                end

                if #currentLine > 0 then
                    table.insert(lines, currentLine)
                end
            end

            if i < #paragraphs then
                table.insert(lines, "")
            end
        end
    end

    return lines
end

return utils
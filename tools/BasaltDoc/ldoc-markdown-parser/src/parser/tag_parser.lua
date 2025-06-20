local tagParser = {}

local function parseTag(tagLine)
    local tag, content = tagLine:match("^%s*@(.-)%s*(.*)$")
    return tag, content
end

function tagParser.parseTags(commentLines)
    local tags = {}
    for _, line in ipairs(commentLines) do
        local tag, content = parseTag(line)
        if tag then
            tags[tag] = content
        end
    end
    return tags
end

return tagParser
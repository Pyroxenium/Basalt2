local string_utils = {}

function string_utils.trim(s)
    return s:match("^%s*(.-)%s*$")
end

function string_utils.is_empty(s)
    return s == nil or s == ""
end

function string_utils.starts_with(s, prefix)
    return s:sub(1, #prefix) == prefix
end

function string_utils.ends_with(s, suffix)
    return s:sub(-#suffix) == suffix
end

function string_utils.split(s, delimiter)
    local result = {}
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

return string_utils
local string_utils = require("utils.string_utils")

local utils = {}

-- Re-export string utilities
utils.trim = string_utils.trim
utils.is_empty = string_utils.is_empty
utils.starts_with = string_utils.starts_with
utils.ends_with = string_utils.ends_with
utils.split = string_utils.split

function utils.isClassMethod(name)
    return name:sub(1, 1):upper() == name:sub(1, 1)
end

return utils
local fileReader = {}

--- Read file content
--- @param filePath string Path to the file
--- @return string|nil content File content or nil if error
--- @return string|nil error Error message if any
function fileReader.readFile(filePath)
    local file = io.open(filePath, "r")
    if not file then
        return nil, "Could not open file: " .. filePath
    end
    
    local content = file:read("*all")
    file:close()
    
    return content, nil
end

--- Write content to file
--- @param filePath string Path to the file
--- @param content string Content to write
--- @return string|nil error Error message if any
function fileReader.writeFile(filePath, content)
    local file = io.open(filePath, "w")
    if not file then
        return "Could not open file for writing: " .. filePath
    end
    
    file:write(content)
    file:close()
    
    return nil
end

return fileReader
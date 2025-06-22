local CommentExtractor = {}

--- Extracts comment blocks that belong together
function CommentExtractor.extractBlocks(lines)
    local blocks = {}
    local currentBlock = {
        comments = {},
        codeContext = nil
    }
    
    local i = 1
    while i <= #lines do
        local line = lines[i]
        local trimmed = line:match("^%s*(.-)%s*$")
        
        -- Check if this is a comment line
        if trimmed:match("^%-%-%-") or trimmed:match("^%-%-") then
            table.insert(currentBlock.comments, trimmed)
        elseif #currentBlock.comments > 0 then
            -- We have comments, now look for the code that follows
            local codeLineIndex = CommentExtractor.findNextCodeLine(lines, i)
            if codeLineIndex then
                local codeLine = lines[codeLineIndex]:match("^%s*(.-)%s*$")
                currentBlock.codeContext = CommentExtractor.analyzeCode(codeLine, codeLineIndex)
            end
            
            -- Save this block and start a new one
            table.insert(blocks, currentBlock)
            currentBlock = {comments = {}, codeContext = nil}
        end
        
        i = i + 1
    end
    
    -- Handle remaining comments
    if #currentBlock.comments > 0 then
        table.insert(blocks, currentBlock)
    end
    
    return blocks
end

--- Find the next non-empty code line
function CommentExtractor.findNextCodeLine(lines, startIndex)
    for i = startIndex, #lines do
        local trimmed = lines[i]:match("^%s*(.-)%s*$")
        if trimmed ~= "" and not trimmed:match("^%-%-") then
            return i
        end
    end
    return nil
end

--- Analyze what kind of code this is
function CommentExtractor.analyzeCode(codeLine, lineNumber)
    -- Function patterns
    if codeLine:match("^function%s+([%w%.%:]+)") then
        local name = codeLine:match("^function%s+([%w%.%:]+)")
        return {type = "function", name = name, line = codeLine, lineNumber = lineNumber}
    end
    
    if codeLine:match("^local%s+function%s+([%w%.%:]+)") then
        local name = codeLine:match("^local%s+function%s+([%w%.%:]+)")
        return {type = "function", name = name, line = codeLine, lineNumber = lineNumber}
    end
    
    -- Class/variable patterns
    if codeLine:match("^local%s+([%w_]+)%s*=%s*setmetatable") then
        local name = codeLine:match("^local%s+([%w_]+)%s*=")
        return {type = "class", name = name, line = codeLine, lineNumber = lineNumber}
    end
    
    if codeLine:match("^local%s+([%w_]+)%s*=") then
        local name = codeLine:match("^local%s+([%w_]+)%s*=")
        return {type = "variable", name = name, line = codeLine, lineNumber = lineNumber}
    end
    
    return {type = "unknown", name = "unknown", line = codeLine, lineNumber = lineNumber}
end

return CommentExtractor
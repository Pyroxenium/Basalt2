local CommentExtractor = {}

--- Extracts comments with their associated code context
-- @param lines table The lines of the Lua file as a table of strings.
-- @return table A table containing comment blocks with context.
function CommentExtractor.extractComments(lines)
    local blocks = {}
    local currentCommentBlock = {}
    local i = 1
    
    while i <= #lines do
        local line = lines[i]:match("^%s*(.*)") -- Trim leading whitespace
        
        -- Check if this is a comment line
        if line:find("^%-%-%-") or line:find("^%-%-") then
            table.insert(currentCommentBlock, line)
        elseif #currentCommentBlock > 0 then
            -- We have accumulated comments, check if next non-empty line is code
            local codeContext = nil
            local j = i
            
            -- Skip empty lines to find the actual code
            while j <= #lines and lines[j]:match("^%s*$") do
                j = j + 1
            end
            
            if j <= #lines then
                local codeLine = lines[j]:match("^%s*(.*)")
                -- Check if it's a function, class, property, etc.
                if codeLine:find("^function") or 
                   codeLine:find("^local function") or
                   codeLine:find("^local%s+%w+%s*=") or
                   codeLine:find("^%w+%.%w+") then
                    codeContext = {
                        type = CommentExtractor.getCodeType(codeLine),
                        name = CommentExtractor.extractName(codeLine),
                        line = codeLine,
                        lineNumber = j
                    }
                end
            end
            
            -- Add the comment block with its context
            table.insert(blocks, {
                comments = currentCommentBlock,
                context = codeContext
            })
            
            currentCommentBlock = {}
        end
        
        i = i + 1
    end
    
    -- Handle any remaining comments
    if #currentCommentBlock > 0 then
        table.insert(blocks, {
            comments = currentCommentBlock,
            context = nil
        })
    end
    
    return blocks
end

--- Determines the type of code (function, class, property, etc.)
function CommentExtractor.getCodeType(codeLine)
    if codeLine:find("^function") or codeLine:find("^local function") then
        return "function"
    elseif codeLine:find("^local%s+%w+%s*=%s*setmetatable") then
        return "class"
    elseif codeLine:find("^local%s+%w+%s*=") then
        return "variable"
    elseif codeLine:find("^%w+%.defineProperty") then
        return "property_definition"
    else
        return "unknown"
    end
end

--- Extracts the name from a code line
function CommentExtractor.extractName(codeLine)
    -- Function patterns
    local funcName = codeLine:match("^function%s+([%w%.%:]+)")
    if funcName then return funcName end
    
    local localFuncName = codeLine:match("^local%s+function%s+([%w%.%:]+)")
    if localFuncName then return localFuncName end
    
    -- Variable/class patterns
    local varName = codeLine:match("^local%s+([%w_]+)%s*=")
    if varName then return varName end
    
    -- Method patterns
    local methodName = codeLine:match("^([%w%.%:]+)%s*=")
    if methodName then return methodName end
    
    return "unknown"
end

return CommentExtractor
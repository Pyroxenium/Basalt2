local CommentExtractor = require("parser.comment_extractor")
local MarkdownGenerator = require("parser.markdown_generator")

local Parser = {}

--- Extract comments and generate markdown
function Parser.extractComments(content)
    local lines = {}
    for line in content:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
    return CommentExtractor.extractComments(lines)
end

--- Generate markdown from comment blocks
function Parser.generateMarkdown(commentBlocks)
    local parsedBlocks = {}
    
    -- Parse each block using the appropriate parser
    for _, block in ipairs(commentBlocks) do
        local parsedBlock = MarkdownGenerator.parseBlock(block)
        table.insert(parsedBlocks, parsedBlock)
    end
    
    -- Generate markdown from parsed blocks
    return MarkdownGenerator.generateMarkdown(parsedBlocks)
end

return Parser
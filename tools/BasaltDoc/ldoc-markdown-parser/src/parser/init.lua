local CommentExtractor = require("parser.comment_extractor")
local TagParser = require("parser.tag_parser")
local MarkdownGenerator = require("parser.markdown_generator")

local Parser = {}

--- Extract comments and generate markdown
function Parser.extractComments(content)
    local lines = {}
    for line in content:gmatch("[^\r\n]+") do
        table.insert(lines, line)
    end
    return CommentExtractor.extractBlocks(lines)
end

--- Generate markdown from comment blocks
function Parser.generateMarkdown(commentBlocks)
    local markdown = {}
    
    -- Parse each block and generate markdown
    for _, block in ipairs(commentBlocks) do
        local tags = TagParser.parseAllTags(block.comments)
        local blockMarkdown = MarkdownGenerator.generateBlock(block, tags)
        if blockMarkdown and blockMarkdown ~= "" then
            table.insert(markdown, blockMarkdown)
        end
    end
    
    return table.concat(markdown, "\n\n")
end

return Parser
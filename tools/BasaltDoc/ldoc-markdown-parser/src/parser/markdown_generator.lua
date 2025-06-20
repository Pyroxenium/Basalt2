local markdownGenerator = {}
local TagParserRegistry = require("parser.tag_parser_registry")

--- Determines which block parser should handle a given block
--- @param block table The comment block with context
--- @return string|nil The block type that can handle this block
function markdownGenerator.detectBlockType(block)
    local blockParsers = TagParserRegistry.getAllBlocks()
    
    for blockType, parser in pairs(blockParsers) do
        if parser.canParse and parser.canParse(block) then
            return blockType
        end
    end
    
    return nil -- No specific block parser found, use generic parsing
end

--- Parses a block using the appropriate block parser
--- @param block table The comment block to parse
--- @return table The parsed block data
function markdownGenerator.parseBlock(block)
    local blockType = markdownGenerator.detectBlockType(block)
    
    if blockType then
        local parser = TagParserRegistry.getBlock(blockType)
        return parser.parse(block)
    else
        -- Generic parsing using individual tag parsers
        return markdownGenerator.parseGenericBlock(block)
    end
end

--- Generic block parsing using individual tag parsers
--- @param block table The comment block to parse
--- @return table The parsed block data
function markdownGenerator.parseGenericBlock(block)
    local parsedBlock = {
        type = "generic",
        tags = {},
        content = {},
        context = block.context
    }
    
    for _, line in ipairs(block.comments) do
        local parsed = false
        local tagParsers = TagParserRegistry.getAllTags()
        
        -- Try each registered tag parser
        for tagName, parser in pairs(tagParsers) do
            local result = parser.parse(line)
            if result then
                table.insert(parsedBlock.tags, result)
                parsed = true
                break
            end
        end
        
        -- If no tag parser matched, treat as regular content
        if not parsed then
            table.insert(parsedBlock.content, line)
        end
    end
    
    return parsedBlock
end

--- Converts parsed blocks to markdown
--- @param parsedBlocks table Array of parsed blocks
--- @return string The generated markdown
function markdownGenerator.generateMarkdown(parsedBlocks)
    local markdown = {}
    
    for _, block in ipairs(parsedBlocks) do
        if block.type == "function" then
            table.insert(markdown, markdownGenerator.generateFunctionMarkdown(block))
        else
            table.insert(markdown, markdownGenerator.generateGenericMarkdown(block))
        end
        table.insert(markdown, "") -- Empty line between blocks
    end
    
    return table.concat(markdown, "\n")
end

--- Generate markdown for function blocks
--- @param functionBlock table The parsed function block
--- @return string The generated markdown
function markdownGenerator.generateFunctionMarkdown(functionBlock)
    local md = {}
    
    table.insert(md, string.format("## Function: %s", functionBlock.name))
    
    if functionBlock.shortDescription then
        table.insert(md, string.format("**Description:** %s", functionBlock.shortDescription))
    end
    
    if #functionBlock.params > 0 then
        table.insert(md, "**Parameters:**")
        for _, param in ipairs(functionBlock.params) do
            table.insert(md, string.format("- `%s` (%s): %s", param.name, param.type, param.description))
        end
    end
    
    if #functionBlock.returns > 0 then
        table.insert(md, "**Returns:**")
        for _, ret in ipairs(functionBlock.returns) do
            table.insert(md, string.format("- `%s` (%s): %s", ret.name, ret.type, ret.description))
        end
    end
    
    if functionBlock.visibility ~= "public" then
        table.insert(md, string.format("**Visibility:** %s", functionBlock.visibility))
    end
    
    return table.concat(md, "\n")
end

--- Generate markdown for generic blocks
--- @param block table The parsed generic block
--- @return string The generated markdown
function markdownGenerator.generateGenericMarkdown(block)
    local md = {}
    
    -- Generate markdown for tags
    if #block.tags > 0 then
        table.insert(md, "### Tags")
        for _, tag in ipairs(block.tags) do
            table.insert(md, string.format("- **%s**: %s", tag.name, tag.description))
        end
    end
    
    -- Generate markdown for content
    if #block.content > 0 then
        table.insert(md, "### Content")
        table.insert(md, table.concat(block.content, "\n"))
    end
    
    return table.concat(md, "\n\n")
end

return markdownGenerator
local TagParserRegistry = {}

local tagParsers = {}
local blockParsers = {}

--- Register a new tag parser (for individual tags like @param, @return)
function TagParserRegistry.registerTag(tagName, parser)
    tagParsers[tagName] = parser
end

--- Register a new block parser (for complete blocks like functions, classes)
function TagParserRegistry.registerBlock(blockType, parser)
    blockParsers[blockType] = parser
end

--- Get a specific tag parser
function TagParserRegistry.getTag(tagName)
    return tagParsers[tagName]
end

--- Get a specific block parser
function TagParserRegistry.getBlock(blockType)
    return blockParsers[blockType]
end

--- Get all registered tag parsers
function TagParserRegistry.getAllTags()
    return tagParsers
end

--- Get all registered block parsers
function TagParserRegistry.getAllBlocks()
    return blockParsers
end

--- Auto-load all parsers
local function loadAllParsers()
    -- Load tag parsers (individual tags)
    local tagParsersList = {"param", "return", "property", "private", "protected", "shortDescription"}
    for _, parserName in ipairs(tagParsersList) do
        local success, parser = pcall(require, "parser.tag_parsers." .. parserName)
        if success then
            TagParserRegistry.registerTag(parserName, parser)
        end
    end
    
    -- Load block parsers (complete documentation blocks)
    local blockParsersList = {"function", "class", "property_definition"}
    for _, parserName in ipairs(blockParsersList) do
        local success, parser = pcall(require, "parser.block_parsers." .. parserName)
        if success then
            TagParserRegistry.registerBlock(parserName, parser)
        end
    end
end

loadAllParsers()

return TagParserRegistry

-- Basalt documentation generator (a tool, not part of the framework).
--
-- Parses the sources under src/ and writes markdown files into docs/.
-- Nothing has to be annotated for a page to exist: class.create,
-- class.property and class.event declarations are read structurally
-- (name, parent, defaults). Doc comments enrich them:
--
--   --- Description lines directly above a declaration.
--   ---@param name type description     (methods)
--   ---@return type description         (methods)
--   ---@usage local x = ...             (methods, may span several lines)
--
--   --- Description above class.property/class.event, or a trailing
--   class.property(X, "foo", false) -- comment on the same line
--
-- Methods starting with "_" and local functions are treated as private
-- and skipped.
--
-- Usage:
--   docgen [outputDir]   generate Markdown (default: docs/)
--   docgen --check       parse and validate without writing files

local args = { ... }

local function findRoot()
    local candidates = {}
    if shell then
        local running = shell.getRunningProgram()
        candidates[#candidates + 1] = fs.getDir(fs.getDir(running))
        if shell.dir then candidates[#candidates + 1] = shell.dir() end
    end
    candidates[#candidates + 1] = ""
    for _, candidate in ipairs(candidates) do
        if fs.exists(fs.combine(candidate, "src/main.lua")) then
            return candidate
        end
    end
    error("docgen: cannot find repository root (expected src/main.lua)", 0)
end

local checkOnly, requestedOut = false, nil
for _, arg in ipairs(args) do
    if arg == "--check" then
        checkOnly = true
    elseif arg:sub(1, 2) ~= "--" then
        requestedOut = arg
    end
end

local root = findRoot()
local srcDir = fs.combine(root, "src")
local outDir = requestedOut or fs.combine(root, "docs")

----------------------------------------------------------------------------
-- parsing
----------------------------------------------------------------------------

local function trim(s)
    return s:match("^%s*(.-)%s*$")
end

local function splitList(value)
    local result = {}
    for item in (value or ""):gmatch("[^,]+") do
        item = trim(item)
        if item ~= "" then result[#result + 1] = item end
    end
    return result
end

local function splitTypeAndDescription(value)
    value = trim(value or "")
    local depth = 0
    for i = 1, #value do
        local char = value:sub(i, i)
        if char == "<" or char == "(" or char == "[" or char == "{" then
            depth = depth + 1
        elseif char == ">" or char == ")" or char == "]" or char == "}" then
            depth = math.max(0, depth - 1)
        elseif char:match("%s") and depth == 0 then
            local previous = value:sub(1, i - 1):match("(%S)%s*$")
            local following = value:sub(i + 1):match("^%s*(.)")
            local functionType = value:match("^fun[%(<]") ~= nil
            if not functionType
                or (previous ~= ":" and previous ~= ","
                    and previous ~= "|" and following ~= ","
                    and following ~= "|") then
                return value:sub(1, i - 1), trim(value:sub(i + 1))
            end
        end
    end
    return value, ""
end

local function parseDocBlock(blockLines)
    local doc = { desc = {}, params = {}, returns = {}, usage = {} }
    local target = doc.desc
    for _, line in ipairs(blockLines) do
        local paramName, paramRest = line:match("^@param%s+(%S+)%s+(.+)$")
        local returnRest = line:match("^@return%s+(.+)$")
        local usageRest = line:match("^@usage%s*(.*)$")
        if paramName then
            local optional = paramName:sub(-1) == "?"
            if optional then paramName = paramName:sub(1, -2) end
            local paramType, paramDescription =
                splitTypeAndDescription(paramRest)
            doc.params[#doc.params + 1] =
                {
                    name = paramName,
                    type = paramType,
                    desc = paramDescription,
                    optional = optional,
                }
            target = nil
        elseif returnRest then
            local returnType, returnDescription =
                splitTypeAndDescription(returnRest)
            local returnName
            local name, description =
                returnDescription:match("^([a-z_][%w_]*)%s+(.+)$")
            if name then
                returnName, returnDescription = name, description
            elseif returnDescription:match("^%w+$") then
                returnName, returnDescription = returnDescription, ""
            end
            doc.returns[#doc.returns + 1] =
                {
                    type = returnType,
                    name = returnName,
                    desc = returnDescription,
                }
            target = nil
        elseif usageRest then
            target = doc.usage
            if #usageRest > 0 then target[#target + 1] = usageRest end
        elseif line:match("^@") then
            target = nil
        elseif target then
            target[#target + 1] = line
        end
    end
    return doc
end

local function describeDefault(raw)
    raw = trim(raw or "")
    if raw:sub(1, 8) == "function" then return "*dynamic*" end
    if raw:sub(1, 1) == "{" then return "*table*" end
    if raw == "" then return "?" end
    return "`" .. raw .. "`"
end

local function baseTypeName(name)
    return (name or ""):match("^([%w_%.]+)")
end

local function parseFile(path)
    local handle = fs.open(path, "r")
    local content = handle.readAll()
    handle.close()

    local sourceName = fs.getName(path):gsub("%.lua$", "")
    local page = {
        sourceName = sourceName,
        name = sourceName,
        primaryClass = nil,
        extends = {},
        header = {},
        props = {},
        events = {},
        methods = {},
        types = {},
        typeByName = {},
        aliases = {},
        aliasByName = {},
    }

    local pending = {}
    local currentType = nil
    local inHeader = true
    local lineNo = 0

    for line in (content .. "\n"):gmatch("(.-)\n") do
        lineNo = lineNo + 1
        repeat

        if inHeader then
            local headerText = line:match("^%-%-%s?(.*)$")
            if headerText ~= nil and not line:match("^%-%-%-") then
                page.header[#page.header + 1] = headerText
                break
            elseif trim(line) ~= "" then
                inHeader = false
            else
                break
            end
        end

        local docText = line:match("^%s*%-%-%-%s?(.*)$")
        if docText then
            local classDisplay, basesText =
                docText:match("^@class%s+(%S+)%s*:?[ \t]*(.*)$")
            local aliasDisplay, aliasDefinition =
                docText:match("^@alias%s+(%S+)%s+(.+)$")
            local fieldRest = docText:match("^@field%s+(.+)$")
            if classDisplay then
                local className = baseTypeName(classDisplay)
                local definition = {
                    name = className,
                    display = classDisplay,
                    bases = splitList(basesText),
                    desc = parseDocBlock(pending).desc,
                    fields = {},
                    fieldOrder = {},
                }
                page.types[#page.types + 1] = definition
                page.typeByName[className] = definition
                currentType = definition
                if className:lower() == sourceName:lower() then
                    page.name = className
                    page.primaryClass = className
                    page.extends = definition.bases
                end
                pending = {}
            elseif aliasDisplay then
                local aliasName = baseTypeName(aliasDisplay)
                local definition = {
                    name = aliasName,
                    display = aliasDisplay,
                    definition = trim(aliasDefinition),
                    desc = parseDocBlock(pending).desc,
                }
                page.aliases[#page.aliases + 1] = definition
                page.aliasByName[aliasName] = definition
                currentType = nil
                pending = {}
            elseif fieldRest and currentType then
                local first, rest = fieldRest:match("^(%S+)%s+(.+)$")
                local visibility
                if first == "public" or first == "private"
                    or first == "protected" then
                    visibility = first
                    first, rest = rest:match("^(%S+)%s+(.+)$")
                end
                if first and rest then
                    local fieldType, description =
                        splitTypeAndDescription(rest)
                    local optional = first:sub(-1) == "?"
                    if optional then first = first:sub(1, -2) end
                    local field = {
                        name = first,
                        type = fieldType,
                        desc = description,
                        visibility = visibility,
                        optional = optional,
                    }
                    currentType.fields[first] = field
                    currentType.fieldOrder[#currentType.fieldOrder + 1] = field
                end
                pending = {}
            else
                pending[#pending + 1] = docText
            end
            break
        end

        do
            local className, parentName =
                line:match('class%.create%(%s*"([%w_]+)"%s*,?%s*([%w_]*)')
            if className then
                page.name = className
                page.primaryClass = className
                local definition = page.typeByName[className]
                if definition and #definition.bases > 0 then
                    page.extends = definition.bases
                elseif parentName ~= "" then
                    page.extends = { parentName }
                end
                pending = {}
                currentType = nil
                break
            end
        end

        do
            local propName, rest =
                line:match('class%.property%(%s*[%w_]+%s*,%s*"([%w_]+)"%s*,%s*(.*)$')
            if propName then
                local default = rest:match("^([^,%)]*)")
                local trailing = line:match("%)%s*%-%-%s*(.+)$")
                local desc = table.concat(parseDocBlock(pending).desc, " ")
                if #desc == 0 and trailing then desc = trim(trailing) end
                page.props[#page.props + 1] = {
                    name = propName,
                    rawDefault = trim(default),
                    default = describeDefault(default),
                    desc = desc,
                }
                pending = {}
                currentType = nil
                break
            end
        end

        do
            local eventName = line:match('class%.event%(%s*[%w_]+%s*,%s*"([%w_]+)"')
            if eventName then
                page.events[#page.events + 1] = {
                    name = eventName,
                    desc = table.concat(parseDocBlock(pending).desc, " "),
                }
                pending = {}
                currentType = nil
                break
            end
        end

        do
            local owner, sep, methodName, params =
                line:match("^function%s+([%w_]+)([:.])([%w_]+)%s*%(([^%)]*)%)")
            if owner and methodName:sub(1, 1) ~= "_" then
                local doc = parseDocBlock(pending)
                page.methods[#page.methods + 1] = {
                    owner = owner,
                    sep = sep,
                    name = methodName,
                    params = trim(params),
                    doc = doc,
                }
            end
            if trim(line) ~= "" then
                pending = {}
                currentType = nil
            end
        end

        until true
    end

    if not page.primaryClass then
        for _, definition in ipairs(page.types) do
            if definition.name:match("Mixin$") then
                page.primaryClass = definition.name
                page.extends = definition.bases
                break
            end
        end
    end
    if page.primaryClass then
        for _, method in ipairs(page.methods) do
            if method.owner == "methods" then
                method.owner = page.primaryClass
            end
        end
    end
    return page
end

local function buildTypeRegistry(pages)
    local registry = {}
    for _, page in ipairs(pages) do
        for _, definition in ipairs(page.types) do
            definition.page = page
            registry[definition.name] = definition
        end
    end
    return registry
end

local function resolveField(registry, className, fieldName, seen)
    className = baseTypeName(className)
    if not className then return nil end
    seen = seen or {}
    if seen[className] then return nil end
    seen[className] = true
    local definition = registry[className]
    if not definition then return nil end
    if definition.fields[fieldName] then return definition.fields[fieldName] end
    for _, base in ipairs(definition.bases) do
        local field = resolveField(registry, base, fieldName, seen)
        if field then return field end
    end
end

local function inferPropertyType(raw)
    raw = trim(raw or "")
    if raw == "true" or raw == "false" then return "boolean" end
    if raw:match("^colors%.") then return "number" end
    if raw:match('^["\']') then return "string" end
    if tonumber(raw) then return "number" end
    if raw:sub(1, 8) == "function" then return "any" end
    if raw:sub(1, 1) == "{" then return "table" end
    return "any"
end

local function preparePage(page, registry)
    for _, prop in ipairs(page.props) do
        local field = page.primaryClass
            and resolveField(registry, page.primaryClass, prop.name)
        prop.type = field and field.type or inferPropertyType(prop.rawDefault)
    end
end

local function publishedTypes(page)
    local wanted, queue = {}, {}
    local function scan(value)
        for identifier in (value or ""):gmatch("[%a_][%w_%.]*") do
            if not wanted[identifier]
                and (page.typeByName[identifier]
                    or page.aliasByName[identifier]) then
                wanted[identifier] = true
                queue[#queue + 1] = identifier
            end
        end
    end

    for _, base in ipairs(page.extends) do scan(base) end
    for _, prop in ipairs(page.props) do scan(prop.type) end
    for _, method in ipairs(page.methods) do
        scan(method.owner)
        for _, param in ipairs(method.doc.params) do scan(param.type) end
        for _, result in ipairs(method.doc.returns) do scan(result.type) end
    end

    local index = 1
    while index <= #queue do
        local name = queue[index]
        index = index + 1
        local alias = page.aliasByName[name]
        if alias then scan(alias.definition) end
        local definition = page.typeByName[name]
        if definition then
            for _, base in ipairs(definition.bases) do scan(base) end
            for _, field in ipairs(definition.fieldOrder) do
                if field.visibility ~= "private"
                    and field.visibility ~= "protected"
                    and field.name:sub(1, 1) ~= "_" then
                    scan(field.type)
                end
            end
        end
    end
    if page.primaryClass then wanted[page.primaryClass] = nil end
    return wanted
end

----------------------------------------------------------------------------
-- markdown output
----------------------------------------------------------------------------

local function esc(s)
    return (s or ""):gsub("|", "\\|")
end

local function inlineCode(s)
    return "`" .. (s or ""):gsub("`", "\\`") .. "`"
end

local function renderPage(page, category)
    local out = {}
    local function w(s) out[#out + 1] = s end

    w("# " .. page.name)
    w("")
    if #page.extends > 0 then
        w("*extends " .. table.concat(page.extends, ", ") .. "*")
        w("")
    end
    if #page.header > 0 then
        w(table.concat(page.header, "\n"))
        w("")
    end

    local visibleTypes = publishedTypes(page)
    local hasTypes = false
    for name in pairs(visibleTypes) do
        if page.typeByName[name] or page.aliasByName[name] then
            hasTypes = true
            break
        end
    end
    if hasTypes then
        w("## Types")
        w("")
        for _, alias in ipairs(page.aliases) do
            if visibleTypes[alias.name] then
                w("### " .. inlineCode(alias.display))
                w("")
                if #alias.desc > 0 then
                    w(table.concat(alias.desc, "\n"))
                    w("")
                end
                w("```lua")
                w(alias.display .. " = " .. alias.definition)
                w("```")
                w("")
            end
        end
        for _, definition in ipairs(page.types) do
            if visibleTypes[definition.name] then
                w("### " .. inlineCode(definition.display))
                w("")
                if #definition.bases > 0 then
                    w("*extends " .. table.concat(definition.bases, ", ") .. "*")
                    w("")
                end
                if #definition.desc > 0 then
                    w(table.concat(definition.desc, "\n"))
                    w("")
                end
                local publicFields = {}
                for _, field in ipairs(definition.fieldOrder) do
                    if field.visibility ~= "private"
                        and field.visibility ~= "protected"
                        and field.name:sub(1, 1) ~= "_" then
                        publicFields[#publicFields + 1] = field
                    end
                end
                if #publicFields > 0 then
                    w("| Field | Type | Description |")
                    w("| --- | --- | --- |")
                    for _, field in ipairs(publicFields) do
                        local suffix = field.optional and " *(optional)*" or ""
                        w("| " .. esc(field.name) .. suffix .. " | `"
                            .. esc(field.type) .. "` | "
                            .. esc(field.desc) .. " |")
                    end
                    w("")
                end
            end
        end
    end

    if #page.props > 0 then
        w("## Properties")
        w("")
        w("| Property | Type | Default | Description |")
        w("| --- | --- | --- | --- |")
        for _, prop in ipairs(page.props) do
            w("| " .. prop.name .. " | `" .. esc(prop.type) .. "` | "
                .. esc(prop.default)
                .. " | " .. esc(prop.desc) .. " |")
        end
        w("")
    end

    if #page.events > 0 then
        w("## Events")
        w("")
        w("| Event | Registrar | Description |")
        w("| --- | --- | --- |")
        for _, event in ipairs(page.events) do
            local registrar = "on" .. event.name:sub(1, 1):upper()
                .. event.name:sub(2)
            w("| " .. event.name .. " | :" .. registrar .. "(fn) | "
                .. esc(event.desc) .. " |")
        end
        w("")
    end

    if #page.methods > 0 then
        w("## Methods")
        w("")
        for _, method in ipairs(page.methods) do
            w("### " .. method.owner .. method.sep .. method.name
                .. "(" .. method.params .. ")")
            w("")
            if #method.doc.desc > 0 then
                w(table.concat(method.doc.desc, "\n"))
                w("")
            end
            if #method.doc.params > 0 then
                for _, param in ipairs(method.doc.params) do
                    local optional = param.optional and ", optional" or ""
                    w("- **" .. param.name .. "** (`" .. param.type
                        .. "`" .. optional .. ") "
                        .. param.desc)
                end
                w("")
            end
            if #method.doc.returns > 0 then
                for _, ret in ipairs(method.doc.returns) do
                    local name = ret.name and " **" .. ret.name .. "**" or ""
                    w("- **returns**" .. name .. " (`" .. ret.type .. "`) "
                        .. ret.desc)
                end
                w("")
            end
            if #method.doc.usage > 0 then
                w("```lua")
                w(table.concat(method.doc.usage, "\n"))
                w("```")
                w("")
            end
        end
    end

    return table.concat(out, "\n")
end

----------------------------------------------------------------------------
-- run
----------------------------------------------------------------------------

local categories = {
    { folder = "", label = "Runtime", files = { "main" } },
    { folder = "core", label = "Core" },
    { folder = "elements", label = "Elements" },
    { folder = "modules", label = "Modules" },
}

local records = {}
for _, category in ipairs(categories) do
    local names = category.files
    if not names then
        names = {}
        local dir = fs.combine(srcDir, category.folder)
        local entries = fs.list(dir)
        table.sort(entries)
        for _, file in ipairs(entries) do
            local moduleName = file:match("^(.+)%.lua$")
            if moduleName then names[#names + 1] = moduleName end
        end
    end

    for _, moduleName in ipairs(names) do
        local sourcePath = fs.combine(srcDir,
            fs.combine(category.folder, moduleName .. ".lua"))
        local page = parseFile(sourcePath)
        local outRel = fs.combine(category.folder, page.name .. ".md")
        records[#records + 1] = {
            category = category,
            moduleName = moduleName,
            page = page,
            outRel = outRel,
        }
    end
end

local pages = {}
for _, record in ipairs(records) do pages[#pages + 1] = record.page end
local registry = buildTypeRegistry(pages)
for _, page in ipairs(pages) do preparePage(page, registry) end

local index = {}
local seenPaths = {}
local missingDescriptions = 0
for _, category in ipairs(categories) do
    index[#index + 1] = "## " .. category.label
    index[#index + 1] = ""
    for _, record in ipairs(records) do
        if record.category == category then
            local key = record.outRel:lower()
            if seenPaths[key] then
                error("docgen: duplicate output path " .. record.outRel, 0)
            end
            seenPaths[key] = true
            record.content = renderPage(record.page, category.label)
            if record.content == "" then
                error("docgen: rendered empty page for "
                    .. record.moduleName, 0)
            end
            for _, prop in ipairs(record.page.props) do
                if prop.desc == "" then
                    missingDescriptions = missingDescriptions + 1
                end
            end
            for _, event in ipairs(record.page.events) do
                if event.desc == "" then
                    missingDescriptions = missingDescriptions + 1
                end
            end
            index[#index + 1] = "- [" .. record.page.name .. "]("
                .. record.outRel:gsub("\\", "/") .. ")"
        end
    end
    index[#index + 1] = ""
end

local indexContent = "# Basalt API documentation\n\n"
    .. "Generated by docgen.lua - do not edit, edit the src/ comments.\n\n"
    .. table.concat(index, "\n")

local function writeFile(path, content)
    local directory = fs.getDir(path)
    if directory ~= "" and not fs.exists(directory) then
        fs.makeDir(directory)
    end
    local handle = fs.open(path, "w")
    if not handle then error("docgen: cannot write " .. path, 0) end
    handle.write(content)
    handle.close()
end

if checkOnly then
    print(("docs valid: %d pages, %d undocumented properties/events")
        :format(#records, missingDescriptions))
else
    for _, record in ipairs(records) do
        writeFile(fs.combine(outDir, record.outRel), record.content)
    end
    writeFile(fs.combine(outDir, "README.md"), indexContent)
    print(("docs generated: %d pages -> %s (%d undocumented properties/events)")
        :format(#records, outDir, missingDescriptions))
end

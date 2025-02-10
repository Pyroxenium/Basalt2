local config
local basalt = {}
local data = {}
local loaded = {}
local baseRequire = require
_ENV.require = function(path)
    if(data[path]~=nil)then
        if(loaded[path]==nil)then
            loaded[path] = load(data[path], nil, "t", _ENV)()
        end
        return loaded[path]
    end
    if(data["libraries/"..path]~=nil)then
        if(loaded["libraries/"..path]==nil)then
            loaded["libraries/"..path] = load(data["libraries/"..path], nil, "t", _ENV)()
        end
        return loaded["libraries/"..path]
    end
    if(data["elements/"..path]~=nil)then
        if(loaded["elements/"..path]==nil)then
            loaded["elements/"..path] = load(data["elements/"..path], nil, "t", _ENV)()
        end
        return loaded["elements/"..path]
    end
    if(data["extensions/"..path]~=nil)then
        if(loaded["extensions/"..path]==nil)then
            loaded["extensions/"..path] = load(data["extensions/"..path], nil, "t", _ENV)()
        end
        return loaded["extensions/"..path]
    end
    return baseRequire(path)
end

local function getConfig()
    if(config==nil)then
        local github = settings.get("basalt.github") or "https://raw.githubusercontent.com/Pyroxenium/Basalt/basalt2/"
        if(github~=nil)then
            local url = github.."config.json"
            local response = http.get(url)
            if(response==nil)then
                error("Couldn't get the config file from github!")
            end
            config = textutils.unserializeJSON(response.readAll())
            response.close()
            return config
        else
            error("Couldn't find the github path in the settings basalt.github!")
        end
    end
    return config
end

local files = getConfig().versions
local webAccess = {}
for k,v in pairs(files)do
    if(k~="elements")and(k~="libraries")and(k~="extensions")then
        webAccess[k] = v[2]
    end
    if(k=="libraries")then
        for k,v in pairs(v)do
            webAccess["libraries/"..k] = v[2]
        end
    end
    if(k=="elements")then
        for k,v in pairs(v)do
            if(k=="BasicElement")or(k=="VisualElement")or(k=="Container")or(k=="BaseFrame")then
                webAccess["elements/"..k] = v[2]
            end
        end
    end
end

print("Loading the core files from github...")
local parallelAccess = {}
for k,v in pairs(webAccess)do
    table.insert(parallelAccess, function()
    local url = v
    local response = http.get(url)
    if(response==nil)then
        error("Couldn't get the file "..k.." from github!")
    end
    local webData = response.readAll()
    print("Loaded "..k.."!")
    data[k] = webData
    end)
end
parallel.waitForAll(unpack(parallelAccess))

basalt = load(data["main"], nil, "t", _ENV)()

return basalt
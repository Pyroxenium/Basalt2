-- Shared text helpers (word wrapping for Label, Dialog, Toast, ...).

local textutil = {}

--- Greedy word wrap; long words are hard-broken. Blank lines are kept.
function textutil.wrap(str, width)
    width = math.max(1, width)
    local lines = {}
    for paragraph in (tostring(str) .. "\n"):gmatch("(.-)\n") do
        local line = ""
        for word in paragraph:gmatch("%S+") do
            if #line == 0 then
                line = word
            elseif #line + 1 + #word <= width then
                line = line .. " " .. word
            else
                lines[#lines + 1] = line
                line = word
            end
            while #line > width do -- hard-break oversized words
                lines[#lines + 1] = line:sub(1, width)
                line = line:sub(width + 1)
            end
        end
        lines[#lines + 1] = line
    end
    if #lines > 1 and lines[#lines] == "" then
        table.remove(lines) -- trailing newline artifact
    end
    if #lines == 0 then lines = { "" } end
    return lines
end

return textutil

local Csv = {}

local s_gmatch = string.gmatch
local s_match = string.match
local tonumber = tonumber

local function parseValue(v)
    if v == "true" or v == "TRUE" then
        v = true
    elseif v == "false" or v == "FALSE" then
        v = false
    else
        v = tonumber(v) or v or ""
    end
    return v
end

function Csv.readLine(line)
    local row = {}
    for v in s_gmatch(line, "%s*([^,]-)%s*,") do
        row[#row+1] = parseValue(v)
    end
    row[#row+1] = parseValue(s_match(line, "%s*([^,]-)%s*$"))
    return row
end
local readLine = Csv.readLine

function Csv.load(filename)
    local rows = {}
    for line in love.filesystem.lines(filename) do
        rows[#rows+1] = readLine(line)
    end
    return rows
end

return Csv
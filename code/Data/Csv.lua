local Tiled = require "Data.Tiled"

local Csv = {}

local function parseValue(v)
    if v == "true" or v == "TRUE" then
        v = true
    elseif v == "false" or v == "FALSE" then
        v = false
    else
        local tileset, tile = v:match("^tile/(%w+)/(%w+)$")
        tileset = tileset and Tiled.tilesets[tileset]
        tile = tileset and tileset[tile]
        v = tile or tonumber(v) or v or ""
    end
    return v
end

function Csv.load(filename)
    local rows = {}
    for line in love.filesystem.lines(filename) do
        local row = {}
        for v in line:gmatch("%s*([^,]-)%s*,") do
            row[#row+1] = parseValue(v)
        end
        row[#row+1] = parseValue(line:match("%s*([^,]-)%s*$"))
        rows[#rows+1] = row
    end
    return rows
end

return Csv
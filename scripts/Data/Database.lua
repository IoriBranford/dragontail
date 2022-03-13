local Database = {}
local Audio = require "System.Audio"
local Csv   = require "Data.Csv"
local type = type

local database = {}

function Database.load(csvfilename)
    local loadedrows = Csv.load(csvfilename)
    local fieldnames = loadedrows[1]
    for i = 1, #fieldnames do
        fieldnames[i] = fieldnames[i]:match("^([_A-Za-z]+)")
    end
    for i = 2, #loadedrows do
        local row = loadedrows[i]
        local key = row[1]
        loadedrows[key] = row
        for i = #row, 1, -1 do
            if row[i] ~= "" then
                row[fieldnames[i]] = row[i]
            end
            row[i] = nil
        end
        local existingrow = database[key]
        if existingrow then
            for k,v in pairs(row) do
                existingrow[k] = v
            end
        else
            database[key] = row
        end
    end
    for i = #loadedrows, 1, -1 do
        loadedrows[i] = nil
    end
    return loadedrows
end

function Database.get(key)
    return database[key]
end

function Database.clear()
    database = {}
end

local function set(unit, k, v)
    local var = type(v) == "string" and v:match("^%$(.+)$")
    unit[k] = var and unit[var] or v ~= "nil" and v or nil
end

function Database.fillBlanks(unit, key)
    local row = type(key) == "table" and key or database[key]
    if row then
        for k,v in pairs(row) do
            if unit[k] == nil then
                set(unit, k, v)
            end
        end
    end
end

function Database.fill(unit, key)
    local row = type(key) == "table" and key or database[key]
    if row then
        for k,v in pairs(row) do
            set(unit, k, v)
        end

        local think = unit[row.think]
        if type(think) == "function" then
            unit.think = think
        end

        Audio.play(unit.typesound)
    end
end

function Database.forEach(func)
    for name, properties in pairs(database) do
        func(name, properties)
    end
end

return Database
local Database = {}
local Csv   = require "Data.Csv"
local Tiled = require "Tiled"
local type = type
local pairs = pairs

local database = {}
local tables = {}

function Database.add(key, row, overwrite)
    local existingrow = database[key]
    if existingrow then
        local mt = getmetatable(row)
        if overwrite then
            for k,v in pairs(row) do
                existingrow[k] = v
            end
            if mt then
                setmetatable(existingrow, mt)
            end
        else
            for k,v in pairs(row) do
                if existingrow[k] == nil then
                    existingrow[k] = v
                end
            end
            if mt and not getmetatable(existingrow) then
                setmetatable(existingrow, mt)
            end
        end
        return existingrow
    else
        database[key] = row
        return row
    end
end
local add = Database.add

function Database.addArray(keyfield, rows, overwrite)
    for i = 1, #rows do
        local row = rows[i]
        add(row[keyfield], row, overwrite)
    end
end
local addArray = Database.addArray

function Database.addHash(keyfield, hash, overwrite)
    for _, row in pairs(hash) do
        add(row[keyfield], row, overwrite)
    end
end
local addHash = Database.addHash

function Database.addMapObjectGroup(objectgroup, overwrite)
    for i = 1, #objectgroup do
        local object = objectgroup[i]
        object.id = nil
        Database.fillBlanks(object, object.type)
    end
    addArray("name", objectgroup, overwrite)
end

function Database.addMapObjects(mapobjects, overwrite)
    for _, object in pairs(mapobjects) do
        object.id = nil
        Database.fillBlanks(object, object.type)
    end
    addHash("name", mapobjects, overwrite)
end

function Database.loadMapObjects(mapfilename, overwrite)
    local map = Tiled.Map.load(mapfilename)
    map:indexEverythingByName()
    Database.addMapObjects(map.objects, overwrite)
end

function Database.load(csvfilename, overwrite)
    local loadedrows = Csv.load(csvfilename)
    local fieldnames = loadedrows[1]
    for i = 1, #fieldnames do
        fieldnames[i] = fieldnames[i]:match("^([_A-Za-z]+)")
    end
    for r = 2, #loadedrows do
        local row = loadedrows[r]
        local key = row[1]
        for c = #row, 1, -1 do
            local field = fieldnames[c]
            if field then
                if row[c] ~= "" then
                    row[field] = row[c]
                end
            else
                print(string.format("%s no field name for data at %d,%d", csvfilename, c, r))
            end
            row[c] = nil
        end
        loadedrows[key] = add(key, row, overwrite)
    end
    for i = #loadedrows, 1, -1 do
        loadedrows[i] = nil
    end
    tables[csvfilename] = loadedrows
    return loadedrows
end

function Database.get(key)
    return database[key]
end

function Database.getTable(csvfilename)
    return tables[csvfilename] or Database.load(csvfilename)
end

function Database.clear()
    database = {}
    tables = {}
end

local function set(unit, k, v)
    local var = type(v) == "string" and v:match("^%$(.+)$")
    if var then
        unit[k] = unit[var]
    elseif v == "nil" then
        unit[k] = nil
    else
        unit[k] = v
    end
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
    end
end

function Database.forEach(func)
    for name, properties in pairs(database) do
        func(name, properties)
    end
end

return Database
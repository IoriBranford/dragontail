local Database = {}
local Audio = require "System.Audio"
local Csv   = require "Data.Csv"
local type = type

local sheets = {}

function Database.load(csvfilename)
    local loaded = Csv.load(csvfilename)
    local fieldnames = loaded[1]
    for i = 1, #fieldnames do
        fieldnames[i] = fieldnames[i]:match("^([_A-Za-z]+)")
    end
    for i = 2, #loaded do
        local t = loaded[i]
        local typename = t[1]
        sheets[typename] = t
        loaded[typename] = t
        for i = #t, 1, -1 do
            if t[i] ~= "" then
                t[fieldnames[i]] = t[i]
            end
            t[i] = nil
        end
    end
    for i = #loaded, 1, -1 do
        loaded[i] = nil
    end
    return loaded
end

function Database.get(key)
    return sheets[key]
end

function Database.clear()
    sheets = {}
end

local function set(unit, k, v)
    local var = type(v) == "string" and v:match("^%$(.+)$")
    unit[k] = var and unit[var] or v ~= "nil" and v or nil
end

function Database.fillBlanks(unit, key)
    local sheet = type(key) == "table" and key or sheets[key]
    if sheet then
        for k,v in pairs(sheet) do
            if unit[k] == nil then
                set(unit, k, v)
            end
        end
    end
end

function Database.fill(unit, key)
    local sheet = type(key) == "table" and key or sheets[key]
    if sheet then
        for k,v in pairs(sheet) do
            set(unit, k, v)
        end

        local think = unit[sheet.think]
        if type(think) == "function" then
            unit.think = think
        end

        Audio.play(unit.typesound)
    end
end

function Database.forEach(func)
    for name, properties in pairs(sheets) do
        func(name, properties)
    end
end

return Database
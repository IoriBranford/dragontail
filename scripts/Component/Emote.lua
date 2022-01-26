local Prefabs = require "Data.Prefabs"
local Units   = require "System.Units"

local Emote = {}

function Emote.set(unit, emote)
    local emoteunit = unit.emoteunit
    if emoteunit then
        Units.remove(emoteunit)
        unit.emoteunit = nil
    end
    if emote then
        local prefab = Prefabs.get(emote)
        if prefab then
            unit.emoteunit = Units.newUnit(prefab)
            Emote.think(unit)
        end
    end
end

function Emote.think(unit)
    local emoteunit = unit.emoteunit
    if emoteunit then
        local emotex, emotey = unit.x, unit.y
        local tile = unit.tile
        if tile then
            emotey = emotey - tile.objectoriginy
        else
            local width = unit.width or 0
            emotex = emotex + width/2
        end
        emoteunit.x, emoteunit.y = emotex, emotey
        emoteunit.velx, emoteunit.vely = unit.velx, unit.vely
    end
end

return Emote
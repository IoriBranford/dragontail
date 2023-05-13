local class = require "Tiled.class"

---@class AnimationFrame
---@field duration number Converted to Tiled.animationtimeunit
---@field tile Tile
---@field tileid integer The local ID of a tile within the parent <tileset>.

---@class Animation
---@field duration number Total duration, in Tiled.animationtimeunit
---@field [integer] AnimationFrame
local Animation = class()

function Animation:_init(tileset)
    local animationtimescale = 60/1000--AnimationTimeUnits[Assets.animationtimeunit] or 1
    local totalduration = 0
    for f = 1, #self do
        local frame = self[f]
        local duration = frame.duration
        totalduration = totalduration + duration
        frame.duration = duration * animationtimescale
        frame.tile = tileset[frame.tileid]
    end
    self.duration = totalduration * animationtimescale
    return self
end

function Animation:isFinished(i, t)
    local duration = self[i].duration
    while t >= duration do
        t = t - duration
        i = i + 1
        if i > #self then
            return true
        end
        duration = self[i].duration
    end
end

function Animation:getUpdate(i, t)
    local duration = self[i].duration
    while t >= duration do
        t = t - duration
        i = (i >= #self) and 1 or (i + 1)
        duration = self[i].duration
    end
    return i, t
end

return Animation
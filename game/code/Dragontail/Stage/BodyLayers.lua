local Body = require "Dragontail.Character.Component.Body"
local CollisionMask = require "Dragontail.Character.Component.Body.CollisionMask"
local ihash         = require "ihash"

---@class BodyLayers
local BodyLayers = {} ---@type Body[][]

function BodyLayers:clear()
    BodyLayers = {}
end

function BodyLayers:eachLayer(mask, only)
    local i = 0
    local function iter()
        if mask == 0 then return end

        i = i + 1
        if i > #self then return end

        local bt = bit.band(mask, 1) ~= 0
        mask = bit.rshift(mask, 1)
        return i, self[i], bt
    end
    if only then
        return function()
            while i <= #self
            and bit.band(mask, 1) ~= only do
                mask = bit.rshift(mask, 1)
                i = i + 1
            end
            return iter()
        end
    end
    return iter
end

function BodyLayers:update(solids)
    local masks = CollisionMask.getKnownMasks()
    while #self < #masks do
        self[#self+1] = {}
    end
    for i = 1, #solids do local solid = solids[i]
        local mask = solid.bodyinlayers or 0
        for _, layer, bt in self:eachLayer(mask) do
            if bt then
                ihash.add(layer, solid)
            else
                ihash.remove(layer, solid)
            end
        end
    end
end

function BodyLayers:prune(dead)
    for _, layer in ipairs(self) do
        ihash.prune(layer, dead)
    end
end

return BodyLayers
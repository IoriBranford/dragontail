local Raycast = require "Object.Raycast"

---@module 'Dragontail.Stage.Boundaries'
local Boundaries = {}

local boundaries = {} ---@type {[any]: Boundary}

function Boundaries.get(k)
    return boundaries[k]
end

function Boundaries.getAll()
    return boundaries
end

function Boundaries.put(k, bound)
    boundaries[k] = bound
end

function Boundaries.clear()
    for k in pairs(boundaries) do
        boundaries[k] = nil
    end
end

function Boundaries.castRay(raycast, rx, ry)
    raycast.hitdist = nil
    local hitsomething
    local rdx, rdy = raycast.rdx, raycast.rdy
    for _, bound in pairs(boundaries) do
        if bound:castRay(raycast, rx, ry) then
            raycast.rdx, raycast.rdy = raycast.hitx - rx, raycast.hity - ry
            hitsomething = true
        end
    end
    raycast.rdx, raycast.rdy = rdx, rdy
    return hitsomething
end

function Boundaries.keepCircleIn(x, y, r)
    local totalpenex, totalpeney, penex, peney
    for _, bounds in pairs(boundaries) do
        x, y, penex, peney = bounds:keepCircleInside(x, y, r)
        if penex then
            totalpenex = (totalpenex or 0) + penex
        end
        if peney then
            totalpeney = (totalpeney or 0) + peney
        end
    end
    return x, y, totalpenex, totalpeney
end

return Boundaries
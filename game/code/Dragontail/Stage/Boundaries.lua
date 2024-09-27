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

function Boundaries.putArray(array, scene)
    if not array then return end
    for _, bounds in ipairs(array) do
        Boundaries.put(bounds.id, bounds)
    end
    if scene then
        for _, boundary in ipairs(array) do
            scene:add(boundary)
        end
    end
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
        penex, peney = bounds:getCirclePenetration(x, y, r)
        if penex then
            x = x - penex
            totalpenex = (totalpenex or 0) + penex
        end
        if peney then
            y = y - peney
            totalpeney = (totalpeney or 0) + peney
        end
    end
    return x, y, totalpenex, totalpeney
end

function Boundaries.keepCylinderIn(x, y, z, r, h)
    local totalpenex, totalpeney, totalpenez, penex, peney, penez
    for _, bounds in pairs(boundaries) do
        penex, peney, penez = bounds:getCylinderPenetration(x, y, z, r, h)
        if penex then
            x = x - penex
            totalpenex = (totalpenex or 0) + penex
        end
        if peney then
            y = y - peney
            totalpeney = (totalpeney or 0) + peney
        end
        if penez then
            z = z - penez
            totalpenez = (totalpenez or 0) + penez
        end
    end
    return x, y, z, totalpenex, totalpeney, totalpenez
end

function Boundaries.getCylinderFloorZ(x, y, z, r, h)
    local floorz
    for _, bounds in pairs(boundaries) do
        local fz = bounds:getCylinderFloorZ(x, y, z, r, h)
        if fz then
            floorz = math.max(floorz or fz, fz)
        end
    end
    return floorz
end

function Boundaries.draw()
    for _, boundary in pairs(boundaries) do
        boundary:draw()
    end
end

return Boundaries
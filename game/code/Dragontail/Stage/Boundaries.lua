
---@module 'Dragontail.Stage.Boundaries'
local Boundaries = {}

local boundaries = {} ---@type {[any]: Boundary}

function Boundaries.get(k)
    return boundaries[k]
end

function Boundaries.put(k, bound)
    boundaries[k] = bound
end

function Boundaries.clear()
    for k in pairs(boundaries) do
        boundaries[k] = nil
    end
end

---@return RayHit
function Boundaries.castRay(rx0, ry0, rx1, ry1, hit)
    if hit then
        hit.hitdist = nil
    end
    for _, bound in pairs(boundaries) do
        hit = bound:castRay(rx0, ry0, rx1, ry1, hit)
        if hit then
            rx1, ry1 = hit.hitx, hit.hity
        end
    end
    return hit
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
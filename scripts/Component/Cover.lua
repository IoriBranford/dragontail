local Cover = {}

local covergrid

function Cover.setGrid(grid)
    covergrid = grid
end

function Cover.think_beforeCollisions(unit)
    unit.cover = 0
    if not unit.takescover then
        return
    end
    if not covergrid then
        return
    end
    local x, y, w, h = unit.x - 1, unit.y - 1, 2, 2
    for c, r, iscover in covergrid:cellsTouchingRect(x, y, w, h) do
        if iscover then
            unit.cover = 1
            break
        end
    end
end

function Cover.isInCover(unit, other)
    return unit.cover and unit.cover > 0
        and not (other and other.ignorecover)
end

function Cover.onCollision_takeCover(unit, other)
    if not unit.takescover then
        return
    end
    if other and other.iscover then
        unit.cover = unit.cover + 1
    end
end

function Cover.draw(x, y)
    if covergrid then
        covergrid:draw(x, y)
    end
end

function Cover.changeColor(unit, r, g, b)
    if Cover.isInCover(unit) then
        r = r/2
        g = g/2
        b = b/2
    end
    return r, g, b
end

return Cover
local Movement = require "Component.Movement"

local function RoseHitEnemy(scenemap, menu)
    local layers = scenemap.layers
    local fg = layers.fg
    local directions = layers.directions
    layers.logo.visible = false
    fg.visible = true
    assert(directions and directions.type == "objectgroup")
    ---@cast directions ObjectGroup

    local path = assert(directions.path)
    local pts = assert(path.points)
    local x, y, i = math2.walkpolyline(pts)
    local xn, yn = pts[#pts-1], pts[#pts]
    fg.x, fg.y = math2.vadd(fg.x, fg.y, x - xn, y - yn)
    repeat
        coroutine.yield("fgmoving")
        local x2, y2
        x2, y2, i = math2.walkpolyline(pts, x, y, i, 50)
        fg.x, fg.y = math2.vadd(fg.x, fg.y, x2 - x, y2 - y)
        x, y = x2, y2
    until x == xn and y == yn

    local menux, menuy = menu.x, menu.y
    menu:setVisible(true)
    for a = 50, 0, -1 do
        local shx, shy = Movement.impactShake(
            math.rad(200), a, 100, love.timer.getTime())
        menu.x = menux + shx
        menu.y = menuy + shy
        coroutine.yield("menushaking")
    end
    menu.x = menux
    menu.y = menuy

    return "done"
end

return RoseHitEnemy
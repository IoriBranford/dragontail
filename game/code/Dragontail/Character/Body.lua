local Movement   = require "Component.Movement"

---@class Body:TiledObject
---@field z number
---@field velx number
---@field vely number
---@field velz number
---@field speed number
---@field bodysolid boolean
---@field bodyheight number
---@field bodyradius number
---@field gravity number
local Body = {}

function Body:init()
    self.x = self.x or 0
    self.y = self.y or 0
    self.z = self.z or 0
    self.velx = self.velx or 0
    self.vely = self.vely or 0
    self.velz = self.velz or 0
    self.speed = self.speed or 1
    self.bodyheight = self.bodyheight or 1
    self.bodyradius = self.bodyradius or 1
    self.gravity = self.gravity or 0

    if self.points then
        local _, rsq = math.farthestpoint(self.points, 0, 0)
        assert(#self.points >= 6, self.id)
        self.bodyradius = math.sqrt(rsq)
        self.points.outward = math.polysignedarea(self.points) < 0
    elseif self.tile then
        self.spriteoriginx = self.spriteoriginx or self.tile.objectoriginx
        self.spriteoriginy = self.spriteoriginy or self.tile.objectoriginy
        local shapes = self.tile.shapes
        if shapes then
            for _, shape in ipairs(shapes) do
                if shape.shape == "polygon" and shape.collidable then
                    Body.initPolygonBody(self, shape.points, shape.x, shape.y)
                    break
                end
            end
        end
    end
end

---@param points number[]
---@param dx number
---@param dy number
function Body:initPolygonBody(points, dx, dy)
    dx = dx or 0
    dy = dy or 0
    local _, rsq = math.farthestpoint(points, -dx, -dy)
    self.bodyradius = math.sqrt(rsq)
    self.points = {}
    self.points.outward = math.polysignedarea(points) < 0
    assert(#points >= 6, self.id)
    for i = 2, #points, 2 do
        local px, py = points[i-1], points[i]
        self.points[i-1] = px + dx
        self.points[i] = py + dy
    end
end

function Body:accelerate(ax, ay)
    self.velx = self.velx + ax
    self.vely = self.vely + ay
end

function Body:accelerateTowardsVel(targetvelx, targetvely, t, e)
    assert(t > 0, "t <= 0")
    e = e or (1/256)
    local accelx = (targetvelx - self.velx) / t
    local accely = (targetvely - self.vely) / t
    if math.abs(accelx) < e then
        self.velx = targetvelx
    else
        self.velx = self.velx + accelx
    end
    if math.abs(accely) < e then
        self.vely = targetvely
    else
        self.vely = self.vely + accely
    end
end

function Body:accelerateTowardsVel3(targetvelx, targetvely, targetvelz, t, e)
    t = math.max(t, 1)
    e = e or (1/256)
    local accelx = (targetvelx - self.velx) / t
    local accely = (targetvely - self.vely) / t
    local accelz = (targetvelz - self.velz) / t
    if math.abs(accelx) < e then
        self.velx = targetvelx
    else
        self.velx = self.velx + accelx
    end
    if math.abs(accely) < e then
        self.vely = targetvely
    else
        self.vely = self.vely + accely
    end
    if math.abs(accelz) < e then
        self.velz = targetvelz
    else
        self.velz = self.velz + accelz
    end
end

function Body:updateGravity()
    local gravity = self.gravity or 0
    if gravity == 0 then
        return
    end
    self.velz = self.velz - gravity
    local Characters = require "Dragontail.Stage.Characters"
    local floorz = Characters.getCylinderFloorZ(self.x, self.y, self.z, self.bodyradius, self.bodyheight) or 0
    if floorz >= self.z + self.velz then
        self.z = floorz
        self.velz = 0
    end
end

function Body:updatePosition()
    self.x = self.x + self.velx
    self.y = self.y + self.vely
    self.z = self.z + self.velz
end

function Body:executeMove(destx, desty, speed, timelimit)
    timelimit = timelimit or math.huge
    coroutine.waitfor(function()
        local x, y = self.x, self.y
        timelimit = timelimit - 1
        if timelimit <= 0 or x == destx and y == desty then
            return true
        end
        self.velx, self.vely = Movement.getVelocity_speed(x, y, destx, desty, speed)
    end)
    return self.x == destx and self.y == desty
end

---@deprecated
function Body:keepInBounds()
    local x, y, z, r, h = self.x, self.y, self.z, self.bodyradius, self.bodyheight
    local totalpenex, totalpeney, totalpenez
    local Characters = require "Dragontail.Stage.Characters"
    self.x, self.y, self.z, totalpenex, totalpeney, totalpenez = Characters.keepCylinderIn(x, y, z, r, h, self)
    return totalpenex, totalpeney, totalpenez
end

function Body:getVelocityWithinBounds()
    local x0, y0, z0, r, h = self.x, self.y, self.z, self.bodyradius, self.bodyheight
    local x1 = x0 + self.velx
    local y1 = y0 + self.vely
    local z1 = z0 + self.velz
    local totalpenex, totalpeney, totalpenez
    local Characters = require "Dragontail.Stage.Characters"
    x1, y1, z1, totalpenex, totalpeney, totalpenez = Characters.keepCylinderIn(x1, y1, z1, r, h, self)
    return x1 - x0, y1 - y0, z1 - z0, totalpenex, totalpeney, totalpenez
end

local function testBodyCollision_polygonAndCircle(polygon, circle)
    local points = polygon.points
    local otherx, othery = circle.x - polygon.x, circle.y - polygon.y
    if math.pointinpolygon(points, otherx, othery) then
        return true
    end
    local nearestx, nearesty = math.nearestpolygonpoint(points, otherx, othery)
    return nearestx and nearesty
        and math.distsq(otherx, othery, nearestx, nearesty) <= circle.bodyradius
end

function Body:testBodyCollision(other)
    if self ~= other
        and self.z <= other.z + other.bodyheight
        and other.z <= self.z + self.bodyheight
        and math.testcircles(self.x, self.y, self.bodyradius, other.x, other.y, other.bodyradius)
    then
        if self.points and not other.points then
            return testBodyCollision_polygonAndCircle(self, other)
        elseif other.points then
            return testBodyCollision_polygonAndCircle(other, self)
        end
        return true
    end
end

function Body:getCirclePenetration(x, y, r)
    local distsq = math.testcircles(self.x, self.y, self.bodyradius, x, y, r)
    if not distsq then
        return
    end

    local points = self.points
    if not points then
        local radii = self.bodyradius + r
        local dist = math.sqrt(distsq)
        local pene = radii - dist
        local dx, dy = self.x - x, self.y - y
        local nx, ny = dx/dist, dy/dist
        return nx*pene, ny*pene
    end

    -- get if point in polygon
    x, y = x - self.x, y - self.y
    local inside = math.pointinpolygon(points, x, y)
    if not points.outward then
        inside = not inside
    end
    -- get nearest point on polygon
    local nearestx, nearesty, nearesti, nearestj = math.nearestpolygonpoint(points, x, y)
    local nearestdsq = nearestx and nearesty and math.distsq(x, y, nearestx, nearesty)
    -- if not in polygon, and nearest point farther than radius, then no collision
    if not inside and (not nearestdsq or nearestdsq > r*r) then
        return
    end

    -- move circle out of polygon in direction of nearest point
    local dist = math.sqrt(nearestdsq)
    local nx, ny
    if dist == 0 then
        local x1, y1 = points[nearesti-1], points[nearesti]
        local x2, y2 = points[nearestj-1], points[nearestj]
        nx, ny = math.norm(math.rot90(x2-x1, y2-y1, 1))
    else
        nx, ny = (nearestx - x)/dist, (nearesty - y)/dist
    end
    local pene = (inside and -r or r) - dist
    return nx * pene, ny * pene

    -- TODO if needed, collision vs concave corners
end

---@return number? penex x penetration. Non-0 = penetrating; 0 = touching; nil = no contact
---@return number? peney y penetration. Non-0 = penetrating; 0 = touching; nil = no contact
---@return number? penez z penetration. Non-0 = penetrating; 0 = touching; nil = no contact
function Body:getCylinderPenetration(x, y, z, r, h)
    local selfz, selfh = self.z, self.bodyheight
    local penex, peney, penez
    local points = self.points
    if not points then
        -- I am a cylinder
        if z + h >= selfz and selfz + selfh >= z then
            local iz, iz2 = math.max(z, selfz), math.min(z+h, selfz+selfh)
            penez = iz == z and iz - iz2 or iz2 - iz
            penex, peney = Body.getCirclePenetration(self, x, y, r)
            if penex and peney and math.lensq(penex, peney) > penez*penez then
                penex, peney = nil, nil
            else
                penez = nil
            end
        end
    elseif points.outward then
        -- I am an outward polygon
        if z + h >= selfz and selfz + selfh >= z then
            local nearestx, nearesty = math.nearestpolygonpoint(points, x - self.x, y - self.y)
            if math.pointinpolygon(points, x - self.x, y - self.y)
            or nearestx and nearesty and math.distsq(nearestx, nearesty, x - self.x, y - self.y) <= r*r then
                local iz, iz2 = math.max(z, selfz), math.min(z+h, selfz+selfh)
                penez = iz == z and iz - iz2 or iz2 - iz
                penex, peney = Body.getCirclePenetration(self, x, y, r)
                if penex and peney and math.lensq(penex, peney) > penez*penez then
                    penex, peney = nil, nil
                else
                    penez = nil
                end
            end
        end
    else
        -- I am an inward polygon
        if z <= selfz then
            penez = z - selfz
        elseif z + h >= selfz + selfh then
            penez = (z + h) - (selfz + selfh)
        end
        penex, peney = Body.getCirclePenetration(self, x, y, r)
    end
    return penex, peney, penez
end

---@param other Body
function Body:collideWith(other)
    if not other.bodysolid then
        return
    end
    local penex, peney, penez = Body.getCylinderPenetration(other, self.x, self.y, self.z, self.bodyradius, self.bodyheight)
    self.x = self.x - (penex or 0)
    self.y = self.y - (peney or 0)
    self.z = self.z - (penez or 0)
    return penex, peney, penez
end

---@param raycast Raycast
function Body:collideWithRaycast(raycast, rx, ry)
    local canhitside = raycast.canhitside
    local selfx, selfy, selfr = self.x, self.y, self.bodyradius
    local rdx, rdy = raycast.dx, raycast.dy
    local rx2, ry2 = rx + rdx, ry + rdy

    local projx, projy = math.projpointsegment(selfx, selfy, rx, ry, rx2, ry2)
    local projdsq = math.distsq(projx, projy, selfx, selfy)
    if projdsq > selfr*selfr then
        return
    end

    local points = self.points
    if not points then
        -- hypot is circle center to intersection point
        -- one side is circle center to proj point
        -- other side is proj point to intersection point
        local rnx, rny = math.norm(rdx, rdy)
        local projtohitdist = math.sqrt(selfr*selfr - projdsq)
        if canhitside < 0 then
            -- hitx,hity is the far intersection
            -- hitwall is a tangent line
            raycast.hitx = projx + rnx * projtohitdist
            raycast.hity = projy + rny * projtohitdist
            raycast.hitside = -1
        else
            -- hitx,hity is the near intersection
            raycast.hitx = projx - rnx * projtohitdist
            raycast.hity = projy - rny * projtohitdist
            raycast.hitside = 1
        end
        raycast.hitdist = math.dist(rx, ry, raycast.hitx, raycast.hity)
        local d = math.det(selfx - rx, selfy - ry, rdx, rdy)
        raycast.hitwallx, raycast.hitwally = math.rot90(raycast.hitx - selfx, raycast.hity - selfy, d)
        raycast.hitwallx2, raycast.hitwally2 = math.rot90(raycast.hitx - selfx, raycast.hity - selfy, -d)
        raycast.hitwallx = raycast.hitwallx + raycast.hitx
        raycast.hitwally = raycast.hitwally + raycast.hity
        raycast.hitwallx2 = raycast.hitwallx2 + raycast.hitx
        raycast.hitwally2 = raycast.hitwally2 + raycast.hity
        return true
    end

    rx, ry = rx - selfx, ry - selfy
    rx2, ry2 = rx2 - selfx, ry2 - selfy
    local hitdsq = raycast.hitdist
    hitdsq = hitdsq and hitdsq*hitdsq or 0x10000000
    local hitx, hity, hitwallx, hitwally, hitwallx2, hitwally2, hitside
    local ax, ay = points[#points-1], points[#points]
    for i = 2, #points, 2 do
        local bx, by = points[i-1], points[i]
        local walldir = math.det(rdx, rdy, bx-ax, by-ay)
        if walldir * canhitside >= 0 then
            local hx, hy, hx2, hy2 = math.intersectsegments(rx, ry, rx2, ry2, ax, ay, bx, by)
            if hx and hy then
                if hx2 and hy2 and math.dot(rdx, rdy, hx2, hy2) < math.dot(rdx, rdy, hx, hy) then
                    hx, hy = hx2, hy2
                end
                local dsq = math.distsq(rx, ry, hx, hy)
                if dsq < hitdsq then
                    hitdsq = dsq
                    hitx, hity = hx, hy
                    hitwallx, hitwally = ax, ay
                    hitwallx2, hitwally2 = bx, by
                    hitside = walldir
                end
            end
        end
        ax, ay = bx, by
    end

    if hitx then
        raycast.hitdist = math.sqrt(hitdsq)
        raycast.hitx = hitx + selfx
        raycast.hity = hity + selfy
        raycast.hitwallx = hitwallx + selfx
        raycast.hitwally = hitwally + selfy
        raycast.hitwallx2 = hitwallx2 + selfx
        raycast.hitwally2 = hitwally2 + selfy
        raycast.hitside = hitside
        return true
    end
end

function Body:getCylinderFloorZ(x, y, z, r, h)
    local floorz = self.z
    local points = self.points
    local outward = not points or points.outward
    if outward then
        floorz = floorz + self.bodyheight
    end
    if z < floorz then
        -- underneath
        return
    end

    if outward and not Body.getCirclePenetration(self, x, y, r) then
        return
    end
    return floorz
end

function Body:draw(fixedfrac)
    fixedfrac = fixedfrac or 0
    local x, y = self.x + self.velx * fixedfrac, self.y + self.vely * fixedfrac
    love.graphics.setColor(.5, .5, 1)
    local bodyradius, bodyheight = self.bodyradius, self.bodyheight
    local screeny = y - self.z
    love.graphics.circle("line", x, screeny, bodyradius)
    love.graphics.circle("line", x, screeny - bodyheight, bodyradius)
    love.graphics.line(x - bodyradius, screeny, x - bodyradius, screeny - bodyheight)
    love.graphics.line(x + bodyradius, screeny, x + bodyradius, screeny - bodyheight)
    local points = self.points
    if points then
        local spriteoriginx, spriteoriginy = self.spriteoriginx or 0, self.spriteoriginy or 0
        love.graphics.push()
        love.graphics.translate(spriteoriginx, spriteoriginy)
        self:drawPolygon()
        love.graphics.translate(0, -bodyheight)
        self:drawPolygon()
        love.graphics.translate(self.x - spriteoriginx, self.y - spriteoriginy)
        for i = 2, #points, 2 do
            local px, py = points[i-1], points[i]
            love.graphics.line(px, py, px, py + bodyheight)
        end
        love.graphics.pop()
    end
end

return Body
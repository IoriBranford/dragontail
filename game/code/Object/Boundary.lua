local Tiled = require "Tiled"

local projpointsegment = math.projpointsegment
local distsq = math.distsq
local sqrt = math.sqrt
local norm = math.norm
local rot90 = math.rot90
local max, min = math.max, math.min
local dot, det = math.dot, math.det
local polysignedarea = math.polysignedarea
local intersectsegments = math.intersectsegments

---@class Boundary:TiledObject
local Boundary = class(Tiled.Object)
Boundary.color = 0
Boundary.linecolor = 0xFFFFFFFF

function Boundary:_init()
    Tiled.Object._init(self)
    self:init()
end

local function forLines(self, r, f)
    r = r or 0
    local points = assert(self.points)
    local cn = self.cornernormals
    local cnx, cny = cn[#points-1], cn[#points]
    local x1, y1 = points[#points-1] + cnx*r, points[#points] + cny*r
    for i = 2, #points, 2 do
        cnx, cny = cn[i-1], cn[i]
        local x2, y2 = points[i-1] + cnx*r, points[i] + cny*r
        f(x1, y1, x2, y2)
        x1, y1 = x2, y2
    end
end

local function getPolygonCornerNormal(hx, hy, ix, iy, jx, jy, sarea)
    local hix, hiy = ix-hx, iy-hy
    local ijx, ijy = jx-ix, jy-iy
    local hipx, hipy = norm(rot90(hix, hiy, 1))
    local ijpx, ijpy = norm(rot90(ijx, ijy, 1))
    local nx, ny = norm(hipx + ijpx, hipy + ijpy)
    local cos = dot(nx, ny, hipx, hipy)
    if cos ~= 0 then
        nx, ny = nx / cos, ny / cos
    end
    return nx, ny
end

function Boundary:init()
    local points = self.points
    assert(points, "Boundary must be a polygon object")

    local sarea = polysignedarea(points)
    self.outward = sarea < 0

    self.z = self.z or 0
    self.bodyheight = self.bodyheight or 512

    local cornernormals = {}
    for i = 1, #points do
        cornernormals[i] = false
    end

    -- Not always the true normal, rather the offset such that a circle of radius 1 will collide correctly
    self.cornernormals = cornernormals

    local x0, y0 = points[#points-3], points[#points-2]
    local x1, y1 = points[#points-1], points[#points]
    local x2, y2 = points[1], points[2]
    local cnx, cny = getPolygonCornerNormal(x0, y0, x1, y1, x2, y2, sarea)
    cornernormals[#points-1], cornernormals[#points] = cnx, cny
    local left, right = x2, x2
    local top, bottom = y2, y2

    for i = 2, #points-2, 2 do
        x0, y0 = x1, y1
        x1, y1 = x2, y2
        x2, y2 = points[i+1], points[i+2]
        left, right = min(left, x2), max(right, x2)
        top, bottom = min(top, y2), max(bottom, y2)
        cnx, cny = getPolygonCornerNormal(x0, y0, x1, y1, x2, y2, sarea)
        cornernormals[i-1], cornernormals[i] = cnx, cny
    end
    self.left, self.right, self.top, self.bottom = left, right, top, bottom

    self.draw = Boundary.draw
end

function Boundary:boundingBox()
    local x, y = self.x, self.y
    return x+self.left, y+self.top, x+self.right, y+self.bottom
end

function Boundary:isCylinderColliding(x, y, z, r, h)
    local selfz, selfh = self.z, self.bodyheight
    if self.outward and (z + h < selfz or selfz + selfh < z)
    or (z + h < selfz + selfh or selfz < z) then
        return false
    end
    return self:isCircleColliding(x, y, r)
end

function Boundary:isCircleColliding(x, y, r)
    x, y = x - self.x, y - self.y
    local colliding = self.outward
    forLines(self, r, function(x1, y1, x2, y2)
        if y > min(y1, y2) then
            if y <= max(y1, y2) then
                if x <= max(x1, x2) then
                    local hitx = (y - y1) * (x2 - x1) / (y2 - y1) + x1;
                    if x1 == x2 or x <= hitx then
                        colliding = not colliding
                    end
                end
            end
        end
    end)
    return colliding
end

function Boundary:getCirclePenetration(x, y, r)
    -- get if point in polygon
    local points = assert(self.points)
    x, y = x - self.x, y - self.y
    local inside = math.pointinpolygon(points, x, y)
    if not self.outward then
        inside = not inside
    end
    -- get nearest point on polygon
    local nearestx, nearesty, nearesti, nearestj = math.nearestpolygonpoint(points, x, y)
    local nearestdsq = distsq(x, y, nearestx, nearesty)
    -- if not in polygon, and nearest point farther than radius, then no collision
    if not inside and nearestdsq > r*r then
        return
    end

    -- move circle out of polygon in direction of nearest point
    local dist = sqrt(nearestdsq)
    local nx, ny
    if dist == 0 then
        local x1, y1 = points[nearesti-1], points[nearesti]
        local x2, y2 = points[nearestj-1], points[nearestj]
        nx, ny = norm(rot90(x2-x1, y2-y1, 1))
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
function Boundary:getCylinderPenetration(x, y, z, r, h)
    local selfz, selfh = self.z, self.bodyheight
    local penex, peney, penez
    if self.outward then
        if z + h >= selfz and selfz + selfh >= z then
            local nearestx, nearesty = math.nearestpolygonpoint(self.points, x - self.x, y - self.y)
            if math.pointinpolygon(self.points, x - self.x, y - self.y)
            or distsq(nearestx, nearesty, x - self.x, y - self.y) <= r*r then
                local iz, iz2 = max(z, selfz), min(z+h, selfz+selfh)
                penez = iz == z and iz - iz2 or iz2 - iz
                penex, peney = self:getCirclePenetration(x, y, r)
                if penex and peney and math.lensq(penex, peney) <= penez*penez then
                    penez = nil
                else
                    penex, peney = nil, nil
                end
            end
        end
    else
        if z <= selfz then
            penez = z - selfz
        elseif z + h >= selfz + selfh then
            penez = (z + h) - (selfz + selfh)
        end
        penex, peney = self:getCirclePenetration(x, y, r)
    end
    return penex, peney, penez
end

function Boundary:getCylinderFloorZ(x, y, z, r, h)
    local floorz = self.z
    if self.outward then
        floorz = floorz + self.bodyheight
    end
    if z < floorz then
        -- underneath
        return
    end

    x, y = x - self.x, y - self.y
    local points = assert(self.points)
    local nearestx, nearesty = math.nearestpolygonpoint(points, x, y)
    if not math.pointinpolygon(points, x, y)
    and distsq(nearestx, nearesty, x, y) > r*r then
        -- off edge
        return
    end
    return floorz
end

---@param raycast Raycast
function Boundary:castRay(raycast, rx, ry)
    local points = self.points
    if not points then return end

    local canhitside = raycast.canhitside
    local selfx, selfy = self.x, self.y
    rx, ry = rx - selfx, ry - selfy
    local rdx, rdy = raycast.dx, raycast.dy
    local rx2, ry2 = rx + rdx, ry + rdy
    local r = raycast.radius
    local hitdsq = raycast.hitdist
    hitdsq = hitdsq and hitdsq*hitdsq or 0x10000000
    local hitx, hity, hitwallx, hitwally, hitwallx2, hitwally2, hitside
    forLines(self, r, function(ax, ay, bx, by)
        local walldir = det(rdx, rdy, bx-ax, by-ay)
        if walldir * canhitside >= 0 then
            local hx, hy, hx2, hy2 = intersectsegments(rx, ry, rx2, ry2, ax, ay, bx, by)
            if hx and hy then
                if hx2 and hy2 and dot(rdx, rdy, hx2, hy2) < dot(rdx, rdy, hx, hy) then
                    hx, hy = hx2, hy2
                end
                local dsq = distsq(rx, ry, hx, hy)
                if dsq < hitdsq then
                    hitdsq = dsq
                    hitx, hity = hx, hy
                    hitwallx, hitwally = ax, ay
                    hitwallx2, hitwally2 = bx, by
                    hitside = walldir
                end
            end
        end
    end)

    if hitx then
        raycast.hitdist = sqrt(hitdsq)
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

function Boundary:drawCollisionDebug(x, y, r)
    local selfx, selfy = self.x, self.y
    x, y = x - selfx, y - selfy
    love.graphics.push()
    love.graphics.translate(selfx, selfy)

    local triangles = self.triangles
    if triangles then
        love.graphics.setColor(.25, .25, .25)
        for i = 6, #triangles, 6 do
            love.graphics.polygon("line",
                triangles[i-5], triangles[i-4],
                triangles[i-3], triangles[i-2],
                triangles[i-1], triangles[i])
        end
    end

    local points = self.points
    if points then
        local cornernormals = self.cornernormals
        local x1, y1 = points[#points-1], points[#points]
        for i = 2, #points, 2 do
            local x2, y2 = points[i-1], points[i]
            local cnx, cny = cornernormals[i-1], cornernormals[i]
            love.graphics.setColor(1, 1, 0)
            love.graphics.line(x2, y2, x2 + cnx*16, y2 + cny*16)

            local projx, projy = projpointsegment(x, y, x1, y1, x2, y2)
            love.graphics.setColor(1, 0, 0)
            love.graphics.circle("fill", projx, projy, 2)

            -- local penex, peney = getCirclePenetrationOfPolygonSegment(x, y, r, x1, y1, x2, y2)
            -- if penex and peney then
            --     love.graphics.setColor(0, 1, 0)
            --     love.graphics.line(projx, projy, projx + penex, projy + peney)
            -- end

            x1, y1 = x2, y2
        end
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.pop()
    self:draw()
end

function Boundary:draw()
    self:drawPolygon()
    local bodyheight = self.bodyheight or 0
    if bodyheight > 0 then
        love.graphics.push()
        love.graphics.translate(0, -bodyheight)
        self:drawPolygon()
        love.graphics.translate(self.x, self.y)
        local points = self.points
        for i = 2, #points, 2 do
            local x, y = points[i-1], points[i]
            love.graphics.line(x, y, x, y + bodyheight)
        end
        love.graphics.pop()
    end
end

return Boundary
local Tiled = require "Tiled"

local projpointsegment = math.projpointsegment
local lensq = math.lensq
local sqrt = math.sqrt

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
    local hipx, hipy = math.norm(math.rot90(hix, hiy, sarea))
    local ijpx, ijpy = math.norm(math.rot90(ijx, ijy, sarea))
    local nx, ny = math.norm(hipx + ijpx, hipy + ijpy)
    if math.dot(nx, ny, ijx, ijy) > 0 then
        local cos = math.dot(nx, ny, hipx, hipy)
        nx, ny = nx / cos, ny / cos
    end
    return nx, ny
end

function Boundary:init()
    local points = self.points
    assert(points, "Boundary must be a polygon object")

    local sarea = math.polysignedarea(points)
    self.signedarea = sarea
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
    local right = x2

    for i = 2, #points-2, 2 do
        x0, y0 = x1, y1
        x1, y1 = x2, y2
        x2, y2 = points[i+1], points[i+2]
        right = math.max(right, x2)
        cnx, cny = getPolygonCornerNormal(x0, y0, x1, y1, x2, y2, sarea)
        cornernormals[i-1], cornernormals[i] = cnx, cny
    end
    self.right = self.x + right
end

local function getCirclePenetrationOfPolygonSegment(x, y, r, x1, y1, x2, y2, sarea)
    local projx, projy = projpointsegment(x, y, x1, y1, x2, y2)
    local distx, disty = x - projx, y - projy
    local distsq = lensq(distx, disty)
    if r*r < distsq then
        return
    end

    local dist = sqrt(distsq)
    local nx, ny = distx/dist, disty/dist
    if sarea * math.det(x2-x1, y2-y1, distx, disty) < 0 then
        r = -r
    end
    local pene = dist - r
    return nx*pene, ny*pene
end

function Boundary:isCircleInside(x, y, r)
    x, y = x - self.x, y - self.y
    local inside = false
    forLines(self, r, function(x1, y1, x2, y2)
        if y > math.min(y1, y2) then
            if y <= math.max(y1, y2) then
                if x <= math.max(x1, x2) then
                    local hitx = (y - y1) * (x2 - x1) / (y2 - y1) + x1;
                    if x1 == x2 or x <= hitx then
                        inside = not inside
                    end
                end
            end
        end
    end)
    return inside
end

---@return number x
---@return number y
---@return number? penex x penetration. Non-0 = penetrating; 0 = touching; nil = no contact
---@return number? peney y penetration. Non-0 = penetrating; 0 = touching; nil = no contact
function Boundary:keepCircleInside(x, y, r)
    if self:isCircleInside(x, y, r) then
        return x, y
    end

    local selfx, selfy = self.x, self.y
    x, y = x - selfx, y - selfy
    local nearestx, nearesty
    local nearestdsq = math.huge

    forLines(self, r, function(x1, y1, x2, y2)
        local projx, projy = projpointsegment(x, y, x1, y1, x2, y2)
        local projdsq = math.distsq(x, y, projx, projy)
        if projdsq < nearestdsq then
            nearestdsq, nearestx, nearesty = projdsq, projx, projy
        end
    end)

    local penex, peney = x - nearestx, y - nearesty
    x, y = x - penex + selfx, y - peney + selfy
    return x, y, penex, peney
end

---@param raycast Raycast
function Boundary:castRay(raycast, rx, ry)
    local points = self.points
    if not points then return end

    local canhitside = self.signedarea < 0
        and -raycast.canhitside or raycast.canhitside
    local selfx, selfy = self.x, self.y
    rx, ry = rx - selfx, ry - selfy
    local rdx, rdy = raycast.dx, raycast.dy
    local rx2, ry2 = rx + rdx, ry + rdy
    local r = raycast.radius
    local cn = self.cornernormals
    local cnx, cny = cn[#points-1], cn[#points]
    local ax, ay = points[#points-1] + cnx*r, points[#points] + cny*r
    local hitdsq = raycast.hitdist
    hitdsq = hitdsq and hitdsq*hitdsq or 0x10000000
    local hitx, hity, hitwallx, hitwally, hitwallx2, hitwally2, hitside
    for b = 2, #points, 2 do
        cnx, cny = cn[b-1], cn[b]
        local bx, by = points[b-1] + cnx*r, points[b] + cny*r
        local walldir = math.det(rdx, rdy, bx-ax, by-ay)
        if walldir * canhitside >= 0 then
            local hx, hy = math.intersectsegments(rx, ry, rx2, ry2, ax, ay, bx, by)
            if hx and hy then
                local distsq = math.distsq(rx, ry, hx, hy)
                if distsq < hitdsq then
                    hitdsq = distsq
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
        raycast.hitdist = sqrt(hitdsq)
        raycast.hitx = hitx + selfx
        raycast.hity = hity + selfy
        raycast.hitwallx = hitwallx + selfx
        raycast.hitwally = hitwally + selfy
        raycast.hitwallx2 = hitwallx2 + selfx
        raycast.hitwally2 = hitwally2 + selfy
        raycast.hitside = self.signedarea < 0 and -hitside or hitside
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
        local sarea = self.signedarea
        local x1, y1 = points[#points-1], points[#points]
        for i = 2, #points, 2 do
            local x2, y2 = points[i-1], points[i]
            local cnx, cny = cornernormals[i-1], cornernormals[i]
            love.graphics.setColor(1, 1, 0)
            love.graphics.line(x2, y2, x2 + cnx*16, y2 + cny*16)

            local projx, projy = projpointsegment(x, y, x1, y1, x2, y2)
            love.graphics.setColor(1, 0, 0)
            love.graphics.circle("fill", projx, projy, 2)

            local penex, peney = getCirclePenetrationOfPolygonSegment(x, y, r, x1, y1, x2, y2, sarea)
            if penex and peney then
                love.graphics.setColor(0, 1, 0)
                love.graphics.line(projx, projy, projx + penex, projy + peney)
            end

            x1, y1 = x2, y2
        end
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.pop()
    self:draw()
end

return Boundary
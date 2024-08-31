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

local function getPolygonCornerNormal(hx, hy, ix, iy, jx, jy, sarea)
    local ihnx, ihny = math.norm(hx-ix, hy-iy)
    local ijnx, ijny = math.norm(jx-ix, jy-iy)
    local nx, ny = ihnx+ijnx, ihny+ijny
    if nx == 0 and ny == 0 then
        return math.rot90(ijnx, ijny, sarea)
    end
    if sarea * math.det(ijnx, ijny, ihnx, ihny) < 0 then
        nx, ny = -nx, -ny
    end
    return math.norm(nx, ny)
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

---@return number x
---@return number y
---@return number? penex x penetration. Non-0 = penetrating; 0 = touching; nil = no contact
---@return number? peney y penetration. Non-0 = penetrating; 0 = touching; nil = no contact
function Boundary:keepCircleInside(x, y, r)
    local points = self.points
    if not points then
        return x, y
    end
    local sarea = self.signedarea
    local totalpenex, totalpeney
    local selfx, selfy = self.x, self.y
    x, y = x - selfx, y - selfy
    local x1, y1 = points[#points-1], points[#points]
    for i = 2, #points, 2 do
        local x2, y2 = points[i-1], points[i]
        local penex, peney = getCirclePenetrationOfPolygonSegment(x, y, r, x1, y1, x2, y2, sarea)
        if penex and peney then
            x, y = x - penex, y - peney
            totalpenex = (totalpenex or 0) + penex
            totalpeney = (totalpeney or 0) + peney
        end
        x1, y1 = x2, y2
    end
    x, y = x + selfx, y + selfy
    return x, y, totalpenex, totalpeney
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

    local ax, ay = points[#points-1], points[#points]
    local hitdsq = raycast.hitdist
    hitdsq = hitdsq and hitdsq*hitdsq or 0x10000000
    local hitx, hity, hitwallx, hitwally, hitwallx2, hitwally2, hitside
    for b = 2, #points, 2 do
        local bx, by = points[b-1], points[b]
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
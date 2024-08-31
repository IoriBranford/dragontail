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
    assert(self.shape == "polygon", "Boundary must be a polygon object")
    local points = self.points

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

---@class RayHit
---@field hitx number where ray hit wall
---@field hity number where ray hit wall
---@field hitdist number
---@field hitside number >0 = from inside, <0 = from outside
---@field ax number first wall endpoint
---@field ay number first wall endpoint
---@field bx number second wall endpoint
---@field by number second wall endpoint
local RayHit = class()

local function castRayOnSegment(rx0, ry0, rx1, ry1, ax, ay, bx, by, allowedhitside, hit)
    local walldir = math.det(rx1-rx0, ry1-ry0, bx-ax, by-ay)
    if allowedhitside ~= 0 and walldir * allowedhitside < 0 then
        return hit
    end
    local hitx, hity = math.intersectsegments(rx0, ry0, rx1, ry1, ax, ay, bx, by)
    if hitx and hity then
        hit = hit or {}
        local hitdist = hit.hitdist or math.huge
        local dist = math.dist(rx0, ry0, hitx, hity)
        if dist < hitdist then
            hit.hitx, hit.hity = hitx, hity
            hit.hitdist = dist
            hit.ax, hit.ay = ax, ay
            hit.bx, hit.by = bx, by
            hit.hitside = walldir
        end
    end
    return hit
end

---@param hit RayHit?
function Boundary:castRay(rx0, ry0, rx1, ry1, allowedhitside, hit)
    local points = self.points
    if not points then
        return
    end
    allowedhitside = allowedhitside or 0
    if self.signedarea < 0 then
        allowedhitside = -allowedhitside
    end
    local selfx, selfy = self.x, self.y
    rx0, ry0 = rx0 - selfx, ry0 - selfy
    rx1, ry1 = rx1 - selfx, ry1 - selfy
    local ax, ay = points[#points-1], points[#points]
    for b = 2, #points, 2 do
        local bx, by = points[b-1], points[b]
        hit = castRayOnSegment(rx0, ry0, rx1, ry1, ax, ay, bx, by, allowedhitside, hit)
        ax, ay = bx, by
    end
    if hit then
        hit.hitx = hit.hitx + selfx
        hit.hity = hit.hity + selfy
        hit.ax = hit.ax + selfx
        hit.ay = hit.ay + selfy
        hit.bx = hit.bx + selfx
        hit.by = hit.by + selfy
        if self.signedarea < 0 then
            hit.hitside = -hit.hitside
        end
    end
    return hit
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
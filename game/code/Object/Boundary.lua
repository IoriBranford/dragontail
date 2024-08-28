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

function Boundary:init()
    local points = self.points
    if self.shape == "polygon" and points then
        self.signedarea = math.polysignedarea(points)
        local right = -math.huge
        for i = 2, #points, 2 do
            right = math.max(right, points[i-1])
        end
        self.right = self.x + right
    elseif self.shape == "rectangle" then
        self.right = self.x + self.width
    end
end

local function getCirclePenetrationOfPolygonSegment(x, y, r, x1, y1, x2, y2, sarea)
    local projx, projy = projpointsegment(x, y, x1, y1, x2, y2)
    local tosegx, tosegy = projx - x, projy - y
    local distsq = lensq(tosegx, tosegy)
    if r*r < distsq then
        return
    end

    local dist = sqrt(distsq)
    local nx, ny = tosegx/dist, tosegy/dist
    local pene = r - dist
    return nx*pene, ny*pene
end

local function keepCircleInPolygon(self, x, y, r)
    local points = self.points
    if not points then
        return x, y
    end
    local sarea = self.signedarea
    local totalpenex, totalpeney
    local selfx, selfy = self.x, self.y
    local x1, y1 = selfx + points[#points-1], selfy + points[#points]
    for i = 2, #points, 2 do
        local x2, y2 = selfx + points[i-1], selfy + points[i]
        local penex, peney = getCirclePenetrationOfPolygonSegment(x, y, r, x1, y1, x2, y2, sarea)
        if penex and peney then
            x, y = x - penex, y - peney
            totalpenex = (totalpenex or 0) + penex
            totalpeney = (totalpeney or 0) + peney
        end
        x1, y1 = x2, y2
    end
    return x, y, totalpenex, totalpeney
end

local function keepCircleInRectangle(self, x, y, r)
    local bx, by, bw, bh = self.x, self.y, self.width, self.height
    local x1, x2 = x - r, x + r
    local y1, y2 = y - r, y + r
    local bx2, by2 = bx + bw, by + bh
    local penex, peney
    if x1 <= bx then
        penex = x1 - bx
    elseif x2 >= bx2 then
        penex = x2 - bx2
    end
    if y1 <= by then
        peney = y1 - by
    elseif y2 >= by2 then
        peney = y2 - by2
    end
    if penex then
        x = x - penex
    end
    if peney then
        y = y - peney
    end
    return x, y, penex, peney
end

---@return number x
---@return number y
---@return number? penex x penetration. Non-0 = penetrating; 0 = touching; nil = no contact
---@return number? peney y penetration. Non-0 = penetrating; 0 = touching; nil = no contact
function Boundary:keepCircleInside(x, y, r)
    if self.shape == "polygon" then
        return keepCircleInPolygon(self, x, y, r)
    elseif self.shape == "rectangle" then
        return keepCircleInRectangle(self, x, y, r)
    end
    return x, y
end

function Boundary:drawCollisionDebug(x, y, r)
    local points = self.points
    if points then
        local sarea = self.signedarea
        local selfx, selfy = self.x, self.y
        local x1, y1 = selfx + points[#points-1], selfy + points[#points]
        for i = 2, #points, 2 do
            local x2, y2 = selfx + points[i-1], selfy + points[i]
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
end

return Boundary
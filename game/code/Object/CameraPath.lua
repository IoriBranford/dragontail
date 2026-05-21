local Tiled = require "Tiled"

---@class CameraPath:TiledObject
local CameraPath = class(Tiled.Object)

function CameraPath:_init()
    Tiled.Object._init(self)
    self:init()
end

function CameraPath:init()
    local points = assert(self.points)
    local length = 0
    local pointtotallengths = {0, 0}
    for i = 4, #points, 2 do
        length = length + math.dist(points[i-3], points[i-2], points[i-1], points[i])
        pointtotallengths[#pointtotallengths+1] = length
        pointtotallengths[#pointtotallengths+1] = length
    end
    self.pointtotallengths = pointtotallengths
    self.totallength = length
end

function CameraPath:projectPoint(focusx, focusy)
    local selfx, selfy = self.x, self.y
    local points = assert(self.points)
    local x, y, i1, i2 = math.nearestpolylinepoint(points, focusx - selfx, focusy - selfy)
    return x + selfx, y + selfy, i1, i2
end

function CameraPath:getProgress(focusx, focusy)
    local selfx, selfy = self.x, self.y
    local points = assert(self.points)
    local x, y, i1 = math.nearestpolylinepoint(points, focusx - selfx, focusy - selfy)
    local x1, y1 = points[i1-1], points[i1]
    return (self.pointtotallengths[i1] + math.dist(x1, y1, x, y)) / self.totallength
end

function CameraPath:getSegment(i1, i2)
    local selfx, selfy = self.x, self.y
    local points = assert(self.points)
    local x1, y1, x2, y2 = points[i1-1], points[i1], points[i2-1], points[i2]
    return x1 + selfx, y1 + selfy,
        x2 + selfx, y2 + selfy
end

---@param cameracenterx number
---@param cameracentery number
---@param godist number distance along path to indicator's target point
---@return number
---@return number
function CameraPath:getGoIndicatorOffset(cameracenterx, cameracentery, godist)
    local selfx, selfy = self.x, self.y
    cameracenterx, cameracentery = cameracenterx - selfx, cameracentery - selfy
    local points = assert(self.points)
    local x, y, i1 = math.nearestpolylinepoint(points, cameracenterx, cameracentery)

    local targetx, targety = points[#points-1], points[#points]
    for i = i1+2, #points, 2 do
        local x2, y2 = points[i-1], points[i]
        local dist = math.dist(x, y, x2, y2)
        if godist == dist then
            targetx, targety = x2, y2
            break
        end
        if godist < dist then
            local ux, uy = (x2-x)/dist, (y2-y)/dist
            targetx = x + ux*godist
            targety = y + uy*godist
            break
        end
        godist = godist - dist
        x, y = x2, y2
    end
    return targetx - cameracenterx, targety - cameracentery
end

function CameraPath:isEnd(x, y)
    return x == self.x + self.points[#self.points-1]
        and y == self.y + self.points[#self.points]
end

return CameraPath
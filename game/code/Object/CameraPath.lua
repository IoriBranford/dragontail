local Tiled = require "Tiled"

---@class CameraPath:TiledObject
local CameraPath = class(Tiled.Object)

function CameraPath:_init()
    Tiled.Object._init(self)
    self:init()
end

function CameraPath:init()
end

function CameraPath:getCameraCenter(focusx, focusy)
    local selfx, selfy = self.x, self.y
    local points = assert(self.points)
    local x, y, i1, i2 = math.nearestpolylinepoint(points, focusx - selfx, focusy - selfy)
    local x1, y1, x2, y2 = points[i1-1], points[i1], points[i2-1], points[i2]
    return x + selfx, y + selfy,
        x1 + selfx, y1 + selfy,
        x2 + selfx, y2 + selfy
end

function CameraPath:isEnd(x, y)
    return x == self.x + self.points[#self.points-1]
        and y == self.y + self.points[#self.points]
end

return CameraPath
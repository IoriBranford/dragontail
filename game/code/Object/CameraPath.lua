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
    local x, y, x1, y1, x2, y2 = math.nearestpolylinepoint(self.points, focusx - selfx, focusy - selfy)
    return x + selfx, y + selfy,
        x1 + selfx, y1 + selfy,
        x2 + selfx, y2 + selfy
end

function CameraPath:isEnd(x, y)
    return x == self.x + self.points[#self.points-1]
        and y == self.y + self.points[#self.points]
end

return CameraPath
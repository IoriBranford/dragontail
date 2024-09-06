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
    local x, y = math.nearestpointonpolygon(self.points, focusx - self.x, focusy - self.y)
    return x + self.x, y + self.y
end

function CameraPath:isEnd(x, y)
    return x == self.x + self.points[#self.points-1]
        and y == self.y + self.points[#self.points]
end

return CameraPath
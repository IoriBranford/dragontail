local Tiled = require "Tiled"

---@class CameraBoundary:TiledObject
local CameraBoundary = class(Tiled.Object)

function CameraBoundary:_init()
    Tiled.Object._init(self)
    self:init()
end

function CameraBoundary:init()
end

---@param camx any
---@param camy any
---@return number newcamx
---@return number newcamy
---@return number boundary1x
---@return number boundary1y
---@return number boundary2x
---@return number boundary2y
function CameraBoundary:keepPointInside(camx, camy)
    local selfx, selfy = self.x, self.y
    local points = assert(self.points)
    local x, y, i1, i2 = math.keeppointinpolygon(points, camx - selfx, camy - selfy)
    local x1, y1, x2, y2 = points[i1-1], points[i1], points[i2-1], points[i2]
    return x + selfx, y + selfy,
        x1 + selfx, y1 + selfy,
        x2 + selfx, y2 + selfy
end

return CameraBoundary
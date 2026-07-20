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
---@return number? boundary1x
---@return number? boundary1y
---@return number? boundary2x
---@return number? boundary2y
function CameraBoundary:keepPointInside(camx, camy, camw, camh)
    local selfx, selfy = self.x, self.y
    local points = self.points
    if points then
        local x, y, i1, i2 = math.keeppointinpolygon(points, camx - selfx, camy - selfy)
        local x1, y1, x2, y2 = points[i1-1], points[i1], points[i2-1], points[i2]
        return x + selfx, y + selfy,
            x1 + selfx, y1 + selfy,
            x2 + selfx, y2 + selfy
    elseif self.shape == "rectangle" then
        local x, y = self.x, self.y
        local w, h = self.width - camw, self.height - camh
        camx = math.max(x, math.min(camx, x + w))
        camy = math.max(y, math.min(camy, y + h))
        return camx, camy
    end
end

function CameraBoundary:lerpPointInside(camx, camy, camw, camh)
    if self.shape == "rectangle" then
        local x, y = self.x, self.y
        local w, h = self.width, self.height
        local tx = (camx - x) / w
        local ty = (camy - y) / h
        local camhw, camhh = camw/2, camh/2
        camx = math.lerp(tx, x + camhw, x + w - camhw)
        camy = math.lerp(ty, y + camhh, y + h - camhh)
        return camx, camy
    end
end

return CameraBoundary
---@class Model:Body
---@field model g3d.model
local Model = {}

function Model:updatePosition(fixedfrac)
    self.model:setTranslation(
        self.x + self.velx*fixedfrac - self.originx,
        -self.y - self.vely*fixedfrac,
        self.z + self.velz*fixedfrac + self.originy)
end

return Model
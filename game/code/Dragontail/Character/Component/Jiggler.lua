---@class Jiggler
---@field scalex number
---@field scaley number
local Jiggler = {}

function Jiggler:update(timer)
    local s = math.min(4, timer) * math.sin(timer)
    self.scalex = 1 + s/8
    self.scaley = 1 - s/32
end

return Jiggler
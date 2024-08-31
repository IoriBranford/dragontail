---@class Raycast
local Raycast = class()

function Raycast:_init(dx, dy, canhitside, radius)
    self.dx = dx or 1
    self.dy = dy or 0
    self.canhitside = canhitside or 0 --- negative = only outsides, positive = only insides, 0 = both sides
    self.radius = radius or 0
    self.hitx = nil ---@type number?
    self.hity = nil ---@type number?
    self.hitdist = nil ---@type number?
    self.hitside = nil ---@type number? negative = from outside, other = from inside
    self.hitwallx = nil ---@type number?
    self.hitwally = nil ---@type number?
    self.hitwallx2 = nil ---@type number?
    self.hitwally2 = nil ---@type number?
end

return Raycast
---@class Raycast
local Raycast = class()

function Raycast:_init(dx, dy, dz, canhitside, radius, height)
    self.dx = dx or 1
    self.dy = dy or 0
    self.dz = dz or 0
    self.canhitside = canhitside or 0 --- negative = only outsides, positive = only insides, 0 = both sides
    self.canhitgroup = nil ---@type string?
    self.radius = radius or 0
    self.height = height or 0
    self.hitx = nil ---@type number?
    self.hity = nil ---@type number?
    self.hitz = nil ---@type number?
    self.hitdist = nil ---@type number?
    self.hitside = nil ---@type number? negative = from outside, other = from inside
    self.hitboundary = nil ---@type Boundary?
    self.hitcharacter = nil ---@type Character?
    self.hitwallx = nil ---@type number?
    self.hitwally = nil ---@type number?
    self.hitwallz = nil ---@type number?
    self.hitwallx2 = nil ---@type number?
    self.hitwally2 = nil ---@type number?
    self.hitwallz2 = nil ---@type number?
end

return Raycast
local Raycast = require "Object.Raycast"

---@class AttackerSlot:Raycast
---@field enemy Enemy?
local AttackerSlot = class(Raycast)

function AttackerSlot:_init(dx, dy)
    Raycast._init(self, dx, dy, 1)
    self.dirx, self.diry = math.norm(self.dx, self.dy)
end

function AttackerSlot:hasSpace(space)
    return not self.hitdist or self.hitdist > space
end

function AttackerSlot:getPosition(targetx, targety, distfromtarget)
    return targetx + self.dirx*distfromtarget, targety + self.diry*distfromtarget
end

return AttackerSlot
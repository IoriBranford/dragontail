local Raycast = require "Object.Raycast"

---@class AttackerSlot:Raycast
---@field enemy Enemy?
local AttackerSlot = class(Raycast)

function AttackerSlot:_init(slottype, dx, dy)
    Raycast._init(self, dx, dy, 1)
    self.canhitgroup = "solids"
    self.type = slottype ---@type "melee"|"missile"
    if self.dx == 0 and self.dy == 0 and self.dz == 0 then
        self.dx = 1
    end
    self.length = math.len(self.dx, self.dy, self.dz)
    self.dirx, self.diry = self.dx/self.length, self.dy/self.length
end

function AttackerSlot:hasSpace(space)
    return not self.hitdist or self.hitdist > space
end

function AttackerSlot:getPosition(targetx, targety, distfromtarget)
    return targetx + self.dirx*distfromtarget, targety + self.diry*distfromtarget
end

function AttackerSlot:getFarPosition(targetx, targety, distfromwall)
    local distfromtarget = math.min(self.hitdist or math.huge, self.length) - distfromwall
    return targetx + self.dirx*distfromtarget, targety + self.diry*distfromtarget
end

return AttackerSlot
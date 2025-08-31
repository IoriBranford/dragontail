local Raycast = require "Object.Raycast"
local CollisionMask = require "Dragontail.Character.Component.Body.CollisionMask"

---@class AttackerSlot:Raycast
---@field enemy Enemy?
local AttackerSlot = class(Raycast)

function AttackerSlot:_init(slottype, x, y, z, dx, dy, dz)
    Raycast._init(self, x, y, z, dx, dy, dz, 1)
    self.hitslayers = CollisionMask.merge("Object", "Wall", "Camera")
    self.type = slottype ---@type "melee"|"missile"
    if self.dx == 0 and self.dy == 0 and self.dz == 0 then
        self.dx = 1
    end
    self.length = math.len(self.dx, self.dy, self.dz)
    self.dirx = self.dx/self.length
    self.diry = self.dy/self.length
    self.dirz = self.dz/self.length
end

function AttackerSlot:hasSpace(space)
    return not self.hitdist or self.hitdist > space
end

function AttackerSlot:getPosition(distfromtarget)
    local x, y, z = self.x, self.y, self.z
    return x + self.dirx*distfromtarget,
        y + self.diry*distfromtarget,
        z + self.dirz*distfromtarget
end

function AttackerSlot:getFarPosition(distfromwall)
    local distfromtarget = math.min(self.hitdist or math.huge, self.length) - distfromwall
    local x, y, z = self.x, self.y, self.z
    return x + self.dirx*distfromtarget,
        y + self.diry*distfromtarget,
        z + self.dirz*distfromtarget
end

return AttackerSlot
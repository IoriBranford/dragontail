
---@class AttackerSlot:RayHit
---@field enemy Enemy?
---@field dirx number
---@field diry number
local AttackerSlot = class()

function AttackerSlot:_init(dirx, diry)
    self.dirx, self.diry = dirx, diry
end

function AttackerSlot:hasSpace(space)
    return not self.hitdist or self.hitdist > space
end

function AttackerSlot:getPosition(targetx, targety, targetdist)
    return targetx + self.dirx*targetdist, targety + self.diry*targetdist
end

return AttackerSlot
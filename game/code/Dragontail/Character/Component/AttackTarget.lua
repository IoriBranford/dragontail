local AttackerSlot = require "Dragontail.Character.Component.AttackerSlot"
local Attacker     = require "Dragontail.Character.Component.Attacker"

---@class AttackTarget:Body,Attacker
---@field health number
---@field maxhealth number
---@field canbeattacked boolean
---@field canbejuggled boolean
---@field canbedamagedbyattack string?
---@field hurtstun number
---@field hurtangle number?
---@field attacker Character
---@field hurtai string?
---@field recoverai string?
---@field aiafterhurt string?
---@field hurtsound string?
---@field attackerslots {[integer]:AttackerSlot, [string]:AttackerSlot[]}
---@field onHitByAttack fun(self:AttackTarget, target:Attacker)?
local AttackTarget = {}

function AttackTarget:initSlots()
    local x, y = self.x, self.y
    local slotz = self.z + self.bodyheight/2

    self.attackerslots = {
        AttackerSlot(self, "melee",   x, y, slotz, 1024, 0, 0), -- 3 o clock
        AttackerSlot(self, "melee",   x, y, slotz, 0, 1024, 0), -- 6 o clock
        AttackerSlot(self, "melee",   x, y, slotz, -1024, 0, 0),-- 9 o clock
        AttackerSlot(self, "melee",   x, y, slotz, 0, -1024, 0), -- 12 o clock
        AttackerSlot(self, "missile", x, y, slotz, 1024*math.cos(1*math.pi/6), 1024*math.sin(1*math.pi/6), 0), -- 4 o clock
        AttackerSlot(self, "missile", x, y, slotz, 1024*math.cos(2*math.pi/6), 1024*math.sin(2*math.pi/6), 0), -- 5 o clock
        AttackerSlot(self, "missile", x, y, slotz, 1024*math.cos(4*math.pi/6), 1024*math.sin(4*math.pi/6), 0), -- 7 o clock
        AttackerSlot(self, "missile", x, y, slotz, 1024*math.cos(5*math.pi/6), 1024*math.sin(5*math.pi/6), 0), -- 8 o clock
        AttackerSlot(self, "missile", x, y, slotz, 1024*math.cos(7*math.pi/6), 1024*math.sin(7*math.pi/6), 0), -- 10 o clock
        AttackerSlot(self, "missile", x, y, slotz, 1024*math.cos(8*math.pi/6), 1024*math.sin(8*math.pi/6), 0), -- 11 o clock
        AttackerSlot(self, "missile", x, y, slotz, 1024*math.cos(10*math.pi/6), 1024*math.sin(10*math.pi/6), 0), -- 1 o clock
        AttackerSlot(self, "missile", x, y, slotz, 1024*math.cos(11*math.pi/6), 1024*math.sin(11*math.pi/6), 0), -- 2 o clock
        melee = {},
        missile = {}
    }

    for _, slot in ipairs(self.attackerslots) do
        local slotgroup = self.attackerslots[slot.type]
        if slotgroup then
            slotgroup[#slotgroup+1] = slot
        end
    end
end

function AttackTarget:findRandomSlot(attackrange, slottype, opponentx, opponenty)
    local attackerslots = self.attackerslots
    attackerslots = slottype and attackerslots[slottype] or attackerslots
    local i = love.math.random(#attackerslots)
    local tooppox, tooppoy = opponentx - self.x, opponenty - self.y
    local mindot = math.len(tooppox, tooppoy)*math.cos(math.pi*.75)

    for _ = 1, #attackerslots do
        local slot = attackerslots[i]
        local slotdirx, slotdiry = slot.dirx, slot.diry
        if math.dot(slotdirx, slotdiry, tooppox, tooppoy) > mindot then
            local space = attackrange
                + AttackTarget.estimateSafeDistanceOnSlot(self, slot)

            if slot:hasSpace(space) then
                local destx, desty = slot:getPosition(space)
                return slot, destx, desty
            end
        end
        if i >= #attackerslots then
            i = 1
        else
            i = i + 1
        end
    end
end

function AttackTarget:findClosestSlot(attackrange, slottype, attackerx, attackery)
    local attackerslots = self.attackerslots
    attackerslots = slottype and attackerslots[slottype] or attackerslots
    local bestslot, bestslotdsq = nil, math.huge
    for _, slot in ipairs(attackerslots) do
        if slot:hasSpace(attackrange) then
            local slotx, sloty = slot:getPosition(attackrange)
            local slotdsq = math.distsq(attackerx, attackery, slotx, sloty)
            if slotdsq < bestslotdsq then
                bestslot, bestslotdsq = slot, slotdsq
            end
        end
    end
    return bestslot
end

function AttackTarget:estimateSafeDistanceOnSlot(slot)
    local velx, vely = self.velx, self.vely
    local attackvecx, attackvecy = velx, vely
    local attackarcrightx, attackarcrighty = velx, vely
    local attackarcleftx, attackarclefty = velx, vely
    if Attacker.isAttacking(self) then
        local attackangle = self.attackangle
        local radius = self.attack.radius
        local arc = self.attack.arc or 0
        attackvecx = radius*math.cos(attackangle)
        attackvecy = radius*math.sin(attackangle)
        attackarcrightx = radius*math.cos(attackangle + arc)
        attackarcrighty = radius*math.sin(attackangle + arc)
        attackarcleftx  = radius*math.cos(attackangle - arc)
        attackarclefty  = radius*math.sin(attackangle - arc)
    end

    local slotdirx, slotdiry = slot.dirx, slot.diry
    return math.max(0, math.dot(slotdirx, slotdiry, attackvecx, attackvecy))
        + math.max(0, math.dot(slotdirx, slotdiry, attackarcrightx, attackarcrighty))
        + math.max(0, math.dot(slotdirx, slotdiry, attackarcleftx, attackarclefty))
end

function AttackTarget:updateSlots()
    local attackerslots = self.attackerslots
    local Characters   = require "Dragontail.Stage.Characters"
    for _, slot in ipairs(attackerslots) do
        slot.x, slot.y, slot.z = self.x, self.y, self.z + self.bodyheight/2
        Characters.castRay3(slot, self)
    end
end

return AttackTarget
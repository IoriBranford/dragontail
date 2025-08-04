local Enemy = require "Dragontail.Character.Enemy"
local Guard = require "Dragontail.Character.Action.Guard"
local Face  = require "Dragontail.Character.Component.Face"

---@class ShieldBandit:Enemy
local ShieldBandit = class(Enemy)

local GuardHitsUntilCounter = 3

function ShieldBandit:duringHurt()
    self.numguardedhits = nil
end

function ShieldBandit:beforeGuard()
    self.velx, self.vely = 0, 0
    self.numguardedhits = self.numguardedhits or 0
end

function ShieldBandit:duringGuard(t)
    local opponent = self.opponents[1]
    Face.turnTowardsObject(self, opponent, self.faceturnspeed, self.state.animation)
    local guardangle = math.floor((self.faceangle + (math.pi/4)) / (math.pi/2)) * math.pi/2
    Guard.startGuarding(self, guardangle)
    if self.numguardedhits + 1 >= GuardHitsUntilCounter then
        self.color = self:getAttackFlashColor(t, true)
    else
        self.color = 0xFFFFFFFF
    end
end

function ShieldBandit:afterGuard()
    Enemy.afterGuard(self)
    self.color = 0xFFFFFFFF
    self.numguardedhits = nil
end

function ShieldBandit:beforeGuardHit(attacker)
    Guard.pushBackAttacker(self, attacker)
    self.numguardedhits = (self.numguardedhits or 0) + 1
end

function ShieldBandit:duringGuardHit(attacker, t)
    if self.numguardedhits >= GuardHitsUntilCounter then
        self.numguardedhits = nil
        Face.faceObject(self, attacker)
        return "shield-bash", attacker
    elseif self.numguardedhits + 1 >= GuardHitsUntilCounter then
        self.color = self:getAttackFlashColor(t, true)
    end
end

return ShieldBandit
local Enemy = require "Dragontail.Character.Enemy"
local Guard = require "Dragontail.Character.Action.Guard"
local Face  = require "Dragontail.Character.Component.Face"
local AttackTarget = require "Dragontail.Character.Component.AttackTarget"

---@class ShieldBandit:Enemy
local ShieldBandit = class(Enemy)

local GuardHitsUntilCounter = 3

function ShieldBandit:findApproachSlot(target, nextstate)
    local bodyradius = self.bodyradius
    local state = self.statetable[nextstate]
    local attackrange = (state and state.maxtargetdist or 1) + target.bodyradius
    return AttackTarget.findClosestSlot(target, attackrange + bodyradius, "melee", self.x, self.y)
        or AttackTarget.findClosestSlot(target, attackrange + bodyradius, "missile", self.x, self.y)
end

function ShieldBandit:duringStand()
    if not self:isCylinderFullyOnCamera(self.camera) then return end
    local opponent = self.opponents[1]
    local fromoppox, fromoppoy = self.x - opponent.x, self.y - opponent.y
    local oppovelx, oppovely = opponent.velx, opponent.vely
    local oppospeed = math.len(oppovelx, oppovely)
    local dot = math.dot(fromoppox, fromoppoy, oppovelx, oppovely)
    if 0 < dot and dot <= oppospeed*200 then
        return "raiseGuard"
    end
end

function ShieldBandit:duringApproach(opponent)
    if not self:isCylinderFullyOnCamera(self.camera) then return end
    local fromoppox, fromoppoy = self.x - opponent.x, self.y - opponent.y
    local oppovelx, oppovely = opponent.velx, opponent.vely
    local oppospeed = math.len(oppovelx, oppovely)
    local dot = math.dot(fromoppox, fromoppoy, oppovelx, oppovely)
    if 0 < dot and dot <= oppospeed*200 then
        return "raiseGuard"
    end
end

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
        self:updateFlash(self.statetime)
    else
        self:resetFlash()
    end
end

function ShieldBandit:afterGuard()
    Enemy.afterGuard(self)
    self:resetFlash()
    self.numguardedhits = nil
end

---@deprecated
function ShieldBandit:beforeGuardHit(attacker)
    Guard.pushBackAttacker(self, attacker)
    self.numguardedhits = (self.numguardedhits or 0) + 1
end

---@deprecated
function ShieldBandit:duringGuardHit(attacker, t)
    if self.numguardedhits >= GuardHitsUntilCounter then
        self.numguardedhits = nil
        Face.faceObject(self, attacker)
        return "shield-counter-bash", attacker
    elseif self.numguardedhits + 1 >= GuardHitsUntilCounter then
        self:updateFlash(self.statetime)
    end
end

return ShieldBandit
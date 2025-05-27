local Enemy = require "Dragontail.Character.Enemy"
local Face       = require "Dragontail.Character.Action.Face"
local Dodge = require "Dragontail.Character.Action.Dodge"
local Database = require "Data.Database"

---@class SpearBandit:Enemy
---@field numdodges integer
local SpearBandit = class(Enemy)

function SpearBandit:duringStand()
    local opponent = self.opponents[1]
    Face.facePosition(self, opponent.x, opponent.y, "Stand")
    -- local oppox, oppoy = opponent.x, opponent.y
    -- local tooppox, tooppoy = oppox - self.x, oppoy - self.y
    -- local seesopponent = math.dot(math.cos(self.faceangle), math.sin(self.faceangle), tooppox, tooppoy) >= 0
    local dodgeangle = self:isFullyOnCamera(self.camera) and Dodge.findDodgeAngle(self)
    if dodgeangle then
        self.numdodges = (self.numdodges or 0) + 1
        return "dodgeIncoming", dodgeangle
    end
end

function SpearBandit:afterStand()
    return Enemy.afterStand(self)
end

function SpearBandit:duringApproach(target)
    -- local oppox, oppoy = opponent.x, opponent.y
    -- local tooppox, tooppoy = oppox - self.x, oppoy - self.y
    -- local seesopponent = math.dot(math.cos(self.faceangle), math.sin(self.faceangle), tooppox, tooppoy) >= 0
    local dodgeangle = self:isFullyOnCamera(self.camera) and Dodge.findDodgeAngle(self)
    if dodgeangle then
        self.numdodges = (self.numdodges or 0) + 1
        return "dodgeIncoming", dodgeangle
    end
end

function SpearBandit:duringDodge()
    if (self.numdodges or 0) >= 2 then
        if math.abs(self.velx) < 1 and math.abs(self.vely) < 1 then
            local attacktype = "spear-poke"
            local opponent = self.opponents[1]
            local maxcounterdist = 128
            local dsq = math.distsq(self.x, self.y, opponent.x, opponent.y)
            if dsq <= maxcounterdist*maxcounterdist then
                Face.faceObject(self, opponent)
                return attacktype
            end
        end
    end
end

function SpearBandit:decideNextAttack()
    return Enemy.decideNextAttack(self)
end

function SpearBandit:duringPrepareAttack(target)
    if (self.numdodges or 0) < 2 then
        local dodgeangle = self:isFullyOnCamera(self.camera) and Dodge.findDodgeAngle(self)
        if dodgeangle then
            self.numdodges = (self.numdodges or 0) + 1
            self.color = self:getAttackFlashColor(0)
            if target.attacker == self then
                target.attacker = nil
            end
            return "dodgeIncoming", dodgeangle
        end
    end
    self:accelerateTowardsVel(0, 0, 4)
end

function SpearBandit:duringAttackSwing(target)
    self.numdodges = 0
    return Enemy.duringAttackSwing(self, target)
end

function SpearBandit:beforeGetUp(attacker)
    return Enemy.beforeGetUp(self, attacker)
end

function SpearBandit:duringGetUp(attacker)
    return Enemy.duringGetUp(self, attacker)
end

return SpearBandit
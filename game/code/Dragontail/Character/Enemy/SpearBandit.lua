local Enemy = require "Dragontail.Character.Enemy"
local Face       = require "Dragontail.Character.Component.Face"
local Dodge = require "Dragontail.Character.Action.Dodge"
local Database = require "Data.Database"
local Body     = require "Dragontail.Character.Component.Body"

---@class SpearBandit:Enemy
---@field numdodges integer
local SpearBandit = class(Enemy)

function SpearBandit:duringStand()
    local opponent = self.opponents[1]
    Face.facePosition(self, opponent.x, opponent.y, "Stand")
    -- local oppox, oppoy = opponent.x, opponent.y
    -- local tooppox, tooppoy = oppox - self.x, oppoy - self.y
    -- local seesopponent = math.dot(math.cos(self.faceangle), math.sin(self.faceangle), tooppox, tooppoy) >= 0
    local dodgeangle = self:isCylinderFullyOnCamera(self.camera) and Dodge.findDodgeAngle(self)
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
    local dodgeangle = self:isCylinderFullyOnCamera(self.camera) and Dodge.findDodgeAngle(self)
    if dodgeangle then
        self.numdodges = (self.numdodges or 0) + 1
        return "dodgeIncoming", dodgeangle
    end
end

local DodgesBeforeCounterAttack = 1
local CounterAttackType = "SpearPoke"

function SpearBandit:duringDodge()
    if (self.numdodges or 0) >= DodgesBeforeCounterAttack then
        local opponent = self.opponents[1]
        if self:couldAttackOpponent(opponent, CounterAttackType) then
            Face.faceObject(self, opponent)
            opponent.attacker = self
            return CounterAttackType
        end
    end
end

function SpearBandit:decideNextAttack()
    return Enemy.decideNextAttack(self)
end

function SpearBandit:duringPrepareAttack(target)
    if (self.numdodges or 0) < DodgesBeforeCounterAttack then
        local dodgeangle = self:isCylinderFullyOnCamera(self.camera) and Dodge.findDodgeAngle(self)
        if dodgeangle then
            self.numdodges = (self.numdodges or 0) + 1
            self.color = self:getAttackFlashColor(0, self.canbeattacked)
            if target.attacker == self then
                target.attacker = nil
            end
            return "dodgeIncoming", dodgeangle
        end
    end
    Face.turnTowardsObject(self, target, self.faceturnspeed or 0,
        self.state.animation, self.state.frame1, self.state.loopframe)
    local deceltime = self.attacktype == CounterAttackType and 8 or 4
    self:accelerateTowardsVel(0, 0, deceltime)
    if self.velx ~= 0 or self.vely ~= 0 then
        Body.keepInBounds(self)
    end
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
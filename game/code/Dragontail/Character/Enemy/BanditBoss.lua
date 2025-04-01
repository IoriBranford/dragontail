local Enemy = require "Dragontail.Character.Enemy"
local Database = require "Data.Database"
local Audio    = require "System.Audio"
local Characters = require "Dragontail.Stage.Characters"
local Stage      = require "Dragontail.Stage"
local DirectionalAnimation = require "Dragontail.Character.DirectionalAnimation"

--- Attacks:
--- - Lance charge
--- - Lance spin
--- Both can be stopped by hitting wall and recoiling
--- 
--- Logic:
--- - Charge at long distance or spin at short distance
--- - At medium health
---     - If player moves past or close while preparing charge, cancel into spin
---     - If player moves away during early spin, cancel into charge
---     - Call backup between some number of attacks
--- - At low health
---     - Spin constantly in desperation
---@class BanditBoss:Enemy
local BanditBoss = class(Enemy)

local yield = coroutine.yield

local GetUpAttackHealthPercent = .75
local OneSwitchAttackHealthPercent = .5
local TwoSwitchAttackHealthPercent = .25
local FirstSummonHealthPercent = .6
local SecondSummonHealthPercent = .3

function BanditBoss:getBestAttack(opponent)
    local targetx, targety = opponent.x, opponent.y
    local distx, disty = targetx - self.x, targety - self.y
    local facex, facey = math.cos(self.faceangle), math.sin(self.faceangle)
    local isoppobehind = math.dot(facex, facey, distx, disty) <= 0
    if isoppobehind or math.lensq(distx, disty) <= 100*100 then
        local turndir = math.det(facex, facey, distx, disty)
        return turndir < 0 and "bandit-boss-spin-ccw" or "bandit-boss-spin-cw"
    end
    return "bandit-boss-charge"
end

function BanditBoss:decideNextAttack()
    local opponent = self.opponents[1]
    local attacktype = self:getBestAttack(opponent)
    return attacktype
end

function BanditBoss:afterStand()
    local healthpct = self.health/self.maxhealth
    if healthpct <= TwoSwitchAttackHealthPercent then
        self.attackswitchesleft = 2
    elseif healthpct <= OneSwitchAttackHealthPercent then
        self.attackswitchesleft = 1
    else
        self.attackswitchesleft = 0
    end
    return Enemy.afterStand(self)
end

function BanditBoss:getAttackSwitch(target)
    if target and target.canbeattacked then
        local switchesleft = self.attackswitchesleft or 0
        local newattack = switchesleft > 0 and self:getBestAttack(target) or self.attacktype
        if newattack ~= self.attacktype then
            self.attackswitchesleft = switchesleft - 1
            self:stopAttack()
            return newattack
        end
    end
end

function BanditBoss:duringPrepareAttack(target)
    self:accelerateTowardsVel(0, 0, 4)
    return self:getAttackSwitch(target)
end

function BanditBoss:duringAttackSwing(target)
    local turnspeed = self.attackspinspeed or 0
    if turnspeed ~= 0 then
        self.attackangle = self.attackangle + turnspeed
        DirectionalAnimation.set(self, self.swinganimation, self.attackangle, 1, self.swinganimationloopframe or 0)
    end
    return self:getAttackSwitch(target)
end

function BanditBoss:attack()
    local opponents = Characters.getGroup("players")
    local opponent = opponents[1]
    local nextstate, a, b, c = self:prepareAttack(opponent)
    if nextstate then
        return nextstate, a, b, c
    end
    nextstate, a, b, c = self:executeAttack(opponent)
    if nextstate then
        return nextstate, a, b, c
    end
    return "stand", 20
end

function BanditBoss:beforeGetUp(attacker)
    local healthpct = self.health/self.maxhealth
    local numsummons = self.numsummons or 0
    if healthpct <= FirstSummonHealthPercent and numsummons < 1
    or healthpct <= SecondSummonHealthPercent and numsummons < 2 then
        Stage.openNextRoomIfNotLast()
        self.numsummons = numsummons + 1
    end
end

function BanditBoss:duringGetUp(attacker)
    if self.health/self.maxhealth <= GetUpAttackHealthPercent then
        local attack = self:getBestAttack(attacker) or ""
        if attack:find("^bandit%-boss%-spin") then
            self.attacktype = attack
            Database.fill(self, attack)
            self.attackswitchesleft = 0
            Audio.play(self.windupsound)
            for t = 1, (self.attackwinduptime or 0) do
                self.color = self:getAttackFlashColor(t)
                yield()
            end
            self:executeAttack(nil, attacker)
            return self.aiaftergetup or self.recoverai
        end
    end
end

function BanditBoss:defeat(attacker)
    Audio.fadeMusic()
    Characters.clearEnemies(self)
    Stage.setToLastRoom()
    return Enemy.defeat(self, attacker)
end

return BanditBoss
local Enemy = require "Dragontail.Character.Enemy"
local Database = require "Data.Database"
local Audio    = require "System.Audio"
local Characters = require "Dragontail.Stage.Characters"
local Raycast    = require "Object.Raycast"
local Movement   = require "Component.Movement"
local Fighter    = require "Dragontail.Character.Fighter"
local Color      = require "Tiled.Color"
local Stage      = require "Dragontail.Stage"
local Dodge      = require "Dragontail.Character.Action.Dodge"
local Slide      = require "Dragontail.Character.Action.Slide"
local Face       = require "Dragontail.Character.Action.Face"
local Shoot      = require "Dragontail.Character.Action.Shoot"
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

local pi = math.pi
local huge = math.huge
local max = math.max
local cos = math.cos
local sin = math.sin
local norm = math.norm
local atan2 = math.atan2
local distsq = math.distsq
local floor = math.floor
local mid = math.mid
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

function BanditBoss:stand(duration)
    duration = duration or 20
    self.velx, self.vely = 0, 0
    local x, y = self.x, self.y
    local opponents = Characters.getGroup("players")
    local opponent = opponents[1]
    for _ = 1, duration do
        Face.facePosition(self, opponent.x, opponent.y)
        local dodgeangle = self:isFullyOnCamera(self.camera) and Dodge.findDodgeAngle(self, opponent)
        if dodgeangle then
            return "dodgeIncoming", dodgeangle
        end
        coroutine.yield()
    end

    if opponent.health <= 0 then
        return "stand"
    end

    local attacktype = self:getBestAttack(opponent)
    self.attacktype = attacktype
    Database.fill(self, self.attacktype)

    local toopposq = math.distsq(x, y, opponent.x, opponent.y)
    local attackradius = self.TotalAttackRange(self.attackradius or 32, self.attacklungespeed or 0, self.attacklungedecel or 1) + opponent.bodyradius
    if not opponent.attacker
    and opponent.canbeattacked
    and toopposq <= attackradius*attackradius
    and self:isFullyOnCamera(self.camera) then
        local healthpct = self.health/self.maxhealth
        if healthpct <= TwoSwitchAttackHealthPercent then
            self.attackswitchesleft = 2
        elseif healthpct <= OneSwitchAttackHealthPercent then
            self.attackswitchesleft = 1
        else
            self.attackswitchesleft = 0
        end
        Face.facePosition(self, opponent.x, opponent.y)
        return "attack", attacktype
    end
    return "approach"
end

function BanditBoss:duringPrepareAttack(target)
    self:accelerateTowardsVel(0, 0, 4)
    if target and target.canbeattacked then
        local switchesleft = self.attackswitchesleft or 0
        local newattack = switchesleft > 0 and self:getBestAttack(target) or self.attacktype
        if newattack ~= self.attacktype then
            self.attackswitchesleft = switchesleft - 1
            return "attack", newattack
        end
    end
end

function BanditBoss:executeAttack(attacktype, targetx, targety, targetz)
    if attacktype then
        self.attacktype = attacktype
        Database.fill(self, attacktype)
    end
    self.numopponentshit = 0
    self:stopGuarding()

    local target
    if type(targetx) == "table" then
        target = targetx
        target.attacker = self
        targetx, targety, targetz = target.x, target.y, target.z
    end

    targetx = targetx or self.x
    targety = targety or self.y
    Face.faceVector(self, targetx - self.x, targety - self.y, self.swinganimation, 1, self.swinganimationloopframe or 0)

    Audio.play(self.swingsound)
    local attackprojectile = self.attackprojectile
    if attackprojectile then
        Shoot.launchProjectileAtPosition(self, attackprojectile, targetx, targety, targetz)
    else
        local attackangle = floor((self.faceangle + (pi/4)) / (pi/2)) * pi/2
        self:startAttack(attackangle)
    end

    local lungespeed = self.attacklungespeed or 0
    local hittime = self.attackhittime or 10
    local turnspeed = self.attackspinspeed or 0
    repeat
        lungespeed = Slide.updateSlideSpeed(self, self.faceangle, lungespeed, self.attacklungedecel or 1)
        if turnspeed ~= 0 then
            self.attackangle = self.attackangle + turnspeed
            DirectionalAnimation.set(self, self.swinganimation, self.attackangle, 1, self.swinganimationloopframe or 0)
        end
        if target and target.canbeattacked then
            local switchesleft = self.attackswitchesleft or 0
            local newattack = switchesleft > 0 and self:getBestAttack(target) or self.attacktype
            if newattack ~= self.attacktype then
                self.attackswitchesleft = switchesleft - 1
                self:stopAttack()
                return "attack", newattack
            end
        end
        hittime = hittime - 1
        self.color = self:getAttackFlashColor(hittime)
        yield()
        if self.velx ~= 0 or self.vely ~= 0 then
            self:keepInBounds()
        end
    until hittime <= 0
    self.color = Color.White

    self:stopAttack()
    if self.attackwindupinvuln then
        self.canbeattacked = true
        self.canbegrabbed = true
    end

    local afterhittime = self.attackafterhittime or 30
    repeat
        lungespeed = Slide.updateSlideSpeed(self, self.faceangle, lungespeed)
        afterhittime = afterhittime - 1
        yield()
        if self.velx ~= 0 or self.vely ~= 0 then
            self:keepInBounds()
        end
    until afterhittime <= 0
end

function BanditBoss:attack(attacktype)
    local opponents = Characters.getGroup("players")
    local opponent = opponents[1]
    local nextstate, a, b, c = self:prepareAttack(attacktype, opponent)
    if nextstate then
        return nextstate, a, b, c
    end
    nextstate, a, b, c = self:executeAttack(attacktype, opponent)
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
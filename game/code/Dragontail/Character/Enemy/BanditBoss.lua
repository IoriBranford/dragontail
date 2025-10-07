local Enemy = require "Dragontail.Character.Enemy"
local Database = require "Data.Database"
local Audio    = require "System.Audio"
local Characters = require "Dragontail.Stage.Characters"
local Stage      = require "Dragontail.Stage"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"
local Face                 = require "Dragontail.Character.Component.Face"
local Attacker             = require "Dragontail.Character.Component.Attacker"

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

local GetUpAttackHealthPercent = 15/16
local OneSwitchAttackHealthPercent = .5
local TwoSwitchAttackHealthPercent = .0
local FirstSummonHealthPercent = .6
local SecondSummonHealthPercent = .3
local AllowedAttackSwitches = {
    ["bandit-boss-charge"] = {
        ["bandit-boss-swat-projectile-cw"] = true,
        ["bandit-boss-swat-projectile-ccw"] = true,
        ["bandit-boss-spin-cw"] = true,
        ["bandit-boss-spin-ccw"] = true,
        ["bandit-boss-poke"] = true,
    },
    ["bandit-boss-charge2"] = {
        ["bandit-boss-swat-projectile-cw"] = true,
        ["bandit-boss-swat-projectile-ccw"] = true,
        ["bandit-boss-spin-cw"] = true,
        ["bandit-boss-spin-ccw"] = true,
    }
}

function BanditBoss:considerDeflectingProjectile()
    local x, y = self.x, self.y
    local radius = self.bodyradius
    local incomingprojectile
    Characters.search("projectiles", function(projectile)
        if not Attacker.isAttacking(projectile) then
            return
        end
        local pvelx, pvely = projectile.velx, projectile.vely
        local pspeed = math.len(pvelx, pvely)
        local frompx, frompy = x - projectile.x, y - projectile.y
        local radii = radius + projectile.bodyradius

        local detDV = math.det(frompx, frompy, pvelx, pvely)
        if math.abs(detDV) > radii*pspeed then return end

        local dotDV = math.dot(frompx, frompy, pvelx, pvely)
        if dotDV > 200*pspeed then return end

        incomingprojectile = projectile
        return "break"
    end)

    if incomingprojectile then
        local pdistx, pdisty = incomingprojectile.x - self.x, incomingprojectile.y - self.y
        local facex, facey = math.cos(self.faceangle), math.sin(self.faceangle)
        local turndir = math.det(facex, facey, pdistx, pdisty)
        local attack = turndir < 0 and "bandit-boss-swat-projectile-ccw"
            or "bandit-boss-swat-projectile-cw"
        return attack, incomingprojectile
    end
end

function BanditBoss:getBestAttack(opponent)
    local deflectattack, projectile = self:considerDeflectingProjectile()
    if deflectattack then
        return deflectattack, projectile
    end
    local targetx, targety = opponent.x, opponent.y
    local distx, disty = targetx - self.x, targety - self.y
    local facex, facey = math.cos(self.faceangle), math.sin(self.faceangle)
    local isoppobehind = math.dot(facex, facey, distx, disty) <= 0
    local isoppocoming = math.dot(opponent.velx, opponent.vely, distx, disty) < 0
    local dsq = math.lensq(distx, disty)
    if dsq <= 128*128 then
        local turndir = math.det(facex, facey, distx, disty)
        if self.state.state == "fall" or self.state.state == "getup" then
            return turndir < 0 and "bandit-boss-getup-spin-ccw" or "bandit-boss-getup-spin-cw"
        end
        if isoppobehind or not isoppocoming then
            return turndir < 0 and "bandit-boss-spin-ccw" or "bandit-boss-spin-cw"
        else
            return "bandit-boss-poke"
        end
    end
    return "bandit-boss-charge"
end

function BanditBoss:decideNextAttack()
    local opponent = self.opponents[1]
    local attacktype = self:getBestAttack(opponent)
    return attacktype
end

function BanditBoss:duringStand()
    return self:considerDeflectingProjectile()
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

function BanditBoss:duringApproach(opponent)
    local deflectattack, projectile = self:considerDeflectingProjectile()
    if deflectattack then
        return deflectattack, projectile
    end
    local bestattack = self:getBestAttack(opponent)
    if bestattack ~= "bandit-boss-charge" then
        if self:couldAttackOpponent(opponent, bestattack) then
            return bestattack
        end
    end
end

function BanditBoss:getAttackSwitch(target)
    if not target or not target.canbeattacked then return end

    local switchesleft = self.attackswitchesleft or 0
    if switchesleft <= 0 then return end

    local allowedswitchattacks = AllowedAttackSwitches[self.state.state]
    if not allowedswitchattacks then return end

    local newattack = self:getBestAttack(target)
    if allowedswitchattacks[newattack] then
        self.attackswitchesleft = switchesleft - 1
        self:stopAttack()
        Face.faceObject(self, target)
        return newattack
    end
end

function BanditBoss:duringPrepareAttack(target)
    self:accelerateTowardsVelXY(0, 0, 4)
    Face.turnTowardsObject(self, target, self.faceturnspeed or 0,
        self.state.animation, self.state.frame1, self.state.loopframe)
    return self:getAttackSwitch(target)
end

function BanditBoss:duringAttackSwing(target)
    local turnspeed = self.attack.spinspeed or 0
    if turnspeed ~= 0 and self.attackangle then
        self.attackangle = self.attackangle + turnspeed
        Face.faceAngle(self, self.attackangle, self.state.animation, self.state.frame1, self.state.loopframe)
    end
    return self:getAttackSwitch(target)
end

function BanditBoss:beforeGetUp()
    local healthpct = self.health/self.maxhealth
    local numsummons = self.numsummons or 0
    if healthpct <= FirstSummonHealthPercent and numsummons < 1
    or healthpct <= SecondSummonHealthPercent and numsummons < 2 then
        Stage.openNextRoomIfNotLast()
        self.numsummons = numsummons + 1
    end
end

function BanditBoss:duringGetUp()
    if self.health/self.maxhealth <= GetUpAttackHealthPercent then
        local attack = self:getBestAttack(self.opponents[1]) or ""
        if attack:find("^bandit%-boss%-getup%-spin") then
            Face.faceObject(self, self.opponents[1])
            self.attackswitchesleft = 0
            return attack
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
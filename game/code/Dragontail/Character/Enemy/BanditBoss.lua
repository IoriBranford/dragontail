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
        self:facePosition(opponent.x, opponent.y)
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
        self:facePosition(opponent.x, opponent.y)
        return "attack", attacktype
    end
    return "approach"
end

function BanditBoss:approach()
    local x, y = self.x, self.y
    local opponents = Characters.getGroup("players")
    local opponent = opponents[1]
    local oppox, oppoy = opponent.x, opponent.y
    local bodyradius = self.bodyradius

    local attackradius = self.TotalAttackRange(self.attackradius or 64, self.attacklungespeed or 0, self.attacklungedecel or 1) + opponent.bodyradius
    local attackerslot
    if self.attackprojectile then
        attackerslot = opponent:findRandomAttackerSlot(bodyradius, "missile")
    else
        attackerslot = opponent:findRandomAttackerSlot(attackradius + bodyradius, "melee")
    end
    if not attackerslot then
        return "stand", 10
    end
    local destx, desty
    if self.attackprojectile then
        destx, desty = attackerslot:getFarPosition(oppox, oppoy, bodyradius)
    else
        destx, desty = attackerslot:getPosition(oppox, oppoy, attackradius)
    end
    local raycast = Raycast(destx - x, desty - y, 0, 1, bodyradius/2)
    raycast.canhitgroup = "solids"
    if Characters.castRay(raycast, x, y) then
        local todestx, todesty = destx - x, desty - y
        local frontendx, frontendy = raycast.hitwallx, raycast.hitwally
        local backendx, backendy = raycast.hitwallx2, raycast.hitwally2
        local wallvecx, wallvecy = frontendx - backendx, frontendy - backendy
        if math.dot(wallvecx, wallvecy, todestx, todesty) < 0 then
            frontendx, backendx = backendx, frontendx
            frontendy, backendy = backendy, frontendy
            wallvecx, wallvecy = -wallvecx, -wallvecy
        end
        local projx, projy = math.projpointsegment(x, y, backendx, backendy, frontendx, frontendy)
        destx, desty = x + frontendx - projx, y + frontendy - projy
    end

    self:faceVector(destx - x, desty - y, "Walk")

    local speed = self.speed or 2
    if math.distsq(x, y, oppox, oppoy) > 320*320 then
        speed = speed * 1.5
    end

    local reached = false
    for i = 1, (self.approachtime or 60) do
        oppox, oppoy = opponent.x, opponent.y
        local tooppox, tooppoy = oppox - x, oppoy - y
        -- local seesopponent = math.dot(math.cos(self.faceangle), math.sin(self.faceangle), tooppox, tooppoy) >= 0
        local dodgeangle = self:isFullyOnCamera(self.camera) and Dodge.findDodgeAngle(self, opponent)
        if dodgeangle then
            return "dodgeIncoming", dodgeangle
        end
        self.velx, self.vely = Movement.getVelocity_speed(self.x, self.y, destx, desty, speed)
        coroutine.yield()
        if self.x == destx and self.y == desty then
            reached = true
            break
        end
    end

    local attacktype = not opponent.attacker and self.attacktype
    if attacktype and opponent.canbeattacked
    and math.distsq(x, y, oppox, oppoy) <= attackradius*attackradius then
        self:facePosition(opponent.x, opponent.y)
        return "attack", attacktype
    end
    if reached then
        return "stand", 10
    end
    return "stand", 5
end

function BanditBoss:prepareAttack(attacktype, targetx, targety)
    if attacktype then
        self.attacktype = attacktype
        Database.fill(self, attacktype)
    end
    self.numopponentshit = 0
    self:stopGuarding()
    self.canbeattacked = not self.attackwindupinvuln
    self.canbegrabbed = not self.attackwindupinvuln

    local target
    if type(targetx) == "table" then
        target = targetx
        target.attacker = self
        targetx, targety = target.x, target.y
    end

    -- targetx = targetx or self.x
    -- targety = targety or self.y
    -- self:faceVector(targetx - self.x, targety - self.y, self.windupanimation, 1, self.windupanimationloopframe or 0)

    self:faceAngle(self.faceangle, self.windupanimation, 1, self.windupanimationloopframe or 0)

    Audio.play(self.windupsound)
    for t = 1, (self.attackwinduptime or 20) do
        self:accelerateTowardsVel(0, 0, 4)
        self.color = self:getAttackFlashColor(t)

        if target and target.canbeattacked then
            local switchesleft = self.attackswitchesleft or 0
            local newattack = switchesleft > 0 and self:getBestAttack(target) or self.attacktype
            if newattack ~= self.attacktype then
                self.attackswitchesleft = switchesleft - 1
                return "attack", newattack
            end
        end

        -- depending on health:
        -- dodge when player approaches
        -- cancel into another attack which is better for player position
        coroutine.yield()
        if self.velx ~= 0 or self.vely ~= 0 then
            self:keepInBounds()
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
    self:faceVector(targetx - self.x, targety - self.y, self.swinganimation, 1, self.swinganimationloopframe or 0)

    Audio.play(self.swingsound)
    local attackprojectile = self.attackprojectile
    if attackprojectile then
        self:launchProjectileAtPosition(attackprojectile, targetx, targety, targetz)
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
            self:setDirectionalAnimation(self.swinganimation, self.attackangle, 1, self.swinganimationloopframe or 0)
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

function BanditBoss:getup(attacker)
    local healthpct = self.health/self.maxhealth
    local numsummons = self.numsummons or 0
    if healthpct <= FirstSummonHealthPercent and numsummons < 1
    or healthpct <= SecondSummonHealthPercent and numsummons < 2 then
        Stage.openNextRoomIfNotLast()
        self.numsummons = numsummons + 1
    end
    local time = self.getuptime or 27
    for _ = 1, time do
        yield()
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
    local recoverai = self.aiaftergetup or self.recoverai
    if not recoverai then
        print("No aiaftergetup or recoverai for "..self.type)
        return "defeat", attacker
    end
    return recoverai
end

function BanditBoss:defeat(attacker)
    Audio.fadeMusic()
    Characters.clearEnemies(self)
    Stage.setToLastRoom()
    return Enemy.defeat(self, attacker)
end

return BanditBoss
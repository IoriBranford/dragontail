local Enemy = require "Dragontail.Character.Enemy"
local Database = require "Data.Database"
local Audio    = require "System.Audio"
local Characters = require "Dragontail.Stage.Characters"
local Raycast    = require "Object.Raycast"
local Movement   = require "Component.Movement"
local Fighter    = require "Dragontail.Character.Fighter"

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

function BanditBoss:stand(duration)
    duration = duration or 20
    self.velx, self.vely = 0, 0
    local x, y = self.x, self.y
    local opponents = Characters.getGroup("players")
    local opponent = opponents[1]
    local oppox, oppoy
    for _ = 1, duration do
        oppox, oppoy = opponent.x, opponent.y
        if oppox ~= x or oppoy ~= y then
            local tooppoy, tooppox = oppoy - y, oppox - x
            if tooppox == 0 and tooppoy == 0 then
                tooppox = 1
            end
            self.facex, self.facey = math.norm(tooppox, tooppoy)
            local faceangle = math.atan2(tooppoy, tooppox)
            self:setDirectionalAnimation("Stand", faceangle)

            local dodgeangle = self:findAngleToDodgeIncoming(opponent)
            if dodgeangle then
                return "dodgeIncoming", dodgeangle
            end
        end
        coroutine.yield()
    end

    if opponent.health <= 0 then
        return "stand"
    end

    local toopposq = math.distsq(x, y, oppox, oppoy)
    local attackchoices = self.attackchoices
    if type(attackchoices) == "string" then
        local choices = {}
        for attack in attackchoices:gmatch("%S+") do
            choices[#choices+1] = attack
        end
        attackchoices = choices
        self.attackchoices = choices
    end
    local attacktype = self.defaultattack
    if attackchoices and #attackchoices > 0 then
        for i, attackchoice in ipairs(attackchoices) do
            local attack = Database.get(attackchoice)
            if attack then
                local attackrange = self.TotalAttackRange(attack.attackradius or 0, attack.attacklungespeed or 0, attack.attacklungedecel or 1)
                if attackrange*attackrange >= toopposq then
                    attacktype = attackchoice
                    break
                end
            end
        end
        if not attacktype then
            attacktype = attackchoices[love.math.random(#attackchoices)]
        end
        self.attacktype = attacktype
    end
    Database.fill(self, attacktype)
    local attackradius = self.TotalAttackRange(self.attackradius or 32, self.attacklungespeed or 0, self.attacklungedecel or 1) + opponent.bodyradius
    if not opponent.attacker and toopposq <= attackradius*attackradius then
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

    -- choose animation
    if desty ~= y or destx ~= x then
        local todesty, todestx = desty - y, destx - x
        if todestx == 0 and todesty == 0 then
            todestx = 1
        end
        self.facex, self.facey = math.norm(todestx, todesty)
        local todestangle = math.atan2(todesty, todestx)
        local walkanimation = self.getDirectionalAnimation_angle("Walk", todestangle, self.animationdirections)
        self:changeAseAnimation(walkanimation)
    end

    local speed = self.speed or 2
    if math.distsq(x, y, oppox, oppoy) > 320*320 then
        speed = speed * 1.5
    end

    local reached = false
    for i = 1, (self.approachtime or 60) do
        oppox, oppoy = opponent.x, opponent.y
        local tooppox, tooppoy = oppox - x, oppoy - y
        -- local seesopponent = math.dot(self.facex, self.facey, tooppox, tooppoy) >= 0
        local dodgeangle = self:findAngleToDodgeIncoming(opponent)
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
    if attacktype and math.distsq(x, y, oppox, oppoy) <= attackradius*attackradius then
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

    if targetx and targety then
        local dirx, diry = math.norm(targetx - self.x, targety - self.y)
        if dirx == dirx then
            self.facex, self.facey = dirx, diry
        end
    end

    local angle = math.atan2(self.facey, self.facex)
    self:setDirectionalAnimation(self.windupanimation, angle, 1, self.windupanimationloopframe or 0)

    Audio.play(self.windupsound)
    for i = 1, (self.attackwinduptime or 20) do
        self:accelerateTowardsVel(0, 0, 4)

        -- depending on health:
        -- dodge when player approaches
        -- cancel into another attack which is better for player position
        coroutine.yield()
    end
end

function BanditBoss:executeAttack(attacktype, targetx, targety, targetz)
    if attacktype then
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

    if targetx and targety then
        local dirx, diry = norm(targetx - self.x, targety - self.y)
        if dirx == dirx then
            self.facex, self.facey = dirx, diry
        end
    end

    local angle = atan2(self.facey, self.facex)
    self:setDirectionalAnimation(self.swinganimation, angle, 1, self.swinganimationloopframe or 0)

    Audio.play(self.swingsound)
    local attackprojectile = self.attackprojectile
    if attackprojectile then
        self:launchProjectileAtPosition(attackprojectile, targetx, targety, targetz)
    else
        local attackangle = floor((angle + (pi/4)) / (pi/2)) * pi/2
        self:startAttack(attackangle)
    end

    local lungespeed = self.attacklungespeed or 0
    local hittime = self.attackhittime or 10
    repeat
        lungespeed = Fighter.updateSlideSpeed(self, angle, lungespeed, self.attacklungedecel or 1)
        hittime = hittime - 1
        yield()
        if self.velx ~= 0 or self.vely ~= 0 then
            self:keepInBounds()
        end
    until hittime <= 0

    self:stopAttack()
    if self.attackwindupinvuln then
        self.canbeattacked = true
        self.canbegrabbed = true
    end

    local afterhittime = self.attackafterhittime or 30
    repeat
        lungespeed = Fighter.updateSlideSpeed(self, angle, lungespeed)
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
    local targetx, targety, targetz = opponent.x, opponent.y, opponent.z
    self:prepareAttack(attacktype, opponent)
    self:executeAttack(attacktype, targetx, targety, targetz)
    return "stand", 20
end

function BanditBoss:defeat(attacker)
    Audio.fadeMusic()
    return Enemy.defeat(self, attacker)
end

return BanditBoss
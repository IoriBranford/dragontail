local Database = require "Data.Database"
local Movement = require "Component.Movement"
local Audio    = require "System.Audio"
local Fighter  = require "Dragontail.Character.Fighter"
local Characters = require "Dragontail.Stage.Characters"
local Raycast    = require "Object.Raycast"
local Color      = require "Tiled.Color"
local Dodge      = require "Dragontail.Character.Action.Dodge"
local Slide      = require "Dragontail.Character.Action.Slide"
local Face       = require "Dragontail.Character.Action.Face"
local Shoot      = require "Dragontail.Character.Action.Shoot"
local DirectionalAnimation = require "Dragontail.Character.DirectionalAnimation"

---@class Ambush
---@field ambushsightarc number?

---@class Enemy:Fighter,Ambush
---@field opponents Player[]
---@field approachtime integer?
---@field defaultattack string?
local Enemy = class(Fighter)

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

local lm_random = love.math.random

local function totalAttackRange(attackradius, attacklungespeed, attacklungedecel)
    return attackradius + Slide.GetSlideDistance(attacklungespeed or 0, attacklungedecel or 1)
end
Enemy.TotalAttackRange = totalAttackRange

function Enemy:getAttackFlashColor(t)
    local greenblue = (1+cos(t))/2
    return Color.asARGBInt(1, greenblue, greenblue, 1)
end

function Enemy:getTargetingScore(oppox, oppoy, oppofacex, oppofacey)
    if not self.canbeattacked then
        return huge
    end
    local tooppox, tooppoy = self.x - oppox, self.y - self.z - oppoy
    if math.dot(oppofacex, oppofacey, tooppox, tooppoy) < 0 then
        return huge
    end
    return math.abs(math.det(oppofacex, oppofacey, tooppox, tooppoy))
end

function Enemy:duringStand()
    local opponent = self.opponents[1]
    Face.facePosition(self, opponent.x, opponent.y, "Stand")
    local dodgeangle = self:isFullyOnCamera(self.camera) and Dodge.findDodgeAngle(self)
    if dodgeangle then
        return "dodgeIncoming", dodgeangle
    end
end

function Enemy:decideNextAttack()
    local opponent = self.opponents[1]
    local toopposq = distsq(self.x, self.y, opponent.x, opponent.y)
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
                local attackrange = totalAttackRange(attack.attackradius or 0, attack.attacklungespeed or 0, attack.attacklungedecel or 1)
                if attackrange*attackrange >= toopposq then
                    attacktype = attackchoice
                    break
                end
            end
        end
        if not attacktype then
            attacktype = attackchoices[lm_random(#attackchoices)]
        end
    end
    return attacktype
end

function Enemy:afterStand()
    local opponent = self.opponents[1]
    if opponent.health <= 0 then
        return "stand"
    end

    local attacktype = self:decideNextAttack()

    local toopposq = distsq(self.x, self.y, opponent.x, opponent.y)
    local attackradius = totalAttackRange(self.attackradius or 32, self.attacklungespeed or 0, self.attacklungedecel or 1) + opponent.bodyradius
    if not opponent.attacker
    and opponent.canbeattacked
    and toopposq <= attackradius*attackradius
    and self:isFullyOnCamera(self.camera)
    then
        opponent.attacker = self
        return attacktype
    end
    return "approach"
end

function Enemy:stand(duration)
    duration = duration or 20
    self.velx, self.vely = 0, 0
    for _ = 1, duration do
        local state, a, b, c, d, e, f = self:duringStand()
        if state then
            return state, a, b, c, d, e, f
        end
        yield()
    end
    return self:afterStand() or "stand"
end

function Enemy:dodgeIncoming(dodgeangle)
    local opponent = self.opponents[1]
    local newstate, a, b, c, d, e, f = Dodge.dodge(self, opponent, dodgeangle)
    if newstate then
        return newstate, a, b, c, d, e, f
    end
    return "stand"
end

function Enemy:findAttackerSlot(opponent)
    local bodyradius = self.bodyradius
    local attackradius = totalAttackRange(self.attackradius or 64, self.attacklungespeed or 0, self.attacklungedecel or 1) + opponent.bodyradius
    local attackerslot
    if self.attackprojectile then
        attackerslot = opponent:findRandomAttackerSlot(bodyradius, "missile")
    else
        attackerslot = opponent:findRandomAttackerSlot(attackradius + bodyradius, "melee")
    end
    return attackerslot
end

function Enemy:getAttackerSlotPosition(opponent, attackerslot)
    local bodyradius = self.bodyradius
    local attackradius = totalAttackRange(self.attackradius or 64, self.attacklungespeed or 0, self.attacklungedecel or 1) + opponent.bodyradius
    local oppox, oppoy = opponent.x, opponent.y
    local destx, desty
    if self.attackprojectile then
        destx, desty = attackerslot:getFarPosition(oppox, oppoy, bodyradius)
    else
        destx, desty = attackerslot:getPosition(oppox, oppoy, attackradius)
    end
    return destx, desty
end

function Enemy:navigateAroundSolid(destx, desty)
    local x, y = self.x, self.y
    local bodyradius = self.bodyradius
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
    return destx, desty
end

function Enemy:duringApproach(target)
end

function Enemy:approach()
    local opponent = self.opponents[1] ---@type Player

    local attackerslot = self:findAttackerSlot(opponent)
    if not attackerslot then
        return "stand", 10
    end
    local destx, desty = self:navigateAroundSolid(self:getAttackerSlotPosition(opponent, attackerslot))

    Face.faceVector(self, destx - self.x, desty - self.y, "Walk")

    local speed = self.speed or 2
    if distsq(self.x, self.y, opponent.x, opponent.y) > 320*320 then
        speed = speed * 1.5
    end

    local reached = false
    for i = 1, (self.approachtime or 60) do
        local state, a, b, c, d, e, f = self:duringApproach(opponent)
        if state then
            return state, a, b, c, d, e, f
        end
        self.velx, self.vely = Movement.getVelocity_speed(self.x, self.y, destx, desty, speed)
        yield()
        if self.x == destx and self.y == desty then
            reached = true
            break
        end
    end

    local attacktype = not opponent.attacker and self.attacktype
    if attacktype and opponent.canbeattacked then
        local attackradius = totalAttackRange(self.attackradius or 64, self.attacklungespeed or 0, self.attacklungedecel or 1) + opponent.bodyradius

        if distsq(self.x, self.y, opponent.x, opponent.y) <= attackradius*attackradius then
            Face.facePosition(self, opponent.x, opponent.y)
            return attacktype
        end
    end
    if reached then
        return "stand", 10
    end
    return "stand", 5
end

function Enemy:leave(exitx, exity)
    self.recoverai = "leave"
    exitx = exitx or self.exitpoint
    self:walkTo(exitx, exity)
    self.exitpoint:disappear()
    self:disappear()
end

function Enemy:enterShootLeave()
    self.recoverai = "enterShootLeave"

    if self.entrypoint then
        if self:walkTo(self.entrypoint) then
            self.entrypoint:disappear()
            self.entrypoint = nil
        end
    end

    local attacktype = self.defaultattack
    if attacktype then
        Database.fill(self, attacktype)
        local ammo = self.ammo or 10
        local opponent = self.opponents[1]
        local raycast = Raycast(1, 0, 0, 1)
        raycast.canhitgroup = "enemies"
        for i = ammo-1, 0, -1 do
            while opponent.health <= 0 do
                yield()
            end
            local hitcharacter
            repeat
                yield()
                raycast.dx, raycast.dy = opponent.x - self.x, opponent.y - self.y
                local angle = atan2(raycast.dy, raycast.dx)
                if angle == angle then
                    DirectionalAnimation.set(self, "Stand", angle)
                end
                hitcharacter = Characters.castRay(raycast, self.x, self.y, self)
            until not hitcharacter
            self.ammo = i
            self:attack()
        end
    end

    if self.exitpoint then
        return "leave", self.exitpoint
    end

    self:disappear()
end

function Enemy:duringPrepareAttack(target)
    self:accelerateTowardsVel(0, 0, 4)
end

function Enemy:interruptWithDodge(target)
    if target then
        local dodgeangle = Dodge.findDodgeAngle(self)
        if dodgeangle then
            if target.attacker == self then
                target.attacker = nil
            end
            return "dodgeIncoming", dodgeangle
        end
    end
end

function Enemy:prepareAttack(targetx, targety)
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

    targetx = targetx or self.x
    targety = targety or self.y
    Face.faceVector(self, targetx - self.x, targety - self.y, self.windupanimation, 1, self.windupanimationloopframe or 0)

    for t = 1, (self.attackwinduptime or 20) do
        self.color = self:getAttackFlashColor(t)

        local state, a, b, c, d, e, f = self:duringPrepareAttack(target)
        if state then
            return state, a, b, c, d, e, f
        end

        yield()
        if self.velx ~= 0 or self.vely ~= 0 then
            self:keepInBounds()
        end
    end
end

function Enemy:duringAttackSwing(target)
end

function Enemy:executeAttack(targetx, targety, targetz)
    self.numopponentshit = 0
    self:stopGuarding()

    local target
    if type(targetx) == "table" then
        target = targetx
        target.attacker = self
        targetx, targety, targetz = target.x, target.y, target.z
    end

    targetx = targetx or (self.x + cos(self.faceangle))
    targety = targety or (self.y + sin(self.faceangle))
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
    repeat
        lungespeed = Slide.updateSlideSpeed(self, self.faceangle, lungespeed, self.attacklungedecel or 1)
        local state, a, b, c, d, e, f = self:duringAttackSwing(target)
        if state then
            return state, a, b, c, d, e, f
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

function Enemy:attack()
    local opponent = self.opponents[1]
    local targetx, targety, targetz = opponent.x, opponent.y, opponent.z
    local state, a, b, c, d, e, f = self:prepareAttack(opponent)
    if state then
        return state, a, b, c, d, e, f
    end
    state, a, b, c, d, e, f = self:executeAttack(targetx, targety, targetz)
    if state then
        return state, a, b, c, d, e, f
    end
    return "stand", 20
end

function Enemy:enterAndDropDown()
    if self.entrypoint then
        if self:walkTo(self.entrypoint) then
            self.entrypoint = nil
        end
    end
    self.gravity = max(self.gravity or 0.25, 0.25)
    repeat
        yield()
    until self.z == Characters.getCylinderFloorZ(self.x, self.y, self.z, self.bodyradius, self.bodyheight)
    Audio.play(self.jumplandsound)
    self:changeAnimation("FallRiseFromKnees", 1, 0)
    Characters.spawn({
        type = "spark-land-on-feet-dust",
        x = self.x,
        y = self.y + 1,
        z = self.z,
    })
    coroutine.wait(9)
    return "stand", 3
end

function Enemy:enterAndAmbush()
    if self.entrypoint then
        if self:walkTo(self.entrypoint) then
            self.entrypoint = nil
        end
    end
    self:prepareAttack(self.defaultattack)
    local opponents = self.opponents
    local sighted
    local cossightarc = cos(self.ambushsightarc or (pi/6))
    repeat
        yield()
        for _, opponent in ipairs(opponents) do
            local tooppox, tooppoy = opponent.x - self.x, opponent.y - self.y
            if tooppox == 0 and tooppoy == 0 then
                tooppox = 1
            else
                tooppox, tooppoy = norm(tooppox, tooppoy)
            end
            local fDotD = math.dot(tooppox, tooppoy, math.cos(self.faceangle), math.sin(self.faceangle))
            if fDotD >= cossightarc then
                sighted = opponent
                break
            end
        end
    until sighted
    self:executeAttack(self.defaultattack, sighted)
    return "stand", 20
end

function Enemy:guard()
    self.velx, self.vely = 0, 0
    local t = self.guardtime or 60
    local opponent = self.opponents[1]
    repeat
        local guardangle = 0
        if opponent.y ~= self.y or opponent.x ~= self.x then
            guardangle = atan2(opponent.y - self.y, opponent.x - self.x)
        end
        self:startGuarding(guardangle)
        DirectionalAnimation.set(self, "guard", guardangle, 1, 0)
        yield()
        t = t - 1
    until t <= 0
    self:stopGuarding()
    self.numguardedhits = 0
    return "stand"
end

function Enemy:guardHit(attacker)
    -- local facex, facey = math.cos(self.faceangle), math.sin(self.faceangle)
    -- local guardarc = self.guardarc or (pi/2)
    -- local toattackerx = -self.x + attacker.x
    -- local toattackery = -self.y + attacker.y
    -- local toattackerdist = len(toattackerx, toattackery)
    -- local dotGA = dot(toattackerx, toattackery, facex, facey)
    -- if dotGA >= cos(guardarc) * toattackerdist then
    Audio.play(self.guardhitsound)
    self:makeImpactSpark(attacker, attacker.guardhitspark)
    self.hurtstun = attacker.attackguardstun or 6
    yield()

    self.numguardedhits = (self.numguardedhits or 0) + 1
    local guardcounterattack = self.guardcounterattack
    local guardhitstocounterattack = self.guardhitstocounterattack or 3
    if guardcounterattack then
        -- print(guardcounterattack, guardhitstocounterattack, self.numguardedhits, self.attackwindupinvuln)
        if self.numguardedhits >= guardhitstocounterattack then
            self.numguardedhits = 0
            self:stopGuarding()
            return guardcounterattack
        end
    end
    return "guard"
        -- local afterguardattacktype = self.afterguardattacktype
        -- if afterguardattacktype then
        --     return afterguardattacktype
        -- end
        -- return afterguardhitai or "stand"
    -- end
    -- return self:hurt(attacker)
end

return Enemy
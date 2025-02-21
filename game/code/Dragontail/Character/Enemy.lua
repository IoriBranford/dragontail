local Database = require "Data.Database"
local Movement = require "Component.Movement"
local Audio    = require "System.Audio"
local Fighter  = require "Dragontail.Character.Fighter"
local Characters = require "Dragontail.Stage.Characters"
local Raycast    = require "Object.Raycast"
local Color      = require "Tiled.Color"

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
    return attackradius + Fighter.GetSlideDistance(attacklungespeed or 0, attacklungedecel or 1)
end
Enemy.TotalAttackRange = totalAttackRange

function Enemy:getAttackFlashColor(t)
    local greenblue = (1+cos(t))/2
    return Color.asARGBInt(1, greenblue, greenblue, 1)
end

function Enemy:findAngleToDodgeIncoming(incoming)
    local dodgespeed = self.dodgespeed
    if not dodgespeed then
        return
    end
    local oppox, oppoy, oppovelx, oppovely
    oppox, oppoy = incoming.x, incoming.y
    oppovelx, oppovely = incoming.velx, incoming.vely
    local fromoppoy, fromoppox = self.y - oppoy, self.x - oppox
    local oppospeedsq = math.lensq(oppovelx, oppovely)
    local dsq = math.lensq(fromoppox, fromoppoy)
    local dodgewithintime = self.dodgewithintime or 30
    if dsq > oppospeedsq * dodgewithintime * dodgewithintime then
        return
    end
    local vdotd = math.dot(oppovelx, oppovely, fromoppox, fromoppoy)
    if vdotd <= math.sqrt(dsq)*math.sqrt(oppospeedsq)/2 then
        return
    end

    local dodgedist = Fighter.GetSlideDistance(dodgespeed, self.dodgedecel or 1)
    local dodgedirx, dodgediry = 1, 0
    if dsq > 0 then
        dodgedirx, dodgediry = math.norm(fromoppox, fromoppoy)
    end
    local dodgespacex, dodgespacey = dodgedirx * dodgedist, dodgediry * dodgedist
    local raycast = Raycast(dodgespacex, dodgespacey, 0, 1, self.bodyradius/2)
    raycast.canhitgroup = "solids"

    if Characters.castRay(raycast, self.x, self.y) then
        -- Dodge along wall
        local ax, ay = raycast.hitwallx, raycast.hitwally
        local bx, by = raycast.hitwallx2, raycast.hitwally2

        raycast.dx, raycast.dy = math.norm(bx - ax, by - ay)
        raycast.dx = raycast.dx * dodgedist
        raycast.dy = raycast.dy * dodgedist
        if math.dot(dodgedirx, dodgediry, raycast.dx, raycast.dy) < 0 then
            raycast.dx, raycast.dy = -raycast.dx, -raycast.dy
        end
        if Characters.castRay(raycast, self.x, self.y) then
            raycast.dx, raycast.dy = -raycast.dx, -raycast.dy
        end
    elseif oppospeedsq >= dodgespeed*dodgespeed then
        local rot90dir = math.det(oppovelx, oppovely, fromoppox, fromoppoy)
        raycast.dx, raycast.dy = math.rot90(raycast.dx, raycast.dy, rot90dir)
        if Characters.castRay(raycast, self.x, self.y) then
            raycast.dx, raycast.dy = -raycast.dx, -raycast.dy
        end
    end
    return math.atan2(raycast.dy, raycast.dx)
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

function Enemy:stand(duration)
    duration = duration or 20
    self.velx, self.vely = 0, 0
    local x, y = self.x, self.y
    local opponent = self.opponents[1]
    local oppox, oppoy
    for _ = 1, duration do
        oppox, oppoy = opponent.x, opponent.y
        if oppox ~= x or oppoy ~= y then
            local tooppoy, tooppox = oppoy - y, oppox - x
            if tooppox == 0 and tooppoy == 0 then
                tooppox = 1
            end
            self:faceDir(tooppox, tooppoy, "Stand")

            local dodgeangle = self:isFullyOnCamera(self.camera) and self:findAngleToDodgeIncoming(opponent)
            if dodgeangle then
                return "dodgeIncoming", dodgeangle
            end
        end
        yield()
    end

    if opponent.health <= 0 then
        return "stand"
    end

    local toopposq = distsq(x, y, oppox, oppoy)
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
        self.attacktype = attacktype
    end
    Database.fill(self, attacktype)
    local attackradius = totalAttackRange(self.attackradius or 32, self.attacklungespeed or 0, self.attacklungedecel or 1) + opponent.bodyradius
    if not opponent.attacker
    and opponent.canbeattacked
    and toopposq <= attackradius*attackradius
    and self:isFullyOnCamera(self.camera)
    then
        return "attack", attacktype
    end
    return "approach"
end

function Enemy:dodgeIncoming(dodgeangle)
    local opponent = self.opponents[1]
    local x, y, oppox, oppoy = self.x, self.y, opponent.x, opponent.y
    local tooppox, tooppoy = oppox - x, oppoy - y
    if tooppox == 0 and tooppoy == 0 then
        tooppox = 1
    end
    tooppox, tooppoy = math.norm(tooppox, tooppoy)
    self:faceDir(tooppox, tooppoy, "Walk")
    Audio.play(self.stopdashsound)
    self:slide(dodgeangle, self.dodgespeed, self.dodgedecel)

    -- local attacktype = not opponent.attacker and self.attacktype
    -- if attacktype then
    --     local attackradius = self.attackradius
    --     x, y, oppox, oppoy = self.x, self.y, opponent.x, opponent.y
    --     if distsq(x, y, oppox, oppoy) <= attackradius*attackradius then
    --         return "attack", attacktype
    --     end
    -- end
    return "stand"
end

function Enemy:approach()
    local x, y = self.x, self.y
    local opponent = self.opponents[1] ---@type Player
    local oppox, oppoy = opponent.x, opponent.y
    local bodyradius = self.bodyradius

    local attackradius = totalAttackRange(self.attackradius or 64, self.attacklungespeed or 0, self.attacklungedecel or 1) + opponent.bodyradius
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
        todestx, todesty = math.norm(todestx, todesty)
        self:faceDir(todestx, todesty, "Walk")
    end

    local speed = self.speed or 2
    if distsq(x, y, oppox, oppoy) > 320*320 then
        speed = speed * 1.5
    end

    local reached = false
    for i = 1, (self.approachtime or 60) do
        oppox, oppoy = opponent.x, opponent.y
        local tooppox, tooppoy = oppox - x, oppoy - y
        -- local seesopponent = math.dot(self.facex, self.facey, tooppox, tooppoy) >= 0
        local dodgeangle = self:isFullyOnCamera(self.camera) and self:findAngleToDodgeIncoming(opponent)
        if dodgeangle then
            return "dodgeIncoming", dodgeangle
        end
        self.velx, self.vely = Movement.getVelocity_speed(self.x, self.y, destx, desty, speed)
        yield()
        if self.x == destx and self.y == desty then
            reached = true
            break
        end
    end

    local attacktype = not opponent.attacker and self.attacktype
    if attacktype
    and opponent.canbeattacked
    and distsq(x, y, oppox, oppoy) <= attackradius*attackradius then
        return "attack", attacktype
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
                    self:setDirectionalAnimation("Stand", angle)
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

function Enemy:prepareAttack(attacktype, targetx, targety)
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
        local dirx, diry = norm(targetx - self.x, targety - self.y)
        if dirx == dirx then
            self.facex, self.facey = dirx, diry
        end
    end

    local angle = atan2(self.facey, self.facex)
    self:setDirectionalAnimation(self.windupanimation, angle, 1, self.windupanimationloopframe or 0)

    Audio.play(self.windupsound)
    for t = 1, (self.attackwinduptime or 20) do
        self:accelerateTowardsVel(0, 0, 4)
        self.color = self:getAttackFlashColor(t)
        -- if target then
        --     local dodgeangle = self:findAngleToDodgeIncoming(target)
        --     if dodgeangle then
        --         target.attacker = nil
        --         return "dodgeIncoming", dodgeangle
        --     end
        -- end
        yield()
    end
end

function Enemy:executeAttack(attacktype, targetx, targety, targetz)
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
        lungespeed = Fighter.updateSlideSpeed(self, angle, lungespeed)
        afterhittime = afterhittime - 1
        yield()
        if self.velx ~= 0 or self.vely ~= 0 then
            self:keepInBounds()
        end
    until afterhittime <= 0
end

function Enemy:attack(attacktype)
    local opponent = self.opponents[1]
    local targetx, targety, targetz = opponent.x, opponent.y, opponent.z
    local state, a, b, c, d, e, f = self:prepareAttack(attacktype, opponent)
    if state then
        return state, a, b, c, d, e, f
    end
    state, a, b, c, d, e, f = self:executeAttack(attacktype, targetx, targety, targetz)
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
            local fDotD = math.dot(tooppox, tooppoy, self.facex, self.facey)
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
        local guardanimation = self.getDirectionalAnimation_angle("guard", guardangle, self.animationdirections)
        self:changeAseAnimation(guardanimation, 1, 0)
        yield()
        t = t - 1
    until t <= 0
    self:stopGuarding()
    self.numguardedhits = 0
    return "stand"
end

function Enemy:guardHit(attacker)
    -- local facex, facey = self.facex, self.facey
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
            return "attack", guardcounterattack
        end
    end
    return "guard"
        -- local afterguardattacktype = self.afterguardattacktype
        -- if afterguardattacktype then
        --     return "attack", afterguardattacktype
        -- end
        -- return afterguardhitai or "stand"
    -- end
    -- return self:hurt(attacker)
end

return Enemy
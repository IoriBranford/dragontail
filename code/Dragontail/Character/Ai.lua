local Movement  = require "Component.Movement"
local Audio     = require "System.Audio"
local Database    = require "Data.Database"
local Script      = require "Component.Script"
local Stage = require "Dragontail.Stage"
local co_create = coroutine.create
local yield = coroutine.yield
local resume = coroutine.resume
local status = coroutine.status
local wait = coroutine.wait
local waitfor = coroutine.waitfor
local norm = math.norm
local distsq = math.distsq
local pi = math.pi
local floor = math.floor
local atan2 = math.atan2
local lm_random = love.math.random
local cos = math.cos
local sin = math.sin
local max = math.max
local mid = math.mid
local huge = math.huge
local Ai = {}

function Ai:spark()
    wait(self.sparktime or 30)
    self:disappear()
end

local function moveTo(self, destx, desty, speed, timelimit)
    timelimit = timelimit or huge
    waitfor(function()
        local x, y = self.x, self.y
        timelimit = timelimit - 1
        if timelimit <= 0 or x == destx and y == desty then
            return true
        end
        self.velx, self.vely = Movement.getVelocity_speed(x, y, destx, desty, speed)
    end)
    return self.x == destx and self.y == desty
end

function Ai:stopHolding(held)
    if self then
        self.heldopponent = nil
    end
    if held then
        held.heldby = nil
        held.bodysolid = true
        held.hurtstun = 0
    end
end
local stopHolding = Ai.stopHolding

local function attackLungeDist(speed)
    if speed <= 0 then
        return 0
    end
    return speed + attackLungeDist(speed-1)
end

local function totalAttackRange(attackradius, attacklungespeed)
    return attackradius + attackLungeDist(attacklungespeed or 0)
end

local function faceDir(self, dx, dy)
    self.facex, self.facey = norm(dx, dy)
end

function Ai:stand(duration)
    duration = duration or 20
    self.velx, self.vely = 0, 0
    local x, y = self.x, self.y
    local i = 1
    local opponent = self.opponent
    local oppox, oppoy
    waitfor(function()
        oppox, oppoy = opponent.x, opponent.y
        if oppox ~= x or oppoy ~= y then
            local tooppoy, tooppox = oppoy - y, oppox - x
            faceDir(self, tooppox, tooppoy)
            local faceangle = atan2(tooppoy, tooppox)
            local standanimation = self.getDirectionalAnimation_angle("stand", faceangle, 4)
            self.sprite:changeAsepriteAnimation(standanimation)
        end
        i = i + 1
        return i > duration
    end)

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
    local attacktype
    if attackchoices and #attackchoices > 0 then
        for i, attackchoice in ipairs(attackchoices) do
            local attack = Database.get(self.type.."-"..attackchoice)
            if attack then
                local attackrange = totalAttackRange(attack.attackradius or 0, attack.attacklungespeed or 0)
                if attackrange*attackrange >= toopposq then
                    attacktype = attackchoice
                    break
                end
            end
        end
        if not attacktype then
            attacktype = attackchoices[lm_random(#attackchoices)]
        end
    else
        attacktype = "attack"
    end
    self.attacktype = attacktype
    Database.fill(self, self.type.."-"..attacktype)
    local attackradius = totalAttackRange(self.attackradius or 32, self.attacklungespeed or 0) + opponent.bodyradius
    if toopposq <= attackradius*attackradius then
        return "attack", attacktype
    end
    return "approach"
end

function Ai:approach()
    local x, y = self.x, self.y
    local opponent = self.opponent
    local oppox, oppoy = opponent.x, opponent.y
    local bodyradius = self.bodyradius
    local bounds = self.bounds
    local minx, miny = bounds.x + bodyradius, bounds.y + bodyradius
    local maxx, maxy = bounds.x + bounds.width - bodyradius, bounds.y + bounds.height - bodyradius

    -- choose dest
    local destanglefromoppo = lm_random(4)*pi/2
    local attackradius = totalAttackRange(self.attackradius or 64, self.attacklungespeed or 0) + opponent.bodyradius
    local destx, desty
    repeat
        destx = oppox + cos(destanglefromoppo) * attackradius
        desty = oppoy + sin(destanglefromoppo) * attackradius
        destanglefromoppo = destanglefromoppo + pi/2
        if destanglefromoppo > 4*pi then
            return "stand", 10
        end
    until minx <= destx and destx <= maxx and miny <= desty and desty <= maxy

    -- choose animation
    if desty ~= y or destx ~= x then
        local todesty, todestx = desty - y, destx - x
        faceDir(self, todestx, todesty)
        local todestangle = atan2(todesty, todestx)
        local walkanimation = self.getDirectionalAnimation_angle("walk", todestangle, 4)
        self.sprite:changeAsepriteAnimation(walkanimation)
    end

    local speed = self.speed or 2
    if distsq(x, y, oppox, oppoy) > 320*320 then
        speed = speed * 1.5
    end
    local reached = moveTo(self, destx, desty, speed, self.approachtime or 60)
    oppox, oppoy = opponent.x, opponent.y
    local attacktype = self.attacktype
    if attacktype and distsq(x, y, oppox, oppoy) <= attackradius*attackradius then
        return "attack", attacktype
    end
    if reached then
        return "stand", 10
    end
    return "stand", 5
end

local function updateLungeAttack(self, attackangle, lungespeed)
    self.velx = lungespeed * cos(attackangle)
    self.vely = lungespeed * sin(attackangle)
    lungespeed = max(0, lungespeed - 1)
    return lungespeed
end

function Ai:attack(attackname)
    attackname = attackname or "attack"
    self:stopGuarding()
    if self.attackwindupinvuln then
        self.hitreactiondisabled = true
    end
    self.velx, self.vely = 0, 0

    local x, y = self.x, self.y
    local bounds = self.bounds
    local opponent = self.opponent
    local oppox, oppoy = opponent.x, opponent.y
    local tooppox, tooppoy = oppox - x, oppoy - y
    local tooppoangle = 0
    if oppox ~= x and oppoy ~= y then
        faceDir(self, tooppox, tooppoy)
        tooppoangle = atan2(tooppoy, tooppox)
    end
    local animation = self.getDirectionalAnimation_angle(attackname.."A", tooppoangle, 4)
    self.sprite:changeAsepriteAnimation(animation, 1, "stop")

    Audio.play(self.windupsound)
    wait(self.attackwinduptime or 20)

    Audio.play(self.swingsound)
    local attackprojectile = self.attackprojectile
    if attackprojectile then
        local bodyradius = self.bodyradius or 0

        Stage.addCharacter({
            x = x + bodyradius*cos(tooppoangle),
            y = y + bodyradius*sin(tooppoangle),
            type = attackprojectile,
            attackangle = tooppoangle,
            shooter = self
        })
    else
        local attackangle = floor((tooppoangle + (pi/4)) / (pi/2)) * pi/2
        self:startAttack(attackangle)
    end

    local lungespeed = self.attacklungespeed or 0

    animation = self.getDirectionalAnimation_angle(attackname.."B", tooppoangle, 4)
    self.sprite:changeAsepriteAnimation(animation, 1, "stop")
    local hittime = self.attackhittime or 10
    repeat
        lungespeed = updateLungeAttack(self, tooppoangle, lungespeed)
        hittime = hittime - 1
        yield()
        self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
    until hittime <= 0

    self:stopAttack()
    self.hitreactiondisabled = nil

    local afterhittime = self.attackafterhittime or 30
    repeat
        lungespeed = updateLungeAttack(self, tooppoangle, lungespeed)
        afterhittime = afterhittime - 1
        yield()
        self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
    until afterhittime <= 0

    return "stand", 20
end

function Ai:guard()
    self.velx, self.vely = 0, 0
    local t = self.guardtime or 60
    local opponent = self.opponent
    repeat
        local guardangle = atan2(opponent.y - self.y, opponent.x - self.x)
        self:startGuarding(guardangle)
        local guardanimation = self.getDirectionalAnimation_angle("guard", guardangle, 4)
        self.sprite:changeAsepriteAnimation(guardanimation, 1, "stop")
        yield()
        t = t - 1
    until t <= 0
    self:stopGuarding()
    self.numguardedhits = 0
    return "stand"
end

function Ai:guardHit(attacker)
    -- local facex, facey = self.facex, self.facey
    -- local guardarc = self.guardarc or (pi/2)
    -- local toattackerx = -self.x + attacker.x
    -- local toattackery = -self.y + attacker.y
    -- local toattackerdist = len(toattackerx, toattackery)
    -- local dotGA = dot(toattackerx, toattackery, facex, facey)
    -- if dotGA >= cos(guardarc) * toattackerdist then
    Audio.play(self.guardhitsound)
    local hitspark = attacker.guardhitspark
    if hitspark then
        local hitsparkcharacter = {
            type = hitspark,
        }
        hitsparkcharacter.x, hitsparkcharacter.y = mid(attacker.x, attacker.y, self.x, self.y)
        Stage.addCharacter(hitsparkcharacter)
    end
    self.hurtstun = attacker.attackguardstun or 6
    yield()

    self.numguardedhits = (self.numguardedhits or 0) + 1
    local guardcounterattack = self.guardcounterattack
    local guardhitstocounterattack = self.guardhitstocounterattack or 3
    if guardcounterattack then
        Database.fill(self, self.type..'-'..guardcounterattack)
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
        -- return self.afterguardhitai or "stand"
    -- end
    -- return self:hurt(attacker)
end

function Ai:hurt(attacker)
    local hitspark = attacker.hitspark
    if hitspark then
        local hitsparkcharacter = {
            type = hitspark,
        }
        hitsparkcharacter.x, hitsparkcharacter.y = mid(attacker.x, attacker.y, self.x, self.y)
        Stage.addCharacter(hitsparkcharacter)
    end
    self.health = self.health - attacker.attackdamage
    self.canbegrabbed = nil
    self.velx, self.vely = 0, 0
    self:stopAttack()
    local heldopponent = self.heldopponent
    local heldby = self.heldby
    stopHolding(self, heldopponent)
    stopHolding(heldby, self)
    self.hurtstun = attacker.attackstun or 3
    local facex, facey = self.facex or 1, self.facey or 0
    local hurtanimation = self.getDirectionalAnimation_angle("hurt", atan2(facey, facex), 2)
    local aseprite = self.sprite and self.sprite.aseprite
    if aseprite and aseprite:getAnimation(hurtanimation) then
        self.sprite:changeAsepriteAnimation(hurtanimation, 1, "stop")
    end

    local hitsound = attacker.hitsound
    if self.health <= 0 then
        hitsound = attacker.attackdefeatsound or hitsound
    end
    Audio.play(hitsound)
    local attackangle = attacker.attackangle
    yield()

    if self.health <= 0 then
        local defeateffect = attacker.attackdefeateffect or self.defeatai or "defeat"
        return defeateffect, attacker, attackangle
    else
        local hiteffect = attacker.attackhiteffect
        if hiteffect then
            return hiteffect, attacker, attackangle
        end
    end
    Audio.play(self.hurtsound)
    local recoverai = self.hurtrecoverai
    if not recoverai then
        print("No hurtrecoverai for "..self.type)
        return "defeat", attacker
    end
    self.canbegrabbed = true
    return recoverai
end

-- function Ai:stun(duration)
--     self:stopAttack()
--     self.velx, self.vely = 0, 0
--     self.sprite:changeAsepriteAnimation("collapseA", 1, "stop")
--     Audio.play(self.stunsound)
--     self.canbegrabbed = true
--     duration = duration or 120
--     wait(duration)
--     self.canbegrabbed = nil
--     return "defeat", "collapseB"
-- end

function Ai:held(holder)
    self:stopAttack()
    self.velx, self.vely = 0, 0

end

function Ai:thrown(thrower, attackangle)
    local dirx, diry
    if attackangle then
        dirx, diry = cos(attackangle), sin(attackangle)
        self:startAttack(attackangle)
    else
        local velx, vely = thrower.velx, thrower.vely
        if velx ~= 0 or vely ~= 0 then
            dirx, diry = norm(velx, vely)
        else
            dirx, diry = norm(self.x - thrower.x, self.y - thrower.y)
        end
    end
    self.canbegrabbed = nil
    self.bodysolid = false
    self.hurtstun = 0
    self.sprite:changeAsepriteAnimation("spin")
    Database.fill(self, "human-thrown")
    local thrownspeed = self.knockedspeed or 8
    self.velx, self.vely = dirx*thrownspeed, diry*thrownspeed
    local thrownsound = Audio.newSource(self.swingsound)
    thrownsound:play()
    local bounds = self.bounds
    local recovertime = huge
    if self.health > 0 then
        recovertime = self.thrownrecovertime or 30
    end
    local oobx, ooby
    repeat
        yield()
        oobx, ooby = self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
        recovertime = recovertime - 1
    until recovertime <= 0 or oobx or ooby
    thrownsound:stop()
    if oobx or ooby then
        return "wallSlammed", thrower, oobx, ooby
    end
    local thrownrecoverai = self.thrownrecoverai
    if thrownrecoverai then
        return thrownrecoverai, thrower
    end
    return self.hurtrecoverai
end

function Ai:wallSlammed(thrower, oobx, ooby)
    self:stopAttack()
    Audio.play(self.bodyslamsound)
    self.health = self.health - (self.wallslamdamage or 25)
    self.hurtstun = self.wallslamstun or 20
    yield()
    local wallslamcounterattack = self.wallslamcounterattack
    if self.health > 0 and wallslamcounterattack then
        Database.fill(self, self.type.."-"..wallslamcounterattack)
        self.canbegrabbed = true
        self.bodysolid = true
        return "attack", wallslamcounterattack, atan2(-(ooby or 0), -(oobx or 0))
    end
    return "fall", thrower
end

function Ai:thrownRecover(thrower)
    self.canbegrabbed = true
    if self.thrownrecoveranimation then
        self.sprite:changeAsepriteAnimation(self.thrownrecoveranimation, 1, "stop")
    end
    Audio.play(self.thrownrecoversound)
    local bounds = self.bounds
    local recovertime = self.thrownrecovertime or 10
    local oobx, ooby
    repeat
        yield()
        self:accelerateTowardsVel(0, 0, recovertime)
        oobx, ooby = self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
        recovertime = recovertime - 1
    until recovertime <= 0 or oobx or ooby

    self:stopAttack()
    if oobx or ooby then
        return "wallSlammed", thrower, oobx, ooby
    end

    self.bodysolid = true
    return self.hurtrecoverai
end

function Ai:fall(attacker)
    self.canbegrabbed = nil
    self:stopAttack()
    self.velx, self.vely = 0, 0
    local defeatanimation = self.defeatanimation or "collapse"
    self.sprite:changeAsepriteAnimation(defeatanimation, 1, "stop")
    wait(20)
    Audio.play(self.bodydropsound)

    if self.health > 0 then
        wait(self.downtime or 30)
        return self.getupai or "getup", attacker
    end
    return "defeat", attacker
end

function Ai:blinkOut(t)
    t = t or 30
    local sprite = self.sprite
    if sprite then
        for i = 1, t do
            sprite.alpha = cos(i)
            yield()
        end
    end
    self:disappear()
end

function Ai:defeat(attacker)
    self.canbegrabbed = nil
    self:stopAttack()
    self.velx, self.vely = 0, 0
    local defeatanimation = self.defeatanimation or "collapse"
    self.sprite:changeAsepriteAnimation(defeatanimation, 1, "stop")
    Audio.play(self.defeatsound)
    yield()
    return "blinkOut", 60
end

function Ai:getup(attacker)
    self.sprite:changeAsepriteAnimation("getup", 1, "stop")
    wait(27)
    local recoverai = self.hurtrecoverai
    if not recoverai then
        print("No hurtrecoverai for "..self.type)
        return "defeat", attacker
    end
    self.canbegrabbed = true
    self.bodysolid = true
    return recoverai
end

function Ai:containerWaitForBreak()
    local solids = self.solids
    while true do
        yield()
        for _, solid in ipairs(solids) do
            if self:collideWithCharacterAttack(solid) then
                return "containerBreak"
            end
        end
    end
end

function Ai:containerBreak(attacker)
    self.bodysolid = false
    Audio.play(self.defeatsound)
    self.sprite:changeAsepriteAnimation("collapse", 1, "stop")
    local item = self.item
    if item then
        item.opponent = self.opponent
        Script.start(item, "itemDrop")
    end
    yield()
    return "blinkOut", 30
end

function Ai:itemDrop(y0)
    local popoutspeed = self.popoutspeed or 8
    local gravity = self.dropgravity or .5
    repeat
        yield()
        popoutspeed = popoutspeed - gravity
        self.z = self.z + popoutspeed
    until self.z <= 0
    self.z = 0
    return "itemWaitForPickup"
end

function Ai:itemWaitForPickup()
    local opponent = self.opponent
    while true do
        local finished
        if self:testBodyCollision(opponent) then
            if self.healhealth then
                if opponent.health < opponent.maxhealth then
                    Audio.play(self.healsound)
                    opponent:heal(self.healhealth)
                    finished = true
                end
            end
        end
        if finished then
            self:disappear()
            break
        end
        yield()
    end
end

function Ai:projectileHit(opponent)
    if opponent then
        -- Audio.play(self.hitsound)
    else
        Audio.play(self.bodyslamsound)
    end
    local attackhitanimation = self.attackhitanimation
    local sprite = self.sprite
    if sprite and attackhitanimation then
        attackhitanimation = self.getDirectionalAnimation_angle(attackhitanimation, self.attackangle, 4)
        self.sprite:changeAsepriteAnimation(attackhitanimation)
    end
    self.bodysolid = false
    self:stopAttack()
    self.velx, self.vely = 0, 0
    yield()
    return "blinkOut", 30
end

function Ai:projectileFly(shooter, angle)
    angle = angle or self.attackangle
    Database.fill(self, self.type.."-attack")
    local bounds = self.bounds
    local speed = self.speed
    self.velx = speed*cos(angle)
    self.vely = speed*sin(angle)
    local oobx, ooby
    repeat
        yield()
        oobx, ooby = self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
    until oobx or ooby
    return "projectileHit"
end

function Ai:projectileDeflected(deflector)
    self.hurtstun = deflector.attackstun or 3

    Audio.play(deflector.hitsound)
    local attackangle = deflector.attackangle
    yield()

    local shooter = self.shooter
    if shooter and shooter.team == "player" then
        attackangle = atan2(shooter.y - self.y, shooter.x - self.x)
    end
    self.shooter = deflector
    return "projectileFly", deflector, attackangle
end

return Ai
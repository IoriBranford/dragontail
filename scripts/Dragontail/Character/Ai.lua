local Movement  = require "Object.Movement"
local Audio     = require "System.Audio"
local Database    = require "Data.Database"
local Controls  = require "System.Controls"
local Stage
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
local random = love.math.random
local cos = math.cos
local sin = math.sin
local acos = math.acos
local asin = math.asin
local dot = math.dot
local det = math.det
local len = math.len
local abs = math.abs
local min = math.min
local max = math.max
local rot = math.rot
local Ai = {}

local function moveTo(self, destx, desty, speed, timelimit)
    timelimit = timelimit or math.huge
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

local function stopHolding(self, held)
    if self then
        self.heldopponent = nil
    end
    if held then
        held.heldby = nil
    end
end

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

local function faceAngle(self, angle)
    self.facex, self.facey = cos(angle), sin(angle)
end

function Ai:playerControl()
    local opponents = self.opponents
    self.facex = self.facex or 1
    self.facey = self.facey or 0
    while true do
        yield()
        local inx, iny = Controls.getDirectionInput()
        local b1pressed = Controls.getButtonsPressed()
        local _, b2down = Controls.getButtonsDown()

        local facex, facey = self.facex, self.facey
        local targetvelx, targetvely = 0, 0
        local speed = b2down and 2 or 5
        if inx ~= 0 or iny ~= 0 then
            inx, iny = norm(inx, iny)
            facex, facey = inx, iny
            self.facex, self.facey = facex, facey
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        if b1pressed then
            return "playerAttack", self.type.."-attack", atan2(-facey, -facex)
        end

        if b2down and not self.heldopponent then
            for i, opponent in ipairs(opponents) do
                if opponent.canbegrabbed and self:testBodyCollision(opponent) then
                    return "playerHold", opponent
                end
            end
        end

        self:accelerateTowardsVel(targetvelx, targetvely, b2down and 4 or 8)

        local velx, vely = self.velx, self.vely
        -- local veldot = dot(velx, vely, inx, iny)
        local attackangle
        -- if not b2
        -- and (inx ~= 0 or iny ~= 0)
        -- and veldot <= len(velx, vely) * speed * cos(pi/4) then
        --     attackangle = atan2(-iny, -inx)
        -- else
        --     attackangle = nil
        -- end
        -- self:startAttack(attackangle)
        if attackangle then
            -- local attackanimation = self.getDirectionalAnimation_angle("attackA", attackangle, 8)
            -- self.sprite:changeAsepriteAnimation(attackanimation)
        elseif velx ~= 0 or vely ~= 0 then
            if false --[[b2]]
            then
                local holdanimation = self.getDirectionalAnimation_angle("hold", atan2(facey, facex), 8)
                self.sprite:changeAsepriteAnimation(holdanimation)
            else
                local runanimation = self.getDirectionalAnimation_angle("run", atan2(facey, facex), 8)
                self.sprite:changeAsepriteAnimation(runanimation)
            end
        else
            local standanimation = self.getDirectionalAnimation_angle("stand", atan2(facey, facex), 8)
            self.sprite:changeAsepriteAnimation(standanimation)
        end
    end
end

function Ai:playerAttack(attacktype, angle)
    Database.fill(self, attacktype)
    local spinvel = self.attackspinspeed or (2*pi/16)
    local spintime = self.attackhittime or 16
    Audio.play(self.swingsound)
    local attackagain = false
    local t = spintime
    repeat
        local inx, iny = Controls.getDirectionInput()
        local targetvelx, targetvely = 0, 0
        local speed = 2
        if inx ~= 0 or iny ~= 0 then
            inx, iny = norm(inx, iny)
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        self:accelerateTowardsVel(targetvelx, targetvely, 8)

        self:startAttack(angle)
        faceAngle(self, angle+pi)
        local spindir = spinvel < 0 and "B" or "A"
        local attackanimation = self.getDirectionalAnimation_angle("attack"..spindir, angle, 4)
        self.sprite:changeAsepriteAnimation(attackanimation)

        yield()
        attackagain = attackagain or Controls.getButtonsPressed()
        angle = angle + spinvel
        t = t - 1
    until t <= 0
    self:stopAttack()
    if attackagain then
        return "playerAttack", attacktype, angle
    end
    return "playerControl"
end

function Ai:playerHold(enemy)
    self:stopAttack()
    self.heldopponent = enemy
    enemy.bodysolid = nil
    enemy.heldby = self
    enemy.hurtstun = enemy.holdstun or 120
    local x, y = self.x, self.y
    local radii = self.bodyradius + enemy.bodyradius
    Audio.play(self.holdsound)
    local holddirx, holddiry = enemy.x - x, enemy.y - y
    if holddirx ~= 0 or holddiry ~= 0 then
        holddirx, holddiry = norm(holddirx, holddiry)
    else
        holddirx = 1
    end
    local holdangle = atan2(holddiry, holddirx)
    local holddestangle = holdangle
    local time = enemy.hurtstun
    while time > 0 do
        yield()
        enemy = self.heldopponent
        if not enemy then
            break
        end
        time = time - 1

        local inx, iny = Controls.getDirectionInput()
        local b1pressed = Controls.getButtonsPressed()
        local _, b2down = Controls.getButtonsDown()
        local targetvelx, targetvely = 0, 0
        local speed = 2
        if inx ~= 0 or iny ~= 0 then
            inx, iny = norm(inx, iny)
            local turnamt = 0
            local turndir = det(holddirx, holddiry, inx, iny)
            if turndir < 0 then
                turnamt = -acos(dot(holddirx, holddiry, inx, iny))
            else
                turnamt = acos(dot(holddirx, holddiry, inx, iny))
            end
            holddestangle = holdangle + turnamt
            targetvelx = inx * speed
            targetvely = iny * speed
        end

        self:accelerateTowardsVel(targetvelx, targetvely, 4)
        local velx, vely = self.velx, self.vely

        local avel = 0
        if holddestangle < holdangle then
            avel = -pi/16
        elseif holddestangle > holdangle then
            avel = pi/16
        end
        holdangle = Movement.moveTowards(holdangle, holddestangle, avel)
        holddirx, holddiry = cos(holdangle), sin(holdangle)
        x, y = self.x, self.y
        enemy.x = x + velx + holddirx*radii
        enemy.y = y + velx + holddiry*radii
        self.facex, self.facey = holddirx, holddiry

        local holdanimation = (velx ~= 0 or vely ~= 0) and "holdwalk" or "hold"
        holdanimation = self.getDirectionalAnimation_angle(holdanimation, holdangle, 8)
        self.sprite:changeAsepriteAnimation(holdanimation)

        if b1pressed then
            stopHolding(self, enemy)
            enemy.bodysolid = true
            enemy.hurtstun = 0
            return "playerAttack", self.type.."-attack", holdangle
        end
        if not b2down then
            enemy:startAi(enemy.thrownai or "thrown", self, holdangle)
            Audio.play(self.throwsound)
            break
        end
    end
    enemy.bodysolid = true
    stopHolding(self, enemy)
    return "playerControl"
end

function Ai:playerVictory()
    self:stopAttack()
    Audio.play(self.victorysound)
    self.sprite:changeAsepriteAnimation("win")
    local i = 0
    while true do
        self:accelerateTowardsVel(0, 0, 4)
        self.z = math.abs(sin(i*pi/30) * 8)
        yield()
        i = i + 1
    end
end

function Ai:stand(duration)
    duration = duration or 60
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

    local attackchoices = self.attackchoices
    if type(attackchoices) == "string" then
        local choices = {}
        for attack in attackchoices:gmatch("%S+") do
            choices[#choices+1] = attack
        end
        attackchoices = choices
        self.attackchoices = choices
    end
    local attacktype = "attack"
    if attackchoices and #attackchoices > 0 then
        attacktype = attackchoices[love.math.random(#attackchoices)]
    end
    self.attacktype = attacktype
    Database.fill(self, self.type.."-"..attacktype)
    local attackradius = totalAttackRange(self.attackradius or 32, self.attacklungespeed or 0) + opponent.bodyradius
    if distsq(x, y, oppox, oppoy) <= attackradius*attackradius then
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
    local destanglefromoppo = random(4)*pi/2
    local attackradius = totalAttackRange(self.attackradius or 32, self.attacklungespeed or 0) + opponent.bodyradius
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
    self.velx, self.vely = 0, 0

    local x, y = self.x, self.y
    local bounds = self.bounds
    local opponent = self.opponent
    local oppox, oppoy = opponent.x, opponent.y
    local tooppox, tooppoy = oppox - x, oppoy - y
    faceDir(self, tooppox, tooppoy)
    local tooppoangle = atan2(tooppoy, tooppox)
    Audio.play(self.windupsound)

    local animation = self.getDirectionalAnimation_angle(attackname.."A", tooppoangle, 4)
    self.sprite:changeAsepriteAnimation(animation, 1, "stop")
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
    local facingangle = atan2(self.facey or 0, self.facex or 1)
    local guardanimation = self.getDirectionalAnimation_angle("guard", facingangle, 4)
    self.sprite:changeAsepriteAnimation(guardanimation, 1, "stop")
    wait(self.guardtime or 60)
    return "stand"
end

function Ai:guardHit(attacker)
    local facex, facey = self.facex, self.facey
    local guardarc = self.guardarc or (pi/4)
    local toattackerx = -self.x + attacker.x
    local toattackery = -self.y + attacker.y
    local toattackerdist = len(toattackerx, toattackery)
    local dotGA = dot(toattackerx, toattackery, facex, facey)
    if dotGA >= cos(guardarc) * toattackerdist then
        Audio.play(self.guardhitsound)
        self.hurtstun = attacker.attackguardstun or 6
        yield()
        local afterguardattacktype = self.afterguardattacktype
        if afterguardattacktype then
            return "attack", afterguardattacktype
        end
        return self.afterguardhitai or "stand"
    end
    return self:hurt(attacker)
end

function Ai:hurt(attacker)
    self.health = self.health - attacker.attackdamage
    self.canbegrabbed = nil
    self.velx, self.vely = 0, 0
    self:stopAttack()
    local heldopponent = self.heldopponent
    local heldby = self.heldby
    stopHolding(self, heldopponent)
    stopHolding(heldby, self)
    if heldopponent then
        heldopponent.hurtstun = 0
    end
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
    local recovertime = math.huge
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
        self:stopAttack()
        Audio.play(self.bodyslamsound)
        self.health = self.health - (self.wallslamdamage or 25)
        self.hurtstun = self.wallslamstun or 20
        yield()
        return "fall", thrower
    end
    return self.thrownrecoverai or self.hurtrecoverai
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
        Audio.play(self.bodyslamsound)
        self.health = self.health - (self.wallslamdamage or 25)
        self.hurtstun = self.wallslamstun or 20
        return "fall", thrower
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

function Ai:playerDefeat(defeatanimation)
    Audio.fadeMusic()
    yield()
    return "defeat", defeatanimation
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
        item:startAi("itemDrop")
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
        Audio.play(self.hitsound)
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
    if shooter then
        attackangle = atan2(shooter.y - self.y, shooter.x - self.x)
    end
    self.shooter = deflector
    return "projectileFly", deflector, attackangle
end

return function(Character)
function Character:startAi(ainame, ...)
    Stage = Stage or require "Dragontail.Stage"
    local f = Ai[ainame]
    if not f then
        error("No AI function "..ainame)
    end
    local ai = co_create(f)
    local ok, msg = resume(ai, self, ...)
    assert(ok, msg)
    if status(ai) == "dead" then
        assert(self.disappeared or not self.type or not self.type:find("Rose"), "Player lost ai after "..ainame)
        ai = nil
        ainame = nil
    end
    self.currentainame = ainame
    self.ai = ai
end

function Character:runAi()
    local ai = self.ai
    if not ai then
        return
    end
    local ok, nextainame, a, b, c, d, e = resume(ai, self)
    assert(ok, nextainame)
    if nextainame then
        self:startAi(nextainame, a, b, c, d, e)
    elseif status(ai) == "dead" then
        assert(self.disappeared or not self.type or not self.type:find("Rose"), "Player lost ai after "..self.currentainame)
        self.currentainame = nil
        self.ai = nil
    end
end
end
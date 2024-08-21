local Database = require "Data.Database"
local Movement = require "Component.Movement"
local Audio    = require "System.Audio"
local Stage    = require "Dragontail.Stage"
local Fighter  = require "Dragontail.Character.Fighter"

---@class Enemy:Fighter
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

local function faceDir(self, dx, dy)
    self.facex, self.facey = norm(dx, dy)
end

local function totalAttackRange(attackradius, attacklungespeed, attacklungedecel)
    return attackradius + Fighter.GetSlideDistance(attacklungespeed or 0, attacklungedecel or 1)
end

local function findAngleToDodgeIncoming(self, incoming)
    local dodgewithindist = self.dodgewithindist or 100
    local dodgespeed = self.dodgespeed
    if not dodgespeed then
        return
    end
    local oppox, oppoy, oppovelx, oppovely
    oppox, oppoy = incoming.x, incoming.y
    oppovelx, oppovely = incoming.velx, incoming.vely
    local tooppoy, tooppox = oppoy - self.y, oppox - self.x
    local vdotd = math.dot(oppovelx, oppovely, tooppox, tooppoy)
    local oppospeed = math.len(oppovelx, oppovely)
    if vdotd < -dodgewithindist*oppospeed or vdotd >= 0 then
        return
    end

    local dodgeangle = atan2(-tooppoy, -tooppox)
    if oppospeed >= dodgespeed then
        dodgeangle = dodgeangle + (love.math.random(2) == 0 and -pi/2 or pi/2)
    end
    local dodgedist = Fighter.GetSlideDistance(dodgespeed, self.dodgedecel or 1)
    local dodgedx, dodgedy = dodgedist*cos(dodgeangle), dodgedist*sin(dodgeangle)
    local dodgeendx, dodgeendy = self.x + dodgedx, self.y + dodgedy
    local bounds = self.bounds
    local dodgeblockedx1 = dodgeendx <= bounds.x + self.bodyradius
    local dodgeblockedx2 = dodgeendx >= bounds.x + bounds.width - self.bodyradius
    local dodgeblockedy1 = dodgeendy <= bounds.y + self.bodyradius
    local dodgeblockedy2 = dodgeendy >= bounds.y + bounds.height - self.bodyradius
    if dodgeblockedx1 then
        if dodgeblockedy1 then
            dodgeangle = love.math.random(2) == 0 and 0 or pi/2
        elseif dodgeblockedy2 then
            dodgeangle = love.math.random(2) == 0 and 0 or -pi/2
        elseif self.y - (bounds.y + bounds.height/2) < 0 then
            dodgeangle = -pi/2
        else
            dodgeangle = pi/2
        end
    elseif dodgeblockedx2 then
        if dodgeblockedy1 then
            dodgeangle = love.math.random(2) == 0 and pi or pi/2
        elseif dodgeblockedy2 then
            dodgeangle = love.math.random(2) == 0 and pi or -pi/2
        elseif self.y - (bounds.y + bounds.height/2) < 0 then
            dodgeangle = -pi/2
        else
            dodgeangle = pi/2
        end
    elseif dodgeblockedy1 or dodgeblockedy2 then
        if not dodgeblockedx1 and not dodgeblockedx2 then
            if self.x - (bounds.x + bounds.width/2) < 0 then
                dodgeangle = 0
            else
                dodgeangle = pi
            end
        end
    end
    return dodgeangle
end

function Enemy:stand(duration)
    duration = duration or 20
    self.velx, self.vely = 0, 0
    local x, y = self.x, self.y
    local opponent = self.opponent
    local oppox, oppoy
    for _ = 1, duration do
        oppox, oppoy = opponent.x, opponent.y
        if oppox ~= x or oppoy ~= y then
            local tooppoy, tooppox = oppoy - y, oppox - x
            if tooppox == 0 and tooppoy == 0 then
                tooppox = 1
            end
            faceDir(self, tooppox, tooppoy)
            local faceangle = atan2(tooppoy, tooppox)
            local standanimation = self.getDirectionalAnimation_angle("Stand", faceangle, self.animationdirections)
            self:changeAseAnimation(standanimation)

            local dodgeangle = findAngleToDodgeIncoming(self, opponent)
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
    if not opponent.attacker and toopposq <= attackradius*attackradius then
        return "attack", attacktype
    end
    return "approach"
end

function Enemy:dodgeIncoming(dodgeangle)
    local opponent = self.opponent
    local x, y, oppox, oppoy = self.x, self.y, opponent.x, opponent.y
    local tooppox, tooppoy = oppox - x, oppoy - y
    if tooppox == 0 and tooppoy == 0 then
        tooppox = 1
    end

    faceDir(self, tooppox, tooppoy)
    self:setDirectionalAnimation("Walk", math.atan2(tooppoy, tooppox))
    Audio.play(self.stopdashsound)
    self:slide(dodgeangle, self.dodgespeed, self.dodgedecel)

    local attacktype = not opponent.attacker and self.attacktype
    if attacktype then
        local attackradius = self.attackradius
        x, y, oppox, oppoy = self.x, self.y, opponent.x, opponent.y
        if distsq(x, y, oppox, oppoy) <= attackradius*attackradius then
            return "attack", attacktype
        end
    end
    return "stand"
end

function Enemy:approach()
    local x, y = self.x, self.y
    local opponent = self.opponent
    local oppox, oppoy = opponent.x, opponent.y
    local bodyradius = self.bodyradius
    local bounds = self.bounds
    local minx, miny = bounds.x + bodyradius, bounds.y + bodyradius
    local maxx, maxy = bounds.x + bounds.width - bodyradius, bounds.y + bounds.height - bodyradius

    -- choose dest
    local destanglefromoppo = lm_random(4)*pi/2
    local attackradius = totalAttackRange(self.attackradius or 64, self.attacklungespeed or 0, self.attacklungedecel or 1) + opponent.bodyradius
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
        if todestx == 0 and todesty == 0 then
            todestx = 1
        end
        faceDir(self, todestx, todesty)
        local todestangle = atan2(todesty, todestx)
        local walkanimation = self.getDirectionalAnimation_angle("Walk", todestangle, self.animationdirections)
        self:changeAseAnimation(walkanimation)
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
        local dodgeangle = findAngleToDodgeIncoming(self, opponent)
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
    if attacktype and distsq(x, y, oppox, oppoy) <= attackradius*attackradius then
        return "attack", attacktype
    end
    if reached then
        return "stand", 10
    end
    return "stand", 5
end

function Enemy:attack()
    self:stopGuarding()
    self.canbeattacked = not self.attackwindupinvuln
    self.canbegrabbed = not self.attackwindupinvuln
    self.velx, self.vely = 0, 0

    local x, y = self.x, self.y
    local bounds = self.bounds
    local opponent = self.opponent
    opponent.attacker = self
    local oppox, oppoy = opponent.x, opponent.y
    local tooppox, tooppoy = oppox - x, oppoy - y
    local tooppoangle = 0
    if oppox ~= x or oppoy ~= y then
        faceDir(self, tooppox, tooppoy)
        tooppoangle = atan2(tooppoy, tooppox)
    end
    local animation = self.windupanimation
    if animation then
        animation = self.getDirectionalAnimation_angle(animation, tooppoangle, self.animationdirections)
        self:changeAseAnimation(animation, 1, 0)
    end

    Audio.play(self.windupsound)
    for i = 1, (self.attackwinduptime or 20) do
        local dodgeangle = findAngleToDodgeIncoming(self, opponent)
        if dodgeangle then
            opponent.attacker = nil
            return "dodgeIncoming", dodgeangle
        end
        yield()
    end

    Audio.play(self.swingsound)
    local attackprojectile = self.attackprojectile
    if attackprojectile then
        local bodyradius = self.bodyradius or 0

        Stage.addCharacter({
            x = x + bodyradius*cos(tooppoangle),
            y = y + bodyradius*sin(tooppoangle),
            type = attackprojectile,
            attackangle = tooppoangle,
            thrower = self
        })
    else
        local attackangle = floor((tooppoangle + (pi/4)) / (pi/2)) * pi/2
        self:startAttack(attackangle)
    end

    local lungespeed = self.attacklungespeed or 0

    animation = self.swinganimation
    if animation then
        animation = self.getDirectionalAnimation_angle(animation, tooppoangle, self.animationdirections)
        self:changeAseAnimation(animation, 1, 0)
    end
    local hittime = self.attackhittime or 10
    repeat
        lungespeed = Fighter.updateSlideSpeed(self, tooppoangle, lungespeed)
        hittime = hittime - 1
        yield()
        self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
    until hittime <= 0

    self:stopAttack()
    if self.attackwindupinvuln then
        self.canbeattacked = true
        self.canbegrabbed = true
    end

    local afterhittime = self.attackafterhittime or 30
    repeat
        lungespeed = Fighter.updateSlideSpeed(self, tooppoangle, lungespeed)
        afterhittime = afterhittime - 1
        yield()
        self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
    until afterhittime <= 0

    return "stand", 20
end

function Enemy:guard()
    self.velx, self.vely = 0, 0
    local t = self.guardtime or 60
    local opponent = self.opponent
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
        Database.fill(self, guardcounterattack)
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
local Database      = require "Data.Database"
local Audio       = require "System.Audio"
local Config      = require "System.Config"
local State       = require "Dragontail.Character.State"
local Object      = require "Tiled.Object"
local Movement    = require "Component.Movement"
local Boundaries  = require "Dragontail.Stage.Boundaries"

local pi = math.pi
local floor = math.floor
local sqrt = math.sqrt
local cos = math.cos
local sin = math.sin
local asin = math.asin
local lensq = math.lensq
local dot = math.dot
local min = math.min
local max = math.max
local testcircles = math.testcircles

---@class Character:AsepriteObject
local Character = class(Object)

function Character:init()
    if self.visible == nil then
        self.visible = true
    end
    self.health = self.health or 1
    self.maxhealth = self.maxhealth or self.health
    self.x = self.x or 0
    self.y = self.y or 0
    self.z = self.z or 0
    self.altitude = self.altitude or 0
    self.velx = self.velx or 0
    self.vely = self.vely or 0
    self.velz = self.velz or 0
    self.speed = self.speed or 1
    self.bodyradius = self.bodyradius or 1
    self.attackradius = self.attackradius or 0
    -- ch.attackangle = ch.attackangle or 0
    self.attackarc = self.attackarc or 0
    self.attackdamage = self.attackdamage or 1
    self.attackstun = self.attackstun or 1
    self.hitstun = self.hitstun or 0
    self.hurtstun = self.hurtstun or 0
end

function Character:updateSprite(sprite, fixedfrac)
    if sprite then
        local vx, vy = self.velx or 0, self.vely or 0
        local x, y, z = self.x, self.y, self.z
        sprite.x = x + vx * fixedfrac
        sprite.y = y + vy * fixedfrac
        sprite.originy = (self.spriteoriginy or 0) + z
    end
end

---@param scene Scene
function Character:addToScene(scene)
    scene:add(self)
    self.originx = self.spriteoriginx
    self.originy = self.spriteoriginy

    local baseDraw = self.draw
    if self.shadowtype then
        self.draw = function(sprite)
            self:drawShadow()
            baseDraw(sprite)
        end
    end
end

function Character:makeAfterImage()
    local Characters  = require "Dragontail.Stage.Characters"
    local afterimage = Characters.spawn({
        x = self.x,
        y = self.y,
        asefile = self.asefile,
        animationspeed = 0,
        spriteoriginx = self.spriteoriginx,
        spriteoriginy = self.spriteoriginy,
        script = "Dragontail.Character.Common",
        initialai = "afterimage"
    })
    afterimage:setAseAnimation(self.aseanimation, self.animationframe)
end

function Character:accelerate(ax, ay)
    self.velx = self.velx + ax
    self.vely = self.vely + ay
end

function Character:accelerateTowardsVel(targetvelx, targetvely, t, e)
    assert(t > 0, "t <= 0")
    e = e or (1/256)
    local accelx = (targetvelx - self.velx) / t
    local accely = (targetvely - self.vely) / t
    if math.abs(accelx) < e then
        self.velx = targetvelx
    else
        self.velx = self.velx + accelx
    end
    if math.abs(accely) < e then
        self.vely = targetvely
    else
        self.vely = self.vely + accely
    end
end

function Character:updatePosition()
    self.x = self.x + self.velx
    self.y = self.y + self.vely
end

function Character:isHitStopOver()
    return self.hitstun <= 0 and self.hurtstun <= 0
end

function Character:fixedupdateHitStop()
    if self.hitstun > 0 then
        self.hitstun = self.hitstun - 1
        if self.hitstun > 0 then
            return false
        end
    end
    if self.hurtstun > 0 then
        self.hurtstun = self.hurtstun - 1
        if self.hurtstun > 0 then
            return false
        end
    end
    return true
end

function Character:fixedupdate()
    if self:fixedupdateHitStop() then
        self:animate(1)
        self:updatePosition()
        State.run(self)
    end
end

function Character:fixedupdateShake(time)
    time = max(0, time - 1)
    self.originx = self.spriteoriginx + 2*math.sin(time)
    return time
end

function Character:update(dsecs, fixedfrac)
    self.originx = self.spriteoriginx + 2*math.sin(self.hurtstun)
    self.originy = (self.spriteoriginy or 0) + self.altitude
end

function Character:moveTo(destx, desty, speed, timelimit)
    timelimit = timelimit or math.huge
    coroutine.waitfor(function()
        local x, y = self.x, self.y
        timelimit = timelimit - 1
        if timelimit <= 0 or x == destx and y == desty then
            return true
        end
        self.velx, self.vely = Movement.getVelocity_speed(x, y, destx, desty, speed)
    end)
    return self.x == destx and self.y == desty
end

function Character:startAttack(attackangle)
    self.attackangle = attackangle
end

function Character:stopAttack()
    self.attackangle = nil
    local opponents = self.opponents
    if opponents then
        for i = 1, #opponents do
            local opponent = opponents[i]
            if opponent.attacker == self then
                opponent.attacker = nil
            end
        end
    end
end

function Character:startGuarding(guardangle)
    self.guardangle = guardangle
end

function Character:stopGuarding()
    self.guardangle = nil
end

function Character:rotateAttack(dangle)
    dangle = math.fmod(dangle + 3*pi, 2*pi) - pi
    self.attackangle = self.attackangle + dangle
end

function Character:rotateAttackTowards(targetangle, turnspeed)
    local dangle = math.fmod(targetangle - self.attackangle + 3*pi, 2*pi) - pi
    dangle = math.max(-turnspeed, math.min(turnspeed, dangle))
    self.attackangle = self.attackangle + dangle
end

function Character:keepInBounds()
    local x, y, r = self.x, self.y, self.bodyradius
    local totalpenex, totalpeney
    self.x, self.y, totalpenex, totalpeney = Boundaries.keepCircleIn(x, y, r)
    return totalpenex, totalpeney
end

function Character:testBodyCollision(other)
    return self ~= other and testcircles(self.x, self.y, self.bodyradius, other.x, other.y, other.bodyradius)
end

function Character:collideWithCharacterBody(other)
    if not other.bodysolid then
        return
    end
    local distsq = self:testBodyCollision(other)
    if distsq then
        local radii = self.bodyradius + other.bodyradius
        local dist = math.sqrt(distsq)
        local dx, dy = self.x - other.x, self.y - other.y
        local normx, normy = dx/dist, dy/dist
        self.x = other.x + normx*radii
        self.y = other.y + normy*radii
        return dx, dy
    end
end

function Character:checkAttackCollision(attacker)
    if self == attacker or self == attacker.thrower or self.thrower == attacker then
        return
    end
    local attackangle = attacker.attackangle
    if not attackangle then
        return
    end
    local fromattackerx, fromattackery = self.x - attacker.x, self.y - attacker.y
    local distsq = lensq(fromattackerx, fromattackery)
    local bodyradius = self.bodyradius
    if distsq <= bodyradius * bodyradius then
        return true
    end
    local radii = bodyradius + attacker.attackradius
    local radiisq = radii * radii
    if distsq <= radiisq then
        local attackarc = attacker.attackarc
        if attackarc >= pi then
            return true
        end
        local dist = sqrt(distsq)
        local attackx, attacky = cos(attackangle), sin(attackangle)
        local dotDA = dot(fromattackerx, fromattackery, attackx, attacky)
        local bodyarc = asin(bodyradius/dist)
        return dotDA >= dist * cos(bodyarc + attackarc)
    end
end

function Character:collideWithCharacterAttack(attacker)
    if self.hurtstun > 0 or not self.canbeattacked then
        return
    end
    if self:checkAttackCollision(attacker) then
        local guardhitai = self.guardai or "guardHit"
        local hurtai = self.hurtai or "hurt"
        if self.guardangle then
            State.start(self, guardhitai, attacker)
        else
            State.start(self, hurtai, attacker)
            if attacker.hitstun <= 0 then
                attacker.hitstun = attacker.attackstunself or 3
            end
        end
        local hitai = attacker.attackhitai
        if hitai then
            State.start(attacker, hitai, self)
        end
        return true
    end
end

function Character:heal(amount)
    self.health = min(self.health + amount, self.maxhealth)
end

function Character.getDirectionalAnimation_angle(basename, angle, numanimations)
    numanimations = numanimations or 1
    if numanimations < 2 then
        return basename
    end
    if angle ~= angle then
        return basename..0
    end
    local faceangle = angle + (pi / numanimations)
    local facedir = floor(faceangle * numanimations / pi / 2)
    facedir = ((facedir % numanimations) + numanimations) % numanimations
    return basename..facedir
end

function Character:setDirectionalAnimation(basename, angle, frame1, loopframe)
    local animation = self.getDirectionalAnimation_angle(basename, angle, self.animationdirections)
    self:changeAseAnimation(animation, frame1, loopframe)
end

function Character:setEmote(emotename)
    local emote = self.emote
    if emote then
        if emotename then
            emote.visible = true
            emote:changeAsepriteAnimation(emotename)
        else
            emote.visible = false
        end
    end
end

function Character:drawShadow()
    local x, y = self.x, self.y
    love.graphics.setColor(0,0,0,.25)

    love.graphics.circle("fill", x, y, self.bodyradius)

    local attackangle = self.attackangle
    local attackradius = self.attackradius
    if attackradius > 0 and attackangle then
        local attackarc = self.attackarc
        if attackarc > 0 then
            love.graphics.arc("fill", x, y, attackradius, attackangle - attackarc, attackangle + attackarc)
        else
            love.graphics.line(x, y, x + attackradius*cos(attackangle), y + attackradius*sin(attackangle))
        end
    end

    if Config.drawbodies then
        love.graphics.setColor(.5, .5, 1)
        love.graphics.circle("line", x, y, self.bodyradius)
        if attackradius > 0 and attackangle then
            local attackarc = self.attackarc
            love.graphics.setColor(1, .5, .5)
            if attackarc > 0 then
                love.graphics.arc("line", x, y, attackradius, attackangle - attackarc, attackangle + attackarc)
            else
                love.graphics.line(x, y, x + attackradius*cos(attackangle), y + attackradius*sin(attackangle))
            end
        end
    end

    love.graphics.setColor(1,1,1,1)
end

function Character:disappear()
    self.disappeared = true
end

function Character:hasDisappeared()
    return self.disappeared
end

return Character
local Audio     = require "System.Audio"
local Database    = require "Data.Database"
local State       = require "Dragontail.Character.State"
local Color       = require "Tiled.Color"
local Character   = require "Dragontail.Character"

local yield = coroutine.yield
local wait = coroutine.wait
local atan2 = math.atan2
local cos = math.cos
local sin = math.sin
local max = math.max

---@class Common:Character
local Common = class(Character)

function Common:spark()
    wait(self.sparktime or 30)
    self:disappear()
end

function Common:afterimage()
    local afterimagetime = max(1, self.afterimagetime or 30)
    local deltaalpha = 1/afterimagetime
    for i = 1, afterimagetime do
        local r, g, b, a = Color.unpack(self.color)
        a = a - deltaalpha
        self.color = Color.asARGBInt(r, g, b, a)
        yield()
    end
    self:disappear()
end

function Common:blinkOut(t)
    t = t or 30
    for i = 1, t do
        local r, g, b = Color.unpack(self.color)
        self.color = Color.asARGBInt(r, g, b, cos(i))
        yield()
    end
    self:disappear()
end

function Common:containerBreak(attacker)
    self.bodysolid = false
    Audio.play(self.defeatsound)
    self:changeAseAnimation("collapse", 1, 0)
    local item = self.item
    if item then
        item.opponent = self.opponent
        State.start(item, "itemDrop")
    end
    yield()
    return "blinkOut", 30
end

function Common:itemDrop(y0)
    local popoutspeed = self.popoutspeed or 8
    local gravity = self.dropgravity or .5
    repeat
        yield()
        popoutspeed = popoutspeed - gravity
        self.altitude = self.altitude + popoutspeed
    until self.altitude <= 0
    self.altitude = 0
    return "itemWaitForPickup"
end

function Common:itemWaitForPickup()
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

function Common:projectileHit(opponent)
    if opponent then
        -- Audio.play(self.hitsound)
    else
        Audio.play(self.bodyslamsound)
    end
    local attackhitanimation = self.attackhitanimation
    if attackhitanimation then
        attackhitanimation = self.getDirectionalAnimation_angle(attackhitanimation, self.attackangle, self.animationdirections)
        self:changeAseAnimation(attackhitanimation)
    end
    self:stopAttack()
    self.velx, self.vely = 0, 0
    yield()
    return "blinkOut", 30
end

function Common:projectileFly(shooter, angle)
    angle = angle or self.attackangle
    Database.fill(self, self.defaultattack)
    self:startAttack(angle)
    local bounds = self.bounds
    local speed = self.speed
    self.velx = speed*cos(angle)
    self.vely = speed*sin(angle)
    local animation = self.swinganimation
    if animation then
        animation = self.getDirectionalAnimation_angle(animation, angle, self.animationdirections)
        self:changeAseAnimation(animation)
    end
    local oobx, ooby
    repeat
        yield()
        oobx, ooby = self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
    until oobx or ooby
    return "projectileHit"
end

function Common:projectileDeflected(deflector)
    self.hurtstun = deflector.attackstun or 3

    Audio.play(deflector.hitsound)
    local attackangle = deflector.attackangle
    yield()

    local thrower = self.thrower
    if thrower and thrower.team ~= "player" and deflector.team == "player" then
        attackangle = 0
        if thrower.y ~= self.y or thrower.x ~= self.x then
            attackangle = atan2(thrower.y - self.y, thrower.x - self.x)
        end
    end
    self.thrower = deflector
    return "projectileFly", deflector, attackangle
end

return Common
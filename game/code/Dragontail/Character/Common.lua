local Audio     = require "System.Audio"
local Database    = require "Data.Database"
local Script      = require "Component.Script"
local yield = coroutine.yield
local wait = coroutine.wait
local atan2 = math.atan2
local cos = math.cos
local sin = math.sin
local max = math.max
local Common = {}

function Common:spark()
    wait(self.sparktime or 30)
    self:disappear()
end

function Common:afterimage()
    local sprite = self.sprite
    local afterimagetime = max(1, self.afterimagetime or 30)
    local deltaalpha = 1/afterimagetime
    for i = 1, afterimagetime do
        sprite.alpha = sprite.alpha - deltaalpha
        yield()
    end
    self:disappear()
end

function Common:blinkOut(t)
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

function Common:containerBreak(attacker)
    self.bodysolid = false
    self.canbeattacked = false
    Audio.play(self.defeatsound)
    self.sprite:changeAsepriteAnimation("collapse", 1, "stop")
    local item = self.item
    if item then
        item.opponent = self.opponent
        Script.start(item, "itemDrop")
    end
    yield()
    return Common.blinkOut, 30
end

function Common:itemDrop(y0)
    local popoutspeed = self.popoutspeed or 8
    local gravity = self.dropgravity or .5
    repeat
        yield()
        popoutspeed = popoutspeed - gravity
        self.z = self.z + popoutspeed
    until self.z <= 0
    self.z = 0
    return Common.itemWaitForPickup
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
    local sprite = self.sprite
    if sprite and attackhitanimation then
        attackhitanimation = self.getDirectionalAnimation_angle(attackhitanimation, self.attackangle, self.animationdirections)
        self.sprite:changeAsepriteAnimation(attackhitanimation)
    end
    self.canbeattacked = false
    self:stopAttack()
    self.velx, self.vely = 0, 0
    yield()
    return Common.blinkOut, 30
end

function Common:projectileFly(shooter, angle)
    angle = angle or self.attackangle
    Database.fill(self, self.defaultattack)
    self:startAttack(angle)
    local bounds = self.bounds
    local speed = self.speed
    self.velx = speed*cos(angle)
    self.vely = speed*sin(angle)
    local oobx, ooby
    repeat
        yield()
        oobx, ooby = self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
    until oobx or ooby
    return Common.projectileHit
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
    return Common.projectileFly, deflector, attackangle
end

return Common
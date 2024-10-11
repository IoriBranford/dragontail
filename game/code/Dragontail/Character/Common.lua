local Audio     = require "System.Audio"
local Database    = require "Data.Database"
local State       = require "Dragontail.Character.State"
local Color       = require "Tiled.Color"
local Character   = require "Dragontail.Character"
local Characters  = require "Dragontail.Stage.Characters"

local yield = coroutine.yield
local wait = coroutine.wait
local atan2 = math.atan2
local cos = math.cos
local sin = math.sin
local max = math.max

local MaxProjectileItems = 16

---@class Common:Character
local Common = class(Character)

function Common:updateDropToGround()
    local _, _, penez = self:keepInBounds()
    if penez then
        self.velz = 0
        return
    end
    local gravity = self.fallgravity or .25
    self.velz = self.velz - gravity
end

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

local function updateBlinkOut(t, color)
    local r, g, b = Color.unpack(color)
    return Color.asARGBInt(r, g, b, cos(t))
end

function Common:blinkOut(t)
    t = t or 30
    for i = 1, t do
        self.color = updateBlinkOut(i, self.color)
        yield()
    end
    self:disappear()
end

function Common:dropDefeatItem()
    local item = self.item
    if not item and self.itemtype then
        item = Characters.spawn({
            type = self.itemtype,
            x = self.x, y = self.y, z = self.z,
        })
    end
    if item then
        item.opponents = self.opponents
        State.start(item, "itemDrop")
    end
end

function Common:containerBreak(attacker)
    Audio.play(self.defeatsound)
    self:changeAnimation("collapse", 1, 0)
    self:dropDefeatItem()
    yield()
    return "blinkOut", 30
end

function Common:itemDrop(y0)
    local popoutspeed = self.popoutspeed or 8
    local gravity = self.fallgravity or .5
    repeat
        yield()
        popoutspeed = popoutspeed - gravity
        self.z = self.z + popoutspeed
    until self.z <= 0
    self.z = 0
    return "itemWaitForPickup"
end

function Common:itemWaitForPickup()
    local opponent = self.opponents[1]
    while true do
        local finished
        if self:testBodyCollision(opponent) then
            if self.healhealth then
                if opponent.health < opponent.maxhealth then
                    Audio.play(self.healsound)
                    opponent:heal(self.healhealth)
                    finished = true
                end
            elseif self.giveweapon then
                if not opponent.weaponinhand then
                    Audio.play(opponent.holdsound)
                    opponent.weaponinhand = self.giveweapon
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
    local hitbounce = self.attackhitbounce or 2
    local normx, normy = math.norm(-self.velx, -self.vely)
    self.velx, self.vely = normx*hitbounce, normy*hitbounce
    yield()
    return "blinkOut", 30
end

function Common:projectileEmbed(opponent, ooby, oobz)
    self:stopAttack()
    local oobx = type(opponent) == "number" and opponent
    opponent = type(opponent) == "table" and opponent or nil
    self.velx, self.vely, self.velz = 0, 0, 0
    if opponent then
        for t = 1, 30 do
            if opponent then
                self.velx, self.vely, self.velz = opponent.velx, opponent.vely, opponent.velz
            end
            self.color = updateBlinkOut(t, self.color)
            yield()
        end
        self:disappear()
    else
        Audio.play(self.bodyslamsound)
        local items = Characters.getGroup("items")
        if self.itemtype and #items < MaxProjectileItems then
            Characters.spawn({
                type = self.itemtype,
                x = self.x, y = self.y, z = self.z
            })
            self:disappear()
        else
            return "blinkOut", 30
        end
    end
end

function Common:projectileBounce(opponent, ooby, oobz)
    self:stopAttack()
    local oobx = type(opponent) == "number" and opponent
    opponent = type(opponent) == "table" and opponent or nil
    if opponent then
    else
        Audio.play(self.bodyslamsound)
    end
    local gravity = self.fallgravity or .25
    local bouncefactor = self.bouncefactor or .5
    if opponent then
        if opponent.z <= self.z and self.z <= opponent.z + opponent.bodyheight then
            self.velx, self.vely = -self.velx*bouncefactor, -self.vely*bouncefactor
        else
            self.velz = -self.velz*bouncefactor
        end
    else
        if oobx or ooby then
            self.velx, self.vely = math.reflect(self.velx*bouncefactor, self.vely*bouncefactor, -oobx or 0, -ooby or 0)
        end
        if oobz then
            self.velz = -self.velz*bouncefactor
        end
    end
    oobz = nil
    repeat
        yield()
        self.velz = self.velz - gravity
        oobx, ooby, oobz = self:keepInBounds()
    until oobz and oobz < 0
    self.velx, self.vely, self.velz = 0, 0, 0
    local items = Characters.getGroup("items")
    local numopponentshit = self.numopponentshit or 0
    if not opponent and self.itemtype and #items < MaxProjectileItems and numopponentshit <= 0 then
        Characters.spawn({
            type = self.itemtype,
            x = self.x, y = self.y, z = self.z
        })
        self:disappear()
    else
        return "blinkOut", 30
    end
end

function Common:projectileFly(shooter)
    local angle = self.attackangle
    Database.fill(self, self.defaultattack)
    if not angle then
        local velx = self.velx
        local vely = self.vely
        if velx ~= 0 or vely ~= 0 then
            angle = atan2(vely, velx)
        else
            angle = 0
        end
        self:startAttack(angle)
    end
    self:setDirectionalAnimation(self.swinganimation, angle, 1, self.swinganimationloopframe or 1)
    local oobx, ooby, oobz
    local gravity = self.fallgravity or 0
    repeat
        yield()
        oobx, ooby, oobz = self:keepInBounds()
        self.velz = self.velz - gravity
    until oobx or ooby or oobz
    local attackhitai = self.attackhitboundaryai or self.attackhitai
    if attackhitai then
        return attackhitai, oobx, ooby, oobz
    end
    self:disappear()
end

function Common:projectileDeflected(deflector)
    self.hurtstun = deflector.attackstun or 3

    Audio.play(deflector.hitsound)
    local attackangle = deflector.attackangle
    local dirx, diry, dirz = cos(attackangle), sin(attackangle), 0

    local speed = self.speed or 1
    local thrower = self.thrower
    if thrower and thrower.team ~= "player" and deflector.team == "player" then
        dirx, diry, dirz = 1, 0, 0
        if thrower.y ~= self.y or thrower.x ~= self.x then
            dirx, diry, dirz = math.norm(thrower.x - self.x, thrower.y - self.y, thrower.z + thrower.bodyheight/2 - self.z)
        end
    end
    self.thrower = deflector
    self.velx = speed*dirx
    self.vely = speed*diry
    self.velz = speed*dirz
    local angle = atan2(self.vely, self.velx)
    self.attackangle = angle
    self:setDirectionalAnimation(self.swinganimation, angle, 1, self.swinganimationloopframe or 1)
    yield()
    return "projectileFly", deflector
end

return Common
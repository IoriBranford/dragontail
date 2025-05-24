local Audio     = require "System.Audio"
local Database    = require "Data.Database"
local StateMachine       = require "Dragontail.Character.StateMachine"
local Color       = require "Tiled.Color"
local Character   = require "Dragontail.Character"
local Characters  = require "Dragontail.Stage.Characters"
local Body        = require "Dragontail.Character.Body"
local DirectionalAnimation = require "Dragontail.Character.DirectionalAnimation"
local Face                 = require "Dragontail.Character.Action.Face"
local Mana = require "Dragontail.Character.Mana"

local yield = coroutine.yield
local wait = coroutine.wait
local atan2 = math.atan2
local cos = math.cos
local sin = math.sin
local max = math.max

local MaxProjectileItems = 16

---@class DropItem
---@field item Character?
---@field itempopouttime integer?
---@field itemvelx number?
---@field itemvely number?

---@class Item
---@field itemtype string?
---@field healhealth number?
---@field itemgetsound string?
---@field giveweapon string?

---@class Projectile
---@field bouncefactor number?

---@class WallHit
---@field wallbumpdamage number?
---@field wallbumpstun integer?
---@field wallslamdamage number?
---@field wallslamstun integer?
---@field bodyslamsound string?

---@class Defeat
---@field defeatai string?
---@field defeatsound string?
---@field defeatedanimation string?

---@class Common:Character,DropItem,Item,Projectile,WallHit,Defeat
---@field lifetime integer?
---@field afterimagetime integer?
---@field opponents Fighter[]
local Common = class(Character)

function Common:spark(time)
    time = time or self.lifetime or 30
    wait(time)
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

function Common:shrinkOut(t)
    t = t or self.lifetime or 60
    local sx, sy = self.scalex or 1, self.scaley or 1
    self.scalex, self.scaley = sx, sy
    local shrinkspeedx = -sx/t
    local shrinkspeedy = -sy/t
    for i = 1, t do
        self.scalex = self.scalex + shrinkspeedx
        self.scaley = self.scaley + shrinkspeedy
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
        local popouttime = self.itempopouttime or 15
        local velx, vely = self.itemvelx or 0, self.itemvely or 0
        if popouttime > 0 then
            item.gravity = item.gravity or .125
            item.velx = velx
            item.vely = vely
            item.velz = item.gravity * popouttime / 2
        end
        item.opponents = self.opponents
        StateMachine.start(item, "itemWaitForPickup")
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
    -- self.velz = self.popoutspeed or 8
    -- local gravity = self.fallgravity or .5
    -- local floorz = Characters.getCylinderFloorZ(self.x, self.y, self.z, self.bodyradius, self.bodyheight) or 0
    -- repeat
    --     self.velz = self.velz - gravity
    --     yield()
    -- until self.z <= floorz
    -- self.z = floorz
    -- self.velz = 0
    return "itemWaitForPickup"
end

function Common:itemWaitForPickup()
    local opponent = self.opponents[1]
    local t = -1
    while true do
        local finished
        t = t + 1
        self:accelerateTowardsVel(0, 0, 10)
        if self.gravity == 0 then
            local _, _, _, penex
                = Characters.keepCylinderIn(self.x, self.y, self.z, self.bodyradius, self.bodyheight)
            if not penex then
                self.gravity = 0.25
            end
        end
        if self.healhealth then
            if opponent.health < opponent.maxhealth then
                local redblue = (t%30)/15
                self.color = Color.asARGBInt(redblue, 1, redblue, 1)
                if Body.testBodyCollision(self, opponent) then
                    Audio.play(self.itemgetsound)
                    opponent:heal(self.healhealth)
                    finished = true
                end
            else
                self.color = Color.White
            end
        elseif self.givemana then
            if opponent.manastore < opponent.manastoremax then
                local greenblue = (t%30)/15
                local red = .5 + greenblue
                self.color = Color.asARGBInt(red, greenblue, greenblue, 1)
                if Body.testBodyCollision(self, opponent) then
                    Audio.play(self.itemgetsound)
                    Mana.store(opponent, self.givemana)
                    finished = true
                end
            else
                self.color = Color.White
            end
        elseif self.giveweapon then
            local weapontype = self.giveweapon
            local tryToGiveWeapon = opponent.tryToGiveWeapon
            if tryToGiveWeapon and weapontype then
                if Body.testBodyCollision(self, opponent) then
                    if tryToGiveWeapon(opponent, weapontype) then
                        finished = true
                    end
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

function Common:storeMana(mana)
    if self.thrower and self.thrower.storeMana then
        self.thrower:storeMana(mana)
    end
end

function Common:projectileShatter(opponent)
    self:stopAttack()
    self.velx = 0
    self.vely = 0
    self.velz = 0
    self:spark(self.state.statetime or 30)
end

function Common:projectileHit(opponent)
    if opponent then
        -- Audio.play(self.hitsound)
    else
        Audio.play(self.bodyslamsound)
    end
    DirectionalAnimation.set(self, self.attackhitanimation, self.attackangle)
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
    self.gravity = 0
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
        local numopponentshit = self.numopponentshit or 0
        if self.itemtype and #items < MaxProjectileItems and numopponentshit <= 0 then
            Characters.spawn({
                type = self.itemtype,
                x = self.x, y = self.y, z = self.z,
                gravity = 0
            })
            self:disappear()
        else
            return "blinkOut", 30
        end
    end
end

function Common:becomeItem()
    if Database.get(self.itemtype) then
        Characters.spawn({
            type = self.itemtype,
            x = self.x, y = self.y, z = self.z
        })
    end
    self:disappear()
end

local function findHomingTarget(self, objects)
    local best
    local bestdsq = math.huge
    local x, y = self.x, self.y
    local z = self.z + self.bodyheight/2
    for _, object in ipairs(objects) do
        if object.health > 0 and object.canbeattacked then
            local dsq = math.distsq3(x, y, z, object.x, object.y, object.z + object.bodyheight/2)
            if dsq < bestdsq then
                best = object
                bestdsq = dsq
            end
        end
    end
    return best
end

function Common:projectileHoming()
    local oobx, ooby, oobz
    local lifetime = self.lifetime or 60
    local opponents = self.opponents
    repeat
        local _
        _, _, _, oobx, ooby, oobz = Body.predictCollisionVelocity(self)
        if oobx or ooby then
            self.velx, self.vely = math.reflect(self.velx, self.vely, -oobx or 0, -ooby or 0)
        end
        if oobz then
            self.velz = -self.velz
        end
        local nearest = findHomingTarget(self, opponents)
        if nearest then
            local vx = nearest.x - self.x
            local vy = nearest.y - self.y
            local vz = nearest.z + nearest.bodyheight/2 - self.z - self.bodyheight/2
            if vx ~= 0 or vy ~= 0 or vz ~= 0
            then
                vx, vy, vz = math.norm(vx, vy, vz)
                self:accelerateTowardsVel3(vx * self.speed, vy * self.speed, vz * self.speed, 8)
            end
        end
        if self.velx ~= 0 or self.vely ~= 0 then
            Face.faceVector(self, self.velx, self.vely, self.state.animation)
            self:startAttack(self.faceangle)
        end
        yield()
        lifetime = lifetime - 1
    until lifetime <= 0
    local attackhitai = self.attackhitboundaryai or self.attackhitai
    if attackhitai then
        return attackhitai, oobx, ooby, oobz
    end
    self:disappear()
end

function Common:projectileBounce(opponent, ooby, oobz)
    self:stopAttack()
    local oobx = type(opponent) == "number" and opponent
    opponent = type(opponent) == "table" and opponent or nil
    if opponent then
    else
        Audio.play(self.bodyslamsound)
    end
    self.gravity = max(self.gravity or 0, .25)
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
        oobx, ooby, oobz = Body.keepInBounds(self)
    until oobz and oobz <= 0
    self.velx, self.vely, self.velz = 0, 0, 0
    local items = Characters.getGroup("items")
    local numopponentshit = self.numopponentshit or 0
    if not opponent and self.itemtype and #items < MaxProjectileItems and numopponentshit <= 0 then
        self:becomeItem()
    else
        return "blinkOut", 30
    end
end

function Common:projectileFly(shooter)
    local angle = self.attackangle
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
    local oobx, ooby, oobz
    local lifetime = self.lifetime
    repeat
        yield()
        oobx, ooby, oobz = Body.keepInBounds(self)
        if lifetime then
            lifetime = lifetime - 1
        end
    until oobx or ooby or oobz or lifetime and lifetime <= 0
    local attackhitai = self.attackhitboundaryai or self.attackhitai
    if attackhitai then
        return attackhitai, oobx, ooby, oobz
    end
    self:disappear()
end

function Common:projectileDeflected(deflector)
    if not deflector.attackdeflectsprojectile then
        return "projectileBounce", deflector
    end
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
    DirectionalAnimation.set(self, self.swinganimation, angle, 1, self.swinganimationloopframe or 1)
    yield()
    return "projectileFly", deflector
end

function Common:makeImpactSpark(attacker, sparktype)
    if sparktype then
        local hitsparkcharacter = {
            type = sparktype,
        }
        hitsparkcharacter.x, hitsparkcharacter.y = math.mid(attacker.x, attacker.y, self.x, self.y)
        local z1, z2 =
            math.max(self.z, attacker.z),
            math.min(self.z + self.bodyheight, attacker.z + attacker.bodyheight)
        hitsparkcharacter.z = z1 + (z2-z1)/2
        return Characters.spawn(hitsparkcharacter)
    end
end

function Common:guardHit(attacker)
    Audio.play(self.guardhitsound)
    self:makeImpactSpark(attacker, attacker.guardhitspark)
    self.hurtstun = attacker.attackguardstun or 6
    yield()
    return self.recoverai or self.initialai
end

return Common
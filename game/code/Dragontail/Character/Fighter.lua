local Audio = require "System.Audio"
local Database = require "Data.Database"
local Common   = require "Dragontail.Character.Common"
local Characters = require "Dragontail.Stage.Characters"
local TiledObject = require "Tiled.Object"

---@class Fighter:Common
local Fighter = class(Common)

local huge = math.huge
local cos = math.cos
local sin = math.sin
local norm = math.norm
local atan2 = math.atan2
local mid = math.mid
local yield = coroutine.yield
local dist = math.dist

function Fighter:init()
    Common.init(self)
    self.facex = self.facex or 1
    self.facey = self.facey or 0
end

function Fighter:startHolding(opponent)
    self.heldopponent = opponent
    opponent:stopAttack()
    opponent:stopGuarding()
    opponent.heldby = self
end

function Fighter:isHolding(opponent)
    return self.heldopponent == opponent
        and opponent.heldby == self
end

function Fighter:stopHolding(opponent)
    if self then
        self.heldopponent = nil
    end
    if opponent then
        opponent.heldby = nil
    end
end

function Fighter.GetSlideDistance(speed, decel)
    return speed * (speed+decel) / 2
end

--- Burst of speed towards angle (away from angle if speed < 0) then slow to 0
function Fighter:slide(angle, speed, decel)
    repeat
        speed = self:updateSlideSpeed(angle, speed, decel)
        self:keepInBounds()
        yield()
    until speed == 0
end

function Fighter:updateSlideSpeed(angle, speed, decel)
    decel = decel or 1
    self.velx = speed * cos(angle)
    self.vely = speed * sin(angle)
    if speed < 0 then
        speed = math.min(0, speed + decel)
    else
        speed = math.max(0, speed - decel)
    end
    return speed
end

function Fighter:hurt(attacker)
    local hurtangle = atan2(attacker.y - self.y, attacker.x - self.x)
    if not hurtangle == hurtangle then
        hurtangle = 0
    end
    self.hurtangle = hurtangle
    self.hurtparticle = attacker.attackhurtparticle
    self.hurtcolorcycle = attacker.attackhurtcolorcycle
    self:makeImpactSpark(attacker, attacker.hitspark)
    self.health = self.health - attacker.attackdamage
    self.velx, self.vely = 0, 0
    self:stopAttack()
    Fighter.stopHolding(self, self.heldopponent)
    self.hurtstun = attacker.attackstun or 3
    local facex, facey = self.facex or 1, self.facey or 0
    if facex == 0 and facey == 0 then
        facex = 1
    end

    local hitsound = attacker.hitsound
    if self.health <= 0 then
        hitsound = attacker.attackdefeatsound or hitsound
    end
    Audio.play(hitsound)
    local attackangle = attacker.attackangle
    local defeateffect = attacker.attackdefeateffect
    local hiteffect = attacker.attackhiteffect
    local pushbackspeed = attacker.attackpushbackspeed or 0
    yield()

    if self.health <= 0 then
        Fighter.stopHolding(self.heldby, self)
        defeateffect = defeateffect or self.defeatai or "defeat"
        return defeateffect, attacker, attackangle
    elseif hiteffect then
        Fighter.stopHolding(self.heldby, self)
        return hiteffect, attacker, attackangle
    end
    Audio.play(self.hurtsound)
    if self.heldby then
        if self.heldby:isHolding(self) then
            return "held", self.heldby
        end
        self.heldby = nil
    end
    while pushbackspeed > 0 do
        pushbackspeed = Fighter.updateSlideSpeed(self, attackangle, pushbackspeed)
        self:keepInBounds()
        yield()
    end
    self.velx, self.vely, self.velz = 0, 0, 0
    local recoverai = self.aiafterhurt or self.recoverai
    if not recoverai then
        print("No aiafterhurt or recoverai for "..self.type)
        Fighter.stopHolding(self.heldby, self)
        return "defeat", attacker
    end
    return recoverai
end

-- function Fighter:stun(duration)
--     self:stopAttack()
--     self.velx, self.vely = 0, 0
--     Audio.play(self.stunsound)
--     self.canbegrabbed = true
--     duration = duration or 120
--     wait(duration)
--     self.canbegrabbed = nil
--     return Fighter.defeat, "FallFlat"
-- end

function Fighter:held(holder)
    self:stopAttack()
    self:stopGuarding()
    self.velx, self.vely = 0, 0
    while holder:isHolding(self) do
        local dx, dy = holder.x - self.x, holder.y - self.y
        if dx == 0 and dy == 0 then
            dx = 1
        end
        yield()
    end
    local recoverai = self.aiafterheld or self.recoverai
    if not recoverai then
        print("No aiafterheld or recoverai for "..self.type)
        return "defeat", holder
    end
    return recoverai
end

function Fighter:knockedBack(thrower, attackangle)
    Audio.play(self.thrownsound)
    local dirx, diry
    if attackangle then
        dirx, diry = cos(attackangle), sin(attackangle)
    else
        local velx, vely = thrower.velx, thrower.vely
        if velx ~= 0 or vely ~= 0 then
            dirx, diry = norm(velx, vely)
        else
            dirx, diry = norm(self.x - thrower.x, self.y - thrower.y)
        end
    end
    self.hurtstun = 0
    self:stopAttack()
    local thrownspeed = thrower.attacklaunchspeed or 10
    self.velx, self.vely = dirx*thrownspeed, diry*thrownspeed
    self.velz = thrower.attackpopupspeed or 4
    local oobx, ooby, oobz
    repeat
        yield()
        oobx, ooby, oobz = self:keepInBounds()
    until oobx or ooby or oobz
    local oobdotvel = math.dot(oobx or 0, ooby or 0, self.velx, self.vely)
    if oobdotvel > 0 then
        oobdotvel = oobdotvel
            / math.len(self.velx, self.vely)
            / math.len(oobx, ooby)
    end
    if oobdotvel > .5 then
        return "wallBump", thrower, oobx, ooby
    end
    if oobz then
        self.velz = 0
    end

    return self.aiafterthrown or "fall", thrower
end

function Fighter:wallBump(thrower, oobx, ooby)
    oobx, ooby = norm(oobx or 0, ooby or 0)
    self:stopAttack()
    local bodyradius = self.bodyradius or 1
    Characters.spawn(
        {
            type = "spark-hit",
            x = self.x + oobx*bodyradius,
            y = self.y + ooby*bodyradius,
            z = self.z + self.bodyheight/2
        }
    )
    self.health = self.health - (self.wallbumpdamage or 10)
    self.hurtstun = self.wallbumpstun or 3
    self.velx, self.vely, self.velz = 0, 0, 0
    yield()
    local wallslamcounterattack = self.wallslamcounterattack
    if self.health > 0 and wallslamcounterattack and self.attack then
        Database.fill(self, wallslamcounterattack)
        return "attack", wallslamcounterattack
    end
    return "fall", thrower
end

function Fighter:thrown(thrower, attackangle)
    self.thrower = thrower
    Audio.play(self.thrownsound)
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
    self.hurtstun = 0
    self.attacktype = "human-thrown"
    Database.fill(self, "human-thrown")
    local thrownspeed = thrower.attacklaunchspeed or 10
    self.velx, self.vely = dirx*thrownspeed, diry*thrownspeed
    self.velz = thrower.attackpopupspeed or 4
    local thrownsound = Audio.newSource(self.swingsound)
    thrownsound:play()
    local thrownslidetime = self.thrownslidetime or 10
    local oobx, ooby, oobz
    local oobdotvel = 0
    repeat
        yield()
        oobx, ooby, oobz = self:keepInBounds()
        if oobz then
            self.velz = 0
            thrownslidetime = thrownslidetime - 1
        end
        oobdotvel = math.dot(oobx or 0, ooby or 0, self.velx, self.vely)
        if oobdotvel > 0 then
            oobdotvel = oobdotvel
                / math.len(self.velx, self.vely)
                / math.len(oobx, ooby)
        end
    until thrownslidetime <= 0 or oobdotvel > .5
    thrownsound:stop()
    self.thrower = nil
    if oobdotvel > .5 then
        return "wallSlammed", thrower, oobx, ooby
    end

    return self.aiafterthrown or "fall", thrower
end

function Fighter:wallSlammed(thrower, oobx, ooby)
    oobx, ooby = norm(oobx or 0, ooby or 0)
    local bodyradius = self.bodyradius or 1
    Characters.spawn(
        {
            type = "spark-bighit",
            x = self.x + oobx*bodyradius,
            y = self.y + ooby*bodyradius
        }
    )
    self.health = self.health - (self.wallslamdamage or 25)
    self.velx, self.vely, self.velz = 0, 0, 0
    yield()
    self:stopAttack()
    self.hurtstun = self.wallslamstun or 20
    yield()
    local wallslamcounterattack = self.wallslamcounterattack
    if self.health > 0 and wallslamcounterattack and self.attack then
        Database.fill(self, wallslamcounterattack)
        return "attack", wallslamcounterattack
    end
    return "fall", thrower
end

function Fighter:thrownRecover(thrower)
    local recovertime = self.thrownrecovertime or 10
    local oobx, ooby
    repeat
        yield()
        self:accelerateTowardsVel(0, 0, recovertime)
        oobx, ooby = self:keepInBounds()
        recovertime = recovertime - 1
    until recovertime <= 0 or oobx or ooby

    self:stopAttack()
    if oobx or ooby then
        return "wallSlammed", thrower, oobx, ooby
    end

    local recoverai = self.recoverai
    if not recoverai then
        print("No recoverai for "..self.type)
        return "defeat", thrower
    end
    return recoverai
end

function Fighter:breakaway(other)
    Fighter.stopHolding(other, self)
    Fighter.stopHolding(self, other)
    local breakspeed = 10
    local dirx, diry = norm(other.x - self.x, other.y - self.y)
    self:makeImpactSpark(other, "spark-hit")
    self.velx, self.vely = -dirx * breakspeed, -diry * breakspeed

    local t = 1
    -- self.hurtstun = self.breakawaystun or 15
    repeat
        yield()
        self:accelerateTowardsVel(0, 0, 8)
        self:keepInBounds()
        t = t + 1
    until t > 15

    self.velx, self.vely = 0, 0
    local attackafterbreakaway = self.attackafterbreakaway
    if attackafterbreakaway then
        Database.fill(self, attackafterbreakaway)
    end
    return self.aiafterbreakaway or self.recoverai
end

function Fighter:fall(attacker)
    local t = 0
    local _, penez
    local fallanimationtime = self.fallanimationtime or 1
    repeat
        self:accelerateTowardsVel(0, 0, 8)
        yield()
        _, _, penez = self:keepInBounds()
        if penez then
            t = t + 1
            self.velz = 0
            self:changeAseAnimation("Fall", 1, 0)
        end
    until t >= fallanimationtime
    Audio.play(self.bodydropsound)
    Characters.spawn({
        type = "spark-fall-down-dust",
        x = self.x,
        y = self.y + 1,
        z = self.z,
    })
    self:stopAttack()

    if self.health > 0 then
        t = 1
        repeat
            self:accelerateTowardsVel(0, 0, 8)
            yield()
            self:keepInBounds()
            t = t + 1
        until t > 20
        self.velx, self.vely, self.velz = 0, 0, 0
        return self.getupai or "getup", attacker
    end
    self.velx, self.vely, self.velz = 0, 0, 0
    return "defeat", attacker
end

function Fighter:defeat(attacker)
    self:stopAttack()
    self.velx, self.vely = 0, 0
    Audio.play(self.defeatsound)
    self:changeAnimation(self.defeatedanimation or "defeated", 1, 0)
    self:dropDefeatItem()
    yield()
    return "blinkOut", 60
end

function Fighter:getup(attacker)
    coroutine.wait(self.getuptime or 27)
    local recoverai = self.aiaftergetup or self.recoverai
    if not recoverai then
        print("No aiaftergetup or recoverai for "..self.type)
        return "defeat", attacker
    end
    return recoverai
end

function Fighter:launchProjectileAtObject(type, object, attackid)
    return self:launchProjectileAtPosition(type, object.x, object.y, object.z, attackid)
end

function Fighter:launchProjectileAtPosition(projectile, targetx, targety, targetz, attackid)
    if type(projectile) == "string" then
        projectile = { type = projectile }
    end
    local projectiledata = Database.get(projectile.type)
    Database.fillBlanks(projectile, projectiledata)

    local x, y, z = self.x, self.y, self.z
    local distx, disty, distz = targetx - x, targety - y, targetz - z
    if distx == 0 and disty == 0 then
        distx = 1
    end

    local dst = math.len(distx, disty, distz)
    local dirx, diry = distx/dst, disty/dst

    local gravity = projectile.gravity or 0
    local speed = projectile.speed or 1
    if speed == 0 then
        speed = 1
    end
    local time = dst / speed

    local velx = dirx * speed
    local vely = diry * speed

    -- z = gravity*t^2/2 + v0*t + z0
    -- dz = gravity*t^2/2 + v0*t
    -- dz/t = gravity*t/2 + v0
    -- v0 = dz/t - gravity*t/2
    local velz = distz/time + gravity * time * .5
    local projectileheight = self.projectilelaunchheight or (self.bodyheight / 2)
    projectile.x = x
    projectile.y = y
    projectile.z = z + projectileheight
    projectile.velx = velx
    projectile.vely = vely
    projectile.velz = velz
    projectile.attackangle = atan2(diry, dirx)
    projectile.thrower = self

    if Database.get(attackid) then
        projectile.defaultattack = attackid
    end
    return Characters.spawn(projectile)
end

function Fighter:launchProjectile(type, dirx, diry, dirz, attackid)
    local projectiledata = Database.get(type)
    if not projectiledata then
        return
    end

    local x, y, z = self.x, self.y, self.z
    local bodyradius, bodyheight = self.bodyradius or 0, self.bodyheight or 0
    local speed = projectiledata.speed or 1
    local projectileheight = self.projectilelaunchheight or (bodyheight / 2)
    local projectile = {
        x = x + bodyradius*dirx,
        y = y + bodyradius*diry,
        z = z + projectileheight,
        velx = speed*dirx,
        vely = speed*diry,
        velz = speed*dirz,
        type = type,
        attackangle = atan2(diry, dirx),
        thrower = self
    }
    if Database.get(attackid) then
        projectile.defaultattack = attackid
    end
    return Characters.spawn(projectile)
end
return Fighter
local Audio = require "System.Audio"
local Database = require "Data.Database"
local Common   = require "Dragontail.Character.Common"
local Characters = require "Dragontail.Stage.Characters"

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
    local hitspark = attacker.hitspark
    if hitspark then
        local hitsparkcharacter = {
            type = hitspark,
        }
        hitsparkcharacter.x, hitsparkcharacter.y = mid(attacker.x, attacker.y, self.x, self.y)
        Characters.spawn(hitsparkcharacter)
    end
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
    local gravity = self.fallgravity or .5
    local oobx, ooby, oobz
    repeat
        yield()
        oobx, ooby, oobz = self:keepInBounds()
        self.velz = self.velz - gravity
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

    return self.aiafterthrown or "fall"
end

function Fighter:wallBump(thrower, oobx, ooby)
    oobx, ooby = norm(oobx or 0, ooby or 0)
    self:stopAttack()
    local bodyradius = self.bodyradius or 1
    Characters.spawn(
        {
            type = "spark-hit",
            x = self.x + oobx*bodyradius,
            y = self.y + ooby*bodyradius
        }
    )
    self.health = self.health - (self.wallbumpdamage or 10)
    self.hurtstun = self.wallbumpstun or 3
    self.velx, self.vely, self.velz = 0, 0, 0
    yield()
    local wallslamcounterattack = self.wallslamcounterattack
    if self.health > 0 and wallslamcounterattack and self.attack then
        Database.fill(self, wallslamcounterattack)
        return "attack", wallslamcounterattack, atan2(-(ooby or 0), -(oobx or 0))
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
    Database.fill(self, "human-thrown")
    local thrownspeed = thrower.attacklaunchspeed or 10
    self.velx, self.vely = dirx*thrownspeed, diry*thrownspeed
    self.velz = thrower.attackpopupspeed or 4
    local gravity = self.fallgravity or .5
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
        else
            self.velz = self.velz - gravity
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

    return self.aiafterthrown or "fall"
end

function Fighter:wallSlammed(thrower, oobx, ooby)
    oobx, ooby = norm(oobx or 0, ooby or 0)
    self:stopAttack()
    local bodyradius = self.bodyradius or 1
    Characters.spawn(
        {
            type = "spark-bighit",
            x = self.x + oobx*bodyradius,
            y = self.y + ooby*bodyradius
        }
    )
    self.health = self.health - (self.wallslamdamage or 25)
    self.hurtstun = self.wallslamstun or 20
    self.velx, self.vely, self.velz = 0, 0, 0
    yield()
    local wallslamcounterattack = self.wallslamcounterattack
    if self.health > 0 and wallslamcounterattack and self.attack then
        Database.fill(self, wallslamcounterattack)
        return "attack", wallslamcounterattack, atan2(-(ooby or 0), -(oobx or 0))
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
    local bodyradius = self.bodyradius
    local hitsparkcharacter = {
        type = "spark-hit",
        x = self.x + dirx*bodyradius,
        y = self.y + diry*bodyradius,
    }
    Characters.spawn(hitsparkcharacter)
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
    local t = 1
    local _, penez
    local gravity = self.fallgravity or .5
    repeat
        self:accelerateTowardsVel(0, 0, 8)
        yield()
        _, _, penez = self:keepInBounds()
        if penez then
            t = t + 1
            self.velz = 0
            self:changeAseAnimation("Fall", 1, 0)
        else
            self.velz = self.velz - gravity
        end
    until t > 20
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
        return self.getupai or "getup", attacker
    end
    return "defeat", attacker
end

function Fighter:defeat(attacker)
    self:stopAttack()
    self.velx, self.vely = 0, 0
    Audio.play(self.defeatsound)
    yield()
    return "blinkOut", 60
end

function Fighter:getup(attacker)
    coroutine.wait(27)
    local recoverai = self.aiaftergetup or self.recoverai
    if not recoverai then
        print("No aiaftergetup or recoverai for "..self.type)
        return "defeat", attacker
    end
    return recoverai
end

function Fighter:launchProjectileAtObject(type, object)
    local distx, disty, distz = object.x - self.x, object.y - self.y, object.z - self.z
    local dirx, diry, dirz = norm(distx, disty, distz)
    return self:launchProjectile(type, dirx, diry, dirz)
end

function Fighter:launchProjectile(type, dirx, diry, dirz)
    local projectiledata = Database.get(type)
    if not projectiledata then
        return
    end

    local x, y, z = self.x, self.y, self.z
    local bodyradius, bodyheight = self.bodyradius or 0, self.bodyheight or 0
    local speed = projectiledata.speed or 1
    return Characters.spawn({
        x = x + bodyradius*dirx,
        y = y + bodyradius*diry,
        z = z + bodyheight / 2,
        velx = speed*dirx,
        vely = speed*diry,
        velz = speed*dirz,
        type = type,
        attackangle = atan2(diry, dirx),
        thrower = self
    })
end
return Fighter
local Stage = require "Dragontail.Stage"
local Audio = require "System.Audio"
local Database = require "Data.Database"
local Common   = require "Dragontail.Character.Common"
local Character= require "Dragontail.Character"

---@class Fighter:Character
local Fighter = class(Character)

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
    local bounds = self.bounds
    repeat
        speed = self:updateSlideSpeed(angle, speed, decel)
        if bounds then
            self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
        end
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
        Stage.addCharacter(hitsparkcharacter)
    end
    self.health = self.health - attacker.attackdamage
    self.canbeattacked = nil
    self.canbegrabbed = nil
    self.velx, self.vely = 0, 0
    self:stopAttack()
    Fighter.stopHolding(self, self.heldopponent)
    self.hurtstun = attacker.attackstun or 3
    local facex, facey = self.facex or 1, self.facey or 0
    if facex == 0 and facey == 0 then
        facex = 1
    end
    local hurtanimation = self.getDirectionalAnimation_angle("hurt", atan2(facey, facex), self.animationdirections)
    local aseprite = self.aseprite
    if aseprite and aseprite.animations[hurtanimation] then
        self:changeAseAnimation(hurtanimation, 1, 0)
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
    local bounds = self.bounds
    while pushbackspeed > 0 do
        pushbackspeed = Fighter.updateSlideSpeed(self, attackangle, pushbackspeed)
        self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
        yield()
    end
    local recoverai = self.aiafterhurt or self.recoverai
    if not recoverai then
        print("No aiafterhurt or recoverai for "..self.type)
        Fighter.stopHolding(self.heldby, self)
        return "defeat", attacker
    end
    self.canbeattacked = true
    self.canbegrabbed = true
    if self.heldby then
        return "held", self.heldby
    end
    return recoverai
end

-- function Fighter:stun(duration)
--     self:stopAttack()
--     self.velx, self.vely = 0, 0
--     self:changeAseAnimation("FallKnees", 1, 0)
--     Audio.play(self.stunsound)
--     self.canbegrabbed = true
--     duration = duration or 120
--     wait(duration)
--     self.canbegrabbed = nil
--     return Fighter.defeat, "FallFlat"
-- end

function Fighter:held(holder)
    self.canbeattacked = true
    self.canbegrabbed = true
    self:stopAttack()
    self:stopGuarding()
    self.velx, self.vely = 0, 0
    while self.heldby == holder do
        local dx, dy = holder.x - self.x, holder.y - self.y
        if dx == 0 and dy == 0 then
            dx = 1
        end
        local hurtanimation = self.getDirectionalAnimation_angle(self.heldanimation or "Stand", atan2(dy, dx), self.animationdirections)
        local aseprite = self.aseprite
        if aseprite and aseprite.animations[hurtanimation] then
            self:changeAseAnimation(hurtanimation, 1, 0)
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
    self.canbeattacked = false
    self.canbegrabbed = nil
    self.hurtstun = 0
    -- self:changeAseAnimation("knockedback")
    self:stopAttack()
    local thrownspeed = thrower.attacklaunchspeed or 10
    self.velx, self.vely = dirx*thrownspeed, diry*thrownspeed
    local bounds = self.bounds
    local recovertime = self.knockedbacktime or 10
    local oobx, ooby
    repeat
        yield()
        oobx, ooby = self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
        recovertime = recovertime - 1
    until recovertime <= 0 or oobx or ooby
    if oobx or ooby then
        return Fighter.wallBump, thrower, oobx, ooby
    end

    return self.aiafterthrown or "fall"
end

function Fighter:wallBump(thrower, oobx, ooby)
    oobx, ooby = norm(oobx or 0, ooby or 0)
    self:stopAttack()
    local bodyradius = self.bodyradius or 1
    Stage.addCharacter(
        {
            type = "spark-hit",
            x = self.x + oobx*bodyradius,
            y = self.y + ooby*bodyradius
        }
    )
    Audio.play(self.bodybumpsound)
    self.health = self.health - (self.wallbumpdamage or 10)
    self.hurtstun = self.wallbumpstun or 3
    self.velx, self.vely = 0, 0
    yield()
    local wallslamcounterattack = self.wallslamcounterattack
    if self.health > 0 and wallslamcounterattack and self.attack then
        Database.fill(self, wallslamcounterattack)
        self.canbeattacked = true
        self.canbegrabbed = true
        return self.attack, wallslamcounterattack, atan2(-(ooby or 0), -(oobx or 0))
    end
    return Fighter.fall, thrower
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
    self.canbeattacked = false
    self.canbegrabbed = nil
    self.hurtstun = 0
    self:changeAseAnimation("spin")
    Database.fill(self, "human-thrown")
    local thrownspeed = thrower.attacklaunchspeed or 10
    self.velx, self.vely = dirx*thrownspeed, diry*thrownspeed
    local thrownsound = Audio.newSource(self.swingsound)
    thrownsound:play()
    local bounds = self.bounds
    local recovertime = self.thrownrecovertime or 30
    local oobx, ooby
    repeat
        yield()
        oobx, ooby = self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
        recovertime = recovertime - 1
    until recovertime <= 0 or oobx or ooby
    thrownsound:stop()
    self.thrower = nil
    if oobx or ooby then
        return Fighter.wallSlammed, thrower, oobx, ooby
    end

    return self.aiafterthrown or "fall"
end

function Fighter:wallSlammed(thrower, oobx, ooby)
    self.canbeattacked = false
    self.canbegrabbed = nil
    oobx, ooby = norm(oobx or 0, ooby or 0)
    self:stopAttack()
    local bodyradius = self.bodyradius or 1
    Stage.addCharacter(
        {
            type = "spark-bighit",
            x = self.x + oobx*bodyradius,
            y = self.y + ooby*bodyradius
        }
    )
    Audio.play(self.bodyslamsound)
    self.health = self.health - (self.wallslamdamage or 25)
    self.hurtstun = self.wallslamstun or 20
    self.velx, self.vely = 0, 0
    yield()
    local wallslamcounterattack = self.wallslamcounterattack
    if self.health > 0 and wallslamcounterattack and self.attack then
        Database.fill(self, wallslamcounterattack)
        self.canbeattacked = true
        self.canbegrabbed = true
        return self.attack, wallslamcounterattack, atan2(-(ooby or 0), -(oobx or 0))
    end
    return Fighter.fall, thrower
end

function Fighter:thrownRecover(thrower)
    if self.thrownrecoveranimation then
        self:changeAseAnimation(self.thrownrecoveranimation, 1, 0)
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
        return Fighter.wallSlammed, thrower, oobx, ooby
    end

    self.canbeattacked = true
    self.canbegrabbed = true
    local recoverai = self.recoverai
    if not recoverai then
        print("No recoverai for "..self.type)
        return "defeat", thrower
    end
    return recoverai
end

function Fighter:breakaway(other)
    Audio.play(self.breakawaysound)
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
    Stage.addCharacter(hitsparkcharacter)
    self.velx, self.vely = -dirx * breakspeed, -diry * breakspeed

    local bounds = self.bounds
    local t = 1
    -- self.hurtstun = self.breakawaystun or 15
    repeat
        yield()
        self:accelerateTowardsVel(0, 0, 8)
        self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
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
    self.canbegrabbed = nil
    self.canbeattacked = false
    local defeatanimation = self.defeatanimation or "Fall"
    local bounds = self.bounds
    self:changeAseAnimation(defeatanimation, 1, 0)
    local t = 1
    repeat
        self:accelerateTowardsVel(0, 0, 8)
        yield()
        self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
        t = t + 1
    until t > 20
    Audio.play(self.bodydropsound)
    self:stopAttack()

    if self.health > 0 then
        t = 1
        repeat
            self:accelerateTowardsVel(0, 0, 8)
            yield()
            self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
            t = t + 1
        until t > 20
        return self.getupai or "getup", attacker
    end
    return "defeat", attacker
end

function Fighter:defeat(attacker)
    self.canbeattacked = false
    self.canbegrabbed = nil
    self:stopAttack()
    self.velx, self.vely = 0, 0
    local defeatanimation = self.defeatanimation or "Fall"
    self:changeAseAnimation(defeatanimation, 1, 0)
    Audio.play(self.defeatsound)
    yield()
    return Common.blinkOut, 60
end

function Fighter:getup(attacker)
    self:changeAseAnimation("FallRiseToFeet", 1, 0)
    coroutine.wait(27)
    local recoverai = self.aiaftergetup or self.recoverai
    if not recoverai then
        print("No aiaftergetup or recoverai for "..self.type)
        return "defeat", attacker
    end
    self.canbeattacked = true
    self.canbegrabbed = true
    return recoverai
end

return Fighter
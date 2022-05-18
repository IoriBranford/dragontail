local Stage = require "Dragontail.Stage"
local Audio = require "System.Audio"
local Database = require "Data.Database"
local Common   = require "Dragontail.Character.Common"
local Fighter = {}

local huge = math.huge
local cos = math.cos
local sin = math.sin
local norm = math.norm
local atan2 = math.atan2
local mid = math.mid
local yield = coroutine.yield

function Fighter:startHolding(opponent)
    self.heldopponent = opponent
    opponent:stopAttack()
    opponent:stopGuarding()
    opponent.bodysolid = nil
    opponent.heldby = self
    opponent.hurtstun = opponent.holdstun or 120
end

function Fighter:stopHolding(opponent)
    if self then
        self.heldopponent = nil
    end
    if opponent then
        opponent.heldby = nil
        opponent.bodysolid = true
        opponent.hurtstun = 0
    end
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
    self.canbegrabbed = nil
    self.velx, self.vely = 0, 0
    self:stopAttack()
    local heldopponent = self.heldopponent
    local heldby = self.heldby
    Fighter.stopHolding(self, heldopponent)
    Fighter.stopHolding(heldby, self)
    self.hurtstun = attacker.attackstun or 3
    local facex, facey = self.facex or 1, self.facey or 0
    local hurtanimation = self.getDirectionalAnimation_angle("hurt", atan2(facey, facex), self.animationdirections)
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
    else
        local hiteffect = attacker.attackhiteffect
        if hiteffect then
            return hiteffect, attacker, attackangle
        end
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

-- function Fighter:stun(duration)
--     self:stopAttack()
--     self.velx, self.vely = 0, 0
--     self.sprite:changeAsepriteAnimation("collapseA", 1, "stop")
--     Audio.play(self.stunsound)
--     self.canbegrabbed = true
--     duration = duration or 120
--     wait(duration)
--     self.canbegrabbed = nil
--     return Fighter.defeat, "collapseB"
-- end

function Fighter:held(holder)
    self:stopAttack()
    self.velx, self.vely = 0, 0
end

function Fighter:thrown(thrower, attackangle)
    Audio.play(self.hurtsound)
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
    local recovertime = self.thrownrecovertime or 30
    local oobx, ooby
    repeat
        yield()
        oobx, ooby = self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
        recovertime = recovertime - 1
    until recovertime <= 0 or oobx or ooby
    thrownsound:stop()
    if oobx or ooby then
        return Fighter.wallSlammed, thrower, oobx, ooby
    end
    local thrownrecoverai = self.thrownrecoverai
    if thrownrecoverai then
        return thrownrecoverai, thrower
    end
    return self.hurtrecoverai
end

function Fighter:wallSlammed(thrower, oobx, ooby)
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
    if self.health > 0 and wallslamcounterattack and self.script.attack then
        Database.fill(self, wallslamcounterattack)
        self.canbegrabbed = true
        self.bodysolid = true
        return self.script.attack, wallslamcounterattack, atan2(-(ooby or 0), -(oobx or 0))
    end
    return Fighter.fall, thrower
end

function Fighter:thrownRecover(thrower)
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
        return Fighter.wallSlammed, thrower, oobx, ooby
    end

    self.bodysolid = true
    return self.hurtrecoverai
end

function Fighter:fall(attacker)
    self.canbegrabbed = nil
    self.bodysolid = false
    self:stopAttack()
    local defeatanimation = self.defeatanimation or "collapse"
    local bounds = self.bounds
    self.sprite:changeAsepriteAnimation(defeatanimation, 1, "stop")
    local t = 1
    repeat
        self:accelerateTowardsVel(0, 0, 8)
        yield()
        self:keepInBounds(bounds.x, bounds.y, bounds.width, bounds.height)
        t = t + 1
    until t > 20
    Audio.play(self.bodydropsound)

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
    self.bodysolid = false
    self.canbegrabbed = nil
    self:stopAttack()
    self.velx, self.vely = 0, 0
    local defeatanimation = self.defeatanimation or "collapse"
    self.sprite:changeAsepriteAnimation(defeatanimation, 1, "stop")
    Audio.play(self.defeatsound)
    yield()
    return Common.blinkOut, 60
end

function Fighter:getup(attacker)
    self.sprite:changeAsepriteAnimation("getup", 1, "stop")
    coroutine.wait(27)
    local recoverai = self.hurtrecoverai
    if not recoverai then
        print("No hurtrecoverai for "..self.type)
        return "defeat", attacker
    end
    self.canbegrabbed = true
    self.bodysolid = true
    return recoverai
end

return Fighter
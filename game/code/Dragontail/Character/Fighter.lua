local Audio = require "System.Audio"
local Database = require "Data.Database"
local Common   = require "Dragontail.Character.Common"
local Characters = require "Dragontail.Stage.Characters"
local TiledObject = require "Tiled.Object"
local Movement    = require "Component.Movement"
local Slide      = require "Dragontail.Character.Action.Slide"
local Face       = require "Dragontail.Character.Action.Face"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"
local DirectionalAnimation = require "Dragontail.Character.DirectionalAnimation"

---@class Mana
---@field mana number?
---@field manamax number?
---@field manaunitsize number?

---@class Combo
---@field comboindex integer?

---@class Dash
---@field dashsound string?
---@field stopdashsound string?

---@class Run
---@field runenergy number?
---@field runenergymax number?
---@field runenergycost number?

---@class Jump
---@field jumplandsound string?

---@class Guard
---@field guardtime integer?
---@field guardhitsound string?
---@field guardcounterattack string?
---@field guardhitstocounterattack integer?

---@class ThrowWeapon
---@field throwtime integer?
---@field throwsound string?

---@class Thrown
---@field thrownslidetime integer?
---@field thrownrecovertime integer?
---@field aiafterthrown string?
---@field thrownsound string?

---@class Fall
---@field fallanimationtime number?
---@field bodydropsound string?

---@class GetUp
---@field getupai string?
---@field getuptime integer?
---@field aiaftergetup string?
---@field getupsound string?

---@class Win
---@field victorysound string?

---@class Fighter:Common,Face,Mana,Combo,Dash,Run,Jump,Dodge,Guard,WeaponInHand,ThrowWeapon,Shoot,HoldOpponent,HeldByOpponent,Thrown,Fall,GetUp,Win
---@field heldopponent Fighter?
---@field heldby Fighter?
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
    self.faceangle = self.faceangle or 0
end

function Fighter:giveMana(mana)
    if not self.mana or not self.manamax then
        return
    end

    mana = self.mana + mana
    if mana > self.manamax then
        mana = self.manamax
    elseif mana < 0 then
        mana = 0
    end
    self.mana = mana
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
    HoldOpponent.stopHolding(self, self.heldopponent)
    self.hurtstun = attacker.attackstun or 3

    if attacker.giveMana then
        local mana = math.max(1, math.floor(attacker.attackdamage/4))
        attacker:giveMana(mana)
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
        HoldOpponent.stopHolding(self.heldby, self)
        defeateffect = defeateffect or self.defeatai or "defeat"
        return defeateffect, attacker, attackangle
    elseif hiteffect then
        HoldOpponent.stopHolding(self.heldby, self)
        return hiteffect, attacker, attackangle
    end
    Audio.play(self.hurtsound)
    if self.heldby then
        if HoldOpponent.isHolding(self.heldby, self) then
            return "held", self.heldby
        end
        self.heldby = nil
    end
    while pushbackspeed > 0 do
        pushbackspeed = Slide.updateSlideSpeed(self, attackangle, pushbackspeed)
        self:keepInBounds()
        yield()
    end
    self.velx, self.vely, self.velz = 0, 0, 0
    local recoverai = self.aiafterhurt or self.recoverai
    if not recoverai then
        print("No aiafterhurt or recoverai for "..self.type)
        HoldOpponent.stopHolding(self.heldby, self)
        return "defeat", attacker
    end
    return recoverai
end

function Fighter:walkTo(destx, desty, timelimit)
    if type(destx) == "table" then
        destx, desty = destx.x, destx.y
    end

    local todestangle = (desty ~= self.y or destx ~= self.x) and atan2(desty - self.y, destx - self.x)
    if todestangle then
        Face.faceAngle(self, todestangle, "Walk")
    end

    timelimit = timelimit or 600
    for i = 1, timelimit do
        if self.x == destx and self.y == desty then
            self.velx, self.vely, self.velz = 0, 0, 0
            if todestangle then
                DirectionalAnimation.set(self, "Stand", todestangle)
            end
            return true
        end
        self.velx, self.vely = Movement.getVelocity_speed(self.x, self.y, destx, desty, self.speed or 1)
        yield()
    end
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
    return HoldOpponent.heldBy(self, holder)
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
    HoldOpponent.stopHolding(other, self)
    HoldOpponent.stopHolding(self, other)
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

function Fighter:beforeGetUp(attacker)
end

function Fighter:duringGetUp(attacker)
end

function Fighter:getup(attacker)
    self:beforeGetUp()
    local time = self.getuptime or 27
    for _ = 1, time do
        yield()
        local state, a, b, c, d, e, f = self:duringGetUp(attacker)
        if state then
            return state, a, b, c, d, e, f
        end
    end
    local recoverai = self.aiaftergetup or self.recoverai
    if not recoverai then
        print("No aiaftergetup or recoverai for "..self.type)
        return "defeat", attacker
    end
    return recoverai
end

return Fighter
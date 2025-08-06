local Audio = require "System.Audio"
local Database = require "Data.Database"
local Common   = require "Dragontail.Character.Common"
local Characters = require "Dragontail.Stage.Characters"
local TiledObject = require "Tiled.Object"
local Movement    = require "Component.Movement"
local Slide      = require "Dragontail.Character.Action.Slide"
local Face       = require "Dragontail.Character.Component.Face"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"
local Mana                 = require "Dragontail.Character.Component.Mana"
local Body                 = require "Dragontail.Character.Component.Body"
local Color                = require "Tiled.Color"
local Guard                = require "Dragontail.Character.Action.Guard"

---@class Dash
---@field dashsound string?
---@field stopdashsound string?

---@class Run
---@field runenergy number?
---@field runenergymax number?
---@field runenergycost number?

---@class Jump
---@field jumplandsound string?

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

---@class GetUp
---@field getupai string?
---@field getuptime integer?
---@field aiaftergetup string?
---@field getupsound string?

---@class Win
---@field victorysound string?

---@class Fighter:Common,Face,Mana,Combo,Dash,Run,Jump,Dodge,WeaponInHand,ThrowWeapon,Shoot,HoldOpponent,HeldByOpponent,Thrown,Fall,GetUp,Win
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
    Face.init(self)
end

Fighter.storeMana = Mana.store

function Fighter:duringHurt() end

---hurt state code
---@param attacker Character
---@return string nextstate
---@return ... next state args
function Fighter:hurt(attacker)
    local hurtangle
    if attacker.y == self.y and attacker.x == self.x then
        hurtangle = 0
    else
        hurtangle = atan2(attacker.y - self.y, attacker.x - self.x)
    end
    self.hurtangle = hurtangle
    self.hurtparticle = attacker.attack.hurtparticle
    self.hurtcolorcycle = attacker.attack.hurtcolorcycle
    self:makeImpactSpark(attacker, attacker.attack.hitspark)
    self.health = self.health - (attacker.attack.damage or 0)
    self.velx, self.vely = 0, 0
    self:stopAttack()
    Guard.stopGuarding(self)
    HoldOpponent.stopHolding(self, self.heldopponent)
    self.hurtstun = attacker.attack.opponentstun or 3

    if attacker.storeMana then
        local mana = attacker.attack.gainmanaonhit
            or math.max(1, math.floor((attacker.attack.damage or 0)/4))
        attacker:storeMana(mana)
    end

    local hitsound = attacker.attack.hitsound
    if self.health <= 0 then
        hitsound = attacker.attack.finalhitsound or hitsound
    end
    Audio.play(hitsound)
    local attackangle = attacker.attackangle
    local defeateffect = attacker.attack.opponentstateonfinalhit
    local hiteffect = attacker.attack.opponentstateonhit
    local pushbackspeed = attacker.attack.pushbackspeed or 0
    yield()

    if self.health <= 0 then
        HoldOpponent.stopHolding(self.heldby, self)
        defeateffect = defeateffect or self.defeatai or "defeat"
        return defeateffect, attacker, attackangle
    elseif hiteffect then
        HoldOpponent.stopHolding(self.heldby, self)
        return hiteffect, attacker, attackangle
    end
    if self.heldby then
        if HoldOpponent.isHolding(self.heldby, self) then
            return "held", self.heldby
        end
        self.heldby = nil
    end
    while pushbackspeed > 0 do
        pushbackspeed = Slide.updateSlideSpeed(self, attackangle, pushbackspeed)
        yield()
        Body.keepInBounds(self)
        self:duringHurt()
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
    if not destx or not desty then return end
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

function Fighter:duringKnockedBack()
end

function Fighter:knockedBack(thrower, attackangle)
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
    self.thrower = thrower
    local thrownspeed = thrower.attack.launchspeed or 10
    self.velx, self.vely = dirx*thrownspeed, diry*thrownspeed
    self.velz = thrower.attackpopupspeed or 4
    local oobx, ooby, oobz
    repeat
        yield()
        oobx, ooby, oobz = Body.keepInBounds(self)
        self:duringKnockedBack()
    until oobx or ooby or oobz
    local oobdotvel = math.dot(oobx or 0, ooby or 0, self.velx, self.vely)
    if oobdotvel > 0 then
        oobdotvel = oobdotvel
            / math.len(self.velx, self.vely)
            / math.len(oobx, ooby)
    end
    self.thrower = nil
    if oobdotvel > .5 then
        return "wallBump", thrower, oobx, ooby
    end
    if oobz then
        self.velz = 0
    end

    return self.aiafterthrown or "fall", thrower
end

function Fighter:knockedBackOrThrown(thrower, attackangle)
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
    if attackangle and self.attacktype then
        self:startAttack(attackangle)
    else
        self:stopAttack()
    end
    self.thrower = thrower
    local thrownspeed = thrower.attack.launchspeed or 10
    self.velx, self.vely = dirx*thrownspeed, diry*thrownspeed
    self.velz = thrower.attackpopupspeed or 4
    local thrownsound = self.attack.swingsound and Audio.newSource(self.attack.swingsound)
    if thrownsound then thrownsound:play() end
    local thrownslidetime = self.thrownslidetime or 1
    local oobx, ooby, oobz
    local oobdotvel = 0
    while thrownslidetime > 0 and oobdotvel <= .5 do
        yield()
        oobx, ooby, oobz = Body.keepInBounds(self)
        self:duringKnockedBack()
        if oobz then
            thrownslidetime = thrownslidetime - 1
        end
        oobdotvel = math.dot(oobx or 0, ooby or 0, self.velx, self.vely)
        if oobdotvel > 0 then
            oobdotvel = oobdotvel
                / math.len(self.velx, self.vely)
                / math.len(oobx, ooby)
        end
    end
    if thrownsound then thrownsound:stop() end
    self.thrower = nil
    if oobdotvel > .5 then
        return self.knockedintowallstate or "wallBump", thrower, oobx, ooby
    end
    if oobz then
        self.velz = 0
    end

    return self.aiafterthrown or "fall", thrower
end

function Fighter:afterWallBump(thrower)
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
    local nextstate, a, b, c, d, e, f = self:afterWallBump(thrower)
    if nextstate then
        return nextstate, a, b, c, d, e, f
    end
    return "fall", thrower
end

function Fighter:thrown(thrower, attackangle)
    self.thrower = thrower
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
    local thrownspeed = thrower.attack.launchspeed or 10
    self.velx, self.vely = dirx*thrownspeed, diry*thrownspeed
    self.velz = thrower.attackpopupspeed or 4
    local thrownsound = self.attack.swingsound and Audio.newSource(self.attack.swingsound)
    if thrownsound then thrownsound:play() end
    local thrownslidetime = self.thrownslidetime or 10
    local oobx, ooby, oobz
    local oobdotvel = 0
    while thrownslidetime > 0 and oobdotvel <= .5 do
        yield()
        oobx, ooby, oobz = Body.keepInBounds(self)
        if oobz then
            thrownslidetime = thrownslidetime - 1
        end
        oobdotvel = math.dot(oobx or 0, ooby or 0, self.velx, self.vely)
        if oobdotvel > 0 then
            oobdotvel = oobdotvel
                / math.len(self.velx, self.vely)
                / math.len(oobx, ooby)
        end
    end
    if thrownsound then thrownsound:stop() end
    self.thrower = nil
    self:stopAttack()
    if oobdotvel > .5 then
        return "wallSlammed", thrower, oobx, ooby
    end

    return self.aiafterthrown or "fall", thrower
end

function Fighter:afterWallSlammed(thrower)
end

function Fighter:wallSlammed(thrower, oobx, ooby)
    oobx, ooby = norm(oobx or 0, ooby or 0)
    local bodyradius = self.bodyradius or 1
    Characters.spawn(
        {
            type = "spark-bighit",
            x = self.x + oobx*bodyradius,
            y = self.y + ooby*bodyradius,
            z = self.z + self.bodyheight/2
        }
    )
    self.health = self.health - (self.wallslamdamage or 25)
    self.velx, self.vely, self.velz = 0, 0, 0
    self:stopAttack()
    yield() -- a window to be juggled by damaging wall e.g. forge-fire
    self.hurtstun = self.wallslamstun or 20
    yield()
    local nextstate, a, b, c, d, e, f = self:afterWallSlammed(thrower)
    if nextstate then
        return nextstate, a, b, c, d, e, f
    end
    return "fall", thrower
end

function Fighter:thrownRecover(thrower)
    local recovertime = self.thrownrecovertime or 10
    local oobx, ooby, oobz
    repeat
        yield()
        oobx, ooby, oobz = Body.keepInBounds(self)
        self:accelerateTowardsVel(0, 0, recovertime)
        recovertime = recovertime - 1
    until recovertime <= 0 and oobz or oobx or ooby

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
        Body.keepInBounds(self)
        self:accelerateTowardsVel(0, 0, 8)
        t = t + 1
    until t > 15

    self.velx, self.vely = 0, 0
    return self.aiafterbreakaway or self.recoverai
end

function Fighter:duringFall() end

function Fighter:fall(attacker)
    self:stopAttack()
    local t = 0
    local fallanimationtime = self.fallanimationtime or 1
    repeat
        self:accelerateTowardsVel(0, 0, 8)
        yield()
        local _, _, penez = Body.keepInBounds(self)
        self:duringFall()
        if penez then
            t = t + 1
            self.velz = 0
            self:changeAseAnimation("Fall", 1, 0)
        end
    until t >= fallanimationtime
    return "down", attacker
end

function Fighter:down(attacker)
    Characters.spawn({
        type = "spark-fall-down-dust",
        x = self.x,
        y = self.y + 1,
        z = self.z,
    })

    local color = self.color
    if color ~= Color.White then
        self.color = Color.White
        for i = 1, 8 do
            local offsetangle = love.math.random()*2*math.pi
            local offsetdist = love.math.random()*self.bodyradius
            local offsetx = offsetdist*cos(offsetangle)
            local offsety = offsetdist*sin(offsetangle)
            local velx = offsetx/8
            local vely = offsety/8

            Characters.spawn({
                type = "particle",
                x = self.x + offsetx,
                y = self.y + offsety,
                z = self.z,
                velx = velx,
                vely = vely,
                velz = 30/16,
                color = color,
                gravity = 1/16,
                lifetime = 30
            })
        end
    end

    if self.health > 0 then
        local t = 1
        repeat
            yield()
            Body.keepInBounds(self)
            self:duringFall()
            self:accelerateTowardsVel(0, 0, 8)
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
    self:dropDefeatItem()
    Audio.play(self.defeatsound)
    yield()
    return "blinkOut", 60
end

function Fighter:beforeGetUp(attacker)
end

function Fighter:duringGetUp(attacker)
end

function Fighter:duringDodge()
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
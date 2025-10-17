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
local Character            = require "Dragontail.Character"
local WeaponInHand         = require "Dragontail.Character.Component.WeaponInHand"

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

---@class Win
---@field victorysound string?

---@class Fighter:Common,Face,Mana,Combo,Dash,Run,Jump,Dodge,WeaponInHand,ThrowWeapon,Shoot,HoldOpponent,HeldByOpponent,Thrown,Win
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

function Fighter:initAseprite()
    Character.initAseprite(self)
    WeaponInHand.loadHandPositions(self)
end

function Fighter:drawAseprite(fixedfrac)
    local animation = self.aseanimation or self.aseprite
    local aframe = self.animationframe or 1
    local frame = animation and animation[aframe]
    if not frame then
        return
    end

    local r,g,b,a = Color.unpack(self.color)
    love.graphics.setColor(r,g,b,a)

    local velx, vely = self.velx or 0, self.vely or 0
    fixedfrac = fixedfrac or 0

    local x, y = self.x + velx*fixedfrac, self.y + vely*fixedfrac
    love.graphics.push()
    love.graphics.translate(x, y)
    love.graphics.rotate(self.rotation or 0)
    love.graphics.shear(self.skewx or 0, self.skewy or 0)
    love.graphics.scale(self.scalex or 1, self.scaley or 1)

    local originx, originy = self:getOrigin()
    love.graphics.translate(-originx, -originy)

    frame:draw()
    WeaponInHand.draw(self, frame, 0, 0)
    love.graphics.pop()
    -- if self.attacker then
    --     love.graphics.line(self.x, self.y, self.attacker.x, self.attacker.y)
    -- end

    -- local px1, py1 = self.inputlog:newestJoystick()
    -- local px0, py0 = self.inputlog:oldestJoystick()
    -- if px0 and py0 and px1 and py1 then
    --     love.graphics.line(self.x + px0*16, self.y + py0*16, self.x + px1*16, self.y + py1*16)
    -- end

    -- local px, py = self:getParryVector()
    -- if px and py then
    --     love.graphics.line(self.x, self.y, self.x + px*16, self.y + py*16)
    -- end
end

Fighter.storeMana = Mana.store

function Fighter:duringHurt() end

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

function Fighter:updateWalkTo(destx, desty)
    if type(destx) == "table" then
        destx, desty = destx.x, destx.y
    end

    if not destx or not desty then return end

    self.velx, self.vely = Movement.getVelocity_speed(
        self.x, self.y, destx, desty, self.speed or 1)

    if self.velx == 0 and self.vely == 0 then
        DirectionalAnimation.set(self, "Stand", self.faceangle)
        return true
    end

    local todestangle = atan2(desty - self.y, destx - self.x)
    Face.faceAngle(self, todestangle, "Walk")
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

function Fighter:getLedgeDirection()
    local floor = self.floorcharacter
    local floorpoints = floor.points
    if not floorpoints then
        local dsq = math.distsq(self.x, self.y, floor.x, floor.y)
        local mindist = floor.bodyradius - self.bodyradius
        if dsq < mindist*mindist then return 0, 0 end

        return self.x - floor.x, self.y - floor.y
    end

    if not floorpoints.outward then return 0, 0 end
    local x = self.x - floor.x
    local y = self.y - floor.y
    local edgex, edgey, pointa, pointb =
        math.nearestpolygonpoint(floorpoints, x, y)
    local edgedsq = math.distsq(edgex, edgey, x, y)
    if edgedsq > self.bodyradius*self.bodyradius then return 0, 0 end

    local ax = floorpoints[pointa-1]
    local ay = floorpoints[pointa]
    local bx = floorpoints[pointb-1]
    local by = floorpoints[pointb]
    return math.rot90(bx-ax, by-ay, 1)
end

function Fighter:indicateDefeated()
    if self.health <= 0 then
        Audio.play(self.finalfallsound)
        local color = Color.asARGBInt(Color.unpack(self.color))
        if color == Color.White then
            self.color = Color.Grey
        end
    end
end

function Fighter:knockedBack(thrower, attackangle)
    self:indicateDefeated()
    local dirx, diry = self:getLedgeDirection()
    if dirx ~= 0 or diry ~= 0 then
        dirx, diry = norm(dirx, diry)
    elseif attackangle then
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
    local thrownspeed = thrower.attack.launchspeed or 5
    self.velx, self.vely = dirx*thrownspeed, diry*thrownspeed
    self.velz = thrower.attack.launchspeedz or 4
    local oobx, ooby, oobz
    repeat
        yield()
        oobx, ooby, oobz = self.penex, self.peney, self.penez
        self:duringKnockedBack()
    until oobx or ooby or oobz
    -- local oobdotvel = math.dot(oobx or 0, ooby or 0, self.velx, self.vely)
    -- if oobdotvel > 0 then
    --     oobdotvel = oobdotvel
    --         / math.len(self.velx, self.vely)
    --         / math.len(oobx, ooby)
    -- end
    self.thrower = nil
    if oobx and ooby then
        return "wallBump", thrower, oobx, ooby
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
    self.velz = thrower.attack.launchspeedz or 4
    local thrownsound = self.attack.swingsound and Audio.newSource(self.attack.swingsound)
    if thrownsound then thrownsound:play() end
    local thrownslidetime = self.thrownslidetime or 1
    local oobx, ooby, oobz
    local oobdotvel = 0
    while thrownslidetime > 0 and oobdotvel <= .5 do
        yield()
        oobx, ooby, oobz = self.penex, self.peney, self.penez
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
    oobx, ooby = oobx or 0, ooby or 0
    if oobx ~= 0 or ooby ~= 0 then
        oobx, ooby = norm(oobx, ooby)
        local bodyradius = self.bodyradius or 1
        Characters.spawn(
            {
                type = "spark-hit",
                x = self.x + oobx*bodyradius,
                y = self.y + ooby*bodyradius,
                z = self.z + self.bodyheight/2
            }
        )
    end
    self:stopAttack()
    self.health = self.health - (self.wallbumpdamage or 10)
    self.hurtstun = self.wallbumpstun or 3
    self.velx, self.vely, self.velz = 0, 0, 0
    yield()
    self:indicateDefeated()
    local nextstate, a, b, c, d, e, f = self:afterWallBump(thrower)
    if nextstate then
        return nextstate, a, b, c, d, e, f
    end
    return "fall", thrower
end

function Fighter:thrown(thrower, attackangle)
    self.thrower = thrower
    self:indicateDefeated()
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
    self.velz = thrower.attack.launchspeedz or 4
    local thrownsound = self.attack.swingsound and Audio.newSource(self.attack.swingsound)
    if thrownsound then thrownsound:play() end
    local thrownslidetime = self.thrownslidetime or 10
    local oobx, ooby, oobz
    -- local oobdotvel = 0
    while thrownslidetime > 0 and not oobx and not ooby do
        yield()
        oobx, ooby, oobz = self.penex, self.peney, self.penez
        if oobz then
            thrownslidetime = thrownslidetime - 1
        end
        -- oobdotvel = math.dot(oobx or 0, ooby or 0, self.velx, self.vely)
        -- if oobdotvel > 0 then
        --     oobdotvel = oobdotvel
        --         / math.len(self.velx, self.vely)
        --         / math.len(oobx, ooby)
        -- end
    end
    if thrownsound then thrownsound:stop() end
    self.thrower = nil
    self:stopAttack()
    if oobx and ooby then
        return "wallSlammed", thrower, oobx, ooby
    end

    return self.aiafterthrown or "fall", thrower
end

function Fighter:afterWallSlammed(thrower)
end

function Fighter:wallSlammed(thrower, oobx, ooby)
    oobx, ooby = oobx or 0, ooby or 0
    if oobx ~= 0 or ooby ~= 0 then
        oobx, ooby = norm(oobx, ooby)
        local bodyradius = self.bodyradius or 1
        Characters.spawn(
            {
                type = "spark-bighit",
                x = self.x + oobx*bodyradius,
                y = self.y + ooby*bodyradius,
                z = self.z + self.bodyheight/2
            }
        )
    end
    self.health = self.health - (self.wallslamdamage or 25)
    self.velx, self.vely, self.velz = 0, 0, 0
    self:stopAttack()
    yield() -- a window to be juggled by damaging wall e.g. forge-fire
    self.hurtstun = self.wallslamstun or 20
    yield()
    self:indicateDefeated()
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
        oobx, ooby, oobz = self.penex, self.peney, self.penez
        self:accelerateTowardsVelXY(0, 0)
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
        self:accelerateTowardsVelXY(0, 0)
        t = t + 1
    until t > 15

    self.velx, self.vely = 0, 0
    return self.aiafterbreakaway or self.recoverai
end

function Fighter:duringFall()
end

function Fighter:fall()
    self:stopAttack()
    Body.accelerateTowardsVelXY(self, 0, 0, self.mass or 8)
    local penez = self.penez
    if penez then
        self.velz = 0
        return self.state.nextstate or "collapse"
    end
end

function Fighter:defeat(attacker)
    self:stopAttack()
    self.velx, self.vely = 0, 0
    self:dropDefeatItem()
    Audio.play(self.defeatsound)
    yield()
    return "blinkOut", 60
end

function Fighter:duringDodge()
end

function Fighter:shakeOffColor()
    local color = self.color
    if color ~= Color.White then
        self.color = Color.White
        for i = 1, 8 do
            local offsetangle = love.math.random()*2*math.pi
            local offsetdist = love.math.random()*self.bodyradius
            local offsetx = offsetdist*math.cos(offsetangle)
            local offsety = offsetdist*math.sin(offsetangle)
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
end

return Fighter
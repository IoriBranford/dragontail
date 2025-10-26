local Body = require "Dragontail.Character.Component.Body"
local drawCake = require "drawCake"
local Guard    = require "Dragontail.Character.Action.Guard"
local StateMachine = require "Dragontail.Character.Component.StateMachine"
local tablepool    = require "tablepool"
local AttackHit    = require "Dragontail.Character.Event.AttackHit"
local Color        = require "Tiled.Color"
local Movement     = require "Component.Movement"

---@class Attacker:Body
---@field defaultattack string?
---@field attacktype string?
---@field attack Attack?
---@field attackangle number?
---@field hitstun number
---@field thrower Character
---@field numopponentshit integer?
---@field opponents Character[]
---@field opponentsbypriority Character[]?
---@field crosshairs Character[]?
---@field onAttackHit fun(self:Attacker, target:AttackTarget)?
local Attacker = {}

function Attacker:init()
    local attackdegrees = self.attackdegrees
    if attackdegrees then
        self.attackangle = math.rad(attackdegrees)
    end
end

function Attacker:initCrosshairs(crosshairtype, numcrosshairs)
    local Characters   = require "Dragontail.Stage.Characters"
    if not self.crosshairs then
        local crosshairs = {}
        self.crosshairs = crosshairs
        for i = 1, numcrosshairs do
            crosshairs[i] = Characters.spawn({
                type = crosshairtype,
                visible = false
            })
        end
    end
end

function Attacker:updateCrosshairTargetObject(i, target)
    if target then
        Attacker.updateCrosshairTargetPosition(self, i,
            target.x, target.y, target.z + target.bodyheight/2)
    else
        Attacker.updateCrosshairTargetPosition(self, i)
    end
end

function Attacker:updateCrosshairTargetPosition(i, x, y, z)
    local crosshair = self.crosshairs and self.crosshairs[i]
    if not crosshair then return end

    if crosshair.visible then
        if x and y and z then
            local delta = 1/8
            local dist = math.dist3(x, y, z, crosshair.x, crosshair.y, crosshair.z)
            local speed = math.max(1, (1 - delta) * dist)
            local velx, vely, velz = Movement.getVelocity3_speed(
                crosshair.x, crosshair.y, crosshair.z,
                x, y, z, speed
            )
            crosshair.velx = velx
            crosshair.vely = vely
            crosshair.velz = velz
            crosshair.scalex = math.max(1, crosshair.scalex - delta)
            crosshair.scaley = math.max(1, crosshair.scaley - delta)
            local _,_,_, a = Color.parseARGBInt(crosshair.color)
            a = math.min(1, a + delta)
            crosshair.color = Color.asARGBInt(1,1,1,a)
        else
            crosshair.visible = false
        end
    elseif x and y and z then
        crosshair.x = x
        crosshair.y = y
        crosshair.z = z
        crosshair.visible = true
        crosshair.scalex = 2
        crosshair.scaley = 2
        crosshair.color = Color.asARGBInt(1,1,1,0)
    end
end

function Attacker:debugPrintCrosshair(i)
    local crosshairs = self.crosshairs
    print("crosshairs", crosshairs)
    if not crosshairs then return end

    local crosshair = crosshairs[i]
    print("crosshair", i, crosshair)
    if not crosshair then return end

    print("aseprite", crosshair.aseprite)
    print("visible", crosshair.visible)
    print("pos", crosshair.x, crosshair.y, crosshair.z)
    print("vel", crosshair.velx, crosshair.vely, crosshair.velz)
    print("color", Color.unpack(crosshair.color))
end

function Attacker:isAttacking()
    return self.attackangle
end

function Attacker:startAttack(attackangle)
    self.attackangle = attackangle
end

function Attacker:stopAttack()
    self.attackangle = nil
    local opponents = self.opponents
    if opponents then
        for i = 1, #opponents do
            local opponent = opponents[i]
            if opponent.attacker == self then
                opponent.attacker = nil
            end
        end
    end
end

function Attacker:rotateAttack(dangle)
    dangle = math.fmod(dangle + 3*math.pi, 2*math.pi) - math.pi
    self.attackangle = self.attackangle + dangle
end

function Attacker:rotateAttackTowards(targetangle, turnspeed)
    local dangle = math.fmod(targetangle - self.attackangle + 3*math.pi, 2*math.pi) - math.pi
    dangle = math.max(-turnspeed, math.min(turnspeed, dangle))
    self.attackangle = self.attackangle + dangle
end

function Attacker:checkAttackCollision_pieslice(target)
    if target == self or target == self.thrower or target.thrower == self then
        return
    end
    local attackangle = self.attackangle
    if not attackangle then
        return
    end
    if target.z + target.bodyheight < self.z
    or target.z > self.z + self.bodyheight then
        return
    end
    local fromattackerx, fromattackery = target.x - self.x, target.y - self.y
    local distsq = math.lensq(fromattackerx, fromattackery)
    local bodyradius = target.bodyradius
    if distsq <= bodyradius * bodyradius then
        return true
    end
    local radii = bodyradius + (self.attack.radius or 0)
    local radiisq = radii * radii
    if distsq <= radiisq then
        local attackarc = self.attack.arc or 0
        if attackarc >= math.pi then
            return true
        end
        local dist = math.sqrt(distsq)
        local attackx, attacky = math.cos(attackangle), math.sin(attackangle)
        local dotDA = math.dot(fromattackerx, fromattackery, attackx, attacky)
        local bodyarc = math.asin(bodyradius/dist)
        return dotDA >= dist * math.cos(bodyarc + attackarc)
    end
end

function Attacker:debugPrint_checkAttackCollision(target)
    print("hurtstun", target.hurtstun)
    print("canbeattacked", target.canbeattacked)
    print("attacker.attack.canjuggle", self.attack.canjuggle)
    print("canbejuggled", target.canbejuggled)
    print("self == target", self == target)
    print("self.thrower == target", self.thrower == target)
    print("target.thrower == self", target.thrower == self)
    print("attackangle", self.attackangle)
    print("hitslayers", string.format("%08x", self.attack.hitslayers or 0xFFFFFFFF))
    print("bodyinlayers", string.format("%08x", target.bodyinlayers or 0))
    print("bodyinhitlayers", string.format("%08x", bit.band(self.attack.hitslayers or 0xFFFFFFFF, target.bodyinlayers)))

    ---TODO Body.debugPrint_getCylinderPenetration
    -- local penex, peney, penez = Attacker.checkAttackCollision(self, target)
    -- if not (penex or peney or penez) then
    --     local x, y, z, r, h = Attacker.getAttackCylinder(self)
    --     Body.debugPrint_getCylinderPenetration(target, x, y, z, r, h)
    -- end
end

function Attacker:getAttackCylinder(attack, attackangle)
    attack = attack or self.attack
    attackangle = attackangle or self.attackangle
    if not attack or not attackangle then return end

    local zoffset = attack.z or 0
    local z = self.z + zoffset
    local h = attack.height or (self.bodyheight - zoffset)
    local l = attack.radius or 0
    local r = l * math.sin(attack.arc or 0)
    local d = l - r
    local x = self.x + math.cos(attackangle)*d
    local y = self.y + math.sin(attackangle)*d
    return x, y, z, r, h
end

function Attacker:checkAttackCollision_cylinder(target, attack, attackangle)
    local ax, ay, az, ar, ah = Attacker.getAttackCylinder(self, attack, attackangle)
    if ax then
        return Body.getCylinderPenetration(target, ax, ay, az, ar, ah)
    end
end

function Attacker:checkAttackCollision(target, attack, attackangle)
    attack = attack or self.attack
    if not attack then return end

    if target.hurtstun > 0 then
        return
    end
    if not target.canbeattacked then
        if not self.attack.canjuggle or not target.canbejuggled then
            return
        end
    end
    if target == self or target == self.thrower or target.thrower == self then
        return
    end
    if 0 == bit.band(attack.hitslayers or 0xFFFFFFFF, target.bodyinlayers) then
        return
    end
    return Attacker.checkAttackCollision_cylinder(self, target, attack, attackangle)
end

---@param target AttackTarget
---@return AttackHit?
function Attacker:getAttackHit(target, attack, attackangle)
    local penex, peney, penez = Attacker.checkAttackCollision(self, target, attack, attackangle)
    if penex or peney or penez then
        -- print(self.type..self.id, self.attacktype, target.type..target.id)
        return AttackHit(self, target, penex, peney, penez)
    end
end

---@param hit AttackHit
function Attacker:onAttackHit(hit)
    self.numopponentshit = (self.numopponentshit or 0) + 1
    local maxselfstuns = hit.attack.maxselfstuns or math.huge
    if self.hitstun <= 0 and self.numopponentshit <= maxselfstuns then
        self.hitstun = hit.attack.selfstun or 3
    end

    local nextstate =
        hit.guarded and hit.attack.selfstateonguard
        or hit.attack.selfstateonhitopponent
        or hit.attack.selfstateonhit

    if nextstate then
        StateMachine.start(self, nextstate, hit.target)
    end
end

local function comparePriorities(a, b)
    return a.targetingscore < b.targetingscore
end

function Attacker:updateOpponentsByPriority(getPriority)
    local opponentsbypriority = self.opponentsbypriority
    if opponentsbypriority then
        for i = #opponentsbypriority, 1, -1 do
            opponentsbypriority[i] = nil
        end
    else
        opponentsbypriority = {}
        self.opponentsbypriority = opponentsbypriority
    end

    local opponents = self.opponents
    for i = 1, #opponents do
        local opponent = opponents[i]
        local priority = getPriority(opponent)
        opponent.targetingscore = priority
        if priority then
            opponentsbypriority[#opponentsbypriority+1] = opponent
        end
    end

    table.sort(opponentsbypriority, comparePriorities)
    return opponentsbypriority
end

function Attacker:drawPieslice(fixedfrac)
    local attackangle = self.attackangle
    local attackradius = self.attack.radius or 0
    if attackradius <= 0 or not attackangle then
        return
    end

    fixedfrac = fixedfrac or 0
    local x, y = self.x + self.velx * fixedfrac, self.y + self.vely * fixedfrac
    local bodyheight = self.bodyheight
    local screeny = y - self.z
    local attackarc = self.attack.arc or 0
    love.graphics.setColor(1, .5, .5)
    if attackarc > 0 then
        drawCake(x, y, attackradius, bodyheight, attackangle, attackarc)
    else
        local c, s = attackradius*math.cos(attackangle), attackradius*math.sin(attackangle)
        love.graphics.line(x, screeny,
            x + c, screeny + s,
            x + c, screeny + s - bodyheight,
            x, screeny - bodyheight)
    end
end

function Attacker:drawCircle(fixedfrac)
    local x, y, z, r, h = Attacker.getAttackCylinder(self)
    if x and y and z and r and h then
        fixedfrac = fixedfrac or 0
        x = x + self.velx*fixedfrac
        y = y + self.vely*fixedfrac
        z = z + self.velz*fixedfrac
        love.graphics.setColor(0, 0, 0)
        love.graphics.circle("line", x, y, r)
        love.graphics.setColor(1, .5, .5)
        drawCake(x, y - z, r, h, 0, math.pi)
    end
end

return Attacker
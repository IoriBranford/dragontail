local Body = require "Dragontail.Character.Component.Body"
local drawCake = require "drawCake"
local Guard    = require "Dragontail.Character.Action.Guard"
local StateMachine = require "Dragontail.Character.Component.StateMachine"
---@class Attacker:Body
---@field defaultattack string?
---@field attacktype string?
---@field attack Attack?
---@field attackangle number?
---@field hitstun number
---@field thrower Character
---@field numopponentshit integer?
---@field onAttackHit fun(self:Attacker, target:Victim)?
local Attacker = {}

---@class Victim
---@field health number
---@field maxhealth number
---@field canbeattacked boolean
---@field canbejuggled boolean
---@field canbedamagedbyattack string?
---@field hurtstun number
---@field hurtangle number?
---@field attacker Character
---@field hurtai string?
---@field recoverai string?
---@field aiafterhurt string?
---@field hurtsound string?
---@field onHitByAttack fun(self:Victim, target:Attacker)?

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

function Attacker:getAttackCylinder()
    local attack = self.attack
    if not attack then return end
    local attackangle = self.attackangle
    if not attackangle then return end

    local z = self.z
    local h = self.bodyheight
    local l = attack.radius or 0
    local r = l * math.sin(attack.arc or 0)
    local d = l - r
    local x = self.x + math.cos(attackangle)*d
    local y = self.y + math.sin(attackangle)*d
    return x, y, z, r, h
end

function Attacker:checkAttackCollision_cylinder(target)
    local ax, ay, az, ar, ah = Attacker.getAttackCylinder(self)
    if ax then
        return Body.getCylinderPenetration(target, ax, ay, az, ar, ah)
    end
end

function Attacker:checkAttackCollision(target)
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
    if 0 == bit.band(self.attack.hitslayers or 0xFFFFFFFF, target.bodyinlayers) then
        return
    end
    return Attacker.checkAttackCollision_cylinder(self, target)
end

---@param target Victim
---@return Hit?
function Attacker:getAttackHit(target)
    local penex, peney, penez = Attacker.checkAttackCollision(self, target)
    if penex or peney or penez then
        -- print(self.type..self.id, self.attacktype, target.type..target.id)
        local x, y, z, r, h = Attacker.getAttackCylinder(self)
        return {
            angle = self.attackangle,
            attack = self.attack,
            target = target,
            attacker = self,
            penex = penex,
            peney = peney,
            penez = penez,
            attackx = x,
            attacky = y,
            attackz = z,
            attackr = r,
            attackh = h,
            guarded = Guard.isAttackInGuardArc(target, self)
        }
    end
end

---@param hit Hit
function Attacker:onAttackHit(hit)
    self.numopponentshit = (self.numopponentshit or 0) + 1
    if self.hitstun <= 0 and self.numopponentshit <= 1 then
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
    local attackangle = self.attackangle
    local attackradius = self.attack.radius or 0
    if attackradius <= 0 or not attackangle then
        return
    end

    fixedfrac = fixedfrac or 0
    local attackarc = self.attack.arc or 0
    local attackr = math.max(1, attackradius * math.sin(attackarc))
    local x = self.x + self.velx*fixedfrac + math.cos(attackangle)*(attackradius - attackr)
    local y = self.y + self.vely*fixedfrac + math.sin(attackangle)*(attackradius - attackr)
    local z = self.z + self.velz*fixedfrac
    local bodyheight = self.bodyheight
    local screeny = y - z
    local attackheight = bodyheight
    love.graphics.setColor(1, .5, .5)
    love.graphics.circle("line", x, screeny, attackr)
    love.graphics.circle("line", x, screeny - attackheight, attackr)
    love.graphics.line(x - attackr, screeny, x - attackr, screeny - attackheight)
    love.graphics.line(x + attackr, screeny, x + attackr, screeny - attackheight)
end

return Attacker
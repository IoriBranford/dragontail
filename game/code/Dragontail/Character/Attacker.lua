local Body = require "Dragontail.Character.Body"
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

function Attacker:debugPrint_checkAttackCollision_circle(target)
    print("self == target", self == target)
    print("self.thrower == target", self.thrower == target)
    print("target.thrower == self", target.thrower == self)
    print("attackangle", self.attackangle)
end

function Attacker:checkAttackCollision_circle(target)
    if target == self or target == self.thrower or target.thrower == self then
        return
    end
    local attackangle = self.attackangle
    if not attackangle then
        return
    end
    local attackz = self.z
    local attackheight = self.bodyheight
    local attacklen = self.attack.radius or 0
    local attackr = attacklen * math.sin(self.attack.arc or 0)
    local attackx = self.x + math.cos(attackangle)*(attacklen - attackr)
    local attacky = self.y + math.sin(attackangle)*(attacklen - attackr)
    local penex, peney, penez = Body.getCylinderPenetration(target, attackx, attacky, attackz, attackr, attackheight)
    return penex or peney or penez
end

Attacker.checkAttackCollision = Attacker.checkAttackCollision_circle

function Attacker:collideWithCharacterAttack(target)
    if target.hurtstun > 0 then
        return
    end
    if not target.canbeattacked then
        if not self.attack.canjuggle or not target.canbejuggled then
            return
        end
    end
    if Attacker.checkAttackCollision(self, target) then
        -- TODO record collision
        return true
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
        love.graphics.arc("line", x, screeny, attackradius, attackangle - attackarc, attackangle + attackarc)
        love.graphics.arc("line", x, screeny - bodyheight, attackradius, attackangle - attackarc, attackangle + attackarc)
        local c1, s1 = attackradius*math.cos(attackangle-attackarc), attackradius*math.sin(attackangle-attackarc)
        local c2, s2 = attackradius*math.cos(attackangle+attackarc), attackradius*math.sin(attackangle+attackarc)
        love.graphics.line(x + c1, screeny + s1, x + c1, screeny + s1 - bodyheight)
        love.graphics.line(x + c2, screeny + s2, x + c2, screeny + s2 - bodyheight)
        local c = math.cos(attackangle)
        local d = math.cos(attackarc)
        if c > d then
            love.graphics.line(x + attackradius, screeny, x + attackradius, screeny - bodyheight)
        elseif c < -d then
            love.graphics.line(x - attackradius, screeny, x - attackradius, screeny - bodyheight)
        end
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
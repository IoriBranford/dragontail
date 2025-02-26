local Body = require "Dragontail.Character.Body"
---@class Attack:Body
---@field defaultattack string?
---@field attacktype string?
---@field attackdata AttackData?
---@field attackangle number?
---@field hitstun number
---@field thrower Character
---@field numopponentshit integer?
---@field attackhitai string?
---@field attackhitopponentai string?
---@field attackhitboundaryai string?
---@field attackguardedai string?
---@field onAttackHit fun(self:Attack, target:Hurt)?
local Attack = {}

---@class Hurt
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
---@field onHitByAttack fun(self:Hurt, target:Attack)?

function Attack:isAttacking()
    return self.attackangle
end

function Attack:startAttack(attackangle)
    self.attackangle = attackangle
end

function Attack:stopAttack()
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

function Attack:rotateAttack(dangle)
    dangle = math.fmod(dangle + 3*math.pi, 2*math.pi) - math.pi
    self.attackangle = self.attackangle + dangle
end

function Attack:rotateAttackTowards(targetangle, turnspeed)
    local dangle = math.fmod(targetangle - self.attackangle + 3*math.pi, 2*math.pi) - math.pi
    dangle = math.max(-turnspeed, math.min(turnspeed, dangle))
    self.attackangle = self.attackangle + dangle
end

function Attack:checkAttackCollision_pieslice(target)
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
    local radii = bodyradius + self.attackradius
    local radiisq = radii * radii
    if distsq <= radiisq then
        local attackarc = self.attackarc
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

function Attack:checkAttackCollision_circle(target)
    if target == self or target == self.thrower or target.thrower == self then
        return
    end
    local attackangle = self.attackangle
    if not attackangle then
        return
    end
    local attackz = self.z
    local attackheight = self.bodyheight
    local attacklen = self.attackradius
    local attackr = attacklen * math.sin(self.attackarc or 0)
    local attackx = self.x + math.cos(attackangle)*(attacklen - attackr)
    local attacky = self.y + math.sin(attackangle)*(attacklen - attackr)
    local penex, peney, penez = Body.getCylinderPenetration(target, attackx, attacky, attackz, attackr, attackheight)
    return penex or peney or penez
end

Attack.checkAttackCollision = Attack.checkAttackCollision_circle

function Attack:collideWithCharacterAttack(target)
    if target.hurtstun > 0 then
        return
    end
    if not target.canbeattacked then
        if not self.attackcanjuggle or not target.canbejuggled then
            return
        end
    end
    if Attack.checkAttackCollision(self, target) then
        -- TODO record collision
        return true
    end
end

function Attack:drawPieslice(fixedfrac)
    local attackangle = self.attackangle
    local attackradius = self.attackradius
    if attackradius <= 0 or not attackangle then
        return
    end

    fixedfrac = fixedfrac or 0
    local x, y = self.x + self.velx * fixedfrac, self.y + self.vely * fixedfrac
    local bodyheight = self.bodyheight
    local screeny = y - self.z
    local attackarc = self.attackarc
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

function Attack:drawCircle(fixedfrac)
    local attackangle = self.attackangle
    local attackradius = self.attackradius
    if attackradius <= 0 or not attackangle then
        return
    end

    fixedfrac = fixedfrac or 0
    local attackarc = self.attackarc
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

return Attack
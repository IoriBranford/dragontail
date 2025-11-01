local drawCake = require "drawCake"

---@class Guard:Body
---@field guardai string|"guardHit"
---@field guardangle number?
---@field guardarc number
local Guard = {}

function Guard:startGuarding(guardangle)
    self.guardangle = guardangle
end

function Guard:stopGuarding()
    self.guardangle = nil
end

function Guard:isGuarding()
    return self.guardangle ~= nil
end

---@param hit AttackHit
---@return boolean
function Guard:isHitGuarded(hit)
    return Guard.isAngleAgainstGuardArc(self, hit.angle)
        or Guard.isPointInGuardArc(self, hit.attackx, hit.attacky)
end

function Guard:isAttackAgainstGuardArc(attacker)
    local attackangle = attacker.attackangle
    return attackangle and Guard.isAngleAgainstGuardArc(self, attackangle)
end

function Guard:isUnitVectorAgainstGuardArc(ux, uy)
    local guardangle = self.guardangle
    if not guardangle then return false end
    local guardarc = self.guardarc or (math.pi/2)
    local gx, gy = math.cos(guardangle), math.sin(guardangle)
    return math.dot(ux, uy, gx, gy) <= -math.cos(guardarc)
end

function Guard:isAngleAgainstGuardArc(angle)
    return Guard.isUnitVectorAgainstGuardArc(self, math.cos(angle), math.sin(angle))
end

function Guard:isPointInGuardArc(x, y)
    local dx, dy = self.x - x, self.y - y
    if dx == 0 and dy == 0 then return true end
    dx, dy = math.norm(dx, dy)
    return Guard.isUnitVectorAgainstGuardArc(self, dx, dy)
end

function Guard:pushBackAttacker(attacker)
    local toattackerx = -self.x + attacker.x
    local toattackery = -self.y + attacker.y
    local toattackerdist = math.len(toattackerx, toattackery)
    if toattackerdist == 0 then
        toattackerx = math.cos(self.guardangle)
        toattackery = math.sin(self.guardangle)
    else
        toattackerx = toattackerx / toattackerdist
        toattackery = toattackery / toattackerdist
    end
    local pushbackspeed = math.len(attacker.velx, attacker.vely)*1.5
    attacker.velx = attacker.velx + pushbackspeed * toattackerx
    attacker.vely = attacker.vely + pushbackspeed * toattackery
end

function Guard:standardImpact(hit)
    local attacker, attack = hit.attacker, hit.attack
    self:makeImpactSpark(attacker, attack.guardhitspark)
    self.hurtstun = attack.opponentguardstun
        or attack.opponentstun or 6
    Guard.pushBackAttacker(self, attacker)
end

function Guard:draw(fixedfrac)
    local angle = self.guardangle
    if not angle then return end

    local arc = self.guardarc or (math.pi/2)

    fixedfrac = fixedfrac or 0
    local x = self.x + self.velx * fixedfrac
    local y = self.y + self.vely * fixedfrac
        - (self.z + self.velz*fixedfrac)
    local r = self.bodyradius
    local h = self.bodyheight
    love.graphics.setColor(.5, 1, 1)
    drawCake(x, y, r, h, angle, arc)
end

return Guard
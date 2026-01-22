local drawCake = require "drawCake"

---@class Guard:Body
---@field guardai string|"guardHit"
---@field guardangle number?
---@field guardarc number
---@field guardradius number?
---@field guardcounterstate string?
---@field numguardedhitsuntilcounter integer?
---@field numguardedhitsuntilwarning integer?
---@field numguardedhits integer?
local Guard = {}

local DefaultGuardArc = math.pi/2

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
    if hit.attacker.unguardable then return false end
    return Guard.isPointInGuardArc(self, hit.attacker.x, hit.attacker.y)
end

function Guard:isAttackAgainstGuardArc(attacker)
    local attackangle = attacker.attackangle
    return attackangle and Guard.isAngleAgainstGuardArc(self, attackangle)
end

function Guard:isUnitVectorAgainstGuardArc(ux, uy)
    local guardangle = self.guardangle
    if not guardangle then return false end
    local guardarc = self.guardarc or DefaultGuardArc
    local gx, gy = math.cos(guardangle), math.sin(guardangle)
    return math.dot(ux, uy, gx, gy) <= -math.cos(guardarc)
end

function Guard:isAngleAgainstGuardArc(angle)
    return Guard.isUnitVectorAgainstGuardArc(self, math.cos(angle), math.sin(angle))
end

function Guard:isPointInGuardArc(x, y)
    local dx, dy = self.x - x, self.y - y
    if dx == 0 and dy == 0 then return false end
    dx, dy = math.norm(dx, dy)
    return Guard.isUnitVectorAgainstGuardArc(self, dx, dy)
end

function Guard:pushBackAttacker(attacker)
    local toattackerx = -self.x + attacker.x
    local toattackery = -self.y + attacker.y
    local toattackerdist = math.len(toattackerx, toattackery)
    if toattackerdist == 0 then
        local guardangle = self.guardangle
            or self.faceangle or 0
        toattackerx = math.cos(guardangle)
        toattackery = math.sin(guardangle)
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

function Guard:draw(sidey, fixedfrac)
    local angle = self.guardangle
    if not angle then return end

    local arc = self.guardarc or DefaultGuardArc
    local a1, a2 = angle - arc, angle + arc
    local y1 = math.sin(a1)
    local y2 = math.sin(a2)
    if sidey < 0 then
        if y1 >= 0 and y2 >= 0 then return end
        if y1 >= 0 then a1 = a1 + math.asin(y1) end
        if y2 >= 0 then a2 = a2 - math.asin(y2) end
    else
        if y1 < 0 and y2 < 0 then return end
        if y1 < 0 then a1 = a1 - math.asin(y1) end
        if y2 < 0 then a2 = a2 + math.asin(y2) end
    end

    fixedfrac = fixedfrac or 0
    local x = self.x + self.velx * fixedfrac
    local y = self.y + self.vely * fixedfrac
        - (self.z + self.velz*fixedfrac)
    local r = self.guardradius or self.bodyradius
    local h = self.bodyheight
    local t = love.timer.getTime()*60
    local dt = math.pi/30
    for _ = 1, h do
        local alpha = (1 + math.cos(t))/2
        love.graphics.setColor(.5, 1, 1, alpha)
        love.graphics.arc("line", "open", x, y, r, a1, a2)
        t = t - dt
        y = y - 1
    end
end

return Guard
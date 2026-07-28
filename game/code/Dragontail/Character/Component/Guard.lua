local Color    = require "Tiled.Color"

---@class Guard:Body
---@field guardai string|"guardHit"
---@field guardangle number?
---@field guardtwoway boolean
---@field guardarc number
---@field guardradius number?
---@field guardcounterstate string?
---@field guardreflectsprojectile boolean
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
function Guard:getGuardedAngle(hit)
    if hit.attacker.unguardable then return end
    return Guard.getGuardedAngleVsPoint(self, hit.attacker.x, hit.attacker.y)
end

function Guard:getGuardedAngleVsAttacker(attacker)
    local attackangle = attacker.attackangle
    return attackangle and Guard.getGuardedAngleVsAngle(self, attackangle)
end

function Guard:getGuardedAngleVsUnitVector(ux, uy)
    local guardangle = self.guardangle
    if not guardangle then return end
    local guardarc = self.guardarc or DefaultGuardArc
    local gx, gy = math2.frompolar(guardangle)
    local cosarc = math.cos(guardarc)
    if math.dot(ux, uy, gx, gy) <= -cosarc then
        return guardangle
    end
    if self.guardtwoway then
        if math.dot(ux, uy, -gx, -gy) <= -cosarc then
            return guardangle+math.pi
        end
    end
end

function Guard:getGuardedAngleVsAngle(angle)
    return Guard.getGuardedAngleVsUnitVector(self, math.cos(angle), math.sin(angle))
end

function Guard:getGuardedAngleVsPoint(x, y)
    local dx, dy = self.x - x, self.y - y
    if dx == 0 and dy == 0 then return end
    dx, dy = math.norm(dx, dy)
    return Guard.getGuardedAngleVsUnitVector(self, dx, dy)
end

---@param atkr Attacker
function Guard:pushBackAttacker(atkr)
    local d, dx, dy = math2.dist(self.x, self.y, atkr.x, atkr.y)
    if d == 0 then
        local a = self.guardangle
            or self.faceangle or 0
        dx, dy = math2.frompolar(a)
    else
        dx, dy = math2.vdiv(dx, dy, d)
    end

    local atk = atkr.attack
    local as = atk and atk.launchspeed or 6
    local afx, afy = math2.vmul(dx, dy, as)

    local vx, vy = self.velx, self.vely
    local s = atk and atk.guardpushback or (as/4)
    local fx, fy = math2.vmul(dx, dy, -s)
    vx, vy = math2.vadd(vx, vy, fx, fy)
    self.velx, self.vely = vx, vy

    local avx, avy = atkr.velx, atkr.vely
    if math2.dot(avx, avy, afx, afy) < 0 then
        avx, avy = math2.vadd(avx, avy, afx, afy)
    end
    atkr.velx, atkr.vely = avx, avy
end

function Guard:standardImpact(hit)
    local attacker, attack = hit.attacker, hit.attack
    self:makeImpactSpark(attacker, attack.guardhitspark)
    self.hurtstun = attack.opponentguardstun
        or attack.opponentstun or 6
    Guard.pushBackAttacker(self, attacker)
end

function Guard:drawArc(sidey, fixedfrac, angle)
    local guardr, guardg, guardb, guardalpha = Color.unpack(self.guardcolor or 0xFF80FFFF)
    if guardalpha <= 0 then
        return
    end

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
    local br = self.bodyradius
    local gr = self.guardradius or br
    if gr > br then
        local offset = gr-br
        x = x + math.cos(angle)*offset
        y = y + math.sin(angle)*offset
    end
    local h = self.bodyheight
    local t = love.timer.getTime()*60
    local dt = math.pi/30
    for _ = 1, h do
        local alpha = guardalpha * (1 + math.cos(t))/2
        love.graphics.setColor(guardr, guardg, guardb, alpha)
        love.graphics.arc("line", "open", x, y, br, a1, a2)
        t = t - dt
        y = y - 1
    end
end

function Guard:draw(sidey, fixedfrac)
    local angle = self.guardangle
    if not angle then return end
    Guard.drawArc(self, sidey, fixedfrac, angle)
    if self.guardtwoway then
        Guard.drawArc(self, sidey, fixedfrac, angle + math.pi)
    end
end

return Guard
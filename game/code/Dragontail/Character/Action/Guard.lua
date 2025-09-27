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

function Guard:isAttackInGuardArc(attacker)
    local Attacker = require "Dragontail.Character.Component.Attacker"
    local ax, ay = Attacker.getAttackCylinder(attacker)
    return ax and ay and Guard.isPointInGuardArc(self, ax, ay) or false
end

function Guard:isPointInGuardArc(x, y)
    local guardangle = self.guardangle
    if not guardangle then return false end
    local dx, dy = x - self.x, y - self.y
    local gx, gy = math.cos(guardangle), math.sin(guardangle)
    local d = math.len(dx, dy)
    local DdotG = math.dot(dx, dy, gx, gy)
    return DdotG >= d*math.cos(self.guardarc or (math.pi/2))
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
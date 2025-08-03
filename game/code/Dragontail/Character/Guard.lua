local Attacker = require "Dragontail.Character.Attacker"
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

function Guard:isAttackInGuardArc(attacker)
    local ax, ay = Attacker.getAttackCylinder(attacker)
    if ax and ay then
        return Guard.isPointInGuardArc(self, ax, ay)
    end
end

function Guard:isPointInGuardArc(x, y)
    local guardangle = self.guardangle
    if not guardangle then return end
    local dx, dy = x - self.x, y - self.y
    local gx, gy = math.cos(guardangle), math.sin(guardangle)
    local d = math.len(dx, dy)
    local DdotG = math.dot(dx, dy, gx, gy)
    return DdotG >= d*math.cos(self.guardarc or (math.pi/2))
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
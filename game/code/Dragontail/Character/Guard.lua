local Attacker = require "Dragontail.Character.Attacker"

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
    local guardangle = self.guardangle
    if not guardangle then return end
    local ax, ay = Attacker.getAttackCylinder(attacker)
    if ax and ay then
        local adx, ady = ax - self.x, ay - self.y
        local gdx, gdy = math.cos(guardangle), math.sin(guardangle)
        local ad = math.len(adx, ady)
        local adotg = math.dot(adx, ady, gdx, gdy)
        return adotg >= ad*math.cos(self.guardarc or (math.pi/2))
    end
end

return Guard
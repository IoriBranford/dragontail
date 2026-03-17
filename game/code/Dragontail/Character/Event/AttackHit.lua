local Guard     = require "Dragontail.Character.Component.Guard"

---@class AttackHit:PooledClass
---@field attacker Attacker
---@field attack Attack
---@field target AttackTarget
---@field angle number
---@field attackx number
---@field attacky number
---@field attackz number
---@field attackr number
---@field attackh number
---@field penex number?
---@field peney number?
---@field penez number?
---@field guarded boolean
---@field guardangle number?
local AttackHit = pooledclass()
AttackHit._nrec = 14

function AttackHit:_init(attacker, target, attack, attackangle, penex, peney, penez)
    local Attacker  = require "Dragontail.Character.Component.Attacker"
    local x, y, z, r, h = Attacker.getAttackCylinder(attacker)
    self.angle = attackangle
    self.attack = attack
    self.target = target
    self.attacker = attacker
    self.penex = penex
    self.peney = peney
    self.penez = penez
    self.attackx = x or attacker.x
    self.attacky = y or attacker.y
    self.attackz = z or attacker.z
    self.attackr = r or attack.radius
    self.attackh = h or attacker.bodyheight
    self.guarded = Guard.isHitGuarded(target, self)
    self.guardangle = target.guardangle
    return self
end

return AttackHit
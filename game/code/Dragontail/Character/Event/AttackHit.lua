local Guard     = require "Dragontail.Character.Action.Guard"

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
local AttackHit = pooledclass()
AttackHit._nrec = 13

function AttackHit:_init(attacker, target, penex, peney, penez)
    local Attacker  = require "Dragontail.Character.Component.Attacker"
    local x, y, z, r, h = Attacker.getAttackCylinder(attacker)
    self.angle = attacker.attackangle
    self.attack = attacker.attack
    self.target = target
    self.attacker = attacker
    self.penex = penex
    self.peney = peney
    self.penez = penez
    self.attackx = x or attacker.x
    self.attacky = y or attacker.y
    self.attackz = z or attacker.z
    self.attackr = r or attacker.attack.radius
    self.attackh = h or attacker.bodyheight
    self.guarded = Guard.isAttackAgainstGuardArc(target, attacker)
    return self
end

return AttackHit
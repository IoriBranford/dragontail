local tablepool = require "tablepool"
local Guard     = require "Dragontail.Character.Action.Guard"

---@class AttackHit
---@field attacker Attacker
---@field attack Attack
---@field target Victim
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

return function(attacker, target, penex, peney, penez)
    local Attacker  = require "Dragontail.Character.Component.Attacker"
    local x, y, z, r, h = Attacker.getAttackCylinder(attacker)
    local hit = tablepool.fetch("AttackHit", 0, 16)
    hit.angle = attacker.attackangle
    hit.attack = attacker.attack
    hit.target = target
    hit.attacker = attacker
    hit.penex = penex
    hit.peney = peney
    hit.penez = penez
    hit.attackx = x
    hit.attacky = y
    hit.attackz = z
    hit.attackr = r
    hit.attackh = h
    hit.guarded = Guard.isAttackInGuardArc(target, attacker)
    return hit
end
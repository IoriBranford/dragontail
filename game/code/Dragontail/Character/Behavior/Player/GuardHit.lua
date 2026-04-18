local Guard    = require "Dragontail.Character.Component.Guard"
local Behavior = require "Dragontail.Character.Behavior"
local Invulnerability = require "Dragontail.Character.Component.Invulnerability"
local Face            = require "Dragontail.Character.Component.Face"

---@class PlayerGuardHit:Behavior
---@field character Enemy
local PlayerGuardHit = pooledclass(Behavior)

---@param hit AttackHit
function PlayerGuardHit:start(hit)
    local player = self.character
    Guard.standardImpact(player, hit)
    local guardangle = assert(hit.guardangle)
    Guard.startGuarding(player, guardangle)
    Face.faceAngle(player, guardangle + math.pi, player.state.animation, player.state.frame1, player.state.loopframe)
end

function PlayerGuardHit:fixedupdate()
    local player = self.character
    player:decelerateXYto0()
end

function PlayerGuardHit:interrupt(...)
    local player = self.character
    Invulnerability.giveInvuln(player, player.guardinvulntime or 120)
    return ...
end

function PlayerGuardHit:timeout(...)
    local player = self.character
    Invulnerability.giveInvuln(player, player.guardinvulntime or 120)
    return ...
end

return PlayerGuardHit
local Behavior = require "Dragontail.Character.Behavior"
local Face     = require "Dragontail.Character.Component.Face"
local StateMachine = require "Dragontail.Character.Component.StateMachine"
local Body         = require "Dragontail.Character.Component.Body"

local CatchingProjectile = pooledclass(Behavior)

function CatchingProjectile:start(projectile)
    local player = self.character
    Face.faceObject(player, projectile, player.state.animation or "catch")
    projectile:stopAttack()
    if player:tryToGiveWeapon(projectile.type) then
        projectile:disappear()
    else
        StateMachine.start(projectile, "projectileBounce", player)
    end
end

function CatchingProjectile:fixedupdate()
    local player = self.character
    Body.accelerateTowardsVel(player, 0, 0, player.mass or 1)
end

return CatchingProjectile
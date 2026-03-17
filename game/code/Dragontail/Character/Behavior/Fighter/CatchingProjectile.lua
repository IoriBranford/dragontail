local Behavior = require "Dragontail.Character.Behavior"
local Face     = require "Dragontail.Character.Component.Face"
local StateMachine = require "Dragontail.Character.Component.StateMachine"

---@class CatchingProjectile:Behavior
---@field character Fighter
local CatchingProjectile = pooledclass(Behavior)

function CatchingProjectile:start(projectile)
    local fighter = self.character
    Face.faceObject(fighter, projectile, fighter.state.animation or "catch")
    projectile:stopAttack() ; projectile:unassignSelfAsAttacker()
    if fighter:tryToGiveWeapon(projectile.type) then
        projectile:disappear()
    else
        StateMachine.start(projectile, "projectileBounce", fighter)
    end
end

function CatchingProjectile:fixedupdate()
    local fighter = self.character
    fighter:decelerateXYto0()
end

return CatchingProjectile
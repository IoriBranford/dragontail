local Behavior = require "Dragontail.Character.Behavior"
local HoldOpponent = require "Dragontail.Character.Component.HoldOpponent"
local Face         = require "Dragontail.Character.Component.Face"

---@class Grabbing:Behavior
---@field character Fighter
local Grabbing = pooledclass(Behavior)

function Grabbing:start(grabbed)
    local fighter = self.character
    HoldOpponent.startHolding(fighter, grabbed)
end

function Grabbing:fixedupdate()
    local fighter = self.character
    fighter:decelerateXYto0()
    Face.faceObject(fighter, fighter.heldopponent,
        fighter.state.animation, fighter.animationframe, fighter.state.loopframe)
    HoldOpponent.updateVelocities(fighter)
end

return Grabbing
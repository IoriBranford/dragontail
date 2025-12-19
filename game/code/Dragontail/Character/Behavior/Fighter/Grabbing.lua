local Behavior = require "Dragontail.Character.Behavior"
local HoldOpponent = require "Dragontail.Character.Component.HoldOpponent"
local Face         = require "Dragontail.Character.Component.Face"
local Guard        = require "Dragontail.Character.Component.Guard"

---@class Grabbing:Behavior
---@field character Fighter
local Grabbing = pooledclass(Behavior)

function Grabbing:start(grabbed)
    local fighter = self.character
    local dx, dy = grabbed.x - fighter.x, grabbed.y - fighter.y
    local guarded = grabbed:isHigherRankedTeammateOf(fighter)
        or dx ~= 0 and dy ~= 0 and
            Guard.isUnitVectorAgainstGuardArc(grabbed, math.norm(dx, dy))
    HoldOpponent.startHolding(fighter, grabbed)
    if guarded then
        fighter.holdstrength = fighter.statetime or 0
    end
end

function Grabbing:fixedupdate()
    local fighter = self.character
    fighter:decelerateXYto0()
    Face.faceObject(fighter, fighter.heldopponent,
        fighter.state.animation, fighter.animationframe, fighter.state.loopframe)
    HoldOpponent.updateVelocities(fighter)
end

return Grabbing
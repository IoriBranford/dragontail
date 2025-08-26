local Behavior = require "Dragontail.Character.Behavior"
local Raycast  = require "Object.Raycast"
local Characters = require "Dragontail.Stage.Characters"
local CollisionMask = require "Dragontail.Character.Component.Body.CollisionMask"

---@class Intercept:Behavior
---@field character Enemy
local Intercept = pooledclass(Behavior)
Intercept._nrec = Behavior._nrec + 2

function Intercept.HasRoomToIntercept(opponent, leadtime)
    leadtime = leadtime or 15
    local raycast = Raycast(
        opponent.x, opponent.y, opponent.z + opponent.bodyheight/2,
        opponent.velx*leadtime, opponent.vely*leadtime, 0
    )
    raycast.hitslayers = CollisionMask.merge("Object", "Wall", "Camera")
    return Characters.castRay3(raycast, opponent)
end

function Intercept:start(opponent, leadtime)
    self.opponent = opponent
    self.leadtime = leadtime or 15
end

function Intercept:update()
    local enemy = self.character
    local opponent = self.opponent
    local leadtime = self.leadtime
    local oppodestx = opponent.x + opponent.velx*leadtime
    local oppodesty = opponent.y + opponent.vely*leadtime

    if enemy:updateWalkTo(oppodestx, oppodesty) then
        return enemy.nextstate
    end
end

return Intercept
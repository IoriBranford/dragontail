local Behavior = require "Dragontail.Character.Behavior"
local HoldOpponent = require "Dragontail.Character.Component.HoldOpponent"
local Attacker     = require "Dragontail.Character.Component.Attacker"
local StateMachine = require "Dragontail.Character.Component.StateMachine"

---@class GroundSlam:Behavior
---@field character Player
local GroundSlam = pooledclass(Behavior)
GroundSlam._nrec = 1

function GroundSlam:_init(character)
    self.character = character
end

---@param ... any
function GroundSlam:start(...)
    local player = self.character
    local velx, vely = player.velx, player.vely
    local attackangle =
        velx == 0 and vely == 0 and player.faceangle
        or math.atan2(vely, velx)
    Attacker.startAttack(player, attackangle)
    local heldenemy = player.heldopponent
    player.holddist = 0
    player.holdheight = 0
    if heldenemy then
        player.holddist = HoldOpponent.getDefaultHoldDistance(player, heldenemy)
        StateMachine.start(heldenemy, "beforeGroundSlammed")
        player.holdstrength = math.huge
    end
end

---@return string? nextstate
---@return any ...
function GroundSlam:fixedupdate()
    local player = self.character
    local heldenemy = player.heldopponent
    local landed = heldenemy and heldenemy.z <= heldenemy.floorz
        or player.z <= player.floorz

    if landed then
        if heldenemy then
            heldenemy.health = heldenemy.health - (heldenemy.groundslamdamage or 15)
            StateMachine.start(heldenemy, "groundSlammed", player)
        end
        -- local jumpangle = player.faceangle
        -- player.velx = math.cos(jumpangle)*4
        -- player.vely = math.sin(jumpangle)*4
        return "groundSlamLand"
        -- player.hitstun = heldenemy.hurtstun
        -- player.statetime = 1
        -- player.nextstate = "jump"
    end

    player.holddist = math.max(0, player.holddist - 4)
    player.holdheight = math.max(-8, player.holdheight - 2)
    HoldOpponent.updateVelocities(player)
end

---@return string? nextstate
---@return any ...
function GroundSlam:interrupt(nextstate, ...)
    local player = self.character
    Attacker.stopAttack(player)
    player.holddist = nil
    player.holdheight = nil
    return nextstate, ...
end

---@return string? nextstate
---@return any ...
function GroundSlam:timeout(nextstate, ...)
    local player = self.character
    Attacker.stopAttack(player)
    player.holddist = nil
    player.holdheight = nil
    return nextstate, ...
end

---@param fixedfrac number
function GroundSlam:draw(fixedfrac)
end

return GroundSlam
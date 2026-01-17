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
    player.holddist = 0
    player.holdheight = -8
    local velx, vely = player.velx, player.vely
    local attackangle =
        velx == 0 and vely == 0 and player.faceangle
        or math.atan2(vely, velx)
    Attacker.startAttack(player, attackangle)
    local heldenemy = player.heldopponent
    if heldenemy then
        heldenemy:changeAnimation("Down")
        heldenemy.canbeattacked = false
        heldenemy.canbejuggled = false
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
            StateMachine.start(heldenemy, "groundSlammed", player)
        end
        -- local jumpangle = player.faceangle
        -- player.velx = math.cos(jumpangle)*4
        -- player.vely = math.sin(jumpangle)*4
        local jx, jy = player:getJoystick()
        if jx ~= 0 or jy ~= 0 then
            player.velx, player.vely = jx*4, jy*4
        end
        player.velz = 4
        HoldOpponent.stopHolding(player, heldenemy)
        return "jump"
        -- player.hitstun = heldenemy.hurtstun
        -- player.statetime = 1
        -- player.nextstate = "jump"
    end

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
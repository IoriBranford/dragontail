local Face       = require "Dragontail.Character.Component.Face"
local Mana                 = require "Dragontail.Character.Component.Mana"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"
local Audio    = require "System.Audio"
local Behavior = require "Dragontail.Character.Behavior"
local Player   = require "Dragontail.Character.Player"

---@class PlayerFighting:Behavior
---@field character Player
local PlayerFighting = pooledclass(Behavior)

function PlayerFighting:start()
    local player = self.character
    player.facedestangle = player.faceangle
end

local ChargeAttacks = Player.ChargeAttacks
local GroundStates = Player.GroundStates
local GroundToAirStates = Player.GroundToAirStates

function PlayerFighting:fixedupdate()
    local player = self.character
    local inair = player.gravity == 0
    local nextstates = inair and GroundToAirStates or GroundStates

    local inx, iny = player:getJoystick()
    player:turnTowardsJoystick("Walk", "Stand")
    player:accelerateTowardsJoystick()

    local caughtprojectile = player:catchProjectileAtJoystick()
    if caughtprojectile then
        return nextstates.catchProjectile, caughtprojectile
    end

    if player.canfly then
        if player:isActionDownAndRecentlyPressed("fly") then
            return nextstates.toggleFlying
        end
    end

    if player:isActionDownAndRecentlyPressed("sprint") then
        Face.faceVector(player, inx, iny)
        return nextstates.run
    end

    local chargedattack = not player.attackbutton.down and player:getChargedAttack(ChargeAttacks)
    if chargedattack then
        Mana.releaseCharge(player)
        return nextstates[chargedattack], player.facedestangle
    end

    if player:isActionRecentlyPressed("attack") then
        local attackangle = player.facedestangle
        if player.weaponinhand then
            attackangle = player:getAngleToBestTarget(attackangle) or attackangle
        end
        player.faceangle = attackangle
        player.facedestangle = attackangle
        if player.weaponinhand then
            return nextstates.throwWeapon, player.facedestangle, 1, 1
        end
        return player:doComboAttack(player.facedestangle, nil, inx ~= 0 or iny ~= 0, inair)
    end

    local opponenttohold = HoldOpponent.findOpponentToHold(player, inx, iny)
    if opponenttohold then
        Audio.play(player.holdsound)
        return nextstates.hold, opponenttohold
    end
end

return PlayerFighting
local Face       = require "Dragontail.Character.Component.Face"
local Mana                 = require "Dragontail.Character.Component.Mana"
local HoldOpponent = require "Dragontail.Character.Action.HoldOpponent"
local Audio    = require "System.Audio"
local Behavior = require "Dragontail.Character.Behavior"

---@class PlayerFighting:Behavior
---@field character Player
local PlayerFighting = pooledclass(Behavior)

function PlayerFighting:start()
    local player = self.character
    player.facedestangle = player.faceangle
    player.joysticklog:clear()
end

local ChargeAttacks = {
    "FireballStorm", "SpitMultiFireball", "SpitFireball"
}

local GroundNextStates = {
    catchProjectile = "catchProjectile",
    toggleFlying = "flyStart",
    run = "run",
    hold = "hold",
    throwWeapon = "throwWeapon",
    ["FireballStorm"] = "FireballStorm",
    ["SpitMultiFireball"] = "SpitMultiFireball",
    ["SpitFireball"] = "SpitFireball",
}

local AirNextStates = {
    catchProjectile = "AirCatchProjectile",
    toggleFlying = "flyEnd",
    run = "AirRun",
    hold = "AirHold",
    throwWeapon = "AirThrowWeapon",
    ["FireballStorm"] = "AirFireballStorm",
    ["SpitMultiFireball"] = "AirSpitMultiFireball",
    ["SpitFireball"] = "AirSpitFireball",
}

function PlayerFighting:fixedupdate()
    local player = self.character
    local inair = player.gravity == 0
    local nextstates = inair and AirNextStates or GroundNextStates

    local inx, iny = player:getJoystick()
    player.joysticklog:put(inx, iny)
    player:turnTowardsJoystick("Walk", "Stand")
    player:accelerateTowardsJoystick()

    local caughtprojectile = player:catchProjectileAtJoystick()
    if caughtprojectile then
        return nextstates.catchProjectile, caughtprojectile
    end

    if player.flybutton.pressed then
        -- disable until ready
        return nextstates.toggleFlying
    end

    if player.sprintbutton.pressed then
        Face.faceVector(player, inx, iny)
        return nextstates.run
    end

    local chargedattack = not player.attackbutton.down and player:getChargedAttack(ChargeAttacks)
    if chargedattack then
        Mana.releaseCharge(player)
        return nextstates[chargedattack], player.facedestangle
    end

    if player.attackbutton.pressed then
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
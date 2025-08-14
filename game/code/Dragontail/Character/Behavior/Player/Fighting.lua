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
    "fireball-storm", "spit-multi-fireball", "spit-fireball"
}

function PlayerFighting:fixedupdate()
    local player = self.character
    local inx, iny = player:getJoystick()
    player.joysticklog:put(inx, iny)
    player:turnTowardsJoystick("Walk", "Stand")
    player:accelerateTowardsJoystick()

    local caughtprojectile = player:catchProjectileAtJoystick()
    if caughtprojectile then
        return "catchProjectile", caughtprojectile
    end

    if player.flybutton.pressed then
        -- disable until ready
        -- return "flyStart"
    end

    if player.sprintbutton.pressed then
        Face.faceVector(player, inx, iny)
        return "run"
    end

    -- player.runenergy = math.min(player.runenergymax, player.runenergy + 1)
    local chargedattack = not player.attackbutton.down and player:getChargedAttack(ChargeAttacks)
    if chargedattack then
        Mana.releaseCharge(player)
        return chargedattack, player.facedestangle
    end

    if player.attackbutton.pressed then
        local attackangle = player.facedestangle
        if player.weaponinhand then
            attackangle = player:getAngleToBestTarget(attackangle) or attackangle
        end
        player.faceangle = attackangle
        player.facedestangle = attackangle
        if player.weaponinhand then
            return "throwWeapon", player.facedestangle, 1, 1
        end
        return player:doComboAttack(player.facedestangle, nil, inx ~= 0 or iny ~= 0)
    end

    local opponenttohold = HoldOpponent.findOpponentToHold(player, inx, iny)
    if opponenttohold then
        Audio.play(player.holdsound)
        return "hold", opponenttohold
    end
end

function PlayerFighting:stop()
end

return PlayerFighting
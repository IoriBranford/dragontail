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

function PlayerFighting:fixedupdate()
    local player = self.character
    local inair = player.gravity == 0

    local inx, iny = player:getJoystick()

    local caughtprojectile = player:catchProjectileAtJoystick()
    if caughtprojectile then
        return "catchProjectile", caughtprojectile
    end

    if player:isActionDownAndRecentlyPressed("fly") then
        if inair then
            return "flyEnd"
        else
            if inx ~= 0 or iny ~= 0 then
                inx, iny = math.norm(inx, iny)
            end
            local speed = player.speed
            player.velx = inx * speed
            player.vely = iny * speed
            return "jump", true
        end
    end

    if player:isActionDownAndRecentlyPressed("sprint") then
        Face.faceVector(player, inx, iny)
        return "run", nil, true
    end

    local chargedattack = not player.attackbutton.down and player:getChargedAttack(ChargeAttacks)
    if chargedattack then
        Mana.releaseCharge(player)
        local attackangle = inx == 0 and iny == 0
            and player.faceangle or math.atan2(iny, inx)
        return chargedattack, attackangle
    end

    if player:isActionRecentlyPressed("attack") then
        local attackangle = inx == 0 and iny == 0
            and player.faceangle or math.atan2(iny, inx)
        if player.weaponinhand then
            attackangle = player:getAngleToBestTarget(attackangle) or attackangle
        end
        player.faceangle = attackangle
        player.facedestangle = attackangle
        if player.weaponinhand then
            return "throwWeapon", attackangle, 1, 1
        end
        return player:doComboAttack(attackangle, nil, inx ~= 0 or iny ~= 0, inair)
    end

    local opponenttohold = HoldOpponent.findOpponentToHold(player, inx, iny)
    if opponenttohold then
        Audio.play(player.holdsound)
        return "hold", opponenttohold
    end

    player:accelerateTowardsJoystick()
    player:turnTowardsJoystick("Walk", "Stand")
end

return PlayerFighting
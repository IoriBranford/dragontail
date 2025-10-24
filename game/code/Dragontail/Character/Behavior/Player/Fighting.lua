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

local ChargeAttackStates = Player.ChargeAttackStates

function PlayerFighting:fixedupdate()
    local player = self.character
    local inair = player.gravity == 0

    local inx, iny = player:getJoystick()

    local caughtprojectile = player:catchProjectileAtJoystick()
    if caughtprojectile then
        return "catchProjectile", caughtprojectile
    end

    if player:consumeActionDownAndRecentlyPressed("sprint") then
        Face.faceVector(player, inx, iny)
        return "run", nil, true
    end

    local chargedattack, attackangle = player:getActivatedChargeAttackTowardsJoystick()
    if chargedattack then
        Mana.releaseCharge(self)
        return chargedattack, attackangle
    end

    if player:consumeActionRecentlyPressed("attack") then
        local attackangle = inx == 0 and iny == 0
            and player.facedestangle or math.atan2(iny, inx)
        if player.weaponinhand then
            local targets = player:updateEnemyTargetingScores(attackangle)
            local target = targets and targets[1]
            if target then
                local totargetx = target.x - player.x
                local totargety = target.y - player.y
                if totargetx ~= 0 or totargety ~= 0 then
                    attackangle = math.atan2(totargety, totargetx)
                end
            end
        end
        player.faceangle = attackangle
        player.facedestangle = attackangle
        if player.weaponinhand then
            return "throwWeapon", attackangle, 1
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

    if player:consumeActionDownAndRecentlyPressed("fly") then
        if inair then
            return "flyEnd"
        end
        return "jump", true
    end
end

return PlayerFighting
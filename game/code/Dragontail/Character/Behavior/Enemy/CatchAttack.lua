local Behavior = require "Dragontail.Character.Behavior"
local StateMachine       = require "Dragontail.Character.Component.StateMachine"
local HoldOpponent       = require "Dragontail.Character.Action.HoldOpponent"
local Guard              = require "Dragontail.Character.Action.Guard"

local CatchAttack = pooledclass(Behavior)
CatchAttack._nrec = Behavior._nrec + 1

function CatchAttack:start(hit)
    local enemy = self.character
    local attacker = hit.attacker
    self.attacker = attacker

    if attacker.team == "players" then
        HoldOpponent.startHolding(enemy, attacker)
        enemy.holdangle = enemy.guardangle
    elseif attacker.team == "enemies" then
        if attacker.heldby then
            HoldOpponent.stopHolding(attacker.heldby, attacker)
        end
        HoldOpponent.startHolding(enemy, attacker)
        enemy.holdangle = enemy.guardangle
    elseif attacker.team == "projectiles" then
        attacker:stopAttack()
        if enemy:tryToGiveWeapon(attacker.type) then
            attacker:disappear()
        else
            StateMachine.start(attacker, "projectileBounce", enemy)
        end
    end
    Guard.stopGuarding(enemy)
end


function CatchAttack:fixedupdate()
    local enemy = self.character
    enemy:decelerateXYto0()
    HoldOpponent.updateVelocities(enemy)
end

function CatchAttack:timeout()
    local enemy = self.character
    local attacker = self.attacker

    if enemy.weaponinhand then
        return "throwBackProjectile"
    end

    if attacker.team == "players" then
        return "hold", attacker
    elseif attacker.team == "enemies"
    and HoldOpponent.isHolding(enemy, attacker) then
        local angle = enemy.holdangle
        HoldOpponent.stopHolding(enemy, attacker)
        StateMachine.start(attacker, "thrown", enemy, angle)
        return "shield-bash2"
    else
        return enemy.recoverai or "stand"
    end
end

return CatchAttack
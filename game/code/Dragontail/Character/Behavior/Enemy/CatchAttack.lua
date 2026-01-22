local Behavior = require "Dragontail.Character.Behavior"
local StateMachine       = require "Dragontail.Character.Component.StateMachine"
local HoldOpponent       = require "Dragontail.Character.Component.HoldOpponent"
local Guard              = require "Dragontail.Character.Component.Guard"
local Face               = require "Dragontail.Character.Component.Face"
local DirectionalAnimation = require "Dragontail.Character.Component.DirectionalAnimation"

local CatchAttack = pooledclass(Behavior)
CatchAttack._nrec = Behavior._nrec + 2

---@param hit AttackHit
function CatchAttack:start(hit)
    local enemy = self.character
    local attacker = hit.attacker

    Face.faceObject(enemy, attacker,
        enemy.state.animation, enemy.animationframe, enemy.state.loopframe)

    if attacker.team == "players"
    or attacker.team == "enemies"
    or attacker.team == "container" then
        if not HoldOpponent.isHolding(enemy, attacker) then
            attacker.thrower = nil
            HoldOpponent.startHolding(enemy, attacker)
        end
    elseif attacker.team == "projectiles" then
        attacker:stopAttack() ; attacker:unassignSelfAsAttacker()
        if enemy:tryToGiveWeapon(attacker.type) then
            attacker:disappear()
        else
            StateMachine.start(attacker, "projectileBounce", enemy)
        end
    end
    Guard.stopGuarding(enemy)

    self.attacker = not attacker.disappeared and attacker
    self.attackerteam = attacker.team
end


function CatchAttack:fixedupdate()
    local enemy = self.character
    local attacker = self.attacker

    local opponent = enemy.opponents[1]
    local tooppox, tooppoy = opponent.x - enemy.x, opponent.y - enemy.y
    if tooppox ~= 0 or tooppoy ~= 0 then
        local targetangle = math.atan2(tooppoy, tooppox)
        targetangle = DirectionalAnimation.SnapAngle(targetangle, enemy.numdirections or 4)

        local faceangle = Face.turnTowardsAngle(enemy, targetangle, nil,
            enemy.state.animation, enemy.animationframe, enemy.state.loopframe)
        if enemy.holdangle then
            enemy.holdangle = faceangle
        end
    end

    enemy:decelerateXYto0()
    HoldOpponent.updateVelocities(enemy)

    local attackerteam = self.attackerteam
    if attackerteam == "enemies"
    or attackerteam == "container" then
        if not HoldOpponent.isHolding(enemy, attacker) then
            return "brokenaway", attacker
        end
        enemy:updateFlash(enemy.statetime)
        if attacker then
            attacker:updateFlash(enemy.statetime)
        end
    elseif attackerteam == "projectiles" then
        enemy:updateFlash(enemy.statetime)
    end
end

function CatchAttack:interrupt(...)
    local enemy = self.character
    local attacker = self.attacker
    enemy:resetFlash()
    if attacker
    and HoldOpponent.isHolding(enemy, attacker) then
        attacker:resetFlash()
        HoldOpponent.stopHolding(enemy, attacker)
    end
    return ...
end

function CatchAttack:timeout()
    local enemy = self.character
    local attacker = self.attacker

    enemy:resetFlash()

    if enemy.weaponinhand then
        return "throwBackProjectile"
    end

    if attacker
    and (attacker.team == "players"
        or attacker.team == "enemies"
        or attacker.team == "container")
    and HoldOpponent.isHolding(enemy, attacker)
    then
        attacker:resetFlash()
        if attacker:isHigherRankedTeammateOf(enemy) then
            enemy.holdstrength = 0
        end
        return "hold", attacker
    else
        return enemy.recoverai or "stand"
    end
end

return CatchAttack